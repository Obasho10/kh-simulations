#!/usr/bin/env python3
"""
ym_eigenmode_static.py — T-S2: mediator-structure experiments on the plasma
eigenproblem (see DERIVATION.md §3/§6 and TS2_RESULTS.md).

Exact reduction of ymgpu2d/analysis/ym_eigenmode.py's 6-block system to
(mediator a, u = qA - qB, w = qA + qB):

    gamma^2 [ I - D_b diag(1/(gamma^2 + Om_A*Om_F)) D_f ] a = - vz u   (mediator)
    gamma u = -i vz Om_A w                              (+ sponge damping)
    gamma w = +2 i alpha vz a - i vz Om_A u             (+ sponge damping)

Modes (--mode):
  full      reference: import and run the production 6-block solver
  qstatic   companion form [a, atil, u, w] with the kernel frozen at
            gamma_ref = gamma_full + 0.03i (validates the reduction; removes
            retardation self-consistency, keeps integrator F1 + current source
            F2 + nonlocality F3). Iterated once on gamma_ref.
  yukawa    algebraic current-sourced mediator (F1 removed, F2 kept, F3 ~ 1/m):
                a = -lamY * (-Lap + kz^2 + m^2)^{-1} (vz u)
            scan --lamY and --mass.
  exchange  algebraic density-sourced local mediator (solid/exchange structure,
            F1+F2+F3 all removed):  a = lamX * w.   Scan --lamX.
            NOTE: operator = i*(Hermitian) - sponge => Re(gamma) <= 0 provably;
            included to confirm + quantify.

All modes share background, grid, and sponge with the production solver.
Defaults target Campaign 35 (alpha=2.0, V0=0.05, EPS=0.15, xi_sponge=11) whose
full-solver eigenvalues are known: kz=1..6 ->
0.0862 0.1344 0.1529 0.1597 0.1602 0.1419  (FINDINGS.md C35).

Usage:
  python3 ym_eigenmode_static.py --mode full qstatic --kz 1 2 3 4 5 6
  python3 ym_eigenmode_static.py --mode yukawa --kz 2 4 --lamY 1 10 100 1000 --mass 0 3
  python3 ym_eigenmode_static.py --mode exchange --kz 2 4 --lamX 0.1 1 10 100 -1 -10
"""

import argparse
import importlib.util
import sys
import numpy as np

YM_SOLVER_PATH = "/home/user/kh/ymgpu2d/analysis/ym_eigenmode.py"
C35_REF = {1: 0.0862, 2: 0.1344, 3: 0.1529, 4: 0.1597, 5: 0.1602, 6: 0.1419}


def load_full_solver():
    spec = importlib.util.spec_from_file_location("ym_eigenmode", YM_SOLVER_PATH)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


# ── shared geometry ───────────────────────────────────────────────────────────
def setup(NX, V0, EPS, alpha, kz, xi_sponge, sigma_sponge, LX=6 * np.pi):
    dx = LX / NX
    x = np.arange(NX) * dx
    xi = (x - LX / 2) / EPS
    Az1 = -V0 * np.log(np.cosh(xi))
    vz = V0 * np.tanh(xi)
    Om_A = kz + alpha * Az1
    Om_F = kz - alpha * Az1
    sp = np.where(np.abs(xi) > xi_sponge,
                  sigma_sponge * (np.abs(xi) - xi_sponge), 0.0)
    # periodic forward/backward first-difference (match production stencils)
    Df = (np.eye(NX, k=1) + np.eye(NX, k=-(NX - 1)) - np.eye(NX)) / dx
    Db = (np.eye(NX) - np.eye(NX, k=-1) - np.eye(NX, k=NX - 1)) / dx
    return dict(dx=dx, x=x, xi=xi, Az1=Az1, vz=vz, Om_A=Om_A, Om_F=Om_F,
                sp=sp, Df=Df, Db=Db)


