#!/bin/bash
# Campaign 53: α=1.0, V0=0.10, xi_sponge=16.0, Lz=2π standard
# Purpose: V0 scaling test at α=1.0: completes V0=0.05/0.10/0.20 series.
#          kz_peak expected at kz=2 (same as C39). γ_peak ∝ V0 → expect ~0.24.
# Server: t130 (/DATA/cm/lcpfct/ymgpu2d/)

ALPHA=1.0
V0=0.10
AMP=0.001
MODE=6
HYP=5e-5
KZ0=1
BP=14
EPS=0.15
XI_SPONGE=16.0
SIGMA=5.0
TARGET_TU=100

for k in 1 2 3 4; do
    KZ_SUPP=$((k - 1))
    echo "=== C53 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        -1 -1 -1 $TARGET_TU \
        > run_c53_k${k}.log 2>&1
    echo "=== C53 kz=${k} done at $(date) ==="
done
