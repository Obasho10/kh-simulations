import numpy as np
import matplotlib.pyplot as plt

# ==============================================================================
# PARAMETERS (Adjust these based on your specific physical system)
# ==============================================================================
alpha = 100     # Coupling/Shear parameter
v = 0.1        # Characteristic velocity
#n = 10             # Quantum/Mode number

kz_min = 0
kz_max = 30
num_points = 10000
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))
colors = ['royalblue', 'crimson', 'darkorange', 'forestgreen']

for n in range(4):
    # ==============================================================================
    # SOLVER
    # ==============================================================================
    kz_vals = np.linspace(kz_min, kz_max, num_points)
    omega_roots = np.zeros((num_points, 4), dtype=complex)

    # Calculate the constant coefficient factor
    C = (2 * n + 1) * np.sqrt((alpha**3) / 2.0) * v

    for i, kz in enumerate(kz_vals):
        # Polynomial coefficients: c_4*w^4 + c_3*w^3 + c_2*w^2 + c_1*w + c_0 = 0
        c4 = 1.0
        c3 = 0.0
        c2 = -kz**2
        c1 = -C
        c0 = -alpha**2 * v * kz

        coeffs = [c4, c3, c2, c1, c0]

        # Calculate roots
        roots = np.roots(coeffs)

        # Sort roots by Real part first to help track continuous branches
        # (np.sort_complex sorts by real part, then imaginary part)
        omega_roots[i, :] = np.sort_complex(roots)

    # ==============================================================================
    # PLOTTING
    # ==============================================================================
    
    # --- Plot 1: Real Frequency ---
    for j in range(4):
        # Using scatter instead of lines prevents false vertical lines where branches cross
        ax1.scatter(kz_vals, omega_roots[:, j].real, color=colors[j], s=2, label=f'Branch {j+1}')

    ax1.set_xlabel(r'Wavenumber $k_z$', fontsize=12)
    ax1.set_ylabel(r'Real Frequency $\omega_r$', fontsize=12)
    ax1.set_title('Dispersion Relation: Real Spectrum', fontsize=14, fontweight='bold')
    ax1.grid(True, linestyle=':', alpha=0.6)

    # --- Plot 2: Growth / Damping Rates ---
    for j in range(4):
        ax2.scatter(kz_vals, omega_roots[:, j].imag, color=colors[j], s=2, label=f'Branch {j+1}')

    # Highlight the gamma = 0 neutral stability line
    ax2.axhline(0, color='black', linewidth=1, linestyle='--')

    ax2.set_xlabel(r'Wavenumber $k_z$', fontsize=12)
    ax2.set_ylabel(r'Growth Rate $\gamma$ (Imag $\omega$)', fontsize=12)
    ax2.set_title('Instability Growth Rates', fontsize=14, fontweight='bold')
    ax2.grid(True, linestyle=':', alpha=0.6)

    # Create a clean legend
    handles, labels = ax1.get_legend_handles_labels()
    fig.legend(handles, labels, loc='upper center', ncol=4, fontsize=11, bbox_to_anchor=(0.5, 1.05))

    plt.tight_layout()
    #plt.savefig(f"dispersion_analytic_n{n}.png", dpi=300, bbox_inches='tight')
    print("Plot saved to dispersion_analytic_n{}.png".format(n))
plt.show()
