#!/usr/bin/env python3
"""
ym_eigenmode.py — 1D linearized eigenvalue solver for the SU(2) KH instability.

Linearises the coupled Maxwell + precession equations around the NAB_CIRC
(Mode 1 / Mode 6) background and solves for the dominant KH eigenvalue.

Background (periodic-x, single shear layer at x = Lx/2):
  Az1(ξ) = -V0 · log(cosh(ξ))     [frozen, log-cosh potential]
  vzA(ξ) = +V0 · tanh(ξ)          [beam-A z-velocity]
  vzB(ξ) = -V0 · tanh(ξ)          [beam-B z-velocity]
  ξ = (x - Lx/2) / EPS

Complex field combinations (colour-2 + i·colour-3):
  b  = By2 + i·By3
  ex = Ex2 + i·Ex3
  ez = Ez2 + i·Ez3
  a  = Az2 + i·Az3
  qA = Q2A + i·Q3A   (beam-A colour charges)
  qB = Q2B + i·Q3B   (beam-B colour charges)

Linearised equations (ansatz: ∂t → γ, ∂z → ikz):
  γ b  = -iΩ_F ex + ∂x ez         [Faraday;  Ω_F = kz - α Az1]
  γ ex = -iΩ_A b                   [Ampere-x; Ω_A = kz + α Az1]
  γ ez =  ∂x b + vzA (qA - qB)    [Ampere-z; backward diff for ∂x b]
  γ a  = -ez                        [Potential]
  γ qA =  iα vzA (a - Az1 qA)     [Precession beam A]
  γ qB =  iα vzA (a + Az1 qB)     [Precession beam B]

Derivative conventions (match simulation stencils):
  ∂x ez in Faraday → forward  difference: (ez[i+1] - ez[i]) / dx
  ∂x b  in Ampere  → backward difference: (b[i]   - b[i-1]) / dx

Boundary conditions: periodic in x (same as simulation modes 1,3,5,6).

Usage examples:
  python3 ym_eigenmode.py --alpha 2.0 --kz 1 2 3 4 5 6
  python3 ym_eigenmode.py --alpha 2.0 --kz 1 --plot --save-profiles
  python3 ym_eigenmode.py --alpha 0.5 --V0 0.1 --EPS 0.15 --kz 1 2 3
  python3 ym_eigenmode.py --alpha 4.0 --kz 1 --NX 768   # full resolution
"""

import numpy as np
import scipy.sparse as sp
import scipy.sparse.linalg as spla
from scipy.optimize import brentq
import argparse
import sys

# ── Physical constants and grid defaults ─────────────────────────────────────
LX          = 6.0 * np.pi      # domain length in x
LZ          = 2.0 * np.pi      # domain length in z (unused; sets kz normalisation)
V0_DEFAULT  = 0.1
EPS_DEFAULT = 0.15             # shear-layer half-width (physical units)
ALPHA_DEFAULT = 2.0
NX_DEFAULT  = 384              # 1-D grid points (768 = full sim resolution)


# ── WKB reference (step-potential parabolic well, wkb.pdf eq. 33) ────────────
def wkb_growth_rate(kz, alpha, V0=V0_DEFAULT, n_wkb=0):
    """
    Solve the WKB quantisation condition for the log-cosh / parabolic well
    (wkb.pdf, eq. 33):
        Q0    = -γ² - kz² + α²·V0·kz / γ²
        |C1|  =  α³·V0² / (2·γ²)
        Q0    = (2n+1)·√|C1|   (n=0 for ground state)
    Returns γ (real, positive growth rate).
    """
    if alpha == 0 or kz == 0:
        return float('nan')

    def residual(g):
        if g <= 0:
            return 1.0
        Q0  = -g**2 - kz**2 + alpha**2 * V0 * kz / g**2
        C1  =  alpha**3 * V0**2 / (2.0 * g**2)
        return Q0 - (2*n_wkb + 1) * np.sqrt(max(C1, 0.0))

    gvals = np.logspace(-4, 0, 500)
    rvals = [residual(g) for g in gvals]
    for i in range(len(rvals) - 1):
        if rvals[i] * rvals[i+1] < 0:
            try:
                return brentq(residual, gvals[i], gvals[i+1])
            except ValueError:
                pass
    return float('nan')


