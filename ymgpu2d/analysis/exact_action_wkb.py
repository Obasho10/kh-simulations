#!/usr/bin/env python3
"""
exact_action_wkb.py — Exact-action WKB theory of the SU(2) shear (KH) branch.

Resolves roadmap T1.2. See PHYSICS.md §11 for the derivation and
PRESENTATION.md §5.4 for the status update this enables.

Contents
--------
1. Exact scalar reduction of the 6-field eigensolver system to one ODE:

       (γ² a'/D)' = (γ² + g) a
       D = γ² + Ω_A Ω_F = γ² + kz² - α²Az1²      (EM/tachyonic factor)
       g = 2α v³ Ω_A / (γ² + v² Ω_A²)            (two-beam precession drive)

   The reduction is exact at the discrete level too: `gamma_reduced()`
   reproduces ym_eigenmode.py eigenvalues to machine precision (the
   forward/backward stencils collapse to the flux-form FD of the ODE, with
   a zero-flux Neumann face on the mode side of the xi_cut wall and a
   Dirichlet ghost on the other).

2. Drive ceiling (exact):  γ³ ≤ α V0²  — G(w) = 2αV0³w/(γ²+V0²w²) is
   maximized on the precession-resonance surface w ≡ Ω_A = γ/V0.
   Natural scales: γ = (αV0²)^{1/3} γ̂,  kz = (α/V0)^{1/3} k̂.

3. Quantization (the branch is quantization-marginal, S < π/2):
       tan S = κ/k_edge,  κ = √(γ²+kz²)
   Model B (`gamma_modelB`): exact action ∫√Q dx over the true well.
   Model A (`gamma_modelA`): closed form —
       X ≡ √(G-γ²)/γ  from  L·X = arctan(1/X),  L = EPS(ξ_w-ξ0)kz
       γ² = ½[-V0²kz² + √(V0⁴kz⁴ + 8αV0³kz/(1+X²))]

4. Confinement-set peak (no intrinsic kz maximum exists; γ saturates at the
   ceiling in an unbounded domain as the mode rides the resonance surface
   outward):
       kz_peak ≈ αV0(ξ_w - ln2) + c(α/V0)^{1/3},  c ≈ 0.85–0.99

5. σ-chased dominant-eigenvalue solver (`gamma_true`): avoids the
   0.55·γ_WKB(quartic) shift-invert heuristic that lands on well-ladder
   overtones at low α / high kz (PHYSICS.md §11e).

Usage
-----
  # validate the reduction (machine-precision check):
  python3 analysis/exact_action_wkb.py --verify-reduction

  # dispersion curve: true n=0 vs model B vs model A:
  python3 analysis/exact_action_wkb.py --alpha 2.0 --V0 0.05 --cut 11 \
      --kz-max 10 --kz-step 0.5

  # regenerate the 12-series validation figure (slow, ~15 min):
  python3 analysis/exact_action_wkb.py --full-validation
"""
import sys, os, argparse, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from scipy.optimize import brentq
import ym_eigenmode as E

LX = 6*np.pi


# ── background profiles ──────────────────────────────────────────────────────
def profiles(NX, EPS, V0, alpha, kz):
    dx = LX/NX
    x = np.arange(NX)*dx
    xi = (x - LX/2)/EPS
    Az1 = -V0*np.log(np.cosh(xi))
    vz = V0*np.tanh(xi)
    return dx, xi, Az1, vz, kz + alpha*Az1, kz - alpha*Az1


# ── 1. exact discrete reduction (machine-precision equivalent to 6-field) ────
def build_reduced(gamma, kz, alpha, V0, EPS, NX, xi_cut):
    dx, xi, Az1, vz, OmA, OmF = profiles(NX, EPS, V0, alpha, kz)
    D = gamma**2 + OmA*OmF
    g = 2*alpha*vz**3*OmA/(gamma**2 + vz**2*OmA**2)
    idx = np.where(np.abs(xi) <= xi_cut)[0]
    n = len(idx)
    pos = -np.ones(NX, dtype=int)
    pos[idx] = np.arange(n)
    A = np.zeros((n, n), dtype=complex)
    g2 = gamma**2
    for jj, i in enumerate(idx):
        ip1, im1 = (i+1) % NX, (i-1+NX) % NX
        # gamma^2/dx^2 [(ez_{i+1}-ez_i)/D_i - (ez_i-ez_{i-1})/D_{i-1}] - (g_i+gamma^2) ez_i = 0
        # walls: right face Dirichlet ghost (ez=0), left face zero-flux (b=0)
        A[jj, jj] += -g2/dx**2/D[i] - g[i] - g2
        if pos[ip1] >= 0:
            A[jj, pos[ip1]] += g2/dx**2/D[i]
        if pos[im1] >= 0:
            A[jj, jj] += -g2/dx**2/D[im1]
            A[jj, pos[im1]] += g2/dx**2/D[im1]
    return A


