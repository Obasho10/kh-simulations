"""
Resolution/timestep convergence analysis for the ymgpu2d resolution study.

Unlike dispersion_ym.py, this script does NOT hardcode NX/NZ/DX/DT — each run may
use a different grid resolution or Courant number (that's the whole point of the
study), so grid parameters are inferred directly from each run's own CSV output
(X/Z columns) and energy.csv (step,time pairs -> DT).

Usage:
    python3 resolution_convergence.py --root <dir with ym_k1_..._res_* directories> \
        --out RESOLUTION_FINDINGS_data.json

Produces three convergence tables (spatial NZ, temporal Courant, aspect ratio dz/dx)
plus three PNG plots, all relative to the shared "res_baseline" run and the analytic
eigenvalue gamma_exact=0.080 TU^-1 (kz=1, alpha=1.0, V0=0.05 — Campaign 22).
"""

import argparse
import json
import re
from pathlib import Path

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

GAMMA_EXACT = 0.080  # analytic eigenvalue, kz=1, alpha=1.0, V0=0.05 (Campaign 22)
K_MODE = 1

# run_tag -> (axis, axis_value, display_label)
RUN_AXIS = {
    "res_baseline": ("spatial", 256, "NZ=256 (baseline)"),
    "res_nz128":    ("spatial", 128, "NZ=128"),
    "res_nz512":    ("spatial", 512, "NZ=512"),
    "res_c0.0025":  ("temporal", 0.0025, "courant=0.0025"),
    "res_c0.005":   ("temporal", 0.005, "courant=0.005"),
    "res_c0.02":    ("temporal", 0.02, "courant=0.02"),
    "res_c0.04":    ("temporal", 0.04, "courant=0.04"),
    "res_nx384":    ("aspect", 384, "NX=384 (dz/dx=2.0)"),
    "res_nx512":    ("aspect", 512, "NX=512 (dz/dx=1.5)"),
    "res_nx1152":   ("aspect", 1152, "NX=1152 (dz/dx=0.667)"),
    "res_nx1536":   ("aspect", 1536, "NX=1536 (dz/dx=0.5)"),
}
# baseline participates in all three axes
BASELINE_TAG = "res_baseline"


def infer_grid(csv_path):
    df = pd.read_csv(csv_path, usecols=["X", "Z"])
    z0 = df["Z"].iloc[0]
    nx = int((df["Z"] == z0).values.argmin())
    if nx == 0:  # argmin returns 0 if all match (single z-block) or first mismatch is idx0
        nx = len(df) if (df["Z"] == z0).all() else nx
    nz = len(df) // nx
    dx = float(df["X"].iloc[1] - df["X"].iloc[0])
    dz = float(df["Z"].iloc[nx] - df["Z"].iloc[0])
    return nx, nz, dx, dz


def infer_dt(energy_csv):
    e = pd.read_csv(energy_csv)
    # linear fit time = DT * step (through origin, step 0 has time 0)
    steps = e["step"].values.astype(float)
    times = e["time"].values.astype(float)
    mask = steps > 0
    dt = float(np.mean(times[mask] / steps[mask]))
    return dt, e


def load_snapshot(path, nx, nz):
    df = pd.read_csv(path)
    az2 = df["Az2"].values.reshape(nz, nx)
    az3 = df["Az3"].values.reshape(nz, nx)
    by2 = df["By2"].values.reshape(nz, nx)
    by3 = df["By3"].values.reshape(nz, nx)
    return az2, az3, by2, by3


def xi_weight(nx, dx, eps=0.15, lx=6.0 * np.pi):
    x_arr = np.arange(nx) * dx
    w = 1.0 / np.cosh((x_arr - lx / 2.0) / eps)
    return w / w.sum()


def extract_circ_amplitude(field_re, field_im, k_mode, nz, weight):
    fre = np.fft.rfft(field_re, axis=0)[k_mode, :] / nz
    fim = np.fft.rfft(field_im, axis=0)[k_mode, :] / nz
    amp = np.abs(fre + 1j * fim)
    return float(np.dot(amp, weight))


def smooth_envelope(amps, half_win=3):
    n = len(amps)
    env = np.empty(n)
    for i in range(n):
        lo, hi = max(0, i - half_win), min(n, i + half_win + 1)
        env[i] = np.mean(amps[lo:hi])
    return env


def fit_growth_rate(times, amps, t_min=None, t_max=None, min_win_frac=0.3):
    mask = np.ones(len(times), dtype=bool)
    if t_min is not None:
        mask &= times >= t_min
    if t_max is not None:
        mask &= times <= t_max
    mask &= amps > 1e-30
    if mask.sum() < 5:
        return float("nan"), float("nan"), float("nan"), float("nan")
    t_win = times[mask]
    a_win = np.log(amps[mask] + 1e-30)
    env = smooth_envelope(a_win)
    n = len(t_win)
    win = max(5, int(n * min_win_frac))
    best = {"r2": -np.inf, "gamma": float("nan"), "t0": float("nan"), "t1": float("nan")}
    for i0 in range(max(1, n - win)):
        tw, aw = t_win[i0:i0 + win], env[i0:i0 + win]
        if len(tw) < 4:
            continue
        c = np.polyfit(tw, aw, 1)
        if c[0] < 1e-6:
            continue
        res = aw - np.polyval(c, tw)
        ss_res, ss_tot = np.sum(res ** 2), np.sum((aw - aw.mean()) ** 2)
        r2 = 1.0 - ss_res / (ss_tot + 1e-30)
        if r2 > best["r2"]:
            best = {"r2": r2, "gamma": c[0], "t0": tw[0], "t1": tw[-1]}
    return best["gamma"], best["t0"], best["t1"], best["r2"]


