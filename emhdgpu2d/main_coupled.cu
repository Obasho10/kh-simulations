#include "EMHD_Physics.cuh"
#include "FCT_Kernels.cuh"
#include <iostream>
#include <vector>
#include <iomanip>
#include <fstream>
#include <sstream>
#include <filesystem>
#include <cmath>
#include <thread>
#include <deque>

namespace fs = std::filesystem;

#define CUDA_CHECK(call) \
    do { cudaError_t err = call; if (err != cudaSuccess) { \
        std::cerr << "CUDA error: " << cudaGetErrorString(err) << "\n"; exit(1); } } while (0)

// =====================================================================
// 1. KERNELS (PHYSICS & BOUNDARIES)
// =====================================================================
__global__ void kernel_smooth_fields(GaugeFieldPtrs f, int nx, int nz) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);
    int xm = max(0, x - 1); int xp = min(nx - 1, x + 1);
    int zm = (z == 0) ? nz - 1 : z - 1; int zp = (z == nz - 1) ? 0 : z + 1;

    // Weights must sum to 1: 0.5 + 4*0.125 = 1.0
    f.By[idx] = 0.5 * f.By[idx] + 0.125 * (f.By[IDX(xp,z,nx)] + f.By[IDX(xm,z,nx)] +
                                            f.By[IDX(x,zp,nx)] + f.By[IDX(x,zm,nx)]);
    f.Ex[idx] = 0.5 * f.Ex[idx] + 0.125 * (f.Ex[IDX(xp,z,nx)] + f.Ex[IDX(xm,z,nx)] +
                                            f.Ex[IDX(x,zp,nx)] + f.Ex[IDX(x,zm,nx)]);
}

__global__ void update_velocities(FluidDevicePtrs f, int nx, int nz) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);
    
    fct_real_t safe_n = max(f.n[idx], 0.05); 
    f.ux[idx] = f.px[idx] / safe_n;
    f.uy[idx] = f.pz[idx] / safe_n;
}

__global__ void enforce_boundaries(GaugeFieldPtrs f, FluidDevicePtrs fluid, int nx, int nz) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);

    // CRITICAL: Global FCT safety net. Never let density hit vacuum.
    if (fluid.n[idx] < 0.05) fluid.n[idx] = 0.05;

    if (x == 0 || x == nx - 1) {
        fluid.px[idx] = 0.0; 
        f.Ey[idx] = 0.0;     
        f.Ez[idx] = 0.0;
        f.Bx[idx] = 0.0;
    }
}

__global__ void init_das_kaw_equilibrium(GaugeFieldPtrs f, FluidDevicePtrs fluid, int nx, int nz, fct_real_t dx, fct_real_t dz, int k_mode, fct_real_t perturb_amp = 0.05) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);

    fct_real_t V0 = 0.1;
    fct_real_t epsilon = 10.0 * dx;
    fct_real_t k_z = (k_mode * 2.0 * M_PI) / (nz * dz);
    fct_real_t x_center = (nx * dx) / 2.0;

    fct_real_t x_node = x * dx;
    fct_real_t x_norm = (x_node - x_center) / epsilon;
    fluid.n[idx] = 1.0;
    fluid.px[idx] = 0.0;
    fluid.py[idx] = 0.0;
    fluid.pz[idx] = V0 * tanh(x_norm);

    fct_real_t x_ex = (x + 0.5) * dx;
    fct_real_t x_norm_ex = (x_ex - x_center) / epsilon;
    fct_real_t B0y_ex = -V0 * epsilon * log(cosh(x_norm_ex));
    fct_real_t vz_ex = V0 * tanh(x_norm_ex);
    f.Ex[idx] = vz_ex * B0y_ex;

    fct_real_t x_by = (x + 0.5) * dx;
    fct_real_t z_by = (z + 0.5) * dz;
    fct_real_t x_norm_by = (x_by - x_center) / epsilon;
    fct_real_t B0y_face = -V0 * epsilon * log(cosh(x_norm_by));
    f.By[idx] = B0y_face + perturb_amp * V0 * (1.0 / cosh(x_norm_by)) * cos(k_z * z_by);
}

