"""
Generate a multi-GPU abi campaign script for all unexplored (alpha, V0, kz) points.

Usage:
  python3 analysis/gen_multigpu_campaign.py [wave_tag] [V0_filter] [--half-kz]

  wave_tag  : label appended to script name (default: "next")
  V0_filter : only generate for this V0 value, e.g. 0.05 (default: all)
  --half-kz : fill half-integer kz (0.5, 1.5, ... 7.5) using Lz=4pi, NZ=128
              instead of integer kz (1..8) using default Lz=2pi, NZ=64

Output: scripts/run_multigpu_abi_{wave_tag}.sh  (ready to scp + launch on abi)
"""

import numpy as np, os, sys, math
from collections import defaultdict

SWEEP_DIR = "sweep"
SCRIPT_DIR = "scripts"
V0_FILES = [
    (0.05, "v0p05"),
    (0.10, "v0p1"),
    (0.03, "v0p03"),
    (0.20, "v0p2"),
    (0.01, "v0p01"),
]
MAX_KZ_INT  = 8      # integer kz: 1..8  (Lz=2pi)
MAX_KZ_HALF = 7.5    # half-int kz: 0.5..7.5 (Lz=4pi, k_mode=1,3,5,...,15)
N_GPU = 3
LZ_4PI = 4 * math.pi   # 12.566370614359172
NZ_4PI = 128            # keep DZ ≈ 0.098


def xi_sponge_for(alpha, V0, kz_phys):
    """Reliable sponge radius: just beyond ξ_crit of kz_peak ≈ 2α."""
    kz_peak_est = max(0.5, round(2 * alpha) * 1.0)
    xi_crit = kz_peak_est / (alpha * V0)
    return max(5, min(55, int(xi_crit * 1.3)))


def missing_combos_int(V0_filter=None):
    """Return (alpha, V0, [kz_int_list]) for unfilled integer kz=1..MAX_KZ_INT."""
    combos = []
    files = [(v, t) for v, t in V0_FILES if V0_filter is None or abs(v - V0_filter) < 1e-9]
    for V0, tag in files:
        path = os.path.join(SWEEP_DIR, f"{tag}.npz")
        if not os.path.exists(path):
            continue
        d = dict(np.load(path))
        alphas = d['alpha_vals']
        kzs = d['kz_vals']
        kz_idx = {k: np.argmin(np.abs(kzs - k)) for k in range(1, MAX_KZ_INT + 1)}
        for ia, alpha in enumerate(alphas):
            missing_kz = [k for k, ik in kz_idx.items()
                          if not np.isfinite(d['gamma_sim'][ia, ik])]
            if missing_kz:
                combos.append((round(float(alpha), 1), V0, missing_kz))
    return combos


def missing_combos_half(V0_filter=None):
    """Return (alpha, V0, [kz_half_list]) for unfilled half-integer kz=0.5,1.5,...7.5."""
    half_kzs = [k * 0.5 for k in range(1, 16, 2)]  # 0.5, 1.5, ..., 7.5
    combos = []
    files = [(v, t) for v, t in V0_FILES if V0_filter is None or abs(v - V0_filter) < 1e-9]
    for V0, tag in files:
        path = os.path.join(SWEEP_DIR, f"{tag}.npz")
        if not os.path.exists(path):
            continue
        d = dict(np.load(path))
        alphas = d['alpha_vals']
        kzs = d['kz_vals']
        kz_idx = {kz: np.argmin(np.abs(kzs - kz)) for kz in half_kzs}
        for ia, alpha in enumerate(alphas):
            missing_kz = [kz for kz, ik in kz_idx.items()
                          if not np.isfinite(d['gamma_sim'][ia, ik])]
            if missing_kz:
                combos.append((round(float(alpha), 1), V0, sorted(missing_kz)))
    return combos


def int_kz_complete():
    """Return True if all integer kz=1..8 are filled for all (alpha, V0)."""
    return len(missing_combos_int()) == 0


