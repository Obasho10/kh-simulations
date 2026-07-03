#!/bin/bash
# Campaign 25: α=1.0, V0=0.05, xi_sponge=20.0, full 6-field eigenfunction seeding
# Resolution: NZ=64, NX=768, courant=0.1 (new validated defaults — no override needed)
# Purpose: Fix kz=2 stray mode by seeding By2, Q2A, Q2B simultaneously with Az2.
#          C24 (Az-only seed) converged to mode 6 (γ=0.060) instead of mode 1 (γ=0.122).
#          6-field seed establishes correct spatial coupling from t=0.
# Server: t136 (/DATA/cm/lcpfct/ymgpu2d/)

ALPHA=1.0
V0=0.05
AMP=0.001
MODE=6
HYP=5e-5
KZ0=1
BP=14
EPS=0.15
XI_SPONGE=20.0
SIGMA=5.0

TARGET_TU=100   # cap run; drives 1-TU export spacing (407 steps) instead of fixed 20000

for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    SEED="eigenmode_seed_kz${k}_a1.00_V0.050_sp20.0.bin"
    echo "=== C25 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        -1 -1 -1 $TARGET_TU "" $SEED \
        > run_c25_k${k}.log 2>&1
    echo "=== C25 kz=${k} done at $(date) ==="
done