// =====================================================================
// 2. COUPLING KERNELS & HOST WRAPPERS (NO MORE GHOST FILES)
// =====================================================================
__global__ void kernel_compute_currents(GaugeFieldPtrs f, FluidDevicePtrs fluid, int nx, int nz) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);

    int xp = min(nx - 1, x + 1);
    int zp = (z == nz - 1) ? 0 : z + 1;
    f.Jx[idx] = -0.5 * (fluid.px[idx] + fluid.px[IDX(xp, z, nx)]);
    f.Jy[idx] = -fluid.py[idx];
    f.Jz[idx] = -0.5 * (fluid.pz[idx] + fluid.pz[IDX(x, zp, nx)]);
}

__global__ void kernel_compute_lorentz(FluidDevicePtrs src, GaugeFieldPtrs f, FluidDevicePtrs fluid, int nx, int nz) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);

    int xm = max(0, x - 1);
    int zm = (z == 0) ? nz - 1 : z - 1;

    fct_real_t Ex_node = 0.5 * (f.Ex[idx] + f.Ex[IDX(xm, z, nx)]);
    fct_real_t Ey_node = f.Ey[idx];
    fct_real_t Ez_node = 0.5 * (f.Ez[idx] + f.Ez[IDX(x, zm, nx)]);
    fct_real_t Bx_node = 0.5 * (f.Bx[idx] + f.Bx[IDX(x, zm, nx)]);
    fct_real_t Bz_node = 0.5 * (f.Bz[idx] + f.Bz[IDX(xm, z, nx)]);
    fct_real_t By_node = 0.25 * (f.By[idx] + f.By[IDX(xm, z, nx)] + f.By[IDX(x, zm, nx)] + f.By[IDX(xm, zm, nx)]);

    fct_real_t n_safe = max(fluid.n[idx], 0.05);
    fct_real_t vx = fluid.px[idx] / n_safe;
    fct_real_t vy = fluid.py[idx] / n_safe;
    fct_real_t vz = fluid.pz[idx] / n_safe;

    src.px[idx] = -1.0 * (Ex_node + (vy * Bz_node - vz * By_node));
    src.py[idx] = -1.0 * (Ey_node + (vz * Bx_node - vx * Bz_node));
    src.pz[idx] = -1.0 * (Ez_node + (vx * By_node - vy * Bx_node));
}

namespace Coupling {
    void compute_currents(GaugeFieldPtrs f, FluidDevicePtrs fluid, GaugeParams params, int nx, int nz) {
        dim3 threads(16, 16);
        dim3 blocks((nx + 15) / 16, (nz + 15) / 16);
        kernel_compute_currents<<<blocks, threads>>>(f, fluid, nx, nz);
    }
    void compute_lorentz_force(FluidDevicePtrs src, GaugeFieldPtrs f, FluidDevicePtrs fluid, int nx, int nz) {
        dim3 threads(16, 16);
        dim3 blocks((nx + 15) / 16, (nz + 15) / 16);
        kernel_compute_lorentz<<<blocks, threads>>>(src, f, fluid, nx, nz);
    }
}

// =====================================================================
// 3. MEMORY ALLOCATORS
// =====================================================================
void alloc_gauge_fields(GaugeFieldPtrs& f, size_t bytes) {
    CUDA_CHECK(cudaMalloc(&f.Ax, bytes)); CUDA_CHECK(cudaMemset(f.Ax, 0, bytes));
    CUDA_CHECK(cudaMalloc(&f.Ay, bytes)); CUDA_CHECK(cudaMemset(f.Ay, 0, bytes));
    CUDA_CHECK(cudaMalloc(&f.Az, bytes)); CUDA_CHECK(cudaMemset(f.Az, 0, bytes));
    CUDA_CHECK(cudaMalloc(&f.Ex, bytes)); CUDA_CHECK(cudaMemset(f.Ex, 0, bytes));
    CUDA_CHECK(cudaMalloc(&f.Ey, bytes)); CUDA_CHECK(cudaMemset(f.Ey, 0, bytes));
    CUDA_CHECK(cudaMalloc(&f.Ez, bytes)); CUDA_CHECK(cudaMemset(f.Ez, 0, bytes));
    CUDA_CHECK(cudaMalloc(&f.Bx, bytes)); CUDA_CHECK(cudaMemset(f.Bx, 0, bytes));
    CUDA_CHECK(cudaMalloc(&f.By, bytes)); CUDA_CHECK(cudaMemset(f.By, 0, bytes));
    CUDA_CHECK(cudaMalloc(&f.Bz, bytes)); CUDA_CHECK(cudaMemset(f.Bz, 0, bytes));
    CUDA_CHECK(cudaMalloc(&f.Jx, bytes)); CUDA_CHECK(cudaMemset(f.Jx, 0, bytes));
    CUDA_CHECK(cudaMalloc(&f.Jy, bytes)); CUDA_CHECK(cudaMemset(f.Jy, 0, bytes));
    CUDA_CHECK(cudaMalloc(&f.Jz, bytes)); CUDA_CHECK(cudaMemset(f.Jz, 0, bytes));
}

