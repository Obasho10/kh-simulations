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
    # Detect Lz multiplier from bandpass marker in dir name
    # bp28 → Lz=4π (kz_physical = k/2); bp55 → Lz=16π (kz_physical = k/8)
    lz4pi  = bool(re.search(r'lz12\.56|lz4pi|_lz4', run_dir)) or \
             (bool(re.search(r'_bp28', run_dir)) and k % 2 == 1)
    lz16pi = bool(re.search(r'_bp55|_bp112', run_dir))
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
            re_c = [0.0] * NX
            im_c = [0.0] * NX
            for iz in range(nz):
                angle = two_pi_k_over_nz * iz
                c = math.cos(angle)
                s = -math.sin(angle)  # rfft convention: exp(-2πikn/N)
                base = iz * NX
                for ix in range(NX):
                    v2 = az2_col[base + ix]
                    v3 = az3_col[base + ix]
                    # amp: rfft(Az2)[k] + i*rfft(Az3)[k] — the (+)-helicity
                    # component the mode-1/6 seed excites (Az2+iAz3 ~ e^{+ikz}).
                    # HISTORY: 2026-07-04..17 this line had `- v3 * (-s)`, i.e.
                    # the CONJUGATE (−helicity) component, which is ~zero for the
                    # seeded mode — every timeseries extracted in that window
                    # starts at FP32 noise (logamp≈−30) and tracks the wrong
                    # component. See FINDINGS.md 2026-07-17 helicity-bug entry.
                    re_k[ix] += v2 * c - v3 * s
                    im_k[ix] += v2 * s + v3 * c
                    # conjugate (−helicity) amplitude kept as a diagnostic
                    re_c[ix] += v2 * c + v3 * s
                    im_c[ix] += v2 * s - v3 * c
            # mean amplitude across x
            amp = sum(math.sqrt(re_k[ix]**2 + im_k[ix]**2) for ix in range(NX)) / (NX * nz)
            amp_conj = sum(math.sqrt(re_c[ix]**2 + im_c[ix]**2) for ix in range(NX)) / (NX * nz)
            rows_out.append({'t': t, 'amp': amp, 'amp_conj': amp_conj})
        except Exception:
            pass

    if not rows_out:
        continue

    # Label by physical kz
    if lz16pi:
        kz_phys = k / 8.0
    elif lz4pi:
        kz_phys = k / 2.0
    else:
        kz_phys = float(k)
    kz_r = round(kz_phys, 3)
    if kz_r == int(kz_r):
        kz_label = str(int(kz_r))
    else:
        kz_label = f"{kz_r:.3f}".rstrip('0').replace('.', 'p')
    out = f"{run_dir}/timeseries_k{kz_label}.csv"
    with open(out, 'w', newline='') as f:
        w = csv.DictWriter(f, fieldnames=['t', 'amp', 'amp_conj'])
        w.writeheader()
        w.writerows(rows_out)
    print(f"Wrote {len(rows_out)} pts → {out}")

    # Delete large field dumps now that timeseries is extracted
    # (set KEEP_DUMPS=1 to skip deletion, e.g. for validation runs)
    if os.environ.get('KEEP_DUMPS'):
        print(f"  KEEP_DUMPS set — leaving {len(csvs)} field dumps in {run_dir}")
        continue
    cleaned = 0
    for csv_path in csvs:
        try:
            os.remove(csv_path)
            cleaned += 1
        except FileNotFoundError:
            pass
    print(f"  Cleaned {cleaned} field dumps from {run_dir}")