def pick_mode(eigvals, eigvecs, xi, xi_sponge, nblocks, NX, frac=0.15):
    """Largest Re(gamma) whose |psi| peak lies inside the sponge and whose edge
    amplitude is small; fallback to largest Re."""
    order = np.argsort(-eigvals.real)
    fallback = None
    for j in order:
        vec = eigvecs[:, j]
        amp = np.sqrt(sum(np.abs(vec[k * NX:(k + 1) * NX]) ** 2
                          for k in range(nblocks)))
        i_pk = int(np.argmax(amp))
        if fallback is None:
            fallback = (eigvals[j], xi[i_pk])
        edge = max(amp[0], amp[-1])
        if abs(xi[i_pk]) < 1.15 * xi_sponge and edge < frac * amp[i_pk]:
            return eigvals[j], xi[i_pk], True
    return fallback[0], fallback[1], False


# ── mode: qstatic (companion linearization, kernel frozen at gamma_ref) ──────
def solve_qstatic(g, kz, alpha, gamma_ref, n_iter=2):
    NX = len(g["vz"])
    for _ in range(n_iter):
        denom = gamma_ref ** 2 + g["Om_A"] * g["Om_F"]
        K0 = np.eye(NX) - g["Db"] @ np.diag(1.0 / denom) @ g["Df"]
        B = np.linalg.solve(K0, np.diag(g["vz"] + 0j))   # K0^{-1} diag(vz)
        Z = np.zeros((NX, NX), complex)
        I = np.eye(NX)
        Dsp = np.diag(g["sp"] + 0j)
        VOm = np.diag(1j * g["vz"] * g["Om_A"])
        Va = np.diag(2j * alpha * g["vz"])
        #        a        atil     u        w
        M = np.block([
            [-Dsp,     I,       Z,       Z],
            [Z,        -Dsp,    -B,      Z],
            [Z,        Z,       -Dsp,    -VOm],
            [Va,       Z,       -VOm,    -Dsp]])
        w_, v_ = np.linalg.eig(M)
        lam, xpk, loc = pick_mode(w_, v_, g["xi"], XI_SPONGE_G, 4, NX)
        gamma_ref = lam.real + 0.03j if lam.real > 1e-4 else gamma_ref
    return lam, xpk, loc


# ── mode: yukawa (algebraic current-sourced mediator) ────────────────────────
def solve_yukawa(g, kz, alpha, lamY, mass):
    NX = len(g["vz"])
    Lap = g["Db"] @ g["Df"]
    Y = -Lap + (kz ** 2 + mass ** 2) * np.eye(NX)
    G = np.linalg.solve(Y, np.diag(g["vz"] + 0j))        # Y^{-1} diag(vz)
    Z = np.zeros((NX, NX), complex)
    Dsp = np.diag(g["sp"] + 0j)
    VOm = np.diag(1j * g["vz"] * g["Om_A"])
    drive = -2j * alpha * lamY * np.diag(g["vz"]) @ G    # 2ia vz * (-lamY G u)
    M = np.block([
        [-Dsp,           -VOm],
        [drive - VOm,    -Dsp]])
    w_, v_ = np.linalg.eig(M)
    return pick_mode(w_, v_, g["xi"], XI_SPONGE_G, 2, NX)


# ── mode: exchange (algebraic density-sourced local mediator) ────────────────
def solve_exchange(g, kz, alpha, lamX):
    NX = len(g["vz"])
    Dsp = np.diag(g["sp"] + 0j)
    VOm = np.diag(1j * g["vz"] * g["Om_A"])
    M = np.block([
        [-Dsp,  -VOm],
        [-VOm,  np.diag(2j * alpha * lamX * g["vz"]) - Dsp]])
    w_, v_ = np.linalg.eig(M)
    return pick_mode(w_, v_, g["xi"], XI_SPONGE_G, 2, NX)


XI_SPONGE_G = 11.0   # set in main()


