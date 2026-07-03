#!/bin/bash
# Campaign 65: α=1.0, V0=0.01, xi_sponge=50 — very low V0 boundary exploration
# αV0=0.01, ξ_crit(kz=1)=100 >> any practical sponge. Will show sponge-compressed
# kz=1, but higher kz may have low-enough ξ_crit to be measured.
# ξ_crit(kz=2)=200 — also too large. Only works if kz≫1 or need Lz extension.
# kz=3: ξ_crit=300. Almost certainly all sponge-compressed at this coupling.
# Run anyway to characterize behavior and confirm lower boundary.
ALPHA=1.0; V0=0.01; XI_SPONGE=40.0; TARGET_TU=100
for k in 1 2 3 4; do
    KZ_SUPP=$((k-1))
    echo "=== C65 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA 0.001 6 $V0 $XI_SPONGE 5.0 -1 1 5e-5 $KZ_SUPP 0.15 14 -1 -1 -1 $TARGET_TU > run_c65_k${k}.log 2>&1
    echo "=== C65 kz=${k} done at $(date) ==="
done
