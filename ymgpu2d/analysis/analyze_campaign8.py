"""
Campaign 8: kz=0 Weibel 2D parameter sweep — WKB validation.

Reads all output directories matching the Campaign 8 naming pattern,
measures the kz=0 By2 exponential growth rate gamma for each (alpha, V0),
and compares to the analytic WKB prediction:

    gamma_WKB = (sqrt(alpha^3/2) * V0)^(1/3) * sin(pi/3)

Produces:
  1. Console table of (alpha, V0, gamma_meas, gamma_WKB, ratio, status)
  2. campaign8_heatmap.png  — 2D ratio gamma_meas/gamma_WKB over (alpha, V0)
  3. campaign8_scatter.png  — gamma_meas vs gamma_WKB scatter
  4. campaign8_slices.png   — gamma vs V0 for each alpha (log-log)
"""
import re
import sys
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors
from pathlib import Path

# ── Grid (must match run_campaign8.sh) ────────────────────────────────────────
ALPHA_VALS = np.linspace(1.0, 6.0, 10)
V0_VALS    = np.logspace(np.log10(0.001), np.log10(0.4), 20)

NX, NZ = 768, 256
DT = 0.01 * (6 * np.pi / NX)    # 0.01 * DX;  1 TU = 1/(DT) steps... actually:
STEPS_PER_SNAPSHOT = 20000       # snapshots written every 20000 steps
TU_PER_SNAPSHOT    = STEPS_PER_SNAPSHOT * DT   # seconds per snapshot in TU

NOISE_FLOOR = 1e-12   # below this kz=0 amplitude = pure float32 noise, skip


# ── Helpers ────────────────────────────────────────────────────────────────────
def wkb_gamma(alpha, v0):
    C = np.sqrt(alpha**3 / 2.0) * v0
    return C**(1.0/3.0) * np.sin(np.pi / 3.0)


def load_by2(path):
    """Load By2 column from a snapshot CSV. Returns (NZ, NX) array."""
    path = str(path)
    with open(path) as f:
        hdr = f.readline().strip().split(',')
    col_idx = hdr.index('By2')
    try:
        d = np.loadtxt(path, delimiter=',', skiprows=1)
        return d[:, col_idx].reshape(NZ, NX)
    except ValueError:
        rows = []
        with open(path) as f:
            f.readline()
            for line in f:
                parts = line.strip().split(',')
                if len(parts) == len(hdr):
                    rows.append([float(p) for p in parts])
        if len(rows) < NZ * NX // 2:
            raise ValueError(f"too few rows: {len(rows)}")
        return np.array(rows[:NZ * NX])[:, col_idx].reshape(NZ, NX)


def kz0_amplitude(path):
    """Mean |FFT(By2, kz=0)| / NZ — the kz=0 Weibel mode amplitude."""
    By2 = load_by2(path)
    return float(np.mean(np.abs(np.fft.rfft(By2, axis=0)[0, :])) / NZ)


def fit_growth_rate(times, amps):
    """Fit gamma from log-amplitude vs time (least squares over points above noise floor)."""
    mask = np.array(amps) > NOISE_FLOOR
    if mask.sum() < 3:
        return np.nan, np.nan, mask.sum()
    t = np.array(times)[mask]
    a = np.log(np.array(amps)[mask])
    c = np.polyfit(t, a, 1)
    return c[0], c[1], int(mask.sum())  # gamma, log(A0), n_pts


def snapshot_step(filename):
    m = re.search(r'(\d+)', Path(filename).name)
    return int(m.group(1)) if m else 0


# ── Directory discovery ────────────────────────────────────────────────────────
DIR_PATTERN = re.compile(
    r'^ym_k1_a([\d.]+)_dtanh_v([\d.]+)_hd2e-04$'
)

def find_campaign8_dirs(base='.'):
    found = {}
    for d in sorted(Path(base).iterdir()):
        if not d.is_dir():
            continue
        m = DIR_PATTERN.match(d.name)
        if m:
            alpha_str = m.group(1)
            v0_str    = m.group(2)
            found[(float(alpha_str), float(v0_str))] = d
    return found


