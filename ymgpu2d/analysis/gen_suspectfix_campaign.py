#!/usr/bin/env python3
"""Generate the suspectfix campaign: reruns the ~1633 (alpha,V0,kz) points in
sweep/{v0p01,v0p03,v0p05}.npz whose best-attempt-so-far gamma_sim disagrees
with gamma_wkb by >30%, using a find_safe_sponge.py-vetted xi_sponge (instead
of the old blind gen_multigpu_campaign.py::xi_sponge_for formula that most of
them were run with) and an adaptive target_tu (15/gamma_wkb, clipped to
[100,400]) instead of the fixed 100 (or even 50, for the eighth/quarter-kz
tier) TU used previously -- slow-growth low-alpha/low-V0 points need far
longer than 100 TU to reach a clean plateau.

Inputs:
  suspect_points_raw.csv   -- alpha,V0,kz,... (+ everything from batch_results.csv)
  sponge_chunks/chunk_*_out.csv -- alpha,V0,kz,xi_sponge,gamma_exact,safe
    (from find_safe_sponge.py, precomputed in parallel -- see _sponge_chunk_worker.py)

Output: scripts/suspectfix_{t130,t140,abi}.sh + scripts/suspectfix_manifest.csv

Node/stream model (5 streams): t130, t140 (RTX A5000, /DATA/cm/lcpfct/ymgpu2d)
+ abi GPU0/1/2 (GTX 1080Ti, /DATA/s23103/lcpfct/ymgpu2d). t126 excluded (CUDA
driver/runtime mismatch on that box, unrelated to this code).

Grid tiers (kz snapped to the 1/8 grid used by sweep/*.npz):
  int  (kz*8 % 8 == 0): default grid (Lz=2pi, NZ=64), k_mode=kz,      bp=14
  half (kz*8 % 8 == 4): Lz=4pi, NZ=128,  k_mode=round(2*kz),          bp=28
  fine (else):          Lz=16pi, NZ=512, k_mode=round(8*kz),          bp=55
(bp = kz_suppress_hi; also becomes the "_bp{N}" tag in the output dir name
that batch_analyze.py's parse_dir() string-matches to infer the grid tier --
see FINDINGS.md and YM_Config/main_ym.cu dir-naming. Keep these exact values.)
"""
import sys, os, math
import numpy as np
import pandas as pd

SCRIPT_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "scripts")
SCRATCH = "/tmp/claude-1001/-home-user-kh-ymgpu2d/68df1c76-663a-4701-80ca-c628c510e7ba/scratchpad"

LZ_HALF = 4 * math.pi
LZ_FINE = 16 * math.pi
NZ_HALF = 128
NZ_FINE = 512

# empirical sec/TU at the *default* (int-tier, NZ=64) grid; fine=8x cells, half=2x
SEC_PER_TU_A5000 = 0.87
SEC_PER_TU_1080TI = 0.87 / (4500.0 / 9200.0)

STREAMS = [
    ("t126", "a5000", "/DATA/cm/lcpfct/ymgpu2d", None),
    ("t130", "a5000", "/DATA/cm/lcpfct/ymgpu2d", None),
    ("t140", "a5000", "/DATA/cm/lcpfct/ymgpu2d", None),
    ("t132", "a5000", "/DATA/ym_kh", None),
    ("abi0", "1080ti", "/DATA/s23103/lcpfct/ymgpu2d", 0),
    ("abi1", "1080ti", "/DATA/s23103/lcpfct/ymgpu2d", 1),
    ("abi2", "1080ti", "/DATA/s23103/lcpfct/ymgpu2d", 2),
]

# Excluded from this rerun (2026-07-16): the seed transient decays into FP32
# noise floor before any growth is visible at these alpha values, even at
# target_tu's 400 cap -- see project_low_alpha_noise_floor.md. Not fixable by
# rerunning with the same seeding approach, so drop them rather than burn
# GPU-hours on more unmeasurable points. Also cuts total runtime a lot since
# these were the slowest (lowest gamma_wkb -> longest target_tu) corner.
EXCLUDE_ALPHA = {0.1, 0.2}


