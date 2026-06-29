#ifndef YM_ENERGY_CUH
#define YM_ENERGY_CUH

#include "YM_Common.cuh"
#include <vector>

__global__ void kernel_ym_energy(YMFieldPtrs f, YMFluidPtrs flA, YMFluidPtrs flB,
                                  fct_real_t* d_out, int nx, int nz);

double compute_ym_energy(YMFieldPtrs& d_f, YMFluidPtrs& d_flA, YMFluidPtrs& d_flB,
                          fct_real_t* d_ebuf, std::vector<fct_real_t>& h_ebuf,
                          int nx, int nz, dim3 blocks, dim3 threads);

#endif // YM_ENERGY_CUH