# ── Main measurement loop ──────────────────────────────────────────────────────
def measure_all(base='.'):
    dirs = find_campaign8_dirs(base)
    if not dirs:
        print(f"No Campaign 8 directories found in {base}")
        print("Expected pattern: ym_k1_a<alpha>_dtanh_v<V0>_hd2e-04")
        sys.exit(1)
    print(f"Found {len(dirs)} directories")

    results = {}  # (alpha, v0) -> dict

    print(f"\n{'alpha':>7}  {'V0':>9}  {'gamma_m':>9}  {'gamma_WKB':>10}  {'ratio':>7}  {'npts':>5}  status")
    print("-" * 70)

    for (alpha_dir, v0_dir), dpath in sorted(dirs.items()):
        csvs = sorted(dpath.glob('ym_*.csv'), key=lambda f: snapshot_step(f))
        if len(csvs) < 2:
            results[(alpha_dir, v0_dir)] = dict(gamma=np.nan, status='no_data', npts=0)
            print(f"{alpha_dir:7.3f}  {v0_dir:9.4f}  {'—':>9}  {'—':>10}  {'—':>7}  {0:>5}  no_data")
            continue

        times, amps = [], []
        for csv in csvs:
            step = snapshot_step(csv)
            try:
                amp = kz0_amplitude(csv)
                times.append(step * DT)
                amps.append(amp)
            except Exception:
                pass

        gamma, log_a0, npts = fit_growth_rate(times, amps)
        g_wkb = wkb_gamma(alpha_dir, v0_dir)
        ratio = gamma / g_wkb if (not np.isnan(gamma) and g_wkb > 0) else np.nan

        status = 'ok' if not np.isnan(gamma) else 'no_growth'
        results[(alpha_dir, v0_dir)] = dict(
            gamma=gamma, gamma_wkb=g_wkb, ratio=ratio,
            times=times, amps=amps, npts=npts, status=status
        )

        if np.isnan(gamma):
            print(f"{alpha_dir:7.3f}  {v0_dir:9.4f}  {'NaN':>9}  {g_wkb:10.4f}  {'—':>7}  {npts:>5}  {status}")
        else:
            print(f"{alpha_dir:7.3f}  {v0_dir:9.4f}  {gamma:9.4f}  {g_wkb:10.4f}  {ratio:7.3f}  {npts:>5}  {status}")

    return results


# ── Plots ─────────────────────────────────────────────────────────────────────
def build_grid(results):
    """Build 2D arrays aligned to ALPHA_VALS x V0_VALS."""
    gamma_grid = np.full((len(ALPHA_VALS), len(V0_VALS)), np.nan)
    ratio_grid = np.full((len(ALPHA_VALS), len(V0_VALS)), np.nan)
    wkb_grid   = np.full((len(ALPHA_VALS), len(V0_VALS)), np.nan)

    for (alpha_dir, v0_dir), r in results.items():
        # find nearest grid indices
        ia = np.argmin(np.abs(ALPHA_VALS - alpha_dir))
        iv = np.argmin(np.abs(V0_VALS   - v0_dir))
        gamma_grid[ia, iv] = r.get('gamma', np.nan)
        ratio_grid[ia, iv] = r.get('ratio', np.nan)
        wkb_grid[ia, iv]   = r.get('gamma_wkb', np.nan)

    return gamma_grid, ratio_grid, wkb_grid


