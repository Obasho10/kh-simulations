#!/bin/bash
# suspectfix campaign -- t126: 220 runs
# Launch: nohup bash scripts/suspectfix_wave2_t126.sh > logs/suspectfix_t126.log 2>&1 &
set -e
WDIR=/DATA/cm/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs
LOG=$WDIR/logs/suspectfix_t126_progress.log
echo "=== start $(date) ===" >> $LOG
cat > /tmp/sfx_t126_a0.1_v0.01_kz0.125.ini <<'EOINI'
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
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.1 V0=0.01 kz=0.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.1_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[t126] a=0.1 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.1 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.1_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.1 V0=0.01 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.1_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[t126] a=0.1 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.1 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.1_v0.01_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.1
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
echo "[t126] a=0.1 V0=0.01 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.1_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[t126] a=0.1 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.1 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.1_v0.01_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.1
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
echo "[t126] a=0.1 V0=0.01 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.1_v0.01_kz3.0.ini >> $LOG 2>&1) || echo "[t126] a=0.1 V0=0.01 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.1 V0=0.01 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.1_v0.01_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.1
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
echo "[t126] a=0.1 V0=0.01 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.1_v0.01_kz5.5.ini >> $LOG 2>&1) || echo "[t126] a=0.1 V0=0.01 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.1 V0=0.01 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.1_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.1
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
echo "[t126] a=0.1 V0=0.01 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.1_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[t126] a=0.1 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.1 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.1_v0.01_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.1
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
echo "[t126] a=0.1 V0=0.01 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.1_v0.01_kz8.0.ini >> $LOG 2>&1) || echo "[t126] a=0.1 V0=0.01 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.1 V0=0.01 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.1_v0.03_kz0.25.ini <<'EOINI'
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
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.1 V0=0.03 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.1_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[t126] a=0.1 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.1 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.1_v0.03_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.1
V0 = 0.03
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
echo "[t126] a=0.1 V0=0.03 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.1_v0.03_kz4.5.ini >> $LOG 2>&1) || echo "[t126] a=0.1 V0=0.03 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.1 V0=0.03 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.1_v0.05_kz0.875.ini <<'EOINI'
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
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.1 V0=0.05 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.1_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[t126] a=0.1 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.1 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.1_v0.05_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.1 V0=0.05 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.1_v0.05_kz1.5.ini >> $LOG 2>&1) || echo "[t126] a=0.1 V0=0.05 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.1 V0=0.05 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.1_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.1
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
echo "[t126] a=0.1 V0=0.05 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.1_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[t126] a=0.1 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.1 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.1_v0.05_kz7.0.ini <<'EOINI'
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
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.1 V0=0.05 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.1_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[t126] a=0.1 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.1 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.1_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.1
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
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.1 V0=0.05 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.1_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[t126] a=0.1 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.1 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.2_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.2
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
echo "[t126] a=0.2 V0=0.01 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.2_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[t126] a=0.2 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.2 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.2_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.2
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
echo "[t126] a=0.2 V0=0.01 kz=2.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.2_v0.01_kz2.25.ini >> $LOG 2>&1) || echo "[t126] a=0.2 V0=0.01 kz=2.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.2 V0=0.01 kz=2.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.2_v0.01_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.2 V0=0.01 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.2_v0.01_kz3.5.ini >> $LOG 2>&1) || echo "[t126] a=0.2 V0=0.01 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.2 V0=0.01 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.2_v0.01_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.2
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
echo "[t126] a=0.2 V0=0.01 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.2_v0.01_kz6.5.ini >> $LOG 2>&1) || echo "[t126] a=0.2 V0=0.01 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.2 V0=0.01 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.2_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.2
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
target_tu = 375.9
run_tag = suspectfix
EOINI
echo "[t126] a=0.2 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.2_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[t126] a=0.2 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.2 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.2_v0.03_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.2
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
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.2 V0=0.03 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.2_v0.03_kz1.5.ini >> $LOG 2>&1) || echo "[t126] a=0.2 V0=0.03 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.2 V0=0.03 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.2_v0.03_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.2 V0=0.03 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.2_v0.03_kz2.5.ini >> $LOG 2>&1) || echo "[t126] a=0.2 V0=0.03 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.2 V0=0.03 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.2_v0.05_kz0.875.ini <<'EOINI'
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
kz_suppress_hi = 55
target_tu = 314.5
run_tag = suspectfix
EOINI
echo "[t126] a=0.2 V0=0.05 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.2_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[t126] a=0.2 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.2 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.2_v0.05_kz5.0.ini <<'EOINI'
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
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.2 V0=0.05 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.2_v0.05_kz5.0.ini >> $LOG 2>&1) || echo "[t126] a=0.2 V0=0.05 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.2 V0=0.05 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.2_v0.05_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.2
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
echo "[t126] a=0.2 V0=0.05 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.2_v0.05_kz6.5.ini >> $LOG 2>&1) || echo "[t126] a=0.2 V0=0.05 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.2 V0=0.05 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.3_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 258.9
run_tag = suspectfix
EOINI
echo "[t126] a=0.3 V0=0.01 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.3_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[t126] a=0.3 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.3 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.3_v0.01_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.3
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
echo "[t126] a=0.3 V0=0.01 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.3_v0.01_kz3.5.ini >> $LOG 2>&1) || echo "[t126] a=0.3 V0=0.01 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.3 V0=0.01 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.3_v0.01_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.3
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
echo "[t126] a=0.3 V0=0.01 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.3_v0.01_kz7.0.ini >> $LOG 2>&1) || echo "[t126] a=0.3 V0=0.01 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.3 V0=0.01 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.3_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.3
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
echo "[t126] a=0.3 V0=0.01 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.3_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[t126] a=0.3 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.3 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.3_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.3
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
echo "[t126] a=0.3 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.3_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[t126] a=0.3 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.3 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.3_v0.03_kz5.0.ini <<'EOINI'
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
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.3 V0=0.03 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.3_v0.03_kz5.0.ini >> $LOG 2>&1) || echo "[t126] a=0.3 V0=0.03 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.3 V0=0.03 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.3_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 0.3
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
target_tu = 250.4
run_tag = suspectfix
EOINI
echo "[t126] a=0.3 V0=0.05 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.3_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[t126] a=0.3 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.3 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.3_v0.05_kz5.0.ini <<'EOINI'
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
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.3 V0=0.05 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.3_v0.05_kz5.0.ini >> $LOG 2>&1) || echo "[t126] a=0.3 V0=0.05 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.3 V0=0.05 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.3_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.3
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
echo "[t126] a=0.3 V0=0.05 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.3_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[t126] a=0.3 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.3 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.4_v0.01_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 0.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.4 V0=0.01 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.4_v0.01_kz1.75.ini >> $LOG 2>&1) || echo "[t126] a=0.4 V0=0.01 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.4 V0=0.01 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.4_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.4
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
target_tu = 350.8
run_tag = suspectfix
EOINI
echo "[t126] a=0.4 V0=0.03 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.4_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[t126] a=0.4 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.4 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.4_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.4
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
echo "[t126] a=0.4 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.4_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t126] a=0.4 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.4 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.4_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.4
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
target_tu = 284.4
run_tag = suspectfix
EOINI
echo "[t126] a=0.4 V0=0.05 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.4_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[t126] a=0.4 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.4 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.4_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.4
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
target_tu = 290.5
run_tag = suspectfix
EOINI
echo "[t126] a=0.4 V0=0.05 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.4_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[t126] a=0.4 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.4 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.4_v0.05_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.4
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
target_tu = 355.8
run_tag = suspectfix
EOINI
echo "[t126] a=0.4 V0=0.05 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.4_v0.05_kz4.5.ini >> $LOG 2>&1) || echo "[t126] a=0.4 V0=0.05 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.4 V0=0.05 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.4_v0.05_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.4
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
target_tu = 375.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.4 V0=0.05 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.4_v0.05_kz5.0.ini >> $LOG 2>&1) || echo "[t126] a=0.4 V0=0.05 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.4 V0=0.05 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.4_v0.05_kz7.0.ini <<'EOINI'
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
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.4 V0=0.05 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.4_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[t126] a=0.4 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.4 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.5_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.5
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
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.5 V0=0.01 kz=2.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.5_v0.01_kz2.125.ini >> $LOG 2>&1) || echo "[t126] a=0.5 V0=0.01 kz=2.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.5 V0=0.01 kz=2.125 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.5_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.5
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
echo "[t126] a=0.5 V0=0.01 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.5_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[t126] a=0.5 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.5 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.5_v0.03_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 126.6
run_tag = suspectfix
EOINI
echo "[t126] a=0.5 V0=0.03 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.5_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[t126] a=0.5 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.5 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.5_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.5
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
target_tu = 151.6
run_tag = suspectfix
EOINI
echo "[t126] a=0.5 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.5_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[t126] a=0.5 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.5 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.5_v0.03_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.5
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
target_tu = 324.1
run_tag = suspectfix
EOINI
echo "[t126] a=0.5 V0=0.03 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.5_v0.03_kz3.5.ini >> $LOG 2>&1) || echo "[t126] a=0.5 V0=0.03 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.5 V0=0.03 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.5_v0.05_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 52.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 328.6
run_tag = suspectfix
EOINI
echo "[t126] a=0.5 V0=0.05 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.5_v0.05_kz6.0.ini >> $LOG 2>&1) || echo "[t126] a=0.5 V0=0.05 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.5 V0=0.05 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.5_v0.05_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 52.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 355.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.5 V0=0.05 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.5_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[t126] a=0.5 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.5 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.6_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.6
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
echo "[t126] a=0.6 V0=0.01 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.6_v0.01_kz2.75.ini >> $LOG 2>&1) || echo "[t126] a=0.6 V0=0.01 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.6 V0=0.01 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.6_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.6
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
echo "[t126] a=0.6 V0=0.01 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.6_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[t126] a=0.6 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.6 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.6_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 45.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 116.9
run_tag = suspectfix
EOINI
echo "[t126] a=0.6 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.6_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[t126] a=0.6 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.6 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.6_v0.03_kz0.875.ini <<'EOINI'
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
kz_suppress_hi = 55
target_tu = 136.3
run_tag = suspectfix
EOINI
echo "[t126] a=0.6 V0=0.03 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.6_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[t126] a=0.6 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.6 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.6_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 125.7
run_tag = suspectfix
EOINI
echo "[t126] a=0.6 V0=0.05 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.6_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[t126] a=0.6 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.6 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.7_v0.01_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 154.8
run_tag = suspectfix
EOINI
echo "[t126] a=0.7 V0=0.01 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.7_v0.01_kz0.5.ini >> $LOG 2>&1) || echo "[t126] a=0.7 V0=0.01 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.7 V0=0.01 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.7_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.7
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
target_tu = 330.3
run_tag = suspectfix
EOINI
echo "[t126] a=0.7 V0=0.01 kz=2.375 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.7_v0.01_kz2.375.ini >> $LOG 2>&1) || echo "[t126] a=0.7 V0=0.01 kz=2.375 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.7 V0=0.01 kz=2.375 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.7_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.7
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
target_tu = 124.8
run_tag = suspectfix
EOINI
echo "[t126] a=0.7 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.7_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[t126] a=0.7 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.7 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.7_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.7
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
target_tu = 209.9
run_tag = suspectfix
EOINI
echo "[t126] a=0.7 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.7_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[t126] a=0.7 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.7 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.7_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.7
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
target_tu = 349.9
run_tag = suspectfix
EOINI
echo "[t126] a=0.7 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.7_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t126] a=0.7 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.7 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.7_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.7 V0=0.05 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.7_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[t126] a=0.7 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.7 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.7_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 37.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.7 V0=0.05 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.7_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[t126] a=0.7 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.7 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.7_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 0.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 127.1
run_tag = suspectfix
EOINI
echo "[t126] a=0.7 V0=0.05 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.7_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[t126] a=0.7 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.7 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.7_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.7
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
target_tu = 159.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.7 V0=0.05 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.7_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[t126] a=0.7 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.7 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.7_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 37.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 271.1
run_tag = suspectfix
EOINI
echo "[t126] a=0.7 V0=0.05 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.7_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[t126] a=0.7 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.7 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.8_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 20.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.8 V0=0.01 kz=0.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.8_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[t126] a=0.8 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.8 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.8_v0.03_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.8
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
target_tu = 133.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.8 V0=0.03 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.8_v0.03_kz1.5.ini >> $LOG 2>&1) || echo "[t126] a=0.8 V0=0.03 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.8 V0=0.03 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.9_v0.01_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.9
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
target_tu = 121.8
run_tag = suspectfix
EOINI
echo "[t126] a=0.9 V0=0.01 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.9_v0.01_kz0.5.ini >> $LOG 2>&1) || echo "[t126] a=0.9 V0=0.01 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.9 V0=0.01 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.9_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.9
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
target_tu = 243.1
run_tag = suspectfix
EOINI
echo "[t126] a=0.9 V0=0.01 kz=2.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.9_v0.01_kz2.125.ini >> $LOG 2>&1) || echo "[t126] a=0.9 V0=0.01 kz=2.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.9 V0=0.01 kz=2.125 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.9_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.9 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.9_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[t126] a=0.9 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.9 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.9_v0.03_kz1.0.ini <<'EOINI'
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
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.9 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.9_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[t126] a=0.9 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.9 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.9_v0.03_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.9
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
target_tu = 254.6
run_tag = suspectfix
EOINI
echo "[t126] a=0.9 V0=0.03 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.9_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[t126] a=0.9 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.9 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a0.9_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=0.9 V0=0.05 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a0.9_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[t126] a=0.9 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=0.9 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.0_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 45.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.0 V0=0.05 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.0_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[t126] a=1.0 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.0 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.1_v0.01_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 215.7
run_tag = suspectfix
EOINI
echo "[t126] a=1.1 V0=0.01 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.1_v0.01_kz2.5.ini >> $LOG 2>&1) || echo "[t126] a=1.1 V0=0.01 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.1 V0=0.01 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.1_v0.01_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.1
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
target_tu = 255.2
run_tag = suspectfix
EOINI
echo "[t126] a=1.1 V0=0.01 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.1_v0.01_kz3.5.ini >> $LOG 2>&1) || echo "[t126] a=1.1 V0=0.01 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.1 V0=0.01 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.1_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 41.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.1 V0=0.05 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.1_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[t126] a=1.1 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.1 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.1_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.1
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
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.1 V0=0.05 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.1_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[t126] a=1.1 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.1 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.2_v0.01_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.2
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
target_tu = 265.2
run_tag = suspectfix
EOINI
echo "[t126] a=1.2 V0=0.01 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.2_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[t126] a=1.2 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.2 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.2_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.2 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.2_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[t126] a=1.2 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.2 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.2_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.2
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
target_tu = 204.1
run_tag = suspectfix
EOINI
echo "[t126] a=1.2 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.2_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t126] a=1.2 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.2 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.2_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.2 V0=0.05 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.2_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[t126] a=1.2 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.2 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.2_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.2
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
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.2 V0=0.05 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.2_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[t126] a=1.2 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.2 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.3_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.3 V0=0.01 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.3_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[t126] a=1.3 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.3 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.3_v0.01_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.3 V0=0.01 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.3_v0.01_kz0.5.ini >> $LOG 2>&1) || echo "[t126] a=1.3 V0=0.01 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.3 V0=0.01 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.3_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.3
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
target_tu = 102.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.3 V0=0.01 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.3_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[t126] a=1.3 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.3 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.3_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.3
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
target_tu = 230.8
run_tag = suspectfix
EOINI
echo "[t126] a=1.3 V0=0.01 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.3_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[t126] a=1.3 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.3 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.3_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.3
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
target_tu = 108.1
run_tag = suspectfix
EOINI
echo "[t126] a=1.3 V0=0.03 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.3_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[t126] a=1.3 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.3 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.3_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 17.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.3 V0=0.05 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.3_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[t126] a=1.3 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.3 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.3_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 52.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.3 V0=0.05 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.3_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[t126] a=1.3 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.3 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.3_v0.05_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.3
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
target_tu = 136.5
run_tag = suspectfix
EOINI
echo "[t126] a=1.3 V0=0.05 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.3_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[t126] a=1.3 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.3 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.4_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.4 V0=0.01 kz=0.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.4_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[t126] a=1.4 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.4 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.4_v0.01_kz4.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 227.3
run_tag = suspectfix
EOINI
echo "[t126] a=1.4 V0=0.01 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.4_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[t126] a=1.4 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.4 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.4_v0.03_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.4 V0=0.03 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.4_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[t126] a=1.4 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.4 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.4_v0.05_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.4
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
echo "[t126] a=1.4 V0=0.05 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.4_v0.05_kz0.25.ini >> $LOG 2>&1) || echo "[t126] a=1.4 V0=0.05 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.4 V0=0.05 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.4_v0.05_kz1.0.ini <<'EOINI'
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
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.4 V0=0.05 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.4_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[t126] a=1.4 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.4 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.4_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 51.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.4 V0=0.05 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.4_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[t126] a=1.4 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.4 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.4_v0.05_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.4
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
target_tu = 122.2
run_tag = suspectfix
EOINI
echo "[t126] a=1.4 V0=0.05 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.4_v0.05_kz6.5.ini >> $LOG 2>&1) || echo "[t126] a=1.4 V0=0.05 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.4 V0=0.05 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.4_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.4
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
target_tu = 135.5
run_tag = suspectfix
EOINI
echo "[t126] a=1.4 V0=0.05 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.4_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[t126] a=1.4 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.4 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.5_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.5
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
echo "[t126] a=1.5 V0=0.03 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.5_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[t126] a=1.5 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.5 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.5_v0.03_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.5
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
echo "[t126] a=1.5 V0=0.03 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.5_v0.03_kz1.5.ini >> $LOG 2>&1) || echo "[t126] a=1.5 V0=0.03 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.5 V0=0.03 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.5_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.5 V0=0.05 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.5_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[t126] a=1.5 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.5 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.6_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.6
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
echo "[t126] a=1.6 V0=0.01 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.6_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[t126] a=1.6 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.6 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.6_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.6
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
target_tu = 187.5
run_tag = suspectfix
EOINI
echo "[t126] a=1.6 V0=0.01 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.6_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[t126] a=1.6 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.6 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.6_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.6
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
target_tu = 209.7
run_tag = suspectfix
EOINI
echo "[t126] a=1.6 V0=0.01 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.6_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[t126] a=1.6 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.6 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.6_v0.01_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.6
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
target_tu = 229.7
run_tag = suspectfix
EOINI
echo "[t126] a=1.6 V0=0.01 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.6_v0.01_kz6.0.ini >> $LOG 2>&1) || echo "[t126] a=1.6 V0=0.01 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.6 V0=0.01 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.6_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 20.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.6 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.6_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[t126] a=1.6 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.6 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.6_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.6
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
echo "[t126] a=1.6 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.6_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[t126] a=1.6 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.6 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.6_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 48.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.6 V0=0.05 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.6_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[t126] a=1.6 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.6 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.6_v0.05_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 48.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 102.7
run_tag = suspectfix
EOINI
echo "[t126] a=1.6 V0=0.05 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.6_v0.05_kz6.0.ini >> $LOG 2>&1) || echo "[t126] a=1.6 V0=0.05 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.6 V0=0.05 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.7_v0.01_kz4.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 187.2
run_tag = suspectfix
EOINI
echo "[t126] a=1.7 V0=0.01 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.7_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[t126] a=1.7 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.7 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.7_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.7
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
target_tu = 197.3
run_tag = suspectfix
EOINI
echo "[t126] a=1.7 V0=0.01 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.7_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[t126] a=1.7 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.7 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.7_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 44.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.7 V0=0.03 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.7_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[t126] a=1.7 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.7 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.7_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.7
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
echo "[t126] a=1.7 V0=0.03 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.7_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[t126] a=1.7 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.7 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.7_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.7 V0=0.05 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.7_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[t126] a=1.7 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.7 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.7_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 45.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.7 V0=0.05 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.7_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[t126] a=1.7 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.7 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.7_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 45.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.7 V0=0.05 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.7_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[t126] a=1.7 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.7 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.8_v0.01_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.8
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
target_tu = 102.6
run_tag = suspectfix
EOINI
echo "[t126] a=1.8 V0=0.01 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.8_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[t126] a=1.8 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.8 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.8_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.8
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
echo "[t126] a=1.8 V0=0.03 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.8_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[t126] a=1.8 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.8 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.8_v0.03_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.8
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
echo "[t126] a=1.8 V0=0.03 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.8_v0.03_kz1.5.ini >> $LOG 2>&1) || echo "[t126] a=1.8 V0=0.03 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.8 V0=0.03 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.8_v0.05_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.8
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
echo "[t126] a=1.8 V0=0.05 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.8_v0.05_kz0.25.ini >> $LOG 2>&1) || echo "[t126] a=1.8 V0=0.05 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.8 V0=0.05 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.8_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.8
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
echo "[t126] a=1.8 V0=0.05 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.8_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[t126] a=1.8 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.8 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.8_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 1.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.8 V0=0.05 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.8_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[t126] a=1.8 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.8 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.8_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.8
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
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.8 V0=0.05 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.8_v0.05_kz5.5.ini >> $LOG 2>&1) || echo "[t126] a=1.8 V0=0.05 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.8 V0=0.05 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.8_v0.05_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.8
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
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.8 V0=0.05 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.8_v0.05_kz6.5.ini >> $LOG 2>&1) || echo "[t126] a=1.8 V0=0.05 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.8 V0=0.05 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.9_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 1.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.9 V0=0.03 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.9_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[t126] a=1.9 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.9 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.9_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.9
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
echo "[t126] a=1.9 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.9_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[t126] a=1.9 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.9 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.9_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.9 V0=0.05 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.9_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[t126] a=1.9 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.9 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.9_v0.05_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.9 V0=0.05 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.9_v0.05_kz4.0.ini >> $LOG 2>&1) || echo "[t126] a=1.9 V0=0.05 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.9 V0=0.05 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.9_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.9 V0=0.05 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.9_v0.05_kz5.5.ini >> $LOG 2>&1) || echo "[t126] a=1.9 V0=0.05 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.9 V0=0.05 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a1.9_v0.05_kz7.0.ini <<'EOINI'
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
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=1.9 V0=0.05 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a1.9_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[t126] a=1.9 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=1.9 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.0_v0.01_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.0
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
target_tu = 140.4
run_tag = suspectfix
EOINI
echo "[t126] a=2.0 V0=0.01 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.0_v0.01_kz3.5.ini >> $LOG 2>&1) || echo "[t126] a=2.0 V0=0.01 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.0 V0=0.01 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.0_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.0
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
echo "[t126] a=2.0 V0=0.03 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.0_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[t126] a=2.0 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.0 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.0_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
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
echo "[t126] a=2.0 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.0_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[t126] a=2.0 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.0 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.0_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 34.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.0 V0=0.05 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.0_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[t126] a=2.0 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.0 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.1_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 15.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.1 V0=0.01 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.1_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[t126] a=2.1 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.1 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.1_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.1
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
echo "[t126] a=2.1 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.1_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[t126] a=2.1 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.1 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.1_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.1
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
target_tu = 101.3
run_tag = suspectfix
EOINI
echo "[t126] a=2.1 V0=0.01 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.1_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[t126] a=2.1 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.1 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.1_v0.01_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.1
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
target_tu = 175.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.1 V0=0.01 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.1_v0.01_kz6.0.ini >> $LOG 2>&1) || echo "[t126] a=2.1 V0=0.01 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.1 V0=0.01 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.1_v0.03_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.1
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
target_tu = 113.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.1 V0=0.03 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.1_v0.03_kz7.5.ini >> $LOG 2>&1) || echo "[t126] a=2.1 V0=0.03 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.1 V0=0.03 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.1_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 15.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.1 V0=0.05 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.1_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[t126] a=2.1 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.1 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.1_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 49.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.1 V0=0.05 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.1_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[t126] a=2.1 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.1 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.1_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 49.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.1 V0=0.05 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.1_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[t126] a=2.1 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.1 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.2_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.2
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
echo "[t126] a=2.2 V0=0.01 kz=0.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.2_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[t126] a=2.2 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.2 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.2_v0.01_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 108.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.2 V0=0.01 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.2_v0.01_kz2.5.ini >> $LOG 2>&1) || echo "[t126] a=2.2 V0=0.01 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.2 V0=0.01 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.2_v0.01_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.2
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
target_tu = 167.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.2 V0=0.01 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.2_v0.01_kz6.0.ini >> $LOG 2>&1) || echo "[t126] a=2.2 V0=0.01 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.2 V0=0.01 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.2_v0.03_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.2
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
echo "[t126] a=2.2 V0=0.03 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.2_v0.03_kz1.5.ini >> $LOG 2>&1) || echo "[t126] a=2.2 V0=0.03 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.2 V0=0.03 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.2_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 34.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.2 V0=0.03 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.2_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[t126] a=2.2 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.2 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.2_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 51.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.2 V0=0.03 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.2_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[t126] a=2.2 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.2 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.2_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.2
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
echo "[t126] a=2.2 V0=0.05 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.2_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[t126] a=2.2 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.2 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.2_v0.05_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 47.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.2 V0=0.05 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.2_v0.05_kz4.5.ini >> $LOG 2>&1) || echo "[t126] a=2.2 V0=0.05 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.2 V0=0.05 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.3_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.3 V0=0.01 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.3_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[t126] a=2.3 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.3 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.3_v0.01_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.3
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
echo "[t126] a=2.3 V0=0.01 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.3_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[t126] a=2.3 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.3 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.3_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.3
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
echo "[t126] a=2.3 V0=0.01 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.3_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[t126] a=2.3 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.3 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.3_v0.01_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.3
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
target_tu = 166.3
run_tag = suspectfix
EOINI
echo "[t126] a=2.3 V0=0.01 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.3_v0.01_kz6.5.ini >> $LOG 2>&1) || echo "[t126] a=2.3 V0=0.01 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.3 V0=0.01 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.3_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.3
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
echo "[t126] a=2.3 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.3_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[t126] a=2.3 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.3 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.3_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 51.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.3 V0=0.03 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.3_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[t126] a=2.3 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.3 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.3_v0.03_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.3
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
echo "[t126] a=2.3 V0=0.03 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.3_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[t126] a=2.3 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.3 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.3_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.3
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
target_tu = 106.5
run_tag = suspectfix
EOINI
echo "[t126] a=2.3 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.3_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t126] a=2.3 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.3 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.3_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 19.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.3 V0=0.05 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.3_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[t126] a=2.3 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.3 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.3_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.3
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
echo "[t126] a=2.3 V0=0.05 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.3_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[t126] a=2.3 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.3 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.3_v0.05_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.3
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
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.3 V0=0.05 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.3_v0.05_kz6.5.ini >> $LOG 2>&1) || echo "[t126] a=2.3 V0=0.05 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.3 V0=0.05 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.4_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.4
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
echo "[t126] a=2.4 V0=0.01 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.4_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[t126] a=2.4 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.4 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.4_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 31.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.4 V0=0.03 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.4_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[t126] a=2.4 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.4 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.4_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 47.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.4 V0=0.03 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.4_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[t126] a=2.4 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.4 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.4_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.4
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
echo "[t126] a=2.4 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.4_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[t126] a=2.4 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.4 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.4_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.4
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
echo "[t126] a=2.4 V0=0.05 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.4_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[t126] a=2.4 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.4 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.4_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.4 V0=0.05 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.4_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[t126] a=2.4 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.4 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.5_v0.01_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.5 V0=0.01 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.5_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[t126] a=2.5 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.5 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.5_v0.01_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.5
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
target_tu = 147.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.5 V0=0.01 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.5_v0.01_kz6.0.ini >> $LOG 2>&1) || echo "[t126] a=2.5 V0=0.01 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.5 V0=0.01 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.5_v0.01_kz7.0.ini <<'EOINI'
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
kz_suppress_hi = 14
target_tu = 158.8
run_tag = suspectfix
EOINI
echo "[t126] a=2.5 V0=0.01 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.5_v0.01_kz7.0.ini >> $LOG 2>&1) || echo "[t126] a=2.5 V0=0.01 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.5 V0=0.01 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.5_v0.03_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.5
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
echo "[t126] a=2.5 V0=0.03 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.5_v0.03_kz7.5.ini >> $LOG 2>&1) || echo "[t126] a=2.5 V0=0.03 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.5 V0=0.03 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.5_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.5 V0=0.05 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.5_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[t126] a=2.5 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.5 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.5_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.5 V0=0.05 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.5_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[t126] a=2.5 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.5 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.6_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.6
V0 = 0.01
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
echo "[t126] a=2.6 V0=0.01 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.6_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[t126] a=2.6 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.6 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.6_v0.01_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.6 V0=0.01 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.6_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[t126] a=2.6 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.6 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.6_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.6
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
echo "[t126] a=2.6 V0=0.01 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.6_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[t126] a=2.6 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.6 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.6_v0.01_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.6 V0=0.01 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.6_v0.01_kz2.5.ini >> $LOG 2>&1) || echo "[t126] a=2.6 V0=0.01 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.6 V0=0.01 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.6_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.6
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
target_tu = 115.4
run_tag = suspectfix
EOINI
echo "[t126] a=2.6 V0=0.01 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.6_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[t126] a=2.6 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.6 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.6_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.6
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
echo "[t126] a=2.6 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.6_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t126] a=2.6 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.6 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.6_v0.05_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.6
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
echo "[t126] a=2.6 V0=0.05 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.6_v0.05_kz0.25.ini >> $LOG 2>&1) || echo "[t126] a=2.6 V0=0.05 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.6 V0=0.05 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.6_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.6
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
echo "[t126] a=2.6 V0=0.05 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.6_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[t126] a=2.6 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.6 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.6_v0.05_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.6 V0=0.05 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.6_v0.05_kz1.5.ini >> $LOG 2>&1) || echo "[t126] a=2.6 V0=0.05 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.6 V0=0.05 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.7_v0.01_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.7 V0=0.01 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.7_v0.01_kz0.5.ini >> $LOG 2>&1) || echo "[t126] a=2.7 V0=0.01 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.7 V0=0.01 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.7_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.7 V0=0.01 kz=1.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.7_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[t126] a=2.7 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.7 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.7_v0.01_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.7
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
target_tu = 147.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.7 V0=0.01 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.7_v0.01_kz7.0.ini >> $LOG 2>&1) || echo "[t126] a=2.7 V0=0.01 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.7 V0=0.01 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.7_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.7
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
target_tu = 152.2
run_tag = suspectfix
EOINI
echo "[t126] a=2.7 V0=0.01 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.7_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[t126] a=2.7 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.7 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.7_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.7
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
echo "[t126] a=2.7 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.7_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t126] a=2.7 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.7 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.7_v0.05_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.7
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
echo "[t126] a=2.7 V0=0.05 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.7_v0.05_kz0.25.ini >> $LOG 2>&1) || echo "[t126] a=2.7 V0=0.05 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.7 V0=0.05 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.7_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.7
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
echo "[t126] a=2.7 V0=0.05 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.7_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[t126] a=2.7 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.7 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.7_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 48.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.7 V0=0.05 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.7_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[t126] a=2.7 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.7 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.7_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.7 V0=0.05 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.7_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[t126] a=2.7 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.7 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.8_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 52.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.8 V0=0.01 kz=1.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.8_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[t126] a=2.8 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.8 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.8_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.8
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
echo "[t126] a=2.8 V0=0.01 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.8_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[t126] a=2.8 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.8 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.8_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.8
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
target_tu = 107.2
run_tag = suspectfix
EOINI
echo "[t126] a=2.8 V0=0.01 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.8_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[t126] a=2.8 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.8 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.8_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.8 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.8_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[t126] a=2.8 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.8 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.8_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 19.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.8 V0=0.03 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.8_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[t126] a=2.8 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.8 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.8_v0.03_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.8 V0=0.03 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.8_v0.03_kz1.5.ini >> $LOG 2>&1) || echo "[t126] a=2.8 V0=0.03 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.8 V0=0.03 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.8_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.8
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
echo "[t126] a=2.8 V0=0.05 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.8_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[t126] a=2.8 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.8 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.8_v0.05_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.8
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
echo "[t126] a=2.8 V0=0.05 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.8_v0.05_kz1.5.ini >> $LOG 2>&1) || echo "[t126] a=2.8 V0=0.05 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.8 V0=0.05 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.8_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.8
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
echo "[t126] a=2.8 V0=0.05 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.8_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[t126] a=2.8 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.8 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.8_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.8
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
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.8 V0=0.05 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.8_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[t126] a=2.8 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.8 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.9_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.9
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
echo "[t126] a=2.9 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.9_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[t126] a=2.9 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.9 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.9_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 50.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.9 V0=0.01 kz=1.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.9_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[t126] a=2.9 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.9 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.9_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.9
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
target_tu = 115.7
run_tag = suspectfix
EOINI
echo "[t126] a=2.9 V0=0.01 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.9_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[t126] a=2.9 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.9 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.9_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.9
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
echo "[t126] a=2.9 V0=0.03 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.9_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[t126] a=2.9 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.9 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a2.9_v0.05_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 53.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=2.9 V0=0.05 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a2.9_v0.05_kz4.0.ini >> $LOG 2>&1) || echo "[t126] a=2.9 V0=0.05 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=2.9 V0=0.05 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a3.0_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 35.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=3.0 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a3.0_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[t126] a=3.0 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=3.0 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a3.0_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 48.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=3.0 V0=0.01 kz=1.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a3.0_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[t126] a=3.0 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=3.0 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a3.0_v0.01_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 3.0
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
target_tu = 122.5
run_tag = suspectfix
EOINI
echo "[t126] a=3.0 V0=0.01 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a3.0_v0.01_kz6.0.ini >> $LOG 2>&1) || echo "[t126] a=3.0 V0=0.01 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=3.0 V0=0.01 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a3.0_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
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
echo "[t126] a=3.0 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a3.0_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[t126] a=3.0 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=3.0 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a3.0_v0.03_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 3.0
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
echo "[t126] a=3.0 V0=0.03 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a3.0_v0.03_kz2.5.ini >> $LOG 2>&1) || echo "[t126] a=3.0 V0=0.03 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=3.0 V0=0.03 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a3.0_v0.03_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 3.0
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
echo "[t126] a=3.0 V0=0.03 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a3.0_v0.03_kz4.0.ini >> $LOG 2>&1) || echo "[t126] a=3.0 V0=0.03 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=3.0 V0=0.03 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a3.0_v0.03_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 3.0
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
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=3.0 V0=0.03 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a3.0_v0.03_kz5.5.ini >> $LOG 2>&1) || echo "[t126] a=3.0 V0=0.03 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=3.0 V0=0.03 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a3.0_v0.03_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=3.0 V0=0.03 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a3.0_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[t126] a=3.0 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=3.0 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a3.0_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 3.0
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
echo "[t126] a=3.0 V0=0.05 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a3.0_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[t126] a=3.0 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=3.0 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a3.0_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=3.0 V0=0.05 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a3.0_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[t126] a=3.0 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=3.0 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a3.0_v0.05_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 51.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=3.0 V0=0.05 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a3.0_v0.05_kz3.5.ini >> $LOG 2>&1) || echo "[t126] a=3.0 V0=0.05 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=3.0 V0=0.05 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a3.0_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 51.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=3.0 V0=0.05 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a3.0_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[t126] a=3.0 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=3.0 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a4.0_v0.03_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 4.0
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
echo "[t126] a=4.0 V0=0.03 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a4.0_v0.03_kz3.0.ini >> $LOG 2>&1) || echo "[t126] a=4.0 V0=0.03 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=4.0 V0=0.03 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a5.0_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 5.0
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
echo "[t126] a=5.0 V0=0.03 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a5.0_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[t126] a=5.0 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=5.0 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t126_a5.0_v0.03_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 5.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t126] a=5.0 V0=0.03 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t126_a5.0_v0.03_kz6.0.ini >> $LOG 2>&1) || echo "[t126] a=5.0 V0=0.03 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
echo "[t126] a=5.0 V0=0.03 kz=6.0 done $(date)" >> $LOG

echo "=== t126 ALL DONE $(date) ===" >> $LOG
