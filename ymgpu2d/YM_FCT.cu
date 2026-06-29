#include "YM_FCT.cuh"

// Pack one NX×NZ field into NX_PAD×NZ with periodic ghost cells in x.
// Left  ghosts [0..HALO-1]:         copied from real cells [NX-HALO..NX-1]
// Real  cells  [HALO..NX+HALO-1]:   copied from real cells [0..NX-1]
// Right ghosts [NX+HALO..NX_PAD-1]: copied from real cells [0..HALO-1]
static __global__ void kernel_pack_ghost(const fct_real_t* __restrict__ src,
                                          fct_real_t* __restrict__ dst,
                                          int nx, int nx_pad, int nz, int halo) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (z >= nz) return;
    if (x < nx)   dst[z * nx_pad + (x + halo)] = src[z * nx + x];
    if (x < halo) {
        dst[z * nx_pad + x]                = src[z * nx + (nx - halo + x)];
        dst[z * nx_pad + (nx + halo + x)]  = src[z * nx + x];
    }
}

// Unpack: copy real cells [HALO..NX+HALO-1] from padded array back to NX×NZ layout.
static __global__ void kernel_unpack_ghost(const fct_real_t* __restrict__ src,
                                            fct_real_t* __restrict__ dst,
                                            int nx, int nx_pad, int nz, int halo) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    dst[z * nx + x] = src[z * nx_pad + (x + halo)];
}

void ym_fct_x_sweep(YMFluidPtrs& d_old, YMFluidPtrs& d_new,
                    YMFluidPtrs& d_src,
                    fct_real_t* d_srcQ1, fct_real_t* d_srcQ2, fct_real_t* d_srcQ3,
                    GridParams grid, fct_real_t dt) {
    dim3 threads(BLOCK_SZ, 1, 1);
    dim3 blocks((grid.nx + BLOCK_SZ - 1) / BLOCK_SZ, grid.ny, 1);

    // x-sweep: apply only x-force (Fx) to px; z-force and precession go in z-sweep
    fct_sweep_kernel<<<blocks,threads>>>(d_old.n,  d_old.ux, d_old.n,  d_new.n,  nullptr,    d_new.E_therm, grid.nx, grid.dx, dt, false);
    fct_sweep_kernel<<<blocks,threads>>>(d_old.n,  d_old.ux, d_old.px, d_new.px, d_src.px,   d_new.E_therm, grid.nx, grid.dx, dt, false);
    fct_sweep_kernel<<<blocks,threads>>>(d_old.n,  d_old.ux, d_old.pz, d_new.pz, nullptr,    d_new.E_therm, grid.nx, grid.dx, dt, false);
    fct_sweep_kernel<<<blocks,threads>>>(d_old.n,  d_old.ux, d_old.Q1, d_new.Q1, nullptr,    d_new.E_therm, grid.nx, grid.dx, dt, false);
    fct_sweep_kernel<<<blocks,threads>>>(d_old.n,  d_old.ux, d_old.Q2, d_new.Q2, nullptr,    d_new.E_therm, grid.nx, grid.dx, dt, false);
    fct_sweep_kernel<<<blocks,threads>>>(d_old.n,  d_old.ux, d_old.Q3, d_new.Q3, nullptr,    d_new.E_therm, grid.nx, grid.dx, dt, false);
    cudaDeviceSynchronize();
}

void ym_fct_x_sweep_periodic(
    YMFluidPtrs& d_old, YMFluidPtrs& d_new, YMFluidPtrs& d_src,
    fct_real_t* d_srcQ1, fct_real_t* d_srcQ2, fct_real_t* d_srcQ3,
    GridParams grid, fct_real_t dt,
    fct_real_t* p_n, fct_real_t* p_ux,
    fct_real_t* p_var, fct_real_t* p_new,
    fct_real_t* p_src, fct_real_t* p_eth)
{
    const int nx   = grid.nx;
    const int nz   = grid.ny;
    const int np   = NX_PAD;
    const int halo = FCT_HALO;

    dim3 pk_threads(64, 4);
    dim3 pk_blocks((np + 63) / 64, (nz + 3) / 4);
    dim3 sw_threads(BLOCK_SZ, 1);
    dim3 sw_blocks((np + BLOCK_SZ - 1) / BLOCK_SZ, nz);

    // Pack shared density + velocity once (all variable sweeps use the same n, ux)
    kernel_pack_ghost<<<pk_blocks, pk_threads>>>(d_old.n,  p_n,  nx, np, nz, halo);
    kernel_pack_ghost<<<pk_blocks, pk_threads>>>(d_old.ux, p_ux, nx, np, nz, halo);
    cudaDeviceSynchronize();

    // Helper lambda: pack var, run FCT, unpack result
    auto do_sweep = [&](fct_real_t* var_old, fct_real_t* var_new, fct_real_t* src_arr) {
        kernel_pack_ghost<<<pk_blocks, pk_threads>>>(var_old, p_var, nx, np, nz, halo);
        if (src_arr) {
            kernel_pack_ghost<<<pk_blocks, pk_threads>>>(src_arr, p_src, nx, np, nz, halo);
        }
        cudaDeviceSynchronize();
        fct_sweep_kernel<<<sw_blocks, sw_threads>>>(p_n, p_ux, p_var, p_new,
                                                     src_arr ? p_src : nullptr,
                                                     p_eth, np, grid.dx, dt, false);
        cudaDeviceSynchronize();
        kernel_unpack_ghost<<<pk_blocks, pk_threads>>>(p_new, var_new, nx, np, nz, halo);
        cudaDeviceSynchronize();
    };

    do_sweep(d_old.n,  d_new.n,  nullptr);
    do_sweep(d_old.px, d_new.px, d_src.px);
    do_sweep(d_old.pz, d_new.pz, nullptr);
    do_sweep(d_old.Q1, d_new.Q1, nullptr);
    do_sweep(d_old.Q2, d_new.Q2, nullptr);
    do_sweep(d_old.Q3, d_new.Q3, nullptr);
}