def wkb_gamma(alpha, V0, kz):
    C = np.sqrt(alpha**3 / 2.0) * V0
    coeffs = [1.0, 0.0, -kz**2, -C, -alpha**2 * V0 * kz]
    roots = np.roots(coeffs)
    g = roots[roots.imag > 1e-10]
    return float(np.max(g.imag)) if len(g) else 0.0


def tier_of(kz):
    e = int(round(kz * 8))
    if e % 8 == 0:
        return "int"
    if e % 8 == 4:
        return "half"
    return "fine"


def load_points(exclude_path=None):
    """Load every suspect point that currently has a completed sponge
    precompute result (inner join -- lets this be called against a
    still-running precompute for an early wave, or the final leftovers for
    a later wave). exclude_path, if given, is a CSV of alpha,V0,kz already
    scheduled by an earlier wave -- excluded so waves never double-run a
    point."""
    suspect = pd.read_csv(os.path.join(SCRATCH, "suspect_points_raw.csv"))
    # suspect_points_raw.csv already carries an xi_sponge column -- the OLD,
    # unvetted value from the run that made this point "suspect" in the
    # first place. Drop it before merging so the vetted value from the
    # precompute (sponge['xi_sponge']) survives under its own name instead
    # of silently colliding and losing to suffixes=("","_sp") (bug found
    # 2026-07-16: this caused ~98% of suspectfix reruns to use the old,
    # never-fixed sponge value despite the whole campaign existing to fix it).
    suspect = suspect.drop(columns=["xi_sponge"])
    chunks = []
    for i in range(8):
        p = os.path.join(SCRATCH, "sponge_chunks", f"chunk_{i}_out.csv")
        chunks.append(pd.read_csv(p))
    sponge = pd.concat(chunks, ignore_index=True)

    df = suspect.merge(sponge, on=["alpha", "V0", "kz"], how="inner", suffixes=("", "_sp"))

    if EXCLUDE_ALPHA:
        before = len(df)
        df = df[~df["alpha"].isin(EXCLUDE_ALPHA)]
        print(f"Dropped {before - len(df)} points at alpha in {EXCLUDE_ALPHA} (noise-floor gap)", file=sys.stderr)

    if exclude_path and os.path.exists(exclude_path):
        prev = pd.read_csv(exclude_path)[["alpha", "V0", "kz"]]
        before = len(df)
        df = df.merge(prev.assign(_prev=True), on=["alpha", "V0", "kz"], how="left")
        df = df[df["_prev"].isna()].drop(columns=["_prev"])
        print(f"Excluded {before - len(df)} points already scheduled by an earlier wave", file=sys.stderr)

    df["gamma_wkb2"] = [wkb_gamma(a, v, k) for a, v, k in zip(df["alpha"], df["V0"], df["kz"])]
    df["target_tu"] = np.clip(15.0 / df["gamma_wkb2"], 100, 400).round(1)
    df["tier"] = df["kz"].apply(tier_of)
    df["cellmult"] = df["tier"].map({"int": 1, "half": 2, "fine": 8})

    def kmode_of(row):
        if row["tier"] == "int":
            return int(round(row["kz"]))
        if row["tier"] == "half":
            return int(round(2 * row["kz"]))
        return int(round(8 * row["kz"]))
    df["k_mode"] = df.apply(kmode_of, axis=1)
    df["bp"] = df["tier"].map({"int": 14, "half": 28, "fine": 55})

    df["cost_a5000"] = df["target_tu"] * df["cellmult"] * SEC_PER_TU_A5000
    df["cost_1080ti"] = df["target_tu"] * df["cellmult"] * SEC_PER_TU_1080TI
    return df


