"""
Dispersion relation analysis for SU(2) Yang-Mills KH simulation.

Usage:
    # Non-Abelian circularly polarized runs (NAB_CIRC, mode=1):
    python dispersion_ym.py --dirs ym_k2_a0.500_circ ... --alpha 0.5 --field circ_nab --plot-dispersion

    # EMHD KH in By1 (EMHD_KH, mode=2):
    python dispersion_ym.py --dirs ym_k2_a0.000_emhd ... --alpha 0 --field By1 --plot-dispersion

    # Original By2 analysis (NAB_LINEAR, mode=0):
    python dispersion_ym.py --dirs ym_k2_a0.500 ... --alpha 0.5 --field By2 --plot-dispersion

    # Specify fit window to isolate early linear phase:
    python dispersion_ym.py --dirs ... --t-min 5 --t-max 50
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path
import re
import argparse
from scipy.optimize import brentq

# ── Simulation parameters (must match main_ym.cu) ────────────────────
# Periodic box: Lx=6π, Lz=2π.  NX=768 is fixed; NZ is detected from CSV row count.
NX = 768
NZ = 256                          # default; overridden per-snapshot by load_snapshot
LZ = 2.0 * np.pi
LX = 6.0 * np.pi
DZ = LZ / NZ
DX = LX / NX
DT = 0.01 * DX
EXPORT_DT = 20000 * DT
V0        = 0.1
EPSILON   = LX / 6.0              # = π, scale for tanh modes

L_Z = LZ
K1  = 2.0 * np.pi / LZ            # = 1.0 exactly — step-mode kz are integers


def k_of_mode(n):
    return n * K1


# ── Snapshot loading (handles both old and new CSV column sets) ───────

def load_snapshot(path):
    df = pd.read_csv(path)
    n_rows = len(df)
    nz = n_rows // NX          # detect NZ from row count (NX=768 is fixed)
    By1 = df['By1'].values.reshape(nz, NX)
    By2 = df['By2'].values.reshape(nz, NX)
    By3 = df['By3'].values.reshape(nz, NX)
    Az2 = df['Az2'].values.reshape(nz, NX) if 'Az2' in df.columns else np.zeros((nz, NX))
    Az3 = df['Az3'].values.reshape(nz, NX) if 'Az3' in df.columns else np.zeros((nz, NX))
    return By1, By2, By3, Az2, Az3


def _xi_weight(xi_cut):
    """x weight: uniform (xi_cut<0) or sech centered at each interface (xi_cut>=0).

    For step-mode (xi_cut<0): flat 1/NX weight, appropriate since the KH mode
    amplitude is uniform across x in the initial linear phase.
    For tanh-mode (xi_cut>=0): sech peaked at each interface x=Lx/3 and x=2Lx/3,
    restricted to |x - interface| < xi_cut (in units of EPSILON=π).
    """
    if xi_cut < 0:
        return np.ones(NX) / NX

    x_arr = np.arange(NX) * DX
    # Two-hump weight centred at the two step interfaces
    w = (1.0 / np.cosh((x_arr - LX / 3.0) / EPSILON) +
         1.0 / np.cosh((x_arr - 2.0 * LX / 3.0) / EPSILON))
    if xi_cut > 0:
        d1 = np.abs(x_arr - LX / 3.0) / EPSILON
        d2 = np.abs(x_arr - 2.0 * LX / 3.0) / EPSILON
        w[np.minimum(d1, d2) >= xi_cut] = 0.0
    s = w.sum()
    return w / s if s > 0 else w


def extract_mode_amplitude(field_2d, k_mode, weight):
    """FFT in z, weighted average over x.
    field_2d shape: (nz, NX) real.  Returns scalar amplitude."""
    nz  = field_2d.shape[0]
    Fk  = np.fft.rfft(field_2d, axis=0)
    amp = np.abs(Fk[k_mode, :]) / nz
    return float(np.dot(amp, weight))


def extract_circ_amplitude(field_re, field_im, k_mode, weight):
    """Complex amplitude |F_re + i*F_im| for the circularly polarized mode."""
    nz  = field_re.shape[0]
    Fre = np.fft.rfft(field_re, axis=0)[k_mode, :] / nz
    Fim = np.fft.rfft(field_im, axis=0)[k_mode, :] / nz
    amp = np.abs(Fre + 1j * Fim)
    return float(np.dot(amp, weight))


def smooth_envelope(amps, half_win=10):
    n = len(amps)
    env = np.empty(n)
    for i in range(n):
        lo = max(0, i - half_win)
        hi = min(n, i + half_win + 1)
        env[i] = np.mean(amps[lo:hi])
    return env


def fit_growth_rate(times, amps, t_min=None, t_max=None, min_win_frac=0.15):
    """Sliding-window linear fit to log(amplitude) in [t_min, t_max].

    Returns (gamma, t0, t1, R²).  The window with highest R² and positive slope wins.
    """
    # Apply time window
    mask = np.ones(len(times), dtype=bool)
    if t_min is not None:
        mask &= (times >= t_min)
    if t_max is not None:
        mask &= (times <= t_max)
    mask &= (amps > 1e-30)

    if mask.sum() < 5:
        return float('nan'), float('nan'), float('nan'), float('nan')

    t_win = times[mask]
    a_win = np.log(amps[mask] + 1e-30)
    env   = smooth_envelope(a_win, half_win=5)

    n      = len(t_win)
    win    = max(5, int(n * min_win_frac))
    best   = {'r2': -np.inf, 'gamma': float('nan'), 't0': float('nan'), 't1': float('nan')}

    for i0 in range(n - win):
        tw = t_win[i0:i0 + win]
        aw = env[i0:i0 + win]
        c  = np.polyfit(tw, aw, 1)
        if c[0] < 1e-6:
            continue
        res    = aw - np.polyval(c, tw)
        ss_res = np.sum(res**2)
        ss_tot = np.sum((aw - aw.mean())**2)
        r2     = 1.0 - ss_res / (ss_tot + 1e-30)
        if r2 > best['r2']:
            best = {'r2': r2, 'gamma': c[0], 't0': tw[0], 't1': tw[-1]}

    return best['gamma'], best['t0'], best['t1'], best['r2']


def growth_rate_from_dir(run_dir, k_mode, field='By2', xi_cut=2.0, t_min=None, t_max=None):
    """Extract growth rate from a run directory.

    field options:
      'By2'      – original single-color field (NAB_LINEAR mode)
      'circ_nab' – |By2+iBy3| circularly polarized non-Abelian mode (NAB_CIRC)
      'By1'      – color-1 magnetic field (EMHD KH mode)
      'Az_circ'  – |Az2+iAz3| complex vector potential (all modes with Az2/Az3 in CSV)
      'By3'      – color-3 magnetic field alone (diagnostic)
    """
    run_dir = Path(run_dir)
    files   = sorted(run_dir.glob('ym_*.csv'),
                     key=lambda f: int(re.search(r'(\d+)', f.name).group(1)))
    if not files:
        raise FileNotFoundError(f"No CSV files in {run_dir}")

    # Infer DT from energy.csv slope (step 0→N) so time is correct for any courant.
    # Falls back to module-level DT if energy.csv is absent or has only one row.
    dt_run = DT
    energy_path = run_dir / 'energy.csv'
    if energy_path.exists():
        try:
            edf = pd.read_csv(energy_path)
            if len(edf) >= 2:
                dt_run = float(edf['time'].iloc[-1] - edf['time'].iloc[0]) / \
                         float(edf['step'].iloc[-1] - edf['step'].iloc[0])
        except Exception:
            pass

    weight = _xi_weight(xi_cut)
    times, amps = [], []

    for f in files:
        step = int(re.search(r'(\d+)', f.name).group(1))
        By1, By2, By3, Az2, Az3 = load_snapshot(f)

        if field == 'By2':
            a = extract_mode_amplitude(By2, k_mode, weight)
        elif field == 'circ_nab':
            a = extract_circ_amplitude(By2, By3, k_mode, weight)
        elif field == 'By1':
            a = extract_mode_amplitude(By1, k_mode, weight)
        elif field == 'Az_circ':
            a = extract_circ_amplitude(Az2, Az3, k_mode, weight)
        elif field == 'By3':
            a = extract_mode_amplitude(By3, k_mode, weight)
        else:
            raise ValueError(f"Unknown field '{field}'")

        times.append(step * dt_run)
        amps.append(a)

    times = np.array(times)
    amps  = np.array(amps)
    gamma, t0, t1, r2 = fit_growth_rate(times, amps, t_min=t_min, t_max=t_max)
    return times, amps, gamma, t0, t1, r2


def plot_run(run_dir, k_mode, ax_amp, ax_log, field='By2',
             xi_cut=2.0, t_min=None, t_max=None):
    times, amps, gamma, t0, t1, r2 = growth_rate_from_dir(
        run_dir, k_mode, field=field, xi_cut=xi_cut, t_min=t_min, t_max=t_max)
    k    = k_of_mode(k_mode)
    label = f"n={k_mode}, k={k:.4f}, γ={gamma:.5f} (R²={r2:.3f})"

    env = smooth_envelope(amps, half_win=10)
    ax_amp.plot(times, amps, alpha=0.25)
    ax_amp.plot(times, env, label=label)
    ax_amp.set_xlabel('t')
    ax_amp.set_ylabel(f'|{field}| amplitude')
    ax_amp.set_title(f'Perturbation amplitude vs time ({field})')
    ax_amp.legend(fontsize=7)

    ax_log.semilogy(times, np.clip(amps, 1e-30, None), alpha=0.2)
    ax_log.semilogy(times, np.clip(env,  1e-30, None), label=label)
    if np.isfinite(t0):
        fit_mask = (times >= t0) & (times <= t1)
        ax_log.semilogy(times[fit_mask], env[fit_mask], 'k--', lw=2)
    if t_min is not None:
        ax_log.axvline(t_min, color='gray', ls=':', lw=1)
    if t_max is not None:
        ax_log.axvline(t_max, color='gray', ls=':', lw=1)
    ax_log.set_xlabel('t')
    ax_log.set_ylabel('log amplitude')
    ax_log.set_title('Log amplitude — dashed = fitted linear phase')
    ax_log.legend(fontsize=7)

    return k, gamma


# ── WKB dispersion prediction (wkb.pdf eq. 33) ───────────────────────
# Q0_mean = (2n+1)*sqrt(|C1|)
# Q0_mean = ω²  - k_z² - α²*v*k_z/ω²   (wkb.pdf eq. 21)
# |C1|    = α³*v² / (2|ω|²)             (wkb.pdf eq. 18)
# Setting ω = iγ (pure imaginary, γ>0 = growth rate):
#   Q0 = -γ² - k_z² + α²*v*k_z/γ²
#   Condition: Q0 = (2n+1)*sqrt(α³*v²/(2γ²))
def wkb_growth_rate(k_z, alpha, v=V0, n_wkb=0):
    """Return γ from WKB condition (wkb.pdf eq. 33)."""
    if alpha == 0 or k_z == 0:
        return float('nan')

    def residual(gam):
        if gam <= 0:
            return 1.0
        Q0    = -gam**2 - k_z**2 + alpha**2 * v * k_z / gam**2
        C1abs = alpha**3 * v**2 / (2 * gam**2)
        return Q0 - (2 * n_wkb + 1) * np.sqrt(max(C1abs, 0))

    gam_vals = np.logspace(-4, 0, 500)
    r_vals   = [residual(g) for g in gam_vals]
    for i in range(len(r_vals) - 1):
        if r_vals[i] * r_vals[i+1] < 0:
            try:
                return brentq(residual, gam_vals[i], gam_vals[i+1])
            except ValueError:
                pass
    return float('nan')


# ── Classical step-function KH (two counter-streaming beams) ─────────
# For a sharp-interface step velocity ±V0, single-beam analysis gives γ = kz*V0.
def step_kh_rate(k_z, v=V0):
    """Classical KH growth rate for a step-function interface: γ = kz·V0."""
    return v * k_z


# ── Classical EMHD KH dispersion (tanh profile, Abelian) ─────────────
# For a tanh shear layer of width ε: γ_KH(k) ≈ V0*k*sech(k*ε*π/2)
# Ad hoc interpolation (not derived from Das-Kaw's nonlocal analysis) that
# reproduces the two rigorous limits below (kzε→0: γ→kz·V0; kzε≫1: γ→0).
def emhd_kh_rate(k_z, v=V0, eps=EPSILON):
    return v * k_z * (1.0 / np.cosh(k_z * eps * np.pi / 2.0))


# ── Das & Kaw (Phys. Plasmas 8, 4518 (2001)) exact dispersion relations ──
# Nonlocal sausage-like instability of EMHD current channels — the paper in
# this repo (4518_1_online.pdf). Length normalized to electron skin depth,
# velocity to their V0; our code uses the same normalization convention
# (code units, c=eps0=1) with V0/EPS as literal inputs.
#
# Step-profile (Eq. 16): electron flow jumps ±V0 at x=0 (ε→0 limit).
#   ω² = -kz²V0²(1+4kz²)/(3+4kz²)         γ = |ω|
#   kz≫1 → γ→kz·V0 (hydrodynamic KH limit); kz≪1 → γ→kz·V0/√3.
# This is the paper's only fully closed-form result; the smooth "linear
# profile" case (their Fig. 2, width 2ε) requires solving a transcendental
# Whittaker-function relation (Eq. 19) and is not implemented here — its two
# rigorous limits (kzε≪1: γ→kz·V0, matching the step result; kzε≫1: stable,
# γ=0) are what `emhd_kh_rate` above interpolates between.
def daskaw_step_rate(k_z, v=V0):
    k_z = np.asarray(k_z)
    return np.abs(k_z) * v * np.sqrt((1.0 + 4.0 * k_z**2) / (3.0 + 4.0 * k_z**2))


def plot_energy(run_dirs):
    fig, ax = plt.subplots(figsize=(9, 5))
    for d in run_dirs:
        efile = Path(d) / 'energy.csv'
        if not efile.exists():
            continue
        df = pd.read_csv(efile)
        ax.plot(df['time'], df['E_ratio'], label=Path(d).name)
    ax.axhline(5.0, color='red', ls='--', lw=1.5, label='halt (5×)')
    ax.axhline(1.0, color='k',   ls=':',  lw=1.0)
    ax.set_xlabel('t')
    ax.set_ylabel('E/E₀')
    ax.set_title('YM Energy conservation')
    ax.legend(fontsize=8)
    plt.tight_layout()
    plt.savefig('ym_energy.png', dpi=150)
    print("Saved ym_energy.png")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--dirs',    nargs='+', required=True)
    parser.add_argument('--modes',   nargs='+', type=int, default=None)
    parser.add_argument('--alpha',   type=float, default=None,
                        help='α_YM for WKB overlay')
    parser.add_argument('--field',   default='By2',
                        choices=['By2', 'circ_nab', 'By1', 'Az_circ', 'By3'],
                        help='Which field/amplitude to track (default: By2)')
    parser.add_argument('--xi-cut',  type=float, default=-1,
                        help='x weight: <0=uniform (default, for step mode), '
                             '>=0=two-hump sech at interfaces, cut at xi_cut EPSILON')
    parser.add_argument('--t-min',   type=float, default=None,
                        help='Fit window start time (TU)')
    parser.add_argument('--t-max',   type=float, default=None,
                        help='Fit window end time (TU)')
    parser.add_argument('--eps',     type=float, default=EPSILON,
                        help='Shear-layer width EPS for the By1 EMHD theory '
                             'overlay (must match eps_override used in the '
                             f'runs; default {EPSILON:.4f} = Lx/6)')
    parser.add_argument('--plot-dispersion', action='store_true')
    parser.add_argument('--plot-energy',     action='store_true')
    args = parser.parse_args()

    # Infer k_mode from dir name  ym_k<N>_a<alpha>[_suffix]
    if args.modes is None:
        modes = []
        for d in args.dirs:
            m = re.search(r'k(\d+)', Path(d).name)
            if not m:
                raise ValueError(f"Cannot parse k_mode from '{d}', pass --modes")
            modes.append(int(m.group(1)))
    else:
        modes = args.modes
    assert len(modes) == len(args.dirs)

    alpha = args.alpha
    if alpha is None:
        m = re.search(r'_a([\d.]+)', Path(args.dirs[0]).name)
        alpha = float(m.group(1)) if m else 0.0

    print(f"Field: {args.field}  |  xi_cut={args.xi_cut}"
          f"  |  t=[{args.t_min},{args.t_max}]  |  alpha={alpha}")

    fig, axes = plt.subplots(1, 2, figsize=(13, 5))
    disp_k, disp_gamma = [], []

    for run_dir, k_mode in zip(args.dirs, modes):
        print(f"  {run_dir}  (k_mode={k_mode}) ...", end=' ', flush=True)
        try:
            k, gamma = plot_run(run_dir, k_mode, axes[0], axes[1],
                                field=args.field, xi_cut=args.xi_cut,
                                t_min=args.t_min, t_max=args.t_max)
            if np.isfinite(gamma):
                disp_k.append(k); disp_gamma.append(gamma)
                print(f"γ = {gamma:.5f}")
            else:
                print("γ = nan")
        except Exception as e:
            print(f"FAILED: {e}")

    plt.tight_layout()
    out_png = f'ym_amplitude_{args.field}.png'
    plt.savefig(out_png, dpi=150)
    print(f"Saved {out_png}")

    if args.plot_energy:
        plot_energy(args.dirs)

    if args.plot_dispersion and len(disp_k) > 1:
        fig2, ax2 = plt.subplots(figsize=(7, 5))
        disp_k     = np.array(disp_k)
        disp_gamma = np.array(disp_gamma)
        idx = np.argsort(disp_k)
        ax2.plot(disp_k[idx], disp_gamma[idx], 'o-', label=f'GPU SU(2) α={alpha} ({args.field})')

        k_th = np.linspace(max(disp_k.min(), 1e-3), disp_k.max(), 300)

        # Classical step-KH reference: γ = kz·V0 (always shown)
        g_step = np.array([step_kh_rate(k) for k in k_th])
        ax2.plot(k_th, g_step, 'b:', lw=1.5, label=f'Step KH  γ=k·V0 (V0={V0})')

        # WKB prediction overlay (non-Abelian modes)
        if alpha > 0 and args.field in ('By2', 'circ_nab', 'Az_circ', 'By3'):
            g_wkb = np.array([wkb_growth_rate(k, alpha) for k in k_th])
            finite = np.isfinite(g_wkb)
            if finite.any():
                ax2.plot(k_th[finite], g_wkb[finite], 'r--', label='WKB non-Ab (n=0)')

        # EMHD KH reference (By1 mode, tanh profile)
        if args.field == 'By1':
            g_kh = np.array([emhd_kh_rate(k, eps=args.eps) for k in k_th])
            ax2.plot(k_th, g_kh, 'g-.', label=f'EMHD KH sech interp. (ε={args.eps:.2f})')
            g_dk = daskaw_step_rate(k_th)
            ax2.plot(k_th, g_dk, 'm:', lw=2,
                     label='Das & Kaw 2001 Eq.16 (exact, step profile)')

        ax2.set_xlabel(r'$k_z$')
        ax2.set_ylabel(r'$\gamma$ (TU⁻¹)')
        ax2.set_title(f'KH Dispersion  (α={alpha}, field={args.field})')
        ax2.legend()
        plt.tight_layout()
        out_disp = f'ym_dispersion_{args.field}.png'
        plt.savefig(out_disp, dpi=150)
        print(f"Saved {out_disp}")

    # Print summary table
    if len(disp_k) > 0:
        print(f"\n{'k_mode':>7} {'k_z':>10} {'gamma':>10} {'WKB':>10}")
        print('-' * 45)
        for k, g in sorted(zip(disp_k, disp_gamma)):
            n_mode = round(k / K1)
            g_wkb  = wkb_growth_rate(k, alpha) if alpha > 0 else float('nan')
            print(f"{n_mode:>7} {k:>10.5f} {g:>10.5f} {g_wkb:>10.5f}")


if __name__ == '__main__':
    main()
