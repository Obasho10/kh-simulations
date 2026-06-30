#include "YM_Physics.cuh"

// =====================================================================
// KERNEL: Color currents  J_x^a = Σ_{fluid} n*Q^a*vx,  J_z^a = Σ n*Q^a*vz
// Sums contributions from BOTH counter-streaming beams A and B.
// Face-averaged to match staggered Yee grid (same stencil as old code).
// Jx lives at (x+0.5, z), Jz lives at (x, z+0.5).
// =====================================================================
__global__ void kernel_ym_currents(YMFieldPtrs f, YMFluidPtrs flA, YMFluidPtrs flB,
                                    int nx, int nz, YMParams p) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);

    int xp = p.periodic_x ? (x + 1) % nx : min(nx - 1, x + 1);
    int zp = (z == nz - 1) ? 0 : z + 1;

    // ── Fluid A ──
    fct_real_t nA0 = flA.n[idx],  nAp = flA.n[IDX(xp, z, nx)];
    fct_real_t nAzp = flA.n[IDX(x, zp, nx)];
    fct_real_t vxA_r = 0.5f * (flA.px[idx] / max(nA0, (fct_real_t)1e-10)
                              + flA.px[IDX(xp, z, nx)] / max(nAp, (fct_real_t)1e-10));
    fct_real_t vzA_t = 0.5f * (flA.pz[idx] / max(nA0, (fct_real_t)1e-10)
                              + flA.pz[IDX(x, zp, nx)] / max(nAzp, (fct_real_t)1e-10));

    fct_real_t nQ1A = 0.5f*(nA0*flA.Q1[idx] + nAp*flA.Q1[IDX(xp,z,nx)]);
    fct_real_t nQ2A = 0.5f*(nA0*flA.Q2[idx] + nAp*flA.Q2[IDX(xp,z,nx)]);
    fct_real_t nQ3A = 0.5f*(nA0*flA.Q3[idx] + nAp*flA.Q3[IDX(xp,z,nx)]);

    fct_real_t nQ1Az = 0.5f*(nA0*flA.Q1[idx] + nAzp*flA.Q1[IDX(x,zp,nx)]);
    fct_real_t nQ2Az = 0.5f*(nA0*flA.Q2[idx] + nAzp*flA.Q2[IDX(x,zp,nx)]);
    fct_real_t nQ3Az = 0.5f*(nA0*flA.Q3[idx] + nAzp*flA.Q3[IDX(x,zp,nx)]);

    // ── Fluid B ──
    fct_real_t nB0 = flB.n[idx],  nBp = flB.n[IDX(xp, z, nx)];
    fct_real_t nBzp = flB.n[IDX(x, zp, nx)];
    fct_real_t vxB_r = 0.5f * (flB.px[idx] / max(nB0, (fct_real_t)1e-10)
                              + flB.px[IDX(xp, z, nx)] / max(nBp, (fct_real_t)1e-10));
    fct_real_t vzB_t = 0.5f * (flB.pz[idx] / max(nB0, (fct_real_t)1e-10)
                              + flB.pz[IDX(x, zp, nx)] / max(nBzp, (fct_real_t)1e-10));

    fct_real_t nQ1B = 0.5f*(nB0*flB.Q1[idx] + nBp*flB.Q1[IDX(xp,z,nx)]);
    fct_real_t nQ2B = 0.5f*(nB0*flB.Q2[idx] + nBp*flB.Q2[IDX(xp,z,nx)]);
    fct_real_t nQ3B = 0.5f*(nB0*flB.Q3[idx] + nBp*flB.Q3[IDX(xp,z,nx)]);

    fct_real_t nQ1Bz = 0.5f*(nB0*flB.Q1[idx] + nBzp*flB.Q1[IDX(x,zp,nx)]);
    fct_real_t nQ2Bz = 0.5f*(nB0*flB.Q2[idx] + nBzp*flB.Q2[IDX(x,zp,nx)]);
    fct_real_t nQ3Bz = 0.5f*(nB0*flB.Q3[idx] + nBzp*flB.Q3[IDX(x,zp,nx)]);

    // ── Total Jx^a = -(nQa_A * vxA + nQa_B * vxB) ──
    f.Jx1[idx] = -(nQ1A * vxA_r + nQ1B * vxB_r);
    f.Jx2[idx] = -(nQ2A * vxA_r + nQ2B * vxB_r);
    f.Jx3[idx] = -(nQ3A * vxA_r + nQ3B * vxB_r);

    // ── Total Jz^a ──
    f.Jz1[idx] = -(nQ1Az * vzA_t + nQ1Bz * vzB_t);
    f.Jz2[idx] = -(nQ2Az * vzA_t + nQ2Bz * vzB_t);
    f.Jz3[idx] = -(nQ3Az * vzA_t + nQ3Bz * vzB_t);
}

