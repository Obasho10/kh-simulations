#!/usr/bin/env python3
"""
Phase 0 of LX_RESOLUTION_PLAN.md: analytic (no-GPU) feasibility screen for
shrinking the production Lx=6*pi box, run against the real historical
parameter space in sweep/all_points_vs_chased.npz (4195 points already
measured across all past campaigns -- no synthetic grid needed).

For each point, half_width_needed = xi_sponge_used * eps_used + MARGIN_XI:
the physical buffer width that point's OWN already-validated sponge choice
requires (plus headroom), regardless of what box it actually ran in. Compare
against Lx/2 for each candidate tier. This tells us whether reusing that
exact sponge choice in a smaller box would still leave it the same margin it
already had -- it does NOT by itself re-derive a smaller safe sponge for
points that fail (see find_safe_sponge.py's new Lx kwarg for that, used
separately on the failures).

The existing EPS>=0.30 box-doubling convention (gen_epsscan_v2_campaign.py)
is applied on top: for those points the box would actually be 2x whatever
tier is picked, so their effective half-width is doubled too.

Usage: python3 lx_feasibility_screen.py
Output: sweep/lx_feasibility.csv, plots/lx_feasibility_screen.png
"""
import os
import math

import numpy as np
import pandas as pd
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..'))

MARGIN_XI = 3.0  # extra xi-units headroom beyond the recorded sponge itself
LX_TIERS = [('2pi', 2 * math.pi), ('3pi', 3 * math.pi),
            ('4pi', 4 * math.pi), ('6pi', 6 * math.pi)]
EPS_WIDE_THRESHOLD = 0.30


def main():
    d = np.load(os.path.join(ROOT, 'sweep', 'all_points_vs_chased.npz'), allow_pickle=True)
    df = pd.DataFrame({k: d[k] for k in
                        ['alpha', 'V0', 'kz', 'eps', 'xi_sponge', 'source', 'node']})
    df['xi_sponge'] = pd.to_numeric(df['xi_sponge'], errors='coerce')
    df['eps'] = pd.to_numeric(df['eps'], errors='coerce')
    n_total = len(df)
    df = df.dropna(subset=['xi_sponge', 'eps'])
    df = df[df['xi_sponge'] > 0]
    print(f"Loaded {n_total} points, {len(df)} with usable xi_sponge/eps.")

    needed_xi = df['xi_sponge'].astype(float) + MARGIN_XI
    for tag, lx in LX_TIERS:
        half_width_xi = (lx / 2.0) / df['eps'].astype(float)
        eff_half_width_xi = np.where(df['eps'] >= EPS_WIDE_THRESHOLD,
                                      2.0 * half_width_xi, half_width_xi)
        df[f'safe_{tag}'] = eff_half_width_xi >= needed_xi

    df['half_width_needed_phys'] = needed_xi * df['eps'].astype(float)

    out_csv = os.path.join(ROOT, 'sweep', 'lx_feasibility.csv')
    df.to_csv(out_csv, index=False)

    print("\n=== Fraction of historical points safe at each Lx tier ===")
    for tag, lx in LX_TIERS:
        frac = df[f'safe_{tag}'].mean()
        print(f"  Lx={tag:>4}: {frac * 100:5.1f}% safe  ({int(df[f'safe_{tag}'].sum())}/{len(df)})")

    df['alphaV0'] = df['alpha'].astype(float) * df['V0'].astype(float)
    kz_bins = [0, 0.5, 1, 2, 3, 5, 8, 1e9]
    av0_bins = [0, 0.02, 0.05, 0.1, 0.2, 0.5, 1e9]
    df['kz_bin'] = pd.cut(df['kz'].astype(float), kz_bins)
    df['av0_bin'] = pd.cut(df['alphaV0'], av0_bins)
    pivot = df.pivot_table(index='kz_bin', columns='av0_bin', values='safe_2pi',
                            aggfunc='mean', observed=False)
    print("\n=== safe_2pi fraction by (kz, alpha*V0) bin ===")
    print(pivot.round(2).to_string())

    counts = df.pivot_table(index='kz_bin', columns='av0_bin', values='safe_2pi',
                             aggfunc='count', observed=False)
    print("\n=== point counts per bin ===")
    print(counts.to_string())

    # Report the worst (lowest-margin) points that still fail at 2pi, for
    # picking the Phase 1b stress-test corner.
    fails = df[~df['safe_2pi']].copy()
    if len(fails):
        fails['margin_2pi_phys'] = ((2 * math.pi / 2.0) / fails['eps']
                                     * np.where(fails['eps'] >= EPS_WIDE_THRESHOLD, 2.0, 1.0)
                                     - needed_xi.loc[fails.index]) * fails['eps']
        worst = fails.sort_values('margin_2pi_phys').head(15)
        print(f"\n=== {len(fails)} points fail safe_2pi; 15 worst (most negative margin) ===")
        print(worst[['alpha', 'V0', 'kz', 'eps', 'xi_sponge', 'half_width_needed_phys',
                      'margin_2pi_phys', 'source']].to_string(index=False))

    os.makedirs(os.path.join(ROOT, 'plots'), exist_ok=True)
    fig, ax = plt.subplots(figsize=(8, 6))
    im = ax.imshow(pivot.values.astype(float), aspect='auto', cmap='RdYlGn', vmin=0, vmax=1)
    ax.set_xticks(range(len(pivot.columns)))
    ax.set_xticklabels([str(c) for c in pivot.columns], rotation=45, ha='right')
    ax.set_yticks(range(len(pivot.index)))
    ax.set_yticklabels([str(i) for i in pivot.index])
    ax.set_xlabel('alpha*V0 bin')
    ax.set_ylabel('kz bin')
    ax.set_title('Fraction of historical points safe at Lx=2pi\n'
                  '(reusing their own recorded xi_sponge + 3 xi margin)')
    plt.colorbar(im, ax=ax, label='fraction safe')
    plt.tight_layout()
    plot_path = os.path.join(ROOT, 'plots', 'lx_feasibility_screen.png')
    plt.savefig(plot_path, dpi=120)
    print(f"\nWrote {out_csv}\nWrote {plot_path}")


if __name__ == '__main__':
    main()