void alloc_fluid(FluidDevicePtrs& f, size_t bytes) {
    CUDA_CHECK(cudaMalloc(&f.n, bytes)); CUDA_CHECK(cudaMemset(f.n, 0, bytes));
    CUDA_CHECK(cudaMalloc(&f.ux, bytes)); CUDA_CHECK(cudaMemset(f.ux, 0, bytes));
    CUDA_CHECK(cudaMalloc(&f.uy, bytes)); CUDA_CHECK(cudaMemset(f.uy, 0, bytes));
    CUDA_CHECK(cudaMalloc(&f.px, bytes)); CUDA_CHECK(cudaMemset(f.px, 0, bytes));
    CUDA_CHECK(cudaMalloc(&f.py, bytes)); CUDA_CHECK(cudaMemset(f.py, 0, bytes));
    CUDA_CHECK(cudaMalloc(&f.pz, bytes)); CUDA_CHECK(cudaMemset(f.pz, 0, bytes));
    CUDA_CHECK(cudaMalloc(&f.E_therm, bytes)); CUDA_CHECK(cudaMemset(f.E_therm, 0, bytes));
}

void copy_fluid_states(FluidDevicePtrs& dst, FluidDevicePtrs& src, size_t bytes) {
    cudaMemcpy(dst.n, src.n, bytes, cudaMemcpyDeviceToDevice);
    cudaMemcpy(dst.ux, src.ux, bytes, cudaMemcpyDeviceToDevice);
    cudaMemcpy(dst.uy, src.uy, bytes, cudaMemcpyDeviceToDevice);
    cudaMemcpy(dst.px, src.px, bytes, cudaMemcpyDeviceToDevice);
    cudaMemcpy(dst.py, src.py, bytes, cudaMemcpyDeviceToDevice);
    cudaMemcpy(dst.pz, src.pz, bytes, cudaMemcpyDeviceToDevice);
}

namespace Gauge {
    void step_ampere_maxwell(GaugeFieldPtrs d_fields, GaugeParams params, int nx, int nz);
    void step_vector_potential(GaugeFieldPtrs d_fields, GaugeParams params, int nx, int nz);
    void step_faraday(GaugeFieldPtrs d_fields, GaugeParams params, int nx, int nz);
}

// =====================================================================
// 3b. ENERGY DIAGNOSTIC
// =====================================================================
__global__ void kernel_energy_density(GaugeFieldPtrs f, FluidDevicePtrs fluid,
                                       fct_real_t* d_out, int nx, int nz) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);

    fct_real_t n_safe = max(fluid.n[idx], 1e-10);
    fct_real_t ke = 0.5 * (fluid.px[idx]*fluid.px[idx] +
                            fluid.py[idx]*fluid.py[idx] +
                            fluid.pz[idx]*fluid.pz[idx]) / n_safe;
    fct_real_t em = 0.5 * (f.Ex[idx]*f.Ex[idx] + f.Ey[idx]*f.Ey[idx] + f.Ez[idx]*f.Ez[idx] +
                            f.Bx[idx]*f.Bx[idx] + f.By[idx]*f.By[idx] + f.Bz[idx]*f.Bz[idx]);
    d_out[idx] = ke + em;
}

