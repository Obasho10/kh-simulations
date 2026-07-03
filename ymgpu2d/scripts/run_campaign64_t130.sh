#!/bin/bash
# Campaign 64: α=0.5, V0=0.10, xi_sponge=22, kz=1..3 extended to check gamma scaling
# (repeat C31 style but with wider sponge to confirm kz_peak=1 vs 2)
# Then C65: α=1.0, V0=0.01 — very low V0 lower boundary
ALPHA=0.5; V0=0.10; XI_SPONGE=22.0; TARGET_TU=100
for k in 1 2 3 4; do
    KZ_SUPP=$((k-1))
    echo "=== C64 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA 0.001 6 $V0 $XI_SPONGE 5.0 -1 1 5e-5 $KZ_SUPP 0.15 14 -1 -1 -1 $TARGET_TU > run_c64_k${k}.log 2>&1
    echo "=== C64 kz=${k} done at $(date) ==="
done
