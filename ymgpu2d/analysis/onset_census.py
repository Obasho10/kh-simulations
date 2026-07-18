#!/usr/bin/env python3
"""
onset_census.py — population statistics of the late-onset outer-region
catastrophe across every run with an energy.csv (2026-07-15 investigation,
see OUTER_REGION.md).

For each run directory under the given roots:
  * parse (k_mode, alpha, V0, mechanism sp/xc + radius, bp) from the dir name
    and physical kz from the timeseries_k*.csv filename (k2p5 → 2.5);
  * classify the energy history: clean / creep (E_ratio rising but bounded) /
    catastrophe (jump to E_ratio > 100 or >10× in one output interval);
  * fit the pre-jump contamination growth rate from ln(E_ratio − 1) — for a
    contaminant growing on a constant background, E/E0 = 1 + (Ec/E0)·e^{2γt},
    so this fit measures 2γ_contam directly;
  * tabulate against the two candidate mechanisms:
      2γ_ts  — color-1 cold two-stream at the retained kz
               (outer_region_theory.gamma_twostream; α-independent, ∝V0 at
               small kV — the eigensolver is blind to this channel)
      γ_WKB  — the physical shear mode (α-dependent) for contrast.

Usage:
  python3 onset_census.py <root1> [<root2> ...] --out onset_census.csv
"""
import sys, os, re, glob, argparse
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import ym_eigenmode as E
from outer_region_theory import gamma_twostream

NAME_RE = re.compile(
    r'ym_k(?P<k>\d+)_a(?P<alpha>[\d.]+)_.*?_v(?P<V0>[\d.]+)'
    r'_(?P<mech>sp|xc)(?P<radius>[\d.]+)_eps(?P<eps>[\d.]+)')
BP_RE = re.compile(r'_bp(?P<bp>\d+)')
TS_RE = re.compile(r'timeseries_k(?P<kz>[\dp]+)\.csv')


def parse_dir(d):
    m = NAME_RE.search(os.path.basename(d))
    if not m:
        return None
    info = dict(k_mode=int(m.group('k')), alpha=float(m.group('alpha')),
                V0=float(m.group('V0')), mech=m.group('mech'),
                radius=float(m.group('radius')), eps=float(m.group('eps')))
    mb = BP_RE.search(os.path.basename(d))
    info['bp'] = int(mb.group('bp')) if mb else -1
    ts = glob.glob(os.path.join(d, 'timeseries_k*.csv'))
    if ts:
        mt = TS_RE.search(os.path.basename(ts[0]))
        if mt:
            info['kz_phys'] = float(mt.group('kz').replace('p', '.'))
    return info


def analyze_energy(fname, jump_factor=10.0, cat_ratio=100.0):
    """Return dict with t_end, E_last, class, t_cat, creep(2γ), creep_r2."""
    try:
        d = np.genfromtxt(fname, delimiter=',', names=True)
    except Exception:
        return None
    if d.size < 4:
        return None
    t = np.atleast_1d(d['time'])
    r = np.atleast_1d(d['E_ratio'])
    ok = np.isfinite(t) & np.isfinite(r)
    t, r = t[ok], r[ok]
    if len(t) < 4:
        return None
    out = dict(t_end=float(t[-1]), E_last=float(r[-1]))

    # catastrophe detection: E_ratio crossing cat_ratio, or a single-interval
    # jump by more than jump_factor while already elevated
    i_cat = None
    for i in range(1, len(r)):
        if r[i] > cat_ratio or (r[i] > jump_factor * max(r[i - 1], 1.0)
                                and r[i] > 5.0):
            i_cat = i
            break
    out['t_cat'] = float(t[i_cat]) if i_cat is not None else np.nan

    # creep fit on ln(E_ratio - 1) before the jump
    stop = i_cat if i_cat is not None else len(r)
    exc = r[:stop] - 1.0
    tt = t[:stop]
    m = (exc > 0.02) & (exc < 4.0)
    out['creep2g'] = np.nan
    out['creep_r2'] = np.nan
    if m.sum() >= 5:
        x, y = tt[m], np.log(exc[m])
        A = np.vstack([x, np.ones_like(x)]).T
        (slope, icpt), res, *_ = np.linalg.lstsq(A, y, rcond=None)
        ss_tot = np.sum((y - y.mean()) ** 2)
        r2 = 1.0 - (res[0] / ss_tot if len(res) and ss_tot > 0 else np.nan)
        out['creep2g'] = float(slope)
        out['creep_r2'] = float(r2)

    if i_cat is not None:
        out['cls'] = 'catastrophe'
    elif out['E_last'] > 1.2:
        out['cls'] = 'creep'
    else:
        out['cls'] = 'clean'
    return out