def analyze_run(run_dir, k_mode=K_MODE, t_min=10.0, t_max=None, field="by_circ"):
    # field="by_circ": |By2+iBy3|. Az2/Az3 are seeded with a large *static* Gaussian
    # at t=0 (mode 6 seeds the eigenmode via Az2/Az3, not By2/By3) — over the short
    # ~25 TU convergence-study window that seed dominates Az_circ's amplitude and its
    # slow fractional growth is unmeasurable there. By2/By3 start at exactly zero and
    # grow purely from induction, giving a clean, unambiguous exponential signal.
    run_dir = Path(run_dir)
    files = sorted(run_dir.glob("ym_*.csv"),
                    key=lambda f: int(re.search(r"(\d+)", f.name).group(1)))
    if not files:
        raise FileNotFoundError(f"No snapshots in {run_dir}")
    energy_csv = run_dir / "energy.csv"
    dt, edf = infer_dt(energy_csv)
    nx, nz, dx, dz = infer_grid(files[-1])
    weight = xi_weight(nx, dx)

    times, amps = [], []
    for f in files:
        step = int(re.search(r"(\d+)", f.name).group(1))
        az2, az3, by2, by3 = load_snapshot(f, nx, nz)
        re_f, im_f = (by2, by3) if field == "by_circ" else (az2, az3)
        amp = extract_circ_amplitude(re_f, im_f, k_mode, nz, weight)
        times.append(step * dt)
        amps.append(amp)
    times, amps = np.array(times), np.array(amps)

    gamma, t0, t1, r2 = fit_growth_rate(times, amps, t_min=t_min, t_max=t_max)

    e_ratio_final = float(edf["E_ratio"].values[-1])
    e_ratio_max = float(edf["E_ratio"].values.max())
    halted_early = len(edf) > 0 and edf["time"].values[-1] < times[-1] - dt

    return {
        "nx": nx, "nz": nz, "dx": dx, "dz": dz, "dt": dt,
        "dz_over_dx": dz / dx,
        "gamma": gamma, "gamma_fit_t0": float(t0), "gamma_fit_t1": float(t1), "gamma_r2": float(r2),
        "times": times.tolist(), "amps": amps.tolist(),
        "e_ratio_final": e_ratio_final, "e_ratio_max": e_ratio_max,
        "halted_early": bool(halted_early),
        "n_snapshots": len(files),
    }


def find_run_dir(root, run_tag):
    matches = list(Path(root).glob(f"ym_k1_a1.000*_{run_tag}"))
    if not matches:
        return None
    return matches[0]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--root", required=True, help="directory containing ym_k1_..._res_* run dirs")
    ap.add_argument("--out-json", default="resolution_convergence_data.json")
    ap.add_argument("--out-prefix", default="resolution_convergence")
    ap.add_argument("--t-min", type=float, default=10.0, help="fit window start (TU), skips early transient")
    args = ap.parse_args()

    results = {}
    for tag in RUN_AXIS:
        run_dir = find_run_dir(args.root, tag)
        if run_dir is None:
            print(f"[skip] {tag}: no matching directory under {args.root}")
            continue
        try:
            r = analyze_run(run_dir, t_min=args.t_min)
        except Exception as e:
            print(f"[error] {tag}: {e}")
            continue
        axis, val, label = RUN_AXIS[tag]
        r.update({"tag": tag, "axis": axis, "axis_value": val, "label": label})
        results[tag] = r
        print(f"{tag:16s} axis={axis:9s} NX={r['nx']:5d} NZ={r['nz']:5d} "
              f"DT={r['dt']:.3e}  gamma={r['gamma']:.5f} (R2={r['gamma_r2']:.3f}, "
              f"fit t=[{r['gamma_fit_t0']:.1f},{r['gamma_fit_t1']:.1f}])  "
              f"E_ratio_max={r['e_ratio_max']:.3f}")

    with open(args.out_json, "w") as fh:
        json.dump(results, fh, indent=2)

    # ── Three convergence plots ──
    axes_def = [
        ("spatial", "NZ", lambda r: r["nz"]),
        ("temporal", "Courant number (DT/DX)", lambda r: r["dt"] / r["dx"]),
        ("aspect", "dz/dx", lambda r: r["dz_over_dx"]),
    ]
    for axis_name, xlabel, xkey in axes_def:
        rows = [r for r in results.values() if r["axis"] == axis_name or r["tag"] == BASELINE_TAG]
        rows = sorted({r["tag"]: r for r in rows}.values(), key=xkey)
        if not rows:
            continue
        xs = [xkey(r) for r in rows]
        gs = [r["gamma"] for r in rows]
        fig, ax = plt.subplots(figsize=(6, 4))
        ax.plot(xs, gs, "o-", label="measured γ (kz=1)")
        ax.axhline(GAMMA_EXACT, color="gray", ls="--", label=f"γ_exact={GAMMA_EXACT}")
        if axis_name == "spatial":
            ax.set_xscale("log", base=2)
        elif axis_name == "temporal":
            ax.set_xscale("log")
        ax.set_xlabel(xlabel)
        ax.set_ylabel("γ (TU⁻¹)")
        ax.set_title(f"{axis_name.capitalize()} convergence (kz=1)")
        ax.legend()
        fig.tight_layout()
        fig.savefig(f"{args.out_prefix}_{axis_name}.png", dpi=150)
        print(f"Wrote {args.out_prefix}_{axis_name}.png")

    print(f"Wrote {args.out_json}")


if __name__ == "__main__":
    main()
