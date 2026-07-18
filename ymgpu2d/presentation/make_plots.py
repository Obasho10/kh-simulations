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
EIGCACHE = os.path.join(os.path.dirname(__file__), 'eigensolver_grid_cache.npz')
os.makedirs(OUT, exist_ok=True)

# WKB-ratio suspect criterion (fig06/fig07/fig15) — a ratio-only cutoff
# (gamma_sim > 2*gamma_wkb) over-flags low-alpha points: gamma_wkb is tiny
# there (alpha<0.5 pushes kz_peak below 1, off the integer-kz grid this
# criterion scans), so an O(0.03-0.08) absolute floor -- present even in
# well-behaved runs (median repeat-run std ~0.001, 90th pct ~0.025 across
# batch_results.csv) -- inflates the ratio without representing a real
# mismatch. ABS_FLOOR requires the absolute gap to also be non-negligible
# before flagging; picked as ~90th-percentile repeat-run noise, well below
# the ~0.1-0.3 TU^-1 scale of real peak growth rates.
ABS_FLOOR = 0.03


def is_suspect(gamma_sim, gamma_wkb, abs_hi=0.6):
    """WKB-ratio suspect test used by fig06/fig07/fig15 (a loose, cheap
    screen -- see fig03/fig04/fig13/fig14 for the sponge-matched exact-
    eigensolver comparison, a separate and stricter methodology not covered
    by this fix). Flags gamma_sim > abs_hi outright (blown-up/nonlinear
    regardless of WKB), otherwise requires BOTH a >2x relative excess over
    gamma_wkb AND an absolute excess above ABS_FLOOR."""
    with np.errstate(divide='ignore', invalid='ignore'):
        gap = gamma_sim - gamma_wkb
        return (gamma_sim > abs_hi) | ((gamma_sim > 2.0 * gamma_wkb) & (gap > ABS_FLOOR))


# ────────────────────────────────────────────────────────────────────────────
# fig03 / fig04 shared helpers — fine-kz exact-eigensolver curves (from
# compute_eigensolver_grid.py's cache) + sweep-table gamma_sim scatter.
# ────────────────────────────────────────────────────────────────────────────
def _eig_series(alpha, V0):
    """Return (kz_vals, gamma) for one (alpha, V0) series from the cache."""
    d = dict(np.load(EIGCACHE))
    series = d['series']
    idx = [i for i, s in enumerate(series)
           if abs(s[0] - alpha) < 1e-6 and abs(s[1] - V0) < 1e-6]
    if not idx:
        raise KeyError(f'no cached eigensolver series for alpha={alpha}, V0={V0}')
    return d['kz_vals'], d['gamma'][idx[0]]


def _sim_scatter(v0_file, alpha, kz_fine, gamma_fine):
    """Return (kz, gamma_sim, clean_mask, suspect_mask) from a sweep table,
    or None if the table's alpha grid doesn't reach this alpha.

    clean/suspect is judged against the EXACT eigensolver curve (interpolated
    onto the sweep table's kz grid), not the closed-form WKB quartic that the
    sweep table's own gamma_wkb column stores. That quartic is a loose upper
    bound (PRESENTATION.md §5.4: off by up to 2x in its best regime) and lets
    badly-mismatched points (wrong sponge, wrong eigenbranch) through — e.g.
    alpha=2.5, V0=0.05, kz=1 has a recorded gamma_sim=0.44 against an exact
    eigenvalue of ~0.08, a 5x miss that the WKB-ratio filter never caught.
    """
    d = dict(np.load(os.path.join(SWEEP, v0_file + '.npz')))
    kz, al = d['kz_vals'], d['alpha_vals']
    ia = np.argmin(np.abs(al - alpha))
    if abs(al[ia] - alpha) > 0.05:
        return None
    gs = d['gamma_sim'][ia]
    theory = np.interp(kz, kz_fine, gamma_fine)
    with np.errstate(divide='ignore', invalid='ignore'):
        ratio = gs / theory
        suspect = (~np.isnan(gs)) & ((ratio > 2.0) | (ratio < 0.4))
    clean = (~np.isnan(gs)) & (~suspect)
    return kz, gs, clean, suspect


