#!/usr/bin/env python3
"""eps_tachyon_scan.py — eigensolver-only companion analysis for the T1.1
EPS scan (staged 2026-07-18, RESEARCH_ROADMAP.md T1.1), answering two
questions ahead of any GPU time:

  1. The core T1.1 question: does kz_peak (the fastest-growing wavelength)
     drift with EPS at fixed alpha, or stay pinned near kz_peak ~ 2*alpha?
     This gives an eigensolver-only *prediction* — gamma_sim/gamma_exact is
     historically 0.5-0.7 (never 1), so it is not a substitute for the GPU
     campaign, but it is a real, pre-registered check of the same claim.

  2. How EPS affects the OTHER (tachyonic, outer, Nielsen-Olesen) branch
     specifically, not just the intended shear-driven mode -- see
     OUTER_REGION.md. xi_crit = kz/(alpha*V0) + ln2 (tachyonic onset) and
     xi_char = 1/sqrt(alpha*kz*V0) (KH mode width) are both EPS-independent
     in xi-units; EPS only rescales the shared physical (x) axis. So in
     principle their ratio -- and therefore whether a sponge can cleanly
     separate them -- should not depend on EPS. Two things CAN still break
     that: (a) grid resolution (dxi = DX/EPS grows as EPS shrinks -- the
     EPS/DX>=6 rule), and (b) the periodic box holding fewer xi-widths as
     EPS grows (domain half-width in xi-units = 3*pi/EPS shrinks, so the
     sponge-to-periodic-wrap buffer shrinks too) -- a *second*, previously
     undocumented resolution-type constraint at the wide-EPS end, mirroring
     the narrow-EPS-end DX rule. This script checks both directly against
     the manifest and flags any point where they bite.

Reads sweep/epsscan_manifest.csv (written by gen_epsscan_campaign.py).
Writes plots/epsscan_kz_peak.png, plots/epsscan_tachyon_vs_eps.png, and
prints a findings-ready summary to stdout.
"""
import os, sys, math
import numpy as np
import pandas as pd

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..'))
MANIFEST = os.path.join(ROOT, 'sweep', 'epsscan_manifest.csv')
PLOT_DIR = os.path.join(ROOT, 'plots')

LX = 6.0 * math.pi


