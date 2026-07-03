#!/bin/bash
# Campaign 33 extension: α=3.0, V0=0.05, xi_sponge=8 — kz=7,8 add-ons
# Extends C33 (done kz=1..6) to show the post-peak shape
# γ_exact: kz=7 → 0.176, kz=8 → 0.172 (past peak at kz=5, 0.179)
ALPHA=3.0; V0=0.05; AMP=0.001; MODE=6; HYP=5e-5; KZ0=1; BP=14; EPS=0.15
XI_SPONGE=8.0; SIGMA=5.0; TARGET_TU=100
for k in 7 8; do
    KZ_SUPP=$((k - 1))
    SEED="eigenmode_seed_kz${k}_a3.00_V0.050_sp8.0.bin"
    echo "=== C33-ext kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        -1 -1 -1 $TARGET_TU "" $SEED > run_c33ext_k${k}.log 2>&1
    echo "=== C33-ext kz=${k} done at $(date) ==="
done