def write_gpu_block_int(gpu_id, combos, out):
    """GPU block for integer kz runs (default Lz=2pi, NZ=64)."""
    out.append(f"run_gpu{gpu_id}() {{")
    out.append(f"    export CUDA_VISIBLE_DEVICES={gpu_id}")
    out.append(f"    local LOG=logs/gpu{gpu_id}_${{TAG}}.log")
    out.append(f"    echo \"[GPU{gpu_id}] start $(date)\" >> $LOG")
    out.append(f"    local WDIR=/DATA/s23103/lcpfct/ymgpu2d")

    for alpha, V0, kz_list in combos:
        xi = xi_sponge_for(alpha, V0, max(kz_list))
        out.append(f"")
        out.append(f"    # α={alpha} V0={V0}")
        for k in kz_list:
            kz_supp = k - 1
            ini = f"/tmp/g{gpu_id}_a{alpha}_v{V0}_k{k}.ini"
            out.append(f"    cat > {ini} <<'EOINI'")
            out.append(f"k_mode = {k}")
            out.append(f"alpha_YM = {alpha}")
            out.append(f"V0 = {V0}")
            out.append(f"perturb_amp = 0.001")
            out.append(f"run_mode = 6")
            out.append(f"xi_sponge = {xi}.0")
            out.append(f"sigma_sponge = 5.0")
            out.append(f"suppress_kz0 = 1")
            out.append(f"hyp_diff = 5e-5")
            out.append(f"kz_suppress_max = {kz_supp}")
            out.append(f"eps_override = 0.15")
            out.append(f"kz_suppress_hi = 14")
            out.append(f"target_tu = 100")
            out.append(f"EOINI")
            out.append(f"    echo \"[GPU{gpu_id}] a={alpha} V0={V0} kz={k} start $(date)\" >> $LOG")
            out.append(f"    cd $WDIR/outputs && $WDIR/ym_coupled {ini} >> $LOG 2>&1")
            out.append(f"    echo \"[GPU{gpu_id}] a={alpha} V0={V0} kz={k} done $(date)\" >> $LOG")

    out.append(f"    echo \"[GPU{gpu_id}] ALL DONE $(date)\" >> $LOG")
    out.append(f"}}")
    out.append("")


def write_gpu_block_half(gpu_id, combos, out):
    """GPU block for half-integer kz runs (Lz=4pi, NZ=128).
    kz_physical = k_mode/2, so k_mode = int(2*kz_physical) (always odd).
    kz_suppress_max = k_mode - 1 (suppress simulation kz < k_mode).
    kz_suppress_hi  = 2*14 = 28 (suppress simulation kz > k_mode up to 28,
                                  equiv. physical kz > kz_phys up to 14).
    """
    out.append(f"run_gpu{gpu_id}() {{")
    out.append(f"    export CUDA_VISIBLE_DEVICES={gpu_id}")
    out.append(f"    local LOG=logs/gpu{gpu_id}_${{TAG}}.log")
    out.append(f"    echo \"[GPU{gpu_id}] start $(date)\" >> $LOG")
    out.append(f"    local WDIR=/DATA/s23103/lcpfct/ymgpu2d")

    for alpha, V0, kz_list in combos:
        out.append(f"")
        out.append(f"    # α={alpha} V0={V0} (Lz=4pi)")
        for kz_phys in kz_list:
            k_mode = int(round(2 * kz_phys))   # 1, 3, 5, 7, 9, 11, 13, 15
            kz_supp = k_mode - 1
            xi = xi_sponge_for(alpha, V0, kz_phys)
            ini = f"/tmp/g{gpu_id}_a{alpha}_v{V0}_kz{kz_phys}.ini"
            out.append(f"    cat > {ini} <<'EOINI'")
            out.append(f"k_mode = {k_mode}")
            out.append(f"alpha_YM = {alpha}")
            out.append(f"V0 = {V0}")
            out.append(f"perturb_amp = 0.001")
            out.append(f"run_mode = 6")
            out.append(f"xi_sponge = {xi}.0")
            out.append(f"sigma_sponge = 5.0")
            out.append(f"suppress_kz0 = 1")
            out.append(f"hyp_diff = 5e-5")
            out.append(f"kz_suppress_max = {kz_supp}")
            out.append(f"eps_override = 0.15")
            out.append(f"kz_suppress_hi = 28")
            out.append(f"target_tu = 100")
            out.append(f"lz_override = {LZ_4PI:.6f}")
            out.append(f"nz_override = {NZ_4PI}")
            out.append(f"EOINI")
            out.append(f"    echo \"[GPU{gpu_id}] a={alpha} V0={V0} kz_phys={kz_phys} k_mode={k_mode} start $(date)\" >> $LOG")
            out.append(f"    cd $WDIR/outputs && $WDIR/ym_coupled {ini} >> $LOG 2>&1")
            out.append(f"    echo \"[GPU{gpu_id}] a={alpha} V0={V0} kz_phys={kz_phys} done $(date)\" >> $LOG")

    out.append(f"    echo \"[GPU{gpu_id}] ALL DONE $(date)\" >> $LOG")
    out.append(f"}}")
    out.append("")