def plot_heatmap(ratio_grid):
    fig, ax = plt.subplots(figsize=(10, 6))
    vmin, vmax = 0.5, 1.5
    cmap = plt.cm.RdYlGn
    norm = mcolors.TwoSlopeNorm(vmin=vmin, vcenter=1.0, vmax=vmax)

    im = ax.pcolormesh(
        np.arange(len(ALPHA_VALS)),
        np.arange(len(V0_VALS)),
        ratio_grid.T,
        cmap=cmap, norm=norm, shading='nearest'
    )
    plt.colorbar(im, ax=ax, label='γ_meas / γ_WKB')

    ax.set_xticks(np.arange(len(ALPHA_VALS)))
    ax.set_xticklabels([f'{a:.2f}' for a in ALPHA_VALS], fontsize=8)
    ax.set_yticks(np.arange(len(V0_VALS)))
    ax.set_yticklabels([f'{v:.4f}' for v in V0_VALS], fontsize=7)
    ax.set_xlabel('α')
    ax.set_ylabel('V₀')
    ax.set_title('Campaign 8: γ_measured / γ_WKB\n'
                 r'(green=1.0 = perfect WKB match; red<1 suppressed; yellow>1 above WKB)')

    # annotate each cell with ratio value
    for ia in range(len(ALPHA_VALS)):
        for iv in range(len(V0_VALS)):
            v = ratio_grid[ia, iv]
            if not np.isnan(v):
                ax.text(ia, iv, f'{v:.2f}', ha='center', va='center',
                        fontsize=5, color='black')

    plt.tight_layout()
    plt.savefig('campaign8_heatmap.png', dpi=150, bbox_inches='tight')
    print('Saved campaign8_heatmap.png')


def plot_scatter(results):
    gm_all, gw_all = [], []
    for r in results.values():
        gm = r.get('gamma', np.nan)
        gw = r.get('gamma_wkb', np.nan)
        if not np.isnan(gm) and not np.isnan(gw):
            gm_all.append(gm)
            gw_all.append(gw)

    if not gm_all:
        return

    gm_all = np.array(gm_all)
    gw_all = np.array(gw_all)

    fig, ax = plt.subplots(figsize=(7, 6))
    ax.scatter(gw_all, gm_all, s=20, alpha=0.7, color='steelblue', label='runs')

    lo = min(gw_all.min(), gm_all.min()) * 0.8
    hi = max(gw_all.max(), gm_all.max()) * 1.2
    ax.plot([lo, hi], [lo, hi], 'k--', lw=1, label='γ_meas = γ_WKB')
    ax.plot([lo, hi], [0.9*lo, 0.9*hi], 'r:', lw=0.8, label='−10%')
    ax.plot([lo, hi], [1.1*lo, 1.1*hi], 'g:', lw=0.8, label='+10%')

    # linear regression
    c = np.polyfit(gw_all, gm_all, 1)
    x_fit = np.linspace(lo, hi, 100)
    ax.plot(x_fit, np.polyval(c, x_fit), 'b-', lw=1.2, alpha=0.6,
            label=f'fit: γ_m = {c[0]:.3f}·γ_WKB + {c[1]:.4f}')

    ax.set_xlabel('γ_WKB (TU⁻¹)')
    ax.set_ylabel('γ_measured (TU⁻¹)')
    ax.set_title('Campaign 8: measured vs analytic growth rate\n'
                 r'γ_WKB = $(\sqrt{\alpha^3/2}\cdot V_0)^{1/3}\cdot\sin(\pi/3)$')
    ax.legend(fontsize=9)
    ax.grid(True, ls=':', alpha=0.4)
    plt.tight_layout()
    plt.savefig('campaign8_scatter.png', dpi=150, bbox_inches='tight')
    print('Saved campaign8_scatter.png')


