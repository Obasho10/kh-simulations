#!/bin/bash
# suspectfix campaign -- abi (3 GPUs)
# Launch: nohup bash scripts/suspectfix_wave1_abi.sh > logs/suspectfix_abi.log 2>&1 &
set -e
WDIR=/DATA/s23103/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs

run_gpu0() {
    export CUDA_VISIBLE_DEVICES=0
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/suspectfix_abi0_progress.log
    echo "[GPU0] start $(date)" >> $LOG
cat > /tmp/sfx_abi0_a0.1_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.1 V0=0.01 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.1_v0.01_kz2.75.ini >> $LOG 2>&1) || echo "[GPU0] a=0.1 V0=0.01 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.1 V0=0.01 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.1_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.1 V0=0.03 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.1_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[GPU0] a=0.1 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.1 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.1_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.1 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.1_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[GPU0] a=0.1 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.1 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.1_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.1 V0=0.03 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.1_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[GPU0] a=0.1 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.1 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.1_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.1 V0=0.03 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.1_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[GPU0] a=0.1 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.1 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.1_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.1 V0=0.05 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.1_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[GPU0] a=0.1 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.1 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.1_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.1 V0=0.05 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.1_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[GPU0] a=0.1 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.1 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.1_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.1 V0=0.05 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.1_v0.05_kz5.5.ini >> $LOG 2>&1) || echo "[GPU0] a=0.1 V0=0.05 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.1 V0=0.05 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.2_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.2 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.2_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[GPU0] a=0.2 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.2 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.2_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.2 V0=0.01 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.2_v0.01_kz2.75.ini >> $LOG 2>&1) || echo "[GPU0] a=0.2 V0=0.01 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.2 V0=0.01 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.2_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.2 V0=0.03 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.2_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[GPU0] a=0.2 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.2 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.2_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 266.9
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.2 V0=0.05 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.2_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[GPU0] a=0.2 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.2 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.2_v0.05_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.2 V0=0.05 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.2_v0.05_kz4.0.ini >> $LOG 2>&1) || echo "[GPU0] a=0.2 V0=0.05 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.2 V0=0.05 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.3_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.3 V0=0.01 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.3_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[GPU0] a=0.3 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.3 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.3_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.3 V0=0.03 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.3_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[GPU0] a=0.3 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.3 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.3_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 353.6
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.3 V0=0.05 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.3_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[GPU0] a=0.3 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.3 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.3_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 387.3
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.3 V0=0.05 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.3_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[GPU0] a=0.3 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.3 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.4_v0.01_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.4 V0=0.01 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.4_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[GPU0] a=0.4 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.4 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.4_v0.01_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.4 V0=0.01 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.4_v0.01_kz6.0.ini >> $LOG 2>&1) || echo "[GPU0] a=0.4 V0=0.01 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.4 V0=0.01 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.4_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 173.3
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.4 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.4_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[GPU0] a=0.4 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.4 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.5_v0.01_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 214.7
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.5 V0=0.01 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.5_v0.01_kz0.5.ini >> $LOG 2>&1) || echo "[GPU0] a=0.5 V0=0.01 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.5 V0=0.01 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.5_v0.01_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 352.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.5 V0=0.01 kz=1.375 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.5_v0.01_kz1.375.ini >> $LOG 2>&1) || echo "[GPU0] a=0.5 V0=0.01 kz=1.375 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.5 V0=0.01 kz=1.375 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.5_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 174.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.5 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.5_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[GPU0] a=0.5 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.5 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.5_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 232.4
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.5 V0=0.05 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.5_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[GPU0] a=0.5 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.5 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.6_v0.01_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 179.7
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.6 V0=0.01 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.6_v0.01_kz0.5.ini >> $LOG 2>&1) || echo "[GPU0] a=0.6 V0=0.01 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.6 V0=0.01 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.6_v0.01_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 293.4
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.6 V0=0.01 kz=1.375 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.6_v0.01_kz1.375.ini >> $LOG 2>&1) || echo "[GPU0] a=0.6 V0=0.01 kz=1.375 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.6 V0=0.01 kz=1.375 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.6_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.6 V0=0.03 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.6_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[GPU0] a=0.6 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.6 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.6_v0.05_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.6 V0=0.05 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.6_v0.05_kz0.25.ini >> $LOG 2>&1) || echo "[GPU0] a=0.6 V0=0.05 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.6 V0=0.05 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.6_v0.05_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 237.2
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.6 V0=0.05 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.6_v0.05_kz4.5.ini >> $LOG 2>&1) || echo "[GPU0] a=0.6 V0=0.05 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.6 V0=0.05 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.6_v0.05_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 273.9
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.6 V0=0.05 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.6_v0.05_kz6.0.ini >> $LOG 2>&1) || echo "[GPU0] a=0.6 V0=0.05 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.6 V0=0.05 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.7_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 205.2
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.7 V0=0.03 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.7_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[GPU0] a=0.7 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.7 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.8_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 0.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 143.5
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.8 V0=0.03 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.8_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[GPU0] a=0.8 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.8 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.8_v0.03_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 296.5
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.8 V0=0.03 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.8_v0.03_kz7.5.ini >> $LOG 2>&1) || echo "[GPU0] a=0.8 V0=0.03 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.8 V0=0.03 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.8_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 136.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.8 V0=0.05 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.8_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[GPU0] a=0.8 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.8 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.9_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 250.1
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.9 V0=0.01 kz=2.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.9_v0.01_kz2.25.ini >> $LOG 2>&1) || echo "[GPU0] a=0.9 V0=0.01 kz=2.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.9 V0=0.01 kz=2.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a0.9_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=0.9 V0=0.03 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a0.9_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[GPU0] a=0.9 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=0.9 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.0_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 335.4
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.0 V0=0.01 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.0_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[GPU0] a=1.0 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.0 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.0_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.0 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.0_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[GPU0] a=1.0 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.0 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.1_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 226.2
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.1 V0=0.01 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.1_v0.01_kz2.75.ini >> $LOG 2>&1) || echo "[GPU0] a=1.1 V0=0.01 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.1 V0=0.01 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.1_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 47.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.1 V0=0.05 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.1_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[GPU0] a=1.1 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.1 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.2_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.2 V0=0.03 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.2_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[GPU0] a=1.2 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.2 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.2_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.2 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.2_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[GPU0] a=1.2 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.2 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.2_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 31.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.2 V0=0.03 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.2_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[GPU0] a=1.2 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.2 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.2_v0.03_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.2 V0=0.03 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.2_v0.03_kz1.5.ini >> $LOG 2>&1) || echo "[GPU0] a=1.2 V0=0.03 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.2 V0=0.03 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.2_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.2 V0=0.05 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.2_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[GPU0] a=1.2 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.2 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.2_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 158.1
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.2 V0=0.05 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.2_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[GPU0] a=1.2 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.2 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.3_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.3 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.3_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[GPU0] a=1.3 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.3 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.3_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 188.4
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.3 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.3_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[GPU0] a=1.3 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.3 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.3_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 121.1
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.3 V0=0.05 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.3_v0.05_kz5.5.ini >> $LOG 2>&1) || echo "[GPU0] a=1.3 V0=0.05 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.3 V0=0.05 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.4_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 108.3
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.4 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.4_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[GPU0] a=1.4 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.4 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.4_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 114.5
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.4 V0=0.01 kz=1.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.4_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[GPU0] a=1.4 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.4 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.4_v0.01_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 262.5
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.4 V0=0.01 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.4_v0.01_kz6.0.ini >> $LOG 2>&1) || echo "[GPU0] a=1.4 V0=0.01 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.4 V0=0.01 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.4_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 105.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.4 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.4_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[GPU0] a=1.4 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.4 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.4_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.4 V0=0.05 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.4_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[GPU0] a=1.4 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.4 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.5_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 200.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.5 V0=0.01 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.5_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[GPU0] a=1.5 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.5 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.5_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 223.6
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.5 V0=0.01 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.5_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[GPU0] a=1.5 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.5 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.5_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.5 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.5_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[GPU0] a=1.5 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.5 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.5_v0.03_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.1
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.5 V0=0.03 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.5_v0.03_kz3.0.ini >> $LOG 2>&1) || echo "[GPU0] a=1.5 V0=0.03 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.5 V0=0.03 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.5_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 51.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.5 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.5_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[GPU0] a=1.5 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.5 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.5_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.5 V0=0.05 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.5_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[GPU0] a=1.5 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.5 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.5_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 49.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.5 V0=0.05 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.5_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[GPU0] a=1.5 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.5 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.6_v0.01_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.6 V0=0.01 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.6_v0.01_kz0.5.ini >> $LOG 2>&1) || echo "[GPU0] a=1.6 V0=0.01 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.6 V0=0.01 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.6_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.6 V0=0.03 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.6_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[GPU0] a=1.6 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.6 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.6_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 42.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.6 V0=0.05 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.6_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[GPU0] a=1.6 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.6 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.7_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.7 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.7_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[GPU0] a=1.7 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.7 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.7_v0.03_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 134.8
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.7 V0=0.03 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.7_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[GPU0] a=1.7 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.7 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.7_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 45.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.7 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.7_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[GPU0] a=1.7 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.7 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.8_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.8 V0=0.01 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.8_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[GPU0] a=1.8 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.8 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.8_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.8 V0=0.05 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.8_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[GPU0] a=1.8 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.8 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.8_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 41.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.8 V0=0.05 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.8_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[GPU0] a=1.8 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.8 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.8_v0.05_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.8 V0=0.05 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.8_v0.05_kz3.5.ini >> $LOG 2>&1) || echo "[GPU0] a=1.8 V0=0.05 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.8 V0=0.05 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.9_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.9 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.9_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[GPU0] a=1.9 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.9 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.9_v0.01_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 136.8
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.9 V0=0.01 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.9_v0.01_kz3.0.ini >> $LOG 2>&1) || echo "[GPU0] a=1.9 V0=0.01 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.9 V0=0.01 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.9_v0.01_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 147.8
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.9 V0=0.01 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.9_v0.01_kz3.5.ini >> $LOG 2>&1) || echo "[GPU0] a=1.9 V0=0.01 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.9 V0=0.01 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.9_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 19.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.9 V0=0.03 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.9_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[GPU0] a=1.9 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.9 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.9_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.9 V0=0.03 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.9_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[GPU0] a=1.9 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.9 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a1.9_v0.03_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 124.8
run_tag = suspectfix
EOINI
echo "[GPU0] a=1.9 V0=0.03 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a1.9_v0.03_kz7.5.ini >> $LOG 2>&1) || echo "[GPU0] a=1.9 V0=0.03 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=1.9 V0=0.03 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.0_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.0 V0=0.01 kz=1.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.0_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[GPU0] a=2.0 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.0 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.0_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.0 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.0_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[GPU0] a=2.0 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.0 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.0_v0.03_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.0 V0=0.03 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.0_v0.03_kz4.0.ini >> $LOG 2>&1) || echo "[GPU0] a=2.0 V0=0.03 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.0 V0=0.03 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.0_v0.05_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 52.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.0 V0=0.05 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.0_v0.05_kz3.5.ini >> $LOG 2>&1) || echo "[GPU0] a=2.0 V0=0.05 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.0 V0=0.05 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.1_v0.01_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 123.8
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.1 V0=0.01 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.1_v0.01_kz3.0.ini >> $LOG 2>&1) || echo "[GPU0] a=2.1 V0=0.01 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.1 V0=0.01 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.1_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.1 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.1_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[GPU0] a=2.1 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.1 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.1_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.1 V0=0.03 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.1_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[GPU0] a=2.1 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.1 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.1_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 49.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.1 V0=0.05 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.1_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[GPU0] a=2.1 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.1 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.1_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 35.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.1 V0=0.05 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.1_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[GPU0] a=2.1 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.1 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.1_v0.05_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 49.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.1 V0=0.05 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.1_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[GPU0] a=2.1 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.1 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.1_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 49.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.1 V0=0.05 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.1_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[GPU0] a=2.1 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.1 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.2_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.2 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.2_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[GPU0] a=2.2 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.2 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.2_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.2 V0=0.03 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.2_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[GPU0] a=2.2 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.2 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.2_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.2 V0=0.05 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.2_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[GPU0] a=2.2 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.2 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.3_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 145.9
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.3 V0=0.01 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.3_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[GPU0] a=2.3 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.3 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.3_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.3 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.3_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[GPU0] a=2.3 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.3 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.3_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.3 V0=0.05 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.3_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[GPU0] a=2.3 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.3 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.3_v0.05_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.3 V0=0.05 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.3_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[GPU0] a=2.3 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.3 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.4_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.4 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.4_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[GPU0] a=2.4 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.4 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.4_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 51.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.4 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.4_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[GPU0] a=2.4 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.4 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.5_v0.01_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.5 V0=0.01 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.5_v0.01_kz0.5.ini >> $LOG 2>&1) || echo "[GPU0] a=2.5 V0=0.01 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.5 V0=0.01 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.5_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 120.1
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.5 V0=0.01 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.5_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[GPU0] a=2.5 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.5 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.5_v0.01_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 153.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.5 V0=0.01 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.5_v0.01_kz6.5.ini >> $LOG 2>&1) || echo "[GPU0] a=2.5 V0=0.01 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.5 V0=0.01 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.5_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.5 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.5_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[GPU0] a=2.5 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.5 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.5_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.5 V0=0.05 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.5_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[GPU0] a=2.5 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.5 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.5_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 52.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.5 V0=0.05 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.5_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[GPU0] a=2.5 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.5 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.6_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.6 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.6_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[GPU0] a=2.6 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.6 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.6_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 50.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.6 V0=0.05 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.6_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[GPU0] a=2.6 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.6 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.6_v0.05_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 50.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.6 V0=0.05 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.6_v0.05_kz4.5.ini >> $LOG 2>&1) || echo "[GPU0] a=2.6 V0=0.05 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.6 V0=0.05 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.6_v0.05_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 50.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.6 V0=0.05 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.6_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[GPU0] a=2.6 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.6 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.7_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.7 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.7_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[GPU0] a=2.7 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.7 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.7_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.7 V0=0.03 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.7_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[GPU0] a=2.7 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.7 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.7_v0.03_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.7 V0=0.03 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.7_v0.03_kz2.5.ini >> $LOG 2>&1) || echo "[GPU0] a=2.7 V0=0.03 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.7 V0=0.03 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.7_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.7 V0=0.05 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.7_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[GPU0] a=2.7 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.7 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.8_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.8 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.8_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[GPU0] a=2.8 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.8 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.8_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.8 V0=0.03 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.8_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[GPU0] a=2.8 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.8 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.8_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 40.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.8 V0=0.03 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.8_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[GPU0] a=2.8 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.8 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.8_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.8 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.8_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[GPU0] a=2.8 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.8 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.8_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.8 V0=0.05 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.8_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[GPU0] a=2.8 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.8 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.9_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.9 V0=0.01 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.9_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[GPU0] a=2.9 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.9 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.9_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.9 V0=0.03 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.9_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[GPU0] a=2.9 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.9 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.9_v0.03_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.9 V0=0.03 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.9_v0.03_kz2.5.ini >> $LOG 2>&1) || echo "[GPU0] a=2.9 V0=0.03 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.9 V0=0.03 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.9_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 42.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.9 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.9_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[GPU0] a=2.9 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.9 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.9_v0.03_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.9 V0=0.03 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.9_v0.03_kz3.0.ini >> $LOG 2>&1) || echo "[GPU0] a=2.9 V0=0.03 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.9 V0=0.03 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.9_v0.03_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.9 V0=0.03 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.9_v0.03_kz7.5.ini >> $LOG 2>&1) || echo "[GPU0] a=2.9 V0=0.03 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.9 V0=0.03 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a2.9_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=2.9 V0=0.05 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a2.9_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[GPU0] a=2.9 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=2.9 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a3.0_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=3.0 V0=0.01 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a3.0_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[GPU0] a=3.0 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=3.0 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a3.0_v0.01_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 106.1
run_tag = suspectfix
EOINI
echo "[GPU0] a=3.0 V0=0.01 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a3.0_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[GPU0] a=3.0 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=3.0 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a3.0_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=3.0 V0=0.03 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a3.0_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[GPU0] a=3.0 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=3.0 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a3.0_v0.03_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=3.0 V0=0.03 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a3.0_v0.03_kz3.0.ini >> $LOG 2>&1) || echo "[GPU0] a=3.0 V0=0.03 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=3.0 V0=0.03 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a3.0_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=3.0 V0=0.05 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a3.0_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[GPU0] a=3.0 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=3.0 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi0_a5.0_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU0] a=5.0 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi0_a5.0_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[GPU0] a=5.0 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU0] a=5.0 V0=0.03 kz=1.0 done $(date)" >> $LOG

    echo "[GPU0] ALL DONE $(date)" >> $LOG
}

