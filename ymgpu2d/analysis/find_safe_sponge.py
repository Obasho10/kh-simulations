#!/usr/bin/env python3
"""
find_safe_sponge.py — eigensolver-based xi_sponge candidate finder.

Replaces the blind production formula
    xi_sponge = max(5, min(55, int(1.3 * kz_peak_est / (alpha * V0))))
(analysis/gen_multigpu_campaign.py::xi_sponge_for) which pushes xi_sponge
toward its 55 ceiling at low kz / low alpha*V0 -- exactly the corner where
the eigensolver spectrum (and the actual CUDA simulation) contains a fast
"outer-region EM instability" (documented since Campaigns 19-21) that a
loose sponge fails to damp. See FINDINGS.md, "Investigation -- _bp28/
half-integer-kz sweep-table contamination, root cause (2026-07-14)" for the
full derivation and "Scope confirmation" for the results below.

Method: build_matrix() already adds the sponge as the same damping term the
simulation's kernel_ym_sponge applies, so screening candidate xi_sponge
values through the eigensolver is a cheap (CPU, seconds) proxy for the GPU
simulation. For each candidate sponge (a decreasing ladder from the
formula's suggestion down to 5), hunt the spectrum with several shift-invert
probes and classify every growing eigenvalue found: "outer branch" if its
growth rate exceeds ~1.3x gamma_WKB (calibrated, not derived -- see
classify()), else a candidate physical mode. Requires 2 CONSECUTIVE clean
ladder rungs, then applies a further 0.75x empirical safety margin -- a
single clean rung, even a "2-consecutive-clean" one, was directly shown by
CUDA to still fail late in a 100-TU run (see below).

*** IMPORTANT -- READ BEFORE TRUSTING THE OUTPUT ***
This is a candidate finder, not a proof of safety, and its own margin has
already been shown to be insufficient at some points even after one revision
(0.75x -> 0.5x, 2026-07-14, after a 7-point boundary-mapping exercise found
3 points where 0.75x wasn't enough but a further-tightened sponge, down to
roughly 0.4-0.6x the ladder pick, rescued every one of them). Within
V0<=0.05, boundary-mapping around several points (alpha=1.5-2.5, kz=1-2.5)
found NO hard physical wall -- every failure at the tool's recommendation
was rescuable by tightening further, usually into the sp=6-10 range. That is
NOT free: sponge compression is real and was measured directly (eigensolver),
e.g. one point's gamma_exact fell 33% between an unsafe-loose and a
safe-tight sponge.

**V0 transition mapped (2026-07-14)**: fixing alpha=1.5, kz=2.5 (the point
that originally failed at V0=0.10) and sweeping V0 upward, retesting each at
the sponge FLOOR (sp=5) when the tool's own recommendation still showed
contamination:

  V0=0.05  (baseline)         CLEAN at moderate sponge (sp~15, established earlier)
  V0=0.06                     CLEAN at floor (sp=5): E/E0 stays ~0.99-1.01 the whole 100 TU
  V0=0.07                     CLEAN at floor (sp=5), confirmed at TWO different (alpha,kz)
  V0=0.08                     MILD near-miss even at floor: flat to t~96, creeps to E/E0~1.22
  V0=0.09                     MODERATE near-miss even at floor: E/E0~1.28-1.35, visible by t~90
  V0=0.10                     HARD FAIL even at floor (sp=8 tried): outright blowup, t~38-91
                               depending on point

This is a gradual transition, not a step: V0<=0.07 is genuinely usable (rescuable to fully
clean with proper -- often quite tight -- sponge tuning); V0=0.08-0.09 is a real transition
zone where even the tightest sponge leaves measurable residual contamination (would bias any
quoted gamma high, not catastrophically wrong but not clean either); V0>=0.10 is a hard wall
where the sponge mechanism fails regardless of tightness. **Do not trust this tool's output
uncritically for V0 > 0.07 without a full-length CUDA spot-check**, and treat even the
V0<=0.07 recommendations as a strong starting candidate that still merits a
spot-check on the first point of any new (alpha, V0) series, not a proof.
For V0>=0.08, the sponge mechanism itself becomes insufficient regardless of
how tight it's set -- the eigensolver's xi_cut hard-wall option
(build_matrix(..., xi_cut=X), Dirichlet BC instead of soft damping) is
untried here and is the next thing to check before assuming those points are
unmeasurable. This whole area needs more understanding, not just a tighter
dial -- see FINDINGS.md and PRESENTATION.md for the open-question reminder
on what the outer branch actually is.

Usage (CLI):
  python3 find_safe_sponge.py --alpha 1.0 --V0 0.05 --kz 1.5 --verbose

Library:
  from find_safe_sponge import find_safe_xi_sponge
  sp, gamma_exact, info = find_safe_xi_sponge(alpha=1.0, V0=0.05, kz=1.5)
  # info['safe'] False means even the tightest candidate showed an outer
  # branch in the eigensolver itself -- treat as unmeasurable with this
  # sponge mechanism, don't just launch a run.
"""
import sys, os, argparse
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import ym_eigenmode as E

