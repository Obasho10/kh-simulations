#!/usr/bin/env python3
"""
Phase 2 of LX_RESOLUTION_PLAN.md: reusable Lx-tier policy for campaign
generators, calibrated against the Phase 0/1 findings (2026-07-21):

  - Lx=2pi confirmed safe (gamma agrees to 5 sig figs vs 6pi) at the reference
    anchor once xi_sponge actually fits inside the box.
  - The naive Phase-0 arithmetic screen (xi_sponge*eps vs Lx/2, +3 margin) is
    NOT sufficient on its own: for alpha=1.1,V0=0.03,kz=3 the PROPERLY
    re-derived minimal safe sponge (via find_safe_sponge.py, not the blind
    formula) was sp=22 -- which itself exceeds 2pi's own xi-budget (20.9),
    confirming this corner genuinely needs 3pi, not a formula artifact.
  - Phase 1b (2026-07-21 redo) confirms 3pi vs 6pi agree once a validly-fitting
    sponge is used in both.

lx_for_point() below picks the cheapest Lx tier whose xi-budget clears the
supplied (or blind-formula-estimated) xi_sponge plus a safety margin, and
preserves the existing EPS>=0.30 box-doubling convention.

IMPORTANT: this only screens sponge-vs-box FIT (does the sponge threshold even
lie inside the box). It does NOT re-derive whether a *smaller* sponge would
also be safe at the picked tier -- for genuinely new (alpha,V0,kz) points,
run find_safe_sponge.find_safe_xi_sponge(..., Lx=<picked tier>) to get the
real minimal safe value before trusting the picked tier is also accurate.
"""
import math
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

LX_TIERS = [2 * math.pi, 3 * math.pi, 4 * math.pi, 6 * math.pi]  # cheapest first
MARGIN_XI = 3.0  # extra xi-units of headroom beyond the sponge itself
EPS_WIDE_THRESHOLD = 0.30


def _production_formula(alpha, V0, kz):
    """Mirrors gen_multigpu_campaign.py::xi_sponge_for -- blind estimate only,
    used as a fallback when no xi_sponge is supplied. NOT trusted as a real
    minimum; see find_safe_sponge.py for that."""
    kz_peak_est = max(0.5, round(2 * alpha) * 1.0)
    xi_crit = kz_peak_est / (alpha * V0)
    return max(5, min(55, int(xi_crit * 1.3)))


def lx_for_point(alpha, V0, kz, EPS, xi_sponge=None):
    """Cheapest Lx tier whose xi-budget (Lx/2)/EPS clears xi_sponge + margin.
    Doubles the result for EPS>=0.30 (existing wide-EPS convention)."""
    if xi_sponge is None:
        xi_sponge = _production_formula(alpha, V0, kz)
    needed = xi_sponge + MARGIN_XI
    for lx in LX_TIERS:
        if (lx / 2.0) / EPS >= needed:
            base_lx = lx
            break
    else:
        base_lx = LX_TIERS[-1]
    return base_lx * 2.0 if EPS >= EPS_WIDE_THRESHOLD else base_lx


def nx_for_lx(lx, target_dx=6.0 * math.pi / 768):
    """NX that holds DX fixed at the reference-converged value (RESOLUTION_
    FINDINGS.md: DX<=0.0245 / EPS/DX>=6 at EPS=0.15), rounded to a multiple of
    64 for FCT-friendly grid sizes."""
    nx = math.ceil(lx / target_dx)
    return int(math.ceil(nx / 64.0) * 64)


def validate_against_archive():
    """Sanity check: apply lx_for_point() to the real historical dataset and
    report the tier distribution, using each point's OWN recorded xi_sponge
    (not the blind formula) as the target -- same spirit as
    lx_feasibility_screen.py but through the policy function itself."""
    import numpy as np
    import pandas as pd

    root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    d = np.load(os.path.join(root, 'sweep', 'all_points_vs_chased.npz'), allow_pickle=True)
    df = pd.DataFrame({k: d[k] for k in ['alpha', 'V0', 'kz', 'eps', 'xi_sponge']})
    df['xi_sponge'] = pd.to_numeric(df['xi_sponge'], errors='coerce')
    df['eps'] = pd.to_numeric(df['eps'], errors='coerce')
    df = df.dropna(subset=['xi_sponge', 'eps'])
    df = df[df['xi_sponge'] > 0]

    picked = [lx_for_point(a, v, k, e, xi_sponge=sp)
              for a, v, k, e, sp in zip(df['alpha'], df['V0'], df['kz'],
                                         df['eps'], df['xi_sponge'])]
    df['lx_picked'] = picked
    print(f"n={len(df)} historical points, tier distribution under lx_for_point():")
    print((df['lx_picked'].value_counts(normalize=True) * 100).round(1).to_string())
    print("\n(compare to lx_feasibility_screen.py's flat-2pi 43.1% safe rate --")
    print(" this policy instead assigns EACH point its own cheapest safe tier)")


if __name__ == '__main__':
    validate_against_archive()
