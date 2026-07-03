#!/usr/bin/env python3
"""Extract Az_circ(t) time series and write small summary CSV per run.

After writing timeseries_k*.csv, deletes ym_*.csv field dumps to save disk space.
Usage: python3 remote_timeseries.py [glob_pattern]
"""
import numpy as np, os, glob, re, sys
from pathlib import Path
import pandas as pd

NX = 768
pattern = sys.argv[1] if len(sys.argv) > 1 else "ym_k*_a*_circ_az2seed*"

for run_dir in sorted(glob.glob(pattern)):
    m = re.search(r'ym_k(\d+)_', run_dir)
    if not m: continue
    k = int(m.group(1))
    csvs = sorted(glob.glob(f"{run_dir}/ym_*.csv"))
    if not csvs: continue
    # get DT from energy.csv
    dt_run = 0.00245437
    ecsv = f"{run_dir}/energy.csv"
    if os.path.exists(ecsv):
        edf = pd.read_csv(ecsv)
        if len(edf) >= 2:
            dt_run = float(edf['time'].iloc[-1]-edf['time'].iloc[0]) / float(edf['step'].iloc[-1]-edf['step'].iloc[0])
    rows = []
    for csv in csvs:
        try:
            step = int(re.search(r'\d+', Path(csv).stem).group())
            t = step * dt_run
            df = pd.read_csv(csv)
            nz = len(df) // NX
            Az2 = df['Az2'].values.reshape(nz, NX)
            Az3 = df['Az3'].values.reshape(nz, NX)
            Fre = np.fft.rfft(Az2, axis=0)[k, :] / nz
            Fim = np.fft.rfft(Az3, axis=0)[k, :] / nz
            amp = float(np.mean(np.abs(Fre + 1j * Fim)))
            rows.append({'t': t, 'amp': amp})
        except Exception:
            pass
    if not rows: continue
    out = f"{run_dir}/timeseries_k{k}.csv"
    pd.DataFrame(rows).to_csv(out, index=False)
    print(f"Wrote {len(rows)} pts → {out}")
    # Delete large field dumps now that timeseries is extracted
    for csv in csvs:
        os.remove(csv)
    print(f"  Cleaned {len(csvs)} field dumps from {run_dir}")