def main():
    df = pd.read_csv(MANIFEST)
    df['edge_xi'] = (LX / 2.0) / df['EPS']              # domain half-width in xi-units
    df['wrap_buffer'] = df['edge_xi'] - df['xi_sponge']   # sponge-to-periodic-wrap margin

    print("=" * 78)
    print("T1.1 EPS-scan eigensolver prediction (no GPU time; see FINDINGS.md for the")
    print("caveat that sim/exact is historically 0.5-0.7x, never 1x)")
    print("=" * 78)

    for alpha, g in df.groupby('alpha'):
        print(f"\n-- alpha={alpha} --")
        piv = g.pivot_table(index='EPS', columns='kz', values='gamma_eig_real')
        print(piv.round(4).to_string())
        kz_peak = piv.idxmax(axis=1)
        print(f"\nkz_peak(EPS) at alpha={alpha}:")
        for eps, kzp in kz_peak.items():
            print(f"  EPS={eps:<6} -> kz_peak={kzp:g}  (gamma={piv.loc[eps, kzp]:.4f})")
        spread = kz_peak.nunique()
        verdict = ("PINNED (coupling-selected, EPS-free)" if spread == 1
                   else f"DRIFTS across {spread} distinct kz_peak values -- shear-width-selected? "
                        "check kz_peak*EPS for a constant instead")
        print(f"  -> {verdict}")

    print("\n" + "=" * 78)
    print("Tachyonic (outer) branch vs EPS")
    print("=" * 78)
    has_outer = df['gamma_eig_outer'].notna()
    print(f"\n{has_outer.sum()}/{len(df)} points show a distinct outer/tachyonic branch "
          f"at the vetted sponge (rest: none found, or fully absent from the domain -- "
          f"xi_crit beyond the box).")
    if has_outer.any():
        print(df[has_outer][['alpha', 'EPS', 'kz', 'xi_sponge', 'xi_crit',
                             'gamma_eig_outer', 'outer_xi_peak']].to_string(index=False))

    print("\n-- Resolution-rule checks --")
    unsafe = df[~df['sponge_safe']]
    print(f"sponge_safe=False (no clean ladder rung found): {len(unsafe)}/{len(df)} points")
    if len(unsafe):
        print(unsafe[['alpha', 'EPS', 'kz']].to_string(index=False))

    tight_wrap = df[df['wrap_buffer'] < 15]
    print(f"\nwrap_buffer < 15 xi-units (sponge-to-periodic-edge margin getting tight -- "
          f"candidate for periodic-image contamination of the real branch itself, which "
          f"classify()'s magnitude threshold would NOT catch since it isn't a separate "
          f"delocalised eigenvalue): {len(tight_wrap)}/{len(df)} points")
    if len(tight_wrap):
        print(tight_wrap[['alpha', 'EPS', 'kz', 'xi_sponge', 'edge_xi', 'wrap_buffer']]
              .to_string(index=False))

    # Does gamma_eig_real at fixed (alpha, kz) trend monotonically with EPS even where
    # xi_sponge itself is unchanged (i.e. NOT explained by the known sponge-compression
    # effect)? That would point at the wrap_buffer / finite-box mechanism above.
    print("\n-- gamma_eig_real(EPS) at fixed (alpha, kz), same xi_sponge across legs? --")
    for (alpha, kz), g in df.groupby(['alpha', 'kz']):
        g = g.sort_values('EPS')
        if g['xi_sponge'].nunique() == 1 and len(g) > 2:
            vals = g['gamma_eig_real'].values
            if np.all(np.diff(vals) > 0) or np.all(np.diff(vals) < 0):
                pct = 100 * (vals[-1] - vals[0]) / vals[0]
                print(f"  alpha={alpha} kz={kz}: gamma_eig_real monotonic across EPS "
                      f"{list(g['EPS'])} at FIXED xi_sponge={g['xi_sponge'].iloc[0]:.0f} "
                      f"-> {vals} ({pct:+.0f}% end-to-end, NOT a sponge artifact)")

    os.makedirs(PLOT_DIR, exist_ok=True)
    try:
        import matplotlib
        matplotlib.use('Agg')
        import matplotlib.pyplot as plt

        fig, axes = plt.subplots(1, 2, figsize=(13, 5))
        for alpha, g in df.groupby('alpha'):
            for eps, gg in g.groupby('EPS'):
                gg = gg.sort_values('kz')
                axes[0].plot(gg['kz'], gg['gamma_eig_real'], marker='o',
                             label=f'a={alpha} EPS={eps}')
        axes[0].set_xlabel('kz'); axes[0].set_ylabel('gamma_eig (real/intended branch)')
        axes[0].set_title('T1.1: gamma(kz) vs EPS -- does kz_peak move?')
        axes[0].legend(fontsize=6, ncol=2)

        for alpha, g in df.groupby('alpha'):
            g = g.sort_values('EPS')
            axes[1].plot(g['EPS'], g['wrap_buffer'], marker='s', label=f'a={alpha}')
        axes[1].axhline(15, color='r', ls='--', lw=1, label='caution threshold')
        axes[1].set_xlabel('EPS'); axes[1].set_ylabel('sponge-to-periodic-wrap buffer (xi)')
        axes[1].set_title('Wide-EPS box-size margin (mean over kz)')
        axes[1].legend(fontsize=7)
        plt.tight_layout()
        fname = os.path.join(PLOT_DIR, 'epsscan_eigensolver_prediction.png')
        plt.savefig(fname, dpi=140)
        print(f"\nSaved plot -> {fname}")
    except Exception as e:
        print(f"\n(plotting skipped: {e})", file=sys.stderr)


if __name__ == '__main__':
    main()
