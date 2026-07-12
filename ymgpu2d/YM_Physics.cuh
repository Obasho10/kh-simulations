#ifndef YM_PHYSICS_CUH
#define YM_PHYSICS_CUH

#include "FCT_DeviceMath.cuh"

// =====================================================================
// SU(2) YANG-MILLS DATA STRUCTURES
// =====================================================================

// Single-fluid component (used for both A and B beams)
struct YMFluidPtrs {
    fct_real_t *n;          // number density
    fct_real_t *ux;         // x-velocity (derived: px/n)
    fct_real_t *uy;         // z-velocity (derived: pz/n) — named uy for FCT z-sweep compat
    fct_real_t *px;         // x-momentum
    fct_real_t *pz;         // z-momentum
    fct_real_t *Q1, *Q2, *Q3;  // color charges (internal dof, advected)
    fct_real_t *E_therm;
};

// YM gauge fields: 3 colors of E, B, A, J (only y-component of B in 2D x-z plane)
struct YMFieldPtrs {
    fct_real_t *Ex1, *Ex2, *Ex3;   // electric field x-component
    fct_real_t *Ez1, *Ez2, *Ez3;   // electric field z-component
    fct_real_t *By1, *By2, *By3;   // magnetic field y-component
    fct_real_t *Az1, *Az2, *Az3;   // vector potential z-component (A_x=0 gauge)
    fct_real_t *Jx1, *Jx2, *Jx3;  // current x-component
    fct_real_t *Jz1, *Jz2, *Jz3;  // current z-component
};

struct YMParams {
    fct_real_t dx, dz, dt_step;
    fct_real_t c, eps_0;
    fct_real_t alpha_YM;
    fct_real_t V0, epsilon;
    int freeze_az1;          // skip Az1 update (static WKB background)
    int periodic_x;          // use periodic wrapping in x (instead of wall) for EM kernels
    fct_real_t xi_sponge;    // |ξ| at which sponge begins (0 = disabled)
    fct_real_t sigma_sponge; // sponge damping rate (TU⁻¹ per unit ξ beyond xi_sponge)
    fct_real_t warm_T;       // isothermal pressure closure: P=n*T, adds -T*grad(n)/n to momentum sources (0=cold)
    int suppress_kz0;        // subtract z-mean of By1/Ex1/Ez1 + color-2/3 fields to kill kz=0 Weibel/filamentation
    fct_real_t hyp_diff_coeff; // 4th-order z-hyperdiffusion coefficient (0=off); use ~5e-5 to kill kz>=74
    int kz_suppress_max;     // subtract DFT modes kz=1..N from color-2/3 fields each step (0=off)
    int kz_suppress_hi;      // also subtract DFT modes kz=kz_suppress_max+2..N to kill two-stream (0=off)
};

// =====================================================================
// KERNEL DECLARATIONS (implemented in YM_Physics.cu)
// =====================================================================

// Currents sum both A and B fluid contributions
__global__ void kernel_ym_currents(YMFieldPtrs f, YMFluidPtrs flA, YMFluidPtrs flB,
                                    int nx, int nz, YMParams p);

__global__ void kernel_ym_ampere(YMFieldPtrs f, YMParams p, int nx, int nz);

__global__ void kernel_ym_faraday(YMFieldPtrs f, YMParams p, int nx, int nz);

__global__ void kernel_ym_potential(YMFieldPtrs f, YMParams p, int nx, int nz);

// Sponge layer: exponential damping of color-2/3 fields outside |ξ| > xi_sponge.
// Absorbs outgoing EM waves so the outer non-Abelian coupling cannot dominate
// the inner WKB mode.  Does NOT touch color-1 (equilibrium sector).
__global__ void kernel_ym_sponge(YMFieldPtrs f, YMFluidPtrs flA, YMFluidPtrs flB,
                                  int nx, int nz, YMParams p);

