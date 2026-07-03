#!/bin/bash
# Campaign 36: α=3.0, V0=0.03, xi_sponge=5 — V0=0.03 low-velocity series, kz=1..9
# γ: 0.054 (kz=1) → peak kz≈7 (0.121) → slow rolloff
ALPHA=3.0; V0=0.03; AMP=0.001; MODE=6; HYP=5e-5; KZ0=1; BP=14; EPS=0.15
XI_SPONGE=5.0; SIGMA=5.0; TARGET_TU=100
for k in 1 2 3 4 5 6 7 8 9; do
    KZ_SUPP=$((k - 1))
    SEED="eigenmode_seed_kz${k}_a3.00_V0.030_sp5.0.bin"
    echo "=== C36 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        -1 -1 -1 $TARGET_TU "" $SEED > run_c36_k${k}.log 2>&1
    echo "=== C36 kz=${k} done at $(date) ==="
done
