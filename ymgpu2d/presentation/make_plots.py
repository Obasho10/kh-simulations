#!/usr/bin/env python3
"""Generate the presentation figures for ymgpu2d/PRESENTATION.md.

Run from ymgpu2d/:  python3 presentation/make_plots.py
Outputs into presentation/plots/. Figures that already exist as campaign
plots (plots/*.png) are copied separately by the shell — this script only
builds the NEW figures derived from analytic formulas, FINDINGS.md tables,
and the sweep/*.npz tables.
"""
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import os

OUT = os.path.join(os.path.dirname(__file__), 'plots')
SWEEP = os.path.join(os.path.dirname(__file__), '..', 'sweep')
os.makedirs(OUT, exist_ok=True)

# ────────────────────────────────────────────────────────────────────────────
# fig01 — the simulated configuration: velocity shear, Az1 background,
#          local precession frequency Omega_A and the outer-region structure
# ────────────────────────────────────────────────────────────────────────────
def fig01():
    EPS = 0.15
    V0, alpha, kz = 0.05, 2.0, 2.0
    xi_sponge = 11.0
    xi = np.linspace(-25, 25, 2001)
    vzA = V0 * np.tanh(xi)                 # in xi units, xi = (x-Lx/2)/EPS
    Az1 = -V0 * np.log(np.cosh(xi))
    OmA = kz + alpha * Az1                 # Doppler-shifted precession freq
    OmF = kz - alpha * Az1
    xi_crit = kz / (alpha * V0)

    fig, axes = plt.subplots(1, 3, figsize=(15, 4.2))
    ax = axes[0]
    ax.plot(xi, vzA / V0, 'b', label=r'$v_z^A/V_0 = \tanh\xi$')
    ax.plot(xi, -vzA / V0, 'r', label=r'$v_z^B/V_0 = -\tanh\xi$')
    ax.plot(xi, Az1 / V0, 'k--', label=r'$A_z^1/V_0 = -\log\cosh\xi$')
    ax.set_xlabel(r'$\xi = (x - L_x/2)/\mathrm{EPS}$'); ax.set_ylim(-6, 2)
    ax.set_title('Background: counter-streaming colored beams\n+ frozen color-1 potential (Mode 6)')
    ax.legend(loc='lower left', fontsize=9); ax.grid(alpha=0.3)

    ax = axes[1]
    ax.plot(xi, OmA, 'g', label=r'$\Omega_A = k_z + \alpha A_z^1$')
    ax.plot(xi, OmF, 'm', label=r'$\Omega_F = k_z - \alpha A_z^1$')
    ax.axhline(0, color='k', lw=0.5)
    for s in (-1, 1):
        ax.axvline(s * xi_crit, color='g', ls=':', lw=1)
    ax.axvspan(-25, -xi_sponge, color='gray', alpha=0.25)
    ax.axvspan(xi_sponge, 25, color='gray', alpha=0.25)
    ax.annotate(r'$\xi_{\rm crit}=k_z/(\alpha V_0)$', xy=(xi_crit, 0), xytext=(5, 1.5),
                arrowprops=dict(arrowstyle='->'), fontsize=10)
    ax.text(-24, 3.2, 'sponge', fontsize=9, color='dimgray')
    ax.text(15.5, 3.2, 'sponge', fontsize=9, color='dimgray')
    ax.set_xlabel(r'$\xi$'); ax.set_ylim(-4, 6)
    ax.set_title(f'Local precession frequencies\n(α={alpha}, V₀={V0}, kz={kz:.0f}; sponge at |ξ|>{xi_sponge:.0f})')
    ax.legend(fontsize=9); ax.grid(alpha=0.3)

    ax = axes[2]
    # outer EM growth estimate gamma ~ sqrt(|Omega_A| * Omega_F) where Omega_A<0
    g_out = np.where(OmA < 0, np.sqrt(np.abs(OmA) * np.maximum(OmF, 0)), 0.0)
    ax.plot(xi, g_out, 'darkorange', label=r'$\gamma_{\rm outer}\simeq\sqrt{|\Omega_A|\,\Omega_F}$')
    ax.axvspan(-25, -xi_sponge, color='gray', alpha=0.25)
    ax.axvspan(xi_sponge, 25, color='gray', alpha=0.25)
    ax.axhline(1.5, color='r', ls='--', lw=1, label='empirical safe limit 1.5 TU$^{-1}$')
    ax.set_xlabel(r'$\xi$'); ax.set_ylabel(r'$\gamma$ (TU$^{-1}$)')
    ax.set_title('Outer-region EM instability rate —\nwhy the sponge position must track $\\xi_{\\rm crit}$')
    ax.legend(fontsize=9); ax.grid(alpha=0.3)

    fig.tight_layout()
    fig.savefig(os.path.join(OUT, 'fig01_setup_profiles.png'), dpi=140)
    plt.close(fig)


