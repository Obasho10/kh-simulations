#!/usr/bin/env python3
"""
catastrophe_forensics.py — what actually grows before the late-onset
catastrophe? (2026-07-15 investigation, see OUTER_REGION.md.)

Two modes:

  extract  — run NEXT TO THE DATA (server): reads every ym_*.csv snapshot in a
             run directory and reduces each to compact per-field diagnostics:
               * z-spectral power P[field, kz_mode] (summed over x)
               * x-profiles of z-power in 4 kz groups (summed over group):
                   grp0: kz_mode = 0
                   grp1: kz_mode = k_mode (the retained/seeded mode)
                   grp2: all other kz_modes ≤ bp (the filtered band — should
                         stay at machine noise if the filters work)
                   grp3: kz_modes > bp (the unfiltered high band)
             writes <outfile>.npz (~15 MB for ~100 snapshots).

  analyze  — run anywhere (iMac): loads the npz, prints growth-rate fits per
             (field, kz group) over a chosen time window, localization of each
             channel, and the identity of the fastest-growing channel just
             before the catastrophe.

Usage:
  # on the server, in ymgpu2d/:
  python3 analysis/catastrophe_forensics.py extract outputs/<run_dir> \
      --k-mode 3 --bp 28 --out forensics_<tag>.npz
  # on the iMac:
  python3 analysis/catastrophe_forensics.py analyze forensics_<tag>.npz \
      --fit-t0 40 --fit-t1 95
"""
import sys, os, glob, argparse
import numpy as np

FIELDS = ['By1', 'By2', 'By3', 'Az2', 'Az3', 'PzA', 'PxA', 'Q1A',
          'PzB', 'PxB', 'Q1B', 'Ex1', 'Ex2', 'Ex3', 'Ez1', 'Ez2', 'Ez3',
          'nA', 'nB', 'Q2A', 'Q3A', 'Q2B', 'Q3B']
# fields whose z-mean (background) is subtracted before the spectral reduction
MEAN_SUB = {'Q1A', 'Q1B', 'nA', 'nB'}


def snapshot_time(fname, dt_per_step):
    step = int(os.path.basename(fname).split('_')[1].split('.')[0])
    return step * dt_per_step


