#ifndef EMHD_PHYSICS_CUH
#define EMHD_PHYSICS_CUH

#include "FCT_Kernels.cuh" // We keep this strictly to inherit fct_real_t and the IDX macro

// =====================================================================
// 1. PHYSICAL CONSTANTS & NORMALIZATION
// =====================================================================
struct GaugeParams {
    fct_real_t dx;
    fct_real_t dz;      // Z replaces Y in our 2D slab coordinates
    fct_real_t dt_step;
    
    // Vacuum parameters
    fct_real_t c;       // Speed of light (Enforces the CFL limit)
    fct_real_t mu_0;    // Vacuum permeability
    fct_real_t eps_0;   // Vacuum permittivity
    
    // Yang-Mills coupling constant (Set to 0.0 for pure Maxwell validation)
    fct_real_t g;       
};

// =====================================================================
// 2. LATTICE GAUGE FIELD POINTERS
// =====================================================================
// In Lattice Gauge Theory, the exact spatial placement of variables 
// is required to preserve the Gauss constraint (div E = rho).
struct GaugeFieldPtrs {

    // -------------------------------------------------------------
    // VECTOR POTENTIAL (A) - Lives on Cell Edges
    // -------------------------------------------------------------
    fct_real_t* Ax;     // X-Edges (i+0.5, k)
    fct_real_t* Ay;     // Nodes    (i, k)       - Out of plane
    fct_real_t* Az;     // Z-Edges  (i, k+0.5)

    // -------------------------------------------------------------
    // ELECTRIC FIELD (E) - Lives on Cell Edges
    // -------------------------------------------------------------
    fct_real_t* Ex;     // X-Edges (i+0.5, k)
    fct_real_t* Ey;     // Nodes   (i, k)        - Out of plane
    fct_real_t* Ez;     // Z-Edges (i, k+0.5)

    // -------------------------------------------------------------
    // MAGNETIC FIELD (B) - Lives on Cell Faces
    // -------------------------------------------------------------
    fct_real_t* Bx;     // X-Faces    (i, k+0.5)
    fct_real_t* By;     // Cell Center(i+0.5, k+0.5) - Out of plane
    fct_real_t* Bz;     // Z-Faces    (i+0.5, k)

    // -------------------------------------------------------------
    // MATTER CURRENTS (J) - Lives on Cell Edges
    // -------------------------------------------------------------
    // In the future, your CPIC particles or FCT sweeps will deposit 
    // their color charges here to act as sources for the gauge fields.
    fct_real_t* Jx;     
    fct_real_t* Jy;     
    fct_real_t* Jz;     
};

// =====================================================================
// 3. MAXWELL/YANG-MILLS KERNEL SIGNATURES
// =====================================================================
namespace Gauge {

    /**
     * @brief Ampere-Maxwell Step: dE/dt = c^2 * curl(B) - J/eps_0
     * Solves the wave propagation of the electric field.
     * When upgraded to Yang-Mills, the (A cross B) self-interaction is added here.
     */
    void step_ampere_maxwell(
        GaugeFieldPtrs d_fields, 
        GaugeParams params, 
        int nx, int nz
    );

    /**
     * @brief Vector Potential Step: dA/dt = -E
     * Integrates the gauge potential. Strictly required for the non-Abelian
     * covariant derivatives in the Yang-Mills upgrade.
     */
    void step_vector_potential(
        GaugeFieldPtrs d_fields, 
        GaugeParams params, 
        int nx, int nz
    );

    /**
     * @brief Faraday Step: dB/dt = -curl(E)
     * Solves the wave propagation of the magnetic field.
     * Inherently preserves div(B) = 0 due to staggered Yee grid exactness.
     * When upgraded to Yang-Mills, the (A cross E) self-interaction is added here.
     */
    void step_faraday(
        GaugeFieldPtrs d_fields, 
        GaugeParams params, 
        int nx, int nz
    );

} // namespace Gauge

#endif // EMHD_PHYSICS_CUH
