#!/usr/bin/env python3
"""Extract Az_circ(t) time series and write small summary CSV per run.

After writing timeseries_k*.csv, deletes ym_*.csv field dumps to save disk space.
Uses only stdlib so it works on servers without numpy/pandas.

Usage: python3 remote_timeseries.py [glob_pattern]
"""
import csv, cmath, glob, math, os, re, sys
from pathlib import Path

NX = 768

pattern = sys.argv[1] if len(sys.argv) > 1 else "ym_k*_a*_circ_az2seed*"

for run_dir in sorted(glob.glob(pattern)):
    m = re.search(r'ym_k(\d+)_', run_dir)
    if not m:
        continue
    k = int(m.group(1))
    # For Lz=4pi runs (lz12.566... in dir name), kz_physical = k/2
    lz4pi = bool(re.search(r'lz12\.56|lz4pi|_lz4', run_dir))
    csvs = sorted(glob.glob(f"{run_dir}/ym_*.csv"))
    if not csvs:
        continue

    # get DT from energy.csv
    dt_run = 0.00245437
    ecsv = f"{run_dir}/energy.csv"
    if os.path.exists(ecsv):
        try:
            with open(ecsv) as f:
                rows = list(csv.DictReader(f))
            if len(rows) >= 2:
                dt_run = (float(rows[-1]['time']) - float(rows[0]['time'])) / \
                          (float(rows[-1]['step']) - float(rows[0]['step']))
        except Exception:
            pass

    rows_out = []
    for csv_path in csvs:
        try:
            step = int(re.search(r'\d+', Path(csv_path).stem).group())
            t = step * dt_run
            with open(csv_path) as f:
                reader = csv.DictReader(f)
                az2_col = []
                az3_col = []
                for row in reader:
                    az2_col.append(float(row['Az2']))
                    az3_col.append(float(row['Az3']))
            n_total = len(az2_col)
            nz = n_total // NX
            if nz < k + 1:
                continue
            # DFT at wavenumber k along z (first axis after reshape[nz, NX])
            # Az2[iz, ix] = az2_col[iz*NX + ix]
            two_pi_k_over_nz = 2.0 * math.pi * k / nz
            re_k = [0.0] * NX
            im_k = [0.0] * NX
            for iz in range(nz):
                angle = two_pi_k_over_nz * iz
                c = math.cos(angle)
                s = -math.sin(angle)  # rfft convention: exp(-2πikn/N)
                base = iz * NX
                for ix in range(NX):
                    re_k[ix] += az2_col[base + ix] * c - az3_col[base + ix] * (-s)
                    im_k[ix] += az2_col[base + ix] * s + az3_col[base + ix] * c
            # mean amplitude across x
            amp = sum(math.sqrt(re_k[ix]**2 + im_k[ix]**2) for ix in range(NX)) / (NX * nz)
            rows_out.append({'t': t, 'amp': amp})
        except Exception:
            pass

    if not rows_out:
        continue

    # For Lz=4pi runs, label the output by physical kz (k/2)
    kz_label = f"{k}p5" if lz4pi and k % 2 == 1 else str(k // 2 if lz4pi else k)
    out = f"{run_dir}/timeseries_k{kz_label}.csv"
    with open(out, 'w', newline='') as f:
        w = csv.DictWriter(f, fieldnames=['t', 'amp'])
        w.writeheader()
        w.writerows(rows_out)
    print(f"Wrote {len(rows_out)} pts → {out}")

    # Delete large field dumps now that timeseries is extracted
    for csv_path in csvs:
        os.remove(csv_path)
    print(f"  Cleaned {len(csvs)} field dumps from {run_dir}")