double compute_total_energy(GaugeFieldPtrs d_fields, FluidDevicePtrs d_fluid,
                             fct_real_t* d_ebuf, std::vector<fct_real_t>& h_ebuf,
                             int nx, int nz, dim3 blocks, dim3 threads) {
    kernel_energy_density<<<blocks, threads>>>(d_fields, d_fluid, d_ebuf, nx, nz);
    cudaDeviceSynchronize();
    cudaMemcpy(h_ebuf.data(), d_ebuf, nx * nz * sizeof(fct_real_t), cudaMemcpyDeviceToHost);
    double total = 0.0;
    for (fct_real_t v : h_ebuf) total += static_cast<double>(v);
    return total;
}

// =====================================================================
// 4. MAIN LOOP
// =====================================================================
int main(int argc, char* argv[]) {
    int k_mode = (argc > 1) ? std::atoi(argv[1]) : 1;
    fct_real_t perturb_amp = (argc > 2) ? std::atof(argv[2]) : 0.05;

    std::cout << "===============================================================\n";
    std::cout << " GPU Coupled Solver: 2D EMHD Sausage Instability\n";
    std::cout << " k_mode = " << k_mode << "  perturb_amp = " << perturb_amp << "\n";
    std::cout << "===============================================================\n";

    GridParams grid = {256, 256, 1.0, 1.0};
    size_t num_cells = grid.nx * grid.ny;
    size_t bytes = num_cells * sizeof(fct_real_t);

    GaugeParams params;
    params.dx = grid.dx; params.dz = grid.dy;
    params.c = 1.0; params.mu_0 = 1.0; params.eps_0 = 1.0; params.g = 0.0;
    params.dt_step = 0.002;

    GaugeFieldPtrs d_fields; alloc_gauge_fields(d_fields, bytes);
    FluidDevicePtrs d_fluid, d_fluid_old, d_src;
    FluidDevicePtrs d_fluid_t, d_fluid_old_t, d_src_t;
    alloc_fluid(d_fluid, bytes); alloc_fluid(d_fluid_old, bytes); alloc_fluid(d_src, bytes);
    alloc_fluid(d_fluid_t, bytes); alloc_fluid(d_fluid_old_t, bytes); alloc_fluid(d_src_t, bytes);

    std::deque<std::thread> export_threads;
    std::vector<fct_real_t> h_By(num_cells), h_pz(num_cells);
    std::vector<fct_real_t> h_ebuf(num_cells);
    fct_real_t* d_ebuf;
    CUDA_CHECK(cudaMalloc(&d_ebuf, bytes));

    int total_steps  = 500000;  // t = 1000
    int export_stride = 1000;   // snapshot every Δt=2 → 500 snapshots per run
    int energy_stride = 500;    // energy check every Δt=1
    const double energy_threshold = 5.0;  // halt if E_total / E_initial > 5

    std::string out_dir = (perturb_amp == 0.0)
        ? "coupled_k" + std::to_string(k_mode) + "_noperturb"
        : "coupled_k" + std::to_string(k_mode);
    fs::create_directories(out_dir);
    // Wipe stale snapshots from any previous run to avoid mixed-stride contamination
    for (auto& entry : fs::directory_iterator(out_dir)) {
        auto name = entry.path().filename().string();
        if (name.rfind("coupled_", 0) == 0 && entry.path().extension() == ".csv")
            fs::remove(entry.path());
    }

    dim3 threads(16, 16);
    dim3 blocks((grid.nx + 15) / 16, (grid.ny + 15) / 16);

    init_das_kaw_equilibrium<<<blocks, threads>>>(d_fields, d_fluid, grid.nx, grid.ny, grid.dx, grid.dy, k_mode, perturb_amp);
    cudaDeviceSynchronize();
    
    kernel_smooth_fields<<<blocks, threads>>>(d_fields, grid.nx, grid.ny);
    cudaDeviceSynchronize();
    
    Coupling::compute_lorentz_force(d_src, d_fields, d_fluid, grid.nx, grid.ny);
    cudaDeviceSynchronize();

    std::cout << " Initialization complete. Starting unified loop...\n";

    auto export_state = [&](int step) {
        CUDA_CHECK(cudaMemcpy(h_By.data(), d_fields.By, bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_pz.data(), d_fluid.pz, bytes, cudaMemcpyDeviceToHost));
        std::thread export_thread([step, grid, out_dir, h_By, h_pz]() {
            std::ostringstream fn;
            fn << out_dir << "/coupled_" << std::setfill('0') << std::setw(5) << step << ".csv";
            std::ofstream out(fn.str());
            out << "X,Z,By,Pz\n";
            for (int z = 0; z < grid.ny; ++z) {
                for (int x = 0; x < grid.nx; ++x) {
                    int idx = x + z * grid.nx;
                    out << x * grid.dx << "," << z * grid.dy << ","
                        << h_By[idx] << "," << h_pz[idx] << "\n";
                }
            }
        });
        export_threads.push_back(std::move(export_thread));
        if (export_threads.size() > 4) {
            if (export_threads.front().joinable()) export_threads.front().join();
            export_threads.pop_front();
        }
    };

    // Measure and record initial energy
    double E_initial = compute_total_energy(d_fields, d_fluid, d_ebuf, h_ebuf,
                                            grid.nx, grid.ny, blocks, threads);
    std::ofstream energy_file(out_dir + "/energy.csv");
    energy_file << std::scientific << std::setprecision(8);
    energy_file << "step,time,E_total,E_ratio\n";
    energy_file << "0," << 0.0 << "," << E_initial << "," << 1.0 << "\n";
    std::cout << " Initial total energy: " << E_initial << "\n";

    export_state(0);

    bool halted = false;
    for (int step = 1; step <= total_steps; ++step) {

        update_velocities<<<blocks, threads>>>(d_fluid, grid.nx, grid.ny);

        copy_fluid_states(d_fluid_old, d_fluid, bytes);
        FCT::run_x_sweep(d_fluid_old, d_fluid, d_src, grid, params.dt_step);

        copy_fluid_states(d_fluid_old, d_fluid, bytes);
        FCT::run_y_sweep(d_fluid_old, d_fluid, d_src, d_fluid_old_t, d_fluid_t, d_src_t, grid, params.dt_step);

        enforce_boundaries<<<blocks, threads>>>(d_fields, d_fluid, grid.nx, grid.ny);

        Coupling::compute_currents(d_fields, d_fluid, params, grid.nx, grid.ny);

        Gauge::step_ampere_maxwell(d_fields, params, grid.nx, grid.ny);
        Gauge::step_vector_potential(d_fields, params, grid.nx, grid.ny);
        Gauge::step_faraday(d_fields, params, grid.nx, grid.ny);

        Coupling::compute_lorentz_force(d_src, d_fields, d_fluid, grid.nx, grid.ny);

        // ── Energy conservation check ─────────────────────────────────────
        if (step % energy_stride == 0) {
            double E = compute_total_energy(d_fields, d_fluid, d_ebuf, h_ebuf,
                                            grid.nx, grid.ny, blocks, threads);
            double ratio = E / E_initial;
            fct_real_t t_now = step * params.dt_step;
            energy_file << step << "," << t_now << "," << E << "," << ratio << "\n";
            energy_file.flush();

            std::cout << " Step: " << std::setw(6) << step
                      << " | t=" << std::fixed << std::setprecision(2) << t_now
                      << " | E/E0=" << std::setprecision(4) << ratio
                      << "        \r" << std::flush;

            if (std::isnan(E) || std::isinf(E)) {
                std::cout << "\n[HALT] NaN/Inf energy at t=" << t_now
                          << " — fluid description has broken down.\n";
                halted = true; break;
            }
            if (ratio > energy_threshold) {
                std::cout << "\n[HALT] E/E0=" << ratio
                          << " > " << energy_threshold
                          << " at t=" << t_now
                          << " — fluid assumption violated, stopping.\n";
                halted = true; break;
            }
        }

        if (step % export_stride == 0) export_state(step);
    }

    if (!halted) std::cout << "\n Run completed normally.\n";
    std::cout << "\nWaiting for background disk writes...\n";
    for (auto& t : export_threads) { if (t.joinable()) t.join(); }
    energy_file.close();
    cudaFree(d_ebuf);
    cudaDeviceReset();
    return 0;
}