# ── Build sparse complex matrix L  (γ ψ = L ψ) ───────────────────────────────
def build_matrix(kz, alpha, V0, EPS, NX, xi_sponge=None, sigma_sponge=5.0,
                 xi_cut=None):
    """
    Returns the 6N × 6N complex sparse operator L in CSR format.
    State ordering: [b, ex, ez, a, qA, qB], each of length N = NX.

    xi_sponge : if set, add damping -σ_s(ξ)·I for |ξ| > xi_sponge (same as simulation).
                Typical value: xi_sponge=10.0 (Campaign 18 setting).
    sigma_sponge : sponge strength (default 5.0 matching simulation).
    xi_cut : if set, apply hard-wall (Dirichlet) BC — rows for |ξ_i| > xi_cut are
             replaced with 1·ψ_i = 0, killing the outer region entirely.
             Use e.g. xi_cut=5 to isolate the inner shear KH mode.
    """
    dx  = LX / NX
    x   = np.arange(NX) * dx
    xi  = (x - LX / 2.0) / EPS

    # Background profiles on the NX grid
    Az1  = -V0 * np.log(np.cosh(xi))       # [NX]
    vzA  =  V0 * np.tanh(xi)               # beam-A z-velocity

    # Effective frequencies
    Omega_A = kz + alpha * Az1             # Ampere:  kz + α Az1
    Omega_F = kz - alpha * Az1             # Faraday: kz - α Az1

    N  = NX
    sz = 6 * N

    # Accumulate COO entries
    row_list, col_list, val_list = [], [], []

    def add(r, c, v):
        row_list.append(r)
        col_list.append(c)
        val_list.append(complex(v))

    # Block offsets in the state vector
    ib  = 0 * N   # b  (By complex)
    iex = 1 * N   # ex (Ex complex)
    iez = 2 * N   # ez (Ez complex)
    ia  = 3 * N   # a  (Az complex)
    iqA = 4 * N   # qA (colour-charge beam A)
    iqB = 5 * N   # qB (colour-charge beam B)

    for i in range(N):
        ip1 = (i + 1) % N
        im1 = (i - 1 + N) % N

        # Hard-wall BC: outside domain → trivial row (eigenvalue = 0, field = 0)
        if xi_cut is not None and abs(xi[i]) > xi_cut:
            for blk in range(6):
                add(blk * N + i, blk * N + i, 0.0)  # identity-like, eigenvalue = 0
            continue

        Om_A = Omega_A[i]
        Om_F = Omega_F[i]
        vz   = vzA[i]
        A1   = Az1[i]

        # Ghost nodes: if neighbour is outside xi_cut, treat as zero (Dirichlet wall)
        ip1_ok = (xi_cut is None) or (abs(xi[ip1]) <= xi_cut)
        im1_ok = (xi_cut is None) or (abs(xi[im1]) <= xi_cut)

        # ── Row b_i: γ b = -iΩ_F ex + (ez[i+1] - ez[i]) / dx  (forward ∂x ez) ──
        add(ib + i, iex + i,   -1j * Om_F)
        add(ib + i, iez + i,   -1.0 / dx)
        if ip1_ok:
            add(ib + i, iez + ip1, +1.0 / dx)
        # else ez[ip1] = 0 by Dirichlet → no contribution

        # ── Row ex_i: γ ex = -iΩ_A b ──
        add(iex + i, ib + i, -1j * Om_A)

        # ── Row ez_i: γ ez = (b[i] - b[i-1])/dx + vzA·qA - vzA·qB  (backward ∂x b) ──
        add(iez + i, ib + i,   +1.0 / dx)
        if im1_ok:
            add(iez + i, ib + im1, -1.0 / dx)
        # else b[im1] = 0 by Dirichlet
        add(iez + i, iqA + i,  +vz)
        add(iez + i, iqB + i,  -vz)

        # ── Row a_i: γ a = -ez ──
        add(ia + i, iez + i, -1.0)

        # ── Row qA_i: γ qA = iα vzA a - i vzA Ω_A qA   [Doppler-corrected] ──
        add(iqA + i, ia  + i,  +1j * alpha * vz)
        add(iqA + i, iqA + i,  -1j * vz * Om_A)

        # ── Row qB_i: γ qB = iα vzA a + i vzA Ω_A qB   [Doppler-corrected] ──
        add(iqB + i, ia  + i,  +1j * alpha * vz)
        add(iqB + i, iqB + i,  +1j * vz * Om_A)

    # ── Sponge: add -σ_s(ξ_i) to diagonal of all 6 blocks for |ξ_i| > xi_sponge ──
    if xi_sponge is not None:
        for i in range(N):
            excess = abs(xi[i]) - xi_sponge
            if excess > 0:
                damp = sigma_sponge * excess
                for blk in range(6):
                    row_list.append(blk * N + i)
                    col_list.append(blk * N + i)
                    val_list.append(-damp + 0j)

    L = sp.coo_matrix(
        (val_list, (row_list, col_list)),
        shape=(sz, sz),
        dtype=complex
    )
    return L.tocsr()


