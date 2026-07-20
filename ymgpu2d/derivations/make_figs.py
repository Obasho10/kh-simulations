#!/usr/bin/env python3
"""Generate all figures for derivations.tex.

Every curve is computed from the formulas derived in the document itself
(or, for the validation figure, from the repo's own 6-field eigensolver).
Run from anywhere:  python3 ymgpu2d/derivations/make_figs.py
Figures land in ymgpu2d/derivations/figs/*.pdf (vector).
"""
import os, sys
import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, '..', 'analysis'))
FIGS = os.path.join(HERE, 'figs')
os.makedirs(FIGS, exist_ok=True)

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from scipy.optimize import brentq

import exact_action_wkb as X
import ym_eigenmode as E

# ---- style (dataviz reference palette, light mode) --------------------------
C = dict(blue='#2a78d6', aqua='#1baf7a', yellow='#eda100', green='#008300',
         violet='#4a3aa7', red='#e34948', ink='#0b0b0b', ink2='#52514e',
         grid='#d9d8d4')
plt.rcParams.update({
    'font.size': 9, 'axes.labelsize': 9.5, 'axes.titlesize': 10,
    'axes.edgecolor': C['ink2'], 'axes.linewidth': 0.8,
    'axes.spines.top': False, 'axes.spines.right': False,
    'axes.grid': True, 'grid.color': C['grid'], 'grid.linewidth': 0.6,
    'grid.alpha': 0.6, 'lines.linewidth': 1.8,
    'xtick.color': C['ink2'], 'ytick.color': C['ink2'],
    'text.color': C['ink'], 'axes.labelcolor': C['ink'],
    'legend.frameon': False, 'legend.fontsize': 8.5,
    'figure.dpi': 110, 'savefig.bbox': 'tight',
})

def save(fig, name):
    p = os.path.join(FIGS, name)
    fig.savefig(p)
    plt.close(fig)
    print('wrote', p)

LN2 = np.log(2.0)

def quartic_gamma(kz, alpha, V0, n=0):
    Ccoef = (2*n+1)*np.sqrt(alpha**3/2.0)*V0
    r = np.roots([1.0, 0.0, -kz**2, -Ccoef, -alpha**2*V0*kz])
    g = r.imag[r.imag > 1e-12]
    return g.max() if len(g) else np.nan

# =============================================================================
# fig_background: shear/Az1 profiles + covariant wavenumbers
# =============================================================================
def fig_background():
    alpha, V0, kz = 2.0, 0.05, 2.0
    xi = np.linspace(-30, 30, 1201)
    fig, (a1, a2) = plt.subplots(1, 2, figsize=(6.6, 2.5))

    xa = np.linspace(-10, 10, 601)
    lc10 = np.log(np.cosh(10.0))
    a1.plot(xa, np.tanh(xa), color=C['blue'])
    a1.plot(xa, -np.log(np.cosh(xa))/lc10, color=C['red'])
    a1.axhline(0, color=C['ink2'], lw=0.7)
    a1.text(3.1, 0.72, r'$v_A/V_0=\tanh\xi$', color=C['blue'], fontsize=8.5)
    a1.text(-9.6, -0.62, r'$A_{z1}(\xi)/|A_{z1}(10)|$', color=C['red'], fontsize=8.5)
    a1.set_xlabel(r'$\xi$'); a1.set_ylabel('profile (normalized)')
    a1.set_xlim(-10, 10)

    u = alpha*V0*np.log(np.cosh(xi))
    OmA, OmF = kz - u, kz + u
    xic = kz/(alpha*V0) + LN2
    a2.plot(xi, OmA, color=C['blue'])
    a2.plot(xi, OmF, color=C['aqua'])
    a2.axhline(0, color=C['ink2'], lw=0.8)
    for s in (-1, 1):
        a2.axvspan(s*xic, s*30, color=C['red'], alpha=0.10, lw=0)
    a2.axvline(xic, color=C['red'], lw=0.9, ls=':')
    a2.axvline(-xic, color=C['red'], lw=0.9, ls=':')
    a2.text(0, 1.55, r'$\Omega_A=k_z-u$', color=C['blue'], ha='center', fontsize=8.5)
    a2.text(0, 3.0, r'$\Omega_F=k_z+u$', color=C['aqua'], ha='center', fontsize=8.5)
    a2.text(25.5, 0.6, 'tachyonic\n$u>k_z$', color=C['red'], ha='center', fontsize=8)
    a2.text(xic, -0.62, r'$\xi_{\rm crit}$', color=C['red'], ha='center', fontsize=8.5)
    a2.set_xlabel(r'$\xi$'); a2.set_ylabel(r'$\Omega_{A,F}$')
    a2.set_xlim(-30, 30)
    fig.tight_layout()
    save(fig, 'fig_background.pdf')

