#include "YM_Energy.cuh"

__global__ void kernel_ym_energy(YMFieldPtrs f, YMFluidPtrs flA, YMFluidPtrs flB,
                                  fct_real_t* d_out, int nx, int nz) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);

    fct_real_t nA = max(flA.n[idx], (fct_real_t)1e-10);
    fct_real_t nB = max(flB.n[idx], (fct_real_t)1e-10);
    fct_real_t keA = 0.5*(flA.px[idx]*flA.px[idx] + flA.pz[idx]*flA.pz[idx]) / nA;
    fct_real_t keB = 0.5*(flB.px[idx]*flB.px[idx] + flB.pz[idx]*flB.pz[idx]) / nB;

    fct_real_t em = 0.5*(
        f.Ex1[idx]*f.Ex1[idx] + f.Ex2[idx]*f.Ex2[idx] + f.Ex3[idx]*f.Ex3[idx] +
        f.Ez1[idx]*f.Ez1[idx] + f.Ez2[idx]*f.Ez2[idx] + f.Ez3[idx]*f.Ez3[idx] +
        f.By1[idx]*f.By1[idx] + f.By2[idx]*f.By2[idx] + f.By3[idx]*f.By3[idx]);

    d_out[idx] = keA + keB + em;
}

double compute_ym_energy(YMFieldPtrs& d_f, YMFluidPtrs& d_flA, YMFluidPtrs& d_flB,
                          fct_real_t* d_ebuf, std::vector<fct_real_t>& h_ebuf,
                          int nx, int nz, dim3 blocks, dim3 threads) {
    kernel_ym_energy<<<blocks, threads>>>(d_f, d_flA, d_flB, d_ebuf, nx, nz);
    cudaDeviceSynchronize();
    CUDA_CHECK(cudaMemcpy(h_ebuf.data(), d_ebuf, nx*nz*sizeof(fct_real_t), cudaMemcpyDeviceToHost));
    double total = 0.0;
    for (fct_real_t v : h_ebuf) total += (double)v;
    return total;
}
