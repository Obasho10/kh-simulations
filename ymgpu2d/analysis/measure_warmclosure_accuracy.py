#!/usr/bin/env python3
"""Fit gamma from the T1.4 warm-closure campaign's GPU timeseries (cold +
3 warm_T legs at kz=1..8) and compare against the filtered-cold eigensolver
reference from the EPS-scan manifest (alpha=2.0, EPS=0.15, V0=0.05 -- the
same production point). See RESEARCH_ROADMAP.md T1.4 and FINDINGS.md
2026-07-19 "EPS-scan (120 pts) and warm-closure (32 pts) GPU results" for
why this did NOT validate the filters-off hypothesis as hoped.

Usage:
  rsync -a --include='ym_k*_warmcl_*/' --include='ym_k*_warmcl_*/timeseries_k*.csv' \
      --exclude='*' t133:/DATA/ym_kh/ymgpu2d/outputs/ remote_data/warmclosure/
  python3 analysis/measure_warmclosure_accuracy.py remote_data/warmclosure
"""
import os, re, sys, glob
import numpy as np
import pandas as pd

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..'))
DEFAULT_DATA_DIR = os.path.join(ROOT, 'remote_data', 'warmclosure')
EPSSCAN_MANIFEST = os.path.join(ROOT, 'sweep', 'epsscan_manifest.csv')


def best_window_fit(t, logamp, min_efold=2.0, min_span_frac=0.10):
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


def main():
    data_dir = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_DATA_DIR
    rows = []
    for d in sorted(glob.glob(os.path.join(data_dir, "ym_k*_warmcl_*"))):
        m = re.search(r'ym_k(\d+)_.*_warmcl_(\w+)$', os.path.basename(d))
        kz, label = int(m.group(1)), m.group(2)
        f = os.path.join(d, f"timeseries_k{kz}.csv")
        if not os.path.exists(f):
            rows.append(dict(kz=kz, label=label, status='no_csv'))
            continue
        df = pd.read_csv(f)
        t = df['t'].values
        amp = df['amp'].values
        mask = amp > 0
        t, amp = t[mask], amp[mask]
        if len(t) < 8:
            rows.append(dict(kz=kz, label=label, status='too_short', n_rows=len(t)))
            continue
        fit = best_window_fit(t, np.log(amp))
        if fit is None:
            rows.append(dict(kz=kz, label=label, status='no_clean_window'))
            continue
        r2, slope, i, j = fit
        rows.append(dict(kz=kz, label=label, status='ok', gamma_sim=slope, r2=r2,
                         t_final=t[-1]))

    res = pd.DataFrame(rows)
    out_csv = os.path.join(ROOT, 'sweep', 'warmclosure_results.csv')
    res.to_csv(out_csv, index=False)
    print(f"wrote {out_csv}")
    print(f"Total points: {len(res)}")
    print(res['status'].value_counts().to_string())
    print()
    print(res.sort_values(['kz', 'label']).to_string(index=False,
          float_format=lambda x: f"{x:.4f}"))

    eps_man = pd.read_csv(EPSSCAN_MANIFEST)
    ref = eps_man[(eps_man.alpha == 2.0) & (eps_man.EPS == 0.15)][['kz', 'gamma_eig_real']]
    print("\n-- warm gamma(kz) vs filtered-cold eigensolver reference (alpha=2,EPS=0.15) --")
    piv = res[res.status == 'ok'].pivot_table(index='kz', columns='label', values='gamma_sim')
    piv = piv.join(ref.set_index('kz'), how='left')
    print(piv.to_string(float_format=lambda x: f"{x:.4f}"))


if __name__ == '__main__':
    main()
