#!/usr/bin/env python3
"""Per-channel energy + mode-structure diagnostic for the T1.4 warm-closure
"surprise" (warm_T increases, not decreases, the measured growth rate --
FINDINGS.md 2026-07-19 "EPS-scan (120 pts) and warm-closure (32 pts) GPU
results"). Needs raw ym_*.csv field-dump snapshots retained (the normal
extractors delete them) -- run against a fresh diagnostic rerun, e.g.:

  ssh t133 'cd /DATA/ym_kh/ymgpu2d/outputs && /path/to/ym_coupled diag.ini'
  (do NOT run remote_timeseries.py afterward -- it deletes the dumps)
  rsync -a t133:/DATA/ym_kh/ymgpu2d/outputs/ym_k4_..._diag/ remote_data/diag_cold/
  python3 analysis/diagnose_warmclosure_channels.py remote_data/diag_cold 4

Per snapshot, computes:
  - Energy per channel using the SAME formula as YM_Energy.cu's
    kernel_ym_energy (0.5*(Ex^2+Ez^2+By^2) per colour, 0.5*(px^2+pz^2)/n per
    beam) summed over the whole grid -- NOT reinvented, reused exactly so
    the numbers are directly comparable to energy.csv's E_total.
  - kz=0 and kz=k_mode amplitude of Az2+i*Az3 (the "official" measured
    channel), By1 (colour-1, no natural complex partner), and Q2A+i*Q3A /
    Q2B+i*Q3B (the colour charges that mediate the precession coupling
    between Az2/Az3 and By1) -- magnitude-per-x-column then averaged over
    x, matching remote_timeseries.py's established convention.

Usage: python3 diagnose_warmclosure_channels.py <run_dir> <k_mode> [NX]
"""
import glob, os, re, sys
import numpy as np
import pandas as pd

NX_DEFAULT = 768


def kz_amp(df, col_re, col_im, k, nx, nz):
    """Per-x-column magnitude of the kz=k DFT term, then averaged over x
    (identical convention to remote_timeseries.py's fast path)."""
    sig = (df[col_re].values + (1j * df[col_im].values if col_im else 0)).reshape(nz, nx)
    ker = np.exp(-2j * np.pi * k * np.arange(nz) / nz)
    F = ker @ sig
    return float(np.abs(F).mean() / nz)


def main():
    run_dir = sys.argv[1]
    k_mode = int(sys.argv[2])
    nx = int(sys.argv[3]) if len(sys.argv) > 3 else NX_DEFAULT

    dt_run = 0.00245437
    ecsv = os.path.join(run_dir, "energy.csv")
    if os.path.exists(ecsv):
        edf = pd.read_csv(ecsv)
        if len(edf) >= 2:
            dt_run = (edf['time'].iloc[-1] - edf['time'].iloc[0]) / \
                      (edf['step'].iloc[-1] - edf['step'].iloc[0])

    rows = []
    for csv_path in sorted(glob.glob(os.path.join(run_dir, "ym_*.csv"))):
        step = int(re.search(r'\d+', os.path.splitext(os.path.basename(csv_path))[0]).group())
        t = step * dt_run
        df = pd.read_csv(csv_path)
        n_total = len(df)
        nz = n_total // nx
        if nz < 1:
            continue

        nA = np.maximum(df['nA'].values, 1e-10)
        nB = np.maximum(df['nB'].values, 1e-10)
        E_ke_A = 0.5 * (df['PxA'].values**2 + df['PzA'].values**2) / nA
        E_ke_B = 0.5 * (df['PxB'].values**2 + df['PzB'].values**2) / nB
        E_em1 = 0.5 * (df['Ex1'].values**2 + df['Ez1'].values**2 + df['By1'].values**2)
        E_em2 = 0.5 * (df['Ex2'].values**2 + df['Ez2'].values**2 + df['By2'].values**2)
        E_em3 = 0.5 * (df['Ex3'].values**2 + df['Ez3'].values**2 + df['By3'].values**2)

        rows.append(dict(
            t=t,
            E_kinetic_A=E_ke_A.sum(), E_kinetic_B=E_ke_B.sum(),
            E_EM_color1=E_em1.sum(), E_EM_color2=E_em2.sum(), E_EM_color3=E_em3.sum(),
            az_kz0=kz_amp(df, 'Az2', 'Az3', 0, nx, nz),
            az_kztarget=kz_amp(df, 'Az2', 'Az3', k_mode, nx, nz),
            by1_kz0=kz_amp(df, 'By1', None, 0, nx, nz),
            by1_kztarget=kz_amp(df, 'By1', None, k_mode, nx, nz),
            qA_kz0=kz_amp(df, 'Q2A', 'Q3A', 0, nx, nz),
            qA_kztarget=kz_amp(df, 'Q2A', 'Q3A', k_mode, nx, nz),
            qB_kz0=kz_amp(df, 'Q2B', 'Q3B', 0, nx, nz),
            qB_kztarget=kz_amp(df, 'Q2B', 'Q3B', k_mode, nx, nz),
            n_perturb_A=float(np.abs(nA - 1.0).mean()),
        ))

    out = pd.DataFrame(rows).sort_values('t')
    out_path = os.path.join(run_dir, "channel_diagnostic.csv")
    out.to_csv(out_path, index=False)
    print(f"Wrote {out_path} ({len(out)} snapshots)")
    print(out.to_string(index=False, float_format=lambda x: f"{x:.4e}"))


if __name__ == '__main__':
    main()
