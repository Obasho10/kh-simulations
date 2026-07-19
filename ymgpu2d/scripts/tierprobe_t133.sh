#!/bin/bash
# tier investigation -- t133: 2 jobs
set -e
WDIR=/DATA/ym_kh/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs
LOG=$WDIR/logs/tierprobe_t133_progress.log
echo "=== start $(date) ===" >> $LOG
cat > /tmp/tp_t133_A_fine_a1.5_v0.05_kz8.ini <<'EOINI'
k_mode = 64
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7
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
echo "[t133] A_fine a=1.5 V0=0.05 kz=8 nz=512 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tp_t133_A_fine_a1.5_v0.05_kz8.ini >> $LOG 2>&1) || echo "[t133] A_fine a=1.5 V0=0.05 kz=8 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k64_a1.500_*_v0.0500_*_tierprobe_A_fine" >> ../logs/inline_extract.log 2>&1)
echo "[t133] A_fine a=1.5 V0=0.05 kz=8 done $(date)" >> $LOG

cat > /tmp/tp_t133_A_fine_a0.4_v0.01_kz2.ini <<'EOINI'
k_mode = 16
alpha_YM = 0.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 15
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 200
lz_override = 50.265482
nz_override = 512
run_tag = tierprobe_A_fine
EOINI
echo "[t133] A_fine a=0.4 V0=0.01 kz=2 nz=512 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tp_t133_A_fine_a0.4_v0.01_kz2.ini >> $LOG 2>&1) || echo "[t133] A_fine a=0.4 V0=0.01 kz=2 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k16_a0.400_*_v0.0100_*_tierprobe_A_fine" >> ../logs/inline_extract.log 2>&1)
echo "[t133] A_fine a=0.4 V0=0.01 kz=2 done $(date)" >> $LOG

echo "=== t133 ALL DONE $(date) ===" >> $LOG
