#ifndef YM_COMMON_CUH
#define YM_COMMON_CUH

#include <iostream>
#include "YM_Physics.cuh"
#include "FCT_Kernels.cuh"

#define CUDA_CHECK(call) \
    do { cudaError_t err = call; if (err != cudaSuccess) { \
        std::cerr << "CUDA error: " << cudaGetErrorString(err) \
                  << " at " << __FILE__ << ":" << __LINE__ << "\n"; exit(1); } } while (0)

#endif // YM_COMMON_CUH