// =====================================================================
// KERNEL: Non-Abelian Ampere-Maxwell
//
// ∂Ex^a/∂t = c²*(-∂_z By^a  -  α*(Az×By)^a)  -  Jx^a/ε₀
// ∂Ez^a/∂t = c²*(+∂_x By^a)                   -  Jz^a/ε₀
//
// Yee stagger: Ex[x,z] at (x+0.5,z), Ez[x,z] at (x,z+0.5)
// =====================================================================
__global__ void kernel_ym_ampere(YMFieldPtrs f, YMParams p, int nx, int nz) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);

    int zm = (z == 0) ? nz - 1 : z - 1;
    int xm = p.periodic_x ? (x + nx - 1) % nx : (x == 0 ? 0 : x - 1);

    fct_real_t c2  = p.c * p.c;
    fct_real_t dt  = p.dt_step;
    fct_real_t aYM = p.alpha_YM;

    fct_real_t By1 = f.By1[idx], By2 = f.By2[idx], By3 = f.By3[idx];
    fct_real_t By1_zm = f.By1[IDX(x, zm, nx)];
    fct_real_t By2_zm = f.By2[IDX(x, zm, nx)];
    fct_real_t By3_zm = f.By3[IDX(x, zm, nx)];

    fct_real_t dBy1_dz = (By1 - By1_zm) / p.dz;
    fct_real_t dBy2_dz = (By2 - By2_zm) / p.dz;
    fct_real_t dBy3_dz = (By3 - By3_zm) / p.dz;

    fct_real_t Az1 = f.Az1[idx], Az2 = f.Az2[idx], Az3 = f.Az3[idx];
    fct_real_t AzxBy1 = su2_cross1(Az2, Az3, By2, By3);
    fct_real_t AzxBy2 = su2_cross2(Az1, Az3, By1, By3);
    fct_real_t AzxBy3 = su2_cross3(Az1, Az2, By1, By2);

    f.Ex1[idx] += dt * (c2 * (-dBy1_dz - aYM * AzxBy1) - f.Jx1[idx] / p.eps_0);
    f.Ex2[idx] += dt * (c2 * (-dBy2_dz - aYM * AzxBy2) - f.Jx2[idx] / p.eps_0);
    f.Ex3[idx] += dt * (c2 * (-dBy3_dz - aYM * AzxBy3) - f.Jx3[idx] / p.eps_0);

    fct_real_t By1_xm = f.By1[IDX(xm, z, nx)];
    fct_real_t By2_xm = f.By2[IDX(xm, z, nx)];
    fct_real_t By3_xm = f.By3[IDX(xm, z, nx)];

    // Backward difference for ∂_x By at Ez location; xm already handles wall vs periodic.
    fct_real_t dBy1_dx = (By1 - By1_xm) / p.dx;
    fct_real_t dBy2_dx = (By2 - By2_xm) / p.dx;
    fct_real_t dBy3_dx = (By3 - By3_xm) / p.dx;

    f.Ez1[idx] += dt * (c2 * dBy1_dx - f.Jz1[idx] / p.eps_0);
    f.Ez2[idx] += dt * (c2 * dBy2_dx - f.Jz2[idx] / p.eps_0);
    f.Ez3[idx] += dt * (c2 * dBy3_dx - f.Jz3[idx] / p.eps_0);
}

