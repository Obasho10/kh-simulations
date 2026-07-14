#!/usr/bin/env python3
"""
Integer-kz-only exact-eigensolver grid, using INTERPOLATED validated sponges
instead of the blind production formula.

Rationale (see chat notes): the blind per-kz xi_sponge formula
(max(5,min(55,int(1.3*kz/(alpha*V0))))) produced a median >100% "error" across
the full grid because it frequently selects the wrong eigenbranch. But every
validated ground-truth point we have (the 8-series fig03/fig04 cache, and all
172 batch_best.csv rows) sits at INTEGER kz, and at fixed V0, the real sponge
a human/production run used is a smooth, mostly-monotonic function of alpha
(e.g. V0=0.05: alpha=0.5->22, 1.0->25, 1.5->15, 2.0->11, 2.5->12, 3.0->10).
Interpolating that real relationship (rather than the blind formula) and
testing it against held-out alpha values gives smooth, physically sensible
gamma(alpha) curves at kz=2,3,4 (typical deviation 5-15%), though kz=1
remains noticeably more fragile (wobbles up to ~15% between anchors).

Only V0 in {0.03, 0.05, 0.10, 0.20} are covered -- V0=0.01 has 1 anchor,
V0=0.02 has 2, both too thin to interpolate.
"""
import sys, os, time
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'analysis'))
import numpy as np
import pandas as pd
import ym_eigenmode as E

SWEEP = os.path.join(os.path.dirname(__file__), '..', 'sweep')
BATCH_BEST = os.path.join(os.path.dirname(__file__), '..', 'batch_best.csv')
OUT = os.path.join(os.path.dirname(__file__), 'integer_kz_grid_cache.npz')

V0_LIST = [0.03, 0.05, 0.10, 0.20]
EPS = 0.15
NX = 384


def build_sponge_interpolator(df, V0):
    sub = df[np.isclose(df['V0'], V0)]
    sp_by_alpha = sub.groupby('alpha')['xi_sponge'].median().sort_index()
    alphas_known = sp_by_alpha.index.values
    sponges_known = sp_by_alpha.values

    def sp_interp(alpha):
        # np.interp already clamps flat outside [alphas_known.min(), .max()]
        return round(float(np.interp(alpha, alphas_known, sponges_known)))
    return sp_interp, alphas_known.min(), alphas_known.max()


def exact_gamma(kz, alpha, V0, sp):
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
    df = pd.read_csv(BATCH_BEST)
    out = {}
    t0 = time.time()
    for V0 in V0_LIST:
        f = f'v0p{str(V0).replace("0.", "").rstrip("0") or "0"}'
        # match sweep filename convention
        fname = {0.03: 'v0p03', 0.05: 'v0p05', 0.10: 'v0p1', 0.20: 'v0p2'}[V0]
        d = dict(np.load(os.path.join(SWEEP, fname + '.npz')))
        alpha_vals, kz_vals = d['alpha_vals'], d['kz_vals']
        int_kz_mask = np.isclose(kz_vals, np.round(kz_vals)) & (kz_vals >= 1)
        int_kz_idx = np.where(int_kz_mask)[0]

        sp_interp, amin, amax = build_sponge_interpolator(df, V0)
        gexact = np.full((len(alpha_vals), len(kz_vals)), np.nan)
        n_done = 0
        for ia, alpha in enumerate(alpha_vals):
            for ik in int_kz_idx:
                kz = kz_vals[ik]
                gs = d['gamma_sim'][ia, ik]
                if np.isnan(gs):
                    continue
                sp = sp_interp(alpha)
                gexact[ia, ik] = exact_gamma(float(kz), float(alpha), V0, sp)
                n_done += 1
        out[f'gamma_exact_{fname}'] = gexact
        out[f'extrap_range_{fname}'] = np.array([amin, amax])
        print(f'{fname} (V0={V0}): {n_done} integer-kz points solved, '
              f'anchor range alpha=[{amin},{amax}]  [{time.time()-t0:.0f}s elapsed]',
              flush=True)
    np.savez_compressed(OUT, **out)
    print(f'wrote {OUT}  (total {time.time()-t0:.0f}s)')


if __name__ == '__main__':
    main()
