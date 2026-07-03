"""
Measure kz=0 By2 growth rate from NAB_DTANH runs and compare to WKB prediction.

The kz=0 Weibel-like instability: gamma = (sqrt(alpha^3/2)*V0)^(1/3) * sin(pi/3)
This mode grows from machine-precision noise and is the dominant instability in
the non-Abelian dtanh geometry at alpha >= 0.5.
"""
import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path
import re

V0 = 0.1
NZ, NX = 256, 768
DT = 0.01 * (6 * np.pi / NX)   # code uses DT=0.01*DX (NOT 0.001 — CLAUDE.md has typo)


def load_col(fname, col):
    with open(fname) as f:
        hdr = f.readline().strip().split(',')
        idx = hdr.index(col)
    try:
        d = np.loadtxt(fname, delimiter=',', skiprows=1)
    except ValueError:
        # Truncated file (NaN/Inf abort mid-write): read only complete rows
        rows = []
        with open(fname) as f:
            f.readline()  # skip header
            for line in f:
                parts = line.strip().split(',')
                if len(parts) == len(hdr):
                    rows.append([float(p) for p in parts])
        if len(rows) < NZ * NX // 2:
            raise ValueError(f"Too few rows in {fname}: {len(rows)}")
        d = np.array(rows[:NZ * NX])
    return d[:, idx].reshape(NZ, NX)


def kz0_amp(fname):
    """Mean |FFT(By2, kz=0)| / NZ."""
    By2 = load_col(fname, 'By2')
    return float(np.mean(np.abs(np.fft.rfft(By2, axis=0)[0, :])) / NZ)


def fit_gamma(times, amps):
    """Fit gamma from points where amplitude is above noise floor 1e-10."""
    mask = np.array(amps) > 1e-10
    if mask.sum() < 3:
        return np.nan, np.nan
    t = np.array(times)[mask]
    a = np.log(np.array(amps)[mask])
    c = np.polyfit(t, a, 1)
    return c[0], c[1]  # gamma, log(A0)


def wkb_gamma_kz0(alpha, v=V0):
    C = np.sqrt(alpha**3 / 2.0) * v
    return C**(1.0/3.0) * np.sin(np.pi / 3.0)


# ---------------------------------------------------------------------------
alphas_to_try = [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0, 2.25, 2.75]
dir_patterns = {
    0.5:  'ym_k1_a0.500_dtanh',
    0.75: 'ym_k1_a0.750_dtanh',
    1.0:  'ym_k1_a1.000_dtanh',
    1.25: 'ym_k1_a1.250_dtanh',
    1.5:  'ym_k1_a1.500_dtanh',
    1.75: 'ym_k1_a1.750_dtanh',
    2.0:  'ym_k1_a2.000_dtanh',
    2.25: 'ym_k1_a2.250_dtanh',
    2.75: 'ym_k1_a2.750_dtanh',
}

results = {}
print(f"{'alpha':>6}  {'gamma_meas':>11}  {'gamma_WKB':>10}  {'ratio':>7}  npts")
for alpha in alphas_to_try:
    ddir = Path(dir_patterns[alpha])
    if not ddir.exists():
        print(f"{alpha:>6.2f}  {'(no data)':>11}")
        continue

    files = sorted(ddir.glob('ym_*.csv'),
                   key=lambda f: int(re.search(r'(\d+)', f.name).group(1)))
    if len(files) < 3:
        print(f"{alpha:>6.2f}  {'(few files)':>11}  ({len(files)} files)")
        continue

    times, amps = [], []
    for f in files:
        step = int(re.search(r'(\d+)', f.name).group(1))
        t = step * DT
        a = kz0_amp(str(f))
        times.append(t)
        amps.append(a)

    gamma, log_a0 = fit_gamma(times, amps)
    g_wkb = wkb_gamma_kz0(alpha)
    ratio = gamma / g_wkb if g_wkb > 0 else np.nan
    results[alpha] = (gamma, g_wkb, times, amps)
    print(f"{alpha:>6.2f}  {gamma:>11.4f}  {g_wkb:>10.4f}  {ratio:>7.3f}  {len(files)}")

# ---------------------------------------------------------------------------
# Plot
if results:
    fig, axes = plt.subplots(1, 2, figsize=(13, 5))

    # Left: time series of kz=0 amplitude
    ax = axes[0]
    colors = plt.cm.viridis(np.linspace(0, 1, len(results)))
    for (alpha, (gamma, g_wkb, times, amps)), col in zip(results.items(), colors):
        valid = [(t, a) for t, a in zip(times, amps) if a > 1e-13]
        if not valid:
            continue
        tv, av = zip(*valid)
        ax.semilogy(tv, av, 'o-', color=col, label=f'α={alpha}, γ={gamma:.3f}')
        # Fitted line
        t_fit = np.linspace(tv[0], tv[-1], 100)
        _, log_a0 = fit_gamma(list(tv), list(av))
        ax.semilogy(t_fit, np.exp(log_a0 + gamma * t_fit), '--', color=col, alpha=0.5)

    ax.set_xlabel('t (TU)')
    ax.set_ylabel('By2(kz=0) amplitude')
    ax.set_title('kz=0 Weibel mode growth')
    ax.legend(fontsize=8)
    ax.grid(True, which='both', ls=':', alpha=0.4)

    # Right: measured vs WKB gamma
    ax2 = axes[1]
    alpha_wkb = np.linspace(0.2, 3.0, 200)
    g_wkb_curve = [wkb_gamma_kz0(a) for a in alpha_wkb]
    ax2.plot(alpha_wkb, g_wkb_curve, 'k-', lw=1.5, label='WKB: γ=(√(α³/2)·V₀)^(1/3)·sin(π/3)')

    meas_alphas = [a for a, (g, gw, _, _) in results.items() if not np.isnan(g)]
    meas_gammas = [g for a, (g, gw, _, _) in results.items() if not np.isnan(g)]
    ax2.plot(meas_alphas, meas_gammas, 'ro', ms=8, label='Simulation')

    # Power-law fit: gamma_fit = A * alpha^n
    if len(meas_alphas) >= 3:
        log_a = np.log(meas_alphas)
        log_g = np.log(meas_gammas)
        c = np.polyfit(log_a, log_g, 1)
        n_exp, log_A = c
        a_fit_range = np.linspace(min(meas_alphas)*0.9, max(meas_alphas)*1.1, 100)
        ax2.plot(a_fit_range, np.exp(log_A) * a_fit_range**n_exp, 'r--', lw=1,
                 label=f'fit: γ∝α^{n_exp:.2f}', alpha=0.7)
        print(f'\nPower-law fit: gamma_fit ~ {np.exp(log_A):.3f} * alpha^{n_exp:.3f}')

    for alpha, gamma in zip(meas_alphas, meas_gammas):
        ax2.annotate(f'α={alpha}', (alpha, gamma), textcoords='offset points',
                     xytext=(5, 3), fontsize=7)

    ax2.set_xlabel('α')
    ax2.set_ylabel('γ (TU⁻¹)')
    ax2.set_title('kz=0 growth rate vs α\n(WKB validation)')
    ax2.legend(fontsize=8)
    ax2.grid(True, ls=':', alpha=0.4)
    ax2.set_xlim(0, max(meas_alphas)*1.15 if meas_alphas else 3.0)
    ax2.set_ylim(bottom=0)

    plt.tight_layout()
    plt.savefig('kz0_gamma_validation.png', dpi=150)
    print('\nSaved kz0_gamma_validation.png')