# =============================================================================
# fig_quartic: quartic dispersion + kz=0 Weibel anchors
# =============================================================================
def fig_quartic():
    V0 = 0.05
    kzs = np.linspace(0, 10, 401)
    fig, ax = plt.subplots(figsize=(4.6, 2.9))
    for alpha, col in [(1.0, C['blue']), (2.0, C['aqua']), (3.0, C['yellow'])]:
        g = [quartic_gamma(k, alpha, V0) for k in kzs]
        ax.plot(kzs, g, color=col)
        gw = np.sqrt(3)/2*((np.sqrt(alpha**3/2)*V0)**(1/3.))
        ax.plot([0], [gw], 'o', color=col, ms=5, zorder=5)
        ax.text(10.15, g[-1], rf'$\alpha={alpha:g}$', color=col,
                va='center', fontsize=8.5)
    ax.text(4.6, 0.045,
            'dots at $k_z=0$: chromo-Weibel\n'
            r'$\gamma(0)=\frac{\sqrt{3}}{2}C^{1/3}$, eq. (2.8)',
            fontsize=8.5, color=C['ink2'])
    ax.set_xlabel(r'$k_z$'); ax.set_ylabel(r'$\gamma$  (TU$^{-1}$)')
    ax.set_xlim(0, 11.6); ax.set_ylim(0, 0.34)
    save(fig, 'fig_quartic.pdf')

# =============================================================================
# fig_tachyon: local envelope gamma_loc(xi)
# =============================================================================
def fig_tachyon():
    alpha, V0 = 2.0, 0.05
    xi = np.linspace(0, 62.8, 1200)
    u = alpha*V0*np.log(np.cosh(xi))
    fig, ax = plt.subplots(figsize=(4.9, 2.9))
    ax.axvspan(0, 11, color=C['ink2'], alpha=0.08, lw=0)
    ax.text(5.5, 2.62, 'production\nwindow', ha='center', fontsize=8, color=C['ink2'])
    for kz, col in [(1.0, C['blue']), (2.0, C['aqua']), (4.0, C['yellow'])]:
        g2 = u**2 - kz**2
        g = np.where(g2 > 0, np.sqrt(np.clip(g2, 0, None)), np.nan)
        ax.plot(xi, g, color=col)
        xic = kz/(alpha*V0) + LN2
        ax.plot([xic], [0], 'o', color=col, ms=4, clip_on=False, zorder=5)
        xexit = np.sqrt(3.1**2 + kz**2)/(alpha*V0) + LN2
        dx = 3.6 if kz == 2.0 else 1.2
        ax.text(xexit+dx, 2.86, rf'$k_z={kz:g}$', color=col, fontsize=8.5)
    ax.plot(xi, alpha*V0*(xi-LN2), ls=':', color=C['ink2'], lw=1.1)
    ax.text(43, 2.28, r'$\alpha V_0(|\xi|-\ln 2)$', rotation=27,
            color=C['ink2'], fontsize=8)
    ax.set_xlabel(r'$|\xi|$')
    ax.set_ylabel(r'$\gamma_{\rm loc}=\sqrt{u^2-k_z^2}$  (TU$^{-1}$)')
    ax.set_xlim(0, 62.8); ax.set_ylim(0, 3.1)
    save(fig, 'fig_tachyon.pdf')

