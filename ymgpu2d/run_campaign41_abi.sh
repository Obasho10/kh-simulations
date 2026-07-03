#!/bin/bash
# Campaign 41: α=1.5, V0=0.03, xi_sponge=18 — fills low-coupling end of V0=0.03 series
# Exact kz_peak=3 (γ=0.104); αV0=0.045, lowest for V0=0.03 series
# Completes V0=0.03 coverage: C41(α=1.5) → C42(α=2.0) → C36(α=3.0) → C37(α=4.0) → C38(α=5.0)
ALPHA=1.5; V0=0.03; AMP=0.001; MODE=6; HYP=5e-5; KZ0=1; BP=14; EPS=0.15
XI_SPONGE=18.0; SIGMA=5.0; TARGET_TU=100

for k in 1 2 3 4 5 6 7 8 9; do
    KZ_SUPP=$((k - 1))
    SEED="eigenmode_seed_kz${k}_a1.50_V0.030_sp18.0.bin"
    echo "=== C41 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        -1 -1 -1 $TARGET_TU "" $SEED > run_c41_k${k}.log 2>&1
    echo "=== C41 kz=${k} done at $(date) ==="
done
