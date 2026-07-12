#!/usr/bin/env python3
"""Generate the presentation figures for spinkh/PRESENTATION.md.

Run from spinkh/:  python3 presentation/make_plots.py
Outputs into presentation/plots/. The A2/A3/A2b production figures are
copied from plots/ by the shell; this script builds the NEW explanatory
figures (band mechanism, T-S2 mediator verdict, material budget).
"""
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import os

OUT = os.path.join(os.path.dirname(__file__), 'plots')
os.makedirs(OUT, exist_ok=True)


# ────────────────────────────────────────────────────────────────────────────
# fig01 — the exchange-band mechanism: local dispersion + where the band
#          condition is met across the shear layer
# ────────────────────────────────────────────────────────────────────────────
def fig01():
    lam = 0.5
    V0, kappa = 0.05, 2.0
    fig, axes = plt.subplots(1, 2, figsize=(12.5, 4.6))

    # (a) local dispersion gamma(Delta)
    ax = axes[0]
    Delta = np.linspace(-3 * lam, 1 * lam, 800)
    inside = (Delta > -2 * lam) & (Delta < 0)
    g = np.where(inside, np.sqrt(np.maximum(lam**2 - (Delta + lam)**2, 0)), 0.0)
    ax.plot(Delta / lam, g / lam, 'b', lw=2)
    ax.axvspan(-2, 0, color='b', alpha=0.08)
    ax.annotate(r'$\gamma_{\max} = \lambda_{xc}$ at $\Delta=-\lambda_{xc}$',
                xy=(-1, 1), xytext=(-2.9, 0.75), arrowprops=dict(arrowstyle='->'), fontsize=10)
    ax.set_xlabel(r'detuning  $\Delta/\lambda_{xc}$,   $\Delta = v_z\,(k_z - \kappa\mathcal{A})$')
    ax.set_ylabel(r'growth rate  $\gamma/\lambda_{xc}$')
    ax.set_title('Local two-beam dispersion:  $\\gamma=\\sqrt{\\lambda^2-(\\Delta+\\lambda)^2}$\n'
                 'unstable band $-2\\lambda < \\Delta < 0$ (branch +)')
    ax.grid(alpha=0.3); ax.set_ylim(-0.05, 1.15)

    # (b) Delta(xi) profiles: where the band condition is met
    ax = axes[1]
    xi = np.linspace(-12, 12, 1200)
    vz = V0 * np.tanh(xi)                # beam A; branch + needs vz<0 side
    A = -V0 * np.log(np.cosh(xi))
    lam_b = 0.5
    for kz, c in [(5, '#9ecae1'), (10, '#4292c6'), (20, '#084594')]:
        D = vz * (kz - kappa * A)
        ax.plot(xi, D / lam_b, color=c, lw=1.8, label=f'$k_z$={kz}')
    ax.axhspan(-2, 0, color='b', alpha=0.08)
    ax.axhline(-1, color='k', ls=':', lw=1)
    ax.text(-11.5, -0.88, r'mid-band $\Delta=-\lambda$ (resonance surface)', fontsize=8)
    ax.set_xlabel(r'$\xi$ (shear-layer units)')
    ax.set_ylabel(r'$\Delta(\xi)/\lambda_{xc}$')
    ax.set_ylim(-4, 4)
    ax.set_title(f'Detuning across the layer  (λ={lam_b}, V₀={V0}, κ={kappa:.0f})\n'
                 'shaded = unstable band; modes live on the $v_z<0$ side')
    ax.legend(fontsize=9); ax.grid(alpha=0.3)

    fig.tight_layout()
    fig.savefig(os.path.join(OUT, 'fig01_band_mechanism.png'), dpi=140)
    plt.close(fig)


