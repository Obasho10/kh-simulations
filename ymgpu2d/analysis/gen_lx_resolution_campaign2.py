#!/usr/bin/env python3
"""
Wave 2 of the Lx-resolution campaign (LX_RESOLUTION_PLAN.md follow-ups,
2026-07-21 second pass): 18 runs across the 5 GPUs confirmed fully idle
(t133, t140, abi x3) -- t126/t132 have logged-in humans (excluded), t130 is
busy, t139 unreachable.

  A. Phase 1b REDO (2 runs): the first attempt reused xi_sponge=55 unchanged
     at Lx=2pi and Lx=6pi, not realizing 55 exceeds 2pi's own xi-budget
     (20.9), so the sponge was inescapably inactive there -- not a valid
     box-size test. find_safe_sponge.py (with the new Lx kwarg) gives the
     TRUE minimal safe sponge for this point at Lx=2pi: sp=22 -- which
     itself needs 3.3 phys units, still bigger than 2pi's 3.14, i.e. this
     point genuinely needs 3pi not 2pi. Redo as Lx=3pi vs Lx=6pi, same
     valid xi_sponge=22 in both, to isolate box-size alone.

  C. Phase 3c (6 runs): narrow EPS=0.12, wide EPS=0.30 (existing box-doubling
     convention), and kz=13 near the filter-band edge (kz_suppress_hi=14) --
     each at production grid vs a refined grid.

  D. Broader alpha>=6 courant sweep (10 runs): 5 NEW dropped points from
     epsscan_v2_manifest.csv (not already tested in wave 1), each at
     production courant=0.1 vs finer courant=0.02, to extend the wave-1
     finding that catastrophe onset time roughly doubles with finer courant.

Output: scripts/lx_resolution2_{t133,t140,abi}.sh, sweep/lx_resolution2_manifest.csv
"""
import math
import os

from lx_policy import nx_for_lx

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..'))
SCRIPT_DIR = os.path.join(ROOT, 'scripts')
SWEEP_DIR = os.path.join(ROOT, 'sweep')

PI = math.pi

STREAMS = [
    ("t133", "/DATA/ym_kh/ymgpu2d", None),
    ("t140", "/DATA/cm/lcpfct/ymgpu2d", None),
    ("abi",  "/DATA/s23103/lcpfct/ymgpu2d", 0),
    ("abi",  "/DATA/s23103/lcpfct/ymgpu2d", 1),
    ("abi",  "/DATA/s23103/lcpfct/ymgpu2d", 2),
]

COMMON = dict(perturb_amp=0.001, run_mode=6, sigma_sponge=5.0, suppress_kz0=1,
              hyp_diff="5e-5", kz_suppress_hi=14)


def r(tag, phase, ini, note=""):
    d = dict(COMMON)
    d.update(ini)
    return dict(tag=tag, phase=phase, ini=d, note=note)


RUNS = []

# ── A. Phase 1b redo: Lx=3pi vs Lx=6pi, same PROPERLY-derived xi_sponge=22 ──
redo_1b = dict(k_mode=3, alpha_YM=1.1, V0=0.03, xi_sponge=22.0, kz_suppress_max=2,
                eps_override=0.15, nz_override=64, courant_override=0.1,
                target_tu=50.0)
RUNS.append(r("lx1bredo_3pi", "1b_redo",
              dict(redo_1b, lx_override=3 * PI, nx_override=nx_for_lx(3 * PI)),
              "properly-fitting sponge (find_safe_sponge, Lx kwarg) -- smallest tier that fits"))
RUNS.append(r("lx1bredo_6pi", "1b_redo",
              dict(redo_1b, lx_override=6 * PI, nx_override=768),
              "same valid sponge, wider box -- isolates box-size alone"))

# ── C. Phase 3c: narrow EPS, wide EPS, kz near filter-band edge ──
narrow = dict(k_mode=1, alpha_YM=1.0, V0=0.05, xi_sponge=10.0, kz_suppress_max=0,
              eps_override=0.12, target_tu=100.0)
nx_narrow = nx_for_lx(6 * PI, target_dx=0.12 / 6.0)  # EPS/DX>=6 boost, Lx unchanged
RUNS.append(r("lx3c_narrow_base", "3c",
              dict(narrow, nz_override=64, nx_override=nx_narrow, courant_override=0.1),
              f"narrow EPS=0.12 production grid (NX={nx_narrow} per EPS/DX>=6 rule)"))
