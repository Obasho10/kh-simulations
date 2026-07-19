#!/bin/bash
# suspectfix campaign -- t130: 272 runs
# Launch: nohup bash scripts/suspectfix_rebuilt_t130.sh > logs/suspectfix_t130.log 2>&1 &
set -e
WDIR=/DATA/cm/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs
LOG=$WDIR/logs/suspectfix_t130_progress.log
echo "=== start $(date) ===" >> $LOG
cat > /tmp/sfx_t130_a0.8_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.8 V0=0.05 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.8_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[t130] a=0.8 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.800_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.8 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.9_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.9 V0=0.05 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.9_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[t130] a=0.9 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.900_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.9 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.0_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.0 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.0_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[t130] a=1.0 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.000_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.0 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.3_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.3 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.3_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[t130] a=1.3 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.300_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.3 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.3_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.3 V0=0.05 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.3_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[t130] a=1.3 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.300_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.3 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.4_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.4 V0=0.05 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.4_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[t130] a=1.4 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.400_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.4 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.5_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.5 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.5_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[t130] a=1.5 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.500_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.5 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.6_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.6 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.6_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[t130] a=1.6 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.600_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.6 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.6_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.6 V0=0.03 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.6_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[t130] a=1.6 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.600_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.6 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.6_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.6 V0=0.05 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.6_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[t130] a=1.6 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.600_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.6 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.7_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.7 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.7_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[t130] a=1.7 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.700_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.7 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.8_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.8 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.8_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[t130] a=1.8 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.800_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.8 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.8_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.8 V0=0.05 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.8_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[t130] a=1.8 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.800_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.8 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.0_v0.03_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.0 V0=0.03 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.0_v0.03_kz4.0.ini >> $LOG 2>&1) || echo "[t130] a=2.0 V0=0.03 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.000_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.0 V0=0.03 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.1_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.1 V0=0.05 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.1_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[t130] a=2.1 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.100_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.1 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.2_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.2 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.2_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[t130] a=2.2 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.200_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.2 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.2_v0.05_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.2 V0=0.05 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.2_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[t130] a=2.2 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.200_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.2 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.3_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.3 V0=0.03 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.3_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[t130] a=2.3 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.300_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.3 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.4_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.4 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.4_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[t130] a=2.4 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.400_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.4 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.4_v0.05_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.4 V0=0.05 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.4_v0.05_kz4.0.ini >> $LOG 2>&1) || echo "[t130] a=2.4 V0=0.05 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.400_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.4 V0=0.05 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.5_v0.03_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.5 V0=0.03 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.5_v0.03_kz3.0.ini >> $LOG 2>&1) || echo "[t130] a=2.5 V0=0.03 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.500_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.5 V0=0.03 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.5_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.5 V0=0.05 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.5_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[t130] a=2.5 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.500_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.5 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.6_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.6 V0=0.03 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.6_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[t130] a=2.6 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.600_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.6 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.6_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.6 V0=0.05 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.6_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[t130] a=2.6 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.600_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.6 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.6_v0.05_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.6 V0=0.05 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.6_v0.05_kz4.0.ini >> $LOG 2>&1) || echo "[t130] a=2.6 V0=0.05 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.600_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.6 V0=0.05 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.6_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.6 V0=0.05 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.6_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[t130] a=2.6 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a2.600_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.6 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.7_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.7 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.7_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[t130] a=2.7 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.700_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.7 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.7_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.7 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.7_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t130] a=2.7 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a2.700_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.7 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.8_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.8 V0=0.01 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.8_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[t130] a=2.8 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.800_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.8 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.8_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.8 V0=0.03 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.8_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[t130] a=2.8 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.800_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.8 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.8_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.8 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.8_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t130] a=2.8 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a2.800_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.8 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.8_v0.05_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.8 V0=0.05 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.8_v0.05_kz4.0.ini >> $LOG 2>&1) || echo "[t130] a=2.8 V0=0.05 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.800_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.8 V0=0.05 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.9_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.9 V0=0.03 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.9_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[t130] a=2.9 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.900_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.9 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.9_v0.05_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.9 V0=0.05 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.9_v0.05_kz5.0.ini >> $LOG 2>&1) || echo "[t130] a=2.9 V0=0.05 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.900_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.9 V0=0.05 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a3.0_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=3.0 V0=0.03 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a3.0_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[t130] a=3.0 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a3.000_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=3.0 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a3.0_v0.03_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=3.0 V0=0.03 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a3.0_v0.03_kz5.0.ini >> $LOG 2>&1) || echo "[t130] a=3.0 V0=0.03 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a3.000_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=3.0 V0=0.03 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a3.0_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=3.0 V0=0.05 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a3.0_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[t130] a=3.0 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a3.000_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=3.0 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a3.0_v0.05_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=3.0 V0=0.05 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a3.0_v0.05_kz4.0.ini >> $LOG 2>&1) || echo "[t130] a=3.0 V0=0.05 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a3.000_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=3.0 V0=0.05 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a4.0_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 4.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=4.0 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a4.0_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t130] a=4.0 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a4.000_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=4.0 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a5.0_v0.03_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 5.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=5.0 V0=0.03 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a5.0_v0.03_kz3.0.ini >> $LOG 2>&1) || echo "[t130] a=5.0 V0=0.03 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a5.000_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=5.0 V0=0.03 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a5.0_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 5.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=5.0 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a5.0_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t130] a=5.0 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a5.000_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=5.0 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a3.0_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.1
run_tag = suspectfix
EOINI
echo "[t130] a=3.0 V0=0.01 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a3.0_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[t130] a=3.0 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a3.000_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=3.0 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.4_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 102.1
run_tag = suspectfix
EOINI
echo "[t130] a=2.4 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.4_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t130] a=2.4 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a2.400_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.4 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.6_v0.05_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 102.7
run_tag = suspectfix
EOINI
echo "[t130] a=1.6 V0=0.05 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.6_v0.05_kz6.0.ini >> $LOG 2>&1) || echo "[t130] a=1.6 V0=0.05 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.600_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.6 V0=0.05 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.0_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 106.3
run_tag = suspectfix
EOINI
echo "[t130] a=2.0 V0=0.01 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.0_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[t130] a=2.0 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.000_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.0 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.2_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 111.4
run_tag = suspectfix
EOINI
echo "[t130] a=2.2 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.2_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t130] a=2.2 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a2.200_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.2 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.7_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 111.6
run_tag = suspectfix
EOINI
echo "[t130] a=1.7 V0=0.05 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.7_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[t130] a=1.7 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.700_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.7 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.8_v0.03_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 117.9
run_tag = suspectfix
EOINI
echo "[t130] a=1.8 V0=0.03 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.8_v0.03_kz6.0.ini >> $LOG 2>&1) || echo "[t130] a=1.8 V0=0.03 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.800_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.8 V0=0.03 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.6_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 118.6
run_tag = suspectfix
EOINI
echo "[t130] a=1.6 V0=0.05 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.6_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[t130] a=1.6 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.600_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.6 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a3.0_v0.01_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 122.5
run_tag = suspectfix
EOINI
echo "[t130] a=3.0 V0=0.01 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a3.0_v0.01_kz6.0.ini >> $LOG 2>&1) || echo "[t130] a=3.0 V0=0.01 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a3.000_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=3.0 V0=0.01 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.2_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 126.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.2 V0=0.01 kz=1.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.2_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[t130] a=1.2 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.200_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.2 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.0_v0.01_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 130.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.0 V0=0.01 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.0_v0.01_kz3.0.ini >> $LOG 2>&1) || echo "[t130] a=2.0 V0=0.01 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.000_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.0 V0=0.01 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.7_v0.03_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 134.8
run_tag = suspectfix
EOINI
echo "[t130] a=1.7 V0=0.03 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.7_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[t130] a=1.7 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.700_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.7 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.3_v0.05_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 136.5
run_tag = suspectfix
EOINI
echo "[t130] a=1.3 V0=0.05 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.3_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[t130] a=1.3 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.300_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.3 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.5_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 141.6
run_tag = suspectfix
EOINI
echo "[t130] a=1.5 V0=0.01 kz=2.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.5_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[t130] a=1.5 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.500_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.5 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.7_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 144.1
run_tag = suspectfix
EOINI
echo "[t130] a=1.7 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.7_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t130] a=1.7 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.700_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.7 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.7_v0.01_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 147.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.7 V0=0.01 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.7_v0.01_kz7.0.ini >> $LOG 2>&1) || echo "[t130] a=2.7 V0=0.01 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.700_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.7 V0=0.01 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.9_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 157.9
run_tag = suspectfix
EOINI
echo "[t130] a=1.9 V0=0.01 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.9_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[t130] a=1.9 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a1.900_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.9 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.1_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 159.7
run_tag = suspectfix
EOINI
echo "[t130] a=2.1 V0=0.01 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.1_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[t130] a=2.1 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.100_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.1 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.5_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 163.3
run_tag = suspectfix
EOINI
echo "[t130] a=1.5 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.5_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t130] a=1.5 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.500_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.5 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.5_v0.03_kz9.0.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 173.2
run_tag = suspectfix
EOINI
echo "[t130] a=1.5 V0=0.03 kz=9.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.5_v0.03_kz9.0.ini >> $LOG 2>&1) || echo "[t130] a=1.5 V0=0.03 kz=9.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.500_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.5 V0=0.03 kz=9.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.4_v0.01_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 185.7
run_tag = suspectfix
EOINI
echo "[t130] a=1.4 V0=0.01 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.4_v0.01_kz3.0.ini >> $LOG 2>&1) || echo "[t130] a=1.4 V0=0.01 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.400_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.4 V0=0.01 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.8_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 186.4
run_tag = suspectfix
EOINI
echo "[t130] a=1.8 V0=0.01 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.8_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[t130] a=1.8 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.800_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.8 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.3_v0.01_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 199.9
run_tag = suspectfix
EOINI
echo "[t130] a=1.3 V0=0.01 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.3_v0.01_kz3.0.ini >> $LOG 2>&1) || echo "[t130] a=1.3 V0=0.01 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.300_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.3 V0=0.01 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.6_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.6 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.6_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[t130] a=0.6 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.600_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.6 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.9_v0.05_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.9 V0=0.05 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.9_v0.05_kz1.5.ini >> $LOG 2>&1) || echo "[t130] a=0.9 V0=0.05 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a0.900_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.9 V0=0.05 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.0_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.0 V0=0.03 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.0_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[t130] a=1.0 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.000_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.0 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.2_v0.01_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.2 V0=0.01 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.2_v0.01_kz0.5.ini >> $LOG 2>&1) || echo "[t130] a=1.2 V0=0.01 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.200_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.2 V0=0.01 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.3_v0.05_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.3 V0=0.05 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.3_v0.05_kz1.5.ini >> $LOG 2>&1) || echo "[t130] a=1.3 V0=0.05 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.300_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.3 V0=0.05 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.3_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.3 V0=0.05 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.3_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[t130] a=1.3 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.300_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.3 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.4_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.4 V0=0.03 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.4_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[t130] a=1.4 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.400_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.4 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.4_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.4 V0=0.05 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.4_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[t130] a=1.4 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.400_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.4 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.5_v0.05_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.5 V0=0.05 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.5_v0.05_kz1.5.ini >> $LOG 2>&1) || echo "[t130] a=1.5 V0=0.05 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.500_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.5 V0=0.05 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.5_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.5 V0=0.05 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.5_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[t130] a=1.5 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.500_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.5 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.6_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.6 V0=0.05 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.6_v0.05_kz5.5.ini >> $LOG 2>&1) || echo "[t130] a=1.6 V0=0.05 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a1.600_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.6 V0=0.05 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.7_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.7 V0=0.03 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.7_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[t130] a=1.7 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.700_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.7 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.8_v0.05_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.8 V0=0.05 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.8_v0.05_kz6.5.ini >> $LOG 2>&1) || echo "[t130] a=1.8 V0=0.05 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.800_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.8 V0=0.05 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.1_v0.05_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.1 V0=0.05 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.1_v0.05_kz1.5.ini >> $LOG 2>&1) || echo "[t130] a=2.1 V0=0.05 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.100_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.1 V0=0.05 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.1_v0.05_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.1 V0=0.05 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.1_v0.05_kz4.5.ini >> $LOG 2>&1) || echo "[t130] a=2.1 V0=0.05 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.100_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.1 V0=0.05 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.1_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.1 V0=0.05 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.1_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[t130] a=2.1 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.100_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.1 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.2_v0.01_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.2 V0=0.01 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.2_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[t130] a=2.2 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.200_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.2 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.2_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.2 V0=0.03 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.2_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[t130] a=2.2 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.200_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.2 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.2_v0.03_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.2 V0=0.03 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.2_v0.03_kz2.5.ini >> $LOG 2>&1) || echo "[t130] a=2.2 V0=0.03 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.200_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.2 V0=0.03 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.3_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.3 V0=0.03 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.3_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[t130] a=2.3 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.300_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.3 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.3_v0.03_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.3 V0=0.03 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.3_v0.03_kz2.5.ini >> $LOG 2>&1) || echo "[t130] a=2.3 V0=0.03 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.300_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.3 V0=0.03 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.3_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.3 V0=0.05 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.3_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[t130] a=2.3 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.300_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.3 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.3_v0.05_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.3 V0=0.05 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.3_v0.05_kz3.5.ini >> $LOG 2>&1) || echo "[t130] a=2.3 V0=0.05 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.300_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.3 V0=0.05 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.3_v0.05_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.3 V0=0.05 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.3_v0.05_kz6.5.ini >> $LOG 2>&1) || echo "[t130] a=2.3 V0=0.05 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.300_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.3 V0=0.05 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.4_v0.03_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.4 V0=0.03 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.4_v0.03_kz2.5.ini >> $LOG 2>&1) || echo "[t130] a=2.4 V0=0.03 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.400_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.4 V0=0.03 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.4_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.4 V0=0.05 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.4_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[t130] a=2.4 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.400_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.4 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.5_v0.05_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.5 V0=0.05 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.5_v0.05_kz3.5.ini >> $LOG 2>&1) || echo "[t130] a=2.5 V0=0.05 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.500_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.5 V0=0.05 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.6_v0.03_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.6 V0=0.03 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.6_v0.03_kz2.5.ini >> $LOG 2>&1) || echo "[t130] a=2.6 V0=0.03 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.600_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.6 V0=0.03 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.6_v0.03_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.6 V0=0.03 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.6_v0.03_kz7.5.ini >> $LOG 2>&1) || echo "[t130] a=2.6 V0=0.03 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.600_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.6 V0=0.03 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.6_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.6 V0=0.05 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.6_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[t130] a=2.6 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.600_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.6 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.7_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.7 V0=0.05 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.7_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[t130] a=2.7 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.700_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.7 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.7_v0.05_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.7 V0=0.05 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.7_v0.05_kz6.5.ini >> $LOG 2>&1) || echo "[t130] a=2.7 V0=0.05 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.700_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.7 V0=0.05 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.8_v0.03_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.8 V0=0.03 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.8_v0.03_kz1.5.ini >> $LOG 2>&1) || echo "[t130] a=2.8 V0=0.03 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.800_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.8 V0=0.03 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.8_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.8 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.8_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[t130] a=2.8 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.800_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.8 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.8_v0.05_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.8 V0=0.05 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.8_v0.05_kz3.5.ini >> $LOG 2>&1) || echo "[t130] a=2.8 V0=0.05 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.800_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.8 V0=0.05 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.9_v0.01_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.9 V0=0.01 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.9_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[t130] a=2.9 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.900_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.9 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.9_v0.03_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.9 V0=0.03 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.9_v0.03_kz1.5.ini >> $LOG 2>&1) || echo "[t130] a=2.9 V0=0.03 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.900_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.9 V0=0.03 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.9_v0.03_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.9 V0=0.03 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.9_v0.03_kz7.5.ini >> $LOG 2>&1) || echo "[t130] a=2.9 V0=0.03 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.900_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.9 V0=0.03 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.9_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.9 V0=0.05 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.9_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[t130] a=2.9 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.900_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.9 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.9_v0.05_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.9 V0=0.05 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.9_v0.05_kz6.5.ini >> $LOG 2>&1) || echo "[t130] a=2.9 V0=0.05 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.900_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.9 V0=0.05 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a3.0_v0.01_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=3.0 V0=0.01 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a3.0_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[t130] a=3.0 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a3.000_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=3.0 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a3.0_v0.03_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=3.0 V0=0.03 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a3.0_v0.03_kz5.5.ini >> $LOG 2>&1) || echo "[t130] a=3.0 V0=0.03 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a3.000_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=3.0 V0=0.03 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.1_v0.01_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 202.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.1 V0=0.01 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.1_v0.01_kz8.0.ini >> $LOG 2>&1) || echo "[t130] a=2.1 V0=0.01 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a2.100_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.1 V0=0.01 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.3_v0.01_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 103.3
run_tag = suspectfix
EOINI
echo "[t130] a=2.3 V0=0.01 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.3_v0.01_kz2.5.ini >> $LOG 2>&1) || echo "[t130] a=2.3 V0=0.01 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.300_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.3 V0=0.01 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.4_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 214.3
run_tag = suspectfix
EOINI
echo "[t130] a=1.4 V0=0.01 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.4_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[t130] a=1.4 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a1.400_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.4 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.6_v0.01_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 108.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.6 V0=0.01 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.6_v0.01_kz3.5.ini >> $LOG 2>&1) || echo "[t130] a=2.6 V0=0.01 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.600_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.6 V0=0.01 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.7_v0.01_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 108.6
run_tag = suspectfix
EOINI
echo "[t130] a=1.7 V0=0.01 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.7_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[t130] a=1.7 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.700_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.7 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.1_v0.03_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 113.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.1 V0=0.03 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.1_v0.03_kz7.5.ini >> $LOG 2>&1) || echo "[t130] a=2.1 V0=0.03 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.100_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.1 V0=0.03 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.3_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 230.8
run_tag = suspectfix
EOINI
echo "[t130] a=1.3 V0=0.01 kz=4.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.3_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[t130] a=1.3 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a1.300_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.3 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.5_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 232.4
run_tag = suspectfix
EOINI
echo "[t130] a=0.5 V0=0.05 kz=3.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.5_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[t130] a=0.5 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a0.500_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.5 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.8_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 237.2
run_tag = suspectfix
EOINI
echo "[t130] a=0.8 V0=0.05 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.8_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[t130] a=0.8 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a0.800_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.8 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.3_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 121.1
run_tag = suspectfix
EOINI
echo "[t130] a=1.3 V0=0.05 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.3_v0.05_kz5.5.ini >> $LOG 2>&1) || echo "[t130] a=1.3 V0=0.05 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a1.300_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.3 V0=0.05 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.0_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 245.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.0 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.0_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t130] a=1.0 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.000_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.0 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.4_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 122.9
run_tag = suspectfix
EOINI
echo "[t130] a=0.4 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.4_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[t130] a=0.4 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.400_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.4 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.7_v0.05_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 253.6
run_tag = suspectfix
EOINI
echo "[t130] a=0.7 V0=0.05 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.7_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[t130] a=0.7 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.700_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.7 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.4_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 131.2
run_tag = suspectfix
EOINI
echo "[t130] a=1.4 V0=0.05 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.4_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[t130] a=1.4 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.400_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.4 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.4_v0.01_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 132.6
run_tag = suspectfix
EOINI
echo "[t130] a=2.4 V0=0.01 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.4_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[t130] a=2.4 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.400_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.4 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.9_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 272.2
run_tag = suspectfix
EOINI
echo "[t130] a=0.9 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.9_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t130] a=0.9 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a0.900_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.9 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.7_v0.03_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 139.5
run_tag = suspectfix
EOINI
echo "[t130] a=1.7 V0=0.03 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.7_v0.03_kz7.5.ini >> $LOG 2>&1) || echo "[t130] a=1.7 V0=0.03 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.700_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.7 V0=0.03 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.5_v0.01_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 140.7
run_tag = suspectfix
EOINI
echo "[t130] a=2.5 V0=0.01 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.5_v0.01_kz5.5.ini >> $LOG 2>&1) || echo "[t130] a=2.5 V0=0.01 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a2.500_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.5 V0=0.01 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.8_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 146.7
run_tag = suspectfix
EOINI
echo "[t130] a=2.8 V0=0.01 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.8_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[t130] a=2.8 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.800_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.8 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.1_v0.01_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 151.6
run_tag = suspectfix
EOINI
echo "[t130] a=2.1 V0=0.01 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.1_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[t130] a=2.1 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.100_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.1 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.8_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 306.2
run_tag = suspectfix
EOINI
echo "[t130] a=0.8 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.8_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t130] a=0.8 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a0.800_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.8 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.8_v0.01_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 156.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.8 V0=0.01 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.8_v0.01_kz3.5.ini >> $LOG 2>&1) || echo "[t130] a=1.8 V0=0.01 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.800_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.8 V0=0.01 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.3_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 161.8
run_tag = suspectfix
EOINI
echo "[t130] a=0.3 V0=0.05 kz=0.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.3_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[t130] a=0.3 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.300_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.3 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.1_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 167.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.1 V0=0.05 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.1_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[t130] a=1.1 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.100_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.1 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.0_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 335.4
run_tag = suspectfix
EOINI
echo "[t130] a=1.0 V0=0.01 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.0_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[t130] a=1.0 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.000_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.0 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.0_v0.01_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 175.9
run_tag = suspectfix
EOINI
echo "[t130] a=2.0 V0=0.01 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.0_v0.01_kz5.5.ini >> $LOG 2>&1) || echo "[t130] a=2.0 V0=0.01 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a2.000_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.0 V0=0.01 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.0_v0.01_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 184.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.0 V0=0.01 kz=1.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.0_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[t130] a=1.0 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.000_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.0 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.5_v0.01_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 187.1
run_tag = suspectfix
EOINI
echo "[t130] a=1.5 V0=0.01 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.5_v0.01_kz3.5.ini >> $LOG 2>&1) || echo "[t130] a=1.5 V0=0.01 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.500_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.5 V0=0.01 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.6_v0.03_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 381.9
run_tag = suspectfix
EOINI
echo "[t130] a=0.6 V0=0.03 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.6_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[t130] a=0.6 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.600_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.6 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.6_v0.01_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 198.9
run_tag = suspectfix
EOINI
echo "[t130] a=1.6 V0=0.01 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.6_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[t130] a=1.6 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.600_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.6 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.3_v0.03_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.3 V0=0.03 kz=5.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.3_v0.03_kz5.0.ini >> $LOG 2>&1) || echo "[t130] a=0.3 V0=0.03 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.300_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.3 V0=0.03 kz=5.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.3_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.3 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.3_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t130] a=0.3 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a0.300_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.3 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.4_v0.01_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.4 V0=0.01 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.4_v0.01_kz7.0.ini >> $LOG 2>&1) || echo "[t130] a=0.4 V0=0.01 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.400_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.4 V0=0.01 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.4_v0.03_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.4 V0=0.03 kz=6.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.4_v0.03_kz6.0.ini >> $LOG 2>&1) || echo "[t130] a=0.4 V0=0.03 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a0.400_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.4 V0=0.03 kz=6.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.4_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.4 V0=0.03 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.4_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[t130] a=0.4 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a0.400_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.4 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.5_v0.01_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.5 V0=0.01 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.5_v0.01_kz8.0.ini >> $LOG 2>&1) || echo "[t130] a=0.5 V0=0.01 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a0.500_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.5 V0=0.01 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.5_v0.03_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.5 V0=0.03 kz=7.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.5_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[t130] a=0.5 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.500_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.5 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.7_v0.01_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.7 V0=0.01 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.7_v0.01_kz8.0.ini >> $LOG 2>&1) || echo "[t130] a=0.7 V0=0.01 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a0.700_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.7 V0=0.01 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.8_v0.01_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.8 V0=0.01 kz=8.0 (tier=int) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.8_v0.01_kz8.0.ini >> $LOG 2>&1) || echo "[t130] a=0.8 V0=0.01 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a0.800_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.8 V0=0.01 kz=8.0 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.5_v0.01_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 212.2
run_tag = suspectfix
EOINI
echo "[t130] a=1.5 V0=0.01 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.5_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[t130] a=1.5 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.500_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.5 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.4_v0.01_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 227.3
run_tag = suspectfix
EOINI
echo "[t130] a=1.4 V0=0.01 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.4_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[t130] a=1.4 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.400_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.4 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.2_v0.01_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 233.9
run_tag = suspectfix
EOINI
echo "[t130] a=1.2 V0=0.01 kz=3.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.2_v0.01_kz3.5.ini >> $LOG 2>&1) || echo "[t130] a=1.2 V0=0.01 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.200_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.2 V0=0.01 kz=3.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.7_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 241.7
run_tag = suspectfix
EOINI
echo "[t130] a=1.7 V0=0.01 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.7_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[t130] a=1.7 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.700_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.7 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.8_v0.03_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 276.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.8 V0=0.03 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.8_v0.03_kz6.5.ini >> $LOG 2>&1) || echo "[t130] a=0.8 V0=0.03 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a0.800_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.8 V0=0.03 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.4_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 293.4
run_tag = suspectfix
EOINI
echo "[t130] a=1.4 V0=0.01 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.4_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[t130] a=1.4 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.400_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.4 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.2_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 342.3
run_tag = suspectfix
EOINI
echo "[t130] a=1.2 V0=0.01 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.2_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[t130] a=1.2 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.200_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.2 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.3_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 353.6
run_tag = suspectfix
EOINI
echo "[t130] a=0.3 V0=0.05 kz=2.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.3_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[t130] a=0.3 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.300_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.3 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.3_v0.01_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.3 V0=0.01 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.3_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[t130] a=0.3 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.300_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.3 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.3_v0.03_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.3 V0=0.03 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.3_v0.03_kz5.5.ini >> $LOG 2>&1) || echo "[t130] a=0.3 V0=0.03 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a0.300_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.3 V0=0.03 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.3_v0.03_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.3 V0=0.03 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.3_v0.03_kz6.5.ini >> $LOG 2>&1) || echo "[t130] a=0.3 V0=0.03 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a0.300_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.3 V0=0.03 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.3_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.3 V0=0.05 kz=5.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.3_v0.05_kz5.5.ini >> $LOG 2>&1) || echo "[t130] a=0.3 V0=0.05 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a0.300_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.3 V0=0.05 kz=5.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.4_v0.03_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.4 V0=0.03 kz=4.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.4_v0.03_kz4.5.ini >> $LOG 2>&1) || echo "[t130] a=0.4 V0=0.03 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.400_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.4 V0=0.03 kz=4.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.5_v0.01_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.5 V0=0.01 kz=6.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.5_v0.01_kz6.5.ini >> $LOG 2>&1) || echo "[t130] a=0.5 V0=0.01 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a0.500_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.5 V0=0.01 kz=6.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.5_v0.03_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.5 V0=0.03 kz=7.5 (tier=half) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.5_v0.03_kz7.5.ini >> $LOG 2>&1) || echo "[t130] a=0.5 V0=0.03 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a0.500_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.5 V0=0.03 kz=7.5 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.6_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.6 V0=0.03 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.6_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[t130] a=0.6 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.600_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.6 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.6_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.6 V0=0.05 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.6_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[t130] a=0.6 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.600_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.6 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.7_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.7 V0=0.05 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.7_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[t130] a=0.7 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.700_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.7 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.8_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.8 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.8_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[t130] a=0.8 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a0.800_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.8 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.8_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.8 V0=0.05 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.8_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[t130] a=0.8 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.800_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.8 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.9_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.9 V0=0.05 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.9_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[t130] a=0.9 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a0.900_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.9 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.0_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.0 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.0_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[t130] a=1.0 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.000_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.0 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.0_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.0 V0=0.05 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.0_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[t130] a=1.0 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.000_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.0 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.1_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.1 V0=0.01 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.1_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[t130] a=1.1 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.100_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.1 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.1_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.1 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.1_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[t130] a=1.1 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.100_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.1 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.1_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.1 V0=0.05 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.1_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[t130] a=1.1 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.100_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.1 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.2_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.2 V0=0.01 kz=0.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.2_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[t130] a=1.2 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.200_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.2 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.2_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.2 V0=0.03 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.2_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[t130] a=1.2 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a1.200_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.2 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.2_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.2 V0=0.05 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.2_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[t130] a=1.2 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.200_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.2 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.3_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.3 V0=0.01 kz=0.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.3_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[t130] a=1.3 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.300_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.3 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.3_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.3 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.3_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[t130] a=1.3 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.300_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.3 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.3_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.3 V0=0.03 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.3_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[t130] a=1.3 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a1.300_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.3 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.4_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.4 V0=0.01 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.4_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[t130] a=1.4 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.400_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.4 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.4_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.4 V0=0.03 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.4_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[t130] a=1.4 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.400_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.4 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.4_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.4 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.4_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[t130] a=1.4 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.400_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.4 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.4_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.4 V0=0.05 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.4_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[t130] a=1.4 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a1.400_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.4 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.5_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.5 V0=0.01 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.5_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[t130] a=1.5 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.500_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.5 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.5_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.5 V0=0.03 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.5_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[t130] a=1.5 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.500_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.5 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.5_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.5 V0=0.03 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.5_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[t130] a=1.5 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a1.500_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.5 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.5_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.5 V0=0.05 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.5_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[t130] a=1.5 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a1.500_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.5 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.5_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.5 V0=0.05 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.5_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[t130] a=1.5 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a1.500_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.5 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.6_v0.05_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.6 V0=0.05 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.6_v0.05_kz0.25.ini >> $LOG 2>&1) || echo "[t130] a=1.6 V0=0.05 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.600_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.6 V0=0.05 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.6_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.6 V0=0.05 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.6_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[t130] a=1.6 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a1.600_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.6 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.7_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.7 V0=0.03 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.7_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[t130] a=1.7 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.700_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.7 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.7_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.7 V0=0.03 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.7_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[t130] a=1.7 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a1.700_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.7 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.7_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.7 V0=0.05 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.7_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[t130] a=1.7 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.700_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.7 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.7_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.7 V0=0.05 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.7_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[t130] a=1.7 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a1.700_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.7 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.8_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.8 V0=0.01 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.8_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[t130] a=1.8 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.800_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.8 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.8_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.8 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.8_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[t130] a=1.8 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.800_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.8 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.8_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.8 V0=0.03 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.8_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[t130] a=1.8 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a1.800_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.8 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.8_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.8 V0=0.05 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.8_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[t130] a=1.8 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.800_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.8 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.8_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.8 V0=0.05 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.8_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[t130] a=1.8 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a1.800_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.8 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.9_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.9 V0=0.01 kz=0.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.9_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[t130] a=1.9 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.900_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.9 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.9_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.9 V0=0.03 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.9_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[t130] a=1.9 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.900_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.9 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.9_v0.05_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=1.9 V0=0.05 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.9_v0.05_kz0.25.ini >> $LOG 2>&1) || echo "[t130] a=1.9 V0=0.05 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.900_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.9 V0=0.05 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.0_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.0 V0=0.01 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.0_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[t130] a=2.0 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.000_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.0 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.0_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.0 V0=0.03 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.0_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[t130] a=2.0 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a2.000_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.0 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.0_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.0 V0=0.05 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.0_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[t130] a=2.0 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.000_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.0 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.0_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.0 V0=0.05 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.0_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[t130] a=2.0 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a2.000_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.0 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.1_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.1 V0=0.01 kz=1.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.1_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[t130] a=2.1 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.100_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.1 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.1_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.1 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.1_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[t130] a=2.1 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.100_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.1 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.1_v0.05_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.1 V0=0.05 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.1_v0.05_kz0.25.ini >> $LOG 2>&1) || echo "[t130] a=2.1 V0=0.05 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.100_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.1 V0=0.05 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.1_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.1 V0=0.05 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.1_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[t130] a=2.1 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a2.100_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.1 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.1_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.1 V0=0.05 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.1_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[t130] a=2.1 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a2.100_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.1 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.2_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.2 V0=0.03 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.2_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[t130] a=2.2 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.200_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.2 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.2_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.2 V0=0.03 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.2_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[t130] a=2.2 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a2.200_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.2 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.3_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.3 V0=0.01 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.3_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[t130] a=2.3 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.300_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.3 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.3_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.3 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.3_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[t130] a=2.3 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a2.300_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.3 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.3_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.3 V0=0.05 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.3_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[t130] a=2.3 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.300_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.3 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.4_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.4 V0=0.01 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.4_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[t130] a=2.4 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.400_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.4 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.4_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.4 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.4_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[t130] a=2.4 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.400_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.4 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.4_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.4 V0=0.05 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.4_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[t130] a=2.4 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.400_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.4 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.4_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.4 V0=0.05 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.4_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[t130] a=2.4 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a2.400_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.4 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.5_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.5 V0=0.01 kz=0.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.5_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[t130] a=2.5 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.500_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.5 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.5_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.5 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.5_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[t130] a=2.5 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.500_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.5 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.5_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.5 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.5_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[t130] a=2.5 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a2.500_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.5 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.5_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.5 V0=0.05 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.5_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[t130] a=2.5 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.500_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.5 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.5_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.5 V0=0.05 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.5_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[t130] a=2.5 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a2.500_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.5 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.5_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.5 V0=0.05 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.5_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[t130] a=2.5 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a2.500_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.5 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.6_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.6 V0=0.01 kz=1.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.6_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[t130] a=2.6 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.600_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.6 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.6_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.6 V0=0.05 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.6_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[t130] a=2.6 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.600_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.6 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.6_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.6 V0=0.05 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.6_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[t130] a=2.6 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a2.600_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.6 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.7_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.7 V0=0.01 kz=1.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.7_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[t130] a=2.7 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.700_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.7 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.7_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.7 V0=0.03 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.7_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[t130] a=2.7 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a2.700_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.7 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.7_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.7 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.7_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[t130] a=2.7 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a2.700_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.7 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.7_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.7 V0=0.05 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.7_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[t130] a=2.7 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a2.700_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.7 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.8_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.8 V0=0.01 kz=0.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.8_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[t130] a=2.8 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.800_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.8 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.8_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.8 V0=0.03 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.8_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[t130] a=2.8 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a2.800_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.8 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.8_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.8 V0=0.05 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.8_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[t130] a=2.8 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a2.800_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.8 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.9_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.9 V0=0.01 kz=0.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.9_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[t130] a=2.9 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.900_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.9 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.9_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.9 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.9_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[t130] a=2.9 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.900_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.9 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.9_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.9 V0=0.03 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.9_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[t130] a=2.9 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a2.900_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.9 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.9_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.9 V0=0.05 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.9_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[t130] a=2.9 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.900_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.9 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a2.9_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=2.9 V0=0.05 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a2.9_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[t130] a=2.9 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a2.900_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=2.9 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a3.0_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=3.0 V0=0.01 kz=0.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a3.0_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[t130] a=3.0 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a3.000_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=3.0 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a3.0_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=3.0 V0=0.03 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a3.0_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[t130] a=3.0 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a3.000_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=3.0 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a3.0_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=3.0 V0=0.03 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a3.0_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[t130] a=3.0 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a3.000_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=3.0 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a3.0_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=3.0 V0=0.03 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a3.0_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[t130] a=3.0 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a3.000_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=3.0 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a3.0_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.0
run_tag = suspectfix
EOINI
echo "[t130] a=3.0 V0=0.05 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a3.0_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[t130] a=3.0 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a3.000_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=3.0 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.6_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100.4
run_tag = suspectfix
EOINI
echo "[t130] a=1.6 V0=0.01 kz=1.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.6_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[t130] a=1.6 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.600_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.6 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.1_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 101.3
run_tag = suspectfix
EOINI
echo "[t130] a=1.1 V0=0.05 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.1_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[t130] a=1.1 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a1.100_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.1 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.2_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 110.2
run_tag = suspectfix
EOINI
echo "[t130] a=1.2 V0=0.01 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.2_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[t130] a=1.2 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.200_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.2 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.0_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 111.4
run_tag = suspectfix
EOINI
echo "[t130] a=1.0 V0=0.05 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.0_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[t130] a=1.0 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a1.000_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.0 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.7_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 117.2
run_tag = suspectfix
EOINI
echo "[t130] a=0.7 V0=0.03 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.7_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[t130] a=0.7 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.700_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.7 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.1_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 119.9
run_tag = suspectfix
EOINI
echo "[t130] a=1.1 V0=0.01 kz=0.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.1_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[t130] a=1.1 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.100_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.1 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.9_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 123.7
run_tag = suspectfix
EOINI
echo "[t130] a=0.9 V0=0.05 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.9_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[t130] a=0.9 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a0.900_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.9 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.1_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 133.6
run_tag = suspectfix
EOINI
echo "[t130] a=1.1 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.1_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[t130] a=1.1 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a1.100_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.1 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.8_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 139.2
run_tag = suspectfix
EOINI
echo "[t130] a=0.8 V0=0.05 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.8_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[t130] a=0.8 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a0.800_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.8 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.5_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 150.6
run_tag = suspectfix
EOINI
echo "[t130] a=0.5 V0=0.05 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.5_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[t130] a=0.5 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a0.500_*_v0.0500_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.5 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.4_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 173.3
run_tag = suspectfix
EOINI
echo "[t130] a=0.4 V0=0.03 kz=0.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.4_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[t130] a=0.4 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.400_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.4 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.3_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 177.9
run_tag = suspectfix
EOINI
echo "[t130] a=1.3 V0=0.01 kz=2.375 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.3_v0.01_kz2.375.ini >> $LOG 2>&1) || echo "[t130] a=1.3 V0=0.01 kz=2.375 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k19_a1.300_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.3 V0=0.01 kz=2.375 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.8_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 183.6
run_tag = suspectfix
EOINI
echo "[t130] a=0.8 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.8_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[t130] a=0.8 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a0.800_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.8 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.0_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 225.1
run_tag = suspectfix
EOINI
echo "[t130] a=1.0 V0=0.01 kz=2.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.0_v0.01_kz2.25.ini >> $LOG 2>&1) || echo "[t130] a=1.0 V0=0.01 kz=2.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k18_a1.000_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.0 V0=0.01 kz=2.25 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.7_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 227.7
run_tag = suspectfix
EOINI
echo "[t130] a=0.7 V0=0.01 kz=1.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.7_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[t130] a=0.7 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.700_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.7 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.9_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 243.1
run_tag = suspectfix
EOINI
echo "[t130] a=0.9 V0=0.01 kz=2.125 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.9_v0.01_kz2.125.ini >> $LOG 2>&1) || echo "[t130] a=0.9 V0=0.01 kz=2.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k17_a0.900_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.9 V0=0.01 kz=2.125 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a1.0_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 248.8
run_tag = suspectfix
EOINI
echo "[t130] a=1.0 V0=0.01 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a1.0_v0.01_kz2.75.ini >> $LOG 2>&1) || echo "[t130] a=1.0 V0=0.01 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a1.000_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=1.0 V0=0.01 kz=2.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.3_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 270.8
run_tag = suspectfix
EOINI
echo "[t130] a=0.3 V0=0.03 kz=0.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.3_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[t130] a=0.3 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.300_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.3 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.7_v0.01_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 0.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 283.6
run_tag = suspectfix
EOINI
echo "[t130] a=0.7 V0=0.01 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.7_v0.01_kz1.75.ini >> $LOG 2>&1) || echo "[t130] a=0.7 V0=0.01 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a0.700_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.7 V0=0.01 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.8_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 289.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.8 V0=0.01 kz=2.375 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.8_v0.01_kz2.375.ini >> $LOG 2>&1) || echo "[t130] a=0.8 V0=0.01 kz=2.375 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k19_a0.800_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.8 V0=0.01 kz=2.375 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.3_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 323.1
run_tag = suspectfix
EOINI
echo "[t130] a=0.3 V0=0.03 kz=1.25 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.3_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[t130] a=0.3 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a0.300_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.3 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.7_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 330.3
run_tag = suspectfix
EOINI
echo "[t130] a=0.7 V0=0.01 kz=2.375 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.7_v0.01_kz2.375.ini >> $LOG 2>&1) || echo "[t130] a=0.7 V0=0.01 kz=2.375 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k19_a0.700_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.7 V0=0.01 kz=2.375 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.4_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 367.2
run_tag = suspectfix
EOINI
echo "[t130] a=0.4 V0=0.03 kz=2.875 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.4_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[t130] a=0.4 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a0.400_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.4 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.5_v0.01_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 397.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.5 V0=0.01 kz=1.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.5_v0.01_kz1.75.ini >> $LOG 2>&1) || echo "[t130] a=0.5 V0=0.01 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a0.500_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.5 V0=0.01 kz=1.75 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.3_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.3 V0=0.03 kz=2.625 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.3_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[t130] a=0.3 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a0.300_*_v0.0300_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.3 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.4_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.4 V0=0.01 kz=2.375 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.4_v0.01_kz2.375.ini >> $LOG 2>&1) || echo "[t130] a=0.4 V0=0.01 kz=2.375 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k19_a0.400_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.4 V0=0.01 kz=2.375 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.5_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.5 V0=0.01 kz=2.375 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.5_v0.01_kz2.375.ini >> $LOG 2>&1) || echo "[t130] a=0.5 V0=0.01 kz=2.375 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k19_a0.500_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.5 V0=0.01 kz=2.375 done $(date)" >> $LOG

cat > /tmp/sfx_t130_a0.6_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 400.0
run_tag = suspectfix
EOINI
echo "[t130] a=0.6 V0=0.01 kz=2.75 (tier=fine) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/sfx_t130_a0.6_v0.01_kz2.75.ini >> $LOG 2>&1) || echo "[t130] a=0.6 V0=0.01 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a0.600_*_v0.0100_*_suspectfix" >> ../logs/inline_extract.log 2>&1)
echo "[t130] a=0.6 V0=0.01 kz=2.75 done $(date)" >> $LOG

echo "=== t130 ALL DONE $(date) ===" >> $LOG