# =============================================================================
# fig_airy: wall-bounded outer-mode estimate
# =============================================================================
def fig_airy():
    alpha, V0, kz, EPS = 1.0, 0.05, 1.5, 0.15
    xic = kz/(alpha*V0) + LN2
    xw = np.linspace(xic+0.5, 60, 400)
    Uw = (alpha*V0*(xw-LN2))**2 - kz**2
    Up = 2*(alpha*V0)**2*(xw-LN2)/EPS
    g2 = Uw - 2.338*Up**(2/3.)
    fig, ax = plt.subplots(figsize=(4.6, 2.9))
    ax.plot(xw, Uw, ls='--', color=C['ink2'], lw=1.2)
    ax.plot(xw, g2, color=C['blue'])
    ax.axhline(0, color=C['ink2'], lw=0.8)
    ax.axvline(xic, color=C['red'], lw=0.9, ls=':')
    x0 = brentq(lambda x: (alpha*V0*(x-LN2))**2 - kz**2
                - 2.338*(2*(alpha*V0)**2*(x-LN2)/EPS)**(2/3.), xic+0.6, 60)
    ax.plot([x0], [0], 'o', color=C['blue'], ms=5, zorder=5)
    ax.axvspan(xic, x0, color=C['blue'], alpha=0.08, lw=0)
    ax.text((xic+x0)/2, 2.05, 'annulus holds\nno bound state', ha='center',
            fontsize=8, color=C['blue'])
    ax.text(48, 3.6, r'envelope $U_w=\gamma_{\rm loc}^2(\xi_w)$',
            color=C['ink2'], fontsize=8.5, ha='center')
    ax.text(49.5, 0.85, r"$U_w-2.338\,(U')^{2/3}$", color=C['blue'],
            fontsize=8.5, ha='center')
    ax.text(xic, -0.9, r'$\xi_{\rm crit}$', color=C['red'], ha='center', fontsize=8.5)
    ax.set_xlabel(r'wall radius $\xi_w$')
    ax.set_ylabel(r'$\gamma^2$  (TU$^{-2}$)')
    ax.set_xlim(28, 60); ax.set_ylim(-1.2, 4.4)
    save(fig, 'fig_airy.pdf')

# =============================================================================
# fig_anatomy: D, g, Q for a production point
# =============================================================================
def fig_anatomy():
    alpha, V0, EPS, kz, cut = 2.0, 0.05, 0.15, 4.0, 11.0
    gam = X.gamma_modelB(kz, alpha, V0, EPS, cut)
    print('anatomy point gamma_modelB =', gam)
    xi = np.linspace(-62.8, 0, 4000)
    Az1 = -V0*np.log(np.cosh(xi)); v = V0*np.tanh(xi)
    u = -alpha*Az1
    OmA, OmF = kz - u, kz + u
    D = gam**2 + OmA*OmF
    g = 2*alpha*v**3*OmA/(gam**2 + v**2*OmA**2)
    Q = -D*(gam**2 + g)/gam**2
    xires = -( (kz - gam/V0)/(alpha*V0) + LN2 )
    xicrit = -( np.sqrt(kz**2+gam**2)/(alpha*V0) + LN2 )

    fig, (a1, a2) = plt.subplots(1, 2, figsize=(6.8, 2.7))
    # left: full view, D and the tachyonic region
    a1.plot(xi, D, color=C['blue'])
    a1.axhline(0, color=C['ink2'], lw=0.8)
    a1.axvline(-cut, color=C['ink'], lw=1.0)
    a1.axvspan(xi[0], xicrit, color=C['red'], alpha=0.10, lw=0)
    a1.text(-59, 4.0, r'$\mathcal{D}<0$:'+'\ntachyon', color=C['red'], fontsize=8.5)
    a1.text(-12.3, -19.5, r'wall $\xi_w$', rotation=90, fontsize=8, color=C['ink'])
    a1.text(-40, 13.2, r'$\mathcal{D}=\gamma^2+k_z^2-u^2$', color=C['blue'],
            fontsize=9)
    a1.set_xlabel(r'$\xi$'); a1.set_ylabel(r'$\mathcal{D}$')
    a1.set_xlim(-62.8, 0)
    # right: zoom on the well
    a2.plot(xi, Q, color=C['violet'])
    a2.axhline(0, color=C['ink2'], lw=0.8)
    well = (Q > 0) & (xi >= -cut)
    a2.fill_between(xi, 0, np.where(well, Q, 0), color=C['violet'], alpha=0.25, lw=0)
    a2.axvline(-cut, color=C['ink'], lw=1.0)
    a2.axvline(xires, color=C['aqua'], lw=0.9, ls='--')
    a2.text(xires, 1.55, r'$\xi_{\rm res}$', color=C['aqua'], ha='center',
            fontsize=8.5)
    a2.text(-6.3, 0.72, 'well ($Q>0$)', color=C['violet'], ha='center', fontsize=8.5)
    a2.text(-3.6, -2.6, 'barrier\n$\\kappa^2=\\gamma^2+k_z^2$', ha='center',
            fontsize=8, color=C['ink2'])
    a2.text(-10.85, -3.35, r'wall $\xi_w$', rotation=90, fontsize=8, color=C['ink'])
    a2.set_xlabel(r'$\xi$'); a2.set_ylabel(r'$Q(\xi;\gamma)$')
    a2.set_xlim(-14, 0); a2.set_ylim(-4, 2)
    fig.tight_layout()
    save(fig, 'fig_anatomy.pdf')