def plot_slices(results):
    """gamma vs V0 for each alpha value (log-log), with WKB overlay."""
    fig, axes = plt.subplots(2, 5, figsize=(18, 7), sharey=False)
    axes = axes.flatten()
    colors = plt.cm.plasma(np.linspace(0.1, 0.9, len(ALPHA_VALS)))

    for ia, (alpha, ax, col) in enumerate(zip(ALPHA_VALS, axes, colors)):
        v0s, gms, gwbs = [], [], []
        for iv, v0 in enumerate(V0_VALS):
            key = None
            for (ad, vd) in results:
                if abs(ad - alpha) < 0.01 and abs(vd - v0) < v0 * 0.05:
                    key = (ad, vd)
                    break
            if key is None:
                continue
            r = results[key]
            gm = r.get('gamma', np.nan)
            gw = r.get('gamma_wkb', np.nan)
            if not np.isnan(gm):
                v0s.append(v0)
                gms.append(gm)
                gwbs.append(gw)

        v0s_wkb = np.array(V0_VALS)
        gw_curve = np.array([wkb_gamma(alpha, v) for v in v0s_wkb])

        ax.loglog(v0s_wkb, gw_curve, 'k-', lw=1.5, label='WKB')
        if gms:
            ax.loglog(v0s, gms, 'o', color=col, ms=5, label='sim')
        ax.set_title(f'α = {alpha:.3f}', fontsize=9)
        ax.set_xlabel('V₀', fontsize=8)
        ax.set_ylabel('γ (TU⁻¹)', fontsize=8)
        ax.grid(True, which='both', ls=':', alpha=0.4)
        ax.legend(fontsize=7)

    plt.suptitle('Campaign 8: γ(V₀) slices vs WKB   [log-log]', fontsize=12)
    plt.tight_layout()
    plt.savefig('campaign8_slices.png', dpi=150, bbox_inches='tight')
    print('Saved campaign8_slices.png')


def plot_alpha_slices(results):
    """gamma vs alpha for a few V0 values, with WKB overlay (log-log)."""
    # pick 5 representative V0 values
    v0_select_idx = [2, 5, 8, 12, 16, 19]  # spread across log range
    v0_select = [V0_VALS[i] for i in v0_select_idx]
    colors = plt.cm.coolwarm(np.linspace(0.0, 1.0, len(v0_select)))

    fig, ax = plt.subplots(figsize=(8, 6))
    alpha_fine = np.linspace(1.0, 6.0, 200)

    for v0, col in zip(v0_select, colors):
        gw_curve = np.array([wkb_gamma(a, v0) for a in alpha_fine])
        ax.loglog(alpha_fine, gw_curve, '-', color=col, lw=1.5, alpha=0.6,
                  label=f'WKB V₀={v0:.4f}')

        alphas_m, gammas_m = [], []
        for (ad, vd), r in results.items():
            if abs(vd - v0) < v0 * 0.05:
                gm = r.get('gamma', np.nan)
                if not np.isnan(gm):
                    alphas_m.append(ad)
                    gammas_m.append(gm)
        if alphas_m:
            order = np.argsort(alphas_m)
            ax.loglog(np.array(alphas_m)[order], np.array(gammas_m)[order],
                      'o-', color=col, ms=5, lw=1, alpha=0.9)

    ax.set_xlabel('α', fontsize=11)
    ax.set_ylabel('γ (TU⁻¹)', fontsize=11)
    ax.set_title('Campaign 8: γ(α) slices vs WKB  [log-log]')
    ax.legend(fontsize=7, ncol=2)
    ax.grid(True, which='both', ls=':', alpha=0.4)
    plt.tight_layout()
    plt.savefig('campaign8_alpha_slices.png', dpi=150, bbox_inches='tight')
    print('Saved campaign8_alpha_slices.png')


# ── Entry point ────────────────────────────────────────────────────────────────
if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(description='Analyze Campaign 8 results')
    parser.add_argument('--dir', default='.', help='Base directory to search (default: .)')
    args = parser.parse_args()

    results = measure_all(args.dir)
    _, ratio_grid, _ = build_grid(results)

    ok = sum(1 for r in results.values() if not np.isnan(r.get('gamma', np.nan)))
    print(f"\nMeasurable runs: {ok}/{len(results)}")

    n_ok = sum(1 for r in results.values() if not np.isnan(r.get('ratio', np.nan)))
    if n_ok > 0:
        ratios = [r['ratio'] for r in results.values() if not np.isnan(r.get('ratio', np.nan))]
        print(f"Ratio gamma_meas/gamma_WKB: mean={np.mean(ratios):.3f}  "
              f"std={np.std(ratios):.3f}  min={np.min(ratios):.3f}  max={np.max(ratios):.3f}")

    plot_heatmap(ratio_grid)
    plot_scatter(results)
    plot_slices(results)
    plot_alpha_slices(results)
