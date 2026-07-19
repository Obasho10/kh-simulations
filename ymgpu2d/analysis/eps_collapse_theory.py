#!/usr/bin/env python3
"""
eps_collapse_theory.py -- Phase 0 (CPU-only, no GPU time) of the EPS-scan v2
campaign. See the plan this implements: does EPS enter the validated
exact-action theory (exact_action_wkb.py, PHYSICS.md Sec 11b) through the
single "quantization budget" group P = (alpha*V0^2)^(1/3) / EPS, and does
that explain both open T1.1 puzzles --

  1. kz_peak drifts with EPS on real GPU data (apparently contradicting the
     EPS-free leading-order formula kz_peak ~ alpha*V0*(xi_w-ln2)+c*(alpha/V0)^(1/3))
  2. gamma(kz) rises 10-39% from EPS 0.10->0.45 at fixed kz, fixed xi_sponge

Reuses (does not reimplement) the validated theory tools:
  - exact_action_wkb.py: gamma_modelA (closed-form, fast), gamma_modelB
    (exact-action, <=2% validated vs the sigma-chased eigensolver),
    ceiling(), kz_peak_formula().
  - find_safe_sponge.py: find_safe_xi_sponge() -- the real per-point vetted
    soft-sponge hunt used by production campaigns. Valid for V0<=0.07 only
    (FINDINGS.md 2026-07-14 V0-transition map); V0>=0.08 uses the hard
    xi_cut=5 wall instead (FINDINGS.md 2026-07-15 "xi_cut ... solves the
    V0=0.09-0.10 hard-wall zone" -- find_safe_xi_sponge is documented BLIND
    in that regime, so it is not used there).

Two grids:
  Grid A (wide/fast, Model A): continuous-kz peak search at a FIXED window
    group alpha*V0*xi_w = XI_W_GROUP (matches the empirical production
    convention, PHYSICS.md Sec 11d peak table: alpha*V0*xi_w in 0.9-1.2
    across validated series) -- isolates pure P-dependence. Covers alpha up
    to 10, the full historical V0 range, and a dense EPS grid, all cheap
    closed-form evaluations.
  Grid B (representative/accurate, Model B): the 15 (alpha,V0) x 5 EPS
    points Phase 1 will validate on GPU, using each point's REAL vetted
    window (soft xi_sponge or hard xi_cut as appropriate) -- these are the
    theory numbers the GPU campaign compares against.

Usage:
  python3 eps_collapse_theory.py --grid A
  python3 eps_collapse_theory.py --grid B
  python3 eps_collapse_theory.py --grid both     (default)
  python3 eps_collapse_theory.py --t25-check      # sanity check vs known 0.977+/-0.011
"""
import sys, os, argparse, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

import exact_action_wkb as X
import find_safe_sponge as F
import ym_eigenmode as E

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..'))
SWEEP_DIR = os.path.join(ROOT, 'sweep')
PLOT_DIR = os.path.join(ROOT, 'plots')

# ---- window-group convention (Grid A) ---------------------------------
# Holds alpha*V0*xi_w fixed across the whole grid so the sweep isolates the
# P-dependence cleanly (PHYSICS.md Sec 11b: "(k_hat, alpha*V0*xi_w) control
# the geometry" -- geometry and budget are supposed to be independent axes).
XI_W_GROUP = 1.0

# ---- window mechanism split (Grid B) -----------------------------------
V0_SOFT_SPONGE_MAX = 0.07   # find_safe_xi_sponge trustworthy up to here
XI_CUT_HIGH_V0 = 5.0        # documented safe hard-wall radius for V0>=0.08

LX_DEFAULT = 6.0 * np.pi
EPS_WIDE_THRESHOLD = 0.30
NX_SOLVER_DEFAULT = 384


def lx_for_eps(eps):
    return 2.0 * LX_DEFAULT if eps >= EPS_WIDE_THRESHOLD else LX_DEFAULT


def nx_solver_for_eps(eps):
    return 2 * NX_SOLVER_DEFAULT if eps >= EPS_WIDE_THRESHOLD else NX_SOLVER_DEFAULT


