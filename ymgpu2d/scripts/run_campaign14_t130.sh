#!/bin/bash
# Campaign 14: extend kz-range filter to color-1 EM (By1,Ex1,Ez1) + add pxA/pxB filter
#
# Campaign 13 NaN'd at t=17.2 TU — same as Campaign 10 (no filter at all).
# The color-1 EM sector at kz=7-14 (By1, Ex1, Ez1) was unfiltered and growing.
# The finite-kz EM instability in color-1 at kz≈7-14 (γ≈0.08-0.1 TU⁻¹) reaches
# critical amplitude at t≈17.2 TU independent of the kz=0 Weibel (which we fixed).
#
# Fix: kernel_ym_subtract_kz_range now covers 15 fields (was 12):
#   NEW: By1, Ex1, Ez1 zeroed at kz=2..14 (same range as color-2/3)
#   Az1 frozen — not touched
#   KEPT: By2/3, Ex2/3, Ez2/3, Az2/3, Q2/3_A/B
#
# Also: pxA/pxB now filtered at same kz ranges via kernel_fluid_pz_subtract_kz_range.
# Previously only pzA, pzB were filtered — pxA could still couple to Ex1 via Jx1.
#
# Smem change: 864 B → 1080 B per block (still 32 blocks/SM on A5000).

ALPHA=2.0
V0=0.1
AMP=0.001
MODE=5
HYP=5e-5
KZ0=1
BP=14
EPS=0.15

cd /DATA/cm/lcpfct/ymgpu2d

echo "=== Campaign 14: color-1 EM kz-range filter + pxA/pxB filter ==="

echo "--- Phase 1: k=1 diagnostic (kz_suppress_max=0) ---"
nohup ./ym_coupled 1 $ALPHA $AMP $MODE $V0 0 5.0 -1 $KZ0 $HYP 0 $EPS $BP \
    > run_c14_k1_ph1.log 2>&1
echo "k=1 ph1 done"

echo "=== Phase 2: kz=1..6 sweep ==="
for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    echo "--- k=$k  kz_suppress_max=$KZ_SUPP  bp=$BP ---"
    nohup ./ym_coupled $k $ALPHA $AMP $MODE $V0 0 5.0 -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        > run_c14_k${k}_bp${BP}.log 2>&1
    echo "k=$k done"
done

echo "Campaign 14 complete."