def assign_streams(df):
    """Greedy LPT: sort heaviest-first, assign each point to whichever stream
    finishes it soonest given that stream's current cumulative load."""
    order = df.sort_values("cost_a5000", ascending=False).index
    finish = {s[0]: 0.0 for s in STREAMS}
    speed_key = {s[0]: s[1] for s in STREAMS}
    assign = {}
    for idx in order:
        row = df.loc[idx]
        best_stream, best_finish = None, None
        for name, cls, _, _ in STREAMS:
            cost = row["cost_a5000"] if cls == "a5000" else row["cost_1080ti"]
            cand_finish = finish[name] + cost
            if best_finish is None or cand_finish < best_finish:
                best_finish, best_stream = cand_finish, name
        cost = row["cost_a5000"] if speed_key[best_stream] == "a5000" else row["cost_1080ti"]
        finish[best_stream] += cost
        assign[idx] = best_stream
    df["stream"] = pd.Series(assign)

    # Run order within each stream: fastest-to-complete first (ascending own
    # cost), not the incidental dataframe order -- get more finished points
    # sooner, so a stop/pause loses less unfinished work and early sanity
    # checks have more data to look at.
    stream_cls = {s[0]: s[1] for s in STREAMS}
    df["own_cost"] = df.apply(
        lambda r: r["cost_a5000"] if stream_cls[r["stream"]] == "a5000" else r["cost_1080ti"], axis=1)
    df = df.sort_values(["stream", "own_cost"]).reset_index(drop=True)

    return df, finish


def lz_nz_block(tier):
    """Box-override .ini lines for the stretched-box tiers.

    CRITICAL (bug found 2026-07-17): every emitted suspectfix script omitted
    these lines, so ALL half/fine-tier reruns executed on the default Lz=2pi
    box at physical kz = k_mode (2x/8x the labeled kz). Any future wave MUST
    include them. See FINDINGS.md 2026-07-17 entry.
    """
    if tier == "half":
        return f"lz_override = {LZ_HALF:.6f}\nnz_override = {NZ_HALF}\n"
    if tier == "fine":
        return f"lz_override = {LZ_FINE:.6f}\nnz_override = {NZ_FINE}\n"
    return ""


INI_TEMPLATE = """cat > {ini} <<'EOINI'
k_mode = {k_mode}
alpha_YM = {alpha}
V0 = {V0}
perturb_amp = 0.001
run_mode = 6
xi_sponge = {xi_sponge}
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = {kz_suppress_max}
eps_override = 0.15
kz_suppress_hi = {bp}
target_tu = {target_tu}
{lz_nz_block}run_tag = suspectfix
EOINI
echo "[{stream}] a={alpha} V0={V0} kz={kz} (tier={tier}) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled {ini} >> $LOG 2>&1) || echo "[{stream}] a={alpha} V0={V0} kz={kz} CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k{k_mode}_a{alpha:.3f}_*_v{V0:.4f}_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[{stream}] a={alpha} V0={V0} kz={kz} done $(date)" >> $LOG
"""


def emit_single_gpu_script(stream_name, wdir, points, out_path):
    lines = ["#!/bin/bash",
             f"# suspectfix campaign -- {stream_name}: {len(points)} runs",
             f"# Launch: nohup bash scripts/{os.path.basename(out_path)} > logs/suspectfix_{stream_name}.log 2>&1 &",
             "set -e",
             f"WDIR={wdir}",
             "mkdir -p $WDIR/logs $WDIR/outputs",
             f"LOG=$WDIR/logs/suspectfix_{stream_name}_progress.log",
             'echo "=== start $(date) ===" >> $LOG']
    for _, row in points.iterrows():
        ini = f"/tmp/sfx_{stream_name}_a{row['alpha']}_v{row['V0']}_kz{row['kz']}.ini"
        lines.append(INI_TEMPLATE.format(
            ini=ini, k_mode=row['k_mode'], alpha=row['alpha'], V0=row['V0'],
            xi_sponge=row['xi_sponge'], kz_suppress_max=row['k_mode'] - 1,
            bp=row['bp'], target_tu=row['target_tu'], stream=stream_name,
            kz=row['kz'], tier=row['tier'], lz_nz_block=lz_nz_block(row['tier'])))
    lines.append(f'echo "=== {stream_name} ALL DONE $(date) ===" >> $LOG')
    with open(out_path, "w") as f:
        f.write("\n".join(lines) + "\n")


