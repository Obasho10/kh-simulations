#!/bin/bash
# Campaign 63: α=2.5, V0=0.20, xi_sponge=7, kz=1..7 (t140)
# Purpose: High-V0 for α=2.5; tests kz_peak invariance and γ∝V0 at α=2.5.
ALPHA=2.5; V0=0.20; XI_SPONGE=7.0; TARGET_TU=100
for k in 1 2 3 4 5 6 7; do
    KZ_SUPP=$((k-1))
    echo "=== C63 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA 0.001 6 $V0 $XI_SPONGE 5.0 -1 1 5e-5 $KZ_SUPP 0.15 14 -1 -1 -1 $TARGET_TU > run_c63_k${k}.log 2>&1
    echo "=== C63 kz=${k} done at $(date) ==="
done