def _plot_series(ax, alpha, V0, v0_file, color, label_prefix=''):
    kz_fine, gamma = _eig_series(alpha, V0)
    ax.plot(kz_fine, gamma, '-', lw=1.8, color=color,
            label=f'{label_prefix}α={alpha:g} (exact eigensolver)')
    res = _sim_scatter(v0_file, alpha, kz_fine, gamma)
    if res is not None:
        kzS, gs, clean, suspect = res
        ax.plot(kzS[clean], gs[clean], 'o', ms=5, color=color,
                mec='k', mew=0.4, zorder=5)
        ax.plot(kzS[suspect], gs[suspect], 'x', ms=5, color=color,
                alpha=0.65, zorder=4)


def _mark_subkz1_caveat(ax, ymax):
    ax.axvspan(0, 1.0, color='gray', alpha=0.12, zorder=0)
    ax.text(0.5, ymax * 0.97,
            'kz<1: preliminary branch\nstructure — not yet\ncross-validated\n(PRESENTATION.md §5.3)',
            fontsize=7.5, color='dimgray', ha='center', va='top', style='italic')


def _sim_legend_handles():
    from matplotlib.lines import Line2D
    return [
        Line2D([0], [0], color='k', lw=1.8, label='exact eigensolver (fine kz grid)'),
        Line2D([0], [0], color='k', lw=0, marker='o', ms=6, mec='k',
               label='γ_sim, within 0.4-2x of exact eigensolver'),
        Line2D([0], [0], color='k', lw=0, marker='x', ms=6, alpha=0.65,
               label='γ_sim, suspect (>2x or <0.4x exact)'),
    ]


# ────────────────────────────────────────────────────────────────────────────
# fig03 — V0=0.05 validation stack: exact eigensolver at fine kz (step 0.125,
#         starting at kz=0.125) vs measured gamma_sim (sweep/v0p05.npz)
# ────────────────────────────────────────────────────────────────────────────
def fig03():
    alphas = [1.0, 1.5, 2.0, 2.5, 3.0]
    cmap = plt.get_cmap('viridis')
    colors = {a: cmap(i / (len(alphas) - 1)) for i, a in enumerate(alphas)}

    fig, ax = plt.subplots(figsize=(10, 6.5))
    _mark_subkz1_caveat(ax, 0.34)
    for a in alphas:
        _plot_series(ax, a, 0.05, 'v0p05', colors[a])

    ax.set_xlabel(r'$k_z$ (physical)'); ax.set_ylabel(r'$\gamma$ (TU$^{-1}$)')
    ax.set_xlim(0, 10); ax.set_ylim(0, 0.34)
    ax.set_title('V₀=0.05 validation stack — exact eigensolver (fine kz grid, Δkz=0.125)\n'
                 'vs measured γ_sim (sweep/v0p05.npz; suspect = >2x or <0.4x the exact eigensolver,\n'
                 'not the old WKB-quartic filter — see chat notes). Fine-scale theory-line texture is a\n'
                 'real branch-crossing artifact of "largest-real-part" eigenvalue selection, not smoothed.',
                 fontsize=10)
    alpha_handles = [plt.Line2D([0], [0], color=colors[a], lw=2, label=f'α={a:g}')
                     for a in alphas]
    leg1 = ax.legend(handles=alpha_handles, fontsize=9, loc='upper right', title='coupling')
    ax.add_artist(leg1)
    ax.legend(handles=_sim_legend_handles(), fontsize=8, loc='lower right')
    ax.grid(alpha=0.3)
    fig.tight_layout()
    fig.savefig(os.path.join(OUT, 'fig03_validation_stack_v005.png'), dpi=140)
    plt.close(fig)


