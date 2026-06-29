import numpy as np
import matplotlib.pyplot as plt

# Physical parameters
alpha = 5.0
v = 0.1

# kz_cutoff: WKB modes only exist below this (n_max >= 0 condition)
#   n_max = 0.5 * (sqrt(2)*alpha^2.5 / (v^2 * kz^3) - 1) >= 0
kz_cutoff = (np.sqrt(2) * alpha**2.5 / v**2) ** (1.0/3.0)
print(f"alpha={alpha}, v={v}")
print(f"WKB valid region: kz < kz_cutoff = {kz_cutoff:.3f}")

kz_vals = np.linspace(0.05, min(8, kz_cutoff * 1.05), 2000)

# Max n we'll evaluate numerically; beyond this the polynomial is dominated
# by the -C*omega term and the cubic root omega ~ C^(1/3)*exp(i*pi/3) suffices.
N_SCAN_MAX = 150

gamma_envelope  = np.full(len(kz_vals), np.nan)  # best γ from valid n
n_best_arr      = np.full(len(kz_vals), -1, dtype=int)
gamma_n0        = np.full(len(kz_vals), np.nan)   # n=0 baseline


def poly_max_gamma(kz, n):
    """Return max Im(omega) > 0 for mode n at wavenumber kz, or 0."""
    C = (2*n + 1) * np.sqrt(alpha**3 / 2.0) * v
    coeffs = [1.0, 0.0, -kz**2, -C, -alpha**2 * v * kz]
    roots = np.roots(coeffs)
    growing = roots[roots.imag > 1e-8]
    return float(np.max(growing.imag)) if len(growing) else 0.0


for i, kz in enumerate(kz_vals):
    n_max_f = 0.5 * (np.sqrt(2) * alpha**2.5 / (v**2 * kz**3) - 1)
    n_max   = int(np.floor(n_max_f))

    if n_max < 0:
        continue

    # n=0 baseline
    gamma_n0[i] = poly_max_gamma(kz, 0)

    # Scan n=0..min(n_max, N_SCAN_MAX) for highest γ.
    # Growth rate is not monotone in n (high n can quench the instability),
    # so we must scan rather than just use n_max.
    n_scan = min(n_max, N_SCAN_MAX)
    best_g = 0.0
    best_n = 0
    for n in range(n_scan + 1):
        g = poly_max_gamma(kz, n)
        if g > best_g:
            best_g = g
            best_n = n

    # If n_max > N_SCAN_MAX also check the asymptote at n_max:
    # large-C limit: omega ~ C^(1/3) * exp(i*pi/3), so gamma = C^(1/3)*sin(pi/3)
    if n_max > N_SCAN_MAX:
        C_max = (2*n_max + 1) * np.sqrt(alpha**3 / 2.0) * v
        g_asym = C_max**(1.0/3.0) * np.sin(np.pi / 3.0)
        if g_asym > best_g:
            best_g = g_asym
            best_n = n_max

    if best_g > 1e-8:
        gamma_envelope[i] = best_g
        n_best_arr[i]     = best_n

# ── Plot ──────────────────────────────────────────────────────────────────────
fig, axes = plt.subplots(1, 2, figsize=(13, 5))

ax = axes[0]
ax.plot(kz_vals, gamma_envelope, 'C0',  lw=2,   label='Envelope (best valid n)')
ax.plot(kz_vals, gamma_n0,       'C1--', lw=1.5, label='n=0 only')
ax.axvline(kz_cutoff, color='k', ls=':', lw=1, label=f'kz_cutoff={kz_cutoff:.2f}')
ax.set_xlabel('kz')
ax.set_ylabel('Growth rate γ')
ax.set_title(f'WKB instability envelope  α={alpha}, V₀={v}')
ax.legend(); ax.grid(True, ls=':', alpha=0.5); ax.set_ylim(bottom=0)

ax2 = axes[1]
ax2.plot(kz_vals, n_best_arr.astype(float), 'C2', lw=1.5)
ax2.axvline(kz_cutoff, color='k', ls=':', lw=1)
ax2.set_xlabel('kz'); ax2.set_ylabel('n that achieves envelope')
ax2.set_title('Optimal mode index vs kz')
ax2.grid(True, ls=':', alpha=0.5)

plt.tight_layout()
plt.savefig('anroot_envelope.png', dpi=150)
print("Saved anroot_envelope.png")

# ── Table ─────────────────────────────────────────────────────────────────────
print(f"\n{'kz':>5}  {'n_max':>7}  {'n_best':>7}  {'γ_env':>8}  {'γ_n0':>8}")
for kz in np.arange(0.5, min(kz_cutoff + 0.6, 9), 0.5):
    n_max_f = 0.5*(np.sqrt(2)*alpha**2.5/(v**2*kz**3)-1)
    n_max   = int(np.floor(n_max_f))
    if n_max < 0:
        print(f"{kz:>5.1f}  {'--':>7}  {'--':>7}  {'--':>8}  {'--':>8}")
        continue
    # scan
    n_scan = min(n_max, N_SCAN_MAX)
    best_g, best_n = 0.0, 0
    for n in range(n_scan+1):
        g = poly_max_gamma(kz, n)
        if g > best_g: best_g, best_n = g, n
    if n_max > N_SCAN_MAX:
        C_max = (2*n_max+1)*np.sqrt(alpha**3/2.0)*v
        g_a = C_max**(1/3)*np.sin(np.pi/3)
        if g_a > best_g: best_g, best_n = g_a, n_max
    g0 = poly_max_gamma(kz, 0)
    print(f"{kz:>5.1f}  {n_max:>7}  {best_n:>7}  {best_g:>8.4f}  {g0:>8.4f}")