# ── Eigenvalue solve ──────────────────────────────────────────────────────────
def solve_eigenmode(kz, alpha, V0, EPS, NX, n_eigs=10, sigma=None,
                    xi_sponge=None, sigma_sponge=5.0, xi_cut=None):
    """
    Solve γ ψ = L ψ for the dominant growing eigenvalue.
    Returns (eigenvalues sorted by Re(γ) desc, eigenvectors).
    """
    L = build_matrix(kz, alpha, V0, EPS, NX,
                     xi_sponge=xi_sponge, sigma_sponge=sigma_sponge,
                     xi_cut=xi_cut)

    if sigma is None:
        gw = wkb_growth_rate(kz, alpha, V0)
        sigma = gw * 0.55 if (np.isfinite(gw) and gw > 0) else 0.1

    try:
        eigvals, eigvecs = spla.eigs(L, k=n_eigs, sigma=sigma, which='LM',
                                     maxiter=10000, tol=1e-10)
    except spla.ArpackNoConvergence as e:
        eigvals = e.eigenvalues
        eigvecs = e.eigenvectors
        if len(eigvals) == 0:
            print(f"  ARPACK did not converge at all (sigma={sigma:.4f})", file=sys.stderr)
            return None, None
        print(f"  ARPACK partial convergence: {len(eigvals)} eigenvalues", file=sys.stderr)
    except Exception as e:
        print(f"  eigs error (sigma={sigma:.4f}): {e}", file=sys.stderr)
        return None, None

    # Sort by Re(γ) descending
    order   = np.argsort(-eigvals.real)
    eigvals = eigvals[order]
    eigvecs = eigvecs[:, order]
    return eigvals, eigvecs


# ── Split eigenvector into field profiles ─────────────────────────────────────
def extract_profiles(eigvec, NX):
    """Return (b, ex, ez, a, qA, qB) each of length NX (complex)."""
    N = NX
    return (eigvec[0*N:1*N], eigvec[1*N:2*N], eigvec[2*N:3*N],
            eigvec[3*N:4*N], eigvec[4*N:5*N], eigvec[5*N:6*N])


