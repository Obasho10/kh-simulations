"""
Create parameter-sweep data tables as npz files, one per V0 value.

Each file contains:
  alpha_vals  : shape (Na,)   — alpha = 0.1, 0.2, ..., 3.0
  kz_vals     : shape (Nk,)   — kz   = 0.125, 0.250, ..., 10.0 (step 0.125)
  gamma_wkb   : shape (Na,Nk) — WKB analytic growth rate (n=0 fundamental mode)
  gamma_sim   : shape (Na,Nk) — simulation result (NaN until filled)
  rel_error   : shape (Na,Nk) — |gamma_sim - gamma_wkb| / gamma_wkb (NaN until filled)

Usage:
  python3 make_sweep_tables.py          # create/overwrite all files
  python3 make_sweep_tables.py --fill   # fill sim values from batch_results.csv

Files: sweep/v0p01.npz  v0p03.npz  v0p05.npz  v0p1.npz  v0p2.npz
"""

import numpy as np
import os, sys

V0_LIST = [
    (0.01, "v0p01"),
    (0.03, "v0p03"),
    (0.05, "v0p05"),
    (0.10, "v0p1"),
    (0.20, "v0p2"),
]

ALPHA_VALS = np.round(np.arange(0.1, 3.01, 0.1), 6)   # 30 values
KZ_VALS    = np.round(np.arange(0.125, 10.001, 0.125), 6)  # 80 values


def wkb_gamma(alpha, V0, kz):
    """Max Im(omega) from the WKB quartic (wkb.pdf eq.33 / wkbfull.pdf eq.4)
    at n=0 (fundamental mode) only. n=0 is dominant: the bare quartic used
    here omits the anharmonic C2*x^4 correction that extends validity to
    higher n, so a scan-and-max over n>0 does not track real subdominant
    excited states -- it diverges without bound, asymptoting to the
    delocalized kz=0 chromo-Weibel cubic (gamma ~ C(n)^(1/3)), which is a
    sign the harmonic-well/localization assumption has broken down, not
    that a higher-n bound state genuinely dominates. Solving the corrected
    quantization condition (wkbfull.pdf eq.12) instead gives a properly
    monotonically-decreasing ladder with n=0 on top, confirming this."""
    C = np.sqrt(alpha**3 / 2.0) * V0  # n=0: (2*0+1) = 1
    coeffs = [1.0, 0.0, -kz**2, -C, -alpha**2 * V0 * kz]
    roots = np.roots(coeffs)
    growing = roots[roots.imag > 1e-10]
    return float(np.max(growing.imag)) if len(growing) else 0.0


def make_file(V0, tag, outdir="sweep"):
    os.makedirs(outdir, exist_ok=True)
    Na, Nk = len(ALPHA_VALS), len(KZ_VALS)
    gamma_wkb = np.zeros((Na, Nk), dtype=np.float64)
    for ia, alpha in enumerate(ALPHA_VALS):
        for ik, kz in enumerate(KZ_VALS):
            gamma_wkb[ia, ik] = wkb_gamma(alpha, V0, kz)
        if (ia+1) % 5 == 0:
            print(f"  V0={V0} α={alpha:.1f} done")

    gamma_sim  = np.full((Na, Nk), np.nan)
    rel_error  = np.full((Na, Nk), np.nan)

    path = os.path.join(outdir, f"{tag}.npz")
    np.savez_compressed(path,
                        alpha_vals=ALPHA_VALS,
                        kz_vals=KZ_VALS,
                        gamma_wkb=gamma_wkb,
                        gamma_sim=gamma_sim,
                        rel_error=rel_error)
    print(f"Wrote {path}  shape={gamma_wkb.shape}  "
          f"max_wkb={gamma_wkb.max():.4f}")


def fill_from_csv(csv_path="batch_results.csv", outdir="sweep"):
    """Fill gamma_sim and rel_error from batch_best.csv."""
    import pandas as pd
    df = pd.read_csv(csv_path)

    for V0, tag in V0_LIST:
        path = os.path.join(outdir, f"{tag}.npz")
        if not os.path.exists(path):
            print(f"  {path} not found, skipping")
            continue
        d = dict(np.load(path))
        sub = df[np.isclose(df['V0'], V0, atol=V0*0.01)]
        filled = 0
        for _, row in sub.iterrows():
            ia = np.argmin(np.abs(d['alpha_vals'] - row['alpha']))
            # kz from sim is an integer; find nearest kz_val
            ik = np.argmin(np.abs(d['kz_vals'] - row['kz']))
            if not np.isfinite(row['gamma_sim']) or row['gamma_sim'] <= 0:
                continue
            d['gamma_sim'][ia, ik] = row['gamma_sim']
            if d['gamma_wkb'][ia, ik] > 0:
                d['rel_error'][ia, ik] = abs(row['gamma_sim'] - d['gamma_wkb'][ia, ik]) / d['gamma_wkb'][ia, ik]
            filled += 1
        np.savez_compressed(path, **d)
        print(f"  {tag}: filled {filled} sim points")


if __name__ == "__main__":
    if "--fill" in sys.argv:
        print("Filling sim values from batch_results.csv ...")
        fill_from_csv()
    else:
        print(f"Building WKB tables: {len(ALPHA_VALS)} alpha × {len(KZ_VALS)} kz points each")
        for V0, tag in V0_LIST:
            print(f"\n=== V0={V0} ({tag}) ===")
            make_file(V0, tag)
        print("\nDone. To fill in sim values later: python3 make_sweep_tables.py --fill")
