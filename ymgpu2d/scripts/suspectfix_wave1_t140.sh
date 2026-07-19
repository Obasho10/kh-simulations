#!/bin/bash
# suspectfix campaign -- t140: 262 runs
# Launch: nohup bash scripts/suspectfix_wave1_t140.sh > logs/suspectfix_t140.log 2>&1 &
set -e
WDIR=/DATA/cm/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs
LOG=$WDIR/logs/suspectfix_t140_progress.log
echo "=== start $(date) ===" >> $LOG
cat > /tmp/sfx_t140_a0.1_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.1
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
echo "[t140] a=0.1 V0=0.01 kz=2.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.1_v0.01_kz2.25.ini >> $LOG 2>&1) || echo "[t140] a=0.1 V0=0.01 kz=2.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.1 V0=0.01 kz=2.25 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.1_v0.01_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.1
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
echo "[t140] a=0.1 V0=0.01 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.1_v0.01_kz3.5.ini >> $LOG 2>&1) || echo "[t140] a=0.1 V0=0.01 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.1 V0=0.01 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.1_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.1
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
echo "[t140] a=0.1 V0=0.01 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.1_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[t140] a=0.1 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.1 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.1_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.1
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
echo "[t140] a=0.1 V0=0.03 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.1_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[t140] a=0.1 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.1 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.1_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.1
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
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.1 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.1_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[t140] a=0.1 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.1 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.1_v0.03_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.1 V0=0.03 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.1_v0.03_kz3.5.ini >> $LOG 2>&1) || echo "[t140] a=0.1 V0=0.03 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.1 V0=0.03 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.1_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 0.1
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
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.1 V0=0.05 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.1_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[t140] a=0.1 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.1 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.1_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.1
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
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.1 V0=0.05 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.1_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=0.1 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.1 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.2_v0.01_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.2 V0=0.01 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.2_v0.01_kz0.5.ini >> $LOG 2>&1) || echo "[t140] a=0.2 V0=0.01 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.2 V0=0.01 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.2_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.2
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
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.2 V0=0.01 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.2_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[t140] a=0.2 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.2 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.2_v0.01_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.2
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
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.2 V0=0.01 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.2_v0.01_kz2.5.ini >> $LOG 2>&1) || echo "[t140] a=0.2 V0=0.01 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.2 V0=0.01 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.2_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.2
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
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.2 V0=0.01 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.2_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[t140] a=0.2 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.2 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.2_v0.01_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.2
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
echo "[t140] a=0.2 V0=0.01 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.2_v0.01_kz7.0.ini >> $LOG 2>&1) || echo "[t140] a=0.2 V0=0.01 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.2 V0=0.01 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.2_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.2
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
echo "[t140] a=0.2 V0=0.01 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.2_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[t140] a=0.2 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.2 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.2_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.2
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
echo "[t140] a=0.2 V0=0.03 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.2_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[t140] a=0.2 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.2 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.2_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.2
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
echo "[t140] a=0.2 V0=0.03 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.2_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[t140] a=0.2 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.2 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.2_v0.03_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.2
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
echo "[t140] a=0.2 V0=0.03 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.2_v0.03_kz4.0.ini >> $LOG 2>&1) || echo "[t140] a=0.2 V0=0.03 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.2 V0=0.03 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.2_v0.03_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.2
V0 = 0.03
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
echo "[t140] a=0.2 V0=0.03 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.2_v0.03_kz5.0.ini >> $LOG 2>&1) || echo "[t140] a=0.2 V0=0.03 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.2 V0=0.03 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.2_v0.05_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.2
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
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.2 V0=0.05 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.2_v0.05_kz1.5.ini >> $LOG 2>&1) || echo "[t140] a=0.2 V0=0.05 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.2 V0=0.05 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.2_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.2
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
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.2 V0=0.05 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.2_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[t140] a=0.2 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.2 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.2_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.2 V0=0.05 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.2_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[t140] a=0.2 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.2 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.2_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.2
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
echo "[t140] a=0.2 V0=0.05 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.2_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[t140] a=0.2 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.2 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.3_v0.01_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.3
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
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.3 V0=0.01 kz=1.375 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.3_v0.01_kz1.375.ini >> $LOG 2>&1) || echo "[t140] a=0.3 V0=0.01 kz=1.375 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.3 V0=0.01 kz=1.375 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.3_v0.01_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.3
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
echo "[t140] a=0.3 V0=0.01 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.3_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[t140] a=0.3 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.3 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.3_v0.01_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.3
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
echo "[t140] a=0.3 V0=0.01 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.3_v0.01_kz6.5.ini >> $LOG 2>&1) || echo "[t140] a=0.3 V0=0.01 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.3 V0=0.01 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.3_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.3
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
target_tu = 230.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.3 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.3_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[t140] a=0.3 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.3 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.3_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 0.3
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
target_tu = 323.1
run_tag = suspectfix
EOINI
echo "[t140] a=0.3 V0=0.03 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.3_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[t140] a=0.3 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.3 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.3_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.3
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
echo "[t140] a=0.3 V0=0.03 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.3_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[t140] a=0.3 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.3 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.3_v0.03_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.3
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
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.3 V0=0.03 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.3_v0.03_kz6.5.ini >> $LOG 2>&1) || echo "[t140] a=0.3 V0=0.03 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.3 V0=0.03 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.3_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.3
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
target_tu = 316.4
run_tag = suspectfix
EOINI
echo "[t140] a=0.3 V0=0.05 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.3_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[t140] a=0.3 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.3 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.3_v0.05_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.3
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
echo "[t140] a=0.3 V0=0.05 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.3_v0.05_kz4.5.ini >> $LOG 2>&1) || echo "[t140] a=0.3 V0=0.05 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.3 V0=0.05 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.3_v0.05_kz7.0.ini <<'EOINI'
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
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.3 V0=0.05 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.3_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[t140] a=0.3 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.3 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.4_v0.01_kz3.0.ini <<'EOINI'
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
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.4 V0=0.01 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.4_v0.01_kz3.0.ini >> $LOG 2>&1) || echo "[t140] a=0.4 V0=0.01 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.4 V0=0.01 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.4_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.4
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
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.4 V0=0.01 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.4_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[t140] a=0.4 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.4 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.4_v0.01_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.4
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
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.4 V0=0.01 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.4_v0.01_kz5.5.ini >> $LOG 2>&1) || echo "[t140] a=0.4 V0=0.01 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.4 V0=0.01 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.4_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.4
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
echo "[t140] a=0.4 V0=0.01 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.4_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[t140] a=0.4 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.4 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.4_v0.01_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.4
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
echo "[t140] a=0.4 V0=0.01 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.4_v0.01_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=0.4 V0=0.01 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.4 V0=0.01 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.4_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.4
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
target_tu = 367.2
run_tag = suspectfix
EOINI
echo "[t140] a=0.4 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.4_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[t140] a=0.4 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.4 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.4_v0.03_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.4
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
echo "[t140] a=0.4 V0=0.03 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.4_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[t140] a=0.4 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.4 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.4_v0.05_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.4 V0=0.05 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.4_v0.05_kz0.25.ini >> $LOG 2>&1) || echo "[t140] a=0.4 V0=0.05 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.4 V0=0.05 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.4_v0.05_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.4
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
echo "[t140] a=0.4 V0=0.05 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.4_v0.05_kz6.5.ini >> $LOG 2>&1) || echo "[t140] a=0.4 V0=0.05 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.4 V0=0.05 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.5_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.5
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
target_tu = 260.8
run_tag = suspectfix
EOINI
echo "[t140] a=0.5 V0=0.01 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.5_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[t140] a=0.5 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.5 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.5_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.5
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
target_tu = 318.5
run_tag = suspectfix
EOINI
echo "[t140] a=0.5 V0=0.01 kz=1.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.5_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[t140] a=0.5 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.5 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.5_v0.01_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.5
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
echo "[t140] a=0.5 V0=0.01 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.5_v0.01_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=0.5 V0=0.01 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.5 V0=0.01 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.5_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.5
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
target_tu = 287.3
run_tag = suspectfix
EOINI
echo "[t140] a=0.5 V0=0.03 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.5_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[t140] a=0.5 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.5 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.5_v0.03_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.5
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
target_tu = 346.4
run_tag = suspectfix
EOINI
echo "[t140] a=0.5 V0=0.03 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.5_v0.03_kz4.0.ini >> $LOG 2>&1) || echo "[t140] a=0.5 V0=0.03 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.5 V0=0.03 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.5_v0.03_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.5
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
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.5 V0=0.03 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.5_v0.03_kz6.5.ini >> $LOG 2>&1) || echo "[t140] a=0.5 V0=0.03 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.5 V0=0.03 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.5_v0.03_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.5
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
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.5 V0=0.03 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.5_v0.03_kz7.5.ini >> $LOG 2>&1) || echo "[t140] a=0.5 V0=0.03 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.5 V0=0.03 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.5_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.5
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
echo "[t140] a=0.5 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.5_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=0.5 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.5 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.5_v0.05_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.5 V0=0.05 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.5_v0.05_kz0.25.ini >> $LOG 2>&1) || echo "[t140] a=0.5 V0=0.05 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.5 V0=0.05 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.5_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 52.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.5 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.5_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[t140] a=0.5 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.5 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.5_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 39.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 118.2
run_tag = suspectfix
EOINI
echo "[t140] a=0.5 V0=0.05 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.5_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[t140] a=0.5 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.5 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.5_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 135.2
run_tag = suspectfix
EOINI
echo "[t140] a=0.5 V0=0.05 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.5_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=0.5 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.5 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.5_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 222.6
run_tag = suspectfix
EOINI
echo "[t140] a=0.5 V0=0.05 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.5_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[t140] a=0.5 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.5 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.6_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.6
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
target_tu = 375.1
run_tag = suspectfix
EOINI
echo "[t140] a=0.6 V0=0.01 kz=2.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.6_v0.01_kz2.25.ini >> $LOG 2>&1) || echo "[t140] a=0.6 V0=0.01 kz=2.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.6 V0=0.01 kz=2.25 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.6_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.6
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
target_tu = 233.9
run_tag = suspectfix
EOINI
echo "[t140] a=0.6 V0=0.03 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.6_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[t140] a=0.6 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.6 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.6_v0.03_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.6
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
target_tu = 338.5
run_tag = suspectfix
EOINI
echo "[t140] a=0.6 V0=0.03 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.6_v0.03_kz5.5.ini >> $LOG 2>&1) || echo "[t140] a=0.6 V0=0.03 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.6 V0=0.03 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.6_v0.03_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.6
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
target_tu = 368.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.6 V0=0.03 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.6_v0.03_kz6.5.ini >> $LOG 2>&1) || echo "[t140] a=0.6 V0=0.03 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.6 V0=0.03 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.6_v0.03_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.6
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
target_tu = 381.9
run_tag = suspectfix
EOINI
echo "[t140] a=0.6 V0=0.03 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.6_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[t140] a=0.6 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.6 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.6_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 185.5
run_tag = suspectfix
EOINI
echo "[t140] a=0.6 V0=0.05 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.6_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[t140] a=0.6 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.6 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.6_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 262.2
run_tag = suspectfix
EOINI
echo "[t140] a=0.6 V0=0.05 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.6_v0.05_kz5.5.ini >> $LOG 2>&1) || echo "[t140] a=0.6 V0=0.05 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.6 V0=0.05 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.7_v0.01_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.7
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
target_tu = 251.6
run_tag = suspectfix
EOINI
echo "[t140] a=0.7 V0=0.01 kz=1.375 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.7_v0.01_kz1.375.ini >> $LOG 2>&1) || echo "[t140] a=0.7 V0=0.01 kz=1.375 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.7 V0=0.01 kz=1.375 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.7_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.7 V0=0.05 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.7_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[t140] a=0.7 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.7 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.7_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.7
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
target_tu = 155.4
run_tag = suspectfix
EOINI
echo "[t140] a=0.7 V0=0.05 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.7_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[t140] a=0.7 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.7 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.8_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.8 V0=0.03 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.8_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[t140] a=0.8 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.8 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.8_v0.03_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.8 V0=0.03 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.8_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[t140] a=0.8 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.8 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.8_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.8
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
target_tu = 175.5
run_tag = suspectfix
EOINI
echo "[t140] a=0.8 V0=0.03 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.8_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[t140] a=0.8 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.8 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.8_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.8
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
target_tu = 183.6
run_tag = suspectfix
EOINI
echo "[t140] a=0.8 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.8_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[t140] a=0.8 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.8 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.8_v0.03_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.8
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
target_tu = 276.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.8 V0=0.03 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.8_v0.03_kz6.5.ini >> $LOG 2>&1) || echo "[t140] a=0.8 V0=0.03 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.8 V0=0.03 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.8_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
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
echo "[t140] a=0.8 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.8_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[t140] a=0.8 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.8 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.8_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.8
V0 = 0.05
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
echo "[t140] a=0.8 V0=0.05 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.8_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[t140] a=0.8 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.8 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.8_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.8 V0=0.05 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.8_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[t140] a=0.8 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.8 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.8_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 139.2
run_tag = suspectfix
EOINI
echo "[t140] a=0.8 V0=0.05 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.8_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[t140] a=0.8 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.8 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.8_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 229.6
run_tag = suspectfix
EOINI
echo "[t140] a=0.8 V0=0.05 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.8_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[t140] a=0.8 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.8 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.9_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.9
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
target_tu = 276.4
run_tag = suspectfix
EOINI
echo "[t140] a=0.9 V0=0.01 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.9_v0.01_kz2.75.ini >> $LOG 2>&1) || echo "[t140] a=0.9 V0=0.01 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.9 V0=0.01 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.9_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.9
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
target_tu = 372.7
run_tag = suspectfix
EOINI
echo "[t140] a=0.9 V0=0.01 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.9_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[t140] a=0.9 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.9 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.9_v0.01_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.9
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
echo "[t140] a=0.9 V0=0.01 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.9_v0.01_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=0.9 V0=0.01 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.9 V0=0.01 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.9_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.9
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
echo "[t140] a=0.9 V0=0.03 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.9_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[t140] a=0.9 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.9 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.9_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.9
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
target_tu = 159.7
run_tag = suspectfix
EOINI
echo "[t140] a=0.9 V0=0.03 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.9_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[t140] a=0.9 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.9 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.9_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.9
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
target_tu = 272.2
run_tag = suspectfix
EOINI
echo "[t140] a=0.9 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.9_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=0.9 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.9 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.9_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.9
V0 = 0.05
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
echo "[t140] a=0.9 V0=0.05 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.9_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[t140] a=0.9 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.9 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.9_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 0.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 50.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=0.9 V0=0.05 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.9_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[t140] a=0.9 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.9 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.9_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.9
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
target_tu = 105.7
run_tag = suspectfix
EOINI
echo "[t140] a=0.9 V0=0.05 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.9_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[t140] a=0.9 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.9 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a0.9_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 123.7
run_tag = suspectfix
EOINI
echo "[t140] a=0.9 V0=0.05 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a0.9_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[t140] a=0.9 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=0.9 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.0_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.0 V0=0.01 kz=0.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.0_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[t140] a=1.0 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.0 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.0_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 40.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 150.8
run_tag = suspectfix
EOINI
echo "[t140] a=1.0 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.0_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=1.0 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.0 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.0_v0.01_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.0
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
echo "[t140] a=1.0 V0=0.01 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.0_v0.01_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=1.0 V0=0.01 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.0 V0=0.01 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.0_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.0 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.0_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[t140] a=1.0 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.0 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.0_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 1.0
V0 = 0.03
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
echo "[t140] a=1.0 V0=0.03 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.0_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[t140] a=1.0 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.0 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.0_v0.03_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.0
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
target_tu = 220.8
run_tag = suspectfix
EOINI
echo "[t140] a=1.0 V0=0.03 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.0_v0.03_kz6.5.ini >> $LOG 2>&1) || echo "[t140] a=1.0 V0=0.03 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.0 V0=0.03 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.0_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 52.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.0 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.0_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[t140] a=1.0 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.0 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.0_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.0 V0=0.05 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.0_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[t140] a=1.0 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.0 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.1_v0.01_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100.9
run_tag = suspectfix
EOINI
echo "[t140] a=1.1 V0=0.01 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.1_v0.01_kz0.5.ini >> $LOG 2>&1) || echo "[t140] a=1.1 V0=0.01 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.1 V0=0.01 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.1_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.1
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
target_tu = 304.9
run_tag = suspectfix
EOINI
echo "[t140] a=1.1 V0=0.01 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.1_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[t140] a=1.1 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.1 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.1_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.1
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
echo "[t140] a=1.1 V0=0.03 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.1_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[t140] a=1.1 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.1 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.1_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.1
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
echo "[t140] a=1.1 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.1_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=1.1 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.1 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.1_v0.05_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.1 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.1_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[t140] a=1.1 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.1 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.1_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.1 V0=0.05 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.1_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[t140] a=1.1 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.1 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.1_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 101.3
run_tag = suspectfix
EOINI
echo "[t140] a=1.1 V0=0.05 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.1_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[t140] a=1.1 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.1 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.2_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.2 V0=0.01 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.2_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[t140] a=1.2 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.2 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.2_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.2
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
target_tu = 110.2
run_tag = suspectfix
EOINI
echo "[t140] a=1.2 V0=0.01 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.2_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[t140] a=1.2 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.2 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.2_v0.01_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.2
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
target_tu = 216.6
run_tag = suspectfix
EOINI
echo "[t140] a=1.2 V0=0.01 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.2_v0.01_kz3.0.ini >> $LOG 2>&1) || echo "[t140] a=1.2 V0=0.01 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.2 V0=0.01 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.2_v0.03_kz1.0.ini <<'EOINI'
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
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.2 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.2_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=1.2 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.2 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.2_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.2
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
target_tu = 122.5
run_tag = suspectfix
EOINI
echo "[t140] a=1.2 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.2_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[t140] a=1.2 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.2 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.2_v0.05_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.2
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
echo "[t140] a=1.2 V0=0.05 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.2_v0.05_kz0.25.ini >> $LOG 2>&1) || echo "[t140] a=1.2 V0=0.05 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.2 V0=0.05 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.2_v0.05_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.2 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.2_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[t140] a=1.2 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.2 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.2_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.2
V0 = 0.05
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
echo "[t140] a=1.2 V0=0.05 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.2_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[t140] a=1.2 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.2 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.2_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.2
V0 = 0.05
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
echo "[t140] a=1.2 V0=0.05 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.2_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[t140] a=1.2 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.2 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.3_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.3
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
target_tu = 116.4
run_tag = suspectfix
EOINI
echo "[t140] a=1.3 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.3_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=1.3 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.3 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.3_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.3
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
target_tu = 163.4
run_tag = suspectfix
EOINI
echo "[t140] a=1.3 V0=0.01 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.3_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[t140] a=1.3 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.3 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.3_v0.01_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.3
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
target_tu = 199.9
run_tag = suspectfix
EOINI
echo "[t140] a=1.3 V0=0.01 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.3_v0.01_kz3.0.ini >> $LOG 2>&1) || echo "[t140] a=1.3 V0=0.01 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.3 V0=0.01 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.3_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.3
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
target_tu = 316.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.3 V0=0.01 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.3_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[t140] a=1.3 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.3 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.3_v0.03_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.3
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
echo "[t140] a=1.3 V0=0.03 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.3_v0.03_kz1.5.ini >> $LOG 2>&1) || echo "[t140] a=1.3 V0=0.03 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.3 V0=0.03 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.3_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.3
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
echo "[t140] a=1.3 V0=0.03 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.3_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[t140] a=1.3 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.3 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.3_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.3
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
echo "[t140] a=1.3 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.3_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[t140] a=1.3 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.3 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.3_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.3
V0 = 0.05
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
echo "[t140] a=1.3 V0=0.05 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.3_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[t140] a=1.3 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.3 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.3_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 35.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.3 V0=0.05 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.3_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[t140] a=1.3 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.3 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.4_v0.01_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.4
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
target_tu = 200.5
run_tag = suspectfix
EOINI
echo "[t140] a=1.4 V0=0.01 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.4_v0.01_kz3.5.ini >> $LOG 2>&1) || echo "[t140] a=1.4 V0=0.01 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.4 V0=0.01 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.4_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.4 V0=0.03 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.4_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[t140] a=1.4 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.4 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.4_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.4
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
echo "[t140] a=1.4 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.4_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=1.4 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.4 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.4_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.4
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
echo "[t140] a=1.4 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.4_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[t140] a=1.4 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.4 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.4_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 1.4
V0 = 0.05
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
echo "[t140] a=1.4 V0=0.05 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.4_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[t140] a=1.4 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.4 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.4_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 48.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.4 V0=0.05 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.4_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[t140] a=1.4 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.4 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.5_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.5
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
echo "[t140] a=1.5 V0=0.01 kz=0.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.5_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[t140] a=1.5 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.5 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.5_v0.01_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.5
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
target_tu = 245.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.5 V0=0.01 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.5_v0.01_kz6.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 V0=0.01 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.5 V0=0.01 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.5_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.5
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
echo "[t140] a=1.5 V0=0.03 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.5_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[t140] a=1.5 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.5 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.5_v0.05_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.5
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
echo "[t140] a=1.5 V0=0.05 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.5_v0.05_kz0.25.ini >> $LOG 2>&1) || echo "[t140] a=1.5 V0=0.05 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.5 V0=0.05 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.5_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 15.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.5 V0=0.05 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.5_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.5 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.5_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.5 V0=0.05 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.5_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[t140] a=1.5 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.5 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.6_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 20.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.6 V0=0.01 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.6_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[t140] a=1.6 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.6 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.6_v0.01_kz1.0.ini <<'EOINI'
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
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.6 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.6_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=1.6 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.6 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.6_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.6
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
echo "[t140] a=1.6 V0=0.03 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.6_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[t140] a=1.6 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.6 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.6_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 47.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.6 V0=0.03 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.6_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[t140] a=1.6 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.6 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.6_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 48.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.6 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.6_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[t140] a=1.6 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.6 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.6_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 1.6
V0 = 0.05
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
echo "[t140] a=1.6 V0=0.05 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.6_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[t140] a=1.6 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.6 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.6_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 46.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.6 V0=0.05 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.6_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[t140] a=1.6 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.6 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.6_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.6
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
echo "[t140] a=1.6 V0=0.05 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.6_v0.05_kz5.5.ini >> $LOG 2>&1) || echo "[t140] a=1.6 V0=0.05 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.6 V0=0.05 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.6_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 48.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 114.8
run_tag = suspectfix
EOINI
echo "[t140] a=1.6 V0=0.05 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.6_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[t140] a=1.6 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.6 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.7_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.7
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
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.7 V0=0.01 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.7_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[t140] a=1.7 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.7 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.7_v0.01_kz1.0.ini <<'EOINI'
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
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.7 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.7_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=1.7 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.7 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.7_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.7
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
echo "[t140] a=1.7 V0=0.01 kz=1.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.7_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[t140] a=1.7 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.7 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.7_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.7
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
target_tu = 176.5
run_tag = suspectfix
EOINI
echo "[t140] a=1.7 V0=0.01 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.7_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[t140] a=1.7 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.7 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.7_v0.01_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.7
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
target_tu = 206.9
run_tag = suspectfix
EOINI
echo "[t140] a=1.7 V0=0.01 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.7_v0.01_kz5.5.ini >> $LOG 2>&1) || echo "[t140] a=1.7 V0=0.01 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.7 V0=0.01 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.7_v0.01_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.7
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
target_tu = 216.1
run_tag = suspectfix
EOINI
echo "[t140] a=1.7 V0=0.01 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.7_v0.01_kz6.0.ini >> $LOG 2>&1) || echo "[t140] a=1.7 V0=0.01 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.7 V0=0.01 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.7_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.7
V0 = 0.03
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
echo "[t140] a=1.7 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.7_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[t140] a=1.7 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.7 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.7_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.7
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
echo "[t140] a=1.7 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.7_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[t140] a=1.7 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.7 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.7_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.7
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
target_tu = 144.1
run_tag = suspectfix
EOINI
echo "[t140] a=1.7 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.7_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=1.7 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.7 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.7_v0.05_kz1.0.ini <<'EOINI'
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
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.7 V0=0.05 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.7_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=1.7 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.7 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.7_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 42.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.7 V0=0.05 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.7_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[t140] a=1.7 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.7 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.8_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.8 V0=0.01 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.8_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[t140] a=1.8 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.8 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.8_v0.01_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.8
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
target_tu = 156.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.8 V0=0.01 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.8_v0.01_kz3.5.ini >> $LOG 2>&1) || echo "[t140] a=1.8 V0=0.01 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.8 V0=0.01 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.8_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.8
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
target_tu = 166.7
run_tag = suspectfix
EOINI
echo "[t140] a=1.8 V0=0.01 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.8_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[t140] a=1.8 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.8 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.8_v0.01_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.8
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
target_tu = 235.7
run_tag = suspectfix
EOINI
echo "[t140] a=1.8 V0=0.01 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.8_v0.01_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=1.8 V0=0.01 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.8 V0=0.01 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.8_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 42.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.8 V0=0.03 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.8_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[t140] a=1.8 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.8 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.8_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.8
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
echo "[t140] a=1.8 V0=0.03 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.8_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[t140] a=1.8 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.8 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.8_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.8
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
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.8 V0=0.03 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.8_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[t140] a=1.8 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.8 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.8_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.8
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
target_tu = 136.1
run_tag = suspectfix
EOINI
echo "[t140] a=1.8 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.8_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=1.8 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.8 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.8_v0.05_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.8
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
echo "[t140] a=1.8 V0=0.05 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.8_v0.05_kz1.5.ini >> $LOG 2>&1) || echo "[t140] a=1.8 V0=0.05 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.8 V0=0.05 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.8_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.8 V0=0.05 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.8_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[t140] a=1.8 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.8 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.9_v0.01_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.9 V0=0.01 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.9_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[t140] a=1.9 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.9 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.9_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.9
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
target_tu = 111.9
run_tag = suspectfix
EOINI
echo "[t140] a=1.9 V0=0.01 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.9_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[t140] a=1.9 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.9 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.9_v0.01_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.9
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
target_tu = 193.4
run_tag = suspectfix
EOINI
echo "[t140] a=1.9 V0=0.01 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.9_v0.01_kz6.0.ini >> $LOG 2>&1) || echo "[t140] a=1.9 V0=0.01 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.9 V0=0.01 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.9_v0.03_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.9
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
echo "[t140] a=1.9 V0=0.03 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.9_v0.03_kz1.5.ini >> $LOG 2>&1) || echo "[t140] a=1.9 V0=0.03 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.9 V0=0.03 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.9_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.9 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.9_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[t140] a=1.9 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.9 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.9_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.9 V0=0.05 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.9_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[t140] a=1.9 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.9 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a1.9_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=1.9 V0=0.05 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a1.9_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[t140] a=1.9 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=1.9 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.0_v0.01_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.0
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
echo "[t140] a=2.0 V0=0.01 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.0_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[t140] a=2.0 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.0 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.0_v0.01_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.0
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
target_tu = 118.7
run_tag = suspectfix
EOINI
echo "[t140] a=2.0 V0=0.01 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.0_v0.01_kz2.5.ini >> $LOG 2>&1) || echo "[t140] a=2.0 V0=0.01 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.0 V0=0.01 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.0_v0.01_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.0
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
target_tu = 175.9
run_tag = suspectfix
EOINI
echo "[t140] a=2.0 V0=0.01 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.0_v0.01_kz5.5.ini >> $LOG 2>&1) || echo "[t140] a=2.0 V0=0.01 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.0 V0=0.01 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.0_v0.01_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.0
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
target_tu = 183.7
run_tag = suspectfix
EOINI
echo "[t140] a=2.0 V0=0.01 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.0_v0.01_kz6.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 V0=0.01 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.0 V0=0.01 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.0_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.0 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.0_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[t140] a=2.0 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.0 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.0_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.0 V0=0.03 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.0_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[t140] a=2.0 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.0 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.0_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.0
V0 = 0.03
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
echo "[t140] a=2.0 V0=0.03 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.0_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.0 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.0_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.0
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
target_tu = 122.5
run_tag = suspectfix
EOINI
echo "[t140] a=2.0 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.0_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.0 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.0_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.0 V0=0.05 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.0_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[t140] a=2.0 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.0 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.1_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.1
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
target_tu = 142.9
run_tag = suspectfix
EOINI
echo "[t140] a=2.1 V0=0.01 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.1_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[t140] a=2.1 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.1 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.1_v0.01_kz4.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 151.6
run_tag = suspectfix
EOINI
echo "[t140] a=2.1 V0=0.01 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.1_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[t140] a=2.1 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.1 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.1_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.1
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
echo "[t140] a=2.1 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.1_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=2.1 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.1 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.1_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.1 V0=0.03 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.1_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[t140] a=2.1 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.1 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.1_v0.03_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.1
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
echo "[t140] a=2.1 V0=0.03 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.1_v0.03_kz2.5.ini >> $LOG 2>&1) || echo "[t140] a=2.1 V0=0.03 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.1 V0=0.03 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.1_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.1 V0=0.03 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.1_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[t140] a=2.1 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.1 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.1_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.1
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
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.1 V0=0.03 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.1_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[t140] a=2.1 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.1 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.1_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.1 V0=0.05 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.1_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[t140] a=2.1 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.1 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.1_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 49.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.1 V0=0.05 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.1_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=2.1 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.1 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.2_v0.01_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.2 V0=0.01 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.2_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[t140] a=2.2 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.2 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.2_v0.01_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.2
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
target_tu = 127.6
run_tag = suspectfix
EOINI
echo "[t140] a=2.2 V0=0.01 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.2_v0.01_kz3.5.ini >> $LOG 2>&1) || echo "[t140] a=2.2 V0=0.01 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.2 V0=0.01 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.2_v0.01_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.2
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
target_tu = 144.7
run_tag = suspectfix
EOINI
echo "[t140] a=2.2 V0=0.01 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.2_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[t140] a=2.2 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.2 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.2_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.2
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
target_tu = 152.5
run_tag = suspectfix
EOINI
echo "[t140] a=2.2 V0=0.01 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.2_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[t140] a=2.2 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.2 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.2_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.2
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
echo "[t140] a=2.2 V0=0.05 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.2_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=2.2 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.2 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.2_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.2
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
echo "[t140] a=2.2 V0=0.05 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.2_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[t140] a=2.2 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.2 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.2_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 47.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.2 V0=0.05 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.2_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[t140] a=2.2 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.2 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.2_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 31.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.2 V0=0.05 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.2_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[t140] a=2.2 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.2 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.3_v0.01_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.3
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
target_tu = 122.1
run_tag = suspectfix
EOINI
echo "[t140] a=2.3 V0=0.01 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.3_v0.01_kz3.5.ini >> $LOG 2>&1) || echo "[t140] a=2.3 V0=0.01 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.3 V0=0.01 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.3_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.3
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
target_tu = 130.5
run_tag = suspectfix
EOINI
echo "[t140] a=2.3 V0=0.01 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.3_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[t140] a=2.3 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.3 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.3_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.3
V0 = 0.03
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
echo "[t140] a=2.3 V0=0.03 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.3_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[t140] a=2.3 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.3 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.3_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.3
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
echo "[t140] a=2.3 V0=0.03 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.3_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[t140] a=2.3 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.3 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.3_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.3 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.3_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[t140] a=2.3 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.3 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.3_v0.03_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.3
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
target_tu = 103.1
run_tag = suspectfix
EOINI
echo "[t140] a=2.3 V0=0.03 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.3_v0.03_kz7.5.ini >> $LOG 2>&1) || echo "[t140] a=2.3 V0=0.03 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.3 V0=0.03 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.3_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.3
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
echo "[t140] a=2.3 V0=0.05 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.3_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[t140] a=2.3 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.3 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.3_v0.05_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.3 V0=0.05 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.3_v0.05_kz3.5.ini >> $LOG 2>&1) || echo "[t140] a=2.3 V0=0.05 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.3 V0=0.05 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.3_v0.05_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.3
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
echo "[t140] a=2.3 V0=0.05 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.3_v0.05_kz6.0.ini >> $LOG 2>&1) || echo "[t140] a=2.3 V0=0.05 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.3 V0=0.05 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.4_v0.01_kz1.125.ini <<'EOINI'
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
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.4 V0=0.01 kz=1.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.4_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[t140] a=2.4 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.4 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.4_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.4
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
echo "[t140] a=2.4 V0=0.03 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.4_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[t140] a=2.4 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.4 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.4_v0.03_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.4
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
echo "[t140] a=2.4 V0=0.03 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.4_v0.03_kz7.5.ini >> $LOG 2>&1) || echo "[t140] a=2.4 V0=0.03 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.4 V0=0.03 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.4_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.4
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
echo "[t140] a=2.4 V0=0.05 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.4_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[t140] a=2.4 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.4 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.4_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.4 V0=0.05 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.4_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[t140] a=2.4 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.4 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.4_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.4 V0=0.05 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.4_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[t140] a=2.4 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.4 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.4_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 31.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.4 V0=0.05 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.4_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[t140] a=2.4 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.4 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.4_v0.05_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.4 V0=0.05 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.4_v0.05_kz6.5.ini >> $LOG 2>&1) || echo "[t140] a=2.4 V0=0.05 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.4 V0=0.05 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.5_v0.01_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.5
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
target_tu = 104.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.5 V0=0.01 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.5_v0.01_kz3.0.ini >> $LOG 2>&1) || echo "[t140] a=2.5 V0=0.01 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.5 V0=0.01 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.5_v0.01_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.5
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
target_tu = 112.3
run_tag = suspectfix
EOINI
echo "[t140] a=2.5 V0=0.01 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.5_v0.01_kz3.5.ini >> $LOG 2>&1) || echo "[t140] a=2.5 V0=0.01 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.5 V0=0.01 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.5_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.5 V0=0.03 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.5_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[t140] a=2.5 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.5 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.5_v0.03_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.5
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
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.5 V0=0.03 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.5_v0.03_kz3.0.ini >> $LOG 2>&1) || echo "[t140] a=2.5 V0=0.03 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.5 V0=0.03 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.5_v0.03_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.5
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
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.5 V0=0.03 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.5_v0.03_kz6.0.ini >> $LOG 2>&1) || echo "[t140] a=2.5 V0=0.03 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.5 V0=0.03 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.5_v0.05_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.5
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
echo "[t140] a=2.5 V0=0.05 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.5_v0.05_kz0.25.ini >> $LOG 2>&1) || echo "[t140] a=2.5 V0=0.05 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.5 V0=0.05 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.5_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 52.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.5 V0=0.05 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.5_v0.05_kz5.5.ini >> $LOG 2>&1) || echo "[t140] a=2.5 V0=0.05 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.5 V0=0.05 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.6_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.6
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
target_tu = 129.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.6 V0=0.01 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.6_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[t140] a=2.6 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.6 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.6_v0.01_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.6
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
target_tu = 147.1
run_tag = suspectfix
EOINI
echo "[t140] a=2.6 V0=0.01 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.6_v0.01_kz6.5.ini >> $LOG 2>&1) || echo "[t140] a=2.6 V0=0.01 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.6 V0=0.01 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.6_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.6
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
echo "[t140] a=2.6 V0=0.03 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.6_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[t140] a=2.6 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.6 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.6_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.6 V0=0.03 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.6_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[t140] a=2.6 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.6 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.6_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.6
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
echo "[t140] a=2.6 V0=0.05 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.6_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[t140] a=2.6 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.6 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.6_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.6 V0=0.05 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.6_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[t140] a=2.6 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.6 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.6_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 50.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.6 V0=0.05 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.6_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[t140] a=2.6 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.6 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.6_v0.05_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 50.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.6 V0=0.05 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.6_v0.05_kz4.0.ini >> $LOG 2>&1) || echo "[t140] a=2.6 V0=0.05 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.6 V0=0.05 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.6_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 50.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.6 V0=0.05 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.6_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[t140] a=2.6 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.6 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.7_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.7
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
echo "[t140] a=2.7 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.7_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=2.7 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.7 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.7_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.7
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
target_tu = 111.2
run_tag = suspectfix
EOINI
echo "[t140] a=2.7 V0=0.01 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.7_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[t140] a=2.7 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.7 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.7_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.7
V0 = 0.03
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
echo "[t140] a=2.7 V0=0.03 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.7_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[t140] a=2.7 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.7 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.7_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.7
V0 = 0.03
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
echo "[t140] a=2.7 V0=0.03 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.7_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[t140] a=2.7 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.7 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.7_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 46.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.7 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.7_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[t140] a=2.7 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.7 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.7_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 48.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.7 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.7_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[t140] a=2.7 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.7 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.7_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 48.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.7 V0=0.05 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.7_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[t140] a=2.7 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.7 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.7_v0.05_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 48.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.7 V0=0.05 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.7_v0.05_kz6.5.ini >> $LOG 2>&1) || echo "[t140] a=2.7 V0=0.05 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.7 V0=0.05 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.7_v0.05_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 48.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.7 V0=0.05 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.7_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[t140] a=2.7 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.7 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.8_v0.01_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.8
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
echo "[t140] a=2.8 V0=0.01 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.8_v0.01_kz0.5.ini >> $LOG 2>&1) || echo "[t140] a=2.8 V0=0.01 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.8 V0=0.01 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.8_v0.01_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.8 V0=0.01 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.8_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[t140] a=2.8 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.8 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.8_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.8 V0=0.03 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.8_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[t140] a=2.8 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.8 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.8_v0.03_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.8
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
echo "[t140] a=2.8 V0=0.03 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.8_v0.03_kz3.0.ini >> $LOG 2>&1) || echo "[t140] a=2.8 V0=0.03 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.8 V0=0.03 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.8_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.8 V0=0.05 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.8_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[t140] a=2.8 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.8 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.8_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.8
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
echo "[t140] a=2.8 V0=0.05 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.8_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[t140] a=2.8 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.8 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.8_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.8
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
echo "[t140] a=2.8 V0=0.05 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.8_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=2.8 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.8 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.9_v0.01_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.9 V0=0.01 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.9_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[t140] a=2.9 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.9 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.9_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.9 V0=0.03 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.9_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[t140] a=2.9 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.9 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.9_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.9
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
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.9 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.9_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=2.9 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.9 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.9_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.9 V0=0.05 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.9_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[t140] a=2.9 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.9 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.9_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 53.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.9 V0=0.05 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.9_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[t140] a=2.9 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.9 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.9_v0.05_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 53.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.9 V0=0.05 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.9_v0.05_kz6.5.ini >> $LOG 2>&1) || echo "[t140] a=2.9 V0=0.05 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.9 V0=0.05 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a2.9_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 53.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=2.9 V0=0.05 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a2.9_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=2.9 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=2.9 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a3.0_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=3.0 V0=0.01 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a3.0_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[t140] a=3.0 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=3.0 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a3.0_v0.01_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 3.0
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
target_tu = 127.5
run_tag = suspectfix
EOINI
echo "[t140] a=3.0 V0=0.01 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a3.0_v0.01_kz6.5.ini >> $LOG 2>&1) || echo "[t140] a=3.0 V0=0.01 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=3.0 V0=0.01 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a3.0_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 3.0
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
target_tu = 136.9
run_tag = suspectfix
EOINI
echo "[t140] a=3.0 V0=0.01 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a3.0_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[t140] a=3.0 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=3.0 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a3.0_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=3.0 V0=0.03 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a3.0_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[t140] a=3.0 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=3.0 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a3.0_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 3.0
V0 = 0.03
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
echo "[t140] a=3.0 V0=0.03 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a3.0_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[t140] a=3.0 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=3.0 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a3.0_v0.03_kz9.0.ini <<'EOINI'
k_mode = 9
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=3.0 V0=0.03 kz=9.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a3.0_v0.03_kz9.0.ini >> $LOG 2>&1) || echo "[t140] a=3.0 V0=0.03 kz=9.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=3.0 V0=0.03 kz=9.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a3.0_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
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
echo "[t140] a=3.0 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a3.0_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[t140] a=3.0 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=3.0 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a3.0_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=3.0 V0=0.05 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a3.0_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[t140] a=3.0 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=3.0 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a3.0_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=3.0 V0=0.05 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a3.0_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[t140] a=3.0 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=3.0 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a3.0_v0.05_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=3.0 V0=0.05 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a3.0_v0.05_kz4.0.ini >> $LOG 2>&1) || echo "[t140] a=3.0 V0=0.05 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=3.0 V0=0.05 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a3.0_v0.05_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 51.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=3.0 V0=0.05 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a3.0_v0.05_kz6.5.ini >> $LOG 2>&1) || echo "[t140] a=3.0 V0=0.05 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=3.0 V0=0.05 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a4.0_v0.03_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 4.0
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
echo "[t140] a=4.0 V0=0.03 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a4.0_v0.03_kz5.0.ini >> $LOG 2>&1) || echo "[t140] a=4.0 V0=0.03 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=4.0 V0=0.03 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a4.0_v0.03_kz9.0.ini <<'EOINI'
k_mode = 9
alpha_YM = 4.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=4.0 V0=0.03 kz=9.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a4.0_v0.03_kz9.0.ini >> $LOG 2>&1) || echo "[t140] a=4.0 V0=0.03 kz=9.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=4.0 V0=0.03 kz=9.0 done $(date)" >> $LOG

cat > /tmp/sfx_t140_a5.0_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 5.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t140] a=5.0 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t140_a5.0_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=5.0 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t140] a=5.0 V0=0.03 kz=8.0 done $(date)" >> $LOG

echo "=== t140 ALL DONE $(date) ===" >> $LOG
