#!/usr/bin/env python3
"""
outer_region_theory.py — theory of the outer-region growth rates (2026-07-15
investigation; see OUTER_REGION.md for the summary and FINDINGS.md for results).

Three subcommands:

  local     — local (uniform-background) dispersion relation of the linearized
              color-2/3 system at each ξ: treats Az1(ξ), vzA(ξ) as constants
              and solves the 6×6 matrix over a kx scan. Overlays the analytic
              tachyonic rate γ_t(ξ) = sqrt(max(0, α²Az1² − kz²)), which is the
              kx=0 pure-EM (Faraday×Ampere) branch:
                  γ b  = −iΩ_F ex,   γ ex = −iΩ_A b   ⇒   γ² = −Ω_A·Ω_F
                  Ω_A = kz + αAz1,   Ω_F = kz − αAz1  ⇒   γ² = α²Az1² − kz²
              i.e. the charged (color-2/3) wave becomes tachyonic wherever
              |α·Az1(ξ)| > kz — the WKB confining well continued past its rim.

  validate  — hunts the FULL eigensolver spectrum (multi-shift, same probes as
              find_safe_sponge.py) and compares every growing "outer branch"
              eigenvalue against the local prediction evaluated at that mode's
              own peak position: γ_pred(ξ_peak) = γ_loc(ξ_peak) − sponge_damp.
              Agreement ⇒ the outer branch is the local tachyonic instability
              of the frozen background, not a discretization artifact.

  twostream — the OTHER outer-region mechanism, invisible to the eigensolver
              (which has no fluid density/momentum dof — state is only
              [b,ex,ez,a,qA,qB]): the color-1 cold two-stream of the
              counter-streaming beams at the kz values the bandpass filter
              retains (k_mode itself + everything above kz_suppress_hi).
              Exact symmetric cold-beam dispersion in code units (ω_p,beam=1):
                  1 = 1/(ω−kV)² + 1/(ω+kV)²
                  ⇒ γ²(kV) = sqrt(4k²V² + 1) − k²V² − 1
              Unstable band kV < √2 (matches the documented kz_ts≈14 cutoff at
              V0=0.1); small-kV limit γ ≈ kV (linear in V0 — candidate origin
              of the observed V0 scaling of the late catastrophe). Prints the
              predicted rate for each observed catastrophe point and the
              implied seed level ln(A_f/A_0) = γ_ts·t_onset.

Usage:
  python3 outer_region_theory.py local     --alpha 1.0 --V0 0.05 --kz 1.5 --xi-max 60
  python3 outer_region_theory.py validate  --alpha 1.0 --V0 0.05 --kz 1.5 --sponge 52
  python3 outer_region_theory.py twostream
"""
import sys, os, argparse
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import ym_eigenmode as E


# ── local uniform-background dispersion ──────────────────────────────────────
def local_matrix(kx, kz, alpha, A, v):
    """6×6 complex matrix of the linearized color-2/3 system at constant
    background (Az1=A, vzA=v), plane-wave ansatz e^{ikx·x}. Ordering matches
    ym_eigenmode: [b, ex, ez, a, qA, qB]."""
    Om_A = kz + alpha * A
    Om_F = kz - alpha * A
    M = np.zeros((6, 6), dtype=complex)
    M[0, 1] = -1j * Om_F          # γb  = -iΩ_F ex
    M[0, 2] = 1j * kx             #       + ikx ez
    M[1, 0] = -1j * Om_A          # γex = -iΩ_A b
    M[2, 0] = 1j * kx             # γez = ikx b
    M[2, 4] = +v                  #       + v qA
    M[2, 5] = -v                  #       - v qB
    M[3, 2] = -1.0                # γa  = -ez
    M[4, 3] = +1j * alpha * v     # γqA = iαv a - iv Ω_A qA
    M[4, 4] = -1j * v * Om_A
    M[5, 3] = +1j * alpha * v     # γqB = iαv a + iv Ω_A qB
    M[5, 5] = +1j * v * Om_A
    return M


def gamma_local(kz, alpha, A, v, kx_scan=None):
    """Max growth rate over kx of the local dispersion at one background point."""
    if kx_scan is None:
        kx_scan = np.linspace(0.0, 8.0, 161)
    best = 0.0
    for kx in kx_scan:
        ev = np.linalg.eigvals(local_matrix(kx, kz, alpha, A, v))
        best = max(best, ev.real.max())
    return best