# =============================================================================
# fig_drive: G(w) resonance + universal well edges
# =============================================================================
def fig_drive():
    alpha, V0, gam = 2.0, 0.05, 0.12
    w = np.linspace(0, 15, 800)
    G = 2*alpha*V0**3*w/(gam**2 + V0**2*w**2)
    ws, Gmax = gam/V0, alpha*V0**2/gam
    fig, (a1, a2) = plt.subplots(1, 2, figsize=(6.6, 2.7))
    a1.plot(w, G, color=C['blue'])
    a1.axhline(gam**2, color=C['red'], lw=1.0, ls='--')
    wm = brentq(lambda x: 2*alpha*V0**3*x/(gam**2+V0**2*x**2)-gam**2, 1e-3, ws)
    wp = brentq(lambda x: 2*alpha*V0**3*x/(gam**2+V0**2*x**2)-gam**2, ws, 40)
    a1.axvspan(wm, wp, color=C['blue'], alpha=0.08, lw=0)
    a1.plot([ws], [Gmax], 'o', color=C['blue'], ms=5, zorder=5)
    a1.annotate(r'$w^*=\gamma/V_0$,  $G_{\max}=\alpha V_0^2/\gamma$',
                xy=(ws, Gmax), xytext=(4.4, 0.0445), fontsize=8.5, color=C['ink'],
                arrowprops=dict(arrowstyle='-', color=C['ink2'], lw=0.7))
    a1.text(12.2, gam**2+0.0012, r'$\gamma^2$', color=C['red'], fontsize=9)
    a1.text(7.2, 0.0255, 'well: $G>\\gamma^2$', color=C['blue'], fontsize=8.5)
    a1.set_xlabel(r'$w=\Omega_A$'); a1.set_ylabel(r'drive $G(w)$')
    a1.set_xlim(0, 15); a1.set_ylim(0, 0.049)

    gh = np.linspace(0.30, 1.0, 400)
    wp_ = (1+np.sqrt(1-gh**6))/gh**2
    wm_ = (1-np.sqrt(1-gh**6))/gh**2
    a2.fill_between(gh, wm_, wp_, color=C['blue'], alpha=0.12, lw=0)
    a2.plot(gh, wp_, color=C['blue'])
    a2.plot(gh, wm_, color=C['blue'])
    a2.plot(gh, gh, ls='--', color=C['aqua'], lw=1.2)
    a2.plot([1], [1], 'o', color=C['red'], ms=5, zorder=6, clip_on=False)
    a2.set_yscale('log')
    a2.text(0.325, 8.0, r'$\hat{w}_\pm=\frac{1\pm\sqrt{1-\hat{\gamma}^6}}{\hat{\gamma}^2}$',
            color=C['blue'], fontsize=9)
    a2.text(0.53, 0.30, r'resonance $\hat{w}^*=\hat{\gamma}$', color=C['aqua'],
            fontsize=8.5, rotation=8)
    a2.annotate('ceiling\n$\\hat\\gamma=1$', xy=(1, 1), xytext=(0.80, 0.105),
                fontsize=8.5, color=C['red'], ha='center',
                arrowprops=dict(arrowstyle='-', color=C['red'], lw=0.7))
    a2.set_xlabel(r'$\hat{\gamma}=\gamma/(\alpha V_0^2)^{1/3}$')
    a2.set_ylabel(r'well edges $\hat{w}$')
    a2.set_xlim(0.30, 1.02)
    fig.tight_layout()
    save(fig, 'fig_drive.pdf')

