#!/bin/bash
# Campaign 43: α=1.0, V0=0.05, Lz=4π (NZ=128) — sub-kz=1 dispersion
# kz_phys = k_mode/2: k1→0.5, k2→1.0, k3→1.5, k4→2.0, k5→2.5
# Exact γ: 0.178, 0.090, 0.111, 0.122, 0.099 (peak at kz_phys=0.5 — new!)
# xi_sponge=20 (3×ξ_char at kz_phys=0.5)
ALPHA=1.0; V0=0.05; AMP=0.001; MODE=6; HYP=5e-5; KZ0=1; BP=14; EPS=0.15
XI_SPONGE=20.0; SIGMA=5.0; TARGET_TU=100
LZ=12.5664   # 4π
NZ=128       # keeps DZ=LZ/NZ≈0.098

for k in 1 2 3 4 5; do
    KZ_SUPP=$((k - 1))
    SEED="eigenmode_seed_kz${k}_a1.00_V0.050_sp20.0_lz12.5664.bin"
    echo "=== C43 k_mode=${k} (kz_phys=$(echo "scale=3; $k/2" | bc)) starting at $(date) ==="
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        $NZ -1 -1 $TARGET_TU "" $SEED $LZ > run_c43_k${k}.log 2>&1
    echo "=== C43 k_mode=${k} done at $(date) ==="
done
