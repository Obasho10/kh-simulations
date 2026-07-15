#include "YM_Init.cuh"

// Two-beam counterstreaming init, zero gauge fields.
// Fluid A: +z shear,  Q^a = (+1, 0, 0)
// Fluid B: -z shear,  Q^a = (-1, 0, 0)   (anti-aligned → nonzero color current)
// All E, B, A = 0 initially. Fields build self-consistently from currents.
// Perturbation: small By kick (∝ sech × trig(k_z z)) seeds the KH mode.
//
// Mode 3 geometry (double-tanh):
//   Two shear layers at x = NX/4 and x = 3NX/4.
//   ξ₁ = (x - NX/4) / EPS,  ξ₂ = (x - 3NX/4) / EPS
//   vz profile: V0*(tanh(ξ₁) - tanh(ξ₂) - 1)
//   Az1 (no-EPS):  -V0*(log cosh(ξ₁) - log cosh(ξ₂))
//   By1 (gauge):   -∂_x Az1 = V0*(tanh(ξ₁) - tanh(ξ₂)) / EPS
__global__ void kernel_ym_init(YMFieldPtrs f,
                                YMFluidPtrs flA, YMFluidPtrs flB,
                                int nx, int nz,
                                fct_real_t dx, fct_real_t dz,
                                int k_mode, fct_real_t perturb_amp,
                                fct_real_t V0, fct_real_t epsilon,
                                int run_mode, fct_real_t alpha_YM,
                                int init_by1_eq, fct_real_t vz_edge_taper,
                                YMSeedProfiles seed) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);

    fct_real_t k_z   = k_mode * 2.0f * (fct_real_t)M_PI / (nz * dz);
    fct_real_t x_c   = (nx * dx) * 0.5f;
    fct_real_t xi    = (x * dx - x_c) / epsilon;
    fct_real_t z_val = z * dz;

    fct_real_t sech_xi = 1.0f / coshf(xi);

    // Single-tanh seed window: |ξ| < 3
    const fct_real_t xi_seed_cutoff = 3.0f;
    fct_real_t seed_win  = (fabsf(xi) < xi_seed_cutoff) ? 1.0f : 0.0f;
    fct_real_t base_seed = perturb_amp * V0 * sech_xi * seed_win;

    // Single-tanh no-EPS Az1 equilibrium
    fct_real_t az1_eq = -V0 * logf(coshf(xi));

    // ── Defaults ──
    fct_real_t by1_init = 0.0f, by2_init = 0.0f, by3_init = 0.0f;
    fct_real_t az1_init = 0.0f, az2_init = 0.0f, az3_init = 0.0f;
    fct_real_t vz_A = +V0 * tanhf(xi);   // single-tanh shear (overridden in mode 3)
    fct_real_t qA_amp = 0.0f, qB_amp = 0.0f;  // color-2 charge seeds (Mode 6 only)

    if (run_mode == 0) {
        // NAB_LINEAR: linearly polarized By2 seed
        by2_init = base_seed * sinf(k_z * z_val);
        az1_init = az1_eq;

    } else if (run_mode == 1) {
        // NAB_CIRC: (+)-helicity By2/By3 seed, log-cosh Az1.
        by2_init = base_seed * cosf(k_z * z_val);
        by3_init = base_seed * sinf(k_z * z_val);
        az1_init = az1_eq;

    } else if (run_mode == 6) {
        // NAB_CIRC_AZ2: same as Mode 1 but seeds Az2/Az3 instead of By2/By3.
        // Seeds the WKB n=0 Gaussian eigenfunction directly into Az2 to bypass
        // the precession cascade build-up that masks KH growth at kz>=2.
        //
        // WKB harmonic-oscillator width: ξ_char = 1/sqrt(α·kz·V0) in ξ-units
        //   (ξ = (x-Lx/2)/EPS). Physical half-width = EPS·ξ_char.
        //   α=2,kz=1,V0=0.1: ξ_char=2.24, σ_phys=0.336
        //   α=2,kz=2,V0=0.1: ξ_char=1.58, σ_phys=0.237
        //
        // By2/By3 left at zero — they grow naturally from Az2 via the KH chain
        // (Az2 → Q3 → Q2 → Lorentz → By2) once the eigenmode is excited.
        az1_init = az1_eq;
        fct_real_t az_amp = 0.0f;
        if (seed.az) {
            // Full eigenfunction seed: all x-profiles from ym_eigenmode.py --export-seed,
            // normalized to max|Az|=1.  Seeding By, Az, and Q simultaneously projects
            // cleanly onto the target eigenmode and suppresses competing stray modes.
            az_amp  = perturb_amp * V0 * seed.az[x];
            if (seed.by) by2_init = perturb_amp * V0 * seed.by[x] * cosf(k_z * z_val);
            if (seed.by) by3_init = perturb_amp * V0 * seed.by[x] * sinf(k_z * z_val);
            if (seed.qA) qA_amp   = perturb_amp * V0 * seed.qA[x];
            if (seed.qB) qB_amp   = perturb_amp * V0 * seed.qB[x];
        } else {
            fct_real_t xi_char = 1.0f / sqrtf(alpha_YM * k_z * V0 + 1e-12f);
            az_amp = perturb_amp * V0 * expf(-0.5f * xi * xi / (xi_char * xi_char));
        }
        az2_init = az_amp * cosf(k_z * z_val);
        az3_init = az_amp * sinf(k_z * z_val);

        // Current-consistent color-1 equilibrium (opt-in, needed for
        // suppress_kz0=0): ∂x By1 = Jz1 = -2 V0 tanh(ξ) ⇒
        // By1 = -2 V0 EPS (log cosh ξ - <log cosh>), zero-mean so no uniform
        // v×B force. <log cosh> over the periodic box ≈ Lx/(4 EPS) - ln 2.
        if (init_by1_eq) {
            fct_real_t mean_lc = (nx * dx) / (4.0f * epsilon) - 0.693147f;
            by1_init = -2.0f * V0 * epsilon * (logf(coshf(xi)) - mean_lc);
        }

    } else if (run_mode == 2) {
        // EMHD_KH: color-1 Kelvin-Helmholtz; no Az1 coupling
        by1_init = base_seed * sinf(k_z * z_val);
        az1_init = 0.0f;

    } else if (run_mode == 4) {
        // NAB_STEP (mode 4): two step-function shear layers on periodic domain.
        // Domain: Lx=6π, Lz=2π.  Interfaces at x=Lx/3 and x=2*Lx/3.
        // Velocity: +V0 for x<Lx/3 and x≥2Lx/3, −V0 for Lx/3≤x<2Lx/3.
        // Az1: cosine background with period Lx/3 (wells at both interfaces).
        // Seed: uniform By2=sin(k·z) — kz=k_mode exactly since Lz=2π.
        fct_real_t Lx = nx * dx;
        fct_real_t x_phys = x * dx;
        fct_real_t s = (x_phys < Lx * (1.0f / 3.0f) || x_phys >= Lx * (2.0f / 3.0f))
                        ? 1.0f : -1.0f;
        vz_A = V0 * s;

        // Az1 = -V0*cos(kx*x), kx = 3*2π/Lx = 1 for Lx=6π.
        // Wells (negative) at x=0,Lx/3,2Lx/3; peaks (positive) at Lx/6,Lx/2,5Lx/6.
        fct_real_t kx_az1 = 3.0f * 2.0f * (fct_real_t)M_PI / Lx;
        az1_init = -V0 * cosf(kx_az1 * x_phys);

        // Seed By2 uniformly in x; k_z = k_mode (integer) since Lz=2π, dz=2π/NZ.
        by2_init = perturb_amp * V0 * sinf(k_z * z_val);

    } else if (run_mode == 5) {
        // NAB_TANH_COSAZ (mode 5): single thin-tanh shear + bounded cosine Az1.
        //
        // Geometry: single shear interface at x = Lx/2.
        //   vz_A = +V0 * tanh((x - Lx/2) / EPS)   [thin when EPS << 1/kz]
        //
        // Az1 profile: cosine, bounded, period = Lx.
        //   Az1 = -V0 * cos(2π x / Lx)             [|Az1| <= V0 everywhere]
        //   Peak (+V0) at x = Lx/2 (interface) — maximum coupling where KH lives.
        //   Bounded coupling: α|Az1|_max = α V0 (never blows up).
        //
        // By1 gauge field: By1 = -∂Az1/∂x = -V0*(2π/Lx)*sin(2π x/Lx)  (small: ~0.033 V0)
        //
        // This design fixes both DTANH failures:
        //   1. Single layer (no double-well eigenfunction splitting).
        //   2. Cosine Az1 bounded (no log-cosh outer-region blowup at small EPS).
        //   3. Tanh velocity (zero at interface → no two-stream instability unlike NAB_STEP).
        //
        fct_real_t Lx    = nx * dx;
        fct_real_t x_ph  = x * dx;
        fct_real_t xi5   = (x_ph - 0.5f * Lx) / epsilon;
        vz_A             = V0 * tanhf(xi5);

        fct_real_t kx_cos = 2.0f * (fct_real_t)M_PI / Lx;
        az1_init = -V0 * cosf(kx_cos * x_ph);
        by1_init = -V0 * kx_cos * sinf(kx_cos * x_ph);  // gauge-consistent ∂Az1/∂x

        // Circularly-polarized seed localised at the shear layer
        fct_real_t sech5 = 1.0f / coshf(xi5);
        fct_real_t bs5   = perturb_amp * V0 * sech5;
        by2_init = bs5 * cosf(k_z * z_val);
        by3_init = bs5 * sinf(k_z * z_val);

    } else {
        // NAB_DTANH (mode 3): double-tanh periodic domain.
        // Two shear layers at x = L/4 and x = 3L/4.
        fct_real_t L    = nx * dx;
        fct_real_t xi1  = (x * dx - L * 0.25f) / epsilon;
        fct_real_t xi2  = (x * dx - L * 0.75f) / epsilon;
        fct_real_t shear = tanhf(xi1) - tanhf(xi2) - 1.0f;
        // shear ≈ -1 at edges (x=0,L), ≈ +1 between layers (x=L/2)

        vz_A = V0 * shear;   // beam A flows with this profile; beam B is -shear

        // No-EPS double-tanh Az1: same structure as single-tanh but symmetric around two layers
        az1_init = -V0 * (logf(coshf(xi1)) - logf(coshf(xi2)));

        // Gauge-consistent By1 = -∂_x Az1 = V0*(tanh(ξ₁) - tanh(ξ₂)) / EPS
        by1_init = V0 * (tanhf(xi1) - tanhf(xi2)) / epsilon;

        // Circularly-polarized (+)-helicity seed at both shear layers
        fct_real_t sech1 = 1.0f / coshf(xi1);
        fct_real_t sech2 = 1.0f / coshf(xi2);
        fct_real_t base_dt = perturb_amp * V0 * (sech1 + sech2);
        by2_init = base_dt * cosf(k_z * z_val);
        by3_init = base_dt * sinf(k_z * z_val);
    }

    // Optional smooth edge taper of vz (modes 1/6, 2026-07-15): removes the
    // periodic-wrap velocity discontinuity that drives the kz=0 color-1
    // collapse when suppress_kz0=0 (see OUTER_REGION.md). Width 3 ξ-units.
    // ∂x Az1 never enters the dynamics, so Az1 needs no matching taper.
    if (vz_edge_taper > 0.0f && (run_mode == 1 || run_mode == 6)) {
        const fct_real_t dt_tap = 3.0f;
        fct_real_t axi = fabsf(xi);
        fct_real_t w = 0.5f * (1.0f - tanhf((axi - vz_edge_taper) / dt_tap));
        vz_A *= w;
        if (init_by1_eq) {
            // By1_eq for the tapered current: ∂x By1 = Jz1 = -2 V0 tanh(ξ) w(ξ).
            // I(|ξ|) = ∫ tanh·w = log cosh|ξ| − (dt/2)(u + log cosh u + ln2),
            // u = (|ξ|−ξ_t)/dt  (exact in the tanh≈1 regime, ξ_t ≳ 10).
            // Evaluated at ξ + dx/2 so the code's BACKWARD difference
            // (By1[i]−By1[i−1])/dx lands on Jz1(ξ_i) to O(dx²) — the
            // cell-centered version leaves a first-order sech²(ξ)·dx residual
            // that the DC screening converts into a secular By1 pump at the
            // shear layer (observed: dBy1≈0.45 by t=12, 2026-07-15).
            fct_real_t axi_h = fabsf(xi + 0.5f * dx / epsilon);
            fct_real_t u  = (axi_h - vz_edge_taper) / dt_tap;
            fct_real_t I  = logf(coshf(axi_h))
                            - 0.5f * dt_tap * (u + logf(coshf(u)) + 0.693147f);
            fct_real_t Lxi = (nx * dx) * 0.5f / epsilon;
            fct_real_t mean_I = (0.5f * vz_edge_taper * vz_edge_taper
                                 - vz_edge_taper * 0.693147f
                                 + (Lxi - vz_edge_taper) * (vz_edge_taper - 0.693147f))
                                / Lxi;
            by1_init = -2.0f * V0 * epsilon * (I - mean_I);
        }
    }

    f.By1[idx] = by1_init;
    f.By2[idx] = by2_init;
    f.By3[idx] = by3_init;
    f.Az1[idx] = az1_init;
    f.Az2[idx] = az2_init;
    f.Az3[idx] = az3_init;
    f.Ex1[idx] = f.Ex2[idx] = f.Ex3[idx] = 0.0f;
    f.Ez1[idx] = f.Ez2[idx] = f.Ez3[idx] = 0.0f;
    f.Jx1[idx] = f.Jx2[idx] = f.Jx3[idx] = 0.0f;
    f.Jz1[idx] = f.Jz2[idx] = f.Jz3[idx] = 0.0f;

    // ── Fluid A ──
    flA.n[idx]  = 1.0f;
    flA.px[idx] = 0.0f;
    flA.pz[idx] = vz_A;
    flA.Q1[idx] = +1.0f;
    flA.Q2[idx] = qA_amp * cosf(k_z * z_val);
    flA.Q3[idx] = qA_amp * sinf(k_z * z_val);

    // ── Fluid B: anti-aligned ──
    flB.n[idx]  = 1.0f;
    flB.px[idx] = 0.0f;
    flB.pz[idx] = -vz_A;
    flB.Q1[idx] = -1.0f;
    flB.Q2[idx] = qB_amp * cosf(k_z * z_val);
    flB.Q3[idx] = qB_amp * sinf(k_z * z_val);
}
