#!/bin/bash
# Auto-generated multi-GPU campaign: wave5_v0p1
# Mode: integer kz (Lz=2pi, NZ=64)
# 30 (α,V0) combos, 203 kz runs across 3 GPUs
# Launch: nohup bash scripts/run_multigpu_abi_wave5_v0p1.sh > logs/wave5_v0p1.log 2>&1 &

set -e
mkdir -p logs
TAG="wave5_v0p1"

run_gpu0() {
    export CUDA_VISIBLE_DEVICES=0
    local LOG=logs/gpu0_${TAG}.log
    echo "[GPU0] start $(date)" >> $LOG
    local WDIR=/DATA/s23103/lcpfct/ymgpu2d

    # α=0.1 V0=0.1
    cat > /tmp/g0_a0.1_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.1 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.1_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU0] a=0.1 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g0_a0.1_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.1 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.1_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU0] a=0.1 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g0_a0.1_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.1 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.1_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU0] a=0.1 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g0_a0.1_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.1 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.1_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU0] a=0.1 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g0_a0.1_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.1 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.1_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU0] a=0.1 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g0_a0.1_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.1 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.1_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU0] a=0.1 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g0_a0.1_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.1 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.1_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU0] a=0.1 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g0_a0.1_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.1 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.1_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU0] a=0.1 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=0.4 V0=0.1
    cat > /tmp/g0_a0.4_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.4 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.4_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU0] a=0.4 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g0_a0.4_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.4 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.4_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU0] a=0.4 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g0_a0.4_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.4 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.4_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU0] a=0.4 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g0_a0.4_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.4 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.4_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU0] a=0.4 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g0_a0.4_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.4 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.4_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU0] a=0.4 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g0_a0.4_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.4 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.4_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU0] a=0.4 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g0_a0.4_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.4 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.4_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU0] a=0.4 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g0_a0.4_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.4 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.4_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU0] a=0.4 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=0.7 V0=0.1
    cat > /tmp/g0_a0.7_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.7 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.7_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU0] a=0.7 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g0_a0.7_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.7 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.7_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU0] a=0.7 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g0_a0.7_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.7 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.7_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU0] a=0.7 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g0_a0.7_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.7 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.7_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU0] a=0.7 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g0_a0.7_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.7 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.7_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU0] a=0.7 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g0_a0.7_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.7 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.7_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU0] a=0.7 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g0_a0.7_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.7 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.7_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU0] a=0.7 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g0_a0.7_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=0.7 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a0.7_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU0] a=0.7 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=1.0 V0=0.1
    cat > /tmp/g0_a1.0_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.0 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.0_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU0] a=1.0 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g0_a1.0_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.0 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.0_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU0] a=1.0 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=1.3 V0=0.1
    cat > /tmp/g0_a1.3_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.3 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.3_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU0] a=1.3 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g0_a1.3_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.3 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.3_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU0] a=1.3 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g0_a1.3_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.3 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.3_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU0] a=1.3 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g0_a1.3_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.3 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.3_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU0] a=1.3 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g0_a1.3_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.3 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.3_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU0] a=1.3 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g0_a1.3_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.3 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.3_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU0] a=1.3 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g0_a1.3_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.3 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.3_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU0] a=1.3 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g0_a1.3_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.3 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.3_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU0] a=1.3 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=1.6 V0=0.1
    cat > /tmp/g0_a1.6_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.6 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.6_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU0] a=1.6 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g0_a1.6_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.6 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.6_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU0] a=1.6 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g0_a1.6_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.6 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.6_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU0] a=1.6 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g0_a1.6_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.6 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.6_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU0] a=1.6 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g0_a1.6_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.6 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.6_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU0] a=1.6 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g0_a1.6_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.6 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.6_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU0] a=1.6 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g0_a1.6_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.6 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.6_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU0] a=1.6 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g0_a1.6_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.6 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.6_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU0] a=1.6 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=1.9 V0=0.1
    cat > /tmp/g0_a1.9_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.9 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.9_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU0] a=1.9 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g0_a1.9_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.9 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.9_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU0] a=1.9 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g0_a1.9_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.9 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.9_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU0] a=1.9 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g0_a1.9_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.9 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.9_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU0] a=1.9 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g0_a1.9_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.9 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.9_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU0] a=1.9 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g0_a1.9_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.9 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.9_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU0] a=1.9 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g0_a1.9_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.9 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.9_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU0] a=1.9 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g0_a1.9_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=1.9 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a1.9_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU0] a=1.9 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=2.2 V0=0.1
    cat > /tmp/g0_a2.2_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=2.2 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a2.2_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU0] a=2.2 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g0_a2.2_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=2.2 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a2.2_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU0] a=2.2 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g0_a2.2_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=2.2 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a2.2_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU0] a=2.2 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g0_a2.2_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=2.2 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a2.2_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU0] a=2.2 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g0_a2.2_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=2.2 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a2.2_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU0] a=2.2 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g0_a2.2_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=2.2 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a2.2_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU0] a=2.2 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g0_a2.2_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=2.2 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a2.2_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU0] a=2.2 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g0_a2.2_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=2.2 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a2.2_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU0] a=2.2 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=2.5 V0=0.1
    cat > /tmp/g0_a2.5_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=2.5 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a2.5_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU0] a=2.5 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=2.8 V0=0.1
    cat > /tmp/g0_a2.8_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=2.8 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a2.8_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU0] a=2.8 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g0_a2.8_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=2.8 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a2.8_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU0] a=2.8 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g0_a2.8_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=2.8 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a2.8_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU0] a=2.8 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g0_a2.8_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=2.8 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a2.8_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU0] a=2.8 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g0_a2.8_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=2.8 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a2.8_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU0] a=2.8 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g0_a2.8_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=2.8 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a2.8_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU0] a=2.8 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g0_a2.8_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=2.8 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a2.8_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU0] a=2.8 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g0_a2.8_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU0] a=2.8 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g0_a2.8_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU0] a=2.8 V0=0.1 kz=8 done $(date)" >> $LOG
    echo "[GPU0] ALL DONE $(date)" >> $LOG
}

