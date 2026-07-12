#!/usr/bin/env python3
"""
spin_eigenmode.py — v0.1 kinematic 1D eigenvalue solver for the spin-KH problem.

Solves the KINEMATIC limit of the spin-fluid model (MAPPING.md §6): frozen flow,
spin advection + precession about the background SOC field + exchange mean field
+ spin diffusion. Blocks (complex, on an NX grid in x):

    psi = [ sA2, sA3, sB2, sB3 ]

    gamma*sS2 = -i kz vS sS2  (+/-) lam (sA3+sB3) - kappa vS A(x) sS3 + Ds d2x sS2 - sp(x) sS2
    gamma*sS3 = -i kz vS sS3  (-/+) lam (sA2+sB2) + kappa vS A(x) sS2 + Ds d2x sS3 - sp(x) sS3

(upper sign: beam A with s1=+1, vA=+V0 f(x); lower: beam B, s1=-1, vB=-V0 f(x))

Everything in YM code units so results compare directly to ymgpu2d/ym_eigenmode.py
and FINDINGS.md: Lx=6*pi, xi=(x-Lx/2)/EPS, background profile options matching the
simulation modes. kappa plays the role of alpha_YM; lam is the exchange coupling
(the proposed replacement for the dynamical gauge sector, MAPPING.md §5).

WHAT THIS DOES AND DOES NOT CONTAIN
  - Contains: the spin analog of the plasma "precession cascade" physics; the
    exchange-driven spin two-stream band |kz*vz - kappa*vz*A + lam| < lam.
  - Does NOT contain (task T-S3, stubs below): flow feedback — spin force from
    d/dx A(x) on momentum, exchange-gradient force, Fermi pressure, Coulomb,
    momentum relaxation. The KH-analog mode lives there, exactly as the plasma
    KH mode required the Lorentz closure.

Usage examples:
    python3 spin_eigenmode.py --alpha 2.0 --V0 0.05 --lam 0.05 --kz 1 2 3 4 5 6
    python3 spin_eigenmode.py --profile uniform --lam 0.1 --kz 1 --plot
"""

import argparse
import numpy as np

LX = 6 * np.pi


# ── background profiles (YM code units) ──────────────────────────────────────
def background(profile, x, V0, EPS, patch_amp=8.0, patch_xi0=5.0, patch_w=1.5):
    """Return (vzA(x), A(x)); vzB = -vzA. A(x) in the same normalization as the
    YM code's Az1 so that the precession term is kappa * v_z * A(x)."""
    xi = (x - LX / 2) / EPS
    if profile == "logcosh":         # NAB_CIRC-style well (modes 1/6)
        vzA = V0 * np.tanh(xi)
        A = -V0 * np.log(np.cosh(xi))
    elif profile == "cos":           # NAB_TANH_COSAZ-style (mode 5) / gate-array
        vzA = V0 * np.tanh(xi)
        A = -V0 * np.cos(x)
    elif profile == "uniform":       # uniform PSH material, no gate modulation
        vzA = V0 * np.tanh(xi)
        A = -V0 * np.ones_like(x)
    elif profile == "patch":         # gate-defined SOC island (A2b designer test)
        vzA = V0 * np.tanh(xi)
        A = patch_amp * np.exp(-0.5 * (xi - patch_xi0) ** 2 / patch_w ** 2)
    else:
        raise ValueError(profile)
    return vzA, A


def sponge_profile(x, EPS, xi_sponge, sigma_sponge):
    """Smooth damping outside |xi| > xi_sponge (same role as the YM sponge)."""
    if xi_sponge <= 0:
        return np.zeros_like(x)
    xi = np.abs(x - LX / 2) / EPS
    ramp = 0.5 * (1 + np.tanh((xi - xi_sponge) / 1.0))
    return sigma_sponge * ramp


def periodic_d2(NX, dx):
    """Dense periodic second-derivative matrix."""
    D2 = np.zeros((NX, NX))
    for i in range(NX):
        D2[i, i] = -2.0
        D2[i, (i - 1) % NX] = 1.0
        D2[i, (i + 1) % NX] = 1.0
    return D2 / dx**2


# ── operator assembly ─────────────────────────────────────────────────────────
def assemble(kz, kappa, lam, Ds, vzA, A, sp, dx, inv_tau_s=0.0):
    """Build the dense complex 4NX x 4NX kinematic operator M with gamma = eig(M).
    Block order: [sA2, sA3, sB2, sB3]. inv_tau_s: uniform spin relaxation 1/tau_s."""
    NX = len(vzA)
    N = 4 * NX
    M = np.zeros((N, N), dtype=complex)
    D2 = periodic_d2(NX, dx)
    I = np.arange(NX)

    def blk(r, c):
        return (slice(r * NX, (r + 1) * NX), slice(c * NX, (c + 1) * NX))

    for s_idx, (sign, vz) in enumerate([(+1.0, vzA), (-1.0, -vzA)]):
        r2, r3 = 2 * s_idx, 2 * s_idx + 1          # rows for sS2, sS3
        prec = kappa * vz * A                       # Omega1_bg(x)
        dopp = -1j * kz * vz - sp - inv_tau_s       # advection + sponge + relaxation

        # sS2 row
        M[blk(r2, r2)] += np.diag(dopp) + Ds * D2
        M[blk(r2, r3)] += np.diag(-prec)
        M[blk(r2, 1)][I, I] += sign * lam           # lam * sA3
        M[blk(r2, 3)][I, I] += sign * lam           # lam * sB3
        # sS3 row
        M[blk(r3, r3)] += np.diag(dopp) + Ds * D2
        M[blk(r3, r2)] += np.diag(+prec)
        M[blk(r3, 0)][I, I] += -sign * lam          # -lam * sA2
        M[blk(r3, 2)][I, I] += -sign * lam          # -lam * sB2

    # ── T-S3 stubs (flow feedback; see MAPPING.md §6) ────────────────────────
    # TODO: extend psi with [dn_A, dpx_A, dpz_A, dn_B, dpx_B, dpz_B, phi_C] and add
    #   1. spin force from background SU(2) field strength: F_x ~ -(kappa/2) s^a vz dA/dx
    #   2. exchange-gradient force:  F_i ~ -(1/2) s^a d_i (lam * s_tot^a)
    #   3. Fermi pressure:           dP = cs2 * dn   (shared with roadmap T1.4)
    #   4. Coulomb (Poisson for phi_C; screens the density branch)
    #   5. momentum relaxation:      -dp/tau_p
    #   6. back-reaction on spin advection: -vz' * (dvx) terms from d(v s)/dx
    # Then the perturbed velocity re-enters the precession term (kappa * dvz * A * s1_bg)
    # closing the candidate spin-KH loop.
    return M


