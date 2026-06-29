#ifndef FCT_DEVICE_MATH_CUH
#define FCT_DEVICE_MATH_CUH

#include <cmath>

// =====================================================================
// BASE TYPES & GRID STRUCTS (defined here to break circular include)
// =====================================================================

typedef double fct_real_t;

#define IDX(x, z, nx) ((x) + (z) * (nx))

struct GridParams {
    int nx, ny;
    fct_real_t dx, dy;
};

struct FluidDevicePtrs {
    fct_real_t* n;
    fct_real_t* ux;
    fct_real_t* uy;
    fct_real_t* px;
    fct_real_t* py;
    fct_real_t* pz;
    fct_real_t* E_therm;
};

// =====================================================================
// 1. KINEMATICS & TRANSPORT COEFFICIENTS
// =====================================================================

/**
 * @brief Computes the Courant-limited phase velocity at the cell interface.
 * Replaces the heavy velocity() function from TransportAndBoundaries.cpp.
 * Since the grid is Cartesian (alpha=1), the volume/area ratios cancel out.
 */
__device__ __forceinline__ fct_real_t compute_eps(
    fct_real_t u_left, 
    fct_real_t u_right, 
    fct_real_t dt_step, 
    fct_real_t dx) 
{
    fct_real_t v_interface = 0.5 * (u_left + u_right);
    return v_interface * (dt_step / dx);
}

/**
 * @brief Calculates the Diffusion (nu) and Anti-Diffusion (mu) coefficients.
 * This perfectly mirrors the classical LCPFCT phase-error minimization logic.
 */
__device__ __forceinline__ void compute_nu_mu(
    fct_real_t eps, 
    fct_real_t& nu, 
    fct_real_t& mu) 
{
    // FIX: Using fabs() prevents silent cast to integer 0 for Courant fractions
    fct_real_t scrh = min(1.0 / 6.0, fabs(eps));
    scrh = (1.0 / 3.0) * scrh * scrh;
    
    nu = (1.0 / 6.0) + (1.0 / 3.0) * (eps * eps - scrh * scrh);
    mu = 0.25 - 0.5 * nu;
}

// =====================================================================
// 2. THE LOW-ORDER (DIFFUSIVE) SWEEP
// =====================================================================

/**
 * @brief Computes the transported and diffused low-order solution (LNRHOT).
 * @param rho_m1 Density at i-1
 * @param rho_0  Density at i
 * @param rho_p1 Density at i+1
 * @param eps_left  Courant fraction at interface (i-1/2)
 * @param eps_right Courant fraction at interface (i+1/2)
 * @param nu_left   Diffusion at interface (i-1/2)
 * @param nu_right  Diffusion at interface (i+1/2)
 */
__device__ __forceinline__ fct_real_t compute_low_order_rho(
    fct_real_t rho_m1, fct_real_t rho_0, fct_real_t rho_p1,
    fct_real_t eps_left, fct_real_t eps_right,
    fct_real_t nu_left, fct_real_t nu_right,
    fct_real_t source_0) // <--- NEW: Injecting the Euler source
{
    fct_real_t flx_left  = 0.5 * eps_left  * (rho_m1 + rho_0);
    fct_real_t flx_right = 0.5 * eps_right * (rho_0  + rho_p1);

    fct_real_t diff_left  = nu_left  * (rho_0  - rho_m1);
    fct_real_t diff_right = nu_right * (rho_p1 - rho_0);

    // LNRHOT: Transported, Sourced, and Diffused low-order solution
    return rho_0 + source_0 - (flx_right - flx_left) + (diff_right - diff_left);
}

// =====================================================================
// 3. THE HIGH-ORDER (ANTI-DIFFUSIVE) LIMITER
// =====================================================================

/**
 * @brief The heart of the FCT algorithm. The Boris-Book/Zalesak limiter.
 * This prevents the anti-diffusive flux from creating new extrema or 
 * exacerbating existing ones, preserving positivity and suppressing shocks.
 * * @param flx_ad The raw anti-diffusive flux (mu * (rho_td_0 - rho_td_m1))
 * @param diff_m1 The difference (rho_td_m1 - rho_td_m2)
 * @param diff_0  The difference (rho_td_0  - rho_td_m1)
 * @param diff_p1 The difference (rho_td_p1 - rho_td_0)
 */
__device__ __forceinline__ fct_real_t apply_fct_limiter(
    fct_real_t flx_ad, 
    fct_real_t diff_m1, 
    fct_real_t diff_0, 
    fct_real_t diff_p1) 
{
    fct_real_t fsgn = copysign(1.0, diff_0);
    
    // Determine the maximum allowable flux before creating an overshoot
    fct_real_t term  = fsgn * diff_m1;
    fct_real_t terp  = fsgn * diff_p1;
    fct_real_t flx_abs = fabs(flx_ad);

    // The legendary triple-min limiter
    fct_real_t flx_limited = max(0.0, min(term, min(flx_abs, terp)));
    
    return fsgn * flx_limited;
}

// =====================================================================
// 4. ENERGY CONSERVATION FIX (YOUR THERMAL TRACKER)
// =====================================================================

/**
 * @brief Calculates the numerical kinetic energy lost to FCT diffusion.
 * You explicitly tracked this on the CPU to close the energy budget. 
 * Doing this entirely in registers saves a global memory read.
 */
__device__ __forceinline__ fct_real_t compute_dissipated_energy(
    fct_real_t n_old, fct_real_t ul_old, fct_real_t ut_old,
    fct_real_t n_new, fct_real_t ul_new, fct_real_t ut_new)
{
    fct_real_t safe_n_old = max(n_old, 1e-15);
    fct_real_t ke_expected = 0.5 * (ul_old * ul_old + ut_old * ut_old) / safe_n_old;

    fct_real_t safe_n_new = max(n_new, 1e-15);
    fct_real_t ke_actual = 0.5 * (ul_new * ul_new + ut_new * ut_new) / safe_n_new;

    fct_real_t ke_dissipated = ke_expected - ke_actual;
    
    return max(0.0, ke_dissipated); // Ensure we only track strictly dissipated heat
}

#endif // FCT_DEVICE_MATH_CUH
