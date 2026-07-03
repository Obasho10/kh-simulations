#!/bin/bash
# Campaign 34: α=1.5, V0=0.05, xi_sponge=12, 6-field eigen seed, NZ=64, courant=0.1
# Server: abi (/DATA/s23103/lcpfct/ymgpu2d/)
# Fills gap between C25 (α=1.0) and C32 (α=2.5); γ peaks at kz=3 (mid-coupling regime)
# Outer EM: ξ_crit(kz=1)≈13.3 > xi_sponge=12 (safe)
# γ_exact: 0.088 (kz=1) → peaks at kz=3 (0.142) → 0.099 (kz=6) TU⁻¹
ALPHA=1.5; V0=0.05; AMP=0.001; MODE=6; HYP=5e-5; KZ0=1; BP=14; EPS=0.15
XI_SPONGE=12.0; SIGMA=5.0; TARGET_TU=100
for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    SEED="eigenmode_seed_kz${k}_a1.50_V0.050_sp12.0.bin"
    echo "=== C34 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        -1 -1 -1 $TARGET_TU "" $SEED > run_c34_k${k}.log 2>&1
    echo "=== C34 kz=${k} done at $(date) ==="
done
