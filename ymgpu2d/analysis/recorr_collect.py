#!/usr/bin/env python3
"""Incremental collector for the recorrection campaign (2026-07-18).

Scans remote_data/recorr/*/ym_*_recorr* dirs, fits growth rates for NEW runs
only, sigma-chases the eigensolver reference for NEW points only, and merges
everything into two persistent caches so repeated invocations never redo work:

    sweep/recorr_results.csv   one row per (alpha, V0, kz): fit + theory + error
    sweep/recorr_chased.csv    chased-eigensolver cache (chase_theory_worker format)

A point is re-fitted only if its timeseries has grown (n_pts changed) since it
was cached. gamma_sim prefers the plateau fit (has_plateau) and falls back to
the max-R2 window fit. rel_err is |gamma_sim - gamma_chased| / gamma_chased,
with the eigensolver evaluated at the run's own xi_sponge (sigma-chased).

Usage:  python3 analysis/recorr_collect.py [nproc]     (default nproc=8)
"""
import os, sys, glob, math, subprocess
import numpy as np
import pandas as pd
from multiprocessing import Pool

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..'))
sys.path.insert(0, HERE)
import batch_analyze as BA

RESULTS = os.path.join(ROOT, 'sweep', 'recorr_results.csv')
CHASED = os.path.join(ROOT, 'sweep', 'recorr_chased.csv')
EPS = 0.15


def tier_of(kz):
    e = int(round(kz * 8))
    return "int" if e % 8 == 0 else ("half" if e % 8 == 4 else "fine")


def scan_dirs():
    out = []
    for d in sorted(glob.glob(os.path.join(ROOT, 'remote_data', 'recorr', '*', 'ym_*_recorr*'))):
        parsed = BA.parse_dir(os.path.basename(d))
        if not parsed:
            continue
        kz, alpha, V0, xs = parsed
        ts = os.path.join(d, f'timeseries_k{BA.kz_to_label(kz)}.csv')
        if os.path.exists(ts):
            out.append((round(alpha, 3), round(V0, 4), round(kz, 3), xs, ts, d))
    return out


def fit_one(job):
    alpha, V0, kz, xs, ts, d = job
    try:
        df = pd.read_csv(ts).sort_values('t')
        t, a = df['t'].values, df['amp'].values
        m = a > 0
        t, a = t[m], a[m]
        if len(t) < 8:
            return None
        amp0_log = float(np.log(a[0]))
        g_r2, t0, t1, r2 = BA.fit_growth_rate(t, a, t_min=5.0)
        pl = BA.fit_growth_rate_plateau(t, a)
        gamma_sim = pl['gamma'] if pl['has_plateau'] else g_r2
        return dict(alpha=alpha, V0=V0, kz=kz, tier=tier_of(kz), xi_sponge=xs,
                    n_pts=len(df), amp0_log=amp0_log,
                    gamma_r2=g_r2, r2=r2, t0=t0, t1=t1,
                    gamma_plateau=pl['gamma'], plateau_t0=pl['t0'],
                    plateau_t1=pl['t1'], has_plateau=pl['has_plateau'],
                    gamma_sim=gamma_sim,
                    src=os.path.join(os.path.basename(os.path.dirname(d)),
                                     os.path.basename(d)))
    except Exception as e:
        print(f"  fit failed {d}: {e}", file=sys.stderr)
        return None