def emit_abi_script(gpu_points, out_path):
    lines = ["#!/bin/bash",
             f"# suspectfix campaign -- abi (3 GPUs)",
             f"# Launch: nohup bash scripts/{os.path.basename(out_path)} > logs/suspectfix_abi.log 2>&1 &",
             "set -e",
             "WDIR=/DATA/s23103/lcpfct/ymgpu2d",
             "mkdir -p $WDIR/logs $WDIR/outputs",
             ""]
    for gpu_id in range(3):
        stream_name = f"abi{gpu_id}"
        points = gpu_points[gpu_id]
        lines.append(f"run_gpu{gpu_id}() {{")
        lines.append(f"    export CUDA_VISIBLE_DEVICES={gpu_id}")
        lines.append(f"    WDIR=/DATA/s23103/lcpfct/ymgpu2d")
        lines.append(f"    LOG=$WDIR/logs/suspectfix_{stream_name}_progress.log")
        lines.append(f'    echo "[GPU{gpu_id}] start $(date)" >> $LOG')
        for _, row in points.iterrows():
            ini = f"/tmp/sfx_{stream_name}_a{row['alpha']}_v{row['V0']}_kz{row['kz']}.ini"
            block = INI_TEMPLATE.format(
                ini=ini, k_mode=row['k_mode'], alpha=row['alpha'], V0=row['V0'],
                xi_sponge=row['xi_sponge'], kz_suppress_max=row['k_mode'] - 1,
                bp=row['bp'], target_tu=row['target_tu'], stream=f"GPU{gpu_id}",
                kz=row['kz'], tier=row['tier'], lz_nz_block=lz_nz_block(row['tier']))
            # NOTE: deliberately not indented -- the block contains a
            # <<'EOINI' heredoc whose closing delimiter must start in
            # column 0, so prefixing every line (including EOINI) with
            # spaces would break it. Bash doesn't need indentation for
            # correctness inside a function body.
            lines.extend(block.split("\n"))
        lines.append(f'    echo "[GPU{gpu_id}] ALL DONE $(date)" >> $LOG')
        lines.append("}")
        lines.append("")
    lines.append('echo "=== abi: launching 3-GPU suspectfix campaign $(date) ==="')
    for gpu_id in range(3):
        lines.append(f"run_gpu{gpu_id} & PID{gpu_id}=$!")
    for gpu_id in range(3):
        lines.append(f"wait $PID{gpu_id} && echo 'GPU{gpu_id} finished' || echo 'GPU{gpu_id} FAILED'")
    lines.append('echo "=== abi: all done $(date) ==="')
    with open(out_path, "w") as f:
        f.write("\n".join(lines) + "\n")


def main(wave_tag="", exclude_path=None):
    suffix = f"_{wave_tag}" if wave_tag else ""
    df = load_points(exclude_path=exclude_path)
    df, finish = assign_streams(df)

    os.makedirs(SCRIPT_DIR, exist_ok=True)
    manifest_path = os.path.join(SCRIPT_DIR, f"suspectfix{suffix}_manifest.csv")
    df.to_csv(manifest_path, index=False)

    print(f"Total suspect points scheduled: {len(df)}")
    print(f"By tier: {df['tier'].value_counts().to_dict()}")
    print("\nEstimated finish time per stream (hours):")
    for name, cls, wdir, gpu in STREAMS:
        print(f"  {name:6s} ({cls:6s}): {finish[name]/3600:.1f}h  -- {sum(df['stream']==name)} runs")
    print(f"\nMakespan (max over streams): {max(finish.values())/3600:.1f}h = {max(finish.values())/3600/24:.2f} days")

    single_gpu_names = [name for name, cls, wdir, gpu in STREAMS if gpu is None]
    for name, cls, wdir, gpu in STREAMS:
        if gpu is None:
            pts = df[df["stream"] == name]
            emit_single_gpu_script(name, wdir, pts, os.path.join(SCRIPT_DIR, f"suspectfix{suffix}_{name}.sh"))

    abi_gpu_points = [df[df["stream"] == f"abi{g}"] for g in range(3)]
    emit_abi_script(abi_gpu_points, os.path.join(SCRIPT_DIR, f"suspectfix{suffix}_abi.sh"))

    print(f"\nWritten: scripts/suspectfix{suffix}_{{{','.join(single_gpu_names)},abi}}.sh")
    print(f"Manifest: {manifest_path}")
    return manifest_path


if __name__ == "__main__":
    wave_tag = sys.argv[1] if len(sys.argv) > 1 else ""
    exclude_path = sys.argv[2] if len(sys.argv) > 2 else None
    main(wave_tag, exclude_path)