// kz=0 suppression: subtract z-mean of By1/Ex1/Ez1 (color-1 EM) + all color-2/3 fields.
// Kills color-1 Weibel filamentation (By1[kz=0] → nonlinear explosion at t≈14.7 TU)
// AND color-2/3 kz=0 Weibel.  Az1 frozen — not touched.
// Launch: <<<NX, NZ, 15*NZ*sizeof(fct_real_t)>>>  (one block per x-column)
__global__ void kernel_ym_subtract_zmean(YMFieldPtrs f, YMFluidPtrs flA, YMFluidPtrs flB,
                                          int nx, int nz);

// 4th-order z-hyperdiffusion: kills near-Nyquist (kz≈110) numerical instability.
// Launch: standard blocks2d/threads2d.  mu = hyp_diff_coeff (dimensionless per step).
__global__ void kernel_ym_hyperdiffuse_z(YMFieldPtrs f, YMFluidPtrs flA, YMFluidPtrs flB,
                                          int nx, int nz, fct_real_t mu);

// DFT range suppression: subtract Fourier modes kz=kz_lo..kz_hi from color-1 EM
// (By1, Ex1, Ez1) + color-2/3 fields.  Az1 frozen — not touched.
// Kills finite-kz EM instabilities in color-1 sector (γ≈0.08-0.1 TU⁻¹ at kz=7-14)
// that trigger NaN at t≈17.2 TU independent of the kz=0 Weibel.
// Call twice per step: kz=1..k-1 (low) and kz=k+1..kz_hi (high, kills two-stream).
// Optimised: register-caching (1 global read) + warp-shuffle reduce (3 syncs/mode).
// Launch: kernel<<<NX, NZ, (2*NZ/32+2)*15*sizeof(fct_real_t)>>>  (1080 B for NZ=256)
__global__ void kernel_ym_subtract_kz_range(YMFieldPtrs f, YMFluidPtrs flA, YMFluidPtrs flB,
                                              int nx, int nz, int kz_lo, int kz_hi);

// DFT range suppression for fluid z-momentum: subtract kz=kz_lo..kz_hi from pzA and pzB.
// Kills the color-1 two-stream at off-target kz modes.
// Launch: kernel<<<NX, NZ, (2*NZ/32+2)*2*sizeof(fct_real_t)>>>  (144 B smem for NZ=256)
__global__ void kernel_fluid_pz_subtract_kz_range(fct_real_t* pzA, fct_real_t* pzB,
                                                    int nx, int nz, int kz_lo, int kz_hi);

// DFT range suppression for fluid density: subtract kz=kz_lo..kz_hi from nA and nB.
// MUST be called with the same kz ranges as kernel_fluid_pz_subtract_kz_range.
// Without this, density voids form at off-target kz (n→0 with pz=0 → ½pz²/n diverges → NaN).
// Launch: kernel<<<NX, NZ, (2*NZ/32+2)*2*sizeof(fct_real_t)>>>  (144 B smem for NZ=256)
__global__ void kernel_fluid_n_subtract_kz_range(fct_real_t* nA, fct_real_t* nB,
                                                   int nx, int nz, int kz_lo, int kz_hi);

// =====================================================================
// INLINE SU(2) CROSS-PRODUCT HELPERS  (ε^{abc}: 123=231=312=+1, rest=-1)
// (A×B)^a = ε^{abc} A^b B^c
// =====================================================================
__device__ __forceinline__ fct_real_t su2_cross1(fct_real_t A2, fct_real_t A3,
                                                   fct_real_t B2, fct_real_t B3) {
    return A2 * B3 - A3 * B2;
}
__device__ __forceinline__ fct_real_t su2_cross2(fct_real_t A1, fct_real_t A3,
                                                   fct_real_t B1, fct_real_t B3) {
    return A3 * B1 - A1 * B3;
}
__device__ __forceinline__ fct_real_t su2_cross3(fct_real_t A1, fct_real_t A2,
                                                   fct_real_t B1, fct_real_t B2) {
    return A1 * B2 - A2 * B1;
}

#endif // YM_PHYSICS_CUH