def gamma_reduced(gamma0, kz, alpha, V0, EPS, NX, xi_cut, tol=1e-10, maxit=40):
    """Newton on mu(gamma)=0 where mu = eigenvalue of the reduced operator
    nearest zero. Converges to the 6-field eigenvalue nearest gamma0."""
    args = (kz, alpha, V0, EPS, NX, xi_cut)

    def mu(gam):
        w = np.linalg.eigvals(build_reduced(gam, *args))
        return w[np.argmin(np.abs(w))]

    gam = complex(gamma0)
    for it in range(maxit):
        m = mu(gam)
        if abs(m) < tol:
            return gam
        h = 1e-6*max(abs(gam), 1e-3)
        step = -m/((mu(gam+h)-m)/h)
        if abs(step) > 0.5*abs(gam):
            step *= 0.5*abs(gam)/abs(step)
        gam += step
        if abs(step) < 1e-12:
            return gam
    return gam


# ── 2. exact local wavenumber Q(x; gamma) ────────────────────────────────────
def Q_exact(gamma, kz, alpha, V0, EPS, N=8192, ximax=None):
    """Q on a fine xi<0 grid (the driven side for the 2+i3 polarization)."""
    if ximax is None:
        ximax = (LX/2)/EPS
    xi = np.linspace(-ximax, 0.0, N)
    Az1 = -V0*np.log(np.cosh(xi))
    vz = V0*np.tanh(xi)
    OmA = kz + alpha*Az1
    D = gamma**2 + (kz - alpha*Az1)*OmA
    g = 2*alpha*vz**3*OmA/(gamma**2 + vz**2*OmA**2)
    return xi, -D*(gamma**2 + g)/gamma**2


def ceiling(alpha, V0):
    """Exact drive ceiling gamma_max = (alpha V0^2)^(1/3)."""
    return (alpha*V0**2)**(1/3.)


def kz_peak_formula(alpha, V0, xi_w, c=0.9):
    """Confinement-set peak: resonance surface reaches the window radius."""
    return alpha*V0*(xi_w - np.log(2)) + c*(alpha/V0)**(1/3.)


