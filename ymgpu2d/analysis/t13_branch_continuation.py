#!/usr/bin/env python3
"""
t13_branch_continuation.py — T1.3 solver-continuation study.

Roadmap task (RESEARCH_ROADMAP.md "T1.3 Sub-kz=1 branch"): the original
sub-kz=1 "two-branch" claim (gamma=0.32 at kz_phys=0.5 falling to 0.06 at
kz_phys=0.75, alpha=2, V0=0.05) came from raw sweep-table entries produced by
the pre-2026-07-17 pipeline (helicity-sign bug + box-mislabeling bug) and was
retracted in results.tex Sec. "Limitations" as unestablished. This script
re-derives the claim from the eigensolver alone (independent of any GPU
pipeline bug) via a fine (dkz_phys=0.05) continuation in kz_phys, tracking
several leading eigenvalue branches (not just the dominant one) and comparing
eigenfunction character (peak location, Az/By ratio, parity) across any
crossing, at a few xi_sponge values to rule out spurious sponge-supported
outer modes contaminating the picture.

Usage:
    python3 t13_branch_continuation.py
Writes:
    sweep/t13_branch_continuation.csv   (long table: kz_phys, xi_sponge, branch eigenvalues + diagnostics)
    plots/t13_branch_continuation.png   (gamma vs kz_phys, one panel per xi_sponge, branches color-coded)
"""
import numpy as np
import sys
import os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from ym_eigenmode import build_matrix, wkb_growth_rate, LX
import scipy.sparse.linalg as spla

ALPHA = 2.0
V0 = 0.05
EPS = 0.15
NX = 384

KZ_MIN, KZ_MAX, DKZ = 0.10, 2.00, 0.05
XI_SPONGES = [8.0, 13.0, 20.0]
SIGMA_SPONGE = 5.0

# Seed sigmas to scan at each kz to catch multiple branches even across a
# crossing (brute multi-shift scan, more robust than pure continuation).
SIGMA_SEEDS_BASE = np.array([0.02, 0.04, 0.07, 0.10, 0.15, 0.20, 0.30, 0.40,
                              0.55, 0.70, 0.90, 1.10, 1.40])


def eigenfunction_diagnostics(eigvec, NX):
    N = NX
    b = eigvec[0:N]
    a = eigvec[3*N:4*N]
    dx = LX / NX
    x = np.arange(NX) * dx
    xi = (x - LX/2.0) / EPS

    amp_b = np.abs(b)
    i_peak = np.argmax(amp_b)
    xi_peak = xi[i_peak]

    az_by_ratio = np.max(np.abs(a)) / max(np.max(amp_b), 1e-300)

    # parity: correlate b(xi) with b(-xi) (reflect index about the mid-domain)
    b_reflect = b[::-1]
    num = np.abs(np.vdot(b, b_reflect))
    den = np.sqrt(np.vdot(b, b).real * np.vdot(b_reflect, b_reflect).real)
    parity_corr = float(num / den) if den > 0 else float('nan')

    return dict(xi_peak=float(xi_peak), az_by_ratio=float(az_by_ratio),
                parity_corr=parity_corr)


def scan_kz(kz, xi_sponge, NX):
    """Solve at many sigma seeds, dedupe growing eigenvalues, return list of
    (eigval, eigvec) sorted by Re(eigval) descending."""
    found = []  # list of (eigval, eigvec)
    gw = wkb_growth_rate(kz, ALPHA, V0)
    seeds = list(SIGMA_SEEDS_BASE)
    if np.isfinite(gw) and gw > 0:
        seeds += [0.4*gw, 0.55*gw, 0.7*gw, gw]

    L = build_matrix(kz, ALPHA, V0, EPS, NX, xi_sponge=xi_sponge,
                      sigma_sponge=SIGMA_SPONGE)

    for sigma in seeds:
        try:
            vals, vecs = spla.eigs(L, k=6, sigma=sigma, which='LM',
                                    maxiter=5000, tol=1e-9)
        except spla.ArpackNoConvergence as e:
            vals, vecs = e.eigenvalues, e.eigenvectors
            if len(vals) == 0:
                continue
        except Exception:
            continue
        for j in range(len(vals)):
            ev = vals[j]
            if ev.real < 5e-4:
                continue
            # dedupe against already-found eigenvalues
            is_dup = any(abs(ev - fev) < 2e-3 * max(1.0, abs(fev))
                         for fev, _ in found)
            if not is_dup:
                found.append((ev, vecs[:, j]))

    found.sort(key=lambda t: -t[0].real)
    return found


def main():
    rows = []
    for xi_sponge in XI_SPONGES:
        print(f"=== xi_sponge={xi_sponge} ===", file=sys.stderr)
        kz_vals = np.arange(KZ_MIN, KZ_MAX + 1e-9, DKZ)
        for kz in kz_vals:
            found = scan_kz(kz, xi_sponge, NX)
            for rank, (ev, vec) in enumerate(found[:6]):
                diag = eigenfunction_diagnostics(vec, NX)
                rows.append(dict(
                    xi_sponge=xi_sponge, kz_phys=round(float(kz), 4),
                    rank=rank, gamma=ev.real, omega_re=ev.imag,
                    **diag
                ))
            print(f"  kz_phys={kz:.3f}: "
                  f"{[round(e.real,4) for e,_ in found[:5]]}", file=sys.stderr)

    import csv
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'sweep')
    os.makedirs(outdir, exist_ok=True)
    outpath = os.path.join(outdir, 't13_branch_continuation.csv')
    with open(outpath, 'w', newline='') as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0].keys()))
        w.writeheader()
        w.writerows(rows)
    print(f"wrote {outpath} ({len(rows)} rows)", file=sys.stderr)


if __name__ == '__main__':
    main()