def generate(wave_tag="next", V0_filter=None, half_kz=False):
    os.makedirs(SCRIPT_DIR, exist_ok=True)

    if half_kz:
        combos = missing_combos_half(V0_filter)
        write_block = write_gpu_block_half
        mode_label = "half-integer kz (Lz=4pi, NZ=128)"
    else:
        combos = missing_combos_int(V0_filter)
        write_block = write_gpu_block_int
        mode_label = "integer kz (Lz=2pi, NZ=64)"

    if not combos:
        print(f"No missing combos found for {mode_label} — fully filled!")
        return None

    # Split combos round-robin across GPUs
    gpu_combos = [[] for _ in range(N_GPU)]
    for i, c in enumerate(combos):
        gpu_combos[i % N_GPU].append(c)

    total_runs = sum(len(kzl) for _, _, kzl in combos)
    print(f"Mode: {mode_label}")
    print(f"Missing: {len(combos)} (α,V0) combos, {total_runs} kz runs total")
    for i, gc in enumerate(gpu_combos):
        runs = sum(len(kzl) for _, _, kzl in gc)
        print(f"  GPU{i}: {len(gc)} combos, {runs} runs")

    out = ["#!/bin/bash",
           f"# Auto-generated multi-GPU campaign: {wave_tag}",
           f"# Mode: {mode_label}",
           f"# {len(combos)} (α,V0) combos, {total_runs} kz runs across 3 GPUs",
           f"# Launch: nohup bash scripts/run_multigpu_abi_{wave_tag}.sh > logs/{wave_tag}.log 2>&1 &",
           "",
           "set -e",
           "mkdir -p logs",
           f'TAG="{wave_tag}"',
           ""]

    for gpu_id, gc in enumerate(gpu_combos):
        write_block(gpu_id, gc, out)

    out += [
        "# ── Launch all 3 GPUs in parallel ──────────────────────────────────────",
        f'echo "=== {wave_tag}: launching 3-GPU campaign $(date) ==="',
        "run_gpu0 &",
        "PID0=$!",
        "run_gpu1 &",
        "PID1=$!",
        "run_gpu2 &",
        "PID2=$!",
        "",
        "wait $PID0 && echo 'GPU0 finished' || echo 'GPU0 FAILED'",
        "wait $PID1 && echo 'GPU1 finished' || echo 'GPU1 FAILED'",
        "wait $PID2 && echo 'GPU2 finished' || echo 'GPU2 FAILED'",
        f'echo "=== {wave_tag}: all done $(date) ==="',
    ]

    script_path = os.path.join(SCRIPT_DIR, f"run_multigpu_abi_{wave_tag}.sh")
    with open(script_path, "w") as f:
        f.write("\n".join(out) + "\n")
    print(f"Written: {script_path}")
    return script_path


if __name__ == "__main__":
    args = sys.argv[1:]
    half_kz = "--half-kz" in args
    args = [a for a in args if a != "--half-kz"]
    wave_tag = args[0] if len(args) > 0 else "next"
    V0_filter = float(args[1]) if len(args) > 1 else None
    generate(wave_tag, V0_filter, half_kz=half_kz)
