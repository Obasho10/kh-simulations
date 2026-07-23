#!/usr/bin/env python3
"""Generate the data-driven figures for results.tex from the real campaign
tables in sweep/ (not re-derived theory curves — actual measured GPU points).

Run from anywhere:  python3 ymgpu2d/derivations/make_results_figs.py
Figures land in ymgpu2d/derivations/figs_results/*.pdf (vector).
"""
import os, sys
import numpy as np
import pandas as pd

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..'))
sys.path.insert(0, os.path.join(ROOT, 'analysis'))
SWEEP = os.path.join(ROOT, 'sweep')
FIGS = os.path.join(HERE, 'figs_results')
os.makedirs(FIGS, exist_ok=True)

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

import exact_action_wkb as X
import chase_theory_worker as CTW
from multiprocessing import Pool
from scipy.signal import medfilt

C = dict(blue='#2a78d6', aqua='#1baf7a', yellow='#eda100', green='#008300',
         violet='#4a3aa7', red='#e34948', ink='#0b0b0b', ink2='#52514e',
         grid='#d9d8d4', magenta='#e87ba4', orange='#eb6834')
CAT = [C['blue'], C['aqua'], C['yellow'], C['violet'], C['red'], C['magenta'], C['orange']]
plt.rcParams.update({
    'font.size': 9, 'axes.labelsize': 9.5, 'axes.titlesize': 10,
    'axes.edgecolor': C['ink2'], 'axes.linewidth': 0.8,
    'axes.spines.top': False, 'axes.spines.right': False,
    'axes.grid': True, 'grid.color': C['grid'], 'grid.linewidth': 0.6,
    'grid.alpha': 0.6, 'lines.linewidth': 1.8,
    'xtick.color': C['ink2'], 'ytick.color': C['ink2'],
    'text.color': C['ink'], 'axes.labelcolor': C['ink'],
    'legend.frameon': False, 'legend.fontsize': 8,
    'figure.dpi': 110, 'savefig.bbox': 'tight',
})


def save(fig, name):
    p = os.path.join(FIGS, name)
    fig.savefig(p)
    plt.close(fig)
    print('wrote', p)


# =============================================================================
# fig_r_dispersion: measured gamma(kz) at several alpha, V0=0.05, from the
# final intkz map (recorr_results.csv), plateau-confirmed best row per point.
# =============================================================================
def load_intkz():
    df = pd.read_csv(os.path.join(SWEEP, 'recorr_results.csv'))
    df = df[(df['kz'] >= 1) & (df['kz'] <= 9) & (df['alpha'] > 0.3)]
    # quality gate matching this project's own convention (PRESENTATION.md
    # fig06): points whose ratio to the chased-eigensolver reference is
    # grossly off (>3x or <0.3x) are a different phenomenon (usually the
    # outer tachyonic branch overtaking at low kz/high alpha*V0, or a
    # cavitation-corrupted fit), not the shear-branch measurement.
    df = df[(df['ratio'] > 0.3) & (df['ratio'] < 3.0)]
    # best row per (alpha, V0, kz): prefer plateau, then highest r2
    df = df.sort_values(['has_plateau', 'r2'], ascending=[False, False])
    df = df.drop_duplicates(subset=['alpha', 'V0', 'kz'], keep='first')
    return df


THEORY_CACHE = os.path.join(SWEEP, 'theory_curve_cache.csv')
THEORY_COLS = ['alpha', 'V0', 'xi_sponge', 'EPS', 'NX', 'kz', 'gamma']


def _load_theory_cache():
    if os.path.exists(THEORY_CACHE):
        return pd.read_csv(THEORY_CACHE)
    return pd.DataFrame(columns=THEORY_COLS)


def _solve_theory_point(args):
    kz, alpha, V0, EPS, NX, xi_sponge = args
    g = CTW.gamma_true_sponge(kz, alpha, V0, EPS, NX, xi_sponge)
    return alpha, V0, xi_sponge, EPS, NX, kz, (g if g is not None else np.nan)