def reduce_snapshot(fname, k_mode, bp):
    import pandas as pd
    df = pd.read_csv(fname)
    nx = df['X'].nunique()
    nz = df['Z'].nunique()
    spec = np.empty((len(FIELDS), nz // 2 + 1))
    prof = np.empty((len(FIELDS), 4, nx))
    nmin = (float(df['nA'].min()), float(df['nB'].min())) \
        if 'nA' in df.columns else (np.nan, np.nan)
    for fi, f in enumerate(FIELDS):
        if f not in df.columns:
            spec[fi] = 0.0; prof[fi] = 0.0
            continue
        # data is written z-major or x-major; reshape robustly via pivot
        arr = df.pivot_table(index='X', columns='Z', values=f,
                             sort=True).to_numpy()          # (nx, nz)
        if f in MEAN_SUB:
            arr = arr - arr.mean(axis=1, keepdims=True)     # perturbation only
        F = np.fft.rfft(arr, axis=1) / nz                    # (nx, nz//2+1)
        P = np.abs(F) ** 2                                   # power per kz per x
        spec[fi] = P.sum(axis=0)
        kzm = np.arange(nz // 2 + 1)
        g0 = kzm == 0
        g1 = kzm == k_mode
        g2 = (kzm >= 1) & (kzm <= bp) & (kzm != k_mode)
        g3 = kzm > bp
        for gi, g in enumerate((g0, g1, g2, g3)):
            prof[fi, gi] = P[:, g].sum(axis=1)
    return spec, prof, nx, nz, nmin


def cmd_extract(args):
    snaps = sorted(glob.glob(os.path.join(args.run_dir, 'ym_*.csv')))
    if not snaps:
        print('no snapshots found'); return
    print(f'{len(snaps)} snapshots')
    specs, profs, times, nmins = [], [], [], []
    nx = nz = None
    for i, s in enumerate(snaps):
        try:
            spec, prof, nx, nz, nmin = reduce_snapshot(s, args.k_mode, args.bp)
        except Exception as e:
            print(f'  skip {os.path.basename(s)}: {e}')
            continue
        specs.append(spec); profs.append(prof); nmins.append(nmin)
        times.append(snapshot_time(s, args.dt_per_step))
        if i % 10 == 0:
            print(f'  {i}/{len(snaps)}', flush=True)
    np.savez_compressed(args.out, spec=np.array(specs), prof=np.array(profs),
                        t=np.array(times), nmin=np.array(nmins),
                        fields=FIELDS, nx=nx, nz=nz,
                        k_mode=args.k_mode, bp=args.bp,
                        run_dir=args.run_dir)
    print(f'wrote {args.out}')


GROUPS = ['kz=0', 'kz=k_mode', 'filtered band', 'high band (>bp)']


def cmd_analyze(args):
    d = np.load(args.npz, allow_pickle=True)
    t, spec, prof = d['t'], d['spec'], d['prof']   # (nt,nf,nkz),(nt,nf,4,nx)
    fields = list(d['fields'])
    nx = int(d['nx'])
    if 'nmin' in d and np.isfinite(d['nmin']).any():
        nmin = d['nmin']
        print('# min density trace (nA, nB) at selected times:')
        for i in range(0, len(t), max(1, len(t) // 12)):
            print(f'  t={t[i]:6.1f}  nA_min={nmin[i,0]:.4f}  nB_min={nmin[i,1]:.4f}')
        print(f'  t={t[-1]:6.1f}  nA_min={nmin[-1,0]:.4f}  nB_min={nmin[-1,1]:.4f}')
        print()
    # amplitude proxy per (field, group): sqrt of profile power summed over x
    amp = np.sqrt(prof.sum(axis=3))                # (nt, nf, 4)
    m = (t >= args.fit_t0) & (t <= args.fit_t1)
    print(f'# fit window t = {args.fit_t0}–{args.fit_t1} '
          f'({m.sum()} snapshots); rates are amplitude e-fold rates γ')
    print(f'{"field":>6} | ' + ' | '.join(f'{g:>22}' for g in GROUPS))
    for fi, f in enumerate(fields):
        cells = []
        for gi in range(4):
            y = amp[m, fi, gi]
            good = y > 0
            if good.sum() > 5:
                g, icpt = np.polyfit(t[m][good], np.log(y[good]), 1)
                r = np.corrcoef(t[m][good], np.log(y[good]))[0, 1]
                cells.append(f'γ={g:+.3f} r²={r*r:.2f} A={y[-1]:.1e}')
            else:
                cells.append('-')
        print(f'{f:>6} | ' + ' | '.join(f'{c:>22}' for c in cells))

    # localization of the dominant late-time channel
    i_last = np.searchsorted(t, args.fit_t1) - 1
    late = prof[i_last]                            # (nf, 4, nx)
    fi, gi = np.unravel_index(np.argmax(late.sum(axis=2)), late.shape[:2])
    p = late[fi, gi]
    x = np.arange(nx)
    xc = nx // 2
    print(f'\n# dominant channel at t={t[i_last]:.1f}: field={fields[fi]}, '
          f'group "{GROUPS[gi]}"')
    csum = np.cumsum(p) / p.sum()
    print(f'  x-quartiles of its power: '
          f'25%@i={np.searchsorted(csum,0.25)}, 50%@i={np.searchsorted(csum,0.5)}, '
          f'75%@i={np.searchsorted(csum,0.75)}  (center i={xc})')
    # print the power in 8 x-bands
    bands = np.array_split(p, 8)
    tot = p.sum()
    print('  power fraction per x-octant: '
          + ' '.join(f'{b.sum()/tot:.2f}' for b in bands))


def main():
    p = argparse.ArgumentParser()
    sub = p.add_subparsers(dest='cmd', required=True)
    e = sub.add_parser('extract')
    e.add_argument('run_dir')
    e.add_argument('--k-mode', type=int, required=True)
    e.add_argument('--bp', type=int, required=True)
    e.add_argument('--dt-per-step', type=float, default=2.454369e-3,
                   help='DT in TU per step (default: courant 0.1 grid)')
    e.add_argument('--out', required=True)
    a = sub.add_parser('analyze')
    a.add_argument('npz')
    a.add_argument('--fit-t0', type=float, default=40.0)
    a.add_argument('--fit-t1', type=float, default=95.0)
    args = p.parse_args()
    cmd_extract(args) if args.cmd == 'extract' else cmd_analyze(args)


if __name__ == '__main__':
    main()
