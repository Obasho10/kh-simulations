#!/bin/bash
# Campaign 39: α=1.0, V0=0.05, xi_sponge=25 — lowest V0=0.05 coupling measured
# Exact kz_peak=2 (γ=0.123); WKB overpredicts by ~1.4-2.0x (least so far at this V0)
# Fills in the low-coupling end of V0=0.05 series (below C34 α=1.5)
ALPHA=1.0; V0=0.05; AMP=0.001; MODE=6; HYP=5e-5; KZ0=1; BP=14; EPS=0.15
XI_SPONGE=25.0; SIGMA=5.0; TARGET_TU=100

for k in 1 2 3 4 5 6 7 8; do
    KZ_SUPP=$((k - 1))
    SEED="eigenmode_seed_kz${k}_a1.00_V0.050_sp25.0.bin"
    echo "=== C39 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        -1 -1 -1 $TARGET_TU "" $SEED > run_c39_k${k}.log 2>&1
    echo "=== C39 kz=${k} done at $(date) ==="
done
