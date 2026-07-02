#!/bin/bash
# Campaign 28: α=1.5, V0=0.10, xi_sponge=10, 6-field eigen seed, NZ=64, courant=0.1
# Server: t140 (/DATA/cm/lcpfct/ymgpu2d/)
ALPHA=1.5; V0=0.10; AMP=0.001; MODE=6; HYP=5e-5; KZ0=1; BP=14; EPS=0.15
XI_SPONGE=10.0; SIGMA=5.0; TARGET_TU=100
for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    SEED="eigenmode_seed_kz${k}_a1.50_V0.100_sp10.0.bin"
    echo "=== C28 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        -1 -1 -1 $TARGET_TU "" $SEED > run_c28_k${k}.log 2>&1
    echo "=== C28 kz=${k} done at $(date) ==="
done