# ────────────────────────────────────────────────────────────────────────────
# fig04 — headline dispersion, V0=0.05 and V0=0.03, exact eigensolver at fine
#         kz vs measured gamma_sim (sweep tables)
# ────────────────────────────────────────────────────────────────────────────
def fig04():
    alphas_05 = [1.5, 2.0, 2.5, 3.0]
    alphas_03 = [3.0, 4.0, 5.0]
    colors_05 = ['#2166ac', '#4393c3', '#74add1', '#abd9e9']
    colors_03 = ['#d73027', '#f46d43', '#fdae61']

    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(15, 6.5))

    _mark_subkz1_caveat(ax1, 0.34)
    for a, c in zip(alphas_05, colors_05):
        _plot_series(ax1, a, 0.05, 'v0p05', c)
    ax1.set_xlabel(r'$k_z$ (physical)'); ax1.set_ylabel(r'$\gamma$ (TU$^{-1}$)')
    ax1.set_xlim(0, 10); ax1.set_ylim(0, 0.34)
    ax1.set_title('V₀ = 0.05,  EPS = 0.15')
    ax1.legend(handles=[plt.Line2D([0], [0], color=c, lw=2, label=f'α={a:g}')
                        for a, c in zip(alphas_05, colors_05)],
              fontsize=9, loc='upper right')
    ax1.grid(alpha=0.3)

    _mark_subkz1_caveat(ax2, 0.17)
    for a, c in zip(alphas_03, colors_03):
        _plot_series(ax2, a, 0.03, 'v0p03', c)
    ax2.set_xlabel(r'$k_z$ (physical)'); ax2.set_ylabel(r'$\gamma$ (TU$^{-1}$)')
    ax2.set_xlim(0, 10); ax2.set_ylim(0, 0.17)
    ax2.set_title('V₀ = 0.03,  EPS = 0.15\n(sweep table alpha grid tops out at 3.0 — '
                  'no γ_sim scatter for α=4,5)', fontsize=10.5)
    ax2.legend(handles=[plt.Line2D([0], [0], color=c, lw=2, label=f'α={a:g}')
                        for a, c in zip(alphas_03, colors_03)],
              fontsize=9, loc='upper right')
    ax2.grid(alpha=0.3)

    fig.legend(handles=_sim_legend_handles(), fontsize=9, loc='lower center',
              ncol=3, bbox_to_anchor=(0.5, -0.02))
    fig.suptitle('SU(2) Yang-Mills KH Dispersion — Mode 6 (NAB_CIRC_AZ2)\n'
                'exact eigensolver (fine kz grid, Δkz=0.125) vs measured γ_sim\n'
                '(suspect = >2x/<0.4x the exact eigensolver; theory-line texture is a real branch-crossing\n'
                'artifact of fine-resolution eigenvalue selection, not noise)',
                fontsize=12, fontweight='bold', y=1.06)
    fig.tight_layout(rect=[0, 0.04, 1, 1])
    fig.savefig(os.path.join(OUT, 'fig04_dispersion_v005_v003.png'), dpi=140,
               bbox_inches='tight')
    plt.close(fig)

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
        suspect = (~np.isnan(gs)) & is_suspect(gs, gw)
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
    fig.suptitle(f'Measured growth-rate maps γ_sim(α, kz) from the raw sweep tables — gray = not yet run, '
                 f'red × = suspect fit (γ_sim > 0.6 TU⁻¹, or >2·γ_WKB AND >{ABS_FLOOR:g} above it — '
                 f'parasitic/nonlinear, needs curation)', y=1.02)
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
        m = (~np.isnan(gs)) & (gw > 0) & ~is_suspect(gs, gw)
        axes[0].plot(gw[m], gs[m], '.', ms=3, alpha=0.5, color=colors[v0], label=f'V₀={v0}')
        ratios_all.append(gs[m] / gw[m])
    xx = np.logspace(-2.3, 0.6, 10)
    axes[0].plot(xx, xx, 'k-', lw=1, label='sim = WKB')
    axes[0].plot(xx, 0.5 * xx, 'k--', lw=1, label='sim = 0.5·WKB')
    axes[0].plot(xx, 0.1 * xx, 'k:', lw=1, label='sim = 0.1·WKB')
    axes[0].set_xscale('log'); axes[0].set_yscale('log')
    axes[0].set_xlabel(r'$\gamma_{\rm WKB}$ (eq. 33 quartic, n=0 fundamental mode)')
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


