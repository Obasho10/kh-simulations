#include "FCT_Kernels.cuh"
#include "FCT_DeviceMath.cuh"

#define BLOCK_SIZE 256
#define HALO 3
#define TILE_DIM 32
#define BLOCK_ROWS 8

// =====================================================================
// 1. THE SHARED MEMORY TRANSPOSE KERNEL
// =====================================================================
__global__ void transpose_fluid_kernel(const fct_real_t* __restrict__ src, fct_real_t* __restrict__ dst, int width, int height) {
    __shared__ fct_real_t tile[TILE_DIM][TILE_DIM + 1];

    int x = blockIdx.x * TILE_DIM + threadIdx.x;
    int y = blockIdx.y * TILE_DIM + threadIdx.y;

    for (int j = 0; j < TILE_DIM; j += BLOCK_ROWS) {
        if (x < width && (y + j) < height) {
            tile[threadIdx.y + j][threadIdx.x] = src[(y + j) * width + x];
        }
    }
    
    __syncthreads();

    x = blockIdx.y * TILE_DIM + threadIdx.x;  
    y = blockIdx.x * TILE_DIM + threadIdx.y;

    for (int j = 0; j < TILE_DIM; j += BLOCK_ROWS) {
        if (x < height && (y + j) < width) {
            dst[(y + j) * height + x] = tile[threadIdx.x][threadIdx.y + j];
        }
    }
}

