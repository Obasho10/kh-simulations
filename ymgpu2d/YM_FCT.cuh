#ifndef YM_FCT_CUH
#define YM_FCT_CUH

#include "YM_Common.cuh"

static constexpr int BLOCK_SZ  = 256;
static constexpr int TILE_DIM2 = 32;
static constexpr int BLOCK_R2  = 8;

// Ghost-cell padding for periodic x-BC in FCT.
// FCT_Sweeps.cu uses HALO=3 for its stencil; must match that value.
static constexpr int FCT_HALO = 3;
static constexpr int NX_PAD   = 768 + 2 * FCT_HALO;  // 774 — sized for NX=3*NZ=768

void ym_fct_x_sweep(YMFluidPtrs& d_old, YMFluidPtrs& d_new,
                    YMFluidPtrs& d_src,
                    fct_real_t* d_srcQ1, fct_real_t* d_srcQ2, fct_real_t* d_srcQ3,
                    GridParams grid, fct_real_t dt);

// Periodic-x FCT x-sweep using ghost-cell padding.
// Six pre-allocated padded scratch buffers are passed in (each NX_PAD*NZ elements).
void ym_fct_x_sweep_periodic(
    YMFluidPtrs& d_old, YMFluidPtrs& d_new, YMFluidPtrs& d_src,
    fct_real_t* d_srcQ1, fct_real_t* d_srcQ2, fct_real_t* d_srcQ3,
    GridParams grid, fct_real_t dt,
    fct_real_t* p_n, fct_real_t* p_ux,
    fct_real_t* p_var, fct_real_t* p_new,
    fct_real_t* p_src, fct_real_t* p_eth);

void ym_fct_z_sweep(YMFluidPtrs& d_old,  YMFluidPtrs& d_new,
                    YMFluidPtrs& d_src,
                    fct_real_t*  d_srcQ1, fct_real_t* d_srcQ2, fct_real_t* d_srcQ3,
                    YMFluidPtrs& d_old_t, YMFluidPtrs& d_new_t,
                    YMFluidPtrs& d_src_t,
                    fct_real_t*  d_srcQ1_t, fct_real_t* d_srcQ2_t, fct_real_t* d_srcQ3_t,
                    GridParams grid, fct_real_t dt);

#endif // YM_FCT_CUH
