#!/usr/bin/env python3
"""Phase 2 of the EPS-scan v2 plan: compare GPU-measured growth rates against
the Phase 0 theory collapse curve (analysis/eps_collapse_theory.py).

Reads sweep/epsscan_v2_fits_clean.csv (58/91 points that passed the
>=2-decades-of-growth quality gate -- the other 33, mostly alpha=6-10 at
EPS>=0.15, hit an early "late-onset instability" catastrophe whose onset
time collapses sharply with alpha, see FINDINGS.md) and sweep/eps_collapse_gridA.csv
(the wide theory-only sweep). Produces plots/eps_collapse_gpu_validation.png:
  Panel 1: gamma_hat = gamma/(alpha V0^2)^(1/3) vs P, GPU points over the
    theory curve -- the magnitude-check comparison.
  Panel 2: the two peak-refinement cascade anchors, gamma vs kz, GPU points
    over each anchor's own theory dispersion curve -- the peak-location test.
"""
import os, sys
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..'))
sys.path.insert(0, HERE)
import exact_action_wkb as X

SWEEP_DIR = os.path.join(ROOT, 'sweep')
PLOT_DIR = os.path.join(ROOT, 'plots')


def main():
    fits = pd.read_csv(os.path.join(SWEEP_DIR, 'epsscan_v2_fits_clean.csv'))
    gridA = pd.read_csv(os.path.join(SWEEP_DIR, 'eps_collapse_gridA.csv'))
    manifest = pd.read_csv(os.path.join(SWEEP_DIR, 'epsscan_v2_manifest.csv'))
    key = ['alpha', 'V0', 'EPS', 'tier', 'kz']
    for c in key:
        fits[c] = fits[c].round(4)
        manifest[c] = manifest[c].round(4)
    fits = fits.merge(manifest[key + ['kz_peak_theory', 'gamma_peak_theory']],
                      on=key, how='left')

    fits['ceiling'] = X.ceiling(fits['alpha'].values, fits['V0'].values)
    fits['P'] = fits['ceiling'] / fits['EPS']
    fits['gamma_hat_sim'] = fits['gamma'] / fits['ceiling']
    fits['gamma_hat_th'] = fits['g_th'] / fits['ceiling']

    mag = fits[fits['group'] == 'magnitude_check']
    rel_err = (fits['gamma'] - fits['g_th']).abs() / fits['g_th']
    print(f"Magnitude-check: {len(mag)} clean points, "
          f"median rel_err={rel_err[fits['group']=='magnitude_check'].median()*100:.1f}%, "
          f"90th pct={rel_err[fits['group']=='magnitude_check'].quantile(0.9)*100:.1f}%")

    fig, ax = plt.subplots(1, 2, figsize=(14, 5.5))

    validA = gridA[np.isfinite(gridA['gamma_hat'])]
    ax[0].scatter(validA['P'], validA['gamma_hat'], c=validA['EPS'], cmap='viridis',
                  s=4, alpha=0.3)
    ax[0].scatter(mag['P'], mag['gamma_hat_sim'], marker='o', s=45, facecolors='none',
                  edgecolors='red', linewidths=1.5, label='GPU sim (measured)', zorder=5)
    ax[0].scatter(mag['P'], mag['gamma_hat_th'], marker='x', s=30, c='black',
                  label='theory (Model B, at snapped kz)', zorder=5)
    ax[0].set_xscale('log')
    ax[0].set_xlabel('P = (alpha V0^2)^(1/3) / EPS')
    ax[0].set_ylabel('gamma / (alpha V0^2)^(1/3)')
    ax[0].set_title(f'Magnitude check: {len(mag)} GPU points vs theory curve')
    ax[0].legend(fontsize=8)

    anchors = fits[fits['group'] == 'cascade_anchor']
    colors = {0: 'tab:blue', 1: 'tab:orange'}
    for i, ((a, v, eps), g) in enumerate(anchors.groupby(['alpha', 'V0', 'EPS'])):
        g = g.sort_values('kz')
        c = colors.get(i, 'tab:green')
        ax[1].plot(g['kz'], g['gamma'], 'o-', color=c, ms=6,
                   label=f'alpha={a},V0={v},EPS={eps} (sim)')
        gmax_row = g.loc[g['gamma'].idxmax()]
        ax[1].axvline(gmax_row['kz'], color=c, ls=':', lw=1, alpha=0.7)
        kz_th = g['kz_peak_theory'].iloc[0] if 'kz_peak_theory' in g.columns else None
        if kz_th is not None and np.isfinite(kz_th):
            ax[1].axvline(kz_th, color=c, ls='--', lw=1.5, alpha=0.9,
                          label=f'  theory continuum peak kz={kz_th:.2f}')
    ax[1].set_xlabel('kz (physical)')
    ax[1].set_ylabel('gamma (sim)')
    ax[1].set_title('Peak-location refinement: GPU discrete peak vs continuum theory peak')
    ax[1].legend(fontsize=7)

    fig.suptitle('EPS-scan v2 Phase 2: GPU validation of the Phase 0 theory collapse')
    plt.tight_layout(rect=[0, 0, 1, 0.95])
    os.makedirs(PLOT_DIR, exist_ok=True)
    outpath = os.path.join(PLOT_DIR, 'eps_collapse_gpu_validation.png')
    plt.savefig(outpath, dpi=140, bbox_inches='tight')
    print(f"saved {outpath}")

    print("\n=== Cascade anchor peak-location summary ===")
    for (a, v, eps), g in anchors.groupby(['alpha', 'V0', 'EPS']):
        g = g.sort_values('kz')
        gmax_row = g.loc[g['gamma'].idxmax()]
        kz_th = g['kz_peak_theory'].iloc[0]
        print(f"  alpha={a} V0={v} EPS={eps}: theory continuum peak kz={kz_th:.3f}, "
              f"GPU discrete peak kz={gmax_row['kz']:.2f} ({gmax_row['tier']}), "
              f"|delta|={abs(gmax_row['kz']-kz_th):.2f}")


if __name__ == '__main__':
    main()
