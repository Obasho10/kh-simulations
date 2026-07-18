#include "YM_Config.cuh"
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
#include <algorithm>
#include <string>

namespace fs = std::filesystem;

int main(int argc, char* argv[]) {
    if (argc < 2) {
        std::cerr << "Usage: ./ym_coupled <config.ini>\n"
                  << "  Config is a key=value file; see ymgpu2d/example.ini for all keys.\n";
        return 1;
    }
    const RunConfig cfg = load_config(argv[1]);

    // ── Unpack config into local names used by the rest of main ──────────────
    const int   k_mode            = cfg.k_mode;
    const fct_real_t aYM          = cfg.alpha_YM;
    const fct_real_t p_amp        = cfg.perturb_amp;
    const int   run_mode          = cfg.run_mode;
    const fct_real_t xi_sponge    = cfg.xi_sponge;
    const fct_real_t sigma_sponge = cfg.sigma_sponge;
    const fct_real_t xi_cut       = cfg.xi_cut;
    const fct_real_t warm_T       = cfg.warm_T;
    const int   freeze_override   = cfg.freeze_override;
    const int   suppress_kz0      = cfg.suppress_kz0;
    const fct_real_t hyp_diff     = cfg.hyp_diff;
    const int   kz_suppress_max   = cfg.kz_suppress_max;
    const int   kz_suppress_hi    = cfg.kz_suppress_hi;
    const fct_real_t target_tu    = cfg.target_tu;
    const std::string run_tag     = cfg.run_tag;
    const std::string seed_profile_file = cfg.seed_profile_file;

    const char* mode_tag = (run_mode == 1) ? "_circ"
                         : (run_mode == 2) ? "_emhd"
                         : (run_mode == 3) ? "_dtanh"
                         : (run_mode == 4) ? "_step"
                         : (run_mode == 5) ? "_tanh"
                         : (run_mode == 6) ? "_circ_az2seed" : "";

    const int   NZ      = (cfg.nz_override > 0)   ? cfg.nz_override   : 64;
    const int   NX      = (cfg.nx_override > 0)   ? cfg.nx_override   : 768;
    const fct_real_t LX = (cfg.lx_override > 0.f) ? cfg.lx_override   : (fct_real_t)(6.0 * M_PI);
    const fct_real_t LZ = (cfg.lz_override > 0.f) ? cfg.lz_override   : (fct_real_t)(2.0 * M_PI);
    const fct_real_t DX = LX / NX;
    const fct_real_t DZ = LZ / NZ;
    const fct_real_t COURANT = (cfg.courant_override > 0.f) ? cfg.courant_override : 0.1f;
    const fct_real_t DT = COURANT * DX;
    const int NX_PAD_RT = NX + 2 * FCT_HALO;
    const fct_real_t V0  = cfg.V0;
    const fct_real_t EPS = (cfg.eps_override > 0.f) ? cfg.eps_override : LX / (fct_real_t)6.0;

    GridParams grid{ NX, NZ, DX, DZ };
    size_t num_cells = (size_t)NX * NZ;
    size_t bytes     = num_cells * sizeof(fct_real_t);

    YMParams params;
    params.dx = DX; params.dz = DZ; params.dt_step = DT;
    params.c = 1.0; params.eps_0 = 1.0;
    params.alpha_YM = aYM;
    params.V0 = V0; params.epsilon = EPS;
    params.freeze_az1 = (run_mode == 1 || run_mode == 3 || run_mode == 4 ||
                         run_mode == 5 || run_mode == 6) ? 1 : 0;
    if (freeze_override >= 0) params.freeze_az1 = freeze_override;
    params.periodic_x    = (run_mode >= 1) ? 1 : 0;
    params.xi_sponge     = xi_sponge;
    params.sigma_sponge  = sigma_sponge;
    params.xi_cut        = xi_cut;
    params.warm_T        = warm_T;
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
        size_t pad_bytes = (size_t)NX_PAD_RT * NZ * sizeof(fct_real_t);
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
    // Electric field (all 3 colors) + fluid density/charge-2/3 — needed to check
    // Gauss's law (D_i E_i^a = rho^a/eps0) in post-processing; not evolved-state
    // otherwise, so must be exported explicitly.
    std::vector<fct_real_t> h_Ex1(num_cells), h_Ex2(num_cells), h_Ex3(num_cells);
    std::vector<fct_real_t> h_Ez1(num_cells), h_Ez2(num_cells), h_Ez3(num_cells);
    std::vector<fct_real_t> h_nA(num_cells), h_nB(num_cells);
    std::vector<fct_real_t> h_Q2A(num_cells), h_Q3A(num_cells);
    std::vector<fct_real_t> h_Q2B(num_cells), h_Q3B(num_cells);
    // Az1 appended last (2026-07-15): static under freeze_az1=1, but the
    // unfrozen background-depletion runs need its actual evolution — By1 is
    // not slaved to ∂x Az1 once color-1 evolves. Name-based readers are
    // unaffected by the extra trailing column.
    std::vector<fct_real_t> h_Az1(num_cells);

    // ── Output directory ──
    std::ostringstream dir_ss;
    dir_ss << "ym_k" << k_mode << "_a" << std::fixed << std::setprecision(3) << aYM;
    if (p_amp == 0.0) dir_ss << "_noperturb";
    dir_ss << mode_tag;
    if (V0 != 0.1) dir_ss << "_v" << std::setprecision(4) << V0;
    if (xi_sponge > 0.0)
        dir_ss << "_sp" << std::setprecision(1) << xi_sponge;
    if (xi_cut > 0.0)
        dir_ss << "_xc" << std::setprecision(1) << xi_cut;
    if (params.freeze_az1 && run_mode == 0)
        dir_ss << "_frz";  // only tag when freeze is non-default for this run_mode
    if (cfg.eps_override > 0.0f)
        dir_ss << "_eps" << std::fixed << std::setprecision(2) << cfg.eps_override;
    if (suppress_kz0)
        dir_ss << "_nkz0";
    if (kz_suppress_max >= 1)
        dir_ss << "_nkz1to" << kz_suppress_max;
    if (kz_suppress_hi > 0)
        dir_ss << "_bp" << kz_suppress_hi;
    if (hyp_diff > 0.0)
        dir_ss << "_hd" << std::scientific << std::setprecision(0) << hyp_diff;
    if (!run_tag.empty())
        dir_ss << "_" << run_tag;
    std::string out_dir = dir_ss.str();
    fs::create_directories(out_dir);
    for (auto& e : fs::directory_iterator(out_dir)) {
        auto nm = e.path().filename().string();
        if (nm.rfind("ym_", 0) == 0 && e.path().extension() == ".csv")
            fs::remove(e.path());
    }

    // ── Eigenfunction seed (Mode 6 only) ──
    // File format: [n_fields:int32][nx_file:int32][n_fields*nx_file float32 values]
    // Fields in order: by, ex, ez, az, qA, qB — all normalized to max|az|=1.
    // Produced by: python3 ym_eigenmode.py --export-seed
    YMSeedProfiles h_seed = {};
    std::vector<fct_real_t*> d_seed_ptrs;
    if (!seed_profile_file.empty()) {
        std::ifstream sf(seed_profile_file, std::ios::binary);
        if (!sf) {
            std::cerr << "ERROR: cannot open seed profile: " << seed_profile_file << "\n";
            return 1;
        }
        int32_t n_fields_file = 0, nx_file = 0;
        sf.read(reinterpret_cast<char*>(&n_fields_file), sizeof(int32_t));
        sf.read(reinterpret_cast<char*>(&nx_file), sizeof(int32_t));
        const fct_real_t** field_ptrs[6] = {
            &h_seed.by, &h_seed.ex, &h_seed.ez, &h_seed.az, &h_seed.qA, &h_seed.qB
        };
        int n_load = std::min((int)n_fields_file, 6);
        for (int f = 0; f < n_load; ++f) {
            std::vector<float> h_file(nx_file);
            sf.read(reinterpret_cast<char*>(h_file.data()), nx_file * sizeof(float));
            std::vector<fct_real_t> h_interp(NX);
            for (int i = 0; i < NX; ++i) {
                float t   = i * (float)(nx_file - 1) / (float)(NX - 1);
                int   j   = std::min((int)t, nx_file - 2);
                float frc = t - j;
                h_interp[i] = h_file[j] * (1.0f - frc) + h_file[j + 1] * frc;
            }
            fct_real_t* d_ptr = nullptr;
            CUDA_CHECK(cudaMalloc(&d_ptr, NX * sizeof(fct_real_t)));
            CUDA_CHECK(cudaMemcpy(d_ptr, h_interp.data(), NX * sizeof(fct_real_t),
                                  cudaMemcpyHostToDevice));
            *field_ptrs[f] = d_ptr;
            d_seed_ptrs.push_back(d_ptr);
        }
        std::cout << " Eigenfunction seed: " << seed_profile_file
                  << " (" << n_fields_file << " fields, " << nx_file
                  << "→" << NX << " points)\n";
    }

    // ── Initialize ──
    dim3 threads2d(16, 16);
    dim3 blocks2d((NX + 15) / 16, (NZ + 15) / 16);

    kernel_ym_init<<<blocks2d, threads2d>>>(d_fields, d_flA, d_flB,
                                             NX, NZ, DX, DZ, k_mode, p_amp, V0, EPS, run_mode, (float)aYM,
                                             cfg.init_by1_eq, cfg.vz_edge_taper, h_seed);
    cudaDeviceSynchronize();

    // Derive velocities and precompute initial sources
    kernel_update_velocities<<<blocks2d, threads2d>>>(d_flA, NX, NZ);
    kernel_update_velocities<<<blocks2d, threads2d>>>(d_flB, NX, NZ);
    kernel_ym_lorentz<<<blocks2d, threads2d>>>(d_srcA, d_fields, d_flA, NX, NZ, params.periodic_x,
                                                params.warm_T, params.dx, params.dz);
    kernel_ym_lorentz<<<blocks2d, threads2d>>>(d_srcB, d_fields, d_flB, NX, NZ, params.periodic_x,
                                                params.warm_T, params.dx, params.dz);
    kernel_ym_precession<<<blocks2d, threads2d>>>(d_sQ1A, d_sQ2A, d_sQ3A, d_fields, d_flA, aYM, NX, NZ);
    kernel_ym_precession<<<blocks2d, threads2d>>>(d_sQ1B, d_sQ2B, d_sQ3B, d_fields, d_flB, aYM, NX, NZ);
    cudaDeviceSynchronize();

    // Step mode: DT=0.01*DX≈2.45e-4, so 1 TU≈4082 steps.
    // 2M steps ≈ 490 TU; snapshot every 20k steps ≈ every 4.9 TU → 100 snapshots.
    // If target_tu is given, recompute all three from fixed *physical-time* cadences so
    // runs at different DT (different resolution/Courant number) stay directly comparable
    // (export every 1.0 TU, energy-check every 0.5 TU) instead of a fixed step count.
    const int total_steps   = (target_tu > 0.0f) ? (int)(target_tu / DT) : 2000000;
    const int export_stride = (target_tu > 0.0f) ? std::max(1, (int)(1.0 / DT)) : 20000;
    const int energy_stride = (target_tu > 0.0f) ? std::max(1, (int)(0.5 / DT)) : 10000;
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

        CUDA_CHECK(cudaMemcpy(h_Ex1.data(), d_fields.Ex1, bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_Ex2.data(), d_fields.Ex2, bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_Ex3.data(), d_fields.Ex3, bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_Ez1.data(), d_fields.Ez1, bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_Ez2.data(), d_fields.Ez2, bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_Ez3.data(), d_fields.Ez3, bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_nA.data(),  d_flA.n,      bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_nB.data(),  d_flB.n,      bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_Q2A.data(), d_flA.Q2,     bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_Q3A.data(), d_flA.Q3,     bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_Q2B.data(), d_flB.Q2,     bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_Q3B.data(), d_flB.Q3,     bytes, cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(h_Az1.data(), d_fields.Az1, bytes, cudaMemcpyDeviceToHost));

        std::thread t([=]() {
            std::ostringstream fn;
            fn << out_dir << "/ym_" << std::setfill('0') << std::setw(6) << step << ".csv";
            std::ofstream out(fn.str());
            out << "X,Z,By1,By2,By3,Az2,Az3,PzA,PxA,Q1A,PzB,PxB,Q1B,"
                   "Ex1,Ex2,Ex3,Ez1,Ez2,Ez3,nA,nB,Q2A,Q3A,Q2B,Q3B,Az1\n";
            for (int z = 0; z < NZ; ++z)
                for (int x = 0; x < NX; ++x) {
                    int i = x + z * NX;
                    out << x*DX << ',' << z*DZ << ','
                        << h_By1[i] << ',' << h_By2[i] << ',' << h_By3[i] << ','
                        << h_Az2[i] << ',' << h_Az3[i] << ','
                        << h_pzA[i] << ',' << h_pxA[i] << ',' << h_Q1A[i] << ','
                        << h_pzB[i] << ',' << h_pxB[i] << ',' << h_Q1B[i] << ','
                        << h_Ex1[i] << ',' << h_Ex2[i] << ',' << h_Ex3[i] << ','
                        << h_Ez1[i] << ',' << h_Ez2[i] << ',' << h_Ez3[i] << ','
                        << h_nA[i]  << ',' << h_nB[i]  << ','
                        << h_Q2A[i] << ',' << h_Q3A[i] << ','
                        << h_Q2B[i] << ',' << h_Q3B[i] << ','
                        << h_Az1[i] << '\n';
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
            ym_fct_x_sweep_periodic(d_flA_old, d_flA, d_srcA, d_sQ1A, d_sQ2A, d_sQ3A, grid, DT, NX_PAD_RT,
                                     d_pad_n, d_pad_ux, d_pad_var, d_pad_new, d_pad_src, d_pad_eth);
        else
            ym_fct_x_sweep(d_flA_old, d_flA, d_srcA, d_sQ1A, d_sQ2A, d_sQ3A, grid, DT);
        // fluid B
        copy_ym_fluid(d_flB_old, d_flB, bytes);
        if (params.periodic_x)
            ym_fct_x_sweep_periodic(d_flB_old, d_flB, d_srcB, d_sQ1B, d_sQ2B, d_sQ3B, grid, DT, NX_PAD_RT,
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

        // 6b2. xi_cut: hard-wall Dirichlet alternative/complement to the soft sponge —
        //      unconditionally zero color-2/3 fields for |ξ| > xi_cut. Retains more of
        //      the true growth rate than the sponge at matched radius (no damping bleed
        //      into the interior); see FINDINGS.md 2026-07-15.
        if (params.xi_cut > 0.0)
            kernel_ym_xicut<<<blocks2d, threads2d>>>(d_fields, d_flA, d_flB, NX, NZ, params);

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
        kernel_ym_lorentz<<<blocks2d, threads2d>>>(d_srcA, d_fields, d_flA, NX, NZ, params.periodic_x,
                                                    params.warm_T, params.dx, params.dz);
        kernel_ym_lorentz<<<blocks2d, threads2d>>>(d_srcB, d_fields, d_flB, NX, NZ, params.periodic_x,
                                                    params.warm_T, params.dx, params.dz);
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
    for (auto p : d_seed_ptrs) cudaFree(p);
    for (auto p : { d_sQ1A, d_sQ2A, d_sQ3A, d_sQ1A_t, d_sQ2A_t, d_sQ3A_t,
                    d_sQ1B, d_sQ2B, d_sQ3B, d_sQ1B_t, d_sQ2B_t, d_sQ3B_t })
        cudaFree(p);
    cudaDeviceReset();
    return 0;
}