# ────────────────────────────────────────────────────────────────────────────
# fig11 — C25 growth curves done honestly: log-amplitude + LOCAL SLOPE.
#          The amplitude curves are NOT single exponentials: seed-dominated
#          slow start → plateau → post-kink decline. The plateau (not any
#          best-R² window) is the defensible γ measurement.
# ────────────────────────────────────────────────────────────────────────────
def fig11():
    import glob
    RD = os.path.join(os.path.dirname(__file__), '..', 'remote_data', 't136')
    exact = {1: 0.0897, 2: 0.1220, 3: 0.0933, 4: 0.0819, 5: 0.0667, 6: 0.0607}
    rep = {1: 0.0889, 2: 0.1211, 3: 0.0927, 4: 0.0810, 5: 0.0643, 6: 0.0566}
    cmap = plt.get_cmap('viridis')
    fig, axes = plt.subplots(1, 2, figsize=(13.5, 5))
    for k in range(1, 7):
        fs = glob.glob(os.path.join(
            RD, f'ym_k{k}_a1.000_circ_az2seed_v0.0500_sp20.0*', f'timeseries_k{k}.csv'))
        if not fs:
            continue
        d = np.loadtxt(fs[0], delimiter=',', skiprows=1)
        t, a = d[:, 0], d[:, 1]
        la = np.log(a)
        g = np.convolve(np.gradient(la, t), np.ones(5) / 5, mode='same')
        c = cmap((k - 1) / 5)
        axes[0].semilogy(t, a, color=c, lw=1.5, label=f'kz={k}')
        axes[1].plot(t[3:-3], g[3:-3], color=c, lw=1.5)
        axes[1].axhline(exact[k], color=c, ls=':', lw=1)
    axes[0].set_xlabel('t (TU)'); axes[0].set_ylabel('|Az_circ| amplitude (log)')
    axes[0].set_title('C25 (α=1, V₀=0.05) amplitude curves —\nNOT single exponentials: '
                      'seed transient → plateau → late kink')
    axes[0].legend(fontsize=8); axes[0].grid(alpha=0.3)
    axes[1].set_xlabel('t (TU)')
    axes[1].set_ylabel(r'local slope  $d\ln A/dt$  (TU$^{-1}$)')
    axes[1].set_title('Local growth rate vs time — the mid-run PLATEAU is the\n'
                      'measurement; dotted lines = 1D eigensolver γ_exact')
    axes[1].set_ylim(0, 0.16); axes[1].grid(alpha=0.3)
    axes[1].annotate('seed-dominated\ntransient', xy=(8, 0.045), fontsize=8, color='dimgray')
    axes[1].annotate('plateau ≈ γ_exact (kz=1..5)', xy=(38, 0.135), fontsize=8, color='dimgray')
    axes[1].annotate('late decline\n(kink in log plot)', xy=(59, 0.02), fontsize=8, color='dimgray')
    fig.suptitle('Growth-rate extraction, honestly: the plateau in the local slope is the measurement — '
                 'max-R² window fits can land on regime transitions; kz=6 (yellow) has no plateau.',
                 fontsize=10)
    fig.tight_layout(rect=[0, 0, 1, 0.92])
    fig.savefig(os.path.join(OUT, 'fig11_growth_curves_C25.png'), dpi=140)
    plt.close(fig)


# ────────────────────────────────────────────────────────────────────────────
# fig13 — relative-error scatter: (gamma_sim - gamma_exact)/gamma_exact per V0,
#          same (alpha, kz) axes as fig06 but sparse scatter instead of a dense
#          heatmap, sourced from batch_best.csv (the per-run best-fit table,
#          which records each run's ACTUAL xi_sponge).
#
#          gamma_exact is recomputed here (not read from batch_best.csv's own
#          gamma_exact column, which can itself be a spurious/wrong-branch
#          eigenvalue -- see chat notes) using each row's own recorded
#          xi_sponge with the localised-mode filter -- the same method
#          verified to reproduce every published curated value to 0.0% error
#          for fig03/fig04. A full-grid (formula-sponge) version of this
#          figure was attempted and abandoned: it produced median >100%
#          "errors" that were actually wrong-eigenbranch picks, not real
#          sim/theory mismatch (no automated rule -- formula sponge, sponge
#          convergence scan, or continuation tracking -- could reliably
#          separate the true shear-localised branch from sponge-boundary
#          artifact branches at an arbitrary grid point). This sparse,
#          per-run-sponge-matched version is the only trustworthy one.
# ────────────────────────────────────────────────────────────────────────────
def fig13():
    import sys as _sys
    _sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'analysis'))
    import ym_eigenmode as _E

    csv_path = os.path.join(os.path.dirname(__file__), '..', 'batch_best.csv')
    df = __import__('pandas').read_csv(csv_path)

    def exact_gamma(kz, alpha, V0, sp, EPS=0.15, NX=384):
        try:
            ev, evec = _E.solve_eigenmode(kz, alpha, V0, EPS, NX, xi_sponge=sp)
        except Exception:
            return np.nan
        if ev is None:
            return np.nan
        for j, v in enumerate(ev):
            if v.real > 1e-5 and _E.is_localised(evec[:, j], NX, EPS, xi_inner=sp):
                return v.real
        return np.nan

    ge = np.array([exact_gamma(float(r.kz), float(r.alpha), float(r.V0), float(r.xi_sponge))
                   for r in df.itertuples()])
    with np.errstate(divide='ignore', invalid='ignore'):
        relerr = (df['gamma_sim'].values - ge) / ge

    v0_list = sorted(df['V0'].unique())
    fig, axes = plt.subplots(1, len(v0_list), figsize=(4.2 * len(v0_list), 4.6), sharey=True)
    if len(v0_list) == 1:
        axes = [axes]
    sc = None
    for ax, v0 in zip(axes, v0_list):
        m = np.isclose(df['V0'].values, v0)
        sc = ax.scatter(df['kz'].values[m], df['alpha'].values[m], c=relerr[m],
                        cmap='RdBu_r', vmin=-0.5, vmax=0.5, s=90, edgecolors='k',
                        linewidths=0.5, zorder=5)
        ax.set_title(f'V₀={v0:g}   ({m.sum()} pts)')
        ax.set_xlabel(r'$k_z$ (physical)')
        ax.set_xlim(0, 10); ax.grid(alpha=0.3)
        ax.set_facecolor('#f5f5f5')
    axes[0].set_ylabel(r'$\alpha$')
    cb = fig.colorbar(sc, ax=axes, fraction=0.02, pad=0.01, extend='both')
    cb.set_label(r'$(\gamma_{\rm sim}-\gamma_{\rm exact})/\gamma_{\rm exact}$')
    n_bad = int(np.sum(np.abs(relerr) > 0.5))
    fig.suptitle(f'Relative error vs the exact eigensolver — sparse, sponge-matched (batch_best.csv, '
                f'{len(df)} runs, each\nusing its own recorded xi_sponge; {n_bad} pts saturate the '
                f'±50% color scale, mostly kz=1). Median error {100*np.nanmedian(relerr):+.1f}%.', y=1.04)
    fig.savefig(os.path.join(OUT, 'fig13_relative_error_scatter.png'), dpi=140,
               bbox_inches='tight')
    plt.close(fig)