run_gpu1() {
    export CUDA_VISIBLE_DEVICES=1
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/suspectfix_abi1_progress.log
    echo "[GPU1] start $(date)" >> $LOG
cat > /tmp/sfx_abi1_a0.1_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.1 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.1_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[GPU1] a=0.1 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.1 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.1_v0.01_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.1 V0=0.01 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.1_v0.01_kz6.5.ini >> $LOG 2>&1) || echo "[GPU1] a=0.1 V0=0.01 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.1 V0=0.01 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.1_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.1 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.1_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[GPU1] a=0.1 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.1 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.1_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 0.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.1 V0=0.03 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.1_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[GPU1] a=0.1 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.1 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.1_v0.03_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.1 V0=0.03 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.1_v0.03_kz3.0.ini >> $LOG 2>&1) || echo "[GPU1] a=0.1 V0=0.03 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.1 V0=0.03 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.1_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.1 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.1_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[GPU1] a=0.1 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.1 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.1_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.1 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.1_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[GPU1] a=0.1 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.1 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.1_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.1 V0=0.05 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.1_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[GPU1] a=0.1 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.1 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.1_v0.05_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.1 V0=0.05 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.1_v0.05_kz3.5.ini >> $LOG 2>&1) || echo "[GPU1] a=0.1 V0=0.05 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.1 V0=0.05 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.1_v0.05_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.1 V0=0.05 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.1_v0.05_kz5.0.ini >> $LOG 2>&1) || echo "[GPU1] a=0.1 V0=0.05 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.1 V0=0.05 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.2_v0.01_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.2 V0=0.01 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.2_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[GPU1] a=0.2 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.2 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.2_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.2 V0=0.03 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.2_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[GPU1] a=0.2 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.2 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.2_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 291.6
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.2 V0=0.05 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.2_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[GPU1] a=0.2 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.2 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.2_v0.05_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.2 V0=0.05 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.2_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[GPU1] a=0.2 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.2 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.3_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.3 V0=0.01 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.3_v0.01_kz2.75.ini >> $LOG 2>&1) || echo "[GPU1] a=0.3 V0=0.01 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.3 V0=0.01 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.3_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 207.1
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.3 V0=0.03 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.3_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[GPU1] a=0.3 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.3 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.3_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 270.8
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.3 V0=0.03 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.3_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[GPU1] a=0.3 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.3 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.3_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.3 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.3_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[GPU1] a=0.3 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.3 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.3_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 195.1
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.3 V0=0.05 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.3_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[GPU1] a=0.3 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.3 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.3_v0.05_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.3 V0=0.05 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.3_v0.05_kz3.5.ini >> $LOG 2>&1) || echo "[GPU1] a=0.3 V0=0.05 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.3 V0=0.05 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.4_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 398.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.4 V0=0.01 kz=1.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.4_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[GPU1] a=0.4 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.4 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.4_v0.05_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 313.8
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.4 V0=0.05 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.4_v0.05_kz3.5.ini >> $LOG 2>&1) || echo "[GPU1] a=0.4 V0=0.05 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.4 V0=0.05 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.5_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.5 V0=0.01 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.5_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[GPU1] a=0.5 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.5 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.5_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 150.6
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.5 V0=0.05 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.5_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[GPU1] a=0.5 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.5 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.6_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.6 V0=0.01 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.6_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[GPU1] a=0.6 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.6 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.6_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.6 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.6_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[GPU1] a=0.6 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.6 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.6_v0.05_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 295.8
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.6 V0=0.05 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.6_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[GPU1] a=0.6 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.6 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.7_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 214.9
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.7 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.7_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[GPU1] a=0.7 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.7 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.7_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 355.4
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.7 V0=0.01 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.7_v0.01_kz2.75.ini >> $LOG 2>&1) || echo "[GPU1] a=0.7 V0=0.01 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.7 V0=0.01 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.7_v0.03_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 327.3
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.7 V0=0.03 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.7_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[GPU1] a=0.7 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.7 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.7_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 0.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 46.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 107.9
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.7 V0=0.05 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.7_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[GPU1] a=0.7 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.7 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a0.8_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 153.3
run_tag = suspectfix
EOINI
echo "[GPU1] a=0.8 V0=0.03 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a0.8_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[GPU1] a=0.8 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=0.8 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.0_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 225.1
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.0 V0=0.01 kz=2.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.0_v0.01_kz2.25.ini >> $LOG 2>&1) || echo "[GPU1] a=1.0 V0=0.01 kz=2.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.0 V0=0.01 kz=2.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.0_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 248.8
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.0 V0=0.01 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.0_v0.01_kz2.75.ini >> $LOG 2>&1) || echo "[GPU1] a=1.0 V0=0.01 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.0 V0=0.01 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.1_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 119.9
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.1 V0=0.01 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.1_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[GPU1] a=1.1 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.1 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.1_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 137.3
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.1 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.1_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[GPU1] a=1.1 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.1 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.1_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 127.7
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.1 V0=0.03 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.1_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[GPU1] a=1.1 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.1 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.1_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 222.7
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.1 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.1_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[GPU1] a=1.1 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.1 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.1_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 47.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.1 V0=0.05 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.1_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[GPU1] a=1.1 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.1 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.1_v0.05_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 47.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.1 V0=0.05 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.1_v0.05_kz1.5.ini >> $LOG 2>&1) || echo "[GPU1] a=1.1 V0=0.05 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.1 V0=0.05 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.2_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 342.3
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.2 V0=0.01 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.2_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[GPU1] a=1.2 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.2 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.2_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.2 V0=0.03 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.2_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[GPU1] a=1.2 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.2 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.3_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 177.9
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.3 V0=0.01 kz=2.375 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.3_v0.01_kz2.375.ini >> $LOG 2>&1) || echo "[GPU1] a=1.3 V0=0.01 kz=2.375 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.3 V0=0.01 kz=2.375 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.3_v0.01_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 182.5
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.3 V0=0.01 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.3_v0.01_kz2.5.ini >> $LOG 2>&1) || echo "[GPU1] a=1.3 V0=0.01 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.3 V0=0.01 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.3_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 20.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.3 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.3_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[GPU1] a=1.3 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.3 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.3_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.3 V0=0.05 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.3_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[GPU1] a=1.3 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.3 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.4_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.4 V0=0.01 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.4_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[GPU1] a=1.4 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.4 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.4_v0.01_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 131.6
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.4 V0=0.01 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.4_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[GPU1] a=1.4 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.4 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.4_v0.01_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 185.7
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.4 V0=0.01 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.4_v0.01_kz3.0.ini >> $LOG 2>&1) || echo "[GPU1] a=1.4 V0=0.01 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.4 V0=0.01 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.4_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 239.6
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.4 V0=0.01 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.4_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[GPU1] a=1.4 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.4 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.4_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.4 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.4_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[GPU1] a=1.4 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.4 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.4_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 175.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.4 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.4_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[GPU1] a=1.4 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.4 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.4_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.4 V0=0.05 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.4_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[GPU1] a=1.4 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.4 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.5_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 101.2
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.5 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.5_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[GPU1] a=1.5 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.5 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.5_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.5 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.5_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[GPU1] a=1.5 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.5 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.6_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.6 V0=0.03 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.6_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[GPU1] a=1.6 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.6 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.7_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 125.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.7 V0=0.01 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.7_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[GPU1] a=1.7 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.7 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.7_v0.01_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 225.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.7 V0=0.01 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.7_v0.01_kz6.5.ini >> $LOG 2>&1) || echo "[GPU1] a=1.7 V0=0.01 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.7 V0=0.01 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.7_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.7 V0=0.03 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.7_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[GPU1] a=1.7 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.7 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.7_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 31.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.7 V0=0.03 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.7_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[GPU1] a=1.7 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.7 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.8_v0.01_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.8 V0=0.01 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.8_v0.01_kz0.5.ini >> $LOG 2>&1) || echo "[GPU1] a=1.8 V0=0.01 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.8 V0=0.01 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.8_v0.01_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 195.5
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.8 V0=0.01 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.8_v0.01_kz5.5.ini >> $LOG 2>&1) || echo "[GPU1] a=1.8 V0=0.01 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.8 V0=0.01 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.8_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 1.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.8 V0=0.03 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.8_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[GPU1] a=1.8 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.8 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.8_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 39.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.8 V0=0.05 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.8_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[GPU1] a=1.8 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.8 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.9_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 17.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.9 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.9_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[GPU1] a=1.9 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.9 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.9_v0.05_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.9 V0=0.05 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.9_v0.05_kz0.25.ini >> $LOG 2>&1) || echo "[GPU1] a=1.9 V0=0.05 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.9 V0=0.05 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.9_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 39.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.9 V0=0.05 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.9_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[GPU1] a=1.9 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.9 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a1.9_v0.05_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=1.9 V0=0.05 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a1.9_v0.05_kz3.5.ini >> $LOG 2>&1) || echo "[GPU1] a=1.9 V0=0.05 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=1.9 V0=0.05 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.0_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 150.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.0 V0=0.01 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.0_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[GPU1] a=2.0 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.0 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.0_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.0 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.0_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[GPU1] a=2.0 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.0 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.0_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 37.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.0 V0=0.03 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.0_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[GPU1] a=2.0 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.0 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.0_v0.05_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 52.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.0 V0=0.05 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.0_v0.05_kz1.5.ini >> $LOG 2>&1) || echo "[GPU1] a=2.0 V0=0.05 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.0 V0=0.05 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.1_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.1 V0=0.01 kz=1.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.1_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[GPU1] a=2.1 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.1 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.1_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.1 V0=0.03 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.1_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[GPU1] a=2.1 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.1 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.1_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.1 V0=0.03 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.1_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[GPU1] a=2.1 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.1 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.1_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.1 V0=0.05 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.1_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[GPU1] a=2.1 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.1 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.1_v0.05_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 49.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.1 V0=0.05 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.1_v0.05_kz3.5.ini >> $LOG 2>&1) || echo "[GPU1] a=2.1 V0=0.05 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.1 V0=0.05 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.1_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 49.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.1 V0=0.05 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.1_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[GPU1] a=2.1 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.1 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.2_v0.01_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 118.2
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.2 V0=0.01 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.2_v0.01_kz3.0.ini >> $LOG 2>&1) || echo "[GPU1] a=2.2 V0=0.01 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.2 V0=0.01 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.2_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.2 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.2_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[GPU1] a=2.2 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.2 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.2_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.2 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.2_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[GPU1] a=2.2 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.2 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.2_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.2 V0=0.05 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.2_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[GPU1] a=2.2 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.2 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.2_v0.05_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 47.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.2 V0=0.05 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.2_v0.05_kz4.0.ini >> $LOG 2>&1) || echo "[GPU1] a=2.2 V0=0.05 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.2 V0=0.05 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.3_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.3 V0=0.01 kz=0.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.3_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[GPU1] a=2.3 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.3 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.3_v0.01_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 138.4
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.3 V0=0.01 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.3_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[GPU1] a=2.3 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.3 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.3_v0.01_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 153.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.3 V0=0.01 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.3_v0.01_kz5.5.ini >> $LOG 2>&1) || echo "[GPU1] a=2.3 V0=0.01 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.3 V0=0.01 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.3_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.3 V0=0.03 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.3_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[GPU1] a=2.3 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.3 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.3_v0.03_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.3 V0=0.03 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.3_v0.03_kz1.5.ini >> $LOG 2>&1) || echo "[GPU1] a=2.3 V0=0.03 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.3 V0=0.03 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.4_v0.01_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.4 V0=0.01 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.4_v0.01_kz1.25.ini >> $LOG 2>&1) || echo "[GPU1] a=2.4 V0=0.01 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.4 V0=0.01 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.4_v0.01_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 108.4
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.4 V0=0.01 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.4_v0.01_kz3.0.ini >> $LOG 2>&1) || echo "[GPU1] a=2.4 V0=0.01 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.4 V0=0.01 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.4_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.4 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.4_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[GPU1] a=2.4 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.4 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.4_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 49.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.4 V0=0.03 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.4_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[GPU1] a=2.4 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.4 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.4_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.4 V0=0.05 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.4_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[GPU1] a=2.4 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.4 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.4_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.4 V0=0.05 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.4_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[GPU1] a=2.4 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.4 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.5_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 134.2
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.5 V0=0.01 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.5_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[GPU1] a=2.5 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.5 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.5_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.5 V0=0.03 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.5_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[GPU1] a=2.5 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.5 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.5_v0.03_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.5 V0=0.03 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.5_v0.03_kz1.5.ini >> $LOG 2>&1) || echo "[GPU1] a=2.5 V0=0.03 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.5 V0=0.03 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.5_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.5 V0=0.05 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.5_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[GPU1] a=2.5 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.5 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.5_v0.05_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.5 V0=0.05 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.5_v0.05_kz5.0.ini >> $LOG 2>&1) || echo "[GPU1] a=2.5 V0=0.05 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.5 V0=0.05 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.6_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.6 V0=0.01 kz=1.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.6_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[GPU1] a=2.6 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.6 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.6_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 20.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.6 V0=0.03 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.6_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[GPU1] a=2.6 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.6 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.6_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.6 V0=0.03 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.6_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[GPU1] a=2.6 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.6 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.6_v0.03_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.6 V0=0.03 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.6_v0.03_kz3.5.ini >> $LOG 2>&1) || echo "[GPU1] a=2.6 V0=0.03 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.6 V0=0.03 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.6_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 17.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.6 V0=0.05 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.6_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[GPU1] a=2.6 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.6 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.6_v0.05_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 50.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.6 V0=0.05 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.6_v0.05_kz3.5.ini >> $LOG 2>&1) || echo "[GPU1] a=2.6 V0=0.05 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.6 V0=0.05 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.7_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.7 V0=0.03 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.7_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[GPU1] a=2.7 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.7 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.7_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.7 V0=0.03 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.7_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[GPU1] a=2.7 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.7 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.7_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.7 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.7_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[GPU1] a=2.7 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.7 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.7_v0.03_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.7 V0=0.03 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.7_v0.03_kz1.5.ini >> $LOG 2>&1) || echo "[GPU1] a=2.7 V0=0.03 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.7 V0=0.03 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.7_v0.03_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.7 V0=0.03 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.7_v0.03_kz3.0.ini >> $LOG 2>&1) || echo "[GPU1] a=2.7 V0=0.03 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.7 V0=0.03 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.7_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.7 V0=0.05 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.7_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[GPU1] a=2.7 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.7 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.8_v0.01_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.8 V0=0.01 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.8_v0.01_kz3.0.ini >> $LOG 2>&1) || echo "[GPU1] a=2.8 V0=0.01 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.8 V0=0.01 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.8_v0.01_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 125.7
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.8 V0=0.01 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.8_v0.01_kz5.5.ini >> $LOG 2>&1) || echo "[GPU1] a=2.8 V0=0.01 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.8 V0=0.01 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.8_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.8 V0=0.03 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.8_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[GPU1] a=2.8 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.8 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.8_v0.03_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.8 V0=0.03 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.8_v0.03_kz3.5.ini >> $LOG 2>&1) || echo "[GPU1] a=2.8 V0=0.03 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.8 V0=0.03 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.8_v0.05_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.8 V0=0.05 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.8_v0.05_kz6.0.ini >> $LOG 2>&1) || echo "[GPU1] a=2.8 V0=0.05 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.8 V0=0.05 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.9_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.9 V0=0.01 kz=0.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.9_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[GPU1] a=2.9 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.9 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.9_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 33.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.9 V0=0.01 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.9_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[GPU1] a=2.9 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.9 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.9_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.9 V0=0.01 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.9_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[GPU1] a=2.9 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.9 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a2.9_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=2.9 V0=0.05 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a2.9_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[GPU1] a=2.9 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=2.9 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a3.0_v0.01_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=3.0 V0=0.01 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a3.0_v0.01_kz0.5.ini >> $LOG 2>&1) || echo "[GPU1] a=3.0 V0=0.01 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=3.0 V0=0.01 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a3.0_v0.01_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=3.0 V0=0.01 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a3.0_v0.01_kz1.25.ini >> $LOG 2>&1) || echo "[GPU1] a=3.0 V0=0.01 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=3.0 V0=0.01 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a3.0_v0.01_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=3.0 V0=0.01 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a3.0_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[GPU1] a=3.0 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=3.0 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a3.0_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=3.0 V0=0.01 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a3.0_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[GPU1] a=3.0 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=3.0 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a3.0_v0.01_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 117.3
run_tag = suspectfix
EOINI
echo "[GPU1] a=3.0 V0=0.01 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a3.0_v0.01_kz5.5.ini >> $LOG 2>&1) || echo "[GPU1] a=3.0 V0=0.01 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=3.0 V0=0.01 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a3.0_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=3.0 V0=0.03 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a3.0_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[GPU1] a=3.0 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=3.0 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a3.0_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 51.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=3.0 V0=0.05 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a3.0_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[GPU1] a=3.0 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=3.0 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a3.0_v0.05_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=3.0 V0=0.05 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a3.0_v0.05_kz6.0.ini >> $LOG 2>&1) || echo "[GPU1] a=3.0 V0=0.05 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=3.0 V0=0.05 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi1_a5.0_v0.03_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 5.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU1] a=5.0 V0=0.03 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi1_a5.0_v0.03_kz5.0.ini >> $LOG 2>&1) || echo "[GPU1] a=5.0 V0=0.03 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU1] a=5.0 V0=0.03 kz=5.0 done $(date)" >> $LOG

    echo "[GPU1] ALL DONE $(date)" >> $LOG
}

