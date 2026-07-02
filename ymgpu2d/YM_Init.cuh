#ifndef YM_INIT_CUH
#define YM_INIT_CUH

#include "YM_Common.cuh"

// run_mode controls the seed and equilibrium:
//   0 = NAB_LINEAR:  By2 sin(kz), Az1≠0  (non-Abelian, linearly polarized)
//   1 = NAB_CIRC:    By2 cos(kz) + By3 sin(kz), Az1≠0, freeze_az1=1 (circularly polarized)
//   2 = EMHD_KH:     By1 sin(kz) seed, Az1=0  (Abelian Kelvin-Helmholtz)
//   3 = NAB_DTANH:   double-tanh periodic domain, circularly polarized seed,
//                    freeze_az1=1, periodic_x=1
// d_seed_az: optional device array of NX normalized float32 values for Mode 6 Az2 seeding.
//   nullptr  → WKB Gaussian (default).
//   non-null → use profile[x] as the x-amplitude (profile must be normalized to max|value|=1).
//   Produced by: python3 ym_eigenmode.py --export-seed <file>
__global__ void kernel_ym_init(YMFieldPtrs f,
                                YMFluidPtrs flA, YMFluidPtrs flB,
                                int nx, int nz,
                                fct_real_t dx, fct_real_t dz,
                                int k_mode, fct_real_t perturb_amp,
                                fct_real_t V0, fct_real_t epsilon,
                                int run_mode, fct_real_t alpha_YM,
                                const fct_real_t* d_seed_az = nullptr);

#endif // YM_INIT_CUH
