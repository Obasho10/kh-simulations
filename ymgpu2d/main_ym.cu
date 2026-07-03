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
    // --- Resolution/timestep convergence-study overrides (all optional, backward compatible) ---
    // nz_override: grid points in z (-1 = default 256). Must be a power of 2 if suppress_kz0
    // is used, and a multiple of 32 if the kz-bandpass filters are used (see validation below).
    int nz_override         = (argc > 14) ? std::atoi(argv[14]) : -1;
    // nx_override: grid points in x (-1 = default 3*NZ, preserving the usual aspect ratio).
    int nx_override         = (argc > 15) ? std::atoi(argv[15]) : -1;
    // courant_override: DT = courant * DX (-1 = default 0.01).
    fct_real_t courant_override = (argc > 16) ? std::atof(argv[16]) : -1.0f;
    // target_tu: halt after this many time-units instead of the default fixed step count
    // (-1 = old behavior, total_steps=2000000). Also drives export/energy-check cadence in
    // physical time units so runs at different DT remain directly comparable.
    fct_real_t target_tu     = (argc > 17) ? std::atof(argv[17]) : -1.0f;
    // run_tag: appended to the output directory name (keeps resolution-study runs from
    // colliding with each other or with existing campaign directories at the same k/alpha).
    std::string run_tag      = (argc > 18) ? argv[18] : "";
    // seed_profile_file: path to raw float32 eigenfunction file produced by
    // "ym_eigenmode.py --export-seed".  Empty = use WKB Gaussian (default).
    // Only used in Mode 6 (NAB_CIRC_AZ2); ignored in all other modes.
    std::string seed_profile_file = (argc > 19) ? argv[19] : "";
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

    // Periodic box: Lx=6π, Lz=2π (physical domain is fixed regardless of resolution).
    // Default resolution NZ=64, NX=768 (dz/dx≈4, anisotropic — NOT NX=3*NZ), dt=0.1*dx.
    // Validated in RESOLUTION_FINDINGS.md ("Follow-up: how far can NZ/Courant be pushed
    // for speed?"): NZ=64/courant=0.8/NX=768 measured gamma(kz=1)=0.09558 vs the
    // NZ=256/courant=0.01 baseline's 0.09375 (R²=0.999, E_ratio_max=1.000000 for both) —
    // fully converged. courant=0.1 here (not the tested-safe ceiling of 0.8) leaves an
    // 8x safety margin for physics configs with a different alpha/V0 stability boundary.
    // NX intentionally does NOT default to 3*NZ any more: NX=192 (3*64) was never tested
    // and would put DX≈0.098 back in the underresolved regime (DX≲0.025 needed at
    // EPS=0.15, per the aspect-ratio results) — NX defaults to a fixed 768 instead,
    // independent of NZ. Override nz_override=256/nx_override=768(unchanged)/
    // courant_override=0.01 to reproduce the pre-2026-07-02 default grid exactly.
    const int NZ = (nz_override > 0) ? nz_override : 64;
    const int NX = (nx_override > 0) ? nx_override : 768;
    const fct_real_t LX = (fct_real_t)(6.0 * M_PI);
    const fct_real_t LZ = (fct_real_t)(2.0 * M_PI);
    const fct_real_t DX = LX / NX;
    const fct_real_t DZ = LZ / NZ;
    const fct_real_t COURANT = (courant_override > 0.0f) ? courant_override : 0.1f;
    const fct_real_t DT = COURANT * DX;
    const int NX_PAD_RT = NX + 2 * FCT_HALO;
    const fct_real_t V0 = V0_arg;

    // Validation: kz-domain kernels below require these constraints on NZ.
    if (suppress_kz0 && (NZ & (NZ - 1)) != 0) {
        std::cerr << "ERROR: suppress_kz0=1 requires NZ to be a power of 2 (got NZ="
                  << NZ << ") — kernel_ym_subtract_zmean uses a binary-tree reduction.\n";
        return 1;
    }
    if ((kz_suppress_max >= 1 || kz_suppress_hi > 0) && (NZ % 32 != 0)) {
        std::cerr << "ERROR: kz_suppress_max/kz_suppress_hi require NZ to be a multiple of 32 "
                  << "(got NZ=" << NZ << ") — kz-range kernels use warp-shuffle reduction.\n";
        return 1;
    }

    std::cout << " NX=" << NX << "  NZ=" << NZ << "  DX=" << DX << "  DZ=" << DZ
              << "  courant=" << COURANT << "  DT=" << DT
              << "  target_tu=" << target_tu << "  run_tag=" << run_tag << "\n"
              << "================================================================\n";
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
                                             h_seed);
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

        std::thread t([=]() {
            std::ostringstream fn;
            fn << out_dir << "/ym_" << std::setfill('0') << std::setw(6) << step << ".csv";
            std::ofstream out(fn.str());
            out << "X,Z,By1,By2,By3,Az2,Az3,PzA,PxA,Q1A,PzB,PxB,Q1B,"
                   "Ex1,Ex2,Ex3,Ez1,Ez2,Ez3,nA,nB,Q2A,Q3A,Q2B,Q3B\n";
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
                        << h_Q2B[i] << ',' << h_Q3B[i] << '\n';
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
    for (auto p : d_seed_ptrs) cudaFree(p);
    for (auto p : { d_sQ1A, d_sQ2A, d_sQ3A, d_sQ1A_t, d_sQ2A_t, d_sQ3A_t,
                    d_sQ1B, d_sQ2B, d_sQ3B, d_sQ1B_t, d_sQ2B_t, d_sQ3B_t })
        cudaFree(p);
    cudaDeviceReset();
    return 0;
}
