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
                                int run_mode) {
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
    fct_real_t az1_init = 0.0f;
    fct_real_t vz_A = +V0 * tanhf(xi);   // single-tanh shear (overridden in mode 3)

    if (run_mode == 0) {
        // NAB_LINEAR: linearly polarized By2 seed
        by2_init = base_seed * sinf(k_z * z_val);
        az1_init = az1_eq;

    } else if (run_mode == 1) {
        // NAB_CIRC: (+)-helicity seed.
        // rfft[cos][k]=NZ/2 (real), rfft[sin][k]=-i*NZ/2 → F2+iF3 = NZ (nonzero)
        by2_init = base_seed * cosf(k_z * z_val);
        by3_init = base_seed * sinf(k_z * z_val);
        az1_init = az1_eq;

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

    f.By1[idx] = by1_init;
    f.By2[idx] = by2_init;
    f.By3[idx] = by3_init;
    f.Az1[idx] = az1_init;
    f.Az2[idx] = f.Az3[idx] = 0.0f;
    f.Ex1[idx] = f.Ex2[idx] = f.Ex3[idx] = 0.0f;
    f.Ez1[idx] = f.Ez2[idx] = f.Ez3[idx] = 0.0f;
    f.Jx1[idx] = f.Jx2[idx] = f.Jx3[idx] = 0.0f;
    f.Jz1[idx] = f.Jz2[idx] = f.Jz3[idx] = 0.0f;

    // ── Fluid A ──
    flA.n[idx]  = 1.0f;
    flA.px[idx] = 0.0f;
    flA.pz[idx] = vz_A;
    flA.Q1[idx] = +1.0f;
    flA.Q2[idx] = 0.0f;
    flA.Q3[idx] = 0.0f;

    // ── Fluid B: anti-aligned ──
    flB.n[idx]  = 1.0f;
    flB.px[idx] = 0.0f;
    flB.pz[idx] = -vz_A;
    flB.Q1[idx] = -1.0f;
    flB.Q2[idx] = 0.0f;
    flB.Q3[idx] = 0.0f;
}