run_gpu1() {
    export CUDA_VISIBLE_DEVICES=1
    local LOG=logs/gpu1_${TAG}.log
    echo "[GPU1] start $(date)" >> $LOG
    local WDIR=/DATA/s23103/lcpfct/ymgpu2d

    # α=0.2 V0=0.1
    cat > /tmp/g1_a0.2_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=0.2 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a0.2_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU1] a=0.2 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g1_a0.2_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=0.2 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a0.2_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU1] a=0.2 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g1_a0.2_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=0.2 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a0.2_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU1] a=0.2 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g1_a0.2_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=0.2 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a0.2_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU1] a=0.2 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g1_a0.2_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=0.2 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a0.2_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU1] a=0.2 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g1_a0.2_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=0.2 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a0.2_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU1] a=0.2 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g1_a0.2_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=0.2 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a0.2_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU1] a=0.2 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g1_a0.2_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=0.2 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a0.2_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU1] a=0.2 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=0.5 V0=0.1
    cat > /tmp/g1_a0.5_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=0.5 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a0.5_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU1] a=0.5 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g1_a0.5_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=0.5 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a0.5_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU1] a=0.5 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=0.8 V0=0.1
    cat > /tmp/g1_a0.8_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=0.8 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a0.8_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU1] a=0.8 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g1_a0.8_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=0.8 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a0.8_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU1] a=0.8 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g1_a0.8_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=0.8 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a0.8_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU1] a=0.8 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g1_a0.8_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=0.8 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a0.8_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU1] a=0.8 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g1_a0.8_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=0.8 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a0.8_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU1] a=0.8 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g1_a0.8_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=0.8 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a0.8_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU1] a=0.8 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g1_a0.8_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=0.8 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a0.8_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU1] a=0.8 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g1_a0.8_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=0.8 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a0.8_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU1] a=0.8 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=1.1 V0=0.1
    cat > /tmp/g1_a1.1_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.1 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.1_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU1] a=1.1 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g1_a1.1_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.1 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.1_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU1] a=1.1 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g1_a1.1_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.1 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.1_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU1] a=1.1 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g1_a1.1_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.1 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.1_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU1] a=1.1 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g1_a1.1_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.1 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.1_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU1] a=1.1 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g1_a1.1_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.1 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.1_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU1] a=1.1 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g1_a1.1_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.1 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.1_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU1] a=1.1 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g1_a1.1_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.1 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.1_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU1] a=1.1 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=1.4 V0=0.1
    cat > /tmp/g1_a1.4_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.4 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.4_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU1] a=1.4 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g1_a1.4_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.4 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.4_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU1] a=1.4 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g1_a1.4_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.4 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.4_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU1] a=1.4 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g1_a1.4_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.4 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.4_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU1] a=1.4 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g1_a1.4_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.4 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.4_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU1] a=1.4 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g1_a1.4_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.4 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.4_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU1] a=1.4 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g1_a1.4_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.4 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.4_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU1] a=1.4 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g1_a1.4_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.4 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.4_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU1] a=1.4 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=1.7 V0=0.1
    cat > /tmp/g1_a1.7_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.7 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.7_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU1] a=1.7 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g1_a1.7_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.7 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.7_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU1] a=1.7 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g1_a1.7_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.7 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.7_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU1] a=1.7 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g1_a1.7_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.7 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.7_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU1] a=1.7 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g1_a1.7_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.7 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.7_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU1] a=1.7 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g1_a1.7_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.7 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.7_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU1] a=1.7 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g1_a1.7_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.7 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.7_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU1] a=1.7 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g1_a1.7_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=1.7 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a1.7_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU1] a=1.7 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=2.0 V0=0.1
    cat > /tmp/g1_a2.0_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.0 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.0_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU1] a=2.0 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g1_a2.0_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.0 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.0_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU1] a=2.0 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=2.3 V0=0.1
    cat > /tmp/g1_a2.3_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.3 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.3_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU1] a=2.3 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g1_a2.3_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.3 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.3_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU1] a=2.3 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g1_a2.3_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.3 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.3_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU1] a=2.3 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g1_a2.3_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.3 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.3_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU1] a=2.3 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g1_a2.3_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.3 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.3_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU1] a=2.3 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g1_a2.3_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.3 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.3_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU1] a=2.3 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g1_a2.3_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.3 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.3_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU1] a=2.3 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g1_a2.3_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.3 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.3_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU1] a=2.3 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=2.6 V0=0.1
    cat > /tmp/g1_a2.6_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.6 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.6_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU1] a=2.6 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g1_a2.6_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.6 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.6_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU1] a=2.6 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g1_a2.6_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.6 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.6_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU1] a=2.6 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g1_a2.6_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.6 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.6_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU1] a=2.6 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g1_a2.6_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.6 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.6_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU1] a=2.6 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g1_a2.6_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.6 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.6_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU1] a=2.6 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g1_a2.6_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.6 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.6_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU1] a=2.6 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g1_a2.6_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.6 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.6_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU1] a=2.6 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=2.9 V0=0.1
    cat > /tmp/g1_a2.9_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.9 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.9_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU1] a=2.9 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g1_a2.9_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.9 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.9_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU1] a=2.9 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g1_a2.9_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.9 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.9_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU1] a=2.9 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g1_a2.9_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.9 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.9_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU1] a=2.9 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g1_a2.9_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.9 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.9_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU1] a=2.9 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g1_a2.9_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.9 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.9_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU1] a=2.9 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g1_a2.9_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.9 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.9_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU1] a=2.9 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g1_a2.9_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU1] a=2.9 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g1_a2.9_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU1] a=2.9 V0=0.1 kz=8 done $(date)" >> $LOG
    echo "[GPU1] ALL DONE $(date)" >> $LOG
}

