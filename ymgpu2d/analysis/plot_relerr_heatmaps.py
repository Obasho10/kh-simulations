#!/usr/bin/env python3
"""Heatmaps of relative error vs sigma-chased eigensolver theory.
One panel per V0, x = integer kz, y = alpha (>0.3), individual color scale
per panel. No-data cells: light gray. Output: plots/relerr_heatmap_int_kz.png"""
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.colors import LinearSegmentedColormap, LogNorm
from matplotlib.ticker import FixedLocator, FuncFormatter

import os
D = np.load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'sweep', 'all_points_vs_chased.npz'))
df = pd.DataFrame({k: D[k] for k in D.files})
df['has_plateau'] = df['has_plateau'] == 'True'
d = df[(df['tier'] == 'int') & (df['kz'] >= 1) & (df['alpha'] > 0.3)
       & np.isfinite(df['rel_err_chased'])].copy()

V0S = [0.01, 0.03, 0.05, 0.1, 0.2]
KZ = [k for k in sorted(d['kz'].unique())]
ALPHA = [a for a in sorted(d['alpha'].unique())]

# single-hue sequential ramp (light -> dark blue), monotonic lightness
cmap = LinearSegmentedColormap.from_list(
    'seqblue', ['#eff6ff', '#bfdbfe', '#60a5fa', '#2563eb', '#1e3a8a'])
cmap.set_bad('#e8e8e8')  # no-data gray

fig, axes = plt.subplots(2, 3, figsize=(16.5, 10), dpi=150)
axes = axes.ravel()

for ax, v in zip(axes, V0S):
    sub = d[np.isclose(d['V0'], v)]
    grid = np.full((len(ALPHA), len(KZ)), np.nan)
    for r in sub.itertuples():
        grid[ALPHA.index(r.alpha), KZ.index(r.kz)] = r.rel_err_chased * 100
    finite = grid[np.isfinite(grid)]
    n_over = int(np.sum(finite > 100))
    pm = ax.pcolormesh(np.ma.masked_invalid(grid), cmap=cmap, vmin=0, vmax=100,
                       edgecolors='white', linewidth=0.6)
    cb = fig.colorbar(pm, ax=ax, extend='max', pad=0.02, aspect=28)
    cb.ax.yaxis.set_major_locator(FixedLocator([0, 25, 50, 75, 100]))
    cb.ax.yaxis.set_minor_locator(FixedLocator([]))
    cb.ax.yaxis.set_major_formatter(FuncFormatter(lambda v, p: f'{v:g}'))
    cb.set_label('rel. error vs chased theory  [%]', fontsize=8.5, color='#444444')
    cb.ax.tick_params(labelsize=8, colors='#444444')
    cb.outline.set_visible(False)

    ax.set_xticks(np.arange(len(KZ)) + 0.5)
    ax.set_xticklabels([f'{k:.0f}' for k in KZ], fontsize=8.5, color='#444444')
    ax.set_yticks(np.arange(len(ALPHA)) + 0.5)
    ax.set_yticklabels([f'{a:.1f}' if (i % 2 == 0 or a > 3) else ''
                        for i, a in enumerate(ALPHA)], fontsize=7.5, color='#444444')
    ax.set_xlabel('kz', fontsize=9.5, color='#333333')
    ax.set_ylabel('alpha', fontsize=9.5, color='#333333')
    med = np.median(finite)
    ax.set_title(f'V0 = {v}   (n={len(finite)}, median {med:.0f}%, {n_over} cells >100%)',
                 fontsize=10.5, color='#222222')
    for s in ax.spines.values():
        s.set_visible(False)
    ax.tick_params(length=0)

axes[5].axis('off')
axes[5].text(0.02, 0.92,
             'All measured integer-kz points, alpha > 0.3\n'
             'best run per (V0, alpha, kz); plateau rate when\n'
             'confirmed, else best-window fit\n\n'
             'color = |gamma_sim - gamma_theory| / gamma_theory\n'
             'theory = sigma-chased windowed eigensolver\n'
             'at the run\'s actual xi_sponge\n\n'
             'common color scale across panels,\n'
             'capped at 100% (arrow = cells beyond cap)\n\n'
             'gray = not measured\n\n'
             'alpha grid is 0.4-3.0; the sparse alpha = 4, 5\n'
             'rows exist only at V0 = 0.03 (and 4 at V0 = 0.1)',
             transform=axes[5].transAxes, fontsize=10, va='top',
             color='#333333', linespacing=1.45)

fig.suptitle('Simulation vs best theory: relative error, integer kz, alpha > 0.3',
             fontsize=13, color='#111111', y=0.985)
fig.tight_layout(rect=(0, 0, 1, 0.965))
out = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'plots', 'relerr_heatmap_int_kz.png')
fig.savefig(out, facecolor='white')
print('wrote', out)
