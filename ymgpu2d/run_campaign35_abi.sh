#!/bin/bash
# Campaign 35: α=2.0, V0=0.05, xi_sponge=11, 6-field eigen seed, NZ=64, courant=0.1
# Server: abi (/DATA/s23103/lcpfct/ymgpu2d/)
# Fills the gap between C34 (α=1.5) and C32 (α=2.5) in the V0=0.05 series
# ξ_crit(kz=1)≈10.7 → outer EM strip [10.7,11] only 0.3 ξ-units (safe)
# γ_exact: 0.086 (kz=1) → peaks at kz=4-5 (0.160) → 0.142 (kz=6) TU⁻¹
ALPHA=2.0; V0=0.05; AMP=0.001; MODE=6; HYP=5e-5; KZ0=1; BP=14; EPS=0.15
XI_SPONGE=11.0; SIGMA=5.0; TARGET_TU=100
for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    SEED="eigenmode_seed_kz${k}_a2.00_V0.050_sp11.0.bin"
    echo "=== C35 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        -1 -1 -1 $TARGET_TU "" $SEED > run_c35_k${k}.log 2>&1
    echo "=== C35 kz=${k} done at $(date) ==="
done
