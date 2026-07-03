#!/bin/bash
# C71: α=3.0, V0=0.01, xi_sponge=35, kz=1..7 (t140) — very low V0 at high alpha
ALPHA=3.0; V0=0.01; XI_SPONGE=35.0; TARGET_TU=100
for k in 1 2 3 4 5 6 7; do
    KZ_SUPP=$((k-1))
    echo "=== C71 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA 0.001 6 $V0 $XI_SPONGE 5.0 -1 1 5e-5 $KZ_SUPP 0.15 14 -1 -1 -1 $TARGET_TU > run_c71_k${k}.log 2>&1
    echo "=== C71 kz=${k} done at $(date) ==="
done