# =============================================================================
# fig_quant: graphical LX=arctan(1/X) + matching cartoon
# =============================================================================
def fig_quant():
    fig, (a1, a2) = plt.subplots(1, 2, figsize=(6.6, 2.7))
    x = np.linspace(1e-3, 2.0, 500)
    a1.plot(x, np.arctan(1/x), color=C['ink'], lw=2.0)
    a1.text(1.62, 0.68, r'$\arctan(1/X)$', color=C['ink'], fontsize=9)
    for L, col in [(0.5, C['blue']), (1.0, C['aqua']), (2.0, C['yellow']),
                   (4.0, C['violet'])]:
        a1.plot(x, L*x, color=col, lw=1.4)
        Xs = brentq(lambda t: L*t - np.arctan(1/t), 1e-6, 10)
        a1.plot([Xs], [L*Xs], 'o', color=col, ms=5, zorder=5)
        xl = min(1.95, 1.45/L)
        a1.text(xl, L*xl+0.05, rf'$L={L:g}$', color=col, fontsize=8)
    a1.set_xlabel(r'$X=\sqrt{G-\gamma^2}/\gamma$')
    a1.set_ylabel('phase')
    a1.set_xlim(0, 2.0); a1.set_ylim(0, 1.75)

    kx, kap = 1.0, 2.5
    S = np.arctan(kap/kx)
    s1 = np.linspace(0, S/kx, 300)
    s2 = np.linspace(S/kx, S/kx+1.6, 200)
    a2.plot(s1, np.cos(kx*s1), color=C['blue'], lw=2.0)
    a2.plot(s2, np.cos(S)*np.exp(-kap*(s2-S/kx)), color=C['aqua'], lw=2.0)
    a2.axvline(0, color=C['ink'], lw=1.4)
    a2.axvline(S/kx, color=C['ink2'], lw=0.9, ls=':')
    a2.axhline(0, color=C['ink2'], lw=0.8)
    a2.text(0.045, 0.06, 'wall\n(Neumann,\nantinode)', fontsize=7.5, color=C['ink'])
    a2.text(0.52, 0.80, r'$\cos(k_x s)$', color=C['blue'], fontsize=9)
    a2.text(1.55, 0.33, r'$e^{-\kappa s}$ barrier', color=C['aqua'], fontsize=9)
    a2.annotate('slopes match:\n$\\tan S=\\kappa/k_x$', xy=(S/kx, np.cos(S)),
                xytext=(1.42, 0.66), fontsize=8, color=C['ink'],
                arrowprops=dict(arrowstyle='-', color=C['ink2'], lw=0.7))
    a2.set_xlabel(r'distance $s$ from outer wall')
    a2.set_ylabel(r'$a(s)$')
    a2.set_xlim(0, 2.75); a2.set_ylim(-0.15, 1.05)
    fig.tight_layout()
    save(fig, 'fig_quant.pdf')