def find_continuous_peak(gamma_fn, kz_guess, kz_lo=0.25, kz_hi_mult=3.0, n_coarse=28,
                          n_fine=21, _expansions=0):
    """Coarse scan + local refine for the continuous kz maximizing gamma_fn(kz).
    No integer/tier constraint -- gives the exact-model ground-truth peak.
    Returns (kz_peak, gamma_peak), (nan, nan) if nothing valid is found.

    If the coarse-scan max lands on the lower edge (kz_lo), that is not a
    real peak -- it means gamma_fn was invalid (NaN/exception) everywhere
    else in range, a real failure mode seen at extrapolated grid corners
    (e.g. alpha=10, EPS=0.10: only 2/75 Grid-B points, both at the least-
    validated edge of Model A/B's tested range). Retry once with the coarse
    grid shifted inward (kz_lo doubled) before giving up and returning the
    edge value -- silently trusting an edge hit produces a spurious
    near-zero kz_peak that would corrupt any downstream collapse fit."""
    kz_hi = max(kz_guess * kz_hi_mult, kz_guess + 5.0, 3.0)
    kzs = np.linspace(kz_lo, kz_hi, n_coarse)

    def safe_eval(kz):
        try:
            g = gamma_fn(float(kz))
            return g if np.isfinite(g) else -np.inf
        except Exception:
            return -np.inf

    gammas = np.array([safe_eval(kz) for kz in kzs])
    if not np.any(np.isfinite(gammas)):
        return float('nan'), float('nan')
    i0 = int(np.argmax(gammas))
    if i0 == 0:
        if _expansions < 2:
            return find_continuous_peak(gamma_fn, kz_guess, kz_lo=kz_lo * 4, kz_hi_mult=kz_hi_mult,
                                         n_coarse=n_coarse, n_fine=n_fine, _expansions=_expansions + 1)
        # still an edge hit after 2 inward shifts: not a real interior peak
        # (e.g. gamma_fn is NaN almost everywhere -- no resolvable well at
        # this window/alpha/EPS combination, seen at the extrapolated
        # alpha=10 corner with a floor-tightened window) -- report failure
        # rather than a spurious near-zero kz_peak.
        return float('nan'), float('nan')
    lo = kzs[max(0, i0 - 1)]
    hi = kzs[min(n_coarse - 1, i0 + 1)]
    fine = np.linspace(lo, hi, n_fine)
    fg = np.array([safe_eval(kz) for kz in fine])
    if not np.any(np.isfinite(fg)):
        return float(kzs[i0]), float(gammas[i0])
    j0 = int(np.argmax(fg))
    return float(fine[j0]), float(fg[j0])


def window_for_point(alpha, V0, kz_guess, eps, nx_solver=NX_SOLVER_DEFAULT):
    """Real per-point vetted window: soft xi_sponge (V0<=0.07) or hard
    xi_cut=5 (V0>=0.08, the documented sponge-hard-wall regime)."""
    if V0 <= V0_SOFT_SPONGE_MAX:
        old_lx = E.LX
        E.LX = lx_for_eps(eps)
        try:
            sp, gamma_exact, info = F.find_safe_xi_sponge(alpha, V0, kz_guess, EPS=eps, NX=nx_solver)
        finally:
            E.LX = old_lx
        return float(sp), 'xi_sponge', bool(info.get('safe', False))
    return XI_CUT_HIGH_V0, 'xi_cut', True


def build_grid_a(alphas, V0s, epss, verbose=True):
    rows = []
    t0 = time.time()
    n_total = len(alphas) * len(V0s) * len(epss)
    n_done = 0
    for a in alphas:
        for v in V0s:
            xi_w = XI_W_GROUP / (a * v)
            kzg = X.kz_peak_formula(a, v, xi_w)
            kzg = kzg if (np.isfinite(kzg) and kzg > 0) else 1.0
            ceil = X.ceiling(a, v)
            for eps in epss:
                gfn = lambda kz, a=a, v=v, eps=eps, xi_w=xi_w: X.gamma_modelA(kz, a, v, eps, xi_w)
                kzp, gp = find_continuous_peak(gfn, kzg)
                P = ceil / eps
                rows.append(dict(
                    alpha=a, V0=v, EPS=eps, xi_w=xi_w, ceiling=ceil, P=P,
                    kz_peak=kzp, gamma_peak=gp,
                    kz_hat=(kzp / (a / v) ** (1 / 3.)) if np.isfinite(kzp) else np.nan,
                    gamma_hat=(gp / ceil) if np.isfinite(gp) else np.nan,
                ))
                n_done += 1
        if verbose:
            print(f"  Grid A: alpha={a:.3f} done ({n_done}/{n_total}, {time.time()-t0:.0f}s)",
                  file=sys.stderr)
    return pd.DataFrame(rows)


