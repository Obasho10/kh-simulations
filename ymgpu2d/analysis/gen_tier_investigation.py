#!/usr/bin/env python3
"""Diagnostic campaign to investigate the tier accuracy gap (int vs half/fine
kz grids) -- see memory project_tier_accuracy_gap.md.

Experiment A (cross-tier control): take 6 (alpha,V0,kz) anchors with INTEGER kz
that already have a clean, plateau-confirmed int-tier measurement, and rerun the
SAME physical kz forced onto the half-tier grid (Lz=4pi, k_mode=2*kz) and the
fine-tier grid (Lz=16pi, k_mode=8*kz). Isolates "is it the box/grid setup, or
something about fractional kz specifically" -- same physical wavenumber, same
xi_sponge (sponge selection doesn't depend on tier), only the grid changes.

Experiment B (resolution convergence): extends RESOLUTION_FINDINGS.md's method
(which only validated the default Lz=2pi/NZ=64 box) to the half and fine boxes.
  B-half: 3 existing bad half-tier points, rerun at 2x NZ (256 instead of 128,
    same Lz=4pi/courant/target_tu) -- does doubling resolution change gamma_sim?
  B-fine: 2 representative fine-tier points (zero existing data, tier hasn't run
    yet), run at BOTH production NZ=512 and 2x NZ=1024 to characterize from
    scratch.

All runs tagged run_tag=tierprobe_<label> so they're trivially excluded from the
main sweep-table fill pipeline (grep out 'tierprobe' before running
make_sweep_tables.py --fill on the results).
"""
import math

LZ_HALF, NZ_HALF = 4 * math.pi, 128
LZ_FINE, NZ_FINE = 16 * math.pi, 512

INI = """cat > {ini} <<'EOINI'
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
lz_override = {lz:.6f}
nz_override = {nz}
run_tag = tierprobe_{label}
EOINI
echo "[{stream}] {label} a={alpha} V0={V0} kz={kz} nz={nz} start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled {ini} >> $LOG 2>&1) || echo "[{stream}] {label} a={alpha} V0={V0} kz={kz} CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k{k_mode}_a{alpha:.3f}_*_v{V0:.4f}_*_tierprobe_{label}" >> ../logs/inline_extract.log 2>&1)
echo "[{stream}] {label} a={alpha} V0={V0} kz={kz} done $(date)" >> $LOG
"""

# ---- Experiment A anchors (integer kz, known-good int-tier baseline) ----
ANCHORS_A = [
    dict(alpha=1.9, V0=0.05, kz=8, xi_sponge=8),
    dict(alpha=1.5, V0=0.05, kz=8, xi_sponge=7),
    dict(alpha=1.5, V0=0.03, kz=7, xi_sponge=8),
    dict(alpha=1.7, V0=0.03, kz=8, xi_sponge=8),
    dict(alpha=0.6, V0=0.01, kz=4, xi_sponge=8),
    dict(alpha=0.4, V0=0.01, kz=2, xi_sponge=8),
]
TARGET_TU_A = 200

# ---- Experiment B-half: existing bad half-tier points, 2x resolution ----
B_HALF = [
    dict(alpha=0.6, V0=0.05, kz=0.5, xi_sponge=8, target_tu=100),
    dict(alpha=0.9, V0=0.03, kz=0.5, xi_sponge=8, target_tu=100),
    dict(alpha=1.1, V0=0.05, kz=1.5, xi_sponge=9, target_tu=100),
]

# ---- Experiment B-fine: fresh points, production (1x) and 2x resolution ----
B_FINE = [
    dict(alpha=2.6, V0=0.05, kz=0.625, xi_sponge=5, target_tu=100),
    dict(alpha=2.9, V0=0.05, kz=1.750, xi_sponge=6, target_tu=100),
]

jobs = []  # list of dict(label=..., **INI kwargs, cost=...)

SEC_PER_TU_A5000 = 0.87

for a in ANCHORS_A:
    k_mode_half = int(round(2 * a["kz"]))
    jobs.append(dict(label="A_half", k_mode=k_mode_half, alpha=a["alpha"], V0=a["V0"],
                      xi_sponge=a["xi_sponge"], kz_suppress_max=k_mode_half - 1, bp=28,
                      target_tu=TARGET_TU_A, lz=LZ_HALF, nz=NZ_HALF, kz=a["kz"],
                      cost=TARGET_TU_A * (NZ_HALF / 64) * SEC_PER_TU_A5000))
    k_mode_fine = int(round(8 * a["kz"]))
    jobs.append(dict(label="A_fine", k_mode=k_mode_fine, alpha=a["alpha"], V0=a["V0"],
                      xi_sponge=a["xi_sponge"], kz_suppress_max=k_mode_fine - 1, bp=55,
                      target_tu=TARGET_TU_A, lz=LZ_FINE, nz=NZ_FINE, kz=a["kz"],
                      cost=TARGET_TU_A * (NZ_FINE / 64) * SEC_PER_TU_A5000))

for b in B_HALF:
    k_mode = int(round(2 * b["kz"]))
    nz2x = NZ_HALF * 2
    jobs.append(dict(label="Bhalf_2x", k_mode=k_mode, alpha=b["alpha"], V0=b["V0"],
                      xi_sponge=b["xi_sponge"], kz_suppress_max=k_mode - 1, bp=28,
                      target_tu=b["target_tu"], lz=LZ_HALF, nz=nz2x, kz=b["kz"],
                      cost=b["target_tu"] * (nz2x / 64) * SEC_PER_TU_A5000))

