#include "YM_Fluid.cuh"

__global__ void kernel_update_velocities(YMFluidPtrs fl, int nx, int nz) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);
    fct_real_t safe_n = max(fl.n[idx], (fct_real_t)0.05);
    fl.ux[idx] = fl.px[idx] / safe_n;
    fl.uy[idx] = fl.pz[idx] / safe_n;  // uy used as vz for FCT z-sweep compat
}

__global__ void kernel_enforce_boundaries(YMFieldPtrs f, YMFluidPtrs flA, YMFluidPtrs flB,
                                           int nx, int nz, int periodic_x) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);

    if (flA.n[idx] < 0.05) flA.n[idx] = 0.05;
    if (flB.n[idx] < 0.05) flB.n[idx] = 0.05;

    // Wall BC in x: no cross-stream momentum, no Ez current.
    // Skipped for periodic_x (double-tanh mode) — EM fields wrap around instead.
    if (!periodic_x && (x == 0 || x == nx - 1)) {
        flA.px[idx] = 0.0;
        flB.px[idx] = 0.0;
        f.Ez1[idx] = f.Ez2[idx] = f.Ez3[idx] = 0.0;
    }
}

__global__ void kernel_ym_lorentz(YMFluidPtrs src, YMFieldPtrs f, YMFluidPtrs fl,
                                   int nx, int nz, int periodic_x) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);

    int xm = periodic_x ? (x + nx - 1) % nx : max(0, x - 1);
    int zm = (z == 0) ? nz - 1 : z - 1;

    fct_real_t n_safe = max(fl.n[idx], (fct_real_t)0.05);
    fct_real_t vx = fl.px[idx] / n_safe;
    fct_real_t vz = fl.pz[idx] / n_safe;

    // Interpolate Ex, Ez to node (x,z)
    fct_real_t Ex1 = 0.5*(f.Ex1[idx] + f.Ex1[IDX(xm,z,nx)]);
    fct_real_t Ex2 = 0.5*(f.Ex2[idx] + f.Ex2[IDX(xm,z,nx)]);
    fct_real_t Ex3 = 0.5*(f.Ex3[idx] + f.Ex3[IDX(xm,z,nx)]);

    fct_real_t Ez1 = 0.5*(f.Ez1[idx] + f.Ez1[IDX(x,zm,nx)]);
    fct_real_t Ez2 = 0.5*(f.Ez2[idx] + f.Ez2[IDX(x,zm,nx)]);
    fct_real_t Ez3 = 0.5*(f.Ez3[idx] + f.Ez3[IDX(x,zm,nx)]);

    // 4-point average By to node
    fct_real_t By1 = 0.25*(f.By1[idx] + f.By1[IDX(xm,z,nx)]
                           + f.By1[IDX(x,zm,nx)] + f.By1[IDX(xm,zm,nx)]);
    fct_real_t By2 = 0.25*(f.By2[idx] + f.By2[IDX(xm,z,nx)]
                           + f.By2[IDX(x,zm,nx)] + f.By2[IDX(xm,zm,nx)]);
    fct_real_t By3 = 0.25*(f.By3[idx] + f.By3[IDX(xm,z,nx)]
                           + f.By3[IDX(x,zm,nx)] + f.By3[IDX(xm,zm,nx)]);

    fct_real_t Q1 = fl.Q1[idx], Q2 = fl.Q2[idx], Q3 = fl.Q3[idx];

    src.px[idx] = -(Q1*(Ex1 + vz*By1) + Q2*(Ex2 + vz*By2) + Q3*(Ex3 + vz*By3));
    src.pz[idx] = -(Q1*(Ez1 - vx*By1) + Q2*(Ez2 - vx*By2) + Q3*(Ez3 - vx*By3));
}