def build_grid_b(alphas, V0s, epss, verbose=True):
    rows = []
    t0 = time.time()
    n_total = len(alphas) * len(V0s) * len(epss)
    n_done = 0
    for a in alphas:
        for v in V0s:
            ceil = X.ceiling(a, v)
            for eps in epss:
                xi_w_guess = XI_W_GROUP / (a * v)
                kz_guess = X.kz_peak_formula(a, v, xi_w_guess)
                kz_guess = kz_guess if (np.isfinite(kz_guess) and kz_guess > 0) else 1.0
                xi_w, wtype, safe = window_for_point(a, v, kz_guess, eps)
                gfn = lambda kz, a=a, v=v, eps=eps, xi_w=xi_w: X.gamma_modelB(kz, a, v, eps, xi_w)
                kzp, gp = find_continuous_peak(gfn, kz_guess)
                P = ceil / eps
                n_done += 1
                if verbose:
                    print(f"  Grid B [{n_done}/{n_total}]: a={a} V0={v} EPS={eps} -> "
                          f"xi_w={xi_w:.2f}({wtype},safe={safe}) kz_peak={kzp:.3f} "
                          f"gamma_peak={gp:.4f} ({time.time()-t0:.0f}s)", file=sys.stderr)
                rows.append(dict(
                    alpha=a, V0=v, EPS=eps, xi_w=xi_w, window_type=wtype, window_safe=safe,
                    ceiling=ceil, P=P, kz_peak=kzp, gamma_peak=gp,
                    kz_hat=(kzp / (a / v) ** (1 / 3.)) if np.isfinite(kzp) else np.nan,
                    gamma_hat=(gp / ceil) if np.isfinite(gp) else np.nan,
                ))
    return pd.DataFrame(rows)


def replicate_original_1039_check(V0=0.05, epss=(0.10, 0.15, 0.225, 0.30, 0.45)):
    """Approximate replica of the T1.1 pre-registered finding (eps_tachyon_scan.py,
    since deleted -- exact xi_sponge values not recoverable): fixed kz, fixed
    xi_sponge (literal xi units, NOT the alpha*V0*xi_w group), only EPS
    varying, across the SAME (alpha, kz) grid the original used (alpha in
    {1.0, 2.0}, kz = 1..8, V0=0.05). xi_sponge per (alpha,kz) taken from the
    PHYSICS.md Sec 11d validated peak table where available, else the
    alpha*V0*xi_w=1.0 convention. If Model A reproduces a similar range of %
    rises, P is a strong candidate explanation for the magnitude puzzle."""
    pcts = []
    rows_all = []
    for alpha in (1.0, 2.0):
        for kz in range(1, 9):
            xi_sponge = XI_W_GROUP / (alpha * V0)  # fixed geometric window, EPS-independent
            gammas = [X.gamma_modelA(float(kz), alpha, V0, eps, xi_sponge) for eps in epss]
            g0, g1 = gammas[0], gammas[-1]
            if g0 and np.isfinite(g0) and np.isfinite(g1) and g0 > 0:
                pct = 100.0 * (g1 - g0) / g0
                pcts.append(pct)
                rows_all.append(dict(alpha=alpha, kz=kz, xi_sponge=xi_sponge,
                                      gamma_eps010=g0, gamma_eps045=g1, pct_rise=pct))
    df = pd.DataFrame(rows_all)
    print(f"\n=== Replicated 10-39% check: alpha in {{1.0,2.0}}, kz=1..8, V0={V0}, "
          f"fixed xi_sponge per (alpha,kz), EPS {epss[0]}->{epss[-1]} ===")
    print(df.to_string(index=False))
    if pcts:
        arr = np.array(pcts)
        print(f"  pct_rise range: [{arr.min():.1f}%, {arr.max():.1f}%]  "
              f"median={np.median(arr):.1f}%  (original T1.1 pre-registered finding: 10-39% rise)")
    return df


def t25_sanity_check():
    """Reproduce the T2.5 collapse sub-case at fixed EPS=0.15 with Model B +
    the real vetted window, and compare to the already-known 0.977+/-0.011
    (T2.1/T2.5, sigma-chased eigensolver, plots/t2p5_collapse.png). Model B
    is validated to <=2% (median <=0.2%) against that ground truth, so this
    should land close, not necessarily identical."""
    alphas = [1.0, 1.5, 2.0, 2.5, 3.0]
    V0s = [0.03, 0.05, 0.10]
    df = build_grid_b(alphas, V0s, [0.15], verbose=True)
    valid = df[np.isfinite(df['gamma_hat'])]
    r = valid['gamma_hat'].values
    print("\n=== T2.5 sanity check (Model B, EPS=0.15, real vetted window) ===")
    print(valid[['alpha', 'V0', 'gamma_hat', 'kz_peak', 'window_type']].to_string(index=False))
    print(f"\ngamma_hat: mean={r.mean():.4f} std={r.std():.4f} "
          f"(reference sigma-chased ground truth: 0.977+/-0.011)")
    ok = abs(r.mean() - 0.977) < 0.05
    print(f"-> {'PASS' if ok else 'CHECK'}: within 5% of the known ceiling ratio")
    return df


