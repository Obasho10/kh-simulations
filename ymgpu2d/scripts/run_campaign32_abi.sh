#!/bin/bash
# Campaign 32: α=2.5, V0=0.05, xi_sponge=9, 6-field eigen seed, NZ=64, courant=0.1
# Server: abi (/DATA/s23103/lcpfct/ymgpu2d/)
# Outer EM: ξ_crit(kz=1)≈8.7, only 0.3 ξ-units outside xi_sponge=9 (safe)
# γ_exact: 0.084 (kz=1) → 0.170 (kz=4-6) TU⁻¹
ALPHA=2.5; V0=0.05; AMP=0.001; MODE=6; HYP=5e-5; KZ0=1; BP=14; EPS=0.15
XI_SPONGE=9.0; SIGMA=5.0; TARGET_TU=100
for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    SEED="eigenmode_seed_kz${k}_a2.50_V0.050_sp9.0.bin"
    echo "=== C32 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        -1 -1 -1 $TARGET_TU "" $SEED > run_c32_k${k}.log 2>&1
    echo "=== C32 kz=${k} done at $(date) ==="
done
