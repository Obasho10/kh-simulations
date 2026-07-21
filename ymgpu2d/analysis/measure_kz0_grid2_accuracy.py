#!/usr/bin/env python3
"""Fit gamma from the kz0v3 coarse deviation-mapping grid (`gen_kz0_grid2.py`,
180 pts: V0 in {0.03..0.10 step 0.01, 0.20} x alpha in {0.4..8.0 step 0.4})
and report deviation vs the WKB prediction. Same best-window log-linear fit
as measure_kz0_accuracy.py (see that file + FINDINGS.md "kz=0 extension
campaign CLOSED OUT" for the known limitation: this fit captures a
pre-asymptotic transient at low alpha*V0, not the true eigenvalue, so
per-point gamma values here inherit that same caveat -- this script exists
to *map* the resulting bias pattern, not to certify it as a clean sweep).

Usage: python3 analysis/measure_kz0_grid2_accuracy.py [remote_data/kz0v3] [out_csv]
"""
import os, re, sys, glob, math
import numpy as np
import pandas as pd

DEFAULT_DATA_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..',
                                'remote_data', 'kz0v3')


def gamma_kz0_wkb(alpha, V0):
    C = math.sqrt(alpha ** 3 / 2.0) * V0
    return C ** (1.0 / 3.0) * math.sin(math.pi / 3.0)


def best_window_fit(t, logamp, min_efold=3.0, min_span_frac=0.15):
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
    out_csv = sys.argv[2] if len(sys.argv) > 2 else None
    rows = []
    dirs = sorted(glob.glob(os.path.join(data_dir, "ym_k1_a*_kz0v3*")))
    if not dirs:
        print(f"No ym_k1_*_kz0v3* dirs found in {data_dir}", file=sys.stderr)
        sys.exit(1)
    for d in dirs:
        m = re.search(r'ym_k1_a([\d.]+)_.*_v([\d.]+)_', os.path.basename(d))
        alpha, V0 = float(m.group(1)), float(m.group(2))
        f = os.path.join(d, "timeseries_k0.csv")
        if not os.path.exists(f):
            rows.append(dict(alpha=alpha, V0=V0, status='no_file'))
            continue
        df = pd.read_csv(f)
        t = df['t'].values
        amp = df['amp'].values
        mask = amp > 0
        t, amp = t[mask], amp[mask]
        if len(t) < 10:
            rows.append(dict(alpha=alpha, V0=V0, status='too_short', n_rows=len(t)))
            continue
        logamp = np.log(amp)
        fit = best_window_fit(t, logamp)
        if fit is None:
            rows.append(dict(alpha=alpha, V0=V0, status='no_clean_window',
                             amp0=amp[0], ampf=amp[-1]))
            continue
        r2, slope, i, j = fit
        gw = gamma_kz0_wkb(alpha, V0)
        rel_err = (slope - gw) / gw
        rows.append(dict(alpha=alpha, V0=V0, status='ok', gamma_fit=slope, gamma_wkb=gw,
                         rel_err=rel_err, r2=r2, t_start=t[i], t_end=t[j],
                         t_final=t[-1], n_efold=logamp[j] - logamp[i]))

    res = pd.DataFrame(rows)
    print(f"Total points: {len(res)}")
    print(res['status'].value_counts().to_string())
    ok = res[res['status'] == 'ok']
    print(f"\nFitted OK: {len(ok)}/{len(res)}")
    if len(ok):
        print(f"\nMedian |rel_err|: {ok['rel_err'].abs().median()*100:.1f}%")
        print(f"Mean |rel_err|:   {ok['rel_err'].abs().mean()*100:.1f}%")
        print(f"Median R^2:       {ok['r2'].median():.4f}")

        print("\n-- rel_err vs alpha (median over V0) --")
        for a, g in ok.groupby('alpha'):
            print(f"  alpha={a:<4} n={len(g):2d}  median_rel_err={g['rel_err'].median()*100:+7.1f}%  "
                  f"median|rel_err|={g['rel_err'].abs().median()*100:6.1f}%")

        print("\n-- full table --")
        print(ok[['alpha', 'V0', 'gamma_fit', 'gamma_wkb', 'rel_err', 'r2', 'n_efold', 't_final']]
              .sort_values(['alpha', 'V0']).to_string(index=False,
              float_format=lambda x: f"{x:.4f}"))

    bad = res[res['status'] != 'ok']
    if len(bad):
        print(f"\n-- non-OK points ({len(bad)}) --")
        print(bad.to_string(index=False))

    if out_csv:
        res.to_csv(out_csv, index=False)
        print(f"\nWrote {out_csv}")


if __name__ == '__main__':
    main()
