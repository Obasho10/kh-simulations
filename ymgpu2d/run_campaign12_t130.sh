#!/bin/bash
# Campaign 12: full bandpass on BOTH color-2/3 fields AND fluid pz
#
# Campaign 11 showed that bandpass on color-2/3 alone did nothing — all runs
# still NaN'd at t=17.2 TU identical to Campaign 10 (no bandpass at all).
# Diagnosis: the NaN comes from the color-1 fluid two-stream in pzA/pzB at
# kz~7-14. New kernel kernel_fluid_pz_subtract_kz_range zeroes those modes
# from the fluid z-momentum each step, killing the two-stream at the source.
#
# Combined filter (per step):
#   color-2/3 fields (By2/3, Ex2/3, Ez2/3, Az2/3, Q2/3): kz != k_target → zero
#   fluid pzA, pzB:                                        kz != k_target → zero
#
# If the fluid two-stream was the blocker, runs should now survive >>17 TU.
# Target: reach the KH growth phase (t=50-100 TU) and measure gamma_KH(kz=1..6).
#
# Argv: k alpha amp mode V0 xi sigma freeze suppress_kz0 hyp kz_suppress_max eps bp
# Note: kz_suppress_hi=bp=40 covers entire two-stream danger zone kz~7-14

ALPHA=2.0
V0=0.1
AMP=0.001
MODE=5
HYP=5e-5
KZ0=1
BP=14        # two-stream unstable band: kz < sqrt(2)/V0 ≈ 14.1; covers kz=k+1..14
EPS=0.15     # kz*EPS = 0.15 < 0.64 → KH active for kz=1..4

cd /DATA/cm/lcpfct/ymgpu2d

echo "=== Phase 1: k=1 EPS=0.15 with full bandpass (pz+color23) ==="
echo "--- k=1  EPS=$EPS  bp=$BP ---"
nohup ./ym_coupled 1 $ALPHA $AMP $MODE $V0 0 5.0 -1 $KZ0 $HYP 0 $EPS $BP \
    > run_full_bp_eps${EPS}_k1_c12.log 2>&1
echo "k=1 done"

echo "=== Phase 2: kz=1..6 at EPS=0.15, full bandpass ==="
for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    echo "--- k=$k  EPS=$EPS  kz_suppress_max=$KZ_SUPP  bp=$BP ---"
    nohup ./ym_coupled $k $ALPHA $AMP $MODE $V0 0 5.0 -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        > run_full_bp_eps${EPS}_k${k}_bp40_c12.log 2>&1
    echo "k=$k done"
done

echo "Campaign 12 complete."