def main():
    global XI_SPONGE_G
    ap = argparse.ArgumentParser()
    ap.add_argument("--mode", nargs="+", default=["full", "qstatic"],
                    choices=["full", "qstatic", "yukawa", "exchange"])
    ap.add_argument("--alpha", type=float, default=2.0)
    ap.add_argument("--V0", type=float, default=0.05)
    ap.add_argument("--EPS", type=float, default=0.15)
    ap.add_argument("--NX", type=int, default=384)
    ap.add_argument("--xi-sponge", type=float, default=11.0)
    ap.add_argument("--sigma-sponge", type=float, default=5.0)
    ap.add_argument("--kz", type=int, nargs="+", default=[1, 2, 3, 4, 5, 6])
    ap.add_argument("--lamY", type=float, nargs="+",
                    default=[1, 10, 100, 300, 1000, -100])
    ap.add_argument("--mass", type=float, nargs="+", default=[0.0, 3.0])
    ap.add_argument("--lamX", type=float, nargs="+",
                    default=[0.1, 1, 10, 100, -1, -10])
    args = ap.parse_args()
    XI_SPONGE_G = args.xi_sponge

    print(f"# T-S2 mediator experiments  alpha={args.alpha} V0={args.V0} "
          f"EPS={args.EPS} NX={args.NX} xi_sponge={args.xi_sponge}")

    full_gammas = {}
    if "full" in args.mode or "qstatic" in args.mode:
        ym = load_full_solver()
        print(f"\n== full (reference, production solver) ==")
        print(f"{'kz':>4} {'gamma':>10} {'Im':>10} {'C35 ref':>9}")
        for kz in args.kz:
            ev, evec = ym.solve_eigenmode(kz, args.alpha, args.V0, args.EPS,
                                          args.NX, n_eigs=10,
                                          xi_sponge=args.xi_sponge,
                                          sigma_sponge=args.sigma_sponge)
            if ev is None:
                print(f"{kz:>4}  FAILED")
                continue
            best = None
            for j, e in enumerate(ev):
                if e.real < 1e-5:
                    continue
                if ym.is_localised(evec[:, j], args.NX, args.EPS,
                                   xi_inner=args.xi_sponge):
                    best = e
                    break
            if best is None:
                best = ev[0]
            full_gammas[kz] = best
            ref = C35_REF.get(kz, float("nan"))
            print(f"{kz:>4} {best.real:>10.4f} {best.imag:>10.4f} {ref:>9.4f}")

    for kz in args.kz:
        g = setup(args.NX, args.V0, args.EPS, args.alpha, kz,
                  args.xi_sponge, args.sigma_sponge)

        if "qstatic" in args.mode:
            gref = full_gammas.get(kz, 0.15 + 0j).real + 0.03j
            lam, xpk, loc = solve_qstatic(g, kz, args.alpha, gref)
            gf = full_gammas.get(kz, np.nan)
            rat = lam.real / gf.real if kz in full_gammas else np.nan
            print(f"qstatic  kz={kz}  gamma={lam.real:+.4f}{lam.imag:+.4f}i  "
                  f"xi_pk={xpk:+.2f} loc={loc}  qs/full={rat:.3f}")

        if "yukawa" in args.mode:
            for m in args.mass:
                for lY in args.lamY:
                    lam, xpk, loc = solve_yukawa(g, kz, args.alpha, lY, m)
                    print(f"yukawa   kz={kz} m={m:<4g} lamY={lY:<8g} "
                          f"gamma={lam.real:+.4f}{lam.imag:+.4f}i  "
                          f"xi_pk={xpk:+.2f} loc={loc}")

        if "exchange" in args.mode:
            for lX in args.lamX:
                lam, xpk, loc = solve_exchange(g, kz, args.alpha, lX)
                print(f"exchange kz={kz} lamX={lX:<8g} "
                      f"gamma={lam.real:+.4f}{lam.imag:+.4f}i  "
                      f"xi_pk={xpk:+.2f} loc={loc}")


if __name__ == "__main__":
    main()
