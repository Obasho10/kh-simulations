#!/usr/bin/env python3
"""Phase 0 (CPU-only) for the low-alpha extension of the EPS-collapse P-theory
validation (2026-07-20). Reuses eps_collapse_theory.build_grid_b unmodified,
just with alpha extended down to 0.2 instead of the original Grid B's floor
of 0.5. alpha<=0.15 is deliberately excluded: project history (suspectfix
campaign) found alpha<=0.2 points can be unmeasurable -- seed decays into the
FP32 noise floor before growth is visible, not fixable by longer target_tu.
Stopping at alpha=0.2 keeps this campaign in the low-but-plausibly-measurable
range rather than risking a batch of doomed runs.

Output: sweep/eps_collapse_gridB_lowalpha.csv
"""
import os
from eps_collapse_theory import build_grid_b

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..'))

alphas_b = [0.2, 0.25, 0.3, 0.4]
V0s_b = [0.03, 0.05, 0.10]
epss_b = [0.10, 0.15, 0.225, 0.30, 0.45]

if __name__ == '__main__':
    df = build_grid_b(alphas_b, V0s_b, epss_b)
    out = os.path.join(ROOT, 'sweep', 'eps_collapse_gridB_lowalpha.csv')
    df.to_csv(out, index=False)
    n_safe = int(df['window_safe'].sum())
    n_finite = int(df['kz_peak'].notna().sum())
    print(f"\nWrote {len(df)} rows to {out}")
    print(f"window_safe: {n_safe}/{len(df)}  finite kz_peak: {n_finite}/{len(df)}")
    print(df.groupby('alpha')[['P', 'kz_peak', 'gamma_peak']].mean())
