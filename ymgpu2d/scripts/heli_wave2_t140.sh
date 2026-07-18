#!/bin/bash
# Wave 2: bp-scan bisection of the hi=28 growth-kill + tight-sponge fine-box redo
WDIR=/DATA/cm/lcpfct/ymgpu2d
LOG=$WDIR/logs/heli_validation_progress.log
echo "=== wave2 start $(date) ===" >> $LOG
run_one() {
    local label=$1 ini=/tmp/heli_$1.ini glob=$3 keep=$4
    printf '%s\n' "$2" > $ini
    echo "[heli] $label start $(date)" >> $LOG
    (cd $WDIR/outputs && $WDIR/ym_coupled $ini >> $LOG 2>&1) \
        || echo "[heli] $label CRASHED (exit $?) $(date)" >> $LOG
    (cd $WDIR/outputs && KEEP_DUMPS=$keep python3 ../analysis/remote_timeseries.py "$glob" >> $LOG 2>&1)
    echo "[heli] $label done $(date)" >> $LOG
}
COMMON="k_mode = 5
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
target_tu = 30"
for HI in 15 16 18 20 24; do
run_one bpscan_hi$HI "$COMMON
kz_suppress_hi = $HI
run_tag = bpscan_hi$HI" "ym_k5_a2.000*bpscan_hi$HI" ''
done
COMMONF="V0 = 0.05
perturb_amp = 0.001
run_mode = 6
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
eps_override = 0.15
lz_override = 50.265482
nz_override = 512
k_mode = 22
alpha_YM = 1.7
xi_sponge = 10
kz_suppress_max = 21
target_tu = 120"
run_one fine55b "$COMMONF
kz_suppress_hi = 55
run_tag = heli_fine55b" 'ym_k22_a1.700*heli_fine55b' ''
run_one fine112b "$COMMONF
kz_suppress_hi = 112
run_tag = heli_fine112b" 'ym_k22_a1.700*heli_fine112b' ''
echo "=== wave2 ALL DONE $(date) ===" >> $LOG