for b in B_FINE:
    k_mode = int(round(8 * b["kz"]))
    for label, nz in [("Bfine_1x", NZ_FINE), ("Bfine_2x", NZ_FINE * 2)]:
        jobs.append(dict(label=label, k_mode=k_mode, alpha=b["alpha"], V0=b["V0"],
                          xi_sponge=b["xi_sponge"], kz_suppress_max=k_mode - 1, bp=55,
                          target_tu=b["target_tu"], lz=LZ_FINE, nz=nz, kz=b["kz"],
                          cost=b["target_tu"] * (nz / 64) * SEC_PER_TU_A5000))

print(f"Total jobs: {len(jobs)}  total cost (A5000-sec): {sum(j['cost'] for j in jobs):.0f}")

# ---- distribute round-robin-by-cost (LPT) across 7 streams ----
STREAMS = ["t126", "t133", "t140", "t132", "abi0", "abi1", "abi2"]
STREAM_INFO = {
    "t126": ("a5000", "/DATA/cm/lcpfct/ymgpu2d", None),
    "t133": ("a5000", "/DATA/ym_kh/ymgpu2d", None),
    "t140": ("a5000", "/DATA/cm/lcpfct/ymgpu2d", None),
    "t132": ("a5000", "/DATA/ym_kh", None),
    "abi0": ("1080ti", "/DATA/s23103/lcpfct/ymgpu2d", 0),
    "abi1": ("1080ti", "/DATA/s23103/lcpfct/ymgpu2d", 1),
    "abi2": ("1080ti", "/DATA/s23103/lcpfct/ymgpu2d", 2),
}
SPEED_RATIO_1080TI = 9200.0 / 4500.0  # 1080ti takes this many times longer per unit cost

finish = {s: 0.0 for s in STREAMS}
assign = {s: [] for s in STREAMS}
for j in sorted(jobs, key=lambda x: -x["cost"]):
    best, best_finish = None, None
    for s in STREAMS:
        cost = j["cost"] * (SPEED_RATIO_1080TI if STREAM_INFO[s][0] == "1080ti" else 1.0)
        cand = finish[s] + cost
        if best_finish is None or cand < best_finish:
            best, best_finish = s, cand
    cost = j["cost"] * (SPEED_RATIO_1080TI if STREAM_INFO[best][0] == "1080ti" else 1.0)
    finish[best] += cost
    assign[best].append(j)

for s in STREAMS:
    print(f"  {s}: {len(assign[s])} jobs, ~{finish[s]/60:.1f} min")

import os
SCRIPT_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "scripts")
os.makedirs(SCRIPT_DIR, exist_ok=True)


def emit_single(stream, wdir, jobs_list, path):
    lines = ["#!/bin/bash", f"# tier investigation -- {stream}: {len(jobs_list)} jobs",
             "set -e", f"WDIR={wdir}", "mkdir -p $WDIR/logs $WDIR/outputs",
             f"LOG=$WDIR/logs/tierprobe_{stream}_progress.log",
             'echo "=== start $(date) ===" >> $LOG']
    for j in jobs_list:
        ini = f"/tmp/tp_{stream}_{j['label']}_a{j['alpha']}_v{j['V0']}_kz{j['kz']}.ini"
        lines.append(INI.format(ini=ini, stream=stream, **j))
    lines.append(f'echo "=== {stream} ALL DONE $(date) ===" >> $LOG')
    with open(path, "w") as f:
        f.write("\n".join(lines) + "\n")


def emit_abi(gpu_jobs, path):
    lines = ["#!/bin/bash", "# tier investigation -- abi (3 GPUs)", "set -e",
              "WDIR=/DATA/s23103/lcpfct/ymgpu2d", "mkdir -p $WDIR/logs $WDIR/outputs", ""]
    for g in range(3):
        stream = f"abi{g}"
        lines.append(f"run_gpu{g}() {{")
        lines.append(f"    export CUDA_VISIBLE_DEVICES={g}")
        lines.append(f"    WDIR=/DATA/s23103/lcpfct/ymgpu2d")
        lines.append(f"    LOG=$WDIR/logs/tierprobe_{stream}_progress.log")
        lines.append(f'    echo "[GPU{g}] start $(date)" >> $LOG')
        for j in assign[stream]:
            ini = f"/tmp/tp_{stream}_{j['label']}_a{j['alpha']}_v{j['V0']}_kz{j['kz']}.ini"
            block = INI.format(ini=ini, stream=f"GPU{g}", **j)
            lines.extend(block.split("\n"))
        lines.append(f'    echo "[GPU{g}] ALL DONE $(date)" >> $LOG')
        lines.append("}")
        lines.append("")
    lines.append('echo "=== abi tierprobe launch $(date) ==="')
    for g in range(3):
        lines.append(f"run_gpu{g} & PID{g}=$!")
    for g in range(3):
        lines.append(f"wait $PID{g} && echo 'GPU{g} finished' || echo 'GPU{g} FAILED'")
    with open(path, "w") as f:
        f.write("\n".join(lines) + "\n")


for s in ["t126", "t140"]:
    emit_single(s, "/DATA/cm/lcpfct/ymgpu2d", assign[s], os.path.join(SCRIPT_DIR, f"tierprobe_{s}.sh"))
emit_single("t133", "/DATA/ym_kh/ymgpu2d", assign["t133"], os.path.join(SCRIPT_DIR, "tierprobe_t133.sh"))
emit_single("t132", "/DATA/ym_kh", assign["t132"], os.path.join(SCRIPT_DIR, "tierprobe_t132.sh"))
emit_abi(assign, os.path.join(SCRIPT_DIR, "tierprobe_abi.sh"))
print("\nWritten scripts/tierprobe_{t126,t130,t140,t132,abi}.sh")
