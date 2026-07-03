#!/bin/bash
# Campaign 59: α=0.5, V0=0.05, xi_sponge=22, kz=1..3 (t130)
# Purpose: Low-α point at V0=0.05. C31 did V0=0.10; this adds V0=0.05.
#          kz_peak expected=1. αV0=0.025 (very weak coupling).
ALPHA=0.5; V0=0.05; XI_SPONGE=22.0; TARGET_TU=100
for k in 1 2 3; do
    KZ_SUPP=$((k-1))
    echo "=== C59 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA 0.001 6 $V0 $XI_SPONGE 5.0 -1 1 5e-5 $KZ_SUPP 0.15 14 -1 -1 -1 $TARGET_TU > run_c59_k${k}.log 2>&1
    echo "=== C59 kz=${k} done at $(date) ==="
done