def theory_curve(alpha, V0, xi_sponge, kz_grid, EPS=0.15, NX=384, nproc=8):
    """Continuous gamma(kz) from the sigma-chased 6-field eigensolver -- the
    same solver (chase_theory_worker.gamma_true_sponge) used to produce the
    'gamma_chased' reference column in recorr_results.csv, evaluated on a
    fine kz grid instead of only at the simulated points. Cached to disk
    since each point takes ~0.3s."""
    cache = _load_theory_cache()
    sel = (np.isclose(cache['alpha'], alpha) & np.isclose(cache['V0'], V0)
           & np.isclose(cache['xi_sponge'], xi_sponge) & np.isclose(cache['EPS'], EPS)
           & (cache['NX'] == NX)) if len(cache) else pd.Series([], dtype=bool)
    have_kz = set(np.round(cache.loc[sel, 'kz'].values, 6)) if len(cache) else set()
    todo = [float(kz) for kz in kz_grid if round(float(kz), 6) not in have_kz]
    if todo:
        args = [(kz, alpha, V0, EPS, NX, xi_sponge) for kz in todo]
        with Pool(min(nproc, len(args))) as pool:
            rows = pool.map(_solve_theory_point, args)
        cache = pd.concat([cache, pd.DataFrame(rows, columns=THEORY_COLS)],
                           ignore_index=True)
        cache.to_csv(THEORY_CACHE, index=False)
    sel = (np.isclose(cache['alpha'], alpha) & np.isclose(cache['V0'], V0)
           & np.isclose(cache['xi_sponge'], xi_sponge) & np.isclose(cache['EPS'], EPS)
           & (cache['NX'] == NX) & cache['kz'].round(6).isin(np.round(kz_grid, 6)))
    sub = cache[sel].sort_values('kz')
    return sub['kz'].values, sub['gamma'].values


def _plot_sim_and_theory(ax, sub, col, label, xi_sponge, EPS=0.15, NX=384):
    alpha, V0 = sub['alpha'].iloc[0], sub['V0'].iloc[0]
    # kz >= 1 only: below that the sigma-chaser locks onto the tachyonic
    # outer branch (see "Two branches emerge..." slide), not the shear
    # branch this plot is about, and it would show as a spurious spike.
    kz_grid = np.arange(1.0, 9.51, 0.25)
    kzt, gt = theory_curve(alpha, V0, xi_sponge, kz_grid, EPS=EPS, NX=NX)
    # Occasionally the chaser still locks onto that outer branch at a
    # single kz even above 1 (e.g. alpha=2,V0=0.2 at kz=1.5): the shear
    # branch is provably bounded by the ceiling (alpha*V0^2)^(1/3) (the
    # "growth-rate ceiling" slide), so drop anything above it.
    keep = gt <= X.ceiling(alpha, V0)
    kzt, gt = kzt[keep], gt[keep]
    # A branch-crossing can also leave a lower-lying shoulder that still
    # clears the ceiling; catch it as a local-smoothness violation instead
    # (the true shear branch varies slowly point-to-point on this grid).
    if len(gt) >= 5:
        med = medfilt(gt, kernel_size=5)
        keep2 = np.abs(gt - med) <= 0.15 * np.abs(med)
        kzt, gt = kzt[keep2], gt[keep2]
    ax.plot(kzt, gt, '-', color=col, lw=1.3, alpha=0.5, zorder=1)
    ax.plot(sub['kz'], sub['gamma_sim'], 'o', color=col, ms=3.5, zorder=3, label=label)


def fig_r_dispersion():
    df = load_intkz()
    d = df[np.isclose(df['V0'], 0.05)]
    fig, ax = plt.subplots(figsize=(5.6, 3.4))
    alphas = [0.4, 0.7, 0.9, 1.0, 1.5, 2.0, 3.0, 3.5]
    colors = CAT + [C['green']]
    for a, col in zip(alphas, colors):
        sub = d[np.isclose(d['alpha'], a)].sort_values('kz')
        if len(sub) < 6:
            continue
        xi_sponge = sub['xi_sponge'].mode().iloc[0]
        _plot_sim_and_theory(ax, sub, col, rf'$\alpha={a:g}$', xi_sponge)
    ax.set_xlabel(r'$k_z$'); ax.set_ylabel(r'$\gamma_{\rm sim}$ (TU$^{-1}$)')
    ax.legend(ncol=2, fontsize=7.5, loc='upper left')
    ax.set_xlim(0.5, 9.5)
    save(fig, 'fig_r_dispersion.pdf')


# =============================================================================
# fig_r_dispersion_v0: same measured map, but at fixed alpha, sweeping V0 --
# the complementary slice to fig_r_dispersion's fixed-V0-sweep-alpha.
# =============================================================================
def fig_r_dispersion_v0(alpha=1.0):
    df = load_intkz()
    d = df[np.isclose(df['alpha'], alpha)]
    fig, ax = plt.subplots(figsize=(5.2, 3.2))
    v0s = [0.03, 0.04, 0.05, 0.07, 0.08, 0.10]
    for v0, col in zip(v0s, CAT):
        sub = d[np.isclose(d['V0'], v0)].sort_values('kz')
        if len(sub) < 6:
            continue
        xi_sponge = sub['xi_sponge'].mode().iloc[0]
        _plot_sim_and_theory(ax, sub, col, rf'$V_0={v0:g}$', xi_sponge)
    ax.set_xlabel(r'$k_z$'); ax.set_ylabel(r'$\gamma_{\rm sim}$ (TU$^{-1}$)')
    ax.legend(ncol=3, fontsize=7.5, loc='upper left')
    ax.set_xlim(0.5, 9.5)
    save(fig, 'fig_r_dispersion_v0.pdf')


