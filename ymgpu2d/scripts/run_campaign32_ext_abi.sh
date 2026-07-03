#!/bin/bash
# Campaign 32 extension: α=2.5, V0=0.05, xi_sponge=9 — kz=7,8 add-ons
# Extends C32 (done kz=1..6) to show the post-peak shape
# γ_exact: kz=7 → 0.176, kz=8 → 0.172 (past peak at kz=5-6, 0.179)
ALPHA=2.5; V0=0.05; AMP=0.001; MODE=6; HYP=5e-5; KZ0=1; BP=14; EPS=0.15
XI_SPONGE=9.0; SIGMA=5.0; TARGET_TU=100
for k in 7 8; do
    KZ_SUPP=$((k - 1))
    SEED="eigenmode_seed_kz${k}_a2.50_V0.050_sp9.0.bin"
    echo "=== C32-ext kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        -1 -1 -1 $TARGET_TU "" $SEED > run_c32ext_k${k}.log 2>&1
    echo "=== C32-ext kz=${k} done at $(date) ==="
done
