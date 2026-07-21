#!/usr/bin/env python3
"""Fit gamma from the T1.1 EPS-scan campaign's GPU timeseries and report
sim/exact accuracy vs the eigensolver (`sweep/epsscan_manifest.csv`'s
`gamma_eig_real`), plus kz_peak(EPS) from the real data (RESEARCH_ROADMAP.md
T1.1, FINDINGS.md 2026-07-19 "EPS-scan (120 pts) and warm-closure (32 pts)
GPU results").

Usage:
  rsync -a --include='ym_k*_epsscan/' --include='ym_k*_epsscan/timeseries_k*.csv' \
      --exclude='*' t126:/DATA/cm/lcpfct/ymgpu2d/outputs/ remote_data/epsscan/t126/
  rsync -a --include='ym_k*_epsscan/' --include='ym_k*_epsscan/timeseries_k*.csv' \
      --exclude='*' t140:/DATA/cm/lcpfct/ymgpu2d/outputs/ remote_data/epsscan/t140/
  python3 analysis/measure_epsscan_accuracy.py remote_data/epsscan

Matches each manifest row to its output directory using the exact
xi_sponge/nx_override/lx_override values from the manifest (not just k/alpha)
-- output dirs can carry stale duplicates from earlier campaign-generator
iterations (same k/alpha/EPS, different sponge/box choice) that a looser
glob would silently pick up the wrong one from.
"""
import os, sys, glob
import numpy as np
import pandas as pd

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..'))
DEFAULT_DATA_DIR = os.path.join(ROOT, 'remote_data', 'epsscan')
MANIFEST = os.path.join(ROOT, 'sweep', 'epsscan_manifest.csv')


def best_window_fit(t, logamp, min_efold=2.5, min_span_frac=0.15):
    n = len(t)
    best = None
    min_span = (t[-1] - t[0]) * min_span_frac
    for i in range(0, n - 5):
        for j in range(i + 5, n):
            if logamp[j] - logamp[i] < min_efold:
                continue
            if t[j] - t[i] < min_span:
                continue
            tt, ll = t[i:j+1], logamp[i:j+1]
            A = np.vstack([tt, np.ones_like(tt)]).T
            slope, intercept = np.linalg.lstsq(A, ll, rcond=None)[0]
            pred = slope * tt + intercept
            ss_res = np.sum((ll - pred) ** 2)
            ss_tot = np.sum((ll - ll.mean()) ** 2)
            r2 = 1 - ss_res / ss_tot if ss_tot > 0 else 0
            if best is None or r2 > best[0]:
                best = (r2, slope, i, j)
    return best


def find_dir(data_dir, stream, r):
    base = os.path.join(data_dir, str(stream))
    k, alpha, sp = int(r['k_mode']), r['alpha'], r['xi_sponge']
    nx, lx = r['nx_override'], r['lx_override']
    tags = [f"ym_k{k}_a{alpha:.3f}_circ_az2seed_v0.0500", f"sp{sp:.1f}"]
    if nx > 0:
        tags.append(f"nx{int(nx)}")
    if lx > 0:
        tags.append(f"lx{lx:.2f}")
    for c in glob.glob(f"{base}/{tags[0]}*epsscan"):
        if all(t in os.path.basename(c) for t in tags[1:]):
            return c
    return None


def main():
    data_dir = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_DATA_DIR
    man = pd.read_csv(MANIFEST)
    rows = []
    for _, r in man.iterrows():
        d = find_dir(data_dir, r['stream'], r)
        if d is None:
            rows.append(dict(**r, status='no_dir'))
            continue
        f = os.path.join(d, f"timeseries_k{int(r['k_mode'])}.csv")
        if not os.path.exists(f):
            rows.append(dict(**r, status='no_csv'))
            continue
        df = pd.read_csv(f)
        t = df['t'].values
        amp = df['amp'].values
        mask = amp > 0
        t, amp = t[mask], amp[mask]
        if len(t) < 8:
            rows.append(dict(**r, status='too_short', n_rows=len(t)))
            continue
        fit = best_window_fit(t, np.log(amp))
        if fit is None:
            rows.append(dict(**r, status='no_clean_window'))
            continue
        r2, slope, i, j = fit
        rows.append(dict(**r, status='ok', gamma_sim=slope, r2=r2,
                         n_efold=np.log(amp[j]) - np.log(amp[i])))
    res = pd.DataFrame(rows)
    out_csv = os.path.join(ROOT, 'sweep', 'epsscan_results.csv')
    res.to_csv(out_csv, index=False)
    print(f"wrote {out_csv}")

    print(f"Total points: {len(res)}")
    print(res['status'].value_counts().to_string())
    ok = res[res['status'] == 'ok'].copy()
    if not len(ok):
        return
    ok['sim_over_eig'] = ok['gamma_sim'] / ok['gamma_eig_real']
    print(f"\nFitted OK: {len(ok)}/{len(res)}")
    print(f"Median sim/exact(eigensolver): {ok['sim_over_eig'].median():.3f}  "
          f"IQR [{ok['sim_over_eig'].quantile(.25):.3f}, {ok['sim_over_eig'].quantile(.75):.3f}]")

    print("\n-- sim/exact by alpha --")
    for a, g in ok.groupby('alpha'):
        print(f"  alpha={a:<4} n={len(g):3d}  median sim/exact={g['sim_over_eig'].median():.3f}")

    print("\n-- kz_peak(EPS) from SIM data (argmax gamma_sim over kz) --")
    for alpha, ga in ok.groupby('alpha'):
        print(f" alpha={alpha}:")
        for eps, ge in ga.groupby('EPS'):
            idx = ge['gamma_sim'].idxmax()
            print(f"    EPS={eps:<6} kz_peak={ge.loc[idx, 'kz']:<4} "
                  f"gamma_sim_peak={ge.loc[idx, 'gamma_sim']:.4f}  (n={len(ge)}/8)")

    bad = res[res['status'] != 'ok']
    if len(bad):
        print(f"\n-- non-OK points ({len(bad)}) --")
        print(bad[['alpha', 'EPS', 'kz', 'status']].to_string(index=False))


if __name__ == '__main__':
    main()