# =============================================================================
# fig_r_kzpeak: measured kz_peak vs alpha (from the same map), overlaid with
# the confinement-set formula evaluated at each point's own recorded xi_sponge.
# =============================================================================
def fig_r_kzpeak():
    df = load_intkz()
    fig, ax = plt.subplots(figsize=(4.8, 3.2))
    for V0, col in [(0.05, C['blue']), (0.10, C['aqua']), (0.20, C['yellow'])]:
        d = df[np.isclose(df['V0'], V0)]
        alphas = sorted(d['alpha'].unique())
        pk_a, pk_k, fm_k = [], [], []
        for a in alphas:
            sub = d[np.isclose(d['alpha'], a)].sort_values('kz')
            # require near-complete kz=1..9 coverage so a missing high-kz
            # point (removed by the ratio quality gate) cannot masquerade
            # as a low-kz "peak" by default
            if len(sub) < 8:
                continue
            i = sub['gamma_sim'].values.argmax()
            kzp = sub['kz'].values[i]
            if kzp == sub['kz'].values[0] or kzp == sub['kz'].values[-1]:
                continue  # boundary "peak" is a truncation artifact, not a maximum
            xiw = sub['xi_sponge'].values[i]
            pk_a.append(a); pk_k.append(kzp)
            fm_k.append(X.kz_peak_formula(a, V0, xiw, c=1.0))
        if not pk_a:
            continue
        pk_a, pk_k, fm_k = map(np.array, (pk_a, pk_k, fm_k))
        ax.plot(pk_a, pk_k, 'o', color=col, ms=5, label=rf'$V_0={V0:g}$ (measured)')
        order = np.argsort(pk_a)
        ax.plot(pk_a[order], fm_k[order], '--', color=col, lw=1.2, alpha=0.8)
    ax.plot([], [], '--', color=C['ink2'], lw=1.2, label='formula (own $\\xi_w$)')
    ax.set_xlabel(r'$\alpha$'); ax.set_ylabel(r'$k_z^{\rm peak}$ (measured)')
    ax.legend(fontsize=7.5)
    save(fig, 'fig_r_kzpeak.pdf')


# =============================================================================
# fig_r_error_by_v0: median rel_err by V0 (plateau-confirmed clean core),
# recomputed directly from recorr_results.csv.
# =============================================================================
def fig_r_error_by_v0():
    df = pd.read_csv(os.path.join(SWEEP, 'recorr_results.csv'))
    intkz_v0 = [0.03, 0.04, 0.05, 0.07, 0.08, 0.10, 0.20]
    df = df[(df['kz'] >= 1) & (df['kz'] <= 9) & (df['alpha'] > 0.3)
            & (df['has_plateau'] == True) & (df['tier'] == 'int')
            & (df['V0'].apply(lambda v: any(np.isclose(v, u) for u in intkz_v0)))]
    # Match alpha coverage across all V0 too (not just tier): campaigns for
    # different V0 swept different alpha ranges, and that composition
    # difference -- not tier mixing -- was what broke the V0=0.08/0.10 bars
    # out of an otherwise clean decreasing trend. Restricting to the alpha
    # set common to every V0 makes n (and hence the comparison) apples-to-
    # apples.
    common_alphas = None
    for v in intkz_v0:
        a = set(np.round(df[np.isclose(df['V0'], v)]['alpha'].unique(), 2))
        common_alphas = a if common_alphas is None else common_alphas & a
    df = df[df['alpha'].round(2).isin(common_alphas)]
    v0s = sorted(df['V0'].unique())
    meds, ns = [], []
    for v in v0s:
        sub = df[np.isclose(df['V0'], v)]
        meds.append(100 * sub['rel_err'].abs().median())
        ns.append(len(sub))
    fig, ax = plt.subplots(figsize=(4.6, 2.9))
    bars = ax.bar([str(v) for v in v0s], meds, color=C['blue'], width=0.6)
    for i, (b, n) in enumerate(zip(bars, ns)):
        ax.text(b.get_x() + b.get_width() / 2, b.get_height() + 0.3, f'n={n}',
                ha='center', fontsize=7.5, color=C['ink2'])
    ax.set_xlabel(r'$V_0$'); ax.set_ylabel('median rel. error (%)')
    ax.set_ylim(0, max(meds) * 1.35)
    save(fig, 'fig_r_error_by_v0.pdf')


