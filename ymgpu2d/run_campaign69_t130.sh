#!/bin/bash
# C69: α=0.1, V0=0.10, xi_sponge=100 — very low alpha
# αV0=0.01. kz_peak~1 expected (α is tiny).
# ξ_crit(kz=1)=1/(0.1×0.10)=100. xi_sponge=100 fills entire domain — can't isolate.
# Run with xi_sponge=0 (no sponge) to see if any growth visible.
ALPHA=0.1; V0=0.10; XI_SPONGE=0; TARGET_TU=100
for k in 1 2 3; do
    KZ_SUPP=$((k-1))
    echo "=== C69 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA 0.001 6 $V0 $XI_SPONGE 5.0 -1 1 5e-5 $KZ_SUPP 0.15 14 -1 -1 -1 $TARGET_TU > run_c69_k${k}.log 2>&1
    echo "=== C69 kz=${k} done at $(date) ==="
done
