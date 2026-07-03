#!/bin/bash
# Campaign 54: α=1.0, V0=0.20, xi_sponge=11.0, Lz=2π standard
# Purpose: High-V0 point for α=1.0 V0 series. kz_peak expected = 2.
# Server: t130 (/DATA/cm/lcpfct/ymgpu2d/)

ALPHA=1.0
V0=0.20
AMP=0.001
MODE=6
HYP=5e-5
KZ0=1
BP=14
EPS=0.15
XI_SPONGE=11.0
SIGMA=5.0
TARGET_TU=100

for k in 1 2 3; do
    KZ_SUPP=$((k - 1))
    echo "=== C54 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        -1 -1 -1 $TARGET_TU \
        > run_c54_k${k}.log 2>&1
    echo "=== C54 kz=${k} done at $(date) ==="
done
