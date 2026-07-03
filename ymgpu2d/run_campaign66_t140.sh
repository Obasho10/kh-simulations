#!/bin/bash
# C66: α=0.5, V0=0.20, xi_sponge=22, kz=1..4 (t140)
ALPHA=0.5; V0=0.20; XI_SPONGE=22.0; TARGET_TU=100
for k in 1 2 3 4; do
    KZ_SUPP=$((k-1))
    echo "=== C66 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA 0.001 6 $V0 $XI_SPONGE 5.0 -1 1 5e-5 $KZ_SUPP 0.15 14 -1 -1 -1 $TARGET_TU > run_c66_k${k}.log 2>&1
    echo "=== C66 kz=${k} done at $(date) ==="
done
