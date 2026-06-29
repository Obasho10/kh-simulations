#include "EMHD_Physics.cuh"
#include <iostream>

// =====================================================================
// 1. DEVICE KERNELS
// =====================================================================
/*__global__ void kernel_smooth_fields(GaugeFieldPtrs f, int nx, int nz) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);
    int xm = max(0, x - 1); int xp = min(nx - 1, x + 1);
    int zm = (z == 0) ? nz - 1 : z - 1; int zp = (z == nz - 1) ? 0 : z + 1;

    // Apply 3x3 box blur to dampen initial discontinuities
    f.By[idx] = 0.25 * f.By[idx] + 0.125 * (f.By[IDX(xp,z,nx)] + f.By[IDX(xm,z,nx)] + 
                                            f.By[IDX(x,zp,nx)] + f.By[IDX(x,zm,nx)]);
    f.Ex[idx] = 0.25 * f.Ex[idx] + 0.125 * (f.Ex[IDX(xp,z,nx)] + f.Ex[IDX(xm,z,nx)] + 
                                            f.Ex[IDX(x,zp,nx)] + f.Ex[IDX(x,zm,nx)]);
}*/
__global__ void kernel_ampere_maxwell(GaugeFieldPtrs f, GaugeParams p, int nx, int nz) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);

    // Z is periodic
    int zm = (z == 0) ? nz - 1 : z - 1;

    fct_real_t c2 = p.c * p.c;
    fct_real_t dt = p.dt_step;

    // curl(B)_x = -dBy/dz
    fct_real_t dBy_dz = (f.By[idx] - f.By[IDX(x, zm, nx)]) / p.dz;
    fct_real_t curlB_x = -dBy_dz;

    // curl(B)_y = dBx/dz - dBz/dx
    fct_real_t dBx_dz = (f.Bx[idx] - f.Bx[IDX(x, zm, nx)]) / p.dz;
    fct_real_t dBz_dx;
    if (x == 0) dBz_dx = (f.Bz[IDX(1, z, nx)] - f.Bz[idx]) / p.dx; // Constant gradient boundary
    else dBz_dx = (f.Bz[idx] - f.Bz[IDX(x - 1, z, nx)]) / p.dx;
    fct_real_t curlB_y = dBx_dz - dBz_dx;

    // curl(B)_z = dBy/dx
    fct_real_t dBy_dx;
    if (x == 0) dBy_dx = (f.By[IDX(1, z, nx)] - f.By[idx]) / p.dx; // Constant gradient boundary
    else dBy_dx = (f.By[idx] - f.By[IDX(x - 1, z, nx)]) / p.dx;
    fct_real_t curlB_z = dBy_dx;

    // CRITICAL FIX: The fluid current J is now subtracted, coupling Matter to Fields!
    f.Ex[idx] += dt * (c2 * curlB_x - f.Jx[idx] / p.eps_0);
    f.Ey[idx] += dt * (c2 * curlB_y - f.Jy[idx] / p.eps_0);
    f.Ez[idx] += dt * (c2 * curlB_z - f.Jz[idx] / p.eps_0);
}

__global__ void kernel_vector_potential(GaugeFieldPtrs f, GaugeParams p, int nx, int nz) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);

    f.Ax[idx] -= p.dt_step * f.Ex[idx];
    f.Ay[idx] -= p.dt_step * f.Ey[idx];
    f.Az[idx] -= p.dt_step * f.Ez[idx];
}

__global__ void kernel_faraday(GaugeFieldPtrs f, GaugeParams p, int nx, int nz) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);

    // Z is periodic
    int zp = (z == nz - 1) ? 0 : z + 1;

    fct_real_t dt = p.dt_step;

    // curl(E)_x = -dEy/dz
    fct_real_t dEy_dz = (f.Ey[IDX(x, zp, nx)] - f.Ey[idx]) / p.dz;
    fct_real_t curlE_x = -dEy_dz;

    // curl(E)_y = dEx/dz - dEz/dx
    fct_real_t dEx_dz = (f.Ex[IDX(x, zp, nx)] - f.Ex[idx]) / p.dz;
    fct_real_t dEz_dx;
    if (x == nx - 1) dEz_dx = (f.Ez[idx] - f.Ez[IDX(x - 1, z, nx)]) / p.dx; // Constant gradient boundary
    else dEz_dx = (f.Ez[IDX(x + 1, z, nx)] - f.Ez[idx]) / p.dx;
    fct_real_t curlE_y = dEx_dz - dEz_dx;

    // curl(E)_z = dEy/dx
    fct_real_t dEy_dx;
    if (x == nx - 1) dEy_dx = (f.Ey[idx] - f.Ey[IDX(x - 1, z, nx)]) / p.dx; // Constant gradient boundary
    else dEy_dx = (f.Ey[IDX(x + 1, z, nx)] - f.Ey[idx]) / p.dx;
    fct_real_t curlE_z = dEy_dx;

    f.Bx[idx] -= dt * curlE_x;
    f.By[idx] -= dt * curlE_y;
    f.Bz[idx] -= dt * curlE_z;
}

// =====================================================================
// 2. HOST WRAPPERS
// =====================================================================
namespace Gauge {
    void step_ampere_maxwell(GaugeFieldPtrs d_fields, GaugeParams params, int nx, int nz) {
        dim3 threads(16, 16);
        dim3 blocks((nx + 15) / 16, (nz + 15) / 16);
        kernel_ampere_maxwell<<<blocks, threads>>>(d_fields, params, nx, nz);
    }
    void step_vector_potential(GaugeFieldPtrs d_fields, GaugeParams params, int nx, int nz) {
        dim3 threads(16, 16);
        dim3 blocks((nx + 15) / 16, (nz + 15) / 16);
        kernel_vector_potential<<<blocks, threads>>>(d_fields, params, nx, nz);
    }
    void step_faraday(GaugeFieldPtrs d_fields, GaugeParams params, int nx, int nz) {
        dim3 threads(16, 16);
        dim3 blocks((nx + 15) / 16, (nz + 15) / 16);
        kernel_faraday<<<blocks, threads>>>(d_fields, params, nx, nz);
    }
}