# =============================================================================
# fig_r_tachyonic: gamma_sim vs gamma_eig (46 points) + the two sponge
# cascades, from tachyonic_fits_final.csv.
# =============================================================================
def fig_r_tachyonic():
    df = pd.read_csv(os.path.join(SWEEP, 'tachyonic_fits_final.csv'))
    df = df[df['status'] == 'OK']
    mag = df[df['group'] == 'magnitude_check']
    casc = df[df['group'] == 'cascade_anchor'] if 'cascade_anchor' in df['group'].unique() else df[df['group'].str.contains('cascade', case=False, na=False)]

    fig, (a1, a2) = plt.subplots(1, 2, figsize=(6.8, 2.9))
    lo, hi = 1e-2, 3.0
    a1.plot([lo, hi], [lo, hi], color=C['ink2'], lw=1.0, ls='--')
    a1.plot([lo, hi], [0.78 * lo, 0.78 * hi], color=C['blue'], lw=1.0, ls=':')
    a1.scatter(mag['gamma_eig'], mag['gamma_sim'], s=18, color=C['blue'], alpha=0.75,
               edgecolor='none')
    a1.set_xscale('log'); a1.set_yscale('log')
    a1.set_xlim(lo, hi); a1.set_ylim(lo, hi)
    a1.set_xlabel(r'$\gamma_{\rm eig}$ (true eigensolver)')
    a1.set_ylabel(r'$\gamma_{\rm sim}$')
    a1.text(0.02, 1.4, r'$y=x$', color=C['ink2'], fontsize=8)
    a1.text(0.02, 0.55, 'ratio$\\,{=}\\,0.78$', color=C['blue'], fontsize=8)

    for grp, col, lbl in [
        ((0.5, 0.05, 0.5), C['blue'], r'$\alpha=0.5,V_0=0.05,k_z=0.5$'),
        ((1.0, 0.05, 1.5), C['aqua'], r'$\alpha=1.0,V_0=0.05,k_z=1.5$'),
    ]:
        a_, v_, k_ = grp
        sub = df[np.isclose(df['alpha'], a_) & np.isclose(df['V0'], v_)
                 & np.isclose(df['kz'], k_)].sort_values('sp')
        if len(sub) == 0:
            continue
        a2.plot(sub['sp'], sub['gamma_sim'], 'o-', color=col, ms=4, label=lbl)
    a2.set_xlabel(r'sponge radius $\xi_{\rm sponge}$')
    a2.set_ylabel(r'$\gamma_{\rm sim}$')
    a2.legend(fontsize=6.8)
    fig.tight_layout()
    save(fig, 'fig_r_tachyonic.pdf')


# =============================================================================
# fig_r_lowalpha: gamma_hat vs P for the alpha>=0.5 EPS-scan v2 GPU points and
# the alpha in [0.2,0.4] extension, from the two fits csvs.
# =============================================================================
def fig_r_lowalpha():
    hi = pd.read_csv(os.path.join(SWEEP, 'epsscan_v2_fits_clean.csv'))
    lo = pd.read_csv(os.path.join(SWEEP, 'epsscan_lowalpha_fits.csv'))

    def phat(d, gcol, acol='alpha', vcol='V0', ecol='EPS'):
        ceil = (d[acol] * d[vcol] ** 2) ** (1 / 3.)
        P = ceil / d[ecol]
        ghat = d[gcol] / ceil
        return P, ghat

    Ph, Gh = phat(hi, 'gamma')
    Pl, Gl = phat(lo, 'gamma_sim')

    fig, ax = plt.subplots(figsize=(4.8, 3.1))
    ax.scatter(Ph, Gh, s=14, color=C['blue'], alpha=0.7, edgecolor='none',
               label=r'$\alpha\geq0.5$ (median err 9.9%)')
    ax.scatter(Pl, Gl, s=14, color=C['red'], alpha=0.7, edgecolor='none',
               marker='^', label=r'$\alpha\in[0.2,0.4]$ (median err 21.6%)')
    ax.set_xscale('log')
    ax.set_xlabel(r'$P=(\alpha V_0^2)^{1/3}/\varepsilon_s$')
    ax.set_ylabel(r'$\hat\gamma=\gamma_{\rm sim}/(\alpha V_0^2)^{1/3}$')
    ax.legend(fontsize=7.5)
    save(fig, 'fig_r_lowalpha.pdf')


if __name__ == '__main__':
    only = sys.argv[1:] or None
    for fn in [fig_r_dispersion, fig_r_dispersion_v0, fig_r_kzpeak, fig_r_error_by_v0,
               fig_r_tachyonic, fig_r_lowalpha]:
        if only and fn.__name__ not in only:
            continue
        print('==', fn.__name__)
        fn()