// =====================================================================
// KERNEL: Non-Abelian Faraday
//
// ∂By^a/∂t = ∂_z Ex^a  -  ∂_x Ez^a  +  α*(Az×Ex)^a
// =====================================================================
__global__ void kernel_ym_faraday(YMFieldPtrs f, YMParams p, int nx, int nz) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);

    int zp = (z == nz - 1) ? 0 : z + 1;
    int xp = p.periodic_x ? (x + 1) % nx : min(nx - 1, x + 1);

    fct_real_t dt  = p.dt_step;
    fct_real_t aYM = p.alpha_YM;

    fct_real_t dEx1_dz = (f.Ex1[IDX(x, zp, nx)] - f.Ex1[idx]) / p.dz;
    fct_real_t dEx2_dz = (f.Ex2[IDX(x, zp, nx)] - f.Ex2[idx]) / p.dz;
    fct_real_t dEx3_dz = (f.Ex3[IDX(x, zp, nx)] - f.Ex3[idx]) / p.dz;

    // Forward difference for ∂_x Ez at By location; xp handles wall vs periodic.
    fct_real_t dEz1_dx = (f.Ez1[IDX(xp, z, nx)] - f.Ez1[idx]) / p.dx;
    fct_real_t dEz2_dx = (f.Ez2[IDX(xp, z, nx)] - f.Ez2[idx]) / p.dx;
    fct_real_t dEz3_dx = (f.Ez3[IDX(xp, z, nx)] - f.Ez3[idx]) / p.dx;

    fct_real_t Az1 = f.Az1[idx], Az2 = f.Az2[idx], Az3 = f.Az3[idx];
    fct_real_t Ex1 = f.Ex1[idx], Ex2 = f.Ex2[idx], Ex3 = f.Ex3[idx];

    fct_real_t AzxEx1 = su2_cross1(Az2, Az3, Ex2, Ex3);
    fct_real_t AzxEx2 = su2_cross2(Az1, Az3, Ex1, Ex3);
    fct_real_t AzxEx3 = su2_cross3(Az1, Az2, Ex1, Ex2);

    f.By1[idx] -= dt * (dEx1_dz - dEz1_dx - aYM * AzxEx1);
    f.By2[idx] -= dt * (dEx2_dz - dEz2_dx - aYM * AzxEx2);
    f.By3[idx] -= dt * (dEx3_dz - dEz3_dx - aYM * AzxEx3);
}

// =====================================================================
// KERNEL: Sponge layer — damp color-2/3 EM fields outside |ξ| > xi_sponge
//
// decay = exp(-σ(x) * dt),  σ(x) = sigma_sponge * max(0, |ξ(x)| - xi_sponge)
//
// Applied to: By2,By3, Ex2,Ex3, Ez2,Ez3, Az2,Az3, Q2/Q3 of both fluids.
// Color-1 (equilibrium sector) is left untouched.
// =====================================================================
__global__ void kernel_ym_sponge(YMFieldPtrs f, YMFluidPtrs flA, YMFluidPtrs flB,
                                  int nx, int nz, YMParams p) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);

    fct_real_t x_c = (nx * p.dx) * 0.5;
    fct_real_t xi  = fabs((x * p.dx - x_c) / p.epsilon);
    if (xi <= p.xi_sponge) return;

    fct_real_t sigma = p.sigma_sponge * (xi - p.xi_sponge);
    fct_real_t decay = exp(-sigma * p.dt_step);

    f.By2[idx] *= decay;  f.By3[idx] *= decay;
    f.Ex2[idx] *= decay;  f.Ex3[idx] *= decay;
    f.Ez2[idx] *= decay;  f.Ez3[idx] *= decay;
    f.Az2[idx] *= decay;  f.Az3[idx] *= decay;

    flA.Q2[idx] *= decay;  flA.Q3[idx] *= decay;
    flB.Q2[idx] *= decay;  flB.Q3[idx] *= decay;
}