run_gpu2() {
    export CUDA_VISIBLE_DEVICES=2
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/suspectfix_abi2_progress.log
    echo "[GPU2] start $(date)" >> $LOG
cat > /tmp/sfx_abi2_a0.1_v0.01_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.1 V0=0.01 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.1_v0.01_kz0.5.ini >> $LOG 2>&1) || echo "[GPU2] a=0.1 V0=0.01 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.1 V0=0.01 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.1_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.1 V0=0.03 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.1_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[GPU2] a=0.1 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.1 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.1_v0.03_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.1 V0=0.03 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.1_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[GPU2] a=0.1 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.1 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.1_v0.05_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.1 V0=0.05 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.1_v0.05_kz6.5.ini >> $LOG 2>&1) || echo "[GPU2] a=0.1 V0=0.05 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.1 V0=0.05 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.2_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 293.4
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.2 V0=0.01 kz=0.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.2_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[GPU2] a=0.2 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.2 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.2_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.2 V0=0.01 kz=2.375 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.2_v0.01_kz2.375.ini >> $LOG 2>&1) || echo "[GPU2] a=0.2 V0=0.01 kz=2.375 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.2 V0=0.01 kz=2.375 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.2_v0.01_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.2 V0=0.01 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.2_v0.01_kz8.0.ini >> $LOG 2>&1) || echo "[GPU2] a=0.2 V0=0.01 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.2 V0=0.01 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.2_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 227.6
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.2 V0=0.03 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.2_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[GPU2] a=0.2 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.2 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.2_v0.05_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.2 V0=0.05 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.2_v0.05_kz4.5.ini >> $LOG 2>&1) || echo "[GPU2] a=0.2 V0=0.05 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.2 V0=0.05 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.2_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.2 V0=0.05 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.2_v0.05_kz5.5.ini >> $LOG 2>&1) || echo "[GPU2] a=0.2 V0=0.05 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.2 V0=0.05 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.3_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.3 V0=0.01 kz=2.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.3_v0.01_kz2.25.ini >> $LOG 2>&1) || echo "[GPU2] a=0.3 V0=0.01 kz=2.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.3 V0=0.01 kz=2.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.3_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 251.1
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.3 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.3_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[GPU2] a=0.3 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.3 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.3_v0.03_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.3 V0=0.03 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.3_v0.03_kz4.0.ini >> $LOG 2>&1) || echo "[GPU2] a=0.3 V0=0.03 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.3 V0=0.03 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.3_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 179.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.3 V0=0.05 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.3_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[GPU2] a=0.3 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.3 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.3_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.3 V0=0.05 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.3_v0.05_kz5.5.ini >> $LOG 2>&1) || echo "[GPU2] a=0.3 V0=0.05 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.3 V0=0.05 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.3_v0.05_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.3 V0=0.05 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.3_v0.05_kz6.0.ini >> $LOG 2>&1) || echo "[GPU2] a=0.3 V0=0.05 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.3 V0=0.05 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.4_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.4 V0=0.01 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.4_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[GPU2] a=0.4 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.4 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.4_v0.01_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.4 V0=0.01 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.4_v0.01_kz3.5.ini >> $LOG 2>&1) || echo "[GPU2] a=0.4 V0=0.01 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.4 V0=0.01 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.4_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 359.1
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.4 V0=0.03 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.4_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[GPU2] a=0.4 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.4 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.4_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 40.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 135.2
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.4 V0=0.05 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.4_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[GPU2] a=0.4 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.4 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.4_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 0.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 188.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.4 V0=0.05 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.4_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[GPU2] a=0.4 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.4 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.5_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.5 V0=0.01 kz=2.375 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.5_v0.01_kz2.375.ini >> $LOG 2>&1) || echo "[GPU2] a=0.5 V0=0.01 kz=2.375 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.5 V0=0.01 kz=2.375 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.5_v0.01_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.5 V0=0.01 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.5_v0.01_kz7.0.ini >> $LOG 2>&1) || echo "[GPU2] a=0.5 V0=0.01 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.5 V0=0.01 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.5_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 52.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 367.4
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.5 V0=0.05 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.5_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[GPU2] a=0.5 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.5 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.6_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 385.3
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.6 V0=0.01 kz=2.375 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.6_v0.01_kz2.375.ini >> $LOG 2>&1) || echo "[GPU2] a=0.6 V0=0.01 kz=2.375 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.6 V0=0.01 kz=2.375 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.6_v0.01_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.6 V0=0.01 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.6_v0.01_kz8.0.ini >> $LOG 2>&1) || echo "[GPU2] a=0.6 V0=0.01 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.6 V0=0.01 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.7_v0.01_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.7 V0=0.01 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.7_v0.01_kz8.0.ini >> $LOG 2>&1) || echo "[GPU2] a=0.7 V0=0.01 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.7 V0=0.01 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.7_v0.05_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 37.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 253.6
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.7 V0=0.05 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.7_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[GPU2] a=0.7 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.7 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.8_v0.01_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 229.9
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.8 V0=0.01 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.8_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[GPU2] a=0.8 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.8 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.8_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 273.4
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.8 V0=0.01 kz=2.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.8_v0.01_kz2.125.ini >> $LOG 2>&1) || echo "[GPU2] a=0.8 V0=0.01 kz=2.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.8 V0=0.01 kz=2.125 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.8_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 40.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.8 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.8_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[GPU2] a=0.8 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.8 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.8_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 109.4
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.8 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.8_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[GPU2] a=0.8 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.8 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.8_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 306.2
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.8 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.8_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[GPU2] a=0.8 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.8 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.9_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 36.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.9 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.9_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[GPU2] a=0.9 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.9 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a0.9_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 156.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=0.9 V0=0.03 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a0.9_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[GPU2] a=0.9 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=0.9 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.0_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 19.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.0 V0=0.05 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.0_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[GPU2] a=1.0 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.0 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.0_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 52.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 183.7
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.0 V0=0.05 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.0_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[GPU2] a=1.0 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.0 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.1_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 193.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.1 V0=0.01 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.1_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[GPU2] a=1.1 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.1 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.1_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 34.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.1 V0=0.03 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.1_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[GPU2] a=1.1 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.1 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.1_v0.05_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.1 V0=0.05 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.1_v0.05_kz0.25.ini >> $LOG 2>&1) || echo "[GPU2] a=1.1 V0=0.05 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.1 V0=0.05 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.2_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.2 V0=0.03 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.2_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[GPU2] a=1.2 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.2 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.2_v0.05_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.2 V0=0.05 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.2_v0.05_kz1.5.ini >> $LOG 2>&1) || echo "[GPU2] a=1.2 V0=0.05 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.2 V0=0.05 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.3_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 113.1
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.3 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.3_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[GPU2] a=1.3 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.3 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.3_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.3 V0=0.05 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.3_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[GPU2] a=1.3 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.3 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.3_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 146.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.3 V0=0.05 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.3_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[GPU2] a=1.3 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.3 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.4_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 293.4
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.4 V0=0.01 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.4_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[GPU2] a=1.4 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.4 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.4_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 102.7
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.4 V0=0.03 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.4_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[GPU2] a=1.4 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.4 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.4_v0.05_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.4 V0=0.05 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.4_v0.05_kz1.5.ini >> $LOG 2>&1) || echo "[GPU2] a=1.4 V0=0.05 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.4 V0=0.05 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.4_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.4 V0=0.05 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.4_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[GPU2] a=1.4 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.4 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.5_v0.01_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 173.3
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.5 V0=0.01 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.5_v0.01_kz3.0.ini >> $LOG 2>&1) || echo "[GPU2] a=1.5 V0=0.01 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.5 V0=0.01 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.5_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.5 V0=0.03 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.5_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[GPU2] a=1.5 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.5 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.5_v0.03_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 141.4
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.5 V0=0.03 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.5_v0.03_kz6.0.ini >> $LOG 2>&1) || echo "[GPU2] a=1.5 V0=0.03 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.5 V0=0.03 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.5_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 15.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.5 V0=0.05 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.5_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[GPU2] a=1.5 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.5 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.5_v0.05_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 51.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.5 V0=0.05 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.5_v0.05_kz1.5.ini >> $LOG 2>&1) || echo "[GPU2] a=1.5 V0=0.05 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.5 V0=0.05 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.6_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.6 V0=0.01 kz=0.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.6_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[GPU2] a=1.6 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.6 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.6_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 132.8
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.6 V0=0.01 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.6_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[GPU2] a=1.6 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.6 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.6_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.6 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.6_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[GPU2] a=1.6 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.6 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.6_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 1.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 33.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.6 V0=0.03 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.6_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[GPU2] a=1.6 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.6 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.6_v0.03_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 148.2
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.6 V0=0.03 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.6_v0.03_kz7.5.ini >> $LOG 2>&1) || echo "[GPU2] a=1.6 V0=0.03 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.6 V0=0.03 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.6_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.6 V0=0.05 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.6_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[GPU2] a=1.6 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.6 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.6_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 44.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.6 V0=0.05 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.6_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[GPU2] a=1.6 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.6 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.6_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 48.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 118.6
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.6 V0=0.05 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.6_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[GPU2] a=1.6 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.6 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.7_v0.01_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.7 V0=0.01 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.7_v0.01_kz0.5.ini >> $LOG 2>&1) || echo "[GPU2] a=1.7 V0=0.01 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.7 V0=0.01 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.7_v0.01_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 108.6
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.7 V0=0.01 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.7_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[GPU2] a=1.7 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.7 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.7_v0.03_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 119.5
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.7 V0=0.03 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.7_v0.03_kz5.5.ini >> $LOG 2>&1) || echo "[GPU2] a=1.7 V0=0.03 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.7 V0=0.03 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.7_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 40.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.7 V0=0.05 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.7_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[GPU2] a=1.7 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.7 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.8_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.8 V0=0.03 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.8_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[GPU2] a=1.8 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.8 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.9_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 216.2
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.9 V0=0.01 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.9_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[GPU2] a=1.9 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.9 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.9_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.9 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.9_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[GPU2] a=1.9 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.9 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.9_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 35.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.9 V0=0.05 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.9_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[GPU2] a=1.9 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.9 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.9_v0.05_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.9 V0=0.05 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.9_v0.05_kz4.5.ini >> $LOG 2>&1) || echo "[GPU2] a=1.9 V0=0.05 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.9 V0=0.05 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a1.9_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=1.9 V0=0.05 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a1.9_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[GPU2] a=1.9 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=1.9 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.0_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.0 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.0_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[GPU2] a=2.0 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.0 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.0_v0.01_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 159.1
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.0 V0=0.01 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.0_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[GPU2] a=2.0 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.0 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.0_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.0 V0=0.03 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.0_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[GPU2] a=2.0 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.0 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.0_v0.03_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.0 V0=0.03 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.0_v0.03_kz1.5.ini >> $LOG 2>&1) || echo "[GPU2] a=2.0 V0=0.03 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.0 V0=0.03 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.0_v0.03_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.0 V0=0.03 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.0_v0.03_kz3.0.ini >> $LOG 2>&1) || echo "[GPU2] a=2.0 V0=0.03 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.0 V0=0.03 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.0_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 52.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.0 V0=0.05 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.0_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[GPU2] a=2.0 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.0 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.1_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 195.6
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.1 V0=0.01 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.1_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[GPU2] a=2.1 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.1 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.1_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 15.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.1 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.1_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[GPU2] a=2.1 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.1 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.1_v0.05_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 49.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.1 V0=0.05 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.1_v0.05_kz4.0.ini >> $LOG 2>&1) || echo "[GPU2] a=2.1 V0=0.05 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.1 V0=0.05 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.2_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.2 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.2_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[GPU2] a=2.2 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.2 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.2_v0.01_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.2 V0=0.01 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.2_v0.01_kz1.25.ini >> $LOG 2>&1) || echo "[GPU2] a=2.2 V0=0.01 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.2 V0=0.01 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.2_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.2 V0=0.01 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.2_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[GPU2] a=2.2 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.2 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.2_v0.03_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.2 V0=0.03 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.2_v0.03_kz2.5.ini >> $LOG 2>&1) || echo "[GPU2] a=2.2 V0=0.03 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.2 V0=0.03 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.2_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.2 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.2_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[GPU2] a=2.2 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.2 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.2_v0.03_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 107.8
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.2 V0=0.03 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.2_v0.03_kz7.5.ini >> $LOG 2>&1) || echo "[GPU2] a=2.2 V0=0.03 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.2 V0=0.03 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.2_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.2 V0=0.05 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.2_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[GPU2] a=2.2 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.2 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.3_v0.01_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.3 V0=0.01 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.3_v0.01_kz0.5.ini >> $LOG 2>&1) || echo "[GPU2] a=2.3 V0=0.01 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.3 V0=0.01 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.3_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.3 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.3_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[GPU2] a=2.3 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.3 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.3_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.3 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.3_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[GPU2] a=2.3 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.3 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.3_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.3 V0=0.05 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.3_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[GPU2] a=2.3 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.3 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.3_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.3 V0=0.05 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.3_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[GPU2] a=2.3 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.3 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.3_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.3 V0=0.05 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.3_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[GPU2] a=2.3 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.3 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.4_v0.01_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 117.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.4 V0=0.01 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.4_v0.01_kz3.5.ini >> $LOG 2>&1) || echo "[GPU2] a=2.4 V0=0.01 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.4 V0=0.01 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.4_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 125.1
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.4 V0=0.01 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.4_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[GPU2] a=2.4 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.4 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.4_v0.01_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 132.6
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.4 V0=0.01 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.4_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[GPU2] a=2.4 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.4 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.4_v0.01_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 153.1
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.4 V0=0.01 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.4_v0.01_kz6.0.ini >> $LOG 2>&1) || echo "[GPU2] a=2.4 V0=0.01 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.4 V0=0.01 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.4_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.4 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.4_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[GPU2] a=2.4 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.4 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.4_v0.03_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.4 V0=0.03 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.4_v0.03_kz2.5.ini >> $LOG 2>&1) || echo "[GPU2] a=2.4 V0=0.03 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.4 V0=0.03 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.4_v0.05_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.4 V0=0.05 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.4_v0.05_kz0.25.ini >> $LOG 2>&1) || echo "[GPU2] a=2.4 V0=0.05 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.4 V0=0.05 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.5_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.5 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.5_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[GPU2] a=2.5 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.5 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.5_v0.01_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 140.7
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.5 V0=0.01 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.5_v0.01_kz5.5.ini >> $LOG 2>&1) || echo "[GPU2] a=2.5 V0=0.01 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.5 V0=0.01 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.5_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 15.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.5 V0=0.03 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.5_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[GPU2] a=2.5 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.5 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.5_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.5 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.5_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[GPU2] a=2.5 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.5 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.5_v0.03_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.5 V0=0.03 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.5_v0.03_kz2.5.ini >> $LOG 2>&1) || echo "[GPU2] a=2.5 V0=0.03 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.5 V0=0.03 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.5_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 47.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.5 V0=0.03 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.5_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[GPU2] a=2.5 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.5 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.5_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 49.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.5 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.5_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[GPU2] a=2.5 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.5 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.5_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.5 V0=0.05 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.5_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[GPU2] a=2.5 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.5 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.6_v0.01_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.1
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.6 V0=0.01 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.6_v0.01_kz3.0.ini >> $LOG 2>&1) || echo "[GPU2] a=2.6 V0=0.01 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.6 V0=0.01 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.6_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.6 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.6_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[GPU2] a=2.6 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.6 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.6_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 29.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.6 V0=0.03 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.6_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[GPU2] a=2.6 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.6 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.6_v0.03_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.6 V0=0.03 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.6_v0.03_kz2.5.ini >> $LOG 2>&1) || echo "[GPU2] a=2.6 V0=0.03 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.6 V0=0.03 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.6_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.6 V0=0.05 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.6_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[GPU2] a=2.6 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.6 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.7_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 20.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.7 V0=0.03 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.7_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[GPU2] a=2.7 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.7 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.7_v0.03_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.7 V0=0.03 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.7_v0.03_kz7.5.ini >> $LOG 2>&1) || echo "[GPU2] a=2.7 V0=0.03 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.7 V0=0.03 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.7_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 48.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.7 V0=0.05 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.7_v0.05_kz5.5.ini >> $LOG 2>&1) || echo "[GPU2] a=2.7 V0=0.05 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.7 V0=0.05 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.8_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.8 V0=0.03 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.8_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[GPU2] a=2.8 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.8 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.8_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.8 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.8_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[GPU2] a=2.8 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.8 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.8_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.8 V0=0.05 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.8_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[GPU2] a=2.8 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.8 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.9_v0.01_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.9 V0=0.01 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.9_v0.01_kz3.0.ini >> $LOG 2>&1) || echo "[GPU2] a=2.9 V0=0.01 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.9 V0=0.01 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.9_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.9 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.9_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[GPU2] a=2.9 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.9 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.9_v0.03_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.9 V0=0.03 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.9_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[GPU2] a=2.9 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.9 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a2.9_v0.05_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 53.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=2.9 V0=0.05 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a2.9_v0.05_kz4.5.ini >> $LOG 2>&1) || echo "[GPU2] a=2.9 V0=0.05 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=2.9 V0=0.05 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a3.0_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=3.0 V0=0.03 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a3.0_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[GPU2] a=3.0 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=3.0 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a3.0_v0.03_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=3.0 V0=0.03 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a3.0_v0.03_kz6.5.ini >> $LOG 2>&1) || echo "[GPU2] a=3.0 V0=0.03 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=3.0 V0=0.03 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a3.0_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=3.0 V0=0.05 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a3.0_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[GPU2] a=3.0 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=3.0 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a3.0_v0.05_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=3.0 V0=0.05 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a3.0_v0.05_kz5.0.ini >> $LOG 2>&1) || echo "[GPU2] a=3.0 V0=0.05 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=3.0 V0=0.05 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_abi2_a5.0_v0.03_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 5.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[GPU2] a=5.0 V0=0.03 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_abi2_a5.0_v0.03_kz4.0.ini >> $LOG 2>&1) || echo "[GPU2] a=5.0 V0=0.03 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[GPU2] a=5.0 V0=0.03 kz=4.0 done $(date)" >> $LOG

    echo "[GPU2] ALL DONE $(date)" >> $LOG
}

echo "=== abi: launching 3-GPU suspectfix campaign $(date) ==="
run_gpu0 & PID0=$!
run_gpu1 & PID1=$!
run_gpu2 & PID2=$!
wait $PID0 && echo 'GPU0 finished' || echo 'GPU0 FAILED'
wait $PID1 && echo 'GPU1 finished' || echo 'GPU1 FAILED'
wait $PID2 && echo 'GPU2 finished' || echo 'GPU2 FAILED'
echo "=== abi: all done $(date) ==="