def gamma_tachyonic(kz, alpha, A):
    """Analytic kx=0 pure-EM branch: γ² = α²A² − kz²."""
    val = (alpha * A) ** 2 - kz ** 2
    return np.sqrt(val) if val > 0 else 0.0


def profile(alpha, V0, kz, EPS, xi_max, n_xi=121):
    """γ_loc(ξ) and γ_t(ξ) along the mode-6 background Az1=-V0·log cosh ξ."""
    xis = np.linspace(0.0, xi_max, n_xi)
    A = -V0 * np.log(np.cosh(xis))
    vv = V0 * np.tanh(xis)
    g_loc = np.array([gamma_local(kz, alpha, a, v) for a, v in zip(A, vv)])
    g_tac = np.array([gamma_tachyonic(kz, alpha, a) for a in A])
    return xis, g_loc, g_tac


def cmd_local(args):
    xis, g_loc, g_tac = profile(args.alpha, args.V0, args.kz, args.EPS,
                                args.xi_max)
    xi_crit = args.kz / (args.alpha * args.V0)
    print(f"# local dispersion: alpha={args.alpha} V0={args.V0} kz={args.kz}")
    print(f"# xi_crit = kz/(alpha*V0) = {xi_crit:.2f}  "
          f"(tachyonic onset ~ where V0·log cosh ξ = kz/α; log cosh ξ ≈ ξ−log2)")
    print(f"{'xi':>8} {'gamma_local':>12} {'gamma_tachyonic':>16} {'ratio':>8}")
    for i in range(0, len(xis), max(1, len(xis) // 30)):
        r = g_loc[i] / g_tac[i] if g_tac[i] > 0 else np.nan
        print(f"{xis[i]:>8.2f} {g_loc[i]:>12.4f} {g_tac[i]:>16.4f} {r:>8.3f}")


# ── validate against the full eigensolver ────────────────────────────────────
DANGER_SIGMAS = [0.2, 0.35, 0.5, 0.75, 1.1, 1.5, 2.2, 3.0]


def cmd_validate(args):
    import find_safe_sponge as F
    kz, alpha, V0, EPS, NX = args.kz, args.alpha, args.V0, args.EPS, args.NX
    sp = args.sponge
    found = F.hunt_eigs(kz, alpha, V0, EPS, NX, sp if sp > 0 else None)
    if not found:
        print("no growing eigenvalues found")
        return
    print(f"# alpha={alpha} V0={V0} kz={kz} xi_sponge={sp} NX={NX}")
    print(f"{'gamma_eig':>10} {'xi_peak':>8} {'gamma_loc(ξpk)':>15} "
          f"{'gamma_tac(ξpk)':>15} {'sponge_damp':>12} {'eig/loc':>8}")
    for g, xi_peak in sorted(found, reverse=True):
        axp = abs(xi_peak)
        A = -V0 * np.log(np.cosh(axp))
        v = V0 * np.tanh(axp)
        g_loc = gamma_local(kz, alpha, A, v)
        g_tac = gamma_tachyonic(kz, alpha, A)
        damp = 5.0 * max(0.0, axp - sp) if sp > 0 else 0.0
        ratio = g / (g_loc - damp) if (g_loc - damp) > 0 else np.nan
        print(f"{g:>10.4f} {xi_peak:>8.2f} {g_loc:>15.4f} {g_tac:>15.4f} "
              f"{damp:>12.4f} {ratio:>8.3f}")


# ── color-1 cold two-stream (fluid channel, not in the eigensolver) ─────────
def gamma_twostream(kz_phys, V0):
    """Exact symmetric cold-beam rate in code units (per-beam ω_p = 1)."""
    s = (kz_phys * V0) ** 2
    val = np.sqrt(4.0 * s + 1.0) - s - 1.0
    return np.sqrt(val) if val > 0 else 0.0


# Observed late-catastrophe onsets (FINDINGS.md 2026-07-14/15, bp28 box).
# Fields: label, alpha, V0, kz_phys, mechanism+radius, observed onset t (TU);
# None = survived the full 100 TU.
OBSERVED = [
    ("sp12, V0=0.10",        1.5, 0.10, 2.5, "sponge 12", 38.4),
    ("sp8,  V0=0.10",        1.5, 0.10, 2.5, "sponge 8",  91.2),
    ("sp9,  V0=0.09",        1.5, 0.09, 2.5, "sponge 9",  82.7),
    ("xc5.5,V0=0.10",        1.5, 0.10, 2.5, "cut 5.5",   90.2),
    ("xc6,  V0=0.10",        1.5, 0.10, 2.5, "cut 6",     89.7),
    ("xc7,  V0=0.10",        1.5, 0.10, 2.5, "cut 7",     91.7),
    ("xc7,  V0=0.09",        1.5, 0.09, 2.5, "cut 7",     92.2),
    ("xc10, V0=0.09",        1.5, 0.09, 2.5, "cut 10",    57.3),
    ("xc10, V0=0.10",        1.5, 0.10, 2.5, "cut 10",    47.8),
    ("xc10+5x hyp, V0=0.10", 1.5, 0.10, 2.5, "cut 10",    87.7),
    ("xc15, V0=0.10",        1.5, 0.10, 2.5, "cut 15",    26.9),
    ("xc5,  V0=0.10 CROSS",  2.0, 0.10, 1.5, "cut 5",     97.7),
    ("xc5,  V0=0.10",        1.5, 0.10, 2.5, "cut 5",     None),
    ("xc5,  V0=0.09",        1.5, 0.09, 2.5, "cut 5",     None),
]


def cmd_twostream(args):
    print("# color-1 cold two-stream at the retained kz (= k_mode): "
          "γ² = sqrt(4(kV)²+1) − (kV)² − 1")
    print(f"# unstable band kV < sqrt(2)  →  kz_cutoff(V0=0.1) = {np.sqrt(2)/0.1:.1f}"
          "  (documented kz_ts≈14 ✓)")
    kmax = np.sqrt(0.75)
    print(f"# fastest-growing: kV = {kmax:.3f}, γ_max = 0.500  "
          "(documented full-domain rate 0.7–0.9 incl. EM corrections)")
    print()
    print(f"{'point':>22} {'γ_ts':>8} {'2γ_ts':>8} {'t_obs':>7} "
          f"{'ln(Af/A0)=γ·t':>14}")
    for label, alpha, V0, kzp, mech, t_obs in OBSERVED:
        g = gamma_twostream(kzp, V0)
        seed = g * t_obs if t_obs else np.nan
        t_str = f"{t_obs:.1f}" if t_obs else ">100"
        print(f"{label:>22} {g:>8.4f} {2*g:>8.4f} {t_str:>7} {seed:>14.1f}")
    print()
    print("# V0 ladder at alpha=1.5, kz=2.5 (the transition-mapping series):")
    print(f"{'V0':>6} {'γ_ts':>8} {'t to e^14 (~1e-6→O(1))':>24}")
    for V0 in (0.05, 0.06, 0.07, 0.08, 0.09, 0.10):
        g = gamma_twostream(2.5, V0)
        print(f"{V0:>6.2f} {g:>8.4f} {14.0/g if g>0 else np.inf:>24.1f}")


def main():
    p = argparse.ArgumentParser(description=__doc__)
    sub = p.add_subparsers(dest='cmd', required=True)
    for name in ('local', 'validate'):
        q = sub.add_parser(name)
        q.add_argument('--alpha', type=float, required=True)
        q.add_argument('--V0', type=float, required=True)
        q.add_argument('--kz', type=float, required=True,
                       help='physical kz')
        q.add_argument('--EPS', type=float, default=0.15)
        if name == 'local':
            q.add_argument('--xi-max', type=float, default=60.0)
        else:
            q.add_argument('--sponge', type=float, default=0.0,
                           help='xi_sponge used in the eigensolver hunt (0 = none)')
            q.add_argument('--NX', type=int, default=384)
    sub.add_parser('twostream')
    args = p.parse_args()
    if args.cmd == 'local':
        cmd_local(args)
    elif args.cmd == 'validate':
        cmd_validate(args)
    else:
        cmd_twostream(args)


if __name__ == '__main__':
    main()