def main():
    nproc = int(sys.argv[1]) if len(sys.argv) > 1 else 8

    store = pd.read_csv(RESULTS) if os.path.exists(RESULTS) else pd.DataFrame()
    cached_npts = {}
    if len(store):
        cached_npts = {(r.alpha, r.V0, r.kz): r.n_pts for r in store.itertuples()}

    jobs = scan_dirs()
    todo = [j for j in jobs if cached_npts.get((j[0], j[1], j[2])) != pd_npts(j[4])]
    print(f"{len(jobs)} extracted runs found; {len(todo)} new/updated to fit "
          f"({len(jobs) - len(todo)} cached)")

    if todo:
        with Pool(nproc) as pool:
            fitted = [r for r in pool.map(fit_one, todo) if r]
        new = pd.DataFrame(fitted)
        if len(store):
            keys = set(zip(new['alpha'], new['V0'], new['kz']))
            store = store[[k not in keys for k in
                           zip(store['alpha'], store['V0'], store['kz'])]]
        store = pd.concat([store, new], ignore_index=True)

    if not len(store):
        print("nothing to do")
        return

    # ── chase eigensolver references for points not yet in the cache ──
    chased = pd.read_csv(CHASED) if os.path.exists(CHASED) else \
        pd.DataFrame(columns=['kz', 'alpha', 'V0', 'eps', 'xi_sponge', 'gamma_chased'])
    have = set(zip(chased['kz'].round(3), chased['alpha'].round(3),
                   chased['V0'].round(4), chased['xi_sponge'].round(2)))
    need = store[[(k, a, v, round(x, 2)) not in have for k, a, v, x in
                  zip(store['kz'], store['alpha'], store['V0'], store['xi_sponge'])]]
    need = need[['kz', 'alpha', 'V0', 'xi_sponge']].drop_duplicates()
    if len(need):
        print(f"chasing {len(need)} new eigensolver points ({nproc} workers)...")
        pts = need.copy()
        pts['eps'] = EPS
        todo_csv = os.path.join(ROOT, 'sweep', '_chase_todo.csv')
        pts[['kz', 'alpha', 'V0', 'eps', 'xi_sponge']].to_csv(todo_csv, index=False)
        subprocess.run([sys.executable, os.path.join(HERE, 'chase_theory_worker.py'),
                        todo_csv, CHASED, str(nproc)], check=True)
        os.remove(todo_csv)
        chased = pd.read_csv(CHASED)

    cmap = {(round(r.kz, 3), round(r.alpha, 3), round(r.V0, 4), round(r.xi_sponge, 2)):
            r.gamma_chased for r in chased.itertuples()}
    store['gamma_chased'] = [cmap.get((round(k, 3), round(a, 3), round(v, 4), round(x, 2)), np.nan)
                             for k, a, v, x in zip(store['kz'], store['alpha'],
                                                   store['V0'], store['xi_sponge'])]
    store['ratio'] = store['gamma_sim'] / store['gamma_chased']
    store['rel_err'] = (store['gamma_sim'] - store['gamma_chased']).abs() / store['gamma_chased']
    store = store.sort_values(['V0', 'kz', 'alpha']).reset_index(drop=True)
    store.to_csv(RESULTS, index=False)
    print(f"saved {len(store)} points -> {RESULTS}")

    # ── summary ──
    bad_amp = store[store['amp0_log'] < -20]
    if len(bad_amp):
        print(f"⚠ {len(bad_amp)} runs have noise-level first amplitude (extraction problem?)")
    ok = store.dropna(subset=['gamma_chased'])
    print(f"\nplateau-confirmed: {store['has_plateau'].sum()}/{len(store)}")
    print("\nmedian rel_err by tier (all / plateau-only):")
    for tier in ['int', 'half', 'fine']:
        s = ok[ok['tier'] == tier]
        sp = s[s['has_plateau']]
        if len(s):
            print(f"  {tier:4s}: n={len(s):4d}  {s['rel_err'].median():.3f}  /  "
                  f"n={len(sp):4d}  {sp['rel_err'].median() if len(sp) else float('nan'):.3f}")
    print("\nmedian rel_err by V0 (plateau-only):")
    for v in sorted(ok['V0'].unique()):
        sp = ok[(ok['V0'] == v) & ok['has_plateau']]
        if len(sp):
            print(f"  V0={v:<5}: n={len(sp):4d}  median={sp['rel_err'].median():.3f}  "
                  f"90pct={sp['rel_err'].quantile(0.9):.3f}")
    worst = ok[ok['has_plateau']].nlargest(8, 'rel_err')
    if len(worst):
        print("\nworst plateau-confirmed points:")
        for r in worst.itertuples():
            print(f"  V0={r.V0} kz={r.kz} a={r.alpha} xs={r.xi_sponge}: "
                  f"sim={r.gamma_sim:.4f} th={r.gamma_chased:.4f} ratio={r.ratio:.2f}")


def pd_npts(ts):
    """Row count of a timeseries CSV (cheap: line count minus header)."""
    try:
        with open(ts) as f:
            return sum(1 for _ in f) - 1
    except OSError:
        return -1


if __name__ == '__main__':
    main()