# Shift-invert probes beyond the default (real-mode-centred) shift, used to
# hunt for a fast outer-region eigenvalue that a single shift would miss.
# Chosen to bracket every outer-branch rate observed so far (0.75-1.43).
DANGER_SIGMAS = [0.2, 0.35, 0.5, 0.75, 1.1, 1.5, 2.2, 3.0]

SP_MIN = 5
SP_MAX = 55


def _production_formula(alpha, V0, kz):
    """The existing blind formula (gen_multigpu_campaign.py::xi_sponge_for),
    used only as the starting point for the search ladder -- NOT trusted as
    an answer."""
    kz_peak_est = max(0.5, round(2 * alpha) * 1.0)
    xi_crit = kz_peak_est / (alpha * V0)
    return max(SP_MIN, min(SP_MAX, int(xi_crit * 1.3)))


def _sponge_ladder(sp_start):
    """Decreasing candidate list from sp_start down to SP_MIN, geometric-ish."""
    fracs = [1.0, 0.8, 0.65, 0.5, 0.38, 0.28, 0.20, 0.14, 0.10]
    vals = sorted({max(SP_MIN, min(SP_MAX, round(sp_start * f))) for f in fracs},
                  reverse=True)
    if vals[-1] != SP_MIN:
        vals.append(SP_MIN)
    return vals


def hunt_eigs(kz, alpha, V0, EPS, NX, xi_sponge, sigma_sponge=5.0):
    """All distinct growing eigenvalues found across the real-mode shift and
    the danger-shift ladder, each tagged with where its |By2| peaks (xi units)."""
    gw = E.wkb_growth_rate(kz, alpha, V0)
    sigma0 = gw * 0.55 if (np.isfinite(gw) and gw > 0) else 0.1
    sigmas = [sigma0] + DANGER_SIGMAS

    dx = E.LX / NX
    x = np.arange(NX) * dx
    xi = (x - E.LX / 2.0) / EPS

    found, seen = [], set()
    for sig in sigmas:
        try:
            ev, evec = E.solve_eigenmode(kz, alpha, V0, EPS, NX, n_eigs=6,
                                         sigma=sig, xi_sponge=xi_sponge,
                                         sigma_sponge=sigma_sponge)
        except Exception:
            continue
        if ev is None:
            continue
        for j, v in enumerate(ev):
            if v.real < 1e-4:
                continue
            key = round(v.real, 4)
            if key in seen:
                continue
            seen.add(key)
            b, _, _, _, _, _ = E.extract_profiles(evec[:, j], NX)
            xi_peak = float(xi[np.argmax(np.abs(b))])
            found.append((float(v.real), xi_peak))
    return found