# ────────────────────────────────────────────────────────────────────────────
# fig05 — kz_peak master table (hand-curated from FINDINGS.md, reliable
#          points only) vs alpha, with the kz_peak ≈ 2α guide line
# ────────────────────────────────────────────────────────────────────────────
def fig05():
    # (alpha, kz_peak_sim, V0, campaign) — from the Master kz_peak Table
    data = {
        0.02: [(2.0, 3), (3.0, 4)],
        0.03: [(1.5, 3), (2.0, 4), (2.5, 4), (3.0, 5), (4.0, 6), (5.0, 6)],
        0.05: [(0.5, 1), (1.0, 2), (1.5, 3), (2.0, 4), (2.5, 4.5), (3.0, 5)],
        0.10: [(0.5, 1), (1.0, 2.5), (1.5, 3), (2.0, 5), (2.5, 5), (3.0, 5)],
        0.20: [(1.0, 2), (1.5, 2.5), (2.0, 4), (2.5, 4), (3.0, 3.5)],
    }
    colors = {0.02: '#999999', 0.03: '#d62728', 0.05: '#1f77b4',
              0.10: '#2ca02c', 0.20: '#9467bd'}
    fig, ax = plt.subplots(figsize=(7, 5.2))
    rng = np.random.default_rng(3)
    for v0, pts in data.items():
        a = np.array([p[0] for p in pts]) + rng.uniform(-0.03, 0.03, len(pts))
        k = np.array([p[1] for p in pts])
        ax.plot(a, k, 'o-', ms=7, lw=1.2, color=colors[v0], label=f'V₀={v0}')
    aa = np.linspace(0.3, 5.2, 50)
    ax.plot(aa, 2 * aa, 'k--', lw=1.5, label=r'$k_{z,\rm peak} = 2\alpha$')
    ax.plot(aa, 1.5 * aa, 'k:', lw=1.2, label=r'$k_{z,\rm peak} = 1.5\alpha$')
    ax.set_xlabel(r'coupling $\alpha$'); ax.set_ylabel(r'$k_z$ at peak $\gamma$ (simulation, reliable points)')
    ax.set_title('Coupling-selected wavelength: the fastest-growing $k_z$\n'
                 'tracks the gauge coupling, weakly dependent on $V_0$')
    ax.legend(fontsize=9); ax.grid(alpha=0.3); ax.set_xlim(0, 5.4); ax.set_ylim(0, 8.5)
    fig.tight_layout()
    fig.savefig(os.path.join(OUT, 'fig05_kzpeak_vs_alpha.png'), dpi=140)
    plt.close(fig)


# ────────────────────────────────────────────────────────────────────────────
# fig06 — sweep-table heatmaps: gamma_sim(alpha, kz) per V0 + suspect mask
# ────────────────────────────────────────────────────────────────────────────
def fig06():
    files = [('v0p01', 0.01), ('v0p03', 0.03), ('v0p05', 0.05),
             ('v0p1', 0.10), ('v0p2', 0.20)]
    fig, axes = plt.subplots(1, 5, figsize=(22, 4.6), sharey=True)
    im = None
    for ax, (f, v0) in zip(axes, files):
        d = dict(np.load(os.path.join(SWEEP, f + '.npz')))
        gs = d['gamma_sim'].copy()
        gw = d['gamma_wkb']
        kz, al = d['kz_vals'], d['alpha_vals']
        with np.errstate(divide='ignore', invalid='ignore'):
            suspect = (~np.isnan(gs)) & ((gs > 2.0 * gw) | (gs > 0.6))
        show = np.ma.masked_invalid(np.where(suspect, np.nan, gs))
        im = ax.pcolormesh(kz, al, show, cmap='viridis', vmin=0, vmax=0.4, shading='nearest')
        ky, kx = np.where(suspect)
        ax.plot(kz[kx], al[ky], 'rx', ms=3, mew=0.8)
        n_ok = int(np.sum(~np.isnan(gs)) - suspect.sum())
        ax.set_title(f'V₀={v0}   ({n_ok} clean + {suspect.sum()} suspect pts)')
        ax.set_xlabel(r'$k_z$ (physical)')
        ax.set_facecolor('#e8e8e8')
    axes[0].set_ylabel(r'$\alpha$')
    cb = fig.colorbar(im, ax=axes, fraction=0.012, pad=0.01)
    cb.set_label(r'$\gamma_{\rm sim}$ (TU$^{-1}$)')
    fig.suptitle('Measured growth-rate maps γ_sim(α, kz) from the raw sweep tables — gray = not yet run, '
                 'red × = suspect fit (γ_sim > 2·γ_WKB or > 0.6 TU⁻¹: parasitic/nonlinear, needs curation)', y=1.02)
    fig.savefig(os.path.join(OUT, 'fig06_sweep_coverage_heatmaps.png'), dpi=130,
                bbox_inches='tight')
    plt.close(fig)


