#!/bin/bash
# Multi-GPU campaign launcher for abi (3× GTX 1080 Ti).
# Assigns one alpha-series to each GPU, runs them in parallel.
# Each GPU runs its kz sequence SEQUENTIALLY (one ym_coupled at a time).
# Log files: logs/gpu{0,1,2}_<tag>.log
#
# Usage: copy this, fill in GPU0/GPU1/GPU2 parameter blocks, run:
#   nohup bash run_multigpu_abi_<tag>.sh > logs/multigpu_<tag>.log 2>&1 &

set -e
mkdir -p logs

# ── GPU 0 ──────────────────────────────────────────────────────────────────
run_gpu0() {
    export CUDA_VISIBLE_DEVICES=0
    local ALPHA=1.0; local V0=0.05; local XI_SPONGE=20.0
    for k in 1 2 3 4; do
        local KZ_SUPP=$((k-1))
        cat > /tmp/gpu0_k${k}.ini <<EOF
k_mode = $k
alpha_YM = $ALPHA
V0 = $V0
perturb_amp = 0.001
run_mode = 6
xi_sponge = $XI_SPONGE
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = $KZ_SUPP
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOF
        echo "[GPU0] kz=${k} start $(date)" >> logs/gpu0_run.log
        ./ym_coupled /tmp/gpu0_k${k}.ini >> logs/gpu0_run.log 2>&1
        echo "[GPU0] kz=${k} done $(date)" >> logs/gpu0_run.log
    done
}

# ── GPU 1 ──────────────────────────────────────────────────────────────────
run_gpu1() {
    export CUDA_VISIBLE_DEVICES=1
    local ALPHA=2.0; local V0=0.05; local XI_SPONGE=11.0
    for k in 1 2 3 4 5; do
        local KZ_SUPP=$((k-1))
        cat > /tmp/gpu1_k${k}.ini <<EOF
k_mode = $k
alpha_YM = $ALPHA
V0 = $V0
perturb_amp = 0.001
run_mode = 6
xi_sponge = $XI_SPONGE
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = $KZ_SUPP
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOF
        echo "[GPU1] kz=${k} start $(date)" >> logs/gpu1_run.log
        ./ym_coupled /tmp/gpu1_k${k}.ini >> logs/gpu1_run.log 2>&1
        echo "[GPU1] kz=${k} done $(date)" >> logs/gpu1_run.log
    done
}

# ── GPU 2 ──────────────────────────────────────────────────────────────────
run_gpu2() {
    export CUDA_VISIBLE_DEVICES=2
    local ALPHA=3.0; local V0=0.05; local XI_SPONGE=8.0
    for k in 1 2 3 4 5 6; do
        local KZ_SUPP=$((k-1))
        cat > /tmp/gpu2_k${k}.ini <<EOF
k_mode = $k
alpha_YM = $ALPHA
V0 = $V0
perturb_amp = 0.001
run_mode = 6
xi_sponge = $XI_SPONGE
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = $KZ_SUPP
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOF
        echo "[GPU2] kz=${k} start $(date)" >> logs/gpu2_run.log
        ./ym_coupled /tmp/gpu2_k${k}.ini >> logs/gpu2_run.log 2>&1
        echo "[GPU2] kz=${k} done $(date)" >> logs/gpu2_run.log
    done
}

# ── Launch all three in parallel, wait for all ─────────────────────────────
echo "=== Launching 3-GPU campaign at $(date) ==="
run_gpu0 &
PID0=$!
run_gpu1 &
PID1=$!
run_gpu2 &
PID2=$!

wait $PID0 && echo "GPU0 finished" || echo "GPU0 FAILED"
wait $PID1 && echo "GPU1 finished" || echo "GPU1 FAILED"
wait $PID2 && echo "GPU2 finished" || echo "GPU2 FAILED"
echo "=== All done at $(date) ==="
