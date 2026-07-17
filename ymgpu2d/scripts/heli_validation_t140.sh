#!/bin/bash
# Helicity-fix validation campaign (2026-07-17) — t140, sequential.
#
# Context: analysis/remote_timeseries.py extracted the CONJUGATE (−helicity)
# component from 2026-07-04 03:29 onward — every timeseries since then starts
# at FP32 noise (logamp≈−30) instead of the seed (≈−13.5) and tracks the wrong
# component. Separately, all suspectfix half/fine-tier runs omitted
# lz_override/nz_override, so they ran the default Lz=2pi box at kz=k_mode.
#
# This campaign validates the corrected pipeline end-to-end at 7 anchor points:
#   A heli_int     k5  a2.0 sp10 bp14  tu60   default box        kz=5    expect ~0.158
#   B heli_bp28    k5  a2.0 sp10 bp28  tu60   default box        kz=5    expect ~= A (bp-independence)
#   C heli_half    k5  a2.0 sp10 bp28  tu150  Lz=4pi  NZ=128     kz=2.5  expect ~0.143
#   F heli_kzlow   k1  a0.9 sp8  bp28  tu250  Lz=4pi  NZ=128     kz=0.5  expect ~0.046
#   D heli_fine55  k22 a1.7 sp42 bp55  tu150  Lz=16pi NZ=512     kz=2.75 bp under-covers phys 7-14 band
#   E heli_fine112 k22 a1.7 sp42 bp112 tu150  Lz=16pi NZ=512     kz=2.75 full band coverage
#   G heli_finelow k2  a2.0 sp8  bp112 tu250  Lz=16pi NZ=512     kz=0.25 kz<1 bucket, correct box
#
# Inline extraction uses the FIXED remote_timeseries.py (writes amp + amp_conj).
# KEEP_DUMPS=1 on the small default-box runs A/B for forensics; big fine-tier
# dumps are cleaned after extraction to save disk.
WDIR=/DATA/cm/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs
LOG=$WDIR/logs/heli_validation_progress.log
echo "=== heli validation start $(date) ===" >> $LOG

run_one() {  # $1=label $2=ini-body $3=dir-glob $4=keep
    local label=$1 ini=/tmp/heli_$1.ini glob=$3 keep=$4
    printf '%s\n' "$2" > $ini
    echo "[heli] $label start $(date)" >> $LOG
    (cd $WDIR/outputs && $WDIR/ym_coupled $ini >> $LOG 2>&1) \
        || echo "[heli] $label CRASHED (exit $?) $(date)" >> $LOG
    (cd $WDIR/outputs && KEEP_DUMPS=$keep python3 ../analysis/remote_timeseries.py "$glob" >> $LOG 2>&1)
    echo "[heli] $label done $(date)" >> $LOG
}

COMMON="V0 = 0.05
perturb_amp = 0.001
run_mode = 6
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
eps_override = 0.15"

run_one heli_int "k_mode = 5
alpha_YM = 2.0
xi_sponge = 10
kz_suppress_max = 4
kz_suppress_hi = 14
target_tu = 60
run_tag = heli_int
$COMMON" 'ym_k5_a2.000*heli_int' 1

run_one heli_bp28 "k_mode = 5
alpha_YM = 2.0
xi_sponge = 10
kz_suppress_max = 4
kz_suppress_hi = 28
target_tu = 60
run_tag = heli_bp28
$COMMON" 'ym_k5_a2.000*heli_bp28' 1

run_one heli_half "k_mode = 5
alpha_YM = 2.0
xi_sponge = 10
kz_suppress_max = 4
kz_suppress_hi = 28
target_tu = 150
lz_override = 12.566371
nz_override = 128
run_tag = heli_half
$COMMON" 'ym_k5_a2.000*heli_half' ''

run_one heli_kzlow "k_mode = 1
alpha_YM = 0.9
xi_sponge = 8
kz_suppress_max = 0
kz_suppress_hi = 28
target_tu = 250
lz_override = 12.566371
nz_override = 128
run_tag = heli_kzlow
$COMMON" 'ym_k1_a0.900*heli_kzlow' ''

run_one heli_fine55 "k_mode = 22
alpha_YM = 1.7
xi_sponge = 42
kz_suppress_max = 21
kz_suppress_hi = 55
target_tu = 150
lz_override = 50.265482
nz_override = 512
run_tag = heli_fine55
$COMMON" 'ym_k22_a1.700*heli_fine55' ''

run_one heli_fine112 "k_mode = 22
alpha_YM = 1.7
xi_sponge = 42
kz_suppress_max = 21
kz_suppress_hi = 112
target_tu = 150
lz_override = 50.265482
nz_override = 512
run_tag = heli_fine112
$COMMON" 'ym_k22_a1.700*heli_fine112' ''

run_one heli_finelow "k_mode = 2
alpha_YM = 2.0
xi_sponge = 8
kz_suppress_max = 1
kz_suppress_hi = 112
target_tu = 250
lz_override = 50.265482
nz_override = 512
run_tag = heli_finelow
$COMMON" 'ym_k2_a2.000*heli_finelow' ''

echo "=== heli validation ALL DONE $(date) ===" >> $LOG
