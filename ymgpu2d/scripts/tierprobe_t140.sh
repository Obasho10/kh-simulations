#!/bin/bash
# tier investigation -- t140: 2 jobs
set -e
WDIR=/DATA/cm/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs
LOG=$WDIR/logs/tierprobe_t140_progress.log
echo "=== start $(date) ===" >> $LOG
cat > /tmp/tp_t140_A_fine_a1.5_v0.03_kz7.ini <<'EOINI'
k_mode = 56
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 55
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 200
lz_override = 50.265482
nz_override = 512
run_tag = tierprobe_A_fine
EOINI
echo "[t140] A_fine a=1.5 V0=0.03 kz=7 nz=512 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tp_t140_A_fine_a1.5_v0.03_kz7.ini >> $LOG 2>&1) || echo "[t140] A_fine a=1.5 V0=0.03 kz=7 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k56_a1.500_*_v0.0300_*_tierprobe_A_fine" >> ../logs/inline_extract.log 2>&1)
echo "[t140] A_fine a=1.5 V0=0.03 kz=7 done $(date)" >> $LOG

cat > /tmp/tp_t140_Bfine_2x_a2.6_v0.05_kz0.625.ini <<'EOINI'
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
target_tu = 100
lz_override = 50.265482
nz_override = 1024
run_tag = tierprobe_Bfine_2x
EOINI
echo "[t140] Bfine_2x a=2.6 V0=0.05 kz=0.625 nz=1024 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tp_t140_Bfine_2x_a2.6_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[t140] Bfine_2x a=2.6 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.600_*_v0.0500_*_tierprobe_Bfine_2x" >> ../logs/inline_extract.log 2>&1)
echo "[t140] Bfine_2x a=2.6 V0=0.05 kz=0.625 done $(date)" >> $LOG

echo "=== t140 ALL DONE $(date) ===" >> $LOG
