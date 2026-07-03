#!/bin/bash
# C70: α=0.2, V0=0.10, xi_sponge=50 — low alpha, no sponge needed (ξ_crit~50)
ALPHA=0.2; V0=0.10; XI_SPONGE=0; TARGET_TU=100
for k in 1 2 3; do
    KZ_SUPP=$((k-1))
    echo "=== C70 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA 0.001 6 $V0 $XI_SPONGE 5.0 -1 1 5e-5 $KZ_SUPP 0.15 14 -1 -1 -1 $TARGET_TU > run_c70_k${k}.log 2>&1
    echo "=== C70 kz=${k} done at $(date) ==="
done