# ── Localisation check ────────────────────────────────────────────────────────
def is_localised(eigvec, NX, EPS, frac=0.15, xi_inner=None):
    """
    Returns True if the eigenvector peak is within the physical domain
    (|ξ| < xi_inner, default 5 for no-sponge; pass xi_sponge when sponge is used)
    and amplitude at the domain boundaries is < frac × peak.
    """
    if xi_inner is None:
        xi_inner = 5.0
    b = eigvec[0:NX]
    amp = np.abs(b)
    i_peak = np.argmax(amp)
    x_peak = i_peak * LX / NX
    xi_peak = abs(x_peak - LX / 2.0) / EPS
    amp_edge = max(amp[0], amp[NX - 1])
    return xi_peak < 1.15 * xi_inner and amp_edge < frac * amp[i_peak]


# ── Main ──────────────────────────────────────────────────────────────────────
def main():
    parser = argparse.ArgumentParser(
        description='1D eigenvalue solver for the SU(2) KH instability (NAB_CIRC background)'
    )
    parser.add_argument('--alpha', type=float, default=ALPHA_DEFAULT,
                        help='Colour coupling α_YM')
    parser.add_argument('--V0',   type=float, default=V0_DEFAULT,
                        help='Shear velocity V0')
    parser.add_argument('--EPS',  type=float, default=EPS_DEFAULT,
                        help='Shear-layer half-width EPS (physical units)')
    parser.add_argument('--kz',   type=int,   nargs='+', default=[1, 2, 3, 4, 5, 6],
                        help='z-wavenumber(s) to solve')
    parser.add_argument('--NX',   type=int,   default=NX_DEFAULT,
                        help='1-D grid points (default 384; 768 = full sim)')
    parser.add_argument('--Lz',  type=float, default=2.0*np.pi,
                        help='Physical domain length in z (default 2π). '
                             'kz_physical = k_mode * 2π / Lz. '
                             'For Lz=4π: k_mode=2 gives kz_phys=1, k_mode=1 gives kz_phys=0.5.')
    parser.add_argument('--Lx',  type=float, default=6.0*np.pi,
                        help='Physical domain length in x (default 6π).')
    parser.add_argument('--sigma', type=float, default=None,
                        help='Shift-invert target (default: 0.55 × γ_WKB)')
    parser.add_argument('--xi-sponge', type=float, default=10.0,
                        help='Sponge boundary in ξ-units (default 10.0, matching C18; 0=no sponge)')
    parser.add_argument('--sigma-sponge', type=float, default=5.0,
                        help='Sponge damping strength (default 5.0)')
    parser.add_argument('--xi-cut', type=float, default=None,
                        help='Hard-wall Dirichlet cutoff in ξ-units (default: None=no cut). '
                             'Use e.g. --xi-cut 15 to isolate inner KH mode for kz>=3.')
    parser.add_argument('--plot', action='store_true',
                        help='Save eigenvector profile plot')
    parser.add_argument('--save-profiles', action='store_true',
                        help='Save eigenvector arrays to .npz files')
    parser.add_argument('--export-seed', action='store_true',
                        help='Export normalized Re(Az) profile as raw float32 binary '
                             '(eigenmode_seed_kz{k}_a{a}_V{v}_sp{sp}.bin) for use as '
                             'simulation seed via ./ym_coupled arg[19]')
    args = parser.parse_args()

    alpha = args.alpha
    V0    = args.V0
    EPS   = args.EPS

    # Override module-level domain constants so build_matrix / is_localised pick them up
    global LX, LZ
    LZ = args.Lz
    LX = args.Lx

    xi_char_k1 = 1.0 / np.sqrt(alpha * 1 * V0) if alpha * V0 > 0 else np.inf
    print(f"# SU(2) KH eigenmode solver")
    print(f"#   α={alpha}, V0={V0}, EPS={EPS}, NX={args.NX}, Lz={LZ:.4f}, Lx={LX:.4f}")
    print(f"#   Background: Az1=-V0·log(cosh(ξ)), vzA=+V0·tanh(ξ), ξ=(x-Lx/2)/EPS")
    print(f"#   ξ_char(kz=1) = 1/sqrt(α·V0) = {xi_char_k1:.3f}  [WKB mode width in ξ-units]")
    print(f"#   Physical mode width(kz=1) = EPS·ξ_char = {EPS*xi_char_k1:.4f}")
    if abs(LZ - 2.0*np.pi) > 1e-6:
        print(f"#   NOTE: Lz={LZ:.4f} (not 2π). k_mode=n → kz_physical=n*2π/Lz={2*np.pi/LZ:.4f}*n")
    print()

    # Campaign 18 γ_Az measurements (corrected weight, sech centred at LX/2)
    # γ_By is biased low for large Az/By-ratio modes (kz=2,5) since By builds
    # from zero while Az is directly seeded; γ_Az is the cleaner comparison.
    C18 = {1: 0.279, 2: 0.173, 3: 0.212, 4: 0.220, 5: 0.175}

    print(f"{'kz':>4} {'γ_exact':>10} {'Im(γ)':>10} {'γ_WKB':>10} "
          f"{'ex/WKB':>8} {'sim/ex':>8} {'Az/By':>8} {'ξ_peak':>8} {'localised':>10}")
    print("─" * 85)

    results = {}
    for kz_int in args.kz:
        # Physical wavenumber: kz_physical = k_mode * 2π / Lz
        # When Lz=2π (default), kz_phys == kz_int. When Lz=4π, kz_phys = kz_int/2.
        kz = kz_int * 2.0 * np.pi / LZ
        kz_label = f"{kz_int}(kz={kz:.3f})" if abs(LZ - 2.0*np.pi) > 1e-6 else str(kz_int)

        gw = wkb_growth_rate(kz, alpha, V0)
        xi_char = 1.0 / np.sqrt(alpha * kz * V0) if alpha * kz * V0 > 0 else np.inf

        xi_sp = args.xi_sponge if args.xi_sponge > 0 else None
        eigvals, eigvecs = solve_eigenmode(kz, alpha, V0, EPS, args.NX,
                                           n_eigs=10, sigma=args.sigma,
                                           xi_sponge=xi_sp,
                                           sigma_sponge=args.sigma_sponge,
                                           xi_cut=args.xi_cut)
        if eigvals is None:
            print(f"{kz_label:>12}  FAILED")
            continue

        # xi_inner: modes within sponge boundary are "physical"
        xi_inner = xi_sp if xi_sp is not None else 5.0

        # Pick the best eigenvalue: largest Re(γ) among positive & localised within sponge
        best_idx  = None
        best_gam  = None
        for j, ev in enumerate(eigvals):
            if ev.real < 1e-5:
                continue
            if is_localised(eigvecs[:, j], args.NX, EPS, xi_inner=xi_inner):
                best_idx = j
                best_gam = ev
                break

        # Fallback: take largest positive Re(γ) regardless of localisation
        if best_gam is None:
            pos = [j for j, ev in enumerate(eigvals) if ev.real > 1e-5]
            if pos:
                best_idx = pos[0]
                best_gam = eigvals[best_idx]

        if best_gam is None:
            print(f"{kz_label:>12}  no growing mode  "
                  f"(all eigenvalues: {[f'{v.real:.3f}+{v.imag:.3f}i' for v in eigvals[:4]]})")
            continue

        b, ex, ez, a, qA, qB = extract_profiles(eigvecs[:, best_idx], args.NX)
        amp_b = np.max(np.abs(b))
        amp_a = np.max(np.abs(a))
        az_by = amp_a / amp_b if amp_b > 1e-15 else np.nan

        # Peak |ξ| location of By2 (b)
        dx_loc  = LX / args.NX
        x_arr   = np.arange(args.NX) * dx_loc
        xi_arr  = (x_arr - LX / 2.0) / EPS
        xi_peak_b = xi_arr[np.argmax(np.abs(b))]

        localised = is_localised(eigvecs[:, best_idx], args.NX, EPS, xi_inner=xi_inner)

        ex_wkb  = best_gam.real / gw if np.isfinite(gw) and gw > 0 else np.nan
        sim_val = C18.get(kz_int)
        sim_ex  = sim_val / best_gam.real if (sim_val and best_gam.real > 0) else np.nan

        print(f"{kz_label:>12} {best_gam.real:>10.4f} {best_gam.imag:>10.4f} {gw:>10.4f} "
              f"{ex_wkb:>8.3f} {sim_ex:>8.3f} {az_by:>8.2f} "
              f"{xi_peak_b:>8.2f} {'yes' if localised else 'NO':>10}")

        # Store by physical kz (float) as dict key so summary table works correctly
        results[kz] = dict(gamma=best_gam, gamma_wkb=gw,
                           kz_int=kz_int, kz_phys=kz,
                           eigvec=eigvecs[:, best_idx],
                           all_eigvals=eigvals, xi_char=xi_char)

        if args.save_profiles:
            x    = np.arange(args.NX) * LX / args.NX
            fname = f'eigenmode_kz{kz_int}_a{alpha:.2f}_V{V0:.2f}_EPS{EPS:.2f}.npz'
            np.savez(fname, x=x, b=b, ex=ex, ez=ez, a=a, qA=qA, qB=qB,
                     gamma=best_gam, gamma_wkb=gw, alpha=alpha, V0=V0, EPS=EPS,
                     kz_int=kz_int, kz_phys=kz, Lz=LZ)
            print(f"       → saved {fname}")

        if args.export_seed:
            # Phase-align all 6 fields: rotate so peak of |Az| is real and positive.
            # All profiles normalized to max|Az|=1 so amplitudes are comparable to Az seed.
            i_peak = np.argmax(np.abs(a))
            phase  = np.exp(-1j * np.angle(a[i_peak]))
            scale  = np.max(np.abs(a))
            profiles = np.stack([
                (b  * phase).real / scale,   # field 0: By2
                (ex * phase).real / scale,   # field 1: Ex2
                (ez * phase).real / scale,   # field 2: Ez2
                (a  * phase).real / scale,   # field 3: Az2
                (qA * phase).real / scale,   # field 4: Q2A (color-2, beam A)
                (qB * phase).real / scale,   # field 5: Q2B (color-2, beam B)
            ]).astype(np.float32)            # shape (6, NX)
            seed_fname = (f'eigenmode_seed_kz{kz_int}_a{alpha:.2f}'
                          f'_V{V0:.3f}_sp{args.xi_sponge:.1f}.bin')
            header = np.array([6, args.NX], dtype=np.int32)
            with open(seed_fname, 'wb') as sf:
                header.tofile(sf)
                profiles.tofile(sf)
            amp_by = np.max(np.abs(profiles[0]))
            amp_qA = np.max(np.abs(profiles[4]))
            print(f"       → 6-field seed saved to {seed_fname} "
                  f"(by/az={amp_by:.3f}  qA/az={amp_qA:.3f})")

    # Summary table
    if results:
        print()
        print("# Summary: exact eigenvalue vs WKB vs Campaign-18 simulation")
        print(f"{'kz':>4} {'γ_exact':>10} {'γ_WKB':>10} {'γ_sim(C18)':>12} "
              f"{'ex/WKB':>8} {'sim/ex':>8} {'sim/WKB':>9}")
        print("─" * 65)
        for kz_phys in sorted(results.keys()):
            r      = results[kz_phys]
            ge     = r['gamma'].real
            gw     = r['gamma_wkb']
            ki     = r['kz_int']
            gs     = C18.get(ki, np.nan)
            klabel = f"{ki}(kz={kz_phys:.3f})" if abs(LZ - 2.0*np.pi) > 1e-6 else str(ki)
            print(f"{klabel:>12} {ge:>10.4f} {gw:>10.4f} {gs:>12.4f} "
                  f"{ge/gw:>8.3f} {gs/ge:>8.3f} {gs/gw:>9.3f}")

    if args.plot and results:
        _plot(results, alpha, V0, EPS, args.NX)


