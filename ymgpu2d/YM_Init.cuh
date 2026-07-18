#ifndef YM_INIT_CUH
#define YM_INIT_CUH

#include "YM_Common.cuh"

// Full 6-field eigenfunction seed for Mode 6 (NAB_CIRC_AZ2).
// All x-profiles normalized relative to max|Az|=1.
// nullptr on any field → that field is not seeded (stays at its equilibrium value).
// Produced by: python3 ym_eigenmode.py --export-seed
struct YMSeedProfiles {
    const fct_real_t* by = nullptr;   // By2 x-amplitude
    const fct_real_t* ex = nullptr;   // Ex2 x-amplitude (reserved; not yet used)
    const fct_real_t* ez = nullptr;   // Ez2 x-amplitude (reserved; not yet used)
    const fct_real_t* az = nullptr;   // Az2 x-amplitude
    const fct_real_t* qA = nullptr;   // Q2 color charge, beam A
    const fct_real_t* qB = nullptr;   // Q2 color charge, beam B
};

__global__ void kernel_ym_init(YMFieldPtrs f,
                                YMFluidPtrs flA, YMFluidPtrs flB,
                                int nx, int nz,
                                fct_real_t dx, fct_real_t dz,
                                int k_mode, fct_real_t perturb_amp,
                                fct_real_t V0, fct_real_t epsilon,
                                int run_mode, fct_real_t alpha_YM,
                                int init_by1_eq, fct_real_t vz_edge_taper,
                                YMSeedProfiles seed = YMSeedProfiles{});

#endif // YM_INIT_CUH
