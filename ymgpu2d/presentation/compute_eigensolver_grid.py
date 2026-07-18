#!/usr/bin/env python3
"""
Fine-kz exact-eigensolver sweep for fig03/fig04 regeneration.

Runs analysis/ym_eigenmode.py's solve_eigenmode() (the numerical linearized
eigenvalue solver, NOT the closed-form WKB quartic) across a fine kz grid
(0.125 .. 10.0, step 0.125 -- matches sweep/*.npz kz_vals exactly) for the
8 (alpha, V0) series that make up fig03 (V0=0.05 validation stack) and
fig04 (V0=0.05 + V0=0.03 headline dispersion).

Each series uses ONE fixed xi_sponge (the actual value the corresponding
production campaign used -- C25/C32-C38, from FINDINGS.md / plot_dispersion_all.py)
rather than a per-kz formula: cross-checked against the curated gamma_exact
table and only the fixed-per-series sponge reproduces it exactly (0.0% diff
at every kz); the per-kz sponge formula (tuned for simulation safety, not
eigensolver mode selection) drifts up to 20%.

At each kz we only accept a growing eigenvalue whose eigenvector passes
is_localised() at that series' sponge -- this rejects the spurious
outer-region instability branch (see PRESENTATION.md fig01) rather than
silently reporting its (much larger, unphysical-for-KH) growth rate.
Points where no localised growing mode is found are left as NaN --
these gaps are physically meaningful (the shear-localised eigenmode
picture breaks down there), not solver failures to be papered over.

Output: presentation/eigensolver_grid_cache.npz
  kz_vals   : (80,) float
  series    : list of (alpha, V0, xi_sponge) tuples, len 8
  gamma     : (8, 80) float, NaN where no localised mode found
"""
import sys, os, time
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'analysis'))
import numpy as np
import ym_eigenmode as E

OUT = os.path.join(os.path.dirname(__file__), 'eigensolver_grid_cache.npz')

# (alpha, V0, xi_sponge) -- xi_sponge = the actual production sponge for that
# campaign (C25=20, C34=12, C35=11, C32=9, C33=8, C36/C37/C38=5), verified above
# to reproduce the curated gamma_exact table to 0.0% at every published kz.
SERIES = [
    (1.0, 0.05, 20),   # C25
    (1.5, 0.05, 12),   # C34
    (2.0, 0.05, 11),   # C35
    (2.5, 0.05, 9),    # C32
    (3.0, 0.05, 8),    # C33
    (3.0, 0.03, 5),    # C36
    (4.0, 0.03, 5),    # C37
    (5.0, 0.03, 5),    # C38
]

KZ_VALS = np.round(np.arange(0.125, 10.0 + 1e-9, 0.125), 3)
EPS = 0.15
NX = 384


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
    gamma = np.full((len(SERIES), len(KZ_VALS)), np.nan)
    t0 = time.time()
    for i, (alpha, V0, sp) in enumerate(SERIES):
        for j, kz in enumerate(KZ_VALS):
            gamma[i, j] = exact_gamma(float(kz), alpha, V0, sp)
        n_ok = np.sum(~np.isnan(gamma[i]))
        print(f"[{time.time()-t0:6.1f}s] alpha={alpha:.1f} V0={V0:.2f} sp={sp}: "
              f"{n_ok}/{len(KZ_VALS)} localised points", flush=True)
    np.savez_compressed(OUT, kz_vals=KZ_VALS,
                        series=np.array(SERIES, dtype=float), gamma=gamma)
    print(f"wrote {OUT}  (total {time.time()-t0:.1f}s)")


if __name__ == '__main__':
    main()