RUNS.append(r("lx3c_narrow_fine", "3c",
              dict(narrow, nz_override=64, nx_override=int(nx_narrow * 1.4 // 64 * 64),
                   courant_override=0.05),
              "narrow EPS=0.12, further NX + finer courant combined"))

wide = dict(k_mode=1, alpha_YM=1.0, V0=0.05, xi_sponge=10.0, kz_suppress_max=0,
            eps_override=0.30, lx_override=12 * PI, nx_override=1536,
            target_tu=100.0)
RUNS.append(r("lx3c_wide_base", "3c", dict(wide, nz_override=64, courant_override=0.1),
              "wide EPS=0.30 production grid (existing box-doubling convention)"))
RUNS.append(r("lx3c_wide_fine", "3c", dict(wide, nz_override=64, courant_override=0.02),
              "wide EPS=0.30, finer courant"))

edge = dict(k_mode=13, alpha_YM=1.0, V0=0.05, xi_sponge=10.0, kz_suppress_max=12,
            eps_override=0.15, nx_override=768, target_tu=50.0)
RUNS.append(r("lx3c_edge_base", "3c", dict(edge, nz_override=64, courant_override=0.1),
              "kz=13 near filter-band edge (kz_suppress_hi=14), production grid"))
RUNS.append(r("lx3c_edge_fine", "3c", dict(edge, nz_override=128, courant_override=0.1),
              "kz=13 near filter-band edge, NZ refined (Filter Nyquist Rule concern)"))

# ── D. Broader alpha>=6 courant sweep: 5 new dropped points ──
d_points = [
    ("d1", dict(k_mode=4, alpha_YM=6.0, V0=0.10, xi_cut=5.0, kz_suppress_max=3),
     "alpha=6,V0=0.10,kz=4 (extends wave-1 kz=5,6 down)"),
    ("d2", dict(k_mode=7, alpha_YM=6.0, V0=0.10, xi_cut=5.0, kz_suppress_max=6),
     "alpha=6,V0=0.10,kz=7 (extends wave-1 kz=5,6 up)"),
    ("d3", dict(k_mode=8, alpha_YM=6.0, V0=0.10, xi_cut=5.0, kz_suppress_max=7),
     "alpha=6,V0=0.10,kz=8"),
    ("d4", dict(k_mode=8, alpha_YM=6.0, V0=0.05, xi_sponge=52.0, kz_suppress_max=7),
     "alpha=6,V0=0.05,kz=8 -- sponge mechanism (V0<=0.07), not xi_cut"),
    ("d5", dict(k_mode=8, alpha_YM=10.0, V0=0.10, xi_cut=5.0, kz_suppress_max=7),
     "alpha=10,V0=0.10,kz=8 -- hardest combo, xi_cut mechanism"),
]
for pid, base, note in d_points:
    common_d = dict(base, eps_override=0.10, nx_override=1152, target_tu=65.0)
    RUNS.append(r(f"lx3b2_{pid}_prod", "3b_wave2",
                  dict(common_d, nz_override=64, courant_override=0.1),
                  f"{note} -- production courant"))
    RUNS.append(r(f"lx3b2_{pid}_fine", "3b_wave2",
                  dict(common_d, nz_override=64, courant_override=0.02),
                  f"{note} -- finer courant (does onset time move again?)"))


def ini_lines(ini):
    order = ["k_mode", "alpha_YM", "V0", "perturb_amp", "run_mode", "xi_sponge",
             "xi_cut", "sigma_sponge", "suppress_kz0", "hyp_diff", "kz_suppress_max",
             "eps_override", "kz_suppress_hi", "nz_override", "nx_override",
             "lx_override", "courant_override", "target_tu"]
    return [f"{k} = {ini[k]}" for k in order if k in ini]


def write_run_block(run, wdir, log_var, out):
    tag, ini = run["tag"], dict(run["ini"])
    k, a = ini["k_mode"], ini["alpha_YM"]
    ini_path = f"/tmp/{tag}.ini"
    out.append(f"    # [{run['phase']}] {tag}: {run['note']}")
    out.append(f"    cat > {ini_path} <<'EOINI'")
    out.extend("    " + ln for ln in ini_lines(ini))
    out.append(f"    run_tag = {tag}")
    out.append("EOINI")
    out.append(f"    rm -rf {wdir}/outputs/ym_k{k}_a{a}*{tag}*")
    out.append(f'    echo "[{tag}] start $(date +%s) $(date)" >> {log_var}')
    out.append("    _T0=$(date +%s)")
    out.append(f"    (cd {wdir}/outputs && {wdir}/ym_coupled {ini_path} >> {log_var} 2>&1) "
                f'|| echo "[{tag}] CRASHED (exit $?) $(date)" >> {log_var}')
    out.append("    _T1=$(date +%s)")
    out.append(f'    echo "[{tag}] done elapsed=$((_T1-_T0))s $(date)" >> {log_var}')
    out.append(f"    (cd {wdir}/outputs && python3 ../analysis/remote_timeseries.py "
                f'"ym_k{k}_a{a}*{tag}*" >> {log_var} 2>&1)')
    out.append("")


def generate():
    os.makedirs(SCRIPT_DIR, exist_ok=True)
    os.makedirs(SWEEP_DIR, exist_ok=True)

    stream_runs = [[] for _ in STREAMS]
    for i, run in enumerate(RUNS):
        stream_runs[i % len(STREAMS)].append(run)

    manifest_rows = []
    for si, (node, wdir, gpu) in enumerate(STREAMS):
        for run in stream_runs[si]:
            row = dict(run["ini"])
            row.update(tag=run["tag"], phase=run["phase"], node=node, gpu=gpu,
                       note=run["note"])
            manifest_rows.append(row)

    for si in (0, 1):  # t133, t140: single-GPU sequential scripts
        node, wdir, _ = STREAMS[si]
        out = ["#!/bin/bash",
               f"# Lx-resolution campaign wave 2 -- {node} stream",
               "# See ymgpu2d/LX_RESOLUTION_PLAN.md",
               "set -u",
               f"WDIR={wdir}",
               "mkdir -p $WDIR/logs $WDIR/outputs",
               f"LOG=$WDIR/logs/lx_resolution2_{node}_runs.log",
               ": > $LOG",
               f'echo "=== lx_resolution2 {node} start $(date) ===" >> $LOG',
               ""]
        for run in stream_runs[si]:
            write_run_block(run, wdir, "$LOG", out)
        out.append(f'echo "=== lx_resolution2 {node} ALL DONE $(date) ===" >> $LOG')
        path = os.path.join(SCRIPT_DIR, f"lx_resolution2_{node}.sh")
        with open(path, "w") as f:
            f.write("\n".join(out) + "\n")
        print(f"Written: {path} ({len(stream_runs[si])} runs)")

    # ---- abi: 3 parallel GPU streams ----
    node, wdir, _ = STREAMS[2]
    out = ["#!/bin/bash",
           "# Lx-resolution campaign wave 2 -- abi (3 GPUs)",
           "# See ymgpu2d/LX_RESOLUTION_PLAN.md",
           "set -u",
           f"WDIR={wdir}",
           "mkdir -p $WDIR/logs $WDIR/outputs",
           ""]
    for gpu_idx in range(3):
        si = 2 + gpu_idx
        out.append(f"run_gpu{gpu_idx}() {{")
        out.append(f"    export CUDA_VISIBLE_DEVICES={gpu_idx}")
        out.append(f"    local WDIR={wdir}")
        out.append(f"    local LOG=$WDIR/logs/lx_resolution2_abi_gpu{gpu_idx}.log")
        out.append("    : > $LOG")
        out.append(f'    echo "[GPU{gpu_idx}] start $(date)" >> $LOG')
        for run in stream_runs[si]:
            write_run_block(run, wdir, "$LOG", out)
        out.append(f'    echo "[GPU{gpu_idx}] ALL DONE $(date)" >> $LOG')
        out.append("}")
        out.append("")
    out += [
        'echo "=== lx_resolution2 abi: launching 3-GPU campaign $(date) ==="',
        "run_gpu0 &", "PID0=$!",
        "run_gpu1 &", "PID1=$!",
        "run_gpu2 &", "PID2=$!",
        "",
        "wait $PID0 && echo 'GPU0 finished' || echo 'GPU0 FAILED'",
        "wait $PID1 && echo 'GPU1 finished' || echo 'GPU1 FAILED'",
        "wait $PID2 && echo 'GPU2 finished' || echo 'GPU2 FAILED'",
        'echo "=== lx_resolution2 abi: all done $(date) ==="',
    ]
    path = os.path.join(SCRIPT_DIR, "lx_resolution2_abi.sh")
    with open(path, "w") as f:
        f.write("\n".join(out) + "\n")
    total_abi = sum(len(stream_runs[i]) for i in (2, 3, 4))
    print(f"Written: {path} ({total_abi} runs across 3 GPUs)")

    import csv
    manifest_path = os.path.join(SWEEP_DIR, "lx_resolution2_manifest.csv")
    all_keys = sorted(set(k for row in manifest_rows for k in row))
    with open(manifest_path, "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=all_keys)
        w.writeheader()
        for row in manifest_rows:
            w.writerow(row)
    print(f"Written: {manifest_path} ({len(manifest_rows)} total runs)")


if __name__ == "__main__":
    generate()