def solve(kz, args, vzA, A, sp, dx, x):
    M = assemble(kz, args.alpha, args.lam, args.Ds, vzA, A, sp, dx,
                 getattr(args, "inv_tau_s", 0.0))
    w, v = np.linalg.eig(M)
    order = np.argsort(-w.real)
    out = []
    NX = len(vzA)
    for idx in order[:args.nmodes]:
        vec = v[:, idx]
        amp = np.sqrt(sum(np.abs(vec[k * NX:(k + 1) * NX]) ** 2 for k in range(4)))
        xi_peak = (x[np.argmax(amp)] - LX / 2) / args.eps
        out.append((w[idx], xi_peak, vec))
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[1])
    ap.add_argument("--alpha", type=float, default=2.0, help="kappa (maps to alpha_YM)")
    ap.add_argument("--V0", type=float, default=0.05)
    ap.add_argument("--lam", type=float, default=0.05,
                    help="exchange coupling lambda_xc (dynamical-sector stand-in)")
    ap.add_argument("--Ds", type=float, default=1e-4, help="spin diffusion")
    ap.add_argument("--eps", type=float, default=0.15, help="shear width EPS")
    ap.add_argument("--profile", default="logcosh",
                    choices=["logcosh", "cos", "uniform", "patch"])
    ap.add_argument("--patch-amp", type=float, default=8.0)
    ap.add_argument("--patch-xi0", type=float, default=5.0)
    ap.add_argument("--patch-w", type=float, default=1.5)
    ap.add_argument("--inv-tau-s", type=float, default=0.0,
                    help="uniform spin relaxation rate 1/tau_s (code units)")
    ap.add_argument("--xi-sponge", type=float, default=10.0)
    ap.add_argument("--sigma-sponge", type=float, default=5.0)
    ap.add_argument("--NX", type=int, default=384)
    ap.add_argument("--kz", type=float, nargs="+", default=[1, 2, 3, 4, 5, 6])
    ap.add_argument("--nmodes", type=int, default=3)
    ap.add_argument("--plot", action="store_true")
    args = ap.parse_args()

    x = (np.arange(args.NX) + 0.5) * (LX / args.NX)
    dx = LX / args.NX
    vzA, A = background(args.profile, x, args.V0, args.eps,
                        args.patch_amp, args.patch_xi0, args.patch_w)
    sp = sponge_profile(x, args.eps, args.xi_sponge, args.sigma_sponge)

    print(f"# spin_eigenmode v0.1 KINEMATIC  profile={args.profile}  "
          f"alpha={args.alpha} V0={args.V0} lam={args.lam} Ds={args.Ds} "
          f"EPS={args.eps} NX={args.NX} xi_sponge={args.xi_sponge}")
    print(f"# NOTE: no flow feedback yet (T-S3) — growth here is the exchange/"
          f"precession family, not the spin-KH mode")
    print(f"{'kz':>5} | {'Re(gamma)':>10} {'Im(gamma)':>10} {'xi_peak':>8} | next modes Re")

    results = {}
    for kz in args.kz:
        modes = solve(kz, args, vzA, A, sp, dx, x)
        (g0, xp0, vec0) = modes[0]
        rest = "  ".join(f"{m[0].real:+.4f}" for m in modes[1:])
        print(f"{kz:5.2f} | {g0.real:10.4f} {g0.imag:10.4f} {xp0:8.2f} | {rest}")
        results[kz] = modes

    if args.plot:
        import matplotlib
        matplotlib.use("Agg")
        import matplotlib.pyplot as plt
        NX = args.NX
        fig, axes = plt.subplots(1, 2, figsize=(11, 4))
        axes[0].plot(args.kz, [results[k][0][0].real for k in args.kz], "o-")
        axes[0].set_xlabel("kz"); axes[0].set_ylabel("Re(gamma)")
        axes[0].set_title("kinematic spin dispersion (v0.1 — NOT spin-KH yet)")
        kz0 = args.kz[0]
        vec = results[kz0][0][2]
        xi = (x - LX / 2) / args.eps
        for k, lbl in enumerate(["sA2", "sA3", "sB2", "sB3"]):
            axes[1].plot(xi, np.abs(vec[k * NX:(k + 1) * NX]), label=lbl)
        axes[1].set_xlabel("xi"); axes[1].set_ylabel("|s|")
        axes[1].legend(); axes[1].set_title(f"leading eigenfunction, kz={kz0}")
        fig.tight_layout()
        fig.savefig("spin_eigenmode_v01.png", dpi=130)
        print("wrote spin_eigenmode_v01.png")


if __name__ == "__main__":
    main()
