#!/usr/bin/env python3
"""Chased-eigensolver worker: reads a points CSV (kz, alpha, V0, eps, xi_sponge),
computes the sigma-chased dominant localised eigenvalue at each point with the
run's actual sponge window, appends results incrementally to an output CSV.

Usage: python3 chase_worker.py points.csv out.csv [nproc]
Safe to re-run: skips points already present in out.csv.
"""
import os
os.environ.setdefault('OMP_NUM_THREADS', '1')
os.environ.setdefault('OPENBLAS_NUM_THREADS', '1')
os.environ.setdefault('VECLIB_MAXIMUM_THREADS', '1')
import sys, time
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), 'analysis'))
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import pandas as pd
from multiprocessing import Pool
import ym_eigenmode as E

NX = 384


def gamma_true_sponge(kz, alpha, V0, EPS, NX, xi_sponge, sigma_sponge=5.0, sigma0=None):
    if sigma0 is None:
        sigma0 = E.wkb_growth_rate(kz, alpha, V0)
        sigma0 = 0.55 * sigma0 if (np.isfinite(sigma0) and sigma0 > 0) else 0.1
    sig = max(sigma0, 0.02)
    best = None
    for it in range(8):
        try:
            ev, evec = E.solve_eigenmode(kz, alpha, V0, EPS, NX, n_eigs=10,
                                         sigma=sig, xi_sponge=xi_sponge,
                                         sigma_sponge=sigma_sponge)
        except Exception:
            return best
        if ev is None:
            return best
        cand = []
        for j, v in enumerate(ev):
            if v.real > 1e-4 and E.is_localised(evec[:, j], NX, EPS, xi_inner=xi_sponge):
                cand.append(v.real)
        if not cand:
            break
        gmax = max(cand)
        if best is None or gmax > best:
            best = gmax
        else:
            break
        if gmax >= 0.9 * max(v.real for v in ev) and it < 7:
            sig = gmax * 1.4
            continue
        break
    return best


def solve_point(row):
    kz, alpha, V0, eps, sp = row
    g = gamma_true_sponge(float(kz), float(alpha), float(V0), float(eps), NX, float(sp))
    return kz, alpha, V0, eps, sp, (g if g is not None else np.nan)


def main():
    pts_csv, out_csv = sys.argv[1], sys.argv[2]
    nproc = int(sys.argv[3]) if len(sys.argv) > 3 else 8
    pts = pd.read_csv(pts_csv)
    done = set()
    if os.path.exists(out_csv):
        prev = pd.read_csv(out_csv)
        done = set(zip(prev['kz'], prev['alpha'], prev['V0'], prev['eps'], prev['xi_sponge']))
        print(f"resuming: {len(done)} already done", flush=True)
    todo = [(r.kz, r.alpha, r.V0, r.eps, r.xi_sponge) for r in pts.itertuples()
            if (r.kz, r.alpha, r.V0, r.eps, r.xi_sponge) not in done]
    print(f"{len(todo)} points to solve with {nproc} workers", flush=True)
    t0 = time.time()
    header_needed = not os.path.exists(out_csv)
    with Pool(nproc) as pool, open(out_csv, 'a', buffering=1) as f:
        if header_needed:
            f.write('kz,alpha,V0,eps,xi_sponge,gamma_chased\n')
        for i, (kz, alpha, V0, eps, sp, g) in enumerate(
                pool.imap_unordered(solve_point, todo, chunksize=4)):
            f.write(f'{kz},{alpha},{V0},{eps},{sp},{g}\n')
            if (i + 1) % 50 == 0:
                el = time.time() - t0
                print(f"  {i+1}/{len(todo)}  {el:.0f}s elapsed, "
                      f"ETA {el/(i+1)*(len(todo)-i-1):.0f}s", flush=True)
    print(f"DONE {len(todo)} in {time.time()-t0:.0f}s", flush=True)


if __name__ == '__main__':
    main()