# =============================================================================
# fig_dispersion: sigma-chased 6-field vs model B vs model A vs quartic
# =============================================================================
def fig_dispersion():
    alpha, V0, EPS, cut, NX = 2.0, 0.05, 0.15, 11.0, 384
    ceil = X.ceiling(alpha, V0)
    KZ = np.arange(0.5, 10.01, 0.5)
    gB, gA, gQ, gT = [], [], [], []
    prev = 0.5*ceil
    for kz in KZ:
        b = X.gamma_modelB(float(kz), alpha, V0, EPS, cut)
        a = X.gamma_modelA(float(kz), alpha, V0, EPS, cut)
        q = quartic_gamma(float(kz), alpha, V0)
        r = X.gamma_true(float(kz), alpha, V0, EPS, NX, cut,
                         b if np.isfinite(b) else prev)
        t = r[0] if r is not None else np.nan
        if np.isfinite(t):
            prev = t
        gB.append(b); gA.append(a); gQ.append(q); gT.append(t)
        print(f'  kz={kz:4.1f}  true={t if np.isfinite(t) else float("nan"):.4f} '
              f'B={b:.4f} A={a:.4f} quartic={q:.4f}')
    fig, ax = plt.subplots(figsize=(5.4, 3.2))
    ax.axhline(ceil, color=C['red'], lw=1.0, ls='--')
    ax.text(9.9, ceil+0.004, r'ceiling $(\alpha V_0^2)^{1/3}$', color=C['red'],
            ha='right', fontsize=8.5)
    ax.plot(KZ, gQ, color=C['yellow'], lw=1.4, ls=':')
    ax.plot(KZ, gA, color=C['aqua'], lw=1.5, ls='--')
    ax.plot(KZ, gB, color=C['blue'])
    ax.plot(KZ, gT, 'o', color=C['ink'], ms=4.5, zorder=6, mfc='none', mew=1.3)
    ax.text(2.05, 0.245, 'WKB quartic', color=C['yellow'], fontsize=8.5)
    ax.text(7.6, 0.128, 'model A', color=C['aqua'], fontsize=8.5)
    ax.text(4.35, 0.178, 'model B', color=C['blue'], fontsize=8.5)
    ax.text(1.15, 0.055, r'6-field eigensolver ($\sigma$-chased $n{=}0$)',
            color=C['ink'], fontsize=8.5)
    ax.set_xlabel(r'$k_z$'); ax.set_ylabel(r'$\gamma$  (TU$^{-1}$)')
    ax.set_xlim(0, 10.3); ax.set_ylim(0, 0.27)
    save(fig, 'fig_dispersion.pdf')

# =============================================================================
# fig_peak: window test + formula scatter
# =============================================================================
def fig_peak():
    alpha, V0, EPS = 2.0, 0.05, 0.15
    KZ = np.arange(1.0, 9.01, 0.25)
    fig, (a1, a2) = plt.subplots(1, 2, figsize=(6.6, 2.8))
    for cut, col in [(11.0, C['blue']), (25.0, C['aqua'])]:
        g = np.array([X.gamma_modelB(float(k), alpha, V0, EPS, cut) for k in KZ])
        a1.plot(KZ, g, color=col)
        i = np.nanargmax(g)
        a1.plot([KZ[i]], [g[i]], 'o', color=col, ms=5, zorder=5)
        kp = X.kz_peak_formula(alpha, V0, cut, c=1.0)
        a1.axvline(kp, color=col, lw=0.9, ls=':')
        dx = -1.6 if cut == 11.0 else 1.6
        a1.text(KZ[i]+dx, g[i]+0.006, rf'$\xi_w={cut:g}$', color=col,
                ha='center', fontsize=8.5)
    a1.set_xlabel(r'$k_z$'); a1.set_ylabel(r'$\gamma$ (model B, TU$^{-1}$)')
    a1.set_ylim(0.08, 0.20); a1.set_xlim(1, 9)

    # (true peak, formula peak) pairs from the 11-series validation table
    pairs = [(3.5, 3.7), (4.0, 4.0), (4.5, 4.5), (4.5, 4.7), (5.0, 5.0),
             (5.5, 5.0), (6.0, 5.6), (6.5, 6.2), (3.0, 3.1), (3.0, 3.6),
             (4.5, 4.45), (5.5, 5.85)]
    t = np.array([p[0] for p in pairs]); f = np.array([p[1] for p in pairs])
    a2.plot([2.4, 7], [2.4, 7], color=C['ink2'], lw=0.9, ls='--')
    a2.fill_between([2.4, 7], [2.4-0.6, 7-0.6], [2.4+0.6, 7+0.6],
                    color=C['ink2'], alpha=0.08, lw=0)
    a2.plot(f, t, 'o', color=C['blue'], ms=5)
    a2.text(5.2, 3.15, r'$\pm0.6$ band', color=C['ink2'], fontsize=8.5)
    a2.set_xlabel(r'formula $\alpha V_0(\xi_w-\ln2)+c\,(\alpha/V_0)^{1/3}$')
    a2.set_ylabel(r'measured $k_z^{\rm peak}$')
    a2.set_xlim(2.4, 7); a2.set_ylim(2.4, 7)
    fig.tight_layout()
    save(fig, 'fig_peak.pdf')

