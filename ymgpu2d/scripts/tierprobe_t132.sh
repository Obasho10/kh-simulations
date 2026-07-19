#!/bin/bash
# tier investigation -- t132: 2 jobs
set -e
WDIR=/DATA/ym_kh
mkdir -p $WDIR/logs $WDIR/outputs
LOG=$WDIR/logs/tierprobe_t132_progress.log
echo "=== start $(date) ===" >> $LOG
cat > /tmp/tp_t132_A_fine_a1.7_v0.03_kz8.ini <<'EOINI'
k_mode = 64
alpha_YM = 1.7
V0 = 0.03
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
echo "[t132] A_fine a=1.7 V0=0.03 kz=8 nz=512 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tp_t132_A_fine_a1.7_v0.03_kz8.ini >> $LOG 2>&1) || echo "[t132] A_fine a=1.7 V0=0.03 kz=8 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k64_a1.700_*_v0.0300_*_tierprobe_A_fine" >> ../logs/inline_extract.log 2>&1)
echo "[t132] A_fine a=1.7 V0=0.03 kz=8 done $(date)" >> $LOG

cat > /tmp/tp_t132_Bfine_2x_a2.9_v0.05_kz1.75.ini <<'EOINI'
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
target_tu = 100
lz_override = 50.265482
nz_override = 1024
run_tag = tierprobe_Bfine_2x
EOINI
echo "[t132] Bfine_2x a=2.9 V0=0.05 kz=1.75 nz=1024 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tp_t132_Bfine_2x_a2.9_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[t132] Bfine_2x a=2.9 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a2.900_*_v0.0500_*_tierprobe_Bfine_2x" >> ../logs/inline_extract.log 2>&1)
echo "[t132] Bfine_2x a=2.9 V0=0.05 kz=1.75 done $(date)" >> $LOG

echo "=== t132 ALL DONE $(date) ===" >> $LOG