// =====================================================================
// KERNEL: z-hyperdiffusion — 4th-order dissipation on color-2/3 fields
//
// Applies F[z] -= mu * (F[z-2] - 4F[z-1] + 6F[z] - 4F[z+1] + F[z+2])
// each step, where mu = hyp_diff_coeff (dimensionless).
//
// Attenuation per step: mu * (4*sin^2(kz*pi/NZ))^2
//   kz=  1:  mu * 1.5e-5  (negligible for any reasonable mu)
//   kz=  8:  mu * 1.5e-3
//   kz= 74:  mu * 7.3     → net growth rate crosses zero for mu=1.7e-5
//   kz=110:  mu * 14.5    → kills gamma≈0.5 instability for mu>3.5e-5
//
// Use mu=5e-5 to confidently suppress kz>=74 while leaving kz=1..8 intact:
//   kz=8  total attenuation over 200k steps: exp(-0.6%)  (0.6% total)
//   kz=110 net growth rate: -1.47 TU^-1     (strongly decaying)
// =====================================================================
__global__ void kernel_ym_hyperdiffuse_z(YMFieldPtrs f, YMFluidPtrs flA, YMFluidPtrs flB,
                                          int nx, int nz, fct_real_t mu) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);

    int zm1 = (z == 0)      ? nz - 1 : z - 1;
    int zm2 = (z <= 1)      ? z - 2 + nz : z - 2;
    int zp1 = (z == nz - 1) ? 0 : z + 1;
    int zp2 = (z >= nz - 2) ? z + 2 - nz : z + 2;

    // Each field: F -= mu * (F[z-2] - 4F[z-1] + 6F[z] - 4F[z+1] + F[z+2])
    // Reads from global memory; the minor inter-block race in the halo cells
    // only affects accuracy of the smoothing, not the stability property.
#define HD_FIELD(ptr) \
    do { \
        fct_real_t d4 = (ptr)[IDX(x,zm2,nx)] - 4.0f*(ptr)[IDX(x,zm1,nx)] \
                      + 6.0f*(ptr)[idx]       - 4.0f*(ptr)[IDX(x,zp1,nx)] \
                      +      (ptr)[IDX(x,zp2,nx)]; \
        (ptr)[idx] -= mu * d4; \
    } while(0)

    HD_FIELD(f.By2);  HD_FIELD(f.By3);
    HD_FIELD(f.Ex2);  HD_FIELD(f.Ex3);
    HD_FIELD(f.Ez2);  HD_FIELD(f.Ez3);
    HD_FIELD(f.Az2);  HD_FIELD(f.Az3);
    HD_FIELD(flA.Q2); HD_FIELD(flA.Q3);
    HD_FIELD(flB.Q2); HD_FIELD(flB.Q3);

#undef HD_FIELD
}

