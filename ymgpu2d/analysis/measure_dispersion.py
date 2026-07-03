"""
Measure By2 k-mode growth rates from GPU YM KH runs and compare to WKB prediction.
Usage:
    python measure_dispersion.py --alpha 0.5 --dirs ym_k2_a0.500 ... ym_k8_a0.500
    python measure_dispersion.py --alpha 0.5 --auto  # auto-discover ym_k*_a0.500 dirs
"""
import numpy as np, csv, os, re, glob, argparse
from scipy.optimize import brentq
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

NX, NZ = 256, 256
DT      = 0.002
V0      = 0.1
EPS     = 10.0
K1      = 2.0 * np.pi / (NZ * 1.0)   # fundamental wavenumber


def load_by2_mode(csv_path, k_mode):
    """Return sech-weighted k-mode amplitude of By2 from a snapshot CSV."""
    by2 = []
    with open(csv_path) as fh:
        for row in csv.DictReader(fh):
            by2.append(float(row['By2']))
    by2 = np.array(by2).reshape(NZ, NX)
    Fk  = np.fft.rfft(by2, axis=0)
    amp = np.abs(Fk[k_mode, :]) / NZ
    x   = np.arange(NX)
    wt  = 1.0 / np.cosh((x - NX / 2.0) / EPS)
    wt /= wt.sum()
    return float(np.dot(amp, wt))


def scan_run(run_dir, k_mode):
    """Return (times, amplitudes) arrays for all snapshots in run_dir."""
    files = sorted(glob.glob(os.path.join(run_dir, 'ym_*.csv')),
                   key=lambda f: int(re.search(r'(\d+)', os.path.basename(f)).group(1)))
    times, amps = [], []
    for f in files:
        step = int(re.search(r'(\d+)', os.path.basename(f)).group(1))
        times.append(step * DT)
        amps.append(load_by2_mode(f, k_mode))
    return np.array(times), np.array(amps)


