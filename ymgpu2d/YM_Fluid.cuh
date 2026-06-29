#ifndef YM_FLUID_CUH
#define YM_FLUID_CUH

#include "YM_Common.cuh"
#include <cstddef>

__global__ void kernel_update_velocities(YMFluidPtrs fl, int nx, int nz);

__global__ void kernel_enforce_boundaries(YMFieldPtrs f, YMFluidPtrs flA, YMFluidPtrs flB,
                                           int nx, int nz, int periodic_x);

__global__ void kernel_ym_lorentz(YMFluidPtrs src, YMFieldPtrs f, YMFluidPtrs fl,
                                   int nx, int nz, int periodic_x);

__global__ void kernel_ym_precession(fct_real_t* src_Q1, fct_real_t* src_Q2, fct_real_t* src_Q3,
                                      YMFieldPtrs f, YMFluidPtrs fl,
                                      fct_real_t alpha_YM, int nx, int nz);

void alloc_ym_fluid(YMFluidPtrs& fl, size_t bytes);
void alloc_ym_fields(YMFieldPtrs& f, size_t bytes);
void copy_ym_fluid(YMFluidPtrs& dst, const YMFluidPtrs& src, size_t bytes);

#endif // YM_FLUID_CUH