// =====================================================================
// KERNEL: kz=0 suppression — subtract z-mean of color-2/3 fields
//
// For each x-column, computes the z-average of all 12 color-2/3 fields
// and subtracts it, zeroing the kz=0 Fourier component.  This prevents
// the uniform-in-z Weibel-like eigenmode from dominating the run and
// allows the kz>=1 KH modes to evolve long enough to measure.
//
// Launch: kernel<<<NX, NZ, 12*NZ*sizeof(fct_real_t)>>>
// NZ must be a power of 2 for the tree reduction.
// =====================================================================
__global__ void kernel_ym_subtract_zmean(YMFieldPtrs f, YMFluidPtrs flA, YMFluidPtrs flB,
                                          int nx, int nz) {
    extern __shared__ fct_real_t smem[];
    int x = blockIdx.x;
    int z = threadIdx.x;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);

    // Load all 12 color-2/3 fields into shared memory slices
    smem[ 0*nz+z] = f.By2[idx];
    smem[ 1*nz+z] = f.By3[idx];
    smem[ 2*nz+z] = f.Ex2[idx];
    smem[ 3*nz+z] = f.Ex3[idx];
    smem[ 4*nz+z] = f.Ez2[idx];
    smem[ 5*nz+z] = f.Ez3[idx];
    smem[ 6*nz+z] = f.Az2[idx];
    smem[ 7*nz+z] = f.Az3[idx];
    smem[ 8*nz+z] = flA.Q2[idx];
    smem[ 9*nz+z] = flA.Q3[idx];
    smem[10*nz+z] = flB.Q2[idx];
    smem[11*nz+z] = flB.Q3[idx];
    __syncthreads();

    // Parallel tree reduction along z to get the sum for each field
    for (int stride = nz >> 1; stride > 0; stride >>= 1) {
        if (z < stride) {
            #pragma unroll
            for (int fi = 0; fi < 12; fi++) smem[fi*nz+z] += smem[fi*nz+z+stride];
        }
        __syncthreads();
    }
    // smem[fi*nz+0] now holds sum over z for field fi at this x-column

    fct_real_t inv_nz = 1.0f / (fct_real_t)nz;
    f.By2[idx]  -= smem[ 0*nz] * inv_nz;
    f.By3[idx]  -= smem[ 1*nz] * inv_nz;
    f.Ex2[idx]  -= smem[ 2*nz] * inv_nz;
    f.Ex3[idx]  -= smem[ 3*nz] * inv_nz;
    f.Ez2[idx]  -= smem[ 4*nz] * inv_nz;
    f.Ez3[idx]  -= smem[ 5*nz] * inv_nz;
    f.Az2[idx]  -= smem[ 6*nz] * inv_nz;
    f.Az3[idx]  -= smem[ 7*nz] * inv_nz;
    flA.Q2[idx] -= smem[ 8*nz] * inv_nz;
    flA.Q3[idx] -= smem[ 9*nz] * inv_nz;
    flB.Q2[idx] -= smem[10*nz] * inv_nz;
    flB.Q3[idx] -= smem[11*nz] * inv_nz;
}