// =====================================================================
// 2. THE FUSED FCT SWEEP KERNEL
// =====================================================================
__global__ void fct_sweep_kernel(
    const fct_real_t* __restrict__ d_n_old, 
    const fct_real_t* __restrict__ d_u_old, 
    const fct_real_t* __restrict__ d_var_old, 
    fct_real_t* __restrict__ d_var_new, 
    const fct_real_t* __restrict__ d_source, 
    fct_real_t* __restrict__ d_therm,
    int nx, fct_real_t dx, fct_real_t dt_step, bool track_thermal) 
{
    int tx = threadIdx.x;
    int x_global = blockIdx.x * blockDim.x + tx;
    int y_global = blockIdx.y;

    int x_clamped = min(x_global, nx - 1);
    int base_idx = y_global * nx;

    const int smem_size = BLOCK_SIZE + 2 * HALO;
    __shared__ fct_real_t s_u[smem_size];
    __shared__ fct_real_t s_var[smem_size];
    __shared__ fct_real_t s_source[smem_size];
    __shared__ fct_real_t s_lorhot[smem_size]; // NEW: Transported intermediate
    __shared__ fct_real_t s_lnrhot[smem_size];
    __shared__ fct_real_t s_flx_ad[smem_size];

    int s_idx = tx + HALO; 

    // -------------------------------------------------------------
    // PHASE A: Load Global Data 
    // -------------------------------------------------------------
    s_u[s_idx]   = d_u_old[base_idx + x_clamped];
    s_var[s_idx] = d_var_old[base_idx + x_clamped];
    s_source[s_idx] = (d_source != nullptr) ? d_source[base_idx + x_clamped] : 0.0;

    if (tx < HALO) {
        int left_x = max(0, x_global - HALO);
        s_u[tx] = d_u_old[base_idx + left_x];
        s_var[tx] = d_var_old[base_idx + left_x];
        s_source[tx] = (d_source != nullptr) ? d_source[base_idx + left_x] : 0.0;

        int right_x = min(nx - 1, blockIdx.x * blockDim.x + blockDim.x + tx);
        s_u[s_idx + blockDim.x] = d_u_old[base_idx + right_x];
        s_var[s_idx + blockDim.x] = d_var_old[base_idx + right_x];
        s_source[s_idx + blockDim.x] = (d_source != nullptr) ? d_source[base_idx + right_x] : 0.0;
    }
    __syncthreads();

    // -------------------------------------------------------------
    // PHASE B: Low-Order Solution (Coupled with Euler Sources)
    // -------------------------------------------------------------
    fct_real_t eps_left = compute_eps(s_u[s_idx - 1], s_u[s_idx], dt_step, dx);
    fct_real_t eps_right = compute_eps(s_u[s_idx], s_u[s_idx + 1], dt_step, dx);

    fct_real_t nu_left, mu_left, nu_right, mu_right;
    compute_nu_mu(eps_left, nu_left, mu_left);
    compute_nu_mu(eps_right, nu_right, mu_right);

    fct_real_t flx_left  = 0.5 * eps_left  * (s_var[s_idx - 1] + s_var[s_idx]);
    fct_real_t flx_right = 0.5 * eps_right * (s_var[s_idx]  + s_var[s_idx + 1]);
    fct_real_t diff_left  = nu_left  * (s_var[s_idx]  - s_var[s_idx - 1]);
    fct_real_t diff_right = nu_right * (s_var[s_idx + 1] - s_var[s_idx]);

    // Explicitly separate LORHOT (for advection fluxes) and LNRHOT (for limiters)
    // Source must be scaled by dt_step: LCPFCT adds dt*F, not raw force F
    s_lorhot[s_idx] = s_var[s_idx] + dt_step * s_source[s_idx] - (flx_right - flx_left);
    s_lnrhot[s_idx] = s_lorhot[s_idx] + (diff_right - diff_left);

    if (tx < 2) {
        int halo_idx = tx + 1;
        fct_real_t e_L = compute_eps(s_u[halo_idx - 1], s_u[halo_idx], dt_step, dx);
        fct_real_t e_R = compute_eps(s_u[halo_idx], s_u[halo_idx + 1], dt_step, dx);
        fct_real_t n_L, m_L, n_R, m_R; compute_nu_mu(e_L, n_L, m_L); compute_nu_mu(e_R, n_R, m_R);
        
        fct_real_t f_L = 0.5 * e_L * (s_var[halo_idx - 1] + s_var[halo_idx]);
        fct_real_t f_R = 0.5 * e_R * (s_var[halo_idx] + s_var[halo_idx + 1]);
        fct_real_t d_L = n_L * (s_var[halo_idx] - s_var[halo_idx - 1]);
        fct_real_t d_R = n_R * (s_var[halo_idx + 1] - s_var[halo_idx]);

        s_lorhot[halo_idx] = s_var[halo_idx] + dt_step * s_source[halo_idx] - (f_R - f_L);
        s_lnrhot[halo_idx] = s_lorhot[halo_idx] + (d_R - d_L);
    }
    if (tx >= blockDim.x - 2) {
        int halo_idx = blockDim.x + HALO + (tx - (blockDim.x - 2));
        fct_real_t e_L = compute_eps(s_u[halo_idx - 1], s_u[halo_idx], dt_step, dx);
        fct_real_t e_R = compute_eps(s_u[halo_idx], s_u[halo_idx + 1], dt_step, dx);
        fct_real_t n_L, m_L, n_R, m_R; compute_nu_mu(e_L, n_L, m_L); compute_nu_mu(e_R, n_R, m_R);

        fct_real_t f_L = 0.5 * e_L * (s_var[halo_idx - 1] + s_var[halo_idx]);
        fct_real_t f_R = 0.5 * e_R * (s_var[halo_idx] + s_var[halo_idx + 1]);
        fct_real_t d_L = n_L * (s_var[halo_idx] - s_var[halo_idx - 1]);
        fct_real_t d_R = n_R * (s_var[halo_idx + 1] - s_var[halo_idx]);

        s_lorhot[halo_idx] = s_var[halo_idx] + dt_step * s_source[halo_idx] - (f_R - f_L);
        s_lnrhot[halo_idx] = s_lorhot[halo_idx] + (d_R - d_L);
    }
    __syncthreads();

    // -------------------------------------------------------------
    // PHASE C: The Limiter
    // -------------------------------------------------------------
    // FIX: Anti-diffusive fluxes MUST use transported LORHOT, not the old state.
    s_flx_ad[s_idx] = mu_right * (s_lorhot[s_idx + 1] - s_lorhot[s_idx]);
    
    if (tx < 2) {
        int halo_idx = tx + 1;
        fct_real_t e_R = compute_eps(s_u[halo_idx], s_u[halo_idx + 1], dt_step, dx);
        fct_real_t n_R, m_R; compute_nu_mu(e_R, n_R, m_R);
        s_flx_ad[halo_idx] = m_R * (s_lorhot[halo_idx + 1] - s_lorhot[halo_idx]);
    }
    if (tx >= blockDim.x - 2) {
        int halo_idx = blockDim.x + HALO + (tx - (blockDim.x - 2));
        fct_real_t e_R = compute_eps(s_u[halo_idx], s_u[halo_idx + 1], dt_step, dx);
        fct_real_t n_R, m_R; compute_nu_mu(e_R, n_R, m_R);
        s_flx_ad[halo_idx] = m_R * (s_lorhot[halo_idx + 1] - s_lorhot[halo_idx]);
    }
    __syncthreads();

    fct_real_t diff_m1 = s_lnrhot[s_idx] - s_lnrhot[s_idx - 1];
    fct_real_t diff_0  = s_lnrhot[s_idx + 1] - s_lnrhot[s_idx];
    fct_real_t diff_p1 = s_lnrhot[s_idx + 2] - s_lnrhot[s_idx + 1];

    fct_real_t flx_lim_left  = apply_fct_limiter(s_flx_ad[s_idx - 1], s_lnrhot[s_idx - 1] - s_lnrhot[s_idx - 2], diff_m1, diff_0);
    fct_real_t flx_lim_right = apply_fct_limiter(s_flx_ad[s_idx], diff_m1, diff_0, diff_p1);

    fct_real_t var_new = s_lnrhot[s_idx] - (flx_lim_right - flx_lim_left);

    // -------------------------------------------------------------
    // PHASE D: Energy Tracking & Global Write
    // -------------------------------------------------------------
    if (x_global < nx) {
        if (track_thermal) {
            fct_real_t ke_diss = compute_dissipated_energy(
                d_n_old[base_idx + x_global], d_u_old[base_idx + x_global], 0.0, 
                d_n_old[base_idx + x_global], var_new, 0.0 
            );
            atomicAdd(&d_therm[base_idx + x_global], ke_diss);
        }
        d_var_new[base_idx + x_global] = var_new;
    }
}

