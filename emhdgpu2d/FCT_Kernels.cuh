#ifndef FCT_KERNELS_CUH
#define FCT_KERNELS_CUH

#include "FCT_DeviceMath.cuh"

// =====================================================================
// DEVICE KERNELS
// =====================================================================

// Corrected Signature (Bug 11: matches the .cu implementation)
__global__ void transpose_fluid_kernel(const fct_real_t* src, fct_real_t* dst, int w, int h);

__global__ void fct_sweep_kernel(
    const fct_real_t* d_n_old,
    const fct_real_t* d_u_old,
    const fct_real_t* d_var_old,
    fct_real_t* d_var_new,
    const fct_real_t* d_source,
    fct_real_t* d_therm,
    int nx,
    fct_real_t dx,
    fct_real_t dt_step,
    bool track_thermal
);

// Note: fct_x_sweep_kernel and fct_y_sweep_kernel declarations removed (Bug 10). 
// They were dead code that never existed in FCT_Sweeps.cu.

// =====================================================================
// HOST WRAPPERS
// =====================================================================
namespace FCT {
    // These remain unchanged, as they correctly orchestrate the single fct_sweep_kernel
    void run_x_sweep(FluidDevicePtrs d_old, FluidDevicePtrs d_new, FluidDevicePtrs d_src, GridParams grid, fct_real_t dt);
    void run_y_sweep(FluidDevicePtrs d_old, FluidDevicePtrs d_new, FluidDevicePtrs d_src, 
                     FluidDevicePtrs d_old_t, FluidDevicePtrs d_new_t, FluidDevicePtrs d_src_t, 
                     GridParams grid, fct_real_t dt);
}

#endif