def classify(found, gamma_wkb, rate_factor=1.3, rate_floor=0.15, xi_abs_floor=25.0):
    """Split found eigenvalues into (real, outer).

    Tried a purely geometric split first (peak location relative to
    xi_sponge) and it does NOT work: the real mode's own peak drifts
    outward as xi_sponge tightens (it is only weakly confined at low kz),
    so at a tight sponge the physical mode's xi_peak can sit almost as far
    out as the outer branch did at a loose one -- geometry alone conflates
    them. Magnitude is the reliable signal instead: every outer-branch
    eigenvalue found so far (0.33-1.46) sits well above what a real KH mode
    can plausibly reach (existing project data: sim/exact ~ 0.5-0.7, WKB is
    a known *overestimate* of the true rate -- see FINDINGS.md), while every
    confirmed real mode is comfortably below gamma_WKB. Flag as outer if
    gamma exceeds rate_factor * gamma_WKB (with a floor for tiny gamma_WKB),
    OR if it peaks past a generous absolute xi bound no physical shear mode
    should ever reach (sanity fallback only, rarely the deciding factor).
    """
    threshold = max(rate_factor * gamma_wkb, rate_floor) if np.isfinite(gamma_wkb) else rate_floor
    real, outer = [], []
    for g, xi_peak in found:
        if g > threshold or abs(xi_peak) > xi_abs_floor:
            outer.append((g, xi_peak))
        else:
            real.append((g, xi_peak))
    return real, outer


SAFETY_MARGIN = 0.5  # see _apply_margin() docstring -- revised 2026-07-14 boundary mapping

def _apply_margin(sp):
    """Extra empirical safety margin below the eigensolver's own
    "2-consecutive-clean" pick, floored at SP_MIN.

    Direct CUDA verification (FINDINGS.md 2026-07-14) showed the linear
    one-shot check is optimistic even with the 2-consecutive-clean rule.
    First calibration (2 points) suggested 0.75x was enough; a follow-up
    7-point boundary-mapping exercise (perturbing alpha/V0/kz around a
    near-miss, one direction at a time) showed 0.75x was NOT enough for
    3 of those 7 points -- each had to be manually tightened further
    (down to roughly 0.4-0.6x their own "2-consecutive-clean" ladder pick,
    landing in the sp=6-10 range) before a full 100-TU CUDA run came back
    clean. 0.5x is the revised, more conservative value from that larger
    dataset. This buys safety at a real, measured accuracy cost: the
    eigensolver's own gamma estimate drops as the sponge tightens (the
    known sponge-compression tradeoff, PRESENTATION.md Sec 8.3) -- e.g.
    for one boundary point, gamma fell from 0.172 (sp=30) to 0.115
    (sp=10), a 33% reduction. This margin is still an empirical fit to a
    handful of points near alpha~1.5-2.5, V0~0.02-0.05, kz~1-2.5 -- NOT a
    general proof, and still needs a spot-check on any new region,
    especially anything closer to the V0=0.10 regime that failed outright
    even at the sponge floor."""
    return max(SP_MIN, int(round(sp * SAFETY_MARGIN)))


def hunt_and_report_real(kz, alpha, V0, EPS, NX, sp, sigma_sponge, gamma_wkb):
    """Re-hunt at the margin-adjusted sponge and return the accepted real
    mode's gamma (or None if nothing found -- caller falls back)."""
    found = hunt_eigs(kz, alpha, V0, EPS, NX, sp, sigma_sponge)
    real, _ = classify(found, gamma_wkb)
    return max((g for g, _ in real), default=None)