// =====================================================================
// 3. HOST LAUNCHERS
// =====================================================================
namespace FCT {

void run_x_sweep(FluidDevicePtrs d_old, FluidDevicePtrs d_new, FluidDevicePtrs d_src, GridParams grid, fct_real_t dt_step) {
    dim3 threads(BLOCK_SIZE, 1, 1);
    dim3 blocks((grid.nx + BLOCK_SIZE - 1) / BLOCK_SIZE, grid.ny, 1);

    // n has no source (mass conservation)
    fct_sweep_kernel<<<blocks, threads>>>(d_old.n, d_old.ux, d_old.n,  d_new.n,  nullptr,  d_new.E_therm, grid.nx, grid.dx, dt_step, false);
    
    // px, py, pz all receive Lorentz force sources
    fct_sweep_kernel<<<blocks, threads>>>(d_old.n, d_old.ux, d_old.px, d_new.px, d_src.px, d_new.E_therm, grid.nx, grid.dx, dt_step, false);
    fct_sweep_kernel<<<blocks, threads>>>(d_old.n, d_old.ux, d_old.py, d_new.py, d_src.py, d_new.E_therm, grid.nx, grid.dx, dt_step, false);
    fct_sweep_kernel<<<blocks, threads>>>(d_old.n, d_old.ux, d_old.pz, d_new.pz, d_src.pz, d_new.E_therm, grid.nx, grid.dx, dt_step, false);

    cudaDeviceSynchronize();
}

void run_y_sweep(FluidDevicePtrs d_old, FluidDevicePtrs d_new, FluidDevicePtrs d_src,
                 FluidDevicePtrs d_old_t, FluidDevicePtrs d_new_t, FluidDevicePtrs d_src_t,
                 GridParams grid, fct_real_t dt_step) {
    dim3 trans_threads(TILE_DIM, BLOCK_ROWS, 1);
    dim3 trans_blocks((grid.nx + TILE_DIM - 1) / TILE_DIM, (grid.ny + TILE_DIM - 1) / TILE_DIM, 1);

    fct_real_t* vars_old[] = {d_old.n, d_old.uy, d_old.px, d_old.py, d_old.pz, d_old.E_therm};
    fct_real_t* vars_old_t[] = {d_old_t.n, d_old_t.uy, d_old_t.px, d_old_t.py, d_old_t.pz, d_old_t.E_therm};
    for (int i = 0; i < 6; ++i) transpose_fluid_kernel<<<trans_blocks, trans_threads>>>(vars_old[i], vars_old_t[i], grid.nx, grid.ny);

    // Transpose all 3 source arrays
    transpose_fluid_kernel<<<trans_blocks, trans_threads>>>(d_src.px, d_src_t.px, grid.nx, grid.ny);
    transpose_fluid_kernel<<<trans_blocks, trans_threads>>>(d_src.py, d_src_t.py, grid.nx, grid.ny);
    transpose_fluid_kernel<<<trans_blocks, trans_threads>>>(d_src.pz, d_src_t.pz, grid.nx, grid.ny);
    cudaDeviceSynchronize();

    dim3 sweep_threads(BLOCK_SIZE, 1, 1);
    dim3 sweep_blocks((grid.ny + BLOCK_SIZE - 1) / BLOCK_SIZE, grid.nx, 1);
    
    // n has no source
    fct_sweep_kernel<<<sweep_blocks, sweep_threads>>>(d_old_t.n, d_old_t.uy, d_old_t.n,  d_new_t.n,  nullptr,    d_new_t.E_therm, grid.ny, grid.dy, dt_step, false);
    
    // px, py, pz all receive Lorentz force sources
    fct_sweep_kernel<<<sweep_blocks, sweep_threads>>>(d_old_t.n, d_old_t.uy, d_old_t.px, d_new_t.px, d_src_t.px, d_new_t.E_therm, grid.ny, grid.dy, dt_step, false);
    fct_sweep_kernel<<<sweep_blocks, sweep_threads>>>(d_old_t.n, d_old_t.uy, d_old_t.py, d_new_t.py, d_src_t.py, d_new_t.E_therm, grid.ny, grid.dy, dt_step, false);
    fct_sweep_kernel<<<sweep_blocks, sweep_threads>>>(d_old_t.n, d_old_t.uy, d_old_t.pz, d_new_t.pz, d_src_t.pz, d_new_t.E_therm, grid.ny, grid.dy, dt_step, false);
    cudaDeviceSynchronize();

    dim3 rev_trans_blocks((grid.ny + TILE_DIM - 1) / TILE_DIM, (grid.nx + TILE_DIM - 1) / TILE_DIM, 1);
    fct_real_t* vars_new[] = {d_new.n, d_new.px, d_new.py, d_new.pz, d_new.E_therm};
    fct_real_t* vars_new_t[] = {d_new_t.n, d_new_t.px, d_new_t.py, d_new_t.pz, d_new_t.E_therm};
    for (int i = 0; i < 5; ++i) transpose_fluid_kernel<<<rev_trans_blocks, trans_threads>>>(vars_new_t[i], vars_new[i], grid.ny, grid.nx);
    cudaDeviceSynchronize();
}
} // namespace FCT