# ────────────────────────────────────────────────────────────────────────────
# fig14 — integer-kz-only relative error, FULL alpha grid, using the
#          interpolated-real-sponge exact eigensolver (integer_kz_grid_cache.npz
#          from compute_integer_kz_grid.py) rather than the blind per-kz
#          formula that failed for fig13's full-grid attempt.
#
#          At every alpha grid point, the sponge is interpolated from the real
#          sponges recorded in batch_best.csv for that V0 (a smooth function
#          of alpha), not guessed from a formula -- this is what makes the
#          full alpha grid tractable at integer kz where the blind formula
#          wasn't. Points falling outside the batch_best.csv anchor range in
#          alpha are extrapolated flat (held at the nearest anchor's sponge)
#          and marked with a lighter edge.
# ────────────────────────────────────────────────────────────────────────────
def fig14():
    ICACHE = os.path.join(os.path.dirname(__file__), 'integer_kz_grid_cache.npz')
    ic = dict(np.load(ICACHE))
    files = [('v0p03', 0.03), ('v0p05', 0.05), ('v0p1', 0.10), ('v0p2', 0.20)]
    fig, axes = plt.subplots(1, 4, figsize=(18, 4.6), sharey=True)
    sc = None
    for ax, (f, v0) in zip(axes, files):
        d = dict(np.load(os.path.join(SWEEP, f + '.npz')))
        gs, ge = d['gamma_sim'], ic[f'gamma_exact_{f}']
        kz, al = d['kz_vals'], d['alpha_vals']
        amin, amax = ic[f'extrap_range_{f}']
        with np.errstate(divide='ignore', invalid='ignore'):
            ratio = gs / ge
            relerr = (gs - ge) / ge
            suspect = (~np.isnan(gs)) & (~np.isnan(ge)) & ((ratio > 2.0) | (ratio < 0.4))
        clean = (~np.isnan(gs)) & (~np.isnan(ge)) & (~suspect)
        iA, iK = np.meshgrid(np.arange(len(al)), np.arange(len(kz)), indexing='ij')
        for mask, marker, alpha_mk in [(clean, 'o', 1.0), (suspect, 'x', 0.5)]:
            m = mask
            if not m.any():
                continue
            extrap = (al[iA][m] < amin) | (al[iA][m] > amax)
            sc = ax.scatter(kz[iK][m], al[iA][m], c=relerr[m], cmap='RdBu_r',
                            vmin=-0.5, vmax=0.5, s=[28 if e else 55 for e in extrap],
                            marker=marker, alpha=alpha_mk,
                            edgecolors=['gray' if e else 'k' for e in extrap],
                            linewidths=0.5, zorder=5)
        n_clean, n_susp = int(clean.sum()), int(suspect.sum())
        ax.set_title(f'V₀={v0:g}   ({n_clean} clean, {n_susp} suspect)\n'
                     f'sponge anchors α∈[{amin:g},{amax:g}]', fontsize=10.5)
        ax.set_xlabel(r'$k_z$ (integer)')
        ax.set_xlim(0, 10); ax.grid(alpha=0.3)
        ax.set_facecolor('#f5f5f5')
    axes[0].set_ylabel(r'$\alpha$')
    cb = fig.colorbar(sc, ax=axes, fraction=0.015, pad=0.01, extend='both')
    cb.set_label(r'$(\gamma_{\rm sim}-\gamma_{\rm exact})/\gamma_{\rm exact}$')
    fig.suptitle('Integer-kz relative error, full α grid — exact eigensolver at each α uses a sponge\n'
                'INTERPOLATED from real batch_best.csv values (not the blind formula, which failed at scale).\n'
                'o = clean (γ_sim within 0.4-2x theory), × = suspect; faint gray edge = α outside the anchor '
                'range (extrapolated sponge). Suspect clusters mark contaminated sweep-table γ_sim, not '
                'theory failures — cross-checked directly against γ_sim at the validated anchors.', y=1.10,
                fontsize=10.5)
    fig.savefig(os.path.join(OUT, 'fig14_integer_kz_relative_error.png'), dpi=140,
               bbox_inches='tight')
    plt.close(fig)


