#!/usr/bin/env python3
"""
depletion_extract.py — compact per-snapshot profiles for the unfrozen-Az1
background-depletion experiment (2026-07-15, see OUTER_REGION.md open items).

For each ym_*.csv snapshot in a run dir, stores:
  * signed z-mean x-profiles of Az1, By1, Ez1, PzA, PzB, nA, Q1A
    (Az1 requires the Az1 export column added 2026-07-15)
  * |k_mode| complex-amplitude x-profiles of the circular pairs
    a = Az2+iAz3 and b = By2+iBy3 (locates the tachyonic mode and its rate)

Run next to the data:
  python3 analysis/depletion_extract.py <run_dir> --k-mode 3 --out dep_X.npz
"""
import sys, os, glob, argparse
import numpy as np

ZMEAN_FIELDS = ['Az1', 'By1', 'Ez1', 'PzA', 'PzB', 'nA', 'Q1A']


def main():
    p = argparse.ArgumentParser()
    p.add_argument('run_dir')
    p.add_argument('--k-mode', type=int, required=True)
    p.add_argument('--dt-per-step', type=float, default=2.454369e-3)
    p.add_argument('--out', required=True)
    args = p.parse_args()
    import pandas as pd

    snaps = sorted(glob.glob(os.path.join(args.run_dir, 'ym_*.csv')))
    print(f'{len(snaps)} snapshots in {args.run_dir}')
    times, zmeans, amps_a, amps_b = [], [], [], []
    for i, s in enumerate(snaps):
        df = pd.read_csv(s)
        step = int(os.path.basename(s).split('_')[1].split('.')[0])
        nz = df['Z'].nunique()
        grids = {}
        for f in ZMEAN_FIELDS + ['Az2', 'Az3', 'By2', 'By3']:
            if f not in df.columns:
                print(f'  missing column {f} — aborting'); return
            grids[f] = df.pivot_table(index='X', columns='Z', values=f,
                                      sort=True).to_numpy()
        zmeans.append(np.stack([grids[f].mean(axis=1) for f in ZMEAN_FIELDS]))
        a = grids['Az2'] + 1j * grids['Az3']
        b = grids['By2'] + 1j * grids['By3']
        amps_a.append(np.abs(np.fft.fft(a, axis=1)[:, args.k_mode]) / nz)
        amps_b.append(np.abs(np.fft.fft(b, axis=1)[:, args.k_mode]) / nz)
        times.append(step * args.dt_per_step)
        if i % 10 == 0:
            print(f'  {i}/{len(snaps)}', flush=True)
    np.savez_compressed(args.out, t=np.array(times),
                        zmean=np.array(zmeans), zmean_fields=ZMEAN_FIELDS,
                        amp_a=np.array(amps_a), amp_b=np.array(amps_b),
                        k_mode=args.k_mode, run_dir=args.run_dir)
    print(f'wrote {args.out}')


if __name__ == '__main__':
    main()