# ────────────────────────────────────────────────────────────────────────────
# fig07 — gamma_sim vs gamma_WKB scatter + ratio histogram
# ────────────────────────────────────────────────────────────────────────────
def fig07():
    files = [('v0p01', 0.01), ('v0p03', 0.03), ('v0p05', 0.05),
             ('v0p1', 0.10), ('v0p2', 0.20)]
    colors = {0.01: '#999999', 0.03: '#d62728', 0.05: '#1f77b4',
              0.10: '#2ca02c', 0.20: '#9467bd'}
    fig, axes = plt.subplots(1, 2, figsize=(12.5, 5))
    ratios_all = []
    for f, v0 in files:
        d = dict(np.load(os.path.join(SWEEP, f + '.npz')))
        gs, gw = d['gamma_sim'].ravel(), d['gamma_wkb'].ravel()
        m = (~np.isnan(gs)) & (gw > 0) & (gs < 2.0 * gw) & (gs < 0.6)
        axes[0].plot(gw[m], gs[m], '.', ms=3, alpha=0.5, color=colors[v0], label=f'V₀={v0}')
        ratios_all.append(gs[m] / gw[m])
    xx = np.logspace(-2.3, 0.6, 10)
    axes[0].plot(xx, xx, 'k-', lw=1, label='sim = WKB')
    axes[0].plot(xx, 0.5 * xx, 'k--', lw=1, label='sim = 0.5·WKB')
    axes[0].plot(xx, 0.1 * xx, 'k:', lw=1, label='sim = 0.1·WKB')
    axes[0].set_xscale('log'); axes[0].set_yscale('log')
    axes[0].set_xlabel(r'$\gamma_{\rm WKB}$ (eq. 33 quartic, max over n)')
    axes[0].set_ylabel(r'$\gamma_{\rm sim}$')
    axes[0].legend(fontsize=8); axes[0].grid(alpha=0.3)
    axes[0].set_title('Simulation vs analytic WKB across the whole sweep\n(suspect fits excluded)')

    r = np.concatenate(ratios_all)
    axes[1].hist(r, bins=60, range=(0, 1.5), color='steelblue', edgecolor='k', lw=0.3)
    axes[1].axvline(np.median(r), color='r', ls='--', label=f'median = {np.median(r):.2f}')
    axes[1].set_xlabel(r'$\gamma_{\rm sim}/\gamma_{\rm WKB}$'); axes[1].set_ylabel('# grid points')
    axes[1].legend(); axes[1].grid(alpha=0.3)
    axes[1].set_title('WKB systematically overestimates —\nthe quantitative statement of the "WKB gap"')
    fig.tight_layout()
    fig.savefig(os.path.join(OUT, 'fig07_sim_vs_wkb.png'), dpi=140)
    plt.close(fig)


# ────────────────────────────────────────────────────────────────────────────
# fig12 — the sub-kz=1 contamination floor (open-issue evidence)
# ────────────────────────────────────────────────────────────────────────────
def fig12():
    files = [('v0p03', 0.03), ('v0p05', 0.05), ('v0p1', 0.10)]
    fig, axes = plt.subplots(1, 3, figsize=(15, 4.4), sharey=True)
    for ax, (f, v0) in zip(axes, files):
        d = dict(np.load(os.path.join(SWEEP, f + '.npz')))
        kz, al = d['kz_vals'], d['alpha_vals']
        mkz = kz <= 3.01
        for a, c in [(1.0, '#1f77b4'), (2.0, '#2ca02c'), (3.0, '#d62728')]:
            ia = np.argmin(np.abs(al - a))
            gs = d['gamma_sim'][ia][mkz]
            m = ~np.isnan(gs)
            ax.plot(kz[mkz][m], gs[m], 'o-', ms=4, lw=1, color=c, label=f'α={a}')
        ax.axhline(0.097 if v0 <= 0.05 else 0.14, color='k', ls=':', lw=1)
        ax.set_yscale('log'); ax.set_xlabel(r'$k_z$ (physical)')
        ax.set_title(f'V₀={v0}')
        ax.grid(alpha=0.3)
    axes[0].set_ylabel(r'$\gamma_{\rm sim}$ (TU$^{-1}$, log)')
    axes[0].legend(fontsize=9)
    fig.suptitle('OPEN ISSUE — raw sweep-table values at kz<3: a flat, α- and V₀-insensitive floor γ≈0.10 '
                 '(dotted) below kz≈1 plus parasitic spikes at half-integer kz. '
                 'These fine-kz points need curated re-analysis before any sub-kz=1 physics claim.', y=1.04, fontsize=10)
    fig.savefig(os.path.join(OUT, 'fig12_subkz1_contamination.png'), dpi=140, bbox_inches='tight')
    plt.close(fig)


if __name__ == '__main__':
    fig01(); fig05(); fig06(); fig07(); fig12()
    print('wrote figures to', OUT)