# =============================================================================
# fig_budget: EPS dependence through the action budget
# =============================================================================
def fig_budget():
    epss = np.geomspace(0.08, 0.5, 22)
    fig, ax = plt.subplots(figsize=(4.6, 2.9))
    series = [(1.0, 0.05, 5.0, 20.0, C['blue'], 0.0),
              (2.0, 0.05, 5.0, 10.0, C['aqua'], 0.0),
              (2.0, 0.05, 7.0, 10.0, C['yellow'], 0.0)]
    for alpha, V0, kz, xw, col, dy in series:
        ceil = X.ceiling(alpha, V0)
        g = np.array([X.gamma_modelB(kz, alpha, V0, float(e), xw) for e in epss])
        ax.plot(epss, g/ceil, color=col)
        ax.text(0.515, g[-1]/ceil + dy,
                rf'$\alpha={alpha:g},\,k_z={kz:g},\,\xi_w={xw:g}$',
                color=col, fontsize=8, va='center')
    ax.set_xlabel(r'shear width $\varepsilon_s$ (EPS)')
    ax.set_ylabel(r'$\gamma/(\alpha V_0^2)^{1/3}$')
    ax.set_xlim(0.08, 0.95)
    save(fig, 'fig_budget.pdf')

# =============================================================================
# fig_twostream: cold two-stream gamma(kV)
# =============================================================================
def fig_twostream():
    kv = np.linspace(0, np.sqrt(2), 500)
    g2 = np.sqrt(4*kv**2+1) - kv**2 - 1
    g = np.sqrt(np.clip(g2, 0, None))
    fig, ax = plt.subplots(figsize=(4.5, 2.8))
    ax.plot(kv, g, color=C['blue'])
    ax.plot(kv, kv, ls=':', color=C['ink2'], lw=1.1)
    ax.plot([np.sqrt(3)/2], [0.5], 'o', color=C['blue'], ms=5, zorder=5)
    ax.plot([np.sqrt(2)], [0], 'o', color=C['red'], ms=5, zorder=5, clip_on=False)
    ax.annotate(r'max: $\gamma=\frac{1}{2}$ at $kV=\frac{\sqrt{3}}{2}$',
                xy=(np.sqrt(3)/2, 0.5), xytext=(0.32, 0.545), fontsize=8.5,
                arrowprops=dict(arrowstyle='-', color=C['ink2'], lw=0.7))
    ax.text(np.sqrt(2)-0.02, 0.045, r'band edge $kV=\sqrt{2}$', color=C['red'],
            ha='right', fontsize=8.5)
    ax.text(0.16, 0.235, r'$\gamma\simeq kV$', color=C['ink2'], fontsize=8.5,
            rotation=48)
    ax.set_xlabel(r'$kV$'); ax.set_ylabel(r'$\gamma/\omega_p$')
    ax.set_xlim(0, 1.5); ax.set_ylim(0, 0.58)
    save(fig, 'fig_twostream.pdf')

