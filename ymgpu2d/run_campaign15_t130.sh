#!/bin/bash
# Campaign 15: zero all color-1 EM (By1, Ex1, Ez1) each step via cudaMemset
#
# Campaign 14 NaN'd at step 70000 (t=17.2 TU) for all k=1..6.
# Spectrum analysis of ym_060000.csv revealed By1[kz=1] = 2.1e-5 growing at γ≈1.1 TU⁻¹
# — a color-1 EM instability AT the target kz=1 that the kz-range bandpass cannot suppress
# (we don't filter kz=k_mode).  By comparison By2[kz=1] (KH mode) = 3.4e-6, barely growing.
#
# Fix (main_ym.cu step 6e): after hyperdiffusion, cudaMemset By1/Ex1/Ez1 to zero each step
# when suppress_kz0=1.  This kills the color-1 EM instability completely.
# The KH physics chain (By2→Ez2→Az2→Q3→Q2→By2 via frozen Az1×color-3 coupling) survives
# because Az1 is NOT zeroed (it's frozen).  Only the color-1 EM RESPONSE is removed.

ALPHA=2.0
V0=0.1
AMP=0.001
MODE=5
HYP=5e-5
KZ0=1
BP=14
EPS=0.15

cd /DATA/cm/lcpfct/ymgpu2d

echo "=== Campaign 15: cudaMemset By1/Ex1/Ez1=0 each step ==="

echo "--- Phase 1: k=1 diagnostic (kz_suppress_max=0) ---"
./ym_coupled 1 $ALPHA $AMP $MODE $V0 0 5.0 -1 $KZ0 $HYP 0 $EPS $BP \
    > run_c15_k1_ph1.log 2>&1
echo "k=1 ph1 done"

echo "=== Phase 2: kz=1..6 sweep ==="
for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    echo "--- k=$k  kz_suppress_max=$KZ_SUPP  bp=$BP ---"
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 0 5.0 -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        > run_c15_k${k}_bp${BP}.log 2>&1
    echo "k=$k done"
done

echo "Campaign 15 complete."
