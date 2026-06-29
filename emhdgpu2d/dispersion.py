"""
Dispersion relation analysis for 2D EMHD Kelvin-Helmholtz simulation.

Usage:
    # Single run (measure growth rate for the mode in that run's output):
    python dispersion.py --dirs coupled_k1 coupled_k2 coupled_k3

    # Full dispersion curve after all k runs are done:
    python dispersion.py --dirs coupled_k1 coupled_k2 ... --plot-dispersion

Each directory must contain coupled_NNNNN.csv files.
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path
import re
import argparse

# ── Simulation parameters (must match main_coupled.cu) ──────────────────────
NX          = 256
NZ          = 256
DX          = 1.0
DZ          = 1.0
DT          = 0.002
EXPORT_DT   = 1000 * DT  # time between saved snapshots (export_stride * DT)
V0          = 0.1
EPSILON     = 10.0 * DX  # shear layer width

# ── Physics ──────────────────────────────────────────────────────────────────
L_Z  = NZ * DZ            # domain length in z
K1   = 2.0 * np.pi / L_Z  # fundamental wavenumber

def k_of_mode(n):
    return n * K1


def load_snapshot(path):
    """Return (By, Pz) as 2D arrays [iz, ix]."""
    df = pd.read_csv(path)
    # Export loop: outer z, inner x  →  reshape to (NZ, NX)
    By = df['By'].values.reshape(NZ, NX)
    Pz = df['Pz'].values.reshape(NZ, NX)
    return By, Pz


def equilibrium_by(x_arr):
    """Analytic equilibrium By = -V0*eps*log(cosh((x - x_c)/eps))."""
    x_c = NX * DX / 2.0
    return -V0 * EPSILON * np.log(np.cosh((x_arr - x_c) / EPSILON))


def extract_mode_amplitude(By, k_mode):
    """
    For each x-column take the FFT in z and return the amplitude at k_mode.
    We average across a strip near the shear layer centre where the
    eigenfunction peaks.
    """
    # Fourier transform along z (axis 0)
    Fk = np.fft.rfft(By, axis=0)            # shape (NZ//2+1, NX)
    amp = np.abs(Fk[k_mode, :]) / NZ        # amplitude spectrum at wavenumber k_mode

    # Weight by the sech profile: eigenfunction peaks at x_centre
    x_arr = np.arange(NX) * DX
    x_c   = NX * DX / 2.0
    weight = 1.0 / np.cosh((x_arr - x_c) / EPSILON)
    weight /= weight.sum()
    return float(np.dot(amp, weight))


def smooth_envelope(amps, half_win=5):
    """
    Running-mean envelope to filter out wave oscillations.
    half_win should span at least one oscillation period in snapshot units.
    """
    n    = len(amps)
    env  = np.empty(n)
    for i in range(n):
        lo = max(0, i - half_win)
        hi = min(n, i + half_win + 1)
        env[i] = np.mean(amps[lo:hi])
    return env


def growth_rate_from_dir(run_dir, k_mode):
    """
    Load all snapshots in run_dir, compute the amplitude of k_mode vs time,
    remove wave oscillations via a running-mean envelope, then fit an
    exponential in the most linear log-amplitude region.
    Returns (times, raw_amps, envelope, gamma, t_fit_start, t_fit_end).
    """
    run_dir = Path(run_dir)
    files   = sorted(run_dir.glob('coupled_*.csv'),
                     key=lambda f: int(re.search(r'(\d+)', f.name).group(1)))
    if not files:
        raise FileNotFoundError(f"No CSV files in {run_dir}")

    times = []
    amps  = []
    for f in files:
        step = int(re.search(r'(\d+)', f.name).group(1))
        By, _ = load_snapshot(f)
        times.append(step * DT)
        amps.append(extract_mode_amplitude(By, k_mode))

    times = np.array(times)
    amps  = np.array(amps)

    # ── Smooth oscillations: half_win in snapshot units
    # With export_stride=1000 and dt=0.002, each snapshot is Δt=2.
    # half_win=10 → ±20 time units: enough to suppress short-period whistlers
    # while preserving KH growth (e-folding ~ 500 time units).
    envelope = smooth_envelope(amps, half_win=10)

    # Skip the initial transient (first 20% of run: eigenmode projection decays)
    skip = max(1, len(times) // 5)
    log_env = np.log(envelope[skip:] + 1e-30)
    t_core  = times[skip:]

    # Slide a window (25% of remaining run) to find the best-fit exponential growth
    win      = max(10, len(t_core) // 4)
    best_r2  = -np.inf
    best_i0  = 0
    gamma    = float('nan')
    for i0 in range(len(t_core) - win):
        t_win = t_core[i0:i0 + win]
        a_win = log_env[i0:i0 + win]
        c     = np.polyfit(t_win, a_win, 1)
        if c[0] < 1e-6:   # require measurable positive slope
            continue
        res    = a_win - np.polyval(c, t_win)
        ss_res = np.sum(res**2)
        ss_tot = np.sum((a_win - a_win.mean())**2)
        r2 = 1 - ss_res / (ss_tot + 1e-30)
        if r2 > best_r2:
            best_r2 = r2
            best_i0 = i0
            gamma   = c[0]

    if not np.isnan(gamma):
        t_fit_start = t_core[best_i0]
        t_fit_end   = t_core[best_i0 + win - 1]
    else:
        t_fit_start = t_fit_end = float('nan')

    return times, amps, envelope, gamma, t_fit_start, t_fit_end


def plot_run(run_dir, k_mode, ax_amp, ax_log):
    times, amps, envelope, gamma, t0, t1 = growth_rate_from_dir(run_dir, k_mode)
    k = k_of_mode(k_mode)
    label = f"n={k_mode}, k={k:.4f}, γ={gamma:.5f}"

    # Raw amplitude (faint) + envelope (solid)
    ax_amp.plot(times, amps, alpha=0.25)
    ax_amp.plot(times, envelope, label=label)
    ax_amp.set_xlabel('t')
    ax_amp.set_ylabel('Mode amplitude')
    ax_amp.set_title('Perturbation amplitude vs time\n(faint=raw, solid=envelope)')
    ax_amp.legend(fontsize=7)

    # Log of envelope + fitted window
    ax_log.semilogy(times, amps, alpha=0.2)
    ax_log.semilogy(times, envelope, label=label)
    if not np.isnan(t0):
        mask = (times >= t0) & (times <= t1)
        ax_log.semilogy(times[mask], envelope[mask], 'k--', lw=2)
    ax_log.set_xlabel('t')
    ax_log.set_ylabel('log(amplitude)')
    ax_log.set_title('Log amplitude — dashed = fitted linear phase')
    ax_log.legend(fontsize=7)

    return k, gamma


def plot_energy(run_dirs):
    """Plot E/E0 vs time for each run to show where energy conservation breaks down."""
    fig, ax = plt.subplots(figsize=(9, 5))
    for d in run_dirs:
        efile = Path(d) / 'energy.csv'
        if not efile.exists():
            continue
        df = pd.read_csv(efile)
        label = Path(d).name
        ax.plot(df['time'], df['E_ratio'], label=label)
    ax.axhline(5.0, color='red', ls='--', lw=1.5, label='halt threshold (5×)')
    ax.axhline(1.0, color='k',   ls=':',  lw=1.0)
    ax.set_xlabel('t')
    ax.set_ylabel('E_total / E_initial')
    ax.set_title('Energy conservation — fluid assumption breakdown')
    ax.legend(fontsize=8)
    plt.tight_layout()
    plt.savefig('energy_conservation.png', dpi=150)
    print("Saved energy_conservation.png")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--dirs', nargs='+', required=True,
                        help='Output directories, one per k run '
                             '(e.g. coupled_k1 coupled_k2 ...)')
    parser.add_argument('--modes', nargs='+', type=int, default=None,
                        help='k_mode numbers matching each dir. '
                             'Default: parse from directory name.')
    parser.add_argument('--plot-dispersion', action='store_true',
                        help='Also plot γ(k) dispersion curve')
    parser.add_argument('--plot-energy', action='store_true',
                        help='Plot energy conservation diagnostic')
    args = parser.parse_args()

    # Infer k_mode from directory name if not given
    if args.modes is None:
        modes = []
        for d in args.dirs:
            m = re.search(r'k(\d+)', Path(d).name)
            if m:
                modes.append(int(m.group(1)))
            else:
                raise ValueError(f"Cannot infer k_mode from '{d}'. "
                                 "Pass --modes explicitly.")
    else:
        modes = args.modes

    assert len(modes) == len(args.dirs), "--modes and --dirs must have same length"

    fig, axes = plt.subplots(1, 2, figsize=(13, 5))
    dispersion_k     = []
    dispersion_gamma = []

    for run_dir, k_mode in zip(args.dirs, modes):
        print(f"Processing {run_dir}  (k_mode={k_mode}) ...", end=' ', flush=True)
        try:
            k, gamma = plot_run(run_dir, k_mode, axes[0], axes[1])
            if np.isfinite(gamma):
                dispersion_k.append(k)
                dispersion_gamma.append(gamma)
                print(f"γ = {gamma:.5f}")
            else:
                print(f"γ = nan (run may have blown up before linear phase — check energy.csv)")
        except Exception as e:
            print(f"FAILED: {e}")

    plt.tight_layout()
    plt.savefig('amplitude_vs_time.png', dpi=150)
    print("Saved amplitude_vs_time.png")

    if args.plot_energy:
        plot_energy(args.dirs)

    if args.plot_dispersion and len(dispersion_k) > 1:
        fig2, ax2 = plt.subplots(figsize=(7, 5))
        dispersion_k     = np.array(dispersion_k)
        dispersion_gamma = np.array(dispersion_gamma)
        idx = np.argsort(dispersion_k)
        ax2.plot(dispersion_k[idx], dispersion_gamma[idx], 'o-', label='GPU EMHD (FCT)')

        # Analytic KH estimate: γ ≈ k*V0 for kε << 1
        k_th = np.linspace(dispersion_k.min(), dispersion_k.max(), 200)
        ax2.plot(k_th, k_th * V0, 'k--', label=r'$\gamma \approx k V_0$ (thin-layer)')

        ax2.set_xlabel(r'$k_z$')
        ax2.set_ylabel(r'$\gamma$')
        ax2.set_title('KH Dispersion Relation — EMHD')
        ax2.legend()
        plt.tight_layout()
        plt.savefig('dispersion_relation.png', dpi=150)
        print("Saved dispersion_relation.png")


if __name__ == '__main__':
    main()