def main():
    p = argparse.ArgumentParser()
    p.add_argument('roots', nargs='+')
    p.add_argument('--out', default='onset_census.csv')
    args = p.parse_args()

    rows = []
    for root in args.roots:
        for d in sorted(glob.glob(os.path.join(root, 'ym_k*'))):
            if not os.path.isdir(d):
                continue
            info = parse_dir(d)
            if info is None or 'kz_phys' not in info:
                continue
            en = os.path.join(d, 'energy.csv')
            if not os.path.exists(en):
                continue
            res = analyze_energy(en)
            if res is None:
                continue
            kz, al, V0 = info['kz_phys'], info['alpha'], info['V0']
            g_ts = gamma_twostream(kz, V0)
            g_wkb = E.wkb_growth_rate(kz, al, V0)
            rows.append(dict(node=os.path.basename(root.rstrip('/')),
                             run=os.path.basename(d), **info, **res,
                             gamma_ts=g_ts, two_gamma_ts=2 * g_ts,
                             gamma_wkb=g_wkb))
    if not rows:
        print("no runs parsed"); return
    import csv
    keys = list(rows[0].keys())
    with open(args.out, 'w', newline='') as f:
        w = csv.DictWriter(f, fieldnames=keys)
        w.writeheader()
        w.writerows(rows)
    n_cat = sum(1 for r in rows if r['cls'] == 'catastrophe')
    n_creep = sum(1 for r in rows if r['cls'] == 'creep')
    print(f"wrote {args.out}: {len(rows)} runs "
          f"({n_cat} catastrophe, {n_creep} creep, "
          f"{len(rows)-n_cat-n_creep} clean)")

    # quick correlation summary for runs with a good creep fit
    good = [r for r in rows if np.isfinite(r['creep2g'])
            and r['creep_r2'] > 0.9 and r['creep2g'] > 0.02]
    if good:
        obs = np.array([r['creep2g'] for r in good])
        ts = np.array([r['two_gamma_ts'] for r in good])
        wk = np.array([2 * r['gamma_wkb'] for r in good])
        fin = np.isfinite(wk)
        print(f"\n{len(good)} runs with clean creep fits (r²>0.9):")
        print(f"  median creep2g/2γ_ts  = {np.median(obs/ts):.3f}  "
              f"(IQR {np.percentile(obs/ts,25):.3f}–{np.percentile(obs/ts,75):.3f})")
        if fin.sum() > 3:
            print(f"  median creep2g/2γ_WKB = {np.median(obs[fin]/wk[fin]):.3f}  "
                  f"(IQR {np.percentile(obs[fin]/wk[fin],25):.3f}–"
                  f"{np.percentile(obs[fin]/wk[fin],75):.3f})")
        corr_ts = np.corrcoef(obs, ts)[0, 1]
        print(f"  corr(creep2g, 2γ_ts) = {corr_ts:.3f}")
        if fin.sum() > 3:
            print(f"  corr(creep2g, 2γ_WKB) = {np.corrcoef(obs[fin], wk[fin])[0,1]:.3f}")


if __name__ == '__main__':
    main()