def _plot(results, alpha, V0, EPS, NX):
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot as plt

    dx  = LX / NX
    x   = np.arange(NX) * dx
    xi  = (x - LX / 2.0) / EPS
    Az1 = -V0 * np.log(np.cosh(xi))

    kz_list = sorted(results.keys())
    n   = len(kz_list)
    fig, axes = plt.subplots(n, 3, figsize=(15, 3.5 * n), squeeze=False)

    for row, kz in enumerate(kz_list):
        r   = results[kz]
        gam = r['gamma']
        gw  = r['gamma_wkb']
        xc  = r['xi_char']

        b, ex, ez, a, qA, qB = extract_profiles(r['eigvec'], NX)

        # Normalise so |b|_max = 1; choose phase so peak Re(b) > 0
        amp  = np.max(np.abs(b))
        phi  = np.angle(b[np.argmax(np.abs(b))])
        b   *= np.exp(-1j * phi) / amp
        a   *= np.exp(-1j * phi) / amp
        qA  *= np.exp(-1j * phi) / amp
        qB  *= np.exp(-1j * phi) / amp

        gauss_ref = np.exp(-0.5 * xi**2 / xc**2)

        ax0, ax1, ax2 = axes[row]
        xi_cut = 12

        ax0.plot(xi, b.real,  'b-',  lw=1.5, label='Re(b)=By2')
        ax0.plot(xi, b.imag,  'b--', lw=1.0, label='Im(b)=By3')
        ax0.plot(xi, gauss_ref, 'k:', lw=1.0, label=f'WKB Gauss ξ_c={xc:.2f}')
        ax0.axhline(0, color='gray', lw=0.5)
        ax0.set_title(f'kz={kz}  γ_exact={gam.real:.4f}+{gam.imag:.4f}i\n'
                      f'γ_WKB={gw:.4f}  ratio={gam.real/gw:.3f}')
        ax0.set_xlim(-xi_cut, xi_cut); ax0.set_xlabel('ξ')
        ax0.set_ylabel('Magnetic / |b|_max')
        ax0.legend(fontsize=7)

        ax1.plot(xi, a.real,  'r-',  lw=1.5, label='Re(a)=Az2')
        ax1.plot(xi, a.imag,  'r--', lw=1.0, label='Im(a)=Az3')
        ax1.plot(xi, Az1 / (V0 + 1e-15) * 0.5, 'k:', lw=0.8, label='Az1/V0 × 0.5')
        ax1.axhline(0, color='gray', lw=0.5)
        ax1.set_title(f'|Az2|_max/|By2|_max = {np.max(np.abs(a)):.2f}')
        ax1.set_xlim(-xi_cut, xi_cut); ax1.set_xlabel('ξ')
        ax1.set_ylabel('Vector potential / |b|_max')
        ax1.legend(fontsize=7)

        ax2.plot(xi, qA.real, 'g-',  lw=1.5, label='Re(qA)=Q2A')
        ax2.plot(xi, qA.imag, 'g--', lw=1.0, label='Im(qA)=Q3A')
        ax2.plot(xi, qB.real, 'm-',  lw=1.5, label='Re(qB)=Q2B')
        ax2.axhline(0, color='gray', lw=0.5)
        ax2.set_title('Colour charges')
        ax2.set_xlim(-xi_cut, xi_cut); ax2.set_xlabel('ξ')
        ax2.legend(fontsize=7)

    plt.tight_layout()
    fname = f'eigenmode_a{alpha:.2f}_V{V0:.2f}_EPS{EPS:.2f}.png'
    plt.savefig(fname, dpi=150)
    print(f"\nSaved → {fname}")


if __name__ == '__main__':
    main()