def find_safe_xi_sponge(alpha, V0, kz, EPS=0.15, NX=384, sigma_sponge=5.0,
                         require_consecutive=2, verbose=False):
    """Return (xi_sponge, gamma_exact, info). info['safe'] is False if even
    the tightest candidate (SP_MIN) still shows an outer branch -- meaning
    this point cannot be cleanly measured with this sponge mechanism alone
    and needs a different approach (e.g. xi_cut hard wall), not a rerun.

    A single "clean" ladder rung is NOT enough to trust: direct CUDA
    verification (FINDINGS.md 2026-07-14) showed a point that looked fully
    clean at xi_sponge=26 (one-shot linear eigenvalue check) still blew up
    at t=57 TU in the full 100-TU nonlinear run, while xi_sponge=15
    (confirmed by the same eigensolver AND by CUDA) held clean the whole
    way. A single snapshot misses slowly-growing residual outer-branch
    contamination that only becomes visible over a long integration. This
    requires `require_consecutive` (default 2) CONSECUTIVE clean ladder
    rungs before accepting, and returns the TIGHTEST of that run (extra
    margin, cheap to buy -- the physical mode's gamma barely moves between
    adjacent rungs once it's actually clean, see the point-1/point-2 ladders
    in FINDINGS.md)."""
    sp_start = _production_formula(alpha, V0, kz)
    ladder = _sponge_ladder(sp_start)
    gamma_wkb = E.wkb_growth_rate(kz, alpha, V0)
    if verbose:
        print(f"  formula suggests sp={sp_start}; gamma_WKB={gamma_wkb:.4f}; search ladder: {ladder}")

    last_real_gamma = None
    clean_run = []  # consecutive (sp, gamma) pairs with zero outer branch
    for sp in ladder:
        found = hunt_eigs(kz, alpha, V0, EPS, NX, sp, sigma_sponge)
        real, outer = classify(found, gamma_wkb)
        real_gamma = max((g for g, _ in real), default=None)
        if verbose:
            r = sorted({round(g, 4) for g, _ in real}, reverse=True)[:4]
            o = sorted({round(g, 4) for g, _ in outer}, reverse=True)[:4]
            print(f"  sp={sp:>3}: real={r}  outer={o}")
        if not outer and real_gamma is not None:
            clean_run.append((sp, real_gamma))
            if len(clean_run) >= require_consecutive:
                sp_ladder_pick, g_ladder_pick = clean_run[-1]
                sp_final = _apply_margin(sp_ladder_pick)
                g_final = hunt_and_report_real(kz, alpha, V0, EPS, NX, sp_final,
                                                sigma_sponge, gamma_wkb)
                if g_final is None:
                    g_final = g_ladder_pick  # fallback, shouldn't normally happen
                return sp_final, g_final, {'safe': True, 'formula_sp': sp_start,
                                            'ladder_pick': sp_ladder_pick}
            last_real_gamma = real_gamma
        else:
            clean_run = []  # any outer branch breaks the consecutive run
            if real_gamma is not None:
                last_real_gamma = real_gamma

    # Never got `require_consecutive` clean rungs in a row -- return the
    # tightest candidate anyway, flagged unsafe.
    return ladder[-1], last_real_gamma, {'safe': False, 'formula_sp': sp_start}


def main():
    p = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument('--alpha', type=float, required=True)
    p.add_argument('--V0', type=float, required=True)
    p.add_argument('--kz', type=float, nargs='+', required=True,
                    help='physical kz value(s) to check')
    p.add_argument('--EPS', type=float, default=0.15)
    p.add_argument('--NX', type=int, default=384)
    p.add_argument('--Lz', type=float, default=2.0 * np.pi,
                    help='only affects wkb sigma seed via E.LZ if you rely on it elsewhere')
    p.add_argument('--verbose', action='store_true')
    args = p.parse_args()

    E.LX = 6.0 * np.pi
    if args.V0 > 0.09:
        print(f"WARNING: V0={args.V0} is at/beyond the confirmed hard wall (V0=0.10 fails "
              f"even at the sponge floor, sp=5-8). This point is likely unmeasurable with "
              f"the sponge mechanism alone -- see the xi_cut note in this file's docstring.",
              file=sys.stderr)
    elif args.V0 > 0.07:
        print(f"WARNING: V0={args.V0} is in the confirmed transition zone (V0=0.08-0.09: "
              f"even the sponge floor leaves measurable residual contamination -- mild at "
              f"0.08, moderate at 0.09, not eliminated). Any gamma reported here likely reads "
              f"high. Do not trust it without a full-length CUDA spot-check.", file=sys.stderr)
    print(f"{'kz':>6} {'formula_sp':>10} {'safe_sp':>8} {'gamma_exact':>12} {'safe':>6}")
    for kz in args.kz:
        sp, g, info = find_safe_xi_sponge(args.alpha, args.V0, kz, args.EPS, args.NX,
                                           verbose=args.verbose)
        g_str = f"{g:.4f}" if g is not None else "NONE"
        print(f"{kz:>6.3f} {info['formula_sp']:>10} {sp:>8} {g_str:>12} {str(info['safe']):>6}")


if __name__ == '__main__':
    main()