run_gpu2() {
    export CUDA_VISIBLE_DEVICES=2
    local LOG=logs/gpu2_${TAG}.log
    echo "[GPU2] start $(date)" >> $LOG
    local WDIR=/DATA/s23103/lcpfct/ymgpu2d

    # α=0.3 V0=0.1
    cat > /tmp/g2_a0.3_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.3 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.3_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU2] a=0.3 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g2_a0.3_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.3 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.3_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU2] a=0.3 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g2_a0.3_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.3 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.3_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU2] a=0.3 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g2_a0.3_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.3 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.3_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU2] a=0.3 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g2_a0.3_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.3 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.3_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU2] a=0.3 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g2_a0.3_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.3 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.3_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU2] a=0.3 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g2_a0.3_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.3 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.3_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU2] a=0.3 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g2_a0.3_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.3 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.3_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU2] a=0.3 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=0.6 V0=0.1
    cat > /tmp/g2_a0.6_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.6 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.6_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU2] a=0.6 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g2_a0.6_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.6 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.6_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU2] a=0.6 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g2_a0.6_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.6 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.6_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU2] a=0.6 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g2_a0.6_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.6 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.6_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU2] a=0.6 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g2_a0.6_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.6 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.6_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU2] a=0.6 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g2_a0.6_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.6 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.6_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU2] a=0.6 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g2_a0.6_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.6 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.6_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU2] a=0.6 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g2_a0.6_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.6 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.6_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU2] a=0.6 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=0.9 V0=0.1
    cat > /tmp/g2_a0.9_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.9 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.9_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU2] a=0.9 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g2_a0.9_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.9 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.9_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU2] a=0.9 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g2_a0.9_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.9 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.9_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU2] a=0.9 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g2_a0.9_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.9 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.9_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU2] a=0.9 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g2_a0.9_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.9 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.9_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU2] a=0.9 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g2_a0.9_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.9 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.9_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU2] a=0.9 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g2_a0.9_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.9 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.9_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU2] a=0.9 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g2_a0.9_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=0.9 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a0.9_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU2] a=0.9 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=1.2 V0=0.1
    cat > /tmp/g2_a1.2_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=1.2 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a1.2_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU2] a=1.2 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g2_a1.2_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=1.2 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a1.2_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU2] a=1.2 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g2_a1.2_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=1.2 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a1.2_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU2] a=1.2 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g2_a1.2_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=1.2 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a1.2_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU2] a=1.2 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g2_a1.2_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=1.2 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a1.2_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU2] a=1.2 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g2_a1.2_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=1.2 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a1.2_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU2] a=1.2 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g2_a1.2_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=1.2 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a1.2_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU2] a=1.2 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g2_a1.2_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=1.2 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a1.2_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU2] a=1.2 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=1.5 V0=0.1
    cat > /tmp/g2_a1.5_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=1.5 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a1.5_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU2] a=1.5 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g2_a1.5_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=1.5 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a1.5_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU2] a=1.5 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=1.8 V0=0.1
    cat > /tmp/g2_a1.8_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=1.8 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a1.8_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU2] a=1.8 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g2_a1.8_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=1.8 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a1.8_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU2] a=1.8 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g2_a1.8_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=1.8 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a1.8_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU2] a=1.8 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g2_a1.8_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=1.8 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a1.8_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU2] a=1.8 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g2_a1.8_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=1.8 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a1.8_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU2] a=1.8 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g2_a1.8_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=1.8 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a1.8_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU2] a=1.8 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g2_a1.8_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=1.8 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a1.8_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU2] a=1.8 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g2_a1.8_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=1.8 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a1.8_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU2] a=1.8 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=2.1 V0=0.1
    cat > /tmp/g2_a2.1_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.1 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.1_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU2] a=2.1 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g2_a2.1_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.1 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.1_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU2] a=2.1 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g2_a2.1_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.1 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.1_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU2] a=2.1 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g2_a2.1_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.1 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.1_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU2] a=2.1 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g2_a2.1_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.1 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.1_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU2] a=2.1 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g2_a2.1_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.1 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.1_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU2] a=2.1 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g2_a2.1_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.1 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.1_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU2] a=2.1 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g2_a2.1_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.1 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.1_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU2] a=2.1 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=2.4 V0=0.1
    cat > /tmp/g2_a2.4_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.4 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.4_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU2] a=2.4 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g2_a2.4_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.4 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.4_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU2] a=2.4 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g2_a2.4_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.4 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.4_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU2] a=2.4 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g2_a2.4_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.4 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.4_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU2] a=2.4 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g2_a2.4_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.4 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.4_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU2] a=2.4 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g2_a2.4_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.4 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.4_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU2] a=2.4 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g2_a2.4_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.4 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.4_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU2] a=2.4 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g2_a2.4_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.4 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.4_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU2] a=2.4 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=2.7 V0=0.1
    cat > /tmp/g2_a2.7_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.7 V0=0.1 kz=1 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.7_v0.1_k1.ini >> $LOG 2>&1
    echo "[GPU2] a=2.7 V0=0.1 kz=1 done $(date)" >> $LOG
    cat > /tmp/g2_a2.7_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.7 V0=0.1 kz=2 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.7_v0.1_k2.ini >> $LOG 2>&1
    echo "[GPU2] a=2.7 V0=0.1 kz=2 done $(date)" >> $LOG
    cat > /tmp/g2_a2.7_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.7 V0=0.1 kz=3 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.7_v0.1_k3.ini >> $LOG 2>&1
    echo "[GPU2] a=2.7 V0=0.1 kz=3 done $(date)" >> $LOG
    cat > /tmp/g2_a2.7_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.7 V0=0.1 kz=4 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.7_v0.1_k4.ini >> $LOG 2>&1
    echo "[GPU2] a=2.7 V0=0.1 kz=4 done $(date)" >> $LOG
    cat > /tmp/g2_a2.7_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.7 V0=0.1 kz=5 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.7_v0.1_k5.ini >> $LOG 2>&1
    echo "[GPU2] a=2.7 V0=0.1 kz=5 done $(date)" >> $LOG
    cat > /tmp/g2_a2.7_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.7 V0=0.1 kz=6 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.7_v0.1_k6.ini >> $LOG 2>&1
    echo "[GPU2] a=2.7 V0=0.1 kz=6 done $(date)" >> $LOG
    cat > /tmp/g2_a2.7_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.7 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.7_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU2] a=2.7 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g2_a2.7_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=2.7 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a2.7_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU2] a=2.7 V0=0.1 kz=8 done $(date)" >> $LOG

    # α=3.0 V0=0.1
    cat > /tmp/g2_a3.0_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=3.0 V0=0.1 kz=7 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a3.0_v0.1_k7.ini >> $LOG 2>&1
    echo "[GPU2] a=3.0 V0=0.1 kz=7 done $(date)" >> $LOG
    cat > /tmp/g2_a3.0_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
    echo "[GPU2] a=3.0 V0=0.1 kz=8 start $(date)" >> $LOG
    cd $WDIR && ./ym_coupled /tmp/g2_a3.0_v0.1_k8.ini >> $LOG 2>&1
    echo "[GPU2] a=3.0 V0=0.1 kz=8 done $(date)" >> $LOG
    echo "[GPU2] ALL DONE $(date)" >> $LOG
}

# ── Launch all 3 GPUs in parallel ──────────────────────────────────────
echo "=== wave5_v0p1: launching 3-GPU campaign $(date) ==="
run_gpu0 &
PID0=$!
run_gpu1 &
PID1=$!
run_gpu2 &
PID2=$!

wait $PID0 && echo 'GPU0 finished' || echo 'GPU0 FAILED'
wait $PID1 && echo 'GPU1 finished' || echo 'GPU1 FAILED'
wait $PID2 && echo 'GPU2 finished' || echo 'GPU2 FAILED'
echo "=== wave5_v0p1: all done $(date) ==="
