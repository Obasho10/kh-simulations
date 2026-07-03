#!/bin/bash
# Campaign 58: α=3.0, V0=0.20, xi_sponge=6.0, Lz=2π standard
# Purpose: High-V0 point for α=3.0 series; have V0=0.03/0.05/0.10, adding V0=0.20.
#          kz_peak expected = 5–6. Tests γ_peak ∝ V0 at α=3.0.
# Server: t140 (/DATA/cm/lcpfct/ymgpu2d/)

ALPHA=3.0
V0=0.20
AMP=0.001
MODE=6
HYP=5e-5
KZ0=1
BP=14
EPS=0.15
XI_SPONGE=6.0
SIGMA=5.0
TARGET_TU=100

for k in 1 2 3 4 5 6 7; do
    KZ_SUPP=$((k - 1))
    echo "=== C58 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        -1 -1 -1 $TARGET_TU \
        > run_c58_k${k}.log 2>&1
    echo "=== C58 kz=${k} done at $(date) ==="
done
