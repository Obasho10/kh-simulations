#!/bin/bash
# Campaign 33: α=3.0, V0=0.05, xi_sponge=8, 6-field eigen seed, NZ=64, courant=0.1
# Server: t136 (/DATA/cm/lcpfct/ymgpu2d/) — launch after teaching nodes come back
# Outer EM: ξ_crit(kz=1)≈7.4, outer EM strip=[7.4,8] only 0.6 ξ-units (safe)
# γ_exact: 0.081 (kz=1) → 0.179 (kz=5-6) TU⁻¹
ALPHA=3.0; V0=0.05; AMP=0.001; MODE=6; HYP=5e-5; KZ0=1; BP=14; EPS=0.15
XI_SPONGE=8.0; SIGMA=5.0; TARGET_TU=100
for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    SEED="eigenmode_seed_kz${k}_a3.00_V0.050_sp8.0.bin"
    echo "=== C33 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        -1 -1 -1 $TARGET_TU "" $SEED > run_c33_k${k}.log 2>&1
    echo "=== C33 kz=${k} done at $(date) ==="
done
