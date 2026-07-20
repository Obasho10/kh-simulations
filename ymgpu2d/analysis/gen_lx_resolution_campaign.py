#!/usr/bin/env python3
"""
Generate the Lx-reduction + extreme-parameter resolution campaign
(LX_RESOLUTION_PLAN.md Phases 1 and 3), launched only on the two nodes
confirmed fully idle on 2026-07-21 (no logged-in humans, GPU util 0%):
t133 (1x RTX A5000) and abi (3x GTX 1080 Ti).

Mirrors the existing conventions:
  - per-run ini template + crash-tolerant "|| echo CRASHED" (t2p8_resolution_t133.sh)
  - per-GPU bash function with CUDA_VISIBLE_DEVICES (gen_multigpu_campaign.py)
  - wall-clock timing captured around every run (needed for Phase 1c's "measure,
    don't extrapolate" 3x-speedup check)

17 runs total, round-robined across 4 streams: t133, abi-gpu0, abi-gpu1, abi-gpu2.

Output: scripts/lx_resolution_t133.sh, scripts/lx_resolution_abi.sh,
        sweep/lx_resolution_manifest.csv
Launch: ssh -f <node> "cd <wdir> && nohup bash scripts/lx_resolution_<node>.sh > logs/lx_resolution_<node>.log 2>&1 &"
"""
import math
import os

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..'))
SCRIPT_DIR = os.path.join(ROOT, 'scripts')
SWEEP_DIR = os.path.join(ROOT, 'sweep')

PI = math.pi

