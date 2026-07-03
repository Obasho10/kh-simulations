#!/bin/bash
# Campaign 55: α=2.0, V0=0.10, xi_sponge=11.0, Lz=2π standard
# Purpose: Complete V0 series for α=2.0: have V0=0.03/0.05/0.20; adding 0.10.
#          kz_peak expected = 4. γ_peak expected ~0.21 (interpolating 0.16 at V0=0.05 and 0.31 at V0=0.20).
# Server: t130 (/DATA/cm/lcpfct/ymgpu2d/)

ALPHA=2.0
V0=0.10
AMP=0.001
MODE=6
HYP=5e-5
KZ0=1
BP=14
EPS=0.15
XI_SPONGE=11.0
SIGMA=5.0
TARGET_TU=100

for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    echo "=== C55 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        -1 -1 -1 $TARGET_TU \
        > run_c55_k${k}.log 2>&1
    echo "=== C55 kz=${k} done at $(date) ==="
done