# =============================================================================
# fig_backreaction: quadratic law
# =============================================================================
def fig_backreaction():
    amp = np.array([3.0e-3, 6.1e-2, 2.9e-1, 2.46])
    daz = np.array([3.6e-6, 1.6e-4, 3.6e-3, 2.42e-1])
    aa = np.geomspace(1e-3, 4, 200)
    fig, ax = plt.subplots(figsize=(4.5, 2.8))
    ax.loglog(aa, 0.04*aa**2, color=C['ink2'], lw=1.1, ls='--')
    ax.loglog(amp, daz, 'o', color=C['blue'], ms=6)
    ax.text(2.4e-2, 1.1e-4, r'$0.04\,|a|^2$', color=C['ink2'], fontsize=9,
            rotation=33)
    ax.text(1.25e-3, 3.5e-6, 'measured (t133,\nseeded$-$unseeded\ndifferencing)',
            fontsize=7.5, color=C['blue'])
    ax.set_xlabel(r'mode amplitude $|a|$')
    ax.set_ylabel(r'$|\Delta A_{z1}|$ at mode peak')
    save(fig, 'fig_backreaction.pdf')

# =============================================================================
# fig_seed: harmonic core ground state + width comparison
# =============================================================================
def fig_seed():
    alpha, V0, kz = 2.0, 0.1, 2.0
    gam = quartic_gamma(kz, alpha, V0)
    C1 = alpha**3*V0**2/(2*gam**2)
    sig = C1**-0.25
    Q0 = np.sqrt(C1)
    xi = np.linspace(-4.2, 4.2, 500)
    fig, (a1, a2) = plt.subplots(1, 2, figsize=(6.6, 2.7))
    a1.plot(xi, (Q0 - C1*xi**2)/Q0, color=C['blue'])
    a1.plot(xi, np.exp(-xi**2/(2*sig**2)), color=C['aqua'])
    a1.axhline(0, color=C['ink2'], lw=0.8)
    xt = np.sqrt(Q0/C1)
    for s in (-1, 1):
        a1.axvline(s*xt, color=C['ink2'], lw=0.8, ls=':')
    a1.text(0, -1.75, r'$Q_0-|C_1|\xi^2$ (normalized)', color=C['blue'],
            ha='center', fontsize=8.5)
    a1.text(1.9, 0.80, r'$e^{-\xi^2/2\xi_{\rm char}^2}$', color=C['aqua'],
            fontsize=9)
    a1.text(xt, -2.6, r'$\xi_T$', color=C['ink2'], ha='center', fontsize=8.5)
    a1.set_xlabel(r'$\xi$'); a1.set_ylabel('harmonic core / $n=0$ state')
    a1.set_ylim(-3.0, 1.15)

    x = np.geomspace(0.08, 3, 200)
    a2.plot(x, (2/x)**0.25, color=C['blue'])
    a2.plot(x, x**-0.5, color=C['aqua'])
    a2.axvspan(0.1, 1.2, color=C['ink2'], alpha=0.07, lw=0)
    a2.plot([0.5], [2**0.5], 'o', color=C['ink'], ms=4.5, zorder=5)
    a2.set_xscale('log')
    a2.text(0.75, 1.55, r'Hermite $(2/\alpha V_0 k_z)^{1/4}$', color=C['blue'],
            fontsize=8.5)
    a2.text(0.115, 1.12, r'code $(\alpha V_0 k_z)^{-1/2}$', color=C['aqua'],
            fontsize=8.5, rotation=-18)
    a2.text(0.36, 2.6, 'campaign grid', color=C['ink2'], fontsize=8)
    a2.set_xlabel(r'$\alpha V_0 k_z$'); a2.set_ylabel(r'$\xi_{\rm char}$')
    a2.set_ylim(0.5, 3.1)
    fig.tight_layout()
    save(fig, 'fig_seed.pdf')

# =============================================================================
if __name__ == '__main__':
    only = sys.argv[1:] or None
    for fn in [fig_background, fig_quartic, fig_tachyon, fig_airy, fig_anatomy,
               fig_drive, fig_quant, fig_dispersion, fig_peak, fig_budget,
               fig_twostream, fig_backreaction, fig_seed]:
        if only and fn.__name__ not in only:
            continue
        print('==', fn.__name__)
        fn()
