#!/bin/bash
# Campaign 46: α=1.0, V0=0.05, Lz=8π (NZ=256) — finer kz_phys below 1
# kz_phys = k_mode/4: k1→0.25, k2→0.50, k3→0.75, k4→1.00
# Exact γ: 0.069, 0.055, 0.194, 0.088 (unexpected peak at kz_phys=0.75!)
# xi_sponge=25
ALPHA=1.0; V0=0.05; AMP=0.001; MODE=6; HYP=5e-5; KZ0=1; BP=14; EPS=0.15
XI_SPONGE=25.0; SIGMA=5.0; TARGET_TU=100
LZ=25.1327   # 8π
NZ=256

for k in 1 2 3 4; do
    KZ_SUPP=$((k - 1))
    SEED="eigenmode_seed_kz${k}_a1.00_V0.050_sp25.0_lz25.1327.bin"
    echo "=== C46 k_mode=${k} (kz_phys=$(echo "scale=3; $k/4" | bc)) starting at $(date) ==="
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        $NZ -1 -1 $TARGET_TU "" $SEED $LZ > run_c46_k${k}.log 2>&1
    echo "=== C46 k_mode=${k} done at $(date) ==="
done
