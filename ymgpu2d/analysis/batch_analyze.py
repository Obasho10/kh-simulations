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
    where C = (2n+1)*sqrt(alpha^3/2)*V0 (wkb.pdf eq.33 / wkbfull.pdf eq.4).

    n=0 (the fundamental mode) only. The bare quartic used here is the
    zeroth-order harmonic-core WKB result; it drops the anharmonic C2*x^4
    correction that wkbfull.pdf secs.7-8 derive to extend validity to
    higher n. Without that correction, scanning n upward does not track a
    real ladder of subdominant excited states -- growth rate rises
    without bound as n->inf, asymptoting to the same cubic that governs
    the delocalized kz=0 chromo-Weibel mode (gamma ~ C(n)^(1/3)), because
    the harmonic-well/localization assumption has left its validity
    regime, not because a higher-n bound state genuinely dominates. Adding
    the anharmonic correction (eq.12) instead makes gamma(n) monotonically
    decreasing as expected, confirming n=0 is dominant -- so scanning here
    would just be extra work for the same answer, not a different one.
    """
    C = np.sqrt(alpha**3 / 2.0) * V0  # n=0: (2*0+1) = 1
    coeffs = [1.0, 0.0, -kz**2, -C, -alpha**2 * V0 * kz]
    roots = np.roots(coeffs)
    growing = roots[roots.imag > 1e-8]
    return float(np.max(growing.imag)) if len(growing) else 0.0


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


# ── Plateau-based growth rate (fitter-independent alternative) ────────
def _local_slope_series(times, log_a, win_tu):
    """d(ln amp)/dt via a sliding window of width win_tu (TU), one estimate
    per sample that has a full window on both sides."""
    n = len(times)
    half = win_tu / 2.0
    tc, slopes = [], []
    for i in range(n):
        m = (times >= times[i] - half) & (times <= times[i] + half)
        if m.sum() < 4:
            continue
        tw, aw = times[m], log_a[m]
        c = np.polyfit(tw, aw, 1)
        tc.append(times[i])
        slopes.append(c[0])
    return np.array(tc), np.array(slopes)


def fit_growth_rate_plateau(times, amps, win_tu=8.0, min_plateau_tu=10.0, flat_tol=0.06):
    """Plateau-based growth rate — the fitter-independent alternative to
    fit_growth_rate()'s max-R2 window search (PRESENTATION.md Sec 8.5).

    max-R2 is attracted to regime transitions on multi-regime curves (seed
    transient -> plateau -> late kink): a smooth transition between two
    different slopes is locally the straightest part of the curve, so
    R2=1.000 certifies local straightness, not physical growth-phase
    placement. This instead computes the local slope d(ln amp)/dt in a
    sliding window of width win_tu, then finds the LONGEST contiguous run of
    samples whose local slope stays within flat_tol (relative, peak-to-peak
    over the whole run) of the run's own median. If no run reaches
    min_plateau_tu there is no reliable measurement (as at C25 kz=6) and this
    returns has_plateau=False rather than a fitter-dependent guess.

    Defaults (win_tu=8, min_plateau_tu=10, flat_tol=0.06) were tuned against
    the C25 audit in PRESENTATION.md Sec 5.2/8.5: reproduces the documented
    plateau gamma for kz=1-5 to within 0.1-0.6% (targets 0.0889, 0.1211,
    0.0927, 0.0810, 0.0643) and correctly reports no plateau for kz=6.
    """
    log_a = np.log(np.clip(amps, 1e-30, None))
    empty = {'gamma': np.nan, 't0': np.nan, 't1': np.nan, 'duration': np.nan,
             'has_plateau': False}
    if len(times) < 8:
        return empty

    tc, slopes = _local_slope_series(times, log_a, win_tu)
    if len(tc) < 4:
        return empty

    pos = slopes > 1e-6
    n = len(tc)
    best = None
    i = 0
    while i < n:
        if not pos[i]:
            i += 1
            continue
        run_idx = [i]
        j = i + 1
        while j < n and pos[j]:
            trial = run_idx + [j]
            vals = slopes[trial]
            med = np.median(vals)
            spread = (vals.max() - vals.min()) / med
            if spread <= flat_tol:
                run_idx = trial
                j += 1
            else:
                break
        duration = tc[run_idx[-1]] - tc[run_idx[0]]
        if duration >= min_plateau_tu and (best is None or duration > best[1]):
            best = (run_idx, duration)
        i = run_idx[-1] + 1 if len(run_idx) > 1 else i + 1

    if best is None:
        return empty
    run_idx, duration = best
    t0, t1 = tc[run_idx[0]], tc[run_idx[-1]]
    m = (times >= t0) & (times <= t1)
    c = np.polyfit(times[m], log_a[m], 1)
    return {'gamma': float(c[0]), 't0': float(t0), 't1': float(t1),
            'duration': float(duration), 'has_plateau': True}


# ── Parse directory name ──────────────────────────────────────────────
def parse_dir(dname):
    """Extract kz_phys, alpha, V0, xi_sponge from directory name.
    For Lz=4pi runs (lz12.566 in name), kz_physical = k_mode / 2.
    """
    m_k  = re.search(r'ym_k(\d+)_', dname)
    m_a  = re.search(r'_a([\d.]+)_', dname)
    m_v  = re.search(r'_v([\d.]+)_', dname)
    m_sp = re.search(r'_sp([\d.]+)_', dname)
    if not (m_k and m_a):
        return None
    k_mode = int(m_k.group(1))
    lz4pi  = bool(re.search(r'lz12\.56|lz4pi|_lz4', dname)) or \
             (bool(re.search(r'_bp28', dname)) and k_mode % 2 == 1)
    lz16pi = bool(re.search(r'_bp55', dname))
    if lz16pi:
        kz = k_mode / 8.0
    elif lz4pi:
        kz = k_mode / 2.0
    else:
        kz = float(k_mode)
    alpha = float(m_a.group(1))
    V0 = float(m_v.group(1)) if m_v else 0.1
    xi_sp = float(m_sp.group(1)) if m_sp else 0.0
    return kz, alpha, V0, xi_sp


def kz_to_label(kz):
    """Convert kz float to timeseries filename label (1→'1', 1.5→'1p5', 0.125→'0p125')."""
    kz = round(kz, 3)
    if kz == int(kz):
        return str(int(kz))
    return f"{kz:.3f}".rstrip('0').replace('.', 'p')


def analyze_node(node_dir):
    node_dir = Path(node_dir)
    rows = []
    # collect run dirs: both direct children and those under outputs/ subdir
    run_dirs = []
    for d in sorted(node_dir.iterdir()):
        if not d.is_dir():
            continue
        if d.name == 'outputs':
            run_dirs.extend(sorted(d.iterdir()))
        else:
            run_dirs.append(d)
    for run_dir in run_dirs:
        if not run_dir.is_dir():
            continue
        parsed = parse_dir(run_dir.name)
        if parsed is None:
            continue
        kz, alpha, V0, xi_sp = parsed
        ts_file = run_dir / f'timeseries_k{kz_to_label(kz)}.csv'
        if not ts_file.exists():
            continue
        try:
            df = pd.read_csv(ts_file)
            if len(df) < 5:
                continue
            times = df['t'].values.astype(float)
            amps  = df['amp'].values.astype(float)
            gamma, t0, t1, r2 = fit_growth_rate(times, amps)
            plateau = fit_growth_rate_plateau(times, amps)
            gamma_ex = wkb_exact_gamma(alpha, V0, kz)
            rows.append({
                'kz': kz, 'alpha': alpha, 'V0': V0, 'xi_sponge': xi_sp,
                'gamma_sim': round(gamma, 5),
                'gamma_exact': round(gamma_ex, 5),
                'ratio': round(gamma / gamma_ex, 3) if gamma_ex > 0 else float('nan'),
                'R2': round(r2, 4),
                't0': round(t0, 1) if np.isfinite(t0) else float('nan'),
                't1': round(t1, 1) if np.isfinite(t1) else float('nan'),
                'has_plateau': plateau['has_plateau'],
                'gamma_plateau': round(plateau['gamma'], 5) if np.isfinite(plateau['gamma']) else float('nan'),
                'plateau_t0': round(plateau['t0'], 1) if np.isfinite(plateau['t0']) else float('nan'),
                'plateau_t1': round(plateau['t1'], 1) if np.isfinite(plateau['t1']) else float('nan'),
                'plateau_ratio': round(plateau['gamma'] / gamma_ex, 3) if (gamma_ex > 0 and np.isfinite(plateau['gamma'])) else float('nan'),
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
