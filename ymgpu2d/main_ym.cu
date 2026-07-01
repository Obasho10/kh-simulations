#include "YM_Fluid.cuh"
#include "YM_Init.cuh"
#include "YM_Energy.cuh"
#include "YM_FCT.cuh"
#include <iomanip>
#include <fstream>
#include <sstream>
#include <filesystem>
#include <cmath>
#include <thread>
#include <deque>

namespace fs = std::filesystem;

int main(int argc, char* argv[]) {
    int k_mode        = (argc > 1) ? std::atoi(argv[1]) : 1;
    fct_real_t aYM    = (argc > 2) ? std::atof(argv[2]) : 0.1;
    fct_real_t p_amp  = (argc > 3) ? std::atof(argv[3]) : 0.05;
    // run_mode: 0=NAB_LINEAR, 1=NAB_CIRC, 2=EMHD_KH, 3=NAB_DTANH, 4=NAB_STEP
    int run_mode      = (argc > 4) ? std::atoi(argv[4]) : 3;
    // V0: shear velocity
    fct_real_t V0_arg = (argc > 5) ? std::atof(argv[5]) : 0.1;
    // xi_sponge: |ξ| at which absorbing sponge begins on color-2/3 fields (0=disabled)
    fct_real_t xi_sponge    = (argc > 6) ? std::atof(argv[6]) : 0.0;
    // sigma_sponge: damping rate in sponge (TU⁻¹ per unit ξ beyond xi_sponge)
    fct_real_t sigma_sponge = (argc > 7) ? std::atof(argv[7]) : 5.0;
    // freeze_az1 override: -1=use run_mode default, 0=off, 1=on
    int freeze_override     = (argc > 8) ? std::atoi(argv[8]) : -1;
    // suppress_kz0: subtract z-mean of color-2/3 fields each step (1=on, 0=off)
    int suppress_kz0        = (argc > 9) ? std::atoi(argv[9]) : 0;
    // hyp_diff_coeff: 4th-order z-hyperdiffusion coefficient — kills kz>=74 numerical instability
    // Use ~5e-5 to suppress kz≈110 while leaving kz=1..8 intact (<0.6% total attenuation)
    fct_real_t hyp_diff     = (argc > 10) ? std::atof(argv[10]) : 0.0;
    // kz_suppress_max: subtract DFT modes kz=1..N from color-2/3 fields each step (0=off)
    // Use k_mode-1 to suppress all modes below the target, isolating mid-kz growth.
    int kz_suppress_max     = (argc > 11) ? std::atoi(argv[11]) : 0;
    // kz_suppress_hi: also subtract DFT modes kz=k_mode+1..N (bandpass: kills two-stream at kz~10-14)
    // Use ~40 to cover the two-stream danger zone while leaving the target kz=k_mode alone.
    int kz_suppress_hi      = (argc > 13) ? std::atoi(argv[13]) : 0;
    // eps_override: shear half-width (physical units). -1 = use mode default (Lx/6=π).
    // Reduce below 0.64/kz to activate KH; mode 5 (NAB_TANH_COSAZ) is designed for thin EPS.
    fct_real_t eps_override = (argc > 12) ? std::atof(argv[12]) : -1.0f;
    const char* mode_names[] = {"NAB_LINEAR", "NAB_CIRC", "EMHD_KH", "NAB_DTANH", "NAB_STEP",
                                "NAB_TANH_COSAZ", "NAB_CIRC_AZ2"};
    const char* mode_tag     = (run_mode == 1) ? "_circ"
                             : (run_mode == 2) ? "_emhd"
                             : (run_mode == 3) ? "_dtanh"
                             : (run_mode == 4) ? "_step"
                             : (run_mode == 5) ? "_tanh"
                             : (run_mode == 6) ? "_circ_az2seed" : "";

    std::cout << "================================================================\n"
              << " GPU SU(2) Yang-Mills KH Solver (two-beam)\n"
              << " k_mode=" << k_mode << "  alpha_YM=" << aYM
              << "  perturb_amp=" << p_amp << "  V0=" << V0_arg
              << "  mode=" << mode_names[run_mode < 7 ? run_mode : 0] << "\n"
              << " xi_sponge=" << xi_sponge << "  sigma_sponge=" << sigma_sponge
              << "  freeze_az1_override=" << freeze_override
              << "  suppress_kz0=" << suppress_kz0
              << "  hyp_diff=" << hyp_diff
              << "  kz_suppress_max=" << kz_suppress_max
              << "  kz_suppress_hi=" << kz_suppress_hi
              << "  eps_override=" << eps_override << "\n"
              << "================================================================\n";

    // Periodic box: Lx=6π, Lz=2π, NX=3*NZ, dx=dz=2π/NZ, dt=0.01*dx
    const int NZ = 256;
    const int NX = 3 * NZ;
    const fct_real_t LX = (fct_real_t)(6.0 * M_PI);
    const fct_real_t LZ = (fct_real_t)(2.0 * M_PI);
    const fct_real_t DX = LX / NX;           // = 2π/NZ
    const fct_real_t DZ = LZ / NZ;           // = 2π/NZ
    const fct_real_t DT = 0.01 * DX;
    const fct_real_t V0 = V0_arg;
    const fct_real_t EPS = (eps_override > 0.0f) ? eps_override
                                                   : LX / (fct_real_t)6.0;  // default = π

    GridParams grid{ NX, NZ, DX, DZ };
    size_t num_cells = (size_t)NX * NZ;
    size_t bytes     = num_cells * sizeof(fct_real_t);

    YMParams params;
    params.dx = DX; params.dz = DZ; params.dt_step = DT;
    params.c = 1.0; params.eps_0 = 1.0;
    params.alpha_YM = aYM;
    params.V0 = V0; params.epsilon = EPS;
    // freeze Az1: static background for WKB theory (CIRC, DTANH, STEP, TANH_COSAZ)
    params.freeze_az1 = (run_mode == 1 || run_mode == 3 || run_mode == 4 || run_mode == 5 || run_mode == 6) ? 1 : 0;
    if (freeze_override >= 0) params.freeze_az1 = freeze_override;
    // periodic EM BC: all modes >=1 use periodic x (no walls)
    params.periodic_x = (run_mode >= 1) ? 1 : 0;
    params.xi_sponge    = xi_sponge;
    params.sigma_sponge = sigma_sponge;
    params.suppress_kz0    = suppress_kz0;
    params.hyp_diff_coeff  = hyp_diff;
    params.kz_suppress_max = kz_suppress_max;
    params.kz_suppress_hi  = kz_suppress_hi;

    // ── Allocate device memory ──
    YMFieldPtrs d_fields;
    alloc_ym_fields(d_fields, bytes);

    // Fluid A (beam +z) and B (beam -z), each with old/new/src/transposed copies
    YMFluidPtrs d_flA,    d_flA_old,  d_srcA,  d_flA_t,    d_flA_old_t,  d_srcA_t;
    YMFluidPtrs d_flB,    d_flB_old,  d_srcB,  d_flB_t,    d_flB_old_t,  d_srcB_t;
    for (auto* p : { &d_flA, &d_flA_old, &d_srcA, &d_flA_t, &d_flA_old_t, &d_srcA_t,
                     &d_flB, &d_flB_old, &d_srcB, &d_flB_t, &d_flB_old_t, &d_srcB_t })
        alloc_ym_fluid(*p, bytes);

    // Color precession source arrays (A and B, regular + transposed)
    fct_real_t *d_sQ1A, *d_sQ2A, *d_sQ3A, *d_sQ1A_t, *d_sQ2A_t, *d_sQ3A_t;
    fct_real_t *d_sQ1B, *d_sQ2B, *d_sQ3B, *d_sQ1B_t, *d_sQ2B_t, *d_sQ3B_t;
    for (auto* p : { &d_sQ1A, &d_sQ2A, &d_sQ3A, &d_sQ1A_t, &d_sQ2A_t, &d_sQ3A_t,
                     &d_sQ1B, &d_sQ2B, &d_sQ3B, &d_sQ1B_t, &d_sQ2B_t, &d_sQ3B_t }) {
        CUDA_CHECK(cudaMalloc(p, bytes)); CUDA_CHECK(cudaMemset(*p, 0, bytes));
    }

    // Padded scratch buffers for periodic FCT x-sweep (only used in run_mode>=1)
    fct_real_t *d_pad_n  = nullptr, *d_pad_ux  = nullptr;
    fct_real_t *d_pad_var = nullptr, *d_pad_new = nullptr;
    fct_real_t *d_pad_src = nullptr, *d_pad_eth = nullptr;
    if (params.periodic_x) {
        size_t pad_bytes = (size_t)NX_PAD * NZ * sizeof(fct_real_t);
        CUDA_CHECK(cudaMalloc(&d_pad_n,   pad_bytes));
        CUDA_CHECK(cudaMalloc(&d_pad_ux,  pad_bytes));
        CUDA_CHECK(cudaMalloc(&d_pad_var, pad_bytes));
        CUDA_CHECK(cudaMalloc(&d_pad_new, pad_bytes));
        CUDA_CHECK(cudaMalloc(&d_pad_src, pad_bytes));
        CUDA_CHECK(cudaMalloc(&d_pad_eth, pad_bytes));
        CUDA_CHECK(cudaMemset(d_pad_eth, 0, pad_bytes));
    }

    fct_real_t* d_ebuf;
    CUDA_CHECK(cudaMalloc(&d_ebuf, bytes));
    std::vector<fct_real_t> h_ebuf(num_cells);

    // Host snapshot buffers
    std::vector<fct_real_t> h_By1(num_cells), h_By2(num_cells), h_By3(num_cells);
    std::vector<fct_real_t> h_Az2(num_cells), h_Az3(num_cells);
    std::vector<fct_real_t> h_pzA(num_cells), h_pxA(num_cells), h_Q1A(num_cells);
    std::vector<fct_real_t> h_pzB(num_cells), h_pxB(num_cells), h_Q1B(num_cells);

    // ── Output directory ──
    std::ostringstream dir_ss;
    dir_ss << "ym_k" << k_mode << "_a" << std::fixed << std::setprecision(3) << aYM;
    if (p_amp == 0.0) dir_ss << "_noperturb";
    dir_ss << mode_tag;
    if (V0 != 0.1) dir_ss << "_v" << std::setprecision(4) << V0;
    if (xi_sponge > 0.0)
        dir_ss << "_sp" << std::setprecision(1) << xi_sponge;
    if (params.freeze_az1 && run_mode == 0)
        dir_ss << "_frz";  // only tag when freeze is non-default for this run_mode
    if (eps_override > 0.0f)
        dir_ss << "_eps" << std::fixed << std::setprecision(2) << eps_override;
    if (suppress_kz0)
        dir_ss << "_nkz0";
    if (kz_suppress_max >= 1)
        dir_ss << "_nkz1to" << kz_suppress_max;
    if (kz_suppress_hi > 0)
        dir_ss << "_bp" << kz_suppress_hi;
    if (hyp_diff > 0.0)
        dir_ss << "_hd" << std::scientific << std::setprecision(0) << hyp_diff;
    std::string out_dir = dir_ss.str();
    fs::create_directories(out_dir);
    for (auto& e : fs::directory_iterator(out_dir)) {
        auto nm = e.path().filename().string();
        if (nm.rfind("ym_", 0) == 0 && e.path().extension() == ".csv")
            fs::remove(e.path());
    }

    // ── Initialize ──
    dim3 threads2d(16, 16);
    dim3 blocks2d((NX + 15) / 16, (NZ + 15) / 16);

    kernel_ym_init<<<blocks2d, threads2d>>>(d_fields, d_flA, d_flB,
                                             NX, NZ, DX, DZ, k_mode, p_amp, V0, EPS, run_mode, (float)aYM);
    cudaDeviceSynchronize();

    // Derive velocities and precompute initial sources
    kernel_update_velocities<<<blocks2d, threads2d>>>(d_flA, NX, NZ);
    kernel_update_velocities<<<blocks2d, threads2d>>>(d_flB, NX, NZ);
    kernel_ym_lorentz<<<blocks2d, threads2d>>>(d_srcA, d_fields, d_flA, NX, NZ, params.periodic_x);
    kernel_ym_lorentz<<<blocks2d, threads2d>>>(d_srcB, d_fields, d_flB, NX, NZ, params.periodic_x);
    kernel_ym_precession<<<blocks2d, threads2d>>>(d_sQ1A, d_sQ2A, d_sQ3A, d_fields, d_flA, aYM, NX, NZ);
    kernel_ym_precession<<<blocks2d, threads2d>>>(d_sQ1B, d_sQ2B, d_sQ3B, d_fields, d_flB, aYM, NX, NZ);
    cudaDeviceSynchronize();

    // Step mode: DT=0.01*DX≈2.45e-4, so 1 TU≈4082 steps.
    // 2M steps ≈ 490 TU; snapshot every 20k steps ≈ every 4.9 TU → 100 snapshots.
    const int total_steps   = 2000000;
    const int export_stride = 20000;
    const int energy_stride = 10000;
    // Periodic domain has no outer blowup; energy grows only from the instability.
    // Use 100× for step/dtanh modes, 5× for wall-BC modes.
    const double energy_thresh = (run_mode >= 3 || xi_sponge > 0.0) ? 100.0 : 5.0;

    double E0 = compute_ym_energy(d_fields, d_flA, d_flB, d_ebuf, h_ebuf, NX, NZ, blocks2d, threads2d);
    std::ofstream efile(out_dir + "/energy.csv");
    efile << std::scientific << std::setprecision(8);
    efile << "step,time,E_total,E_ratio\n";
    efile << "0,0," << E0 << ",1.0\n";
    std::cout << " Initial energy: " << E0 << "\n";

    std::deque<std::thread> export_threads;

    auto export_state = [&](int step) {
        CUDA_CHECK(cudaMemcpy(h_By1.data(), d_fields.By1, bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_By2.data(), d_fields.By2, bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_By3.data(), d_fields.By3, bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_Az2.data(), d_fields.Az2, bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_Az3.data(), d_fields.Az3, bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_pzA.data(), d_flA.pz,    bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_pxA.data(), d_flA.px,    bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_Q1A.data(), d_flA.Q1,    bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_pzB.data(), d_flB.pz,    bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_pxB.data(), d_flB.px,    bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_Q1B.data(), d_flB.Q1,    bytes, cudaMemcpyDeviceToHost));

        std::thread t([=]() {
            std::ostringstream fn;
            fn << out_dir << "/ym_" << std::setfill('0') << std::setw(6) << step << ".csv";
            std::ofstream out(fn.str());
            out << "X,Z,By1,By2,By3,Az2,Az3,PzA,PxA,Q1A,PzB,PxB,Q1B\n";
            for (int z = 0; z < NZ; ++z)
                for (int x = 0; x < NX; ++x) {
                    int i = x + z * NX;
                    out << x*DX << ',' << z*DZ << ','
                        << h_By1[i] << ',' << h_By2[i] << ',' << h_By3[i] << ','
                        << h_Az2[i] << ',' << h_Az3[i] << ','
                        << h_pzA[i] << ',' << h_pxA[i] << ',' << h_Q1A[i] << ','
                        << h_pzB[i] << ',' << h_pxB[i] << ',' << h_Q1B[i] << '\n';
                }
        });
        export_threads.push_back(std::move(t));
        if (export_threads.size() > 4) {
            if (export_threads.front().joinable()) export_threads.front().join();
            export_threads.pop_front();
        }
    };

    export_state(0);

    // ================================================================
    // MAIN TIME LOOP
    // ================================================================
    bool halted = false;
    for (int step = 1; step <= total_steps && !halted; ++step) {

        // 1. Derive velocities
        kernel_update_velocities<<<blocks2d, threads2d>>>(d_flA, NX, NZ);
        kernel_update_velocities<<<blocks2d, threads2d>>>(d_flB, NX, NZ);

        // 2. FCT x-sweep — fluid A
        copy_ym_fluid(d_flA_old, d_flA, bytes);
        if (params.periodic_x)
            ym_fct_x_sweep_periodic(d_flA_old, d_flA, d_srcA, d_sQ1A, d_sQ2A, d_sQ3A, grid, DT,
                                     d_pad_n, d_pad_ux, d_pad_var, d_pad_new, d_pad_src, d_pad_eth);
        else
            ym_fct_x_sweep(d_flA_old, d_flA, d_srcA, d_sQ1A, d_sQ2A, d_sQ3A, grid, DT);
        // fluid B
        copy_ym_fluid(d_flB_old, d_flB, bytes);
        if (params.periodic_x)
            ym_fct_x_sweep_periodic(d_flB_old, d_flB, d_srcB, d_sQ1B, d_sQ2B, d_sQ3B, grid, DT,
                                     d_pad_n, d_pad_ux, d_pad_var, d_pad_new, d_pad_src, d_pad_eth);
        else
            ym_fct_x_sweep(d_flB_old, d_flB, d_srcB, d_sQ1B, d_sQ2B, d_sQ3B, grid, DT);

        // 3. FCT z-sweep — fluid A
        copy_ym_fluid(d_flA_old, d_flA, bytes);
        ym_fct_z_sweep(d_flA_old, d_flA, d_srcA, d_sQ1A, d_sQ2A, d_sQ3A,
                        d_flA_old_t, d_flA_t, d_srcA_t,
                        d_sQ1A_t, d_sQ2A_t, d_sQ3A_t, grid, DT);
        // fluid B
        copy_ym_fluid(d_flB_old, d_flB, bytes);
        ym_fct_z_sweep(d_flB_old, d_flB, d_srcB, d_sQ1B, d_sQ2B, d_sQ3B,
                        d_flB_old_t, d_flB_t, d_srcB_t,
                        d_sQ1B_t, d_sQ2B_t, d_sQ3B_t, grid, DT);

        // 4. Boundaries
        kernel_enforce_boundaries<<<blocks2d, threads2d>>>(d_fields, d_flA, d_flB, NX, NZ, params.periodic_x);

        // 5. Currents (sums both fluids)
        kernel_ym_currents<<<blocks2d, threads2d>>>(d_fields, d_flA, d_flB, NX, NZ, params);

        // 6. Non-Abelian Maxwell
        kernel_ym_ampere<<<blocks2d, threads2d>>>(d_fields, params, NX, NZ);
        kernel_ym_potential<<<blocks2d, threads2d>>>(d_fields, params, NX, NZ);
        kernel_ym_faraday<<<blocks2d, threads2d>>>(d_fields, params, NX, NZ);

        // 6b. Sponge: absorb color-2/3 EM fields in outer region |ξ| > xi_sponge
        //     This prevents the outer non-Abelian coupling from masking the inner WKB mode.
        if (params.xi_sponge > 0.0)
            kernel_ym_sponge<<<blocks2d, threads2d>>>(d_fields, d_flA, d_flB, NX, NZ, params);

        // 6c. kz=0 suppression: subtract z-mean of color-1 EM (By1,Ex1,Ez1) AND color-2/3
        //     fields each step.  Kills both the color-1 Weibel filamentation instability
        //     (By1[kz=0] growing → nonlinear explosion at t≈14.7 TU) and the color-2/3
        //     kz=0 Weibel.  Az1 is frozen so its mean is static and not zeroed.
        if (params.suppress_kz0) {
            size_t smem_sz = 15 * NZ * sizeof(fct_real_t);
            kernel_ym_subtract_zmean<<<NX, NZ, smem_sz>>>(d_fields, d_flA, d_flB, NX, NZ);
        }

        // 6c2. Bandpass filter: keep only kz=k_mode in color-1 EM (By1,Ex1,Ez1) + color-2/3.
        //   Low side:  suppress kz=1..kz_suppress_max (below target)
        //   High side: suppress kz=k_mode+1..kz_suppress_hi (kills EM instability at kz~7-14)
        //   Now includes color-1 EM fields — finite-kz EM instability in color-1 sector
        //   (γ≈0.08-0.1 TU⁻¹ at kz=7-14) triggers NaN at t≈17.2 TU if unfiltered.
        // Smem: (2*nwarps+2)*15*4 = (16+2)*15*4 = 1080 bytes for NZ=256
        {
            int nwarps_bp = NZ / 32;
            size_t smem_bp = (2 * nwarps_bp + 2) * 15 * sizeof(fct_real_t);
            if (params.kz_suppress_max >= 1)
                kernel_ym_subtract_kz_range<<<NX, NZ, smem_bp>>>(d_fields, d_flA, d_flB,
                                                                    NX, NZ, 1, params.kz_suppress_max);
            if (params.kz_suppress_hi > params.kz_suppress_max + 1)
                kernel_ym_subtract_kz_range<<<NX, NZ, smem_bp>>>(d_fields, d_flA, d_flB,
                                                                    NX, NZ, params.kz_suppress_max + 2,
                                                                    params.kz_suppress_hi);
        }

        // 6c3. Fluid n+pz+px bandpass: suppress nA,nB, pzA,pzB, pxA,pxB at same off-target kz.
        //   n, pz, px all filtered together so vz=pz/n and vx=px/n stay well-behaved.
        //   pxA/pxB added here to prevent x-momentum two-stream from seeding color-1 EM.
        // Smem: (2*nwarps+2)*2*4 = 144 bytes for NZ=256
        {
            int nwarps_pz = NZ / 32;
            size_t smem_pz = (2 * nwarps_pz + 2) * 2 * sizeof(fct_real_t);
            if (params.kz_suppress_max >= 1) {
                kernel_fluid_pz_subtract_kz_range<<<NX, NZ, smem_pz>>>(d_flA.pz, d_flB.pz,
                                                                          NX, NZ, 1, params.kz_suppress_max);
                kernel_fluid_pz_subtract_kz_range<<<NX, NZ, smem_pz>>>(d_flA.px, d_flB.px,
                                                                          NX, NZ, 1, params.kz_suppress_max);
                kernel_fluid_n_subtract_kz_range<<<NX, NZ, smem_pz>>>(d_flA.n, d_flB.n,
                                                                         NX, NZ, 1, params.kz_suppress_max);
            }
            if (params.kz_suppress_hi > params.kz_suppress_max + 1) {
                kernel_fluid_pz_subtract_kz_range<<<NX, NZ, smem_pz>>>(d_flA.pz, d_flB.pz,
                                                                          NX, NZ, params.kz_suppress_max + 2,
                                                                          params.kz_suppress_hi);
                kernel_fluid_pz_subtract_kz_range<<<NX, NZ, smem_pz>>>(d_flA.px, d_flB.px,
                                                                          NX, NZ, params.kz_suppress_max + 2,
                                                                          params.kz_suppress_hi);
                kernel_fluid_n_subtract_kz_range<<<NX, NZ, smem_pz>>>(d_flA.n, d_flB.n,
                                                                         NX, NZ, params.kz_suppress_max + 2,
                                                                         params.kz_suppress_hi);
            }
        }

        // 6d. z-hyperdiffusion: 4th-order dissipation kills near-Nyquist (kz≈110) numerical
        //     instability while leaving kz=1..8 KH modes intact (<0.6% total attenuation).
        if (params.hyp_diff_coeff > 0.0f)
            kernel_ym_hyperdiffuse_z<<<blocks2d, threads2d>>>(d_fields, d_flA, d_flB,
                                                               NX, NZ, params.hyp_diff_coeff);

        // 6e. Zero color-1 EM (By1, Ex1, Ez1) completely each step.
        //     Campaign 14 analysis: By1[kz=1] grows at γ≈1.1 TU⁻¹ — a color-1 EM instability
        //     at the target kz that the bandpass filter cannot suppress (it's at kz=k_mode).
        //     Zeroing all of By1/Ex1/Ez1 kills this instability while preserving the KH chain:
        //     By2→Ez2→Az2→Q3→Q2→Lorentz→By2 via frozen Az1×color-3 non-Abelian coupling.
        if (params.suppress_kz0) {
            CUDA_CHECK(cudaMemset(d_fields.By1, 0, bytes));
            CUDA_CHECK(cudaMemset(d_fields.Ex1, 0, bytes));
            CUDA_CHECK(cudaMemset(d_fields.Ez1, 0, bytes));
        }

        // 7. Update sources for next FCT step
        kernel_ym_lorentz<<<blocks2d, threads2d>>>(d_srcA, d_fields, d_flA, NX, NZ, params.periodic_x);
        kernel_ym_lorentz<<<blocks2d, threads2d>>>(d_srcB, d_fields, d_flB, NX, NZ, params.periodic_x);
        kernel_ym_precession<<<blocks2d, threads2d>>>(d_sQ1A, d_sQ2A, d_sQ3A, d_fields, d_flA, aYM, NX, NZ);
        kernel_ym_precession<<<blocks2d, threads2d>>>(d_sQ1B, d_sQ2B, d_sQ3B, d_fields, d_flB, aYM, NX, NZ);

        // 8. Energy check
        if (step % energy_stride == 0) {
            double E = compute_ym_energy(d_fields, d_flA, d_flB, d_ebuf, h_ebuf, NX, NZ, blocks2d, threads2d);
            double ratio = E / E0;
            fct_real_t t_now = step * DT;
            efile << step << ',' << t_now << ',' << E << ',' << ratio << '\n';
            efile.flush();
            std::cout << " Step " << std::setw(7) << step
                      << " | t=" << std::fixed << std::setprecision(1) << t_now
                      << " | E/E0=" << std::setprecision(4) << ratio << "     \r" << std::flush;
            if (std::isnan(E) || std::isinf(E)) {
                std::cout << "\n[HALT] NaN/Inf at t=" << t_now << "\n";
                halted = true;
            } else if (ratio > energy_thresh) {
                std::cout << "\n[HALT] E/E0=" << ratio << " > " << energy_thresh
                          << " at t=" << t_now << "\n";
                halted = true;
            }
        }

        // 9. Snapshot
        if (step % export_stride == 0) export_state(step);
    }

    if (!halted) std::cout << "\n Run completed normally.\n";
    std::cout << "\nWaiting for disk writes...\n";
    for (auto& t : export_threads) if (t.joinable()) t.join();
    efile.close();
    cudaFree(d_ebuf);
    for (auto p : { d_sQ1A, d_sQ2A, d_sQ3A, d_sQ1A_t, d_sQ2A_t, d_sQ3A_t,
                    d_sQ1B, d_sQ2B, d_sQ3B, d_sQ1B_t, d_sQ2B_t, d_sQ3B_t })
        cudaFree(p);
    cudaDeviceReset();
    return 0;
}
