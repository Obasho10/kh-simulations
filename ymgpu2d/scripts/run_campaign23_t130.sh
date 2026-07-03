#!/bin/bash
# Campaign 23: α=1.0, V0=0.05, xi_sponge=20.0 (doubled from C22)
# Purpose: reduce sponge-boundary systematic (~10-15% in C22) by giving modes
#          more room. ξ_crit(kz=1..6) = 20..120, all above xi_sponge=20 → no outer EM.
# Mode 6 (NAB_CIRC_AZ2): log-cosh Az1, Az2/Az3 WKB Gaussian seed.
# Server: t130 (/DATA/cm/lcpfct/ymgpu2d/)

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

for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    echo "=== C23 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        > run_c23_k${k}.log 2>&1
    echo "=== C23 kz=${k} done at $(date) ==="
done
