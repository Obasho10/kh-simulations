#!/usr/bin/env python3
"""Batch growth-rate extraction from pre-computed timeseries_k*.csv files.

Usage:
    python3 batch_analyze.py remote_data/abi remote_data/t130 remote_data/t140
    python3 batch_analyze.py remote_data/abi  # single node

Outputs a CSV summary: alpha, V0, kz, gamma_sim, R2, t0, t1, xi_sponge, source_dir
"""

import sys, re, os
import numpy as np
import pandas as pd
from pathlib import Path
from scipy.optimize import brentq


# ── WKB exact growth rate (quartic polynomial) ────────────────────────
def wkb_exact_gamma(alpha, V0, kz):
    """Max Im(omega) from omega^4 - kz^2*omega^2 - C*omega - alpha^2*V0*kz = 0
    where C = sqrt(alpha^3/2)*V0 (n=0 dominant at low coupling).
    Scan n=0..20 and return the best (highest gamma)."""
    best = 0.0
    n_max_f = 0.5 * (np.sqrt(2) * alpha**2.5 / (V0**2 * kz**3) - 1)
    n_max = min(int(np.floor(n_max_f)), 50) if n_max_f >= 0 else -1
    for n in range(max(0, n_max) + 1):
        C = (2*n + 1) * np.sqrt(alpha**3 / 2.0) * V0
        coeffs = [1.0, 0.0, -kz**2, -C, -alpha**2 * V0 * kz]
        roots = np.roots(coeffs)
        growing = roots[roots.imag > 1e-8]
        if len(growing):
            g = float(np.max(growing.imag))
            if g > best:
                best = g
    return best


# ── Growth rate fit (same algorithm as dispersion_ym.py) ─────────────
def fit_growth_rate(times, amps, t_min=None, t_max=None, min_win_frac=0.15):
    log_a = np.log(np.clip(amps, 1e-30, None))
    mask = np.ones(len(times), dtype=bool)
    if t_min is not None:
        mask &= times >= t_min
    if t_max is not None:
        mask &= times <= t_max
    tw, aw = times[mask], log_a[mask]
    if len(tw) < 4:
        return 0.0, np.nan, np.nan, 0.0

    min_win = max(4, int(len(tw) * min_win_frac))
    best = {'r2': -1e9, 'gamma': 0.0, 't0': np.nan, 't1': np.nan}
    for i in range(len(tw)):
        for j in range(i + min_win, len(tw) + 1):
            tw_s, aw_s = tw[i:j], aw[i:j]
            c = np.polyfit(tw_s, aw_s, 1)
            if c[0] < 1e-6:
                continue
            res = aw_s - np.polyval(c, tw_s)
            ss_res = np.sum(res**2)
            ss_tot = np.sum((aw_s - aw_s.mean())**2)
            r2 = 1.0 - ss_res / (ss_tot + 1e-30)
            if r2 > best['r2']:
                best = {'r2': r2, 'gamma': c[0], 't0': tw_s[0], 't1': tw_s[-1]}
    return best['gamma'], best['t0'], best['t1'], best['r2']


# ── Parse directory name ──────────────────────────────────────────────
def parse_dir(dname):
    """Extract kz, alpha, V0, xi_sponge from directory name."""
    m_k  = re.search(r'ym_k(\d+)_', dname)
    m_a  = re.search(r'_a([\d.]+)_', dname)
    m_v  = re.search(r'_v([\d.]+)_', dname)
    m_sp = re.search(r'_sp([\d.]+)_', dname)
    if not (m_k and m_a):
        return None
    kz = int(m_k.group(1))
    alpha = float(m_a.group(1))
    V0 = float(m_v.group(1)) if m_v else 0.1
    xi_sp = float(m_sp.group(1)) if m_sp else 0.0
    return kz, alpha, V0, xi_sp


def analyze_node(node_dir):
    node_dir = Path(node_dir)
    rows = []
    for run_dir in sorted(node_dir.iterdir()):
        if not run_dir.is_dir():
            continue
        parsed = parse_dir(run_dir.name)
        if parsed is None:
            continue
        kz, alpha, V0, xi_sp = parsed
        ts_file = run_dir / f'timeseries_k{kz}.csv'
        if not ts_file.exists():
            continue
        try:
            df = pd.read_csv(ts_file)
            if len(df) < 5:
                continue
            times = df['t'].values.astype(float)
            amps  = df['amp'].values.astype(float)
            gamma, t0, t1, r2 = fit_growth_rate(times, amps)
            gamma_ex = wkb_exact_gamma(alpha, V0, kz)
            rows.append({
                'kz': kz, 'alpha': alpha, 'V0': V0, 'xi_sponge': xi_sp,
                'gamma_sim': round(gamma, 5),
                'gamma_exact': round(gamma_ex, 5),
                'ratio': round(gamma / gamma_ex, 3) if gamma_ex > 0 else float('nan'),
                'R2': round(r2, 4),
                't0': round(t0, 1) if np.isfinite(t0) else float('nan'),
                't1': round(t1, 1) if np.isfinite(t1) else float('nan'),
                'source': run_dir.name,
                'node': node_dir.name,
            })
        except Exception as e:
            print(f"  SKIP {run_dir.name}: {e}", file=sys.stderr)
    return rows


def main():
    dirs = sys.argv[1:] if len(sys.argv) > 1 else ['remote_data/abi', 'remote_data/t130', 'remote_data/t140']
    all_rows = []
    for d in dirs:
        rows = analyze_node(d)
        all_rows.extend(rows)
        print(f"{d}: {len(rows)} runs analyzed")

    df = pd.DataFrame(all_rows)
    if df.empty:
        print("No data found.")
        return

    df = df.sort_values(['alpha', 'V0', 'kz']).reset_index(drop=True)
    out = Path('/home/user/kh/ymgpu2d/batch_results.csv')
    df.to_csv(out, index=False)
    print(f"\nSaved {len(df)} rows → {out}")

    # Print summary grouped by (alpha, V0)
    print("\n=== Summary by (alpha, V0) ===")
    for (alpha, V0), grp in df.groupby(['alpha', 'V0']):
        best = grp.loc[grp['gamma_sim'].idxmax()]
        print(f"  α={alpha:.1f} V0={V0:.3f}: kz=1..{grp['kz'].max()}, "
              f"kz_peak={best['kz']} (γ={best['gamma_sim']:.4f}), "
              f"γ_exact_peak={best['gamma_exact']:.4f}, ratio={best['ratio']:.3f}")


if __name__ == '__main__':
    main()