__global__ void kernel_ym_precession(fct_real_t* src_Q1, fct_real_t* src_Q2, fct_real_t* src_Q3,
                                      YMFieldPtrs f, YMFluidPtrs fl,
                                      fct_real_t alpha_YM, int nx, int nz) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);

    int zm = (z == 0) ? nz - 1 : z - 1;

    fct_real_t n_safe = max(fl.n[idx], (fct_real_t)0.05);
    fct_real_t vz = fl.pz[idx] / n_safe;

    fct_real_t Az1 = 0.5*(f.Az1[idx] + f.Az1[IDX(x,zm,nx)]);
    fct_real_t Az2 = 0.5*(f.Az2[idx] + f.Az2[IDX(x,zm,nx)]);
    fct_real_t Az3 = 0.5*(f.Az3[idx] + f.Az3[IDX(x,zm,nx)]);

    fct_real_t Q1 = fl.Q1[idx], Q2 = fl.Q2[idx], Q3 = fl.Q3[idx];

    src_Q1[idx] = alpha_YM * vz * su2_cross1(Q2, Q3, Az2, Az3);
    src_Q2[idx] = alpha_YM * vz * su2_cross2(Q1, Q3, Az1, Az3);
    src_Q3[idx] = alpha_YM * vz * su2_cross3(Q1, Q2, Az1, Az2);
}

void alloc_ym_fluid(YMFluidPtrs& fl, size_t bytes) {
    CUDA_CHECK(cudaMalloc(&fl.n,       bytes)); CUDA_CHECK(cudaMemset(fl.n,       0, bytes));
    CUDA_CHECK(cudaMalloc(&fl.ux,      bytes)); CUDA_CHECK(cudaMemset(fl.ux,      0, bytes));
    CUDA_CHECK(cudaMalloc(&fl.uy,      bytes)); CUDA_CHECK(cudaMemset(fl.uy,      0, bytes));
    CUDA_CHECK(cudaMalloc(&fl.px,      bytes)); CUDA_CHECK(cudaMemset(fl.px,      0, bytes));
    CUDA_CHECK(cudaMalloc(&fl.pz,      bytes)); CUDA_CHECK(cudaMemset(fl.pz,      0, bytes));
    CUDA_CHECK(cudaMalloc(&fl.Q1,      bytes)); CUDA_CHECK(cudaMemset(fl.Q1,      0, bytes));
    CUDA_CHECK(cudaMalloc(&fl.Q2,      bytes)); CUDA_CHECK(cudaMemset(fl.Q2,      0, bytes));
    CUDA_CHECK(cudaMalloc(&fl.Q3,      bytes)); CUDA_CHECK(cudaMemset(fl.Q3,      0, bytes));
    CUDA_CHECK(cudaMalloc(&fl.E_therm, bytes)); CUDA_CHECK(cudaMemset(fl.E_therm, 0, bytes));
}

void alloc_ym_fields(YMFieldPtrs& f, size_t bytes) {
    auto alloc1 = [&](fct_real_t*& p) {
        CUDA_CHECK(cudaMalloc(&p, bytes)); CUDA_CHECK(cudaMemset(p, 0, bytes));
    };
    alloc1(f.Ex1); alloc1(f.Ex2); alloc1(f.Ex3);
    alloc1(f.Ez1); alloc1(f.Ez2); alloc1(f.Ez3);
    alloc1(f.By1); alloc1(f.By2); alloc1(f.By3);
    alloc1(f.Az1); alloc1(f.Az2); alloc1(f.Az3);
    alloc1(f.Jx1); alloc1(f.Jx2); alloc1(f.Jx3);
    alloc1(f.Jz1); alloc1(f.Jz2); alloc1(f.Jz3);
}

void copy_ym_fluid(YMFluidPtrs& dst, const YMFluidPtrs& src, size_t bytes) {
    cudaMemcpy(dst.n,  src.n,  bytes, cudaMemcpyDeviceToDevice);
    cudaMemcpy(dst.ux, src.ux, bytes, cudaMemcpyDeviceToDevice);
    cudaMemcpy(dst.uy, src.uy, bytes, cudaMemcpyDeviceToDevice);
    cudaMemcpy(dst.px, src.px, bytes, cudaMemcpyDeviceToDevice);
    cudaMemcpy(dst.pz, src.pz, bytes, cudaMemcpyDeviceToDevice);
    cudaMemcpy(dst.Q1, src.Q1, bytes, cudaMemcpyDeviceToDevice);
    cudaMemcpy(dst.Q2, src.Q2, bytes, cudaMemcpyDeviceToDevice);
    cudaMemcpy(dst.Q3, src.Q3, bytes, cudaMemcpyDeviceToDevice);
}