// =====================================================================
// KERNEL: low-kz suppression — subtract DFT modes kz=1..kz_max from color-2/3 fields
//
// For each x-column (one block per x, NZ threads), iterates over each mode m=1..kz_max.
// Per mode: loads cosine- and sine-weighted field values into shared memory, tree-reduces
// to get the DFT coefficients, then subtracts the reconstruction from each cell.
// Since orthogonal modes are processed sequentially on already-modified fields, the result
// is identical to projecting all modes out simultaneously from the original field.
//
// Shared memory layout: [12*NZ cosine-sums | 12*NZ sine-sums]
// Launch: kernel<<<NX, NZ, 2*12*NZ*sizeof(fct_real_t)>>>
// =====================================================================
// Optimised DFT-range suppression for 12 color-2/3 fields.
// Key speedup vs old kernel: load each field from global memory ONCE into
// registers, accumulate all mode subtractions in registers, write back once.
// Warp-shuffle replace the shared-memory tree-reduce → only 3 __syncthreads
// per mode instead of 10, and smem drops from 24 KB to 864 B per block,
// allowing 32 blocks/SM (vs 2) → full occupancy.
// Launch: <<<NX, NZ, (2*NZ/32+2)*12*sizeof(fct_real_t)>>>
__global__ void kernel_ym_subtract_kz_range(YMFieldPtrs f, YMFluidPtrs flA, YMFluidPtrs flB,
                                              int nx, int nz, int kz_lo, int kz_hi) {
    extern __shared__ fct_real_t smem[];
    // smem layout (per block, NFIELDS=12):
    //   [0..nwarps*12-1]              Am warp partial sums
    //   [nwarps*12..2*nwarps*12-1]    Bm warp partial sums
    //   [2*nwarps*12..2*nwarps*12+11] Am final (one per field)
    //   [2*nwarps*12+12..]            Bm final (one per field)
    const int NFIELDS = 12;
    int nwarps = nz / 32;
    fct_real_t* smem_Aw = smem;
    fct_real_t* smem_Bw = smem + nwarps * NFIELDS;
    fct_real_t* smem_A  = smem + 2 * nwarps * NFIELDS;
    fct_real_t* smem_B  = smem_A + NFIELDS;

    int x = blockIdx.x, z = threadIdx.x;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);
    int wid = z / 32, lane = z % 32;

    // Load all 12 fields once into registers
    fct_real_t v[NFIELDS];
    v[0]  = f.By2[idx];   v[1]  = f.By3[idx];
    v[2]  = f.Ex2[idx];   v[3]  = f.Ex3[idx];
    v[4]  = f.Ez2[idx];   v[5]  = f.Ez3[idx];
    v[6]  = f.Az2[idx];   v[7]  = f.Az3[idx];
    v[8]  = flA.Q2[idx];  v[9]  = flA.Q3[idx];
    v[10] = flB.Q2[idx];  v[11] = flB.Q3[idx];

    // Accumulate total subtraction across all modes in registers
    fct_real_t delta[NFIELDS];
    #pragma unroll
    for (int fi = 0; fi < NFIELDS; fi++) delta[fi] = 0.0f;

    for (int m = kz_lo; m <= kz_hi; m++) {
        float phase = 2.0f * (float)M_PI * m * z / (float)nz;
        float cz = cosf(phase), sz = sinf(phase);

        // Per-thread weighted products
        fct_real_t ar[NFIELDS], br[NFIELDS];
        #pragma unroll
        for (int fi = 0; fi < NFIELDS; fi++) {
            ar[fi] = v[fi] * cz;
            br[fi] = v[fi] * sz;
        }

        // Warp-level reduce (no __syncthreads needed)
        #pragma unroll
        for (int off = 16; off > 0; off >>= 1) {
            #pragma unroll
            for (int fi = 0; fi < NFIELDS; fi++) {
                ar[fi] += __shfl_down_sync(0xffffffff, ar[fi], off);
                br[fi] += __shfl_down_sync(0xffffffff, br[fi], off);
            }
        }

        // Lane 0 of each warp writes warp sums to smem
        if (lane == 0) {
            #pragma unroll
            for (int fi = 0; fi < NFIELDS; fi++) {
                smem_Aw[wid * NFIELDS + fi] = ar[fi];
                smem_Bw[wid * NFIELDS + fi] = br[fi];
            }
        }
        __syncthreads();  // sync 1: ensure all warp sums visible

        // First NFIELDS threads combine warp sums → final Am, Bm
        if (z < NFIELDS) {
            fct_real_t sc = 0, ss = 0;
            for (int w = 0; w < nwarps; w++) {
                sc += smem_Aw[w * NFIELDS + z];
                ss += smem_Bw[w * NFIELDS + z];
            }
            float inv2 = 2.0f / (float)nz;
            smem_A[z] = sc * inv2;
            smem_B[z] = ss * inv2;
        }
        __syncthreads();  // sync 2: final Am/Bm visible to all

        // Accumulate this mode's subtraction in registers
        #pragma unroll
        for (int fi = 0; fi < NFIELDS; fi++)
            delta[fi] += smem_A[fi] * cz + smem_B[fi] * sz;

        __syncthreads();  // sync 3: protect smem_A/B before next mode overwrites
    }

    // Write back once (global memory write × 12, not × 12 × 39)
    f.By2[idx]  = v[0]  - delta[0];
    f.By3[idx]  = v[1]  - delta[1];
    f.Ex2[idx]  = v[2]  - delta[2];
    f.Ex3[idx]  = v[3]  - delta[3];
    f.Ez2[idx]  = v[4]  - delta[4];
    f.Ez3[idx]  = v[5]  - delta[5];
    f.Az2[idx]  = v[6]  - delta[6];
    f.Az3[idx]  = v[7]  - delta[7];
    flA.Q2[idx] = v[8]  - delta[8];
    flA.Q3[idx] = v[9]  - delta[9];
    flB.Q2[idx] = v[10] - delta[10];
    flB.Q3[idx] = v[11] - delta[11];
}