# ────────────────────────────────────────────────────────────────────────────
# fig15 — where does sim match WKB to <10%? (alpha, kz) location per V0,
#          using the corrected (n=0) gamma_wkb / rel_error now in sweep/*.npz.
# ────────────────────────────────────────────────────────────────────────────
def fig15():
    files = [('v0p01', 0.01), ('v0p03', 0.03), ('v0p05', 0.05),
             ('v0p1', 0.10), ('v0p2', 0.20)]
    fig, axes = plt.subplots(1, 5, figsize=(22, 4.6), sharey=True)
    aa = np.linspace(0.1, 3.0, 50)
    for ax, (f, v0) in zip(axes, files):
        d = dict(np.load(os.path.join(SWEEP, f + '.npz')))
        gs, gw, re = d['gamma_sim'], d['gamma_wkb'], d['rel_error']
        kz, al = d['kz_vals'], d['alpha_vals']
        suspect = (~np.isnan(gs)) & is_suspect(gs, gw)
        valid = (~np.isnan(re)) & (~suspect)
        good = valid & (re < 0.10)
        iA, iK = np.meshgrid(np.arange(len(al)), np.arange(len(kz)), indexing='ij')
        ax.scatter(kz[iK][valid & ~good], al[iA][valid & ~good], s=8, c='#cfcfcf',
                  zorder=2, label='≥10% off')
        sc = ax.scatter(kz[iK][good], al[iA][good], s=40, c=re[good], cmap='viridis_r',
                        vmin=0, vmax=0.10, edgecolors='k', linewidths=0.4, zorder=5,
                        label='<10% off')
        ax.plot(2 * aa, aa, 'r--', lw=1.2, alpha=0.7, label=r'$k_{z,\rm peak}=2\alpha$ (fig05)')
        n_good = int(good.sum())
        ax.set_title(f'V₀={v0:g}   ({n_good} pts <10%)')
        ax.set_xlabel(r'$k_z$ (physical)')
        ax.set_xlim(0, 10); ax.set_ylim(0, 3.1); ax.grid(alpha=0.3)
        ax.set_facecolor('#f5f5f5')
    axes[0].set_ylabel(r'$\alpha$')
    axes[0].legend(fontsize=8, loc='upper left')
    cb = fig.colorbar(sc, ax=axes, fraction=0.012, pad=0.01, extend='max')
    cb.set_label(r'$|\gamma_{\rm sim}-\gamma_{\rm WKB}|/\gamma_{\rm WKB}$ (points <10% only)')
    fig.suptitle('Where simulation matches the (corrected, n=0) WKB quartic to <10% — clusters along the\n'
                 'kz_peak(α) dispersion ridge (fig05), not uniformly across the grid. Gray = valid but ≥10% '
                 'off; suspect/contaminated fits excluded entirely.', y=1.04)
    fig.savefig(os.path.join(OUT, 'fig15_wkb_match_location.png'), dpi=140,
               bbox_inches='tight')
    plt.close(fig)


if __name__ == '__main__':
    fig01(); fig03(); fig04(); fig05(); fig06(); fig07(); fig11(); fig12(); fig13(); fig14(); fig15()
    print('wrote figures to', OUT)