STREAMS = [
    ("t133", "/DATA/ym_kh/ymgpu2d", None),
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

# ── Phase 1a: Lx box axis at the original resolution-study reference anchor
#    (alpha=1.0, V0=0.05, kz=1, xi_sponge=10, target_tu=25, NZ=256, courant=0.01
#    -- identical to RESOLUTION_FINDINGS.md's res_baseline, so directly comparable) ──
anchor_1a = dict(k_mode=1, alpha_YM=1.0, V0=0.05, xi_sponge=10.0, kz_suppress_max=0,
                  eps_override=0.15, nz_override=256, courant_override=0.01,
                  target_tu=25.0)
for tag, lx, nx in [("lx1a_2pi", 2 * PI, 256), ("lx1a_3pi", 3 * PI, 384),
                    ("lx1a_4pi", 4 * PI, 512)]:
    ini = dict(anchor_1a, lx_override=lx, nx_override=nx)
    RUNS.append(r(tag, "1a", ini, "box axis @ reference anchor, DX held fixed"))

# ── Phase 1b: stress-test the predicted failure corner. alpha=1.1, V0=0.03, kz=3
#    hits the blind sponge formula's SP_MAX=55 ceiling (real historical value,
#    from sweep/all_points_vs_chased.npz) -- deliberately reused unchanged at
#    both box widths to see the box-too-small failure mode directly. ──
corner_1b = dict(k_mode=3, alpha_YM=1.1, V0=0.03, xi_sponge=55.0, kz_suppress_max=2,
                   eps_override=0.15, nz_override=64, courant_override=0.1,
                   target_tu=50.0)
RUNS.append(r("lx1b_6pi", "1b", dict(corner_1b, lx_override=6 * PI, nx_override=768),
              "known-safe box (existing convention)"))
RUNS.append(r("lx1b_2pi", "1b", dict(corner_1b, lx_override=2 * PI, nx_override=256),
              "predicted-unsafe box, same xi_sponge NOT re-derived"))

# ── Phase 1c: the actual "free 3x" answer -- production-realistic point at
#    production grid (NZ=64, courant=0.1), Lx=6pi vs Lx=2pi at matched DX,
#    target_tu=100 (not the short 25TU convergence window). Wall-clock timed. ──
speed_1c = dict(k_mode=1, alpha_YM=1.0, V0=0.05, xi_sponge=10.0, kz_suppress_max=0,
                  eps_override=0.15, nz_override=64, courant_override=0.1,
                  target_tu=100.0)
RUNS.append(r("lx1c_6pi", "1c", dict(speed_1c, lx_override=6 * PI, nx_override=768),
              "current default -- wall-clock baseline"))
RUNS.append(r("lx1c_2pi", "1c", dict(speed_1c, lx_override=2 * PI, nx_override=256),
              "3x-cheaper candidate -- wall-clock + gamma agreement"))

# ── Phase 3a: close out T2.8's HIGH corner (alpha=3, V0=0.10, kz=5) definitively.
#    Exact recipe replicated from scripts/t2p8_resolution_t133.sh on t133 (xi_sponge=8,
#    kz_suppress_max=4, target_tu=100) -- REFEREE_PROOFING_RESULTS.md never combined
#    NX=1152 and courant<=0.05 in one run. ──
t28_high = dict(k_mode=5, alpha_YM=3.0, V0=0.10, xi_sponge=8.0, kz_suppress_max=4,
                  eps_override=0.15, target_tu=100.0)
RUNS.append(r("lx3a_combined", "3a",
              dict(t28_high, nz_override=64, nx_override=1152, courant_override=0.05),
              "NX=1152 + courant=0.05 simultaneously (plan-specified definitive rerun)"))
RUNS.append(r("lx3a_fullcombined", "3a",
              dict(t28_high, nz_override=128, nx_override=1152, courant_override=0.05),
              "all three refined axes together -- true finest-grid ceiling"))
RUNS.append(r("lx3a_kz6ext", "3a",
              dict(t28_high, k_mode=6, kz_suppress_max=5,
                   nz_override=64, nx_override=768, courant_override=0.1),
              "extend corner: does the gap grow past kz=5? (production grid)"))
RUNS.append(r("lx3a_kz7ext", "3a",
              dict(t28_high, k_mode=7, kz_suppress_max=6,
                   nz_override=64, nx_override=768, courant_override=0.1),
              "extend corner further: kz=7 (production grid)"))

# ── Phase 3b: is the alpha>=6 early-catastrophe onset (EPS-scan v2, FINDINGS.md)
#    resolution-independent? 3 real dropped points from epsscan_v2_manifest.csv,
#    each at (i) production grid and (ii) finer grid. EPS=0.10 for all three means
#    the narrow-EPS NX boost (EPS/DX>=6) already requires NX=1152 even at "production"
#    grid -- so the two variants differ only in courant, which is still the
#    plan-specified comparison. target_tu=65 matches XI_CUT_TU_CAP (FINDINGS.md
#    2026-07-15: catastrophe onset not observed before t~90 in any tested point). ──
b_points = [
    ("b1", dict(k_mode=5, alpha_YM=6.0, V0=0.10, xi_cut=5.0, kz_suppress_max=4),
     "V0=0.10 >= hard-wall threshold -> xi_cut mechanism"),
    ("b2", dict(k_mode=6, alpha_YM=6.0, V0=0.10, xi_cut=5.0, kz_suppress_max=5),
     "V0=0.10 >= hard-wall threshold -> xi_cut mechanism"),
    ("b3", dict(k_mode=8, alpha_YM=10.0, V0=0.05, xi_sponge=52.0, kz_suppress_max=7,
                sigma_sponge=5.0),
     "V0=0.05 <= 0.07 -> sponge mechanism, sp from blind formula ceiling-ish"),
]
for pid, base, note in b_points:
    common_b = dict(base, eps_override=0.10, nx_override=1152, target_tu=65.0)
    RUNS.append(r(f"lx3b_{pid}_prod", "3b",
                  dict(common_b, nz_override=64, courant_override=0.1),
                  f"{note} -- production grid baseline"))
    RUNS.append(r(f"lx3b_{pid}_fine", "3b",
                  dict(common_b, nz_override=64, courant_override=0.02),
                  f"{note} -- finer courant, same NX (already boosted for narrow EPS)"))


def ini_lines(ini):
    order = ["k_mode", "alpha_YM", "V0", "perturb_amp", "run_mode", "xi_sponge",
             "xi_cut", "sigma_sponge", "suppress_kz0", "hyp_diff", "kz_suppress_max",
             "eps_override", "kz_suppress_hi", "nz_override", "nx_override",
             "lx_override", "courant_override", "target_tu"]
    lines = []
    for k in order:
        if k in ini:
            v = ini[k]
            lines.append(f"{k} = {v}")
    return lines


def write_run_block(run, wdir, log_var, out):
    tag, ini = run["tag"], dict(run["ini"])
    ini["run_tag"] = tag
    k = ini["k_mode"]
    a = ini["alpha_YM"]
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

    # ---- t133: single GPU, sequential script (T2.8-style run list) ----
    node, wdir, _ = STREAMS[0]
    out = ["#!/bin/bash",
           "# Lx-reduction + extreme-parameter resolution campaign -- t133 stream",
           "# See ymgpu2d/LX_RESOLUTION_PLAN.md",
           "set -u",
           f"WDIR={wdir}",
           "mkdir -p $WDIR/logs $WDIR/outputs",
           "LOG=$WDIR/logs/lx_resolution_t133_runs.log",
           ": > $LOG",
           'echo "=== lx_resolution t133 start $(date) ===" >> $LOG',
           ""]
    for run in stream_runs[0]:
        write_run_block(run, wdir, "$LOG", out)
    out.append('echo "=== lx_resolution t133 ALL DONE $(date) ===" >> $LOG')
    path = os.path.join(SCRIPT_DIR, "lx_resolution_t133.sh")
    with open(path, "w") as f:
        f.write("\n".join(out) + "\n")
    print(f"Written: {path} ({len(stream_runs[0])} runs)")

    # ---- abi: 3 parallel GPU streams ----
    node, wdir, _ = STREAMS[1]
    out = ["#!/bin/bash",
           "# Lx-reduction + extreme-parameter resolution campaign -- abi (3 GPUs)",
           "# See ymgpu2d/LX_RESOLUTION_PLAN.md",
           "set -u",
           f"WDIR={wdir}",
           "mkdir -p $WDIR/logs $WDIR/outputs",
           ""]
    for gpu_idx in range(3):
        si = 1 + gpu_idx
        out.append(f"run_gpu{gpu_idx}() {{")
        out.append(f"    export CUDA_VISIBLE_DEVICES={gpu_idx}")
        out.append(f"    local WDIR={wdir}")
        out.append(f"    local LOG=$WDIR/logs/lx_resolution_abi_gpu{gpu_idx}.log")
        out.append("    : > $LOG")
        out.append(f'    echo "[GPU{gpu_idx}] start $(date)" >> $LOG')
        for run in stream_runs[si]:
            write_run_block(run, wdir, "$LOG", out)
        out.append(f'    echo "[GPU{gpu_idx}] ALL DONE $(date)" >> $LOG')
        out.append("}")
        out.append("")
    out += [
        'echo "=== lx_resolution abi: launching 3-GPU campaign $(date) ==="',
        "run_gpu0 &", "PID0=$!",
        "run_gpu1 &", "PID1=$!",
        "run_gpu2 &", "PID2=$!",
        "",
        "wait $PID0 && echo 'GPU0 finished' || echo 'GPU0 FAILED'",
        "wait $PID1 && echo 'GPU1 finished' || echo 'GPU1 FAILED'",
        "wait $PID2 && echo 'GPU2 finished' || echo 'GPU2 FAILED'",
        'echo "=== lx_resolution abi: all done $(date) ==="',
    ]
    path = os.path.join(SCRIPT_DIR, "lx_resolution_abi.sh")
    with open(path, "w") as f:
        f.write("\n".join(out) + "\n")
    total_abi = sum(len(stream_runs[i]) for i in (1, 2, 3))
    print(f"Written: {path} ({total_abi} runs across 3 GPUs)")

    import csv
    manifest_path = os.path.join(SWEEP_DIR, "lx_resolution_manifest.csv")
    all_keys = sorted(set(k for row in manifest_rows for k in row))
    with open(manifest_path, "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=all_keys)
        w.writeheader()
        for row in manifest_rows:
            w.writerow(row)
    print(f"Written: {manifest_path} ({len(manifest_rows)} total runs)")


if __name__ == "__main__":
    generate()