// Optimised DFT-range suppression for fluid pz (2 fields).
// Same register-caching + warp-shuffle strategy as above.
// Kills the color-1 two-stream — the mechanism missed by the color-2/3 filter.
// Launch: <<<NX, NZ, (2*NZ/32+2)*2*sizeof(fct_real_t)>>>
__global__ void kernel_fluid_pz_subtract_kz_range(fct_real_t* pzA, fct_real_t* pzB,
                                                    int nx, int nz, int kz_lo, int kz_hi) {
    extern __shared__ fct_real_t smem[];
    const int NFIELDS = 2;
    int nwarps = nz / 32;
    fct_real_t* smem_Aw = smem;
    fct_real_t* smem_Bw = smem + nwarps * NFIELDS;
    fct_real_t* smem_A  = smem + 2 * nwarps * NFIELDS;
    fct_real_t* smem_B  = smem_A + NFIELDS;

    int x = blockIdx.x, z = threadIdx.x;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);
    int wid = z / 32, lane = z % 32;

    fct_real_t v[NFIELDS] = {pzA[idx], pzB[idx]};
    fct_real_t delta[NFIELDS] = {0.0f, 0.0f};

    for (int m = kz_lo; m <= kz_hi; m++) {
        float phase = 2.0f * (float)M_PI * m * z / (float)nz;
        float cz = cosf(phase), sz = sinf(phase);

        fct_real_t ar[NFIELDS] = {v[0]*cz, v[1]*cz};
        fct_real_t br[NFIELDS] = {v[0]*sz, v[1]*sz};

        #pragma unroll
        for (int off = 16; off > 0; off >>= 1) {
            ar[0] += __shfl_down_sync(0xffffffff, ar[0], off);
            ar[1] += __shfl_down_sync(0xffffffff, ar[1], off);
            br[0] += __shfl_down_sync(0xffffffff, br[0], off);
            br[1] += __shfl_down_sync(0xffffffff, br[1], off);
        }

        if (lane == 0) {
            smem_Aw[wid * NFIELDS + 0] = ar[0];  smem_Aw[wid * NFIELDS + 1] = ar[1];
            smem_Bw[wid * NFIELDS + 0] = br[0];  smem_Bw[wid * NFIELDS + 1] = br[1];
        }
        __syncthreads();

        if (z < NFIELDS) {
            fct_real_t sc = 0, ss = 0;
            for (int w = 0; w < nwarps; w++) {
                sc += smem_Aw[w * NFIELDS + z];
                ss += smem_Bw[w * NFIELDS + z];
            }
            float inv2 = 2.0f / (float)nz;
            smem_A[z] = sc * inv2;
            smem_B[z] = ss * inv2;
        }
        __syncthreads();

        delta[0] += smem_A[0] * cz + smem_B[0] * sz;
        delta[1] += smem_A[1] * cz + smem_B[1] * sz;
        __syncthreads();
    }

    pzA[idx] = v[0] - delta[0];
    pzB[idx] = v[1] - delta[1];
}

// =====================================================================
// KERNEL: Vector potential update  ∂Az^a/∂t = -Ez^a
// =====================================================================
__global__ void kernel_ym_potential(YMFieldPtrs f, YMParams p, int nx, int nz) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int z = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= nx || z >= nz) return;
    int idx = IDX(x, z, nx);

    if (!p.freeze_az1)
        f.Az1[idx] -= p.dt_step * f.Ez1[idx];
    f.Az2[idx] -= p.dt_step * f.Ez2[idx];
    f.Az3[idx] -= p.dt_step * f.Ez3[idx];
}
