#!/usr/bin/env python3
"""Extract the kz=0 (spatially-uniform in z, per-x magnitude) component of
Az2/Az3 from a run's raw field dumps, for the noise-seeded kz=0 chromo-Weibel
measurement (`gen_kz0_campaign.py` -- see FINDINGS.md 2026-07-19 "kz=0
extension campaign was CONTAMINATED" for why this exists instead of the
usual seeded-eigenmode approach).

Mirrors remote_timeseries.py's numpy fast path exactly (same math, k=0):
for each x-column, sum Az2+i*Az3 over z (the kz=0 DFT term at that x), take
its magnitude, THEN average that per-x magnitude over x -- NOT the other
order (average the raw complex value over x and z together first). The two
give very different answers here: Az2/Az3's kz=0-in-z profile has real
x-structure (this is a double-tanh background, run_mode=3) with both signs
across x, so averaging raw values over x cancels most of the true signal
and leaves numerical noise -- this is why the first version of this script
(average-everything, "amp = mean(Az2)") measured a hopelessly noisy,
non-monotonic trace instead of Campaign 3's clean 25-e-fold exponential.

The run here is intentionally seeded at a k_mode != 0 (Campaign 3's method:
seed some other channel, let kz=0 grow on its own from residual floating-
point noise) so remote_timeseries.py itself can't be reused directly (its
target k is inferred from the directory name, which encodes the SEEDED
k_mode here, not 0). Deletes the raw ym_*.csv dumps afterward, matching
remote_timeseries.py's disk-hygiene convention.

Usage: python3 extract_kz0_noise.py <glob_pattern> [NX]
Writes timeseries_k0.csv (t,amp,amp_conj -- identical at k=0 by construction,
kept for column-format compatibility with measure_kz0_accuracy.py).
"""
import glob, os, re, sys
import numpy as np
import pandas as pd

NX_DEFAULT = 768
pattern = sys.argv[1] if len(sys.argv) > 1 else "ym_k*_kz0ext*"
NX = int(sys.argv[2]) if len(sys.argv) > 2 else NX_DEFAULT

for run_dir in sorted(glob.glob(pattern)):
    csvs = sorted(glob.glob(f"{run_dir}/ym_*.csv"))
    if not csvs:
        continue

    dt_run = 0.00245437
    ecsv = f"{run_dir}/energy.csv"
    if os.path.exists(ecsv):
        try:
            edf = pd.read_csv(ecsv)
            if len(edf) >= 2:
                dt_run = (edf['time'].iloc[-1] - edf['time'].iloc[0]) / \
                          (edf['step'].iloc[-1] - edf['step'].iloc[0])
        except Exception:
            pass

    nx_m = re.search(r'_nx(\d+)', run_dir)
    nx = int(nx_m.group(1)) if nx_m else NX

    rows_out = []
    for csv_path in csvs:
        try:
            step = int(re.search(r'\d+', os.path.splitext(os.path.basename(csv_path))[0]).group())
            t = step * dt_run
            df_ = pd.read_csv(csv_path, usecols=['Az2', 'Az3'])
            n_total = len(df_)
            nz = n_total // nx
            if nz < 1:
                continue
            sig = (df_['Az2'].values + 1j * df_['Az3'].values).reshape(nz, nx)
            F = sig.sum(axis=0)          # kz=0 DFT term per x-column
            amp = float(np.abs(F).mean() / nz)
            rows_out.append({'t': t, 'amp': amp, 'amp_conj': amp})
        except Exception:
            continue

    if rows_out:
        rows_out.sort(key=lambda r: r['t'])
        pd.DataFrame(rows_out).to_csv(f"{run_dir}/timeseries_k0.csv", index=False)

    for csv_path in csvs:
        os.remove(csv_path)
