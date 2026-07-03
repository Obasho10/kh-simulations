#!/bin/bash
# Campaign 60: α=1.5, V0=0.20, xi_sponge=9, kz=1..5 (t130)
# Purpose: High-V0 for α=1.5; completes V0 series (have 0.03/0.05/0.10).
#          kz_peak expected=3 (same as V0=0.03/0.10). Tests γ_peak∝V0 at α=1.5.
ALPHA=1.5; V0=0.20; XI_SPONGE=9.0; TARGET_TU=100
for k in 1 2 3 4 5; do
    KZ_SUPP=$((k-1))
    echo "=== C60 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA 0.001 6 $V0 $XI_SPONGE 5.0 -1 1 5e-5 $KZ_SUPP 0.15 14 -1 -1 -1 $TARGET_TU > run_c60_k${k}.log 2>&1
    echo "=== C60 kz=${k} done at $(date) ==="
done