# ── 3. Model B: exact-action quantization ────────────────────────────────────
def action_exact(gamma, kz, alpha, V0, EPS, xi_wall):
    xi, Q = Q_exact(gamma, kz, alpha, V0, EPS, ximax=xi_wall)
    dxi = xi[1]-xi[0]
    pos = Q > 0
    if not pos.any():
        return None
    idx = np.where(pos)[0]
    segs = np.split(idx, np.where(np.diff(idx) > 1)[0]+1)
    best, Sbest = None, 0.0
    for s in segs:
        Ss = np.sum(np.sqrt(Q[s]))*dxi*EPS
        if Ss > Sbest:
            Sbest, best = Ss, s
    s = best
    k_edge = np.sqrt(Q[s[max(0, len(s)-max(1, len(s)//5))]])
    kappa = np.sqrt(gamma**2 + kz**2)
    attached = xi[s[-1]] > -2.2      # well touches the tanh^3 knee
    free_outer = s[0] > 2            # outer edge is a turning point, not the wall
    return Sbest, k_edge, kappa, attached, free_outer


def gamma_modelB(kz, alpha, V0, EPS, xi_wall, n=0):
    g_hi = 0.9995*ceiling(alpha, V0)

    def f(gam):
        r = action_exact(gam, kz, alpha, V0, EPS, xi_wall)
        if r is None:
            return -10.0
        S, k_edge, kappa, attached, free = r
        Phi = (np.arctan2(kappa, k_edge) if attached else np.pi/4) + n*np.pi
        if free:
            Phi += np.pi/4
        return S - Phi

    gs = np.linspace(g_hi, 1e-3, 120)   # scan downward: first bracket = n=0
    vprev = f(gs[0])
    for i in range(1, len(gs)):
        v = f(gs[i])
        if vprev*v < 0:
            return brentq(f, gs[i], gs[i-1], xtol=1e-6)
        vprev = v
    return np.nan


# ── 4. Model A: closed-form square well ──────────────────────────────────────
def gamma_modelA(kz, alpha, V0, EPS, xi_wall, xi0=1.5):
    L = EPS*max(xi_wall - xi0, 1e-6)*kz
    X = brentq(lambda X: L*X - np.arctan(1.0/X), 1e-9, 1e3)
    y = (-V0**2*kz**2 + np.sqrt(V0**4*kz**4 + 8*alpha*V0**3*kz/(1+X**2)))/2.0
    return np.sqrt(y)


# ── 5. σ-chased dominant eigenvalue of the 6-field system ────────────────────
def gamma_true(kz, alpha, V0, EPS, NX, xi_cut, sigma0=None):
    """Largest localised growing eigenvalue; re-shifts upward until the top
    of the found window is clear. Returns (gamma, xi_peak_of_b) or None."""
    if sigma0 is None:
        gB = gamma_modelB(kz, alpha, V0, EPS, xi_cut)
        sigma0 = gB if np.isfinite(gB) else 0.5*ceiling(alpha, V0)
    sig = max(sigma0, 0.02)
    best = None
    for it in range(6):
        try:
            ev, evec = E.solve_eigenmode(kz, alpha, V0, EPS, NX, n_eigs=10,
                                         sigma=sig, xi_sponge=None, xi_cut=xi_cut)
        except Exception:
            return None
        if ev is None:
            return None
        cand = []
        for j, v in enumerate(ev):
            if v.real > 1e-4 and E.is_localised(evec[:, j], NX, EPS, xi_inner=xi_cut):
                b = evec[0:NX, j]
                xi = (np.arange(NX)*LX/NX - LX/2)/EPS
                cand.append((v.real, xi[np.argmax(np.abs(b))]))
        if not cand:
            return None
        gmax, pk = max(cand)
        if best is None or gmax > best[0]:
            best = (gmax, pk)
        if gmax >= 0.95*max(v.real for v in ev) and it < 5:
            sig = gmax*1.3
            continue
        break
    return best


# ── validation drivers ───────────────────────────────────────────────────────
def verify_reduction(NX=384, EPS=0.15):
    print(f"{'alpha':>5} {'V0':>5} {'kz':>4} {'cut':>4} | {'gamma_6field':>13} | {'gamma_reduced':>13} | rel.diff")
    for (alpha, V0, kz, xc) in [(2.0, 0.05, 1.0, 11), (2.0, 0.05, 3.0, 11),
                                (2.0, 0.05, 5.0, 11), (1.0, 0.05, 2.0, 20),
                                (3.0, 0.03, 7.0, 5), (1.0, 0.10, 1.0, 10),
                                (2.5, 0.05, 4.0, 9)]:
        ev, evec = E.solve_eigenmode(kz, alpha, V0, EPS, NX, xi_sponge=None, xi_cut=xc)
        g6 = None
        for j, v in enumerate(ev):
            if v.real > 1e-5 and E.is_localised(evec[:, j], NX, EPS, xi_inner=xc):
                g6 = v
                break
        if g6 is None:
            print(f"{alpha:5.1f} {V0:5.2f} {kz:4.1f} {xc:4.0f} | no growing mode")
            continue
        gr = gamma_reduced(g6, kz, alpha, V0, EPS, NX, xc)
        print(f"{alpha:5.1f} {V0:5.2f} {kz:4.1f} {xc:4.0f} | {g6.real:13.8f} | "
              f"{gr.real:13.8f} | {abs(gr-g6)/abs(g6):.2e}")


def dispersion(alpha, V0, cut, EPS=0.15, NX=768, kz_max=10.0, kz_step=0.5):
    KZ = np.arange(kz_step, kz_max + 1e-9, kz_step)
    print(f"# alpha={alpha} V0={V0} cut={cut}  ceiling={ceiling(alpha,V0):.4f}  "
          f"kz_peak_formula={kz_peak_formula(alpha,V0,cut):.2f}")
    print(f"{'kz':>5} {'gamma_n0':>9} {'xi_pk':>6} {'modelB':>8} {'modelA':>8} {'B/n0':>6}")
    prev = 0.5*ceiling(alpha, V0)
    for kz in KZ:
        gB = gamma_modelB(float(kz), alpha, V0, EPS, cut)
        gA = gamma_modelA(float(kz), alpha, V0, EPS, cut)
        r = gamma_true(float(kz), alpha, V0, EPS, NX, cut,
                       gB if np.isfinite(gB) else prev)
        gt, pk = (r if r is not None else (np.nan, np.nan))
        if np.isfinite(gt):
            prev = gt
        print(f"{kz:5.2f} {gt:9.4f} {pk:6.1f} {gB:8.4f} {gA:8.4f} {gB/gt:6.3f}")


def main():
    p = argparse.ArgumentParser(description=__doc__.split('\n')[1])
    p.add_argument('--verify-reduction', action='store_true')
    p.add_argument('--alpha', type=float, default=2.0)
    p.add_argument('--V0', type=float, default=0.05)
    p.add_argument('--EPS', type=float, default=0.15)
    p.add_argument('--cut', type=float, default=11.0)
    p.add_argument('--NX', type=int, default=768)
    p.add_argument('--kz-max', type=float, default=10.0)
    p.add_argument('--kz-step', type=float, default=0.5)
    args = p.parse_args()
    if args.verify_reduction:
        verify_reduction()
    else:
        dispersion(args.alpha, args.V0, args.cut, EPS=args.EPS, NX=args.NX,
                   kz_max=args.kz_max, kz_step=args.kz_step)


if __name__ == '__main__':
    main()
