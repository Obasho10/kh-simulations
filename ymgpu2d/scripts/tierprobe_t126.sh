#!/bin/bash
# tier investigation -- t126: 3 jobs
set -e
WDIR=/DATA/cm/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs
LOG=$WDIR/logs/tierprobe_t126_progress.log
echo "=== start $(date) ===" >> $LOG
cat > /tmp/tp_t126_A_fine_a1.9_v0.05_kz8.ini <<'EOINI'
k_mode = 64
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 63
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 200
lz_override = 50.265482
nz_override = 512
run_tag = tierprobe_A_fine
EOINI
echo "[t126] A_fine a=1.9 V0=0.05 kz=8 nz=512 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tp_t126_A_fine_a1.9_v0.05_kz8.ini >> $LOG 2>&1) || echo "[t126] A_fine a=1.9 V0=0.05 kz=8 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k64_a1.900_*_v0.0500_*_tierprobe_A_fine" >> ../logs/inline_extract.log 2>&1)
echo "[t126] A_fine a=1.9 V0=0.05 kz=8 done $(date)" >> $LOG

cat > /tmp/tp_t126_A_fine_a0.6_v0.01_kz4.ini <<'EOINI'
k_mode = 32
alpha_YM = 0.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 31
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 200
lz_override = 50.265482
nz_override = 512
run_tag = tierprobe_A_fine
EOINI
echo "[t126] A_fine a=0.6 V0=0.01 kz=4 nz=512 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tp_t126_A_fine_a0.6_v0.01_kz4.ini >> $LOG 2>&1) || echo "[t126] A_fine a=0.6 V0=0.01 kz=4 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k32_a0.600_*_v0.0100_*_tierprobe_A_fine" >> ../logs/inline_extract.log 2>&1)
echo "[t126] A_fine a=0.6 V0=0.01 kz=4 done $(date)" >> $LOG

cat > /tmp/tp_t126_Bhalf_2x_a1.1_v0.05_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 256
run_tag = tierprobe_Bhalf_2x
EOINI
echo "[t126] Bhalf_2x a=1.1 V0=0.05 kz=1.5 nz=256 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tp_t126_Bhalf_2x_a1.1_v0.05_kz1.5.ini >> $LOG 2>&1) || echo "[t126] Bhalf_2x a=1.1 V0=0.05 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.100_*_v0.0500_*_tierprobe_Bhalf_2x" >> ../logs/inline_extract.log 2>&1)
echo "[t126] Bhalf_2x a=1.1 V0=0.05 kz=1.5 done $(date)" >> $LOG

echo "=== t126 ALL DONE $(date) ===" >> $LOG
