#!/bin/bash
# Campaign 42: α=2.0, V0=0.03, xi_sponge=14 — second fill for V0=0.03 series
# Exact kz_peak=5 (γ=0.118); αV0=0.060
# Bridges gap between C41 (α=1.5, kz_peak=3) and C36 (α=3.0, kz_peak=7)
ALPHA=2.0; V0=0.03; AMP=0.001; MODE=6; HYP=5e-5; KZ0=1; BP=14; EPS=0.15
XI_SPONGE=14.0; SIGMA=5.0; TARGET_TU=100

for k in 1 2 3 4 5 6 7 8 9; do
    KZ_SUPP=$((k - 1))
    SEED="eigenmode_seed_kz${k}_a2.00_V0.030_sp14.0.bin"
    echo "=== C42 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        -1 -1 -1 $TARGET_TU "" $SEED > run_c42_k${k}.log 2>&1
    echo "=== C42 kz=${k} done at $(date) ==="
done