# ────────────────────────────────────────────────────────────────────────────
# fig02 — T-S2 mediator-structure verdict (values from TS2_RESULTS.md)
# ────────────────────────────────────────────────────────────────────────────
def fig02():
    fig, axes = plt.subplots(1, 2, figsize=(13, 4.8), gridspec_kw={'width_ratios': [1.15, 1]})

    # (a) structural diagram
    ax = axes[0]; ax.axis('off')
    def box(x, y, s, fc):
        ax.text(x, y, s, ha='center', va='center', fontsize=8.5,
                bbox=dict(boxstyle='round,pad=0.45', fc=fc, ec='k', lw=0.8))
    ax.set_xlim(0, 10); ax.set_ylim(0, 10)
    ax.text(5, 9.5, 'What carries the feedback loop?', ha='center', fontsize=11, weight='bold')
    box(2.5, 8.3, 'PLASMA (YM code)\nmediator $a$ = dynamical gauge field', '#dbeafe')
    box(2.5, 6.6, 'F1  integrator: response $\\propto 1/\\gamma^2$', '#dbeafe')
    box(2.5, 5.5, 'F2  current-sourced: $-v_z(q_A{-}q_B)$', '#dbeafe')
    box(2.5, 4.4, 'F3  nonlocal elliptic kernel', '#dbeafe')
    box(2.5, 2.7, 'KH-type loop GROWS\n(γ = 0.13 at kz=2, C35 point)', '#bbf7d0')
    box(7.5, 8.3, 'SOLID (2DEG)\nmediator $b_{xc}$ = exchange field $\\lambda\\, s_{tot}$', '#fee2e2')
    box(7.5, 6.6, 'algebraic (no F1)', '#fee2e2')
    box(7.5, 5.5, 'density-sourced $s_A{+}s_B$ (no F2)', '#fee2e2')
    box(7.5, 4.4, 'contact/local (no F3)', '#fee2e2')
    box(7.5, 2.7, 'KH-type loop PROVABLY STABLE\n(Re γ ≤ 0, all λ, both signs)', '#fecaca')
    box(5.0, 0.9, 'T-S2 verdict: F2 (current sourcing) is the essential feature — no solid interaction has it\n'
                  '⇒ pivot to the exchange-band instability (the solid\'s OWN unstable channel)', '#fef9c3')

    # (b) bar chart of closure scan at kz=2 (TS2_RESULTS.md tables)
    ax = axes[1]
    labels = ['full\n(gauge dyn.)', 'qstatic\n(frozen kernel)', 'exchange\nλ=0.1…100',
              'yukawa\nλ$_Y$=100', 'yukawa\nλ$_Y$=300\n(≈matched)', 'yukawa\nλ$_Y$=1000']
    vals = [0.1344, 0.138, 0.0, 0.083, 0.178, 0.346]
    cols = ['#2563eb', '#60a5fa', '#dc2626', '#f59e0b', '#f59e0b', '#f59e0b']
    ax.bar(range(len(vals)), vals, color=cols, edgecolor='k', lw=0.5)
    ax.set_xticks(range(len(vals))); ax.set_xticklabels(labels, fontsize=8)
    ax.axhline(0.1344, color='#2563eb', ls='--', lw=1)
    ax.set_ylabel(r'Re γ  (code units, kz=2, α=2, V₀=0.05)')
    ax.set_title('Mediator-replacement experiments on the\nplasma eigenproblem (ym_eigenmode_static.py)')
    ax.grid(axis='y', alpha=0.3)

    fig.tight_layout()
    fig.savefig(os.path.join(OUT, 'fig02_mediator_verdict.png'), dpi=140)
    plt.close(fig)


# ────────────────────────────────────────────────────────────────────────────
# fig06 — material budget (numbers from soc_params.py band_budget output)
# ────────────────────────────────────────────────────────────────────────────
def fig06():
    rows = [
        ('GaAs PSH QW — D_s measured\n(Weber05 spin gratings)', 169.4, 3.0e11, 2.0),
        ('GaAs PSH QW — D_s spin-drag\nestimate', 123.7, 2.4e11, 3.0),
        ('GaAs PSH QW — D_s ohmic\n(pessimistic)', 27.7, 0.81e11, 22.1),
        ('graphene/WSe₂ — spin-drag', 7.3, 2.8e11, 8.9),
        ('graphene/WSe₂ — ohmic', 5.2, 2.0e11, 14.1),
    ]
    fig, ax = plt.subplots(figsize=(9.5, 4.6))
    y = np.arange(len(rows))[::-1]
    marg = [r[1] for r in rows]
    cols = ['#15803d', '#22c55e', '#86efac', '#fbbf24', '#fcd34d']
    ax.barh(y, marg, color=cols, edgecolor='k', lw=0.5)
    for yi, r in zip(y, rows):
        ax.text(r[1] * 1.08, yi, f'γ_net ≈ {r[2]:.1e} s⁻¹,  pattern ≈ {r[3]:.1f} μm',
                va='center', fontsize=8.5)
    ax.axvline(1, color='r', ls='--', lw=1.5)
    ax.text(1.05, len(rows) - 0.6, 'threshold\n(margin = 1)', color='r', fontsize=9)
    ax.set_yticks(y); ax.set_yticklabels([r[0] for r in rows], fontsize=9)
    ax.set_xscale('log'); ax.set_xlim(0.5, 3000)
    ax.set_xlabel(r'supercriticality margin  $v_{\rm drift}/v_c$  (log)')
    ax.set_title('Exchange-band material budget (soc_params.py band_budget)\n'
                 r'threshold law $V_{0,c}=(1/\tau_s)^{3/2}\sqrt{D_s}/(0.65\lambda_{xc})$ — GaAs PSH is the platform')
    ax.grid(axis='x', alpha=0.3)
    fig.tight_layout()
    fig.savefig(os.path.join(OUT, 'fig06_material_budget.png'), dpi=140)
    plt.close(fig)


if __name__ == '__main__':
    fig01(); fig02(); fig06()
    print('wrote figures to', OUT)