def make_collapse_plot(dfA, dfB, path):
    fig, ax = plt.subplots(1, 2, figsize=(13, 5))
    validA = dfA[np.isfinite(dfA['kz_hat']) & np.isfinite(dfA['gamma_hat'])]

    sc0 = ax[0].scatter(validA['P'], validA['kz_hat'], c=validA['EPS'], cmap='viridis',
                         s=6, alpha=0.5, label='Grid A (Model A)')
    ax[0].set_xlabel('P = (alpha V0^2)^(1/3) / EPS')
    ax[0].set_ylabel('kz_peak / (alpha/V0)^(1/3)')
    ax[0].set_xscale('log')
    ax[0].set_title('kz_peak collapse test')
    plt.colorbar(sc0, ax=ax[0], label='EPS')

    sc1 = ax[1].scatter(validA['P'], validA['gamma_hat'], c=validA['EPS'], cmap='viridis',
                         s=6, alpha=0.5, label='Grid A (Model A)')
    ax[1].axhline(0.977, color='r', ls='--', lw=1, label='T2.5 EPS=0.15 anchor (0.977+/-0.011)')
    ax[1].set_xlabel('P = (alpha V0^2)^(1/3) / EPS')
    ax[1].set_ylabel('gamma_peak / (alpha V0^2)^(1/3)')
    ax[1].set_xscale('log')
    ax[1].set_title('gamma_peak collapse test')
    plt.colorbar(sc1, ax=ax[1], label='EPS')

    if dfB is not None and len(dfB):
        validB = dfB[np.isfinite(dfB['kz_hat']) & np.isfinite(dfB['gamma_hat'])]
        ax[0].scatter(validB['P'], validB['kz_hat'], c='k', marker='x', s=35,
                       label='Grid B (Model B, real vetted window)')
        ax[1].scatter(validB['P'], validB['gamma_hat'], c='k', marker='x', s=35,
                       label='Grid B (Model B, real vetted window)')

    ax[0].legend(fontsize=7)
    ax[1].legend(fontsize=7)
    fig.suptitle('EPS-scan v2 Phase 0: does EPS enter only through P=(alphaV0^2)^(1/3)/EPS?')
    plt.tight_layout(rect=[0, 0, 1, 0.95])
    os.makedirs(os.path.dirname(path), exist_ok=True)
    plt.savefig(path, dpi=140, bbox_inches='tight')
    print(f"saved {path}")


def print_summary(df, label):
    r = df['gamma_hat'].dropna().values
    kh = df['kz_hat'].dropna().values
    print(f"\n=== {label} summary ===")
    if len(r):
        print(f"gamma_hat: n={len(r)} mean={r.mean():.4f} std={r.std():.4f} "
              f"spread={100*r.std()/r.mean():.1f}%  min={r.min():.4f} max={r.max():.4f}")
    if len(kh):
        print(f"kz_hat:    n={len(kh)} mean={kh.mean():.4f} std={kh.std():.4f} "
              f"spread={100*kh.std()/kh.mean():.1f}%  min={kh.min():.4f} max={kh.max():.4f}")


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--grid', choices=['A', 'B', 'both'], default='both')
    p.add_argument('--t25-check', action='store_true')
    p.add_argument('--n-alpha', type=int, default=40)
    p.add_argument('--n-v0', type=int, default=25)
    p.add_argument('--n-eps', type=int, default=12)
    args = p.parse_args()

    os.makedirs(SWEEP_DIR, exist_ok=True)
    os.makedirs(PLOT_DIR, exist_ok=True)

    if args.t25_check:
        t25_sanity_check()
        replicate_original_1039_check()
        return

    dfA = dfB = None
    if args.grid in ('A', 'both'):
        alphas = np.geomspace(0.3, 10.0, args.n_alpha)
        V0s = np.linspace(0.01, 0.20, args.n_v0)
        epss = np.geomspace(0.08, 0.5, args.n_eps)
        print(f"Grid A: {len(alphas)} alpha x {len(V0s)} V0 x {len(epss)} EPS = "
              f"{len(alphas)*len(V0s)*len(epss)} points", file=sys.stderr)
        dfA = build_grid_a(alphas, V0s, epss)
        dfA.to_csv(os.path.join(SWEEP_DIR, 'eps_collapse_gridA.csv'), index=False)
        print_summary(dfA, 'Grid A (wide, Model A)')
        replicate_original_1039_check()

    if args.grid in ('B', 'both'):
        alphas_b = [0.5, 1.5, 3.0, 6.0, 10.0]
        V0s_b = [0.03, 0.05, 0.10]
        epss_b = [0.10, 0.15, 0.225, 0.30, 0.45]
        dfB = build_grid_b(alphas_b, V0s_b, epss_b)
        dfB.to_csv(os.path.join(SWEEP_DIR, 'eps_collapse_gridB.csv'), index=False)
        print_summary(dfB, 'Grid B (representative, Model B, real vetted window)')

    if dfA is not None:
        make_collapse_plot(dfA, dfB, os.path.join(PLOT_DIR, 'eps_collapse_theory.png'))


if __name__ == '__main__':
    main()