void ym_fct_z_sweep(YMFluidPtrs& d_old,  YMFluidPtrs& d_new,
                    YMFluidPtrs& d_src,
                    fct_real_t*  d_srcQ1, fct_real_t* d_srcQ2, fct_real_t* d_srcQ3,
                    YMFluidPtrs& d_old_t, YMFluidPtrs& d_new_t,
                    YMFluidPtrs& d_src_t,
                    fct_real_t*  d_srcQ1_t, fct_real_t* d_srcQ2_t, fct_real_t* d_srcQ3_t,
                    GridParams grid, fct_real_t dt) {
    dim3 trans_threads(TILE_DIM2, BLOCK_R2, 1);
    dim3 trans_blocks((grid.nx + TILE_DIM2-1)/TILE_DIM2,
                      (grid.ny + TILE_DIM2-1)/TILE_DIM2, 1);

    fct_real_t* to_old[]   = { d_old.n, d_old.uy, d_old.px, d_old.pz, d_old.Q1, d_old.Q2, d_old.Q3, d_old.E_therm };
    fct_real_t* to_old_t[] = { d_old_t.n, d_old_t.uy, d_old_t.px, d_old_t.pz, d_old_t.Q1, d_old_t.Q2, d_old_t.Q3, d_old_t.E_therm };
    for (int i = 0; i < 8; ++i)
        transpose_fluid_kernel<<<trans_blocks,trans_threads>>>(to_old[i], to_old_t[i], grid.nx, grid.ny);

    transpose_fluid_kernel<<<trans_blocks,trans_threads>>>(d_src.px,  d_src_t.px,  grid.nx, grid.ny);
    transpose_fluid_kernel<<<trans_blocks,trans_threads>>>(d_src.pz,  d_src_t.pz,  grid.nx, grid.ny);
    transpose_fluid_kernel<<<trans_blocks,trans_threads>>>(d_srcQ1,   d_srcQ1_t,   grid.nx, grid.ny);
    transpose_fluid_kernel<<<trans_blocks,trans_threads>>>(d_srcQ2,   d_srcQ2_t,   grid.nx, grid.ny);
    transpose_fluid_kernel<<<trans_blocks,trans_threads>>>(d_srcQ3,   d_srcQ3_t,   grid.nx, grid.ny);
    cudaDeviceSynchronize();

    dim3 sweep_threads(BLOCK_SZ, 1, 1);
    dim3 sweep_blocks((grid.ny + BLOCK_SZ-1)/BLOCK_SZ, grid.nx, 1);

    // z-sweep: apply only z-force (Fz) to pz; x-force was already applied in x-sweep
    fct_sweep_kernel<<<sweep_blocks,sweep_threads>>>(d_old_t.n, d_old_t.uy, d_old_t.n,  d_new_t.n,  nullptr,     d_new_t.E_therm, grid.ny, grid.dy, dt, false);
    fct_sweep_kernel<<<sweep_blocks,sweep_threads>>>(d_old_t.n, d_old_t.uy, d_old_t.px, d_new_t.px, nullptr,     d_new_t.E_therm, grid.ny, grid.dy, dt, false);
    fct_sweep_kernel<<<sweep_blocks,sweep_threads>>>(d_old_t.n, d_old_t.uy, d_old_t.pz, d_new_t.pz, d_src_t.pz, d_new_t.E_therm, grid.ny, grid.dy, dt, false);
    fct_sweep_kernel<<<sweep_blocks,sweep_threads>>>(d_old_t.n, d_old_t.uy, d_old_t.Q1, d_new_t.Q1, d_srcQ1_t,  d_new_t.E_therm, grid.ny, grid.dy, dt, false);
    fct_sweep_kernel<<<sweep_blocks,sweep_threads>>>(d_old_t.n, d_old_t.uy, d_old_t.Q2, d_new_t.Q2, d_srcQ2_t,  d_new_t.E_therm, grid.ny, grid.dy, dt, false);
    fct_sweep_kernel<<<sweep_blocks,sweep_threads>>>(d_old_t.n, d_old_t.uy, d_old_t.Q3, d_new_t.Q3, d_srcQ3_t,  d_new_t.E_therm, grid.ny, grid.dy, dt, false);
    cudaDeviceSynchronize();

    dim3 rev_blocks((grid.ny + TILE_DIM2-1)/TILE_DIM2,
                    (grid.nx + TILE_DIM2-1)/TILE_DIM2, 1);
    fct_real_t* to_new[]   = { d_new.n, d_new.px, d_new.pz, d_new.Q1, d_new.Q2, d_new.Q3, d_new.E_therm };
    fct_real_t* to_new_t[] = { d_new_t.n, d_new_t.px, d_new_t.pz, d_new_t.Q1, d_new_t.Q2, d_new_t.Q3, d_new_t.E_therm };
    for (int i = 0; i < 7; ++i)
        transpose_fluid_kernel<<<rev_blocks,trans_threads>>>(to_new_t[i], to_new[i], grid.ny, grid.nx);
    cudaDeviceSynchronize();
}
