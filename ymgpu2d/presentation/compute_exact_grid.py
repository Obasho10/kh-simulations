#!/usr/bin/env python3
"""
Full-grid exact-eigensolver pass for the relative-error heatmap (fig13).

For every (alpha, kz) grid cell in each sweep/*.npz table that has a
gamma_sim value, solve the numerical eigenvalue problem (analysis/ym_eigenmode.py,
solve_eigenmode + is_localised -- the same "exact eigensolver" used for
fig03/fig04) using the production xi_sponge formula:

    xi_sponge = max(5, min(55, int(1.3*kz/(alpha*V0))))

(reference_xi_sponge_formula memory: verified against 2160 existing runs;
this is the general per-point formula, not the single hand-tuned per-campaign
sponge used for the fig03/fig04 8-series cache, since here we need a value at
every grid cell, most of which were never hand-tuned).

Only the localised growing eigenvalue is accepted (rejects the spurious
outer-region branch); NaN if none is found.

Output: presentation/exact_grid_cache.npz
  one array per V0 file: gamma_exact_v0pXX, shape matching that table's
  (alpha_vals, kz_vals) grid, NaN where gamma_sim was NaN or no localised
  mode was found.
"""
import sys, os, time
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'analysis'))
import numpy as np
import ym_eigenmode as E

SWEEP = os.path.join(os.path.dirname(__file__), '..', 'sweep')
OUT = os.path.join(os.path.dirname(__file__), 'exact_grid_cache.npz')

FILES = [('v0p01', 0.01), ('v0p03', 0.03), ('v0p05', 0.05), ('v0p1', 0.10), ('v0p2', 0.20)]
EPS = 0.15
NX = 384


def sp_formula(kz, alpha, V0):
    return max(5, min(55, int(1.3 * kz / (alpha * V0))))


def exact_gamma(kz, alpha, V0):
    sp = sp_formula(kz, alpha, V0)
    try:
        ev, evec = E.solve_eigenmode(kz, alpha, V0, EPS, NX, xi_sponge=sp)
    except Exception:
        return np.nan
    if ev is None:
        return np.nan
    for j, v in enumerate(ev):
        if v.real > 1e-5 and E.is_localised(evec[:, j], NX, EPS, xi_inner=sp):
            return v.real
    return np.nan


def main():
    out = {}
    t0 = time.time()
    total_done = 0
    for f, V0 in FILES:
        d = dict(np.load(os.path.join(SWEEP, f + '.npz')))
        gs = d['gamma_sim']
        al, kz = d['alpha_vals'], d['kz_vals']
        gexact = np.full_like(gs, np.nan)
        idx = np.argwhere(~np.isnan(gs))
        print(f'{f} (V0={V0}): {len(idx)} points to compute', flush=True)
        for n, (ia, ik) in enumerate(idx):
            gexact[ia, ik] = exact_gamma(float(kz[ik]), float(al[ia]), V0)
            total_done += 1
            if (n + 1) % 100 == 0:
                elapsed = time.time() - t0
                print(f'  [{f}] {n+1}/{len(idx)}  (total {total_done}, {elapsed:.0f}s elapsed)',
                      flush=True)
        out[f'gamma_exact_{f}'] = gexact
        out[f'alpha_vals_{f}'] = al
        out[f'kz_vals_{f}'] = kz
        n_ok = np.sum(~np.isnan(gexact))
        print(f'{f}: done, {n_ok}/{len(idx)} localised  [{time.time()-t0:.0f}s elapsed total]',
              flush=True)
    np.savez_compressed(OUT, **out)
    print(f'wrote {OUT}  (total {time.time()-t0:.0f}s, {total_done} solves)')


if __name__ == '__main__':
    main()