def fit_late_growth(times, amps, late_frac=0.35, min_pts=8):
    """
    Fit exponential growth in the LATE phase of the run.
    Uses a sliding window over the last late_frac fraction of snapshots,
    finds the window with highest R² for a positive-slope linear fit to log(amp).
    Returns (gamma, t_start, t_end, r2).
    """
    n_skip   = max(1, int((1.0 - late_frac) * len(times)))
    t_late   = times[n_skip:]
    log_amp  = np.log(amps[n_skip:] + 1e-30)

    win      = max(min_pts, len(t_late) // 3)
    best_r2  = -np.inf
    gamma    = float('nan')
    t0 = t1 = float('nan')

    for i0 in range(max(1, len(t_late) - win)):
        t_w = t_late[i0: i0 + win]
        a_w = log_amp[i0: i0 + win]
        c   = np.polyfit(t_w, a_w, 1)
        if c[0] < 1e-5:
            continue
        res    = a_w - np.polyval(c, t_w)
        ss_tot = np.sum((a_w - a_w.mean()) ** 2)
        r2     = 1 - np.sum(res ** 2) / (ss_tot + 1e-30)
        if r2 > best_r2:
            best_r2 = r2
            gamma   = c[0]
            t0      = t_w[0]
            t1      = t_w[-1]

    return gamma, t0, t1, best_r2


def wkb_growth_rate(k_z, alpha, v=V0, n_wkb=0):
    """WKB dispersion (wkb.pdf eq. 33): Q0_mean = (2n+1)*sqrt(|C1|)
    With ω = iγ: Q0 = -γ² - kz² + α²*v*kz/γ²  (sign flips on last term)
    |C1| = α³*v² / (2γ²)
    """
    if alpha == 0 or k_z == 0:
        return float('nan')

    def residual(gam):
        if gam <= 0:
            return 1.0
        Q0    = -gam**2 - k_z**2 + alpha**2 * v * k_z / gam**2
        C1abs = alpha**3 * v**2 / (2 * gam**2)
        return Q0 - (2 * n_wkb + 1) * np.sqrt(max(C1abs, 0))

    gam_vals = np.logspace(-4, 0, 600)
    r_vals   = [residual(g) for g in gam_vals]
    for i in range(len(r_vals) - 1):
        if r_vals[i] * r_vals[i + 1] < 0:
            try:
                return brentq(residual, gam_vals[i], gam_vals[i + 1])
            except ValueError:
                pass
    return float('nan')


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--alpha', type=float, required=True)
    parser.add_argument('--dirs',  nargs='*', default=None)
    parser.add_argument('--auto',  action='store_true',
                        help='auto-discover ym_k*_a{alpha} dirs in cwd')
    parser.add_argument('--late-frac', type=float, default=0.35,
                        help='fraction of run to treat as late phase (default 0.35)')
    args = parser.parse_args()

    alpha_str = '%.3f' % args.alpha

    if args.auto:
        pattern = 'ym_k*_a%s' % alpha_str
        dirs = sorted(glob.glob(pattern),
                      key=lambda d: int(re.search(r'k(\d+)', d).group(1)))
    else:
        dirs = args.dirs or []

    if not dirs:
        print("No directories found.")
        return

    print("%-20s  %6s  %8s  %8s  %8s  %8s  %5s" %
          ('dir', 'k_mode', 'k_z', 'γ_GPU', 'γ_WKB', 'ratio', 'R²'))
    print('-' * 75)

    disp_k, disp_gpu, disp_wkb = [], [], []

    fig, axes = plt.subplots(1, 2, figsize=(13, 5))
    ax_lin, ax_log = axes

    for d in dirs:
        m = re.search(r'k(\d+)', d)
        if not m:
            print("Cannot parse k_mode from '%s'" % d)
            continue
        k_mode = int(m.group(1))
        k_z    = k_mode * K1
        g_wkb  = wkb_growth_rate(k_z, args.alpha)

        times, amps = scan_run(d, k_mode)
        if len(times) < 5:
            print("%-20s  k=%d  too few snapshots (%d)" % (d, k_mode, len(times)))
            continue

        gamma, t0, t1, r2 = fit_late_growth(times, amps, late_frac=args.late_frac)

        ratio = (gamma / g_wkb) if (np.isfinite(gamma) and g_wkb > 0) else float('nan')
        print("%-20s  %6d  %8.4f  %8.5f  %8.5f  %8.4f  %5.3f  (t=%.0f..%.0f)" %
              (d, k_mode, k_z, gamma, g_wkb, ratio, r2, t0, t1))

        if np.isfinite(gamma):
            disp_k.append(k_z)
            disp_gpu.append(gamma)
            disp_wkb.append(g_wkb)

        label = 'k=%d γ=%.4f' % (k_mode, gamma)
        ax_lin.plot(times, amps, alpha=0.3)
        ax_lin.plot(times, amps, '.', ms=3, label=label)
        ax_log.semilogy(times, amps + 1e-30, label=label)
        if np.isfinite(t0):
            mask = (times >= t0) & (times <= t1)
            if mask.sum() > 1:
                t_m = times[mask]
                fit_curve = np.exp(gamma * (t_m - t_m[0])) * amps[mask][0]
                ax_log.semilogy(t_m, fit_curve, 'k--', lw=1.5)

    ax_lin.set_xlabel('t'); ax_lin.set_ylabel('|By²_k| amplitude')
    ax_lin.set_title('By2 mode amplitude vs time')
    ax_lin.legend(fontsize=7)
    ax_log.set_xlabel('t'); ax_log.set_ylabel('log amplitude')
    ax_log.set_title('Log amplitude (dashed = fitted growth)')
    ax_log.legend(fontsize=7)
    plt.tight_layout()
    plt.savefig('ym_amplitude_a%s.png' % alpha_str, dpi=150)
    print("Saved ym_amplitude_a%s.png" % alpha_str)

    if len(disp_k) > 1:
        fig2, ax2 = plt.subplots(figsize=(7, 5))
        disp_k   = np.array(disp_k)
        disp_gpu = np.array(disp_gpu)
        disp_wkb = np.array(disp_wkb)
        idx = np.argsort(disp_k)
        ax2.plot(disp_k[idx], disp_gpu[idx], 'bo-', label='GPU SU(2)', ms=8)
        ax2.plot(disp_k[idx], disp_wkb[idx], 'r--', label='WKB (n=0)', lw=2)

        k_th = np.linspace(0, disp_k.max() * 1.2, 300)
        g_th = np.array([wkb_growth_rate(k, args.alpha) for k in k_th])
        mask = np.isfinite(g_th)
        ax2.plot(k_th[mask], g_th[mask], 'r-', alpha=0.4, lw=1)

        ax2.set_xlabel(r'$k_z$'); ax2.set_ylabel(r'$\gamma$')
        ax2.set_title('YM KH Dispersion Relation  (α_YM=%.2f, V0=%.2f)' %
                      (args.alpha, V0))
        ax2.legend()
        plt.tight_layout()
        plt.savefig('ym_dispersion_a%s.png' % alpha_str, dpi=150)
        print("Saved ym_dispersion_a%s.png" % alpha_str)


if __name__ == '__main__':
    main()
