#!/bin/bash
# Campaign 24: α=1.0, V0=0.05, xi_sponge=20.0, eigenfunction seeding
# Purpose: C23 (Gaussian seed, xi_sponge=20) but with exact eigenfunction seeds
#          from ym_eigenmode.py --export-seed --xi-sponge 20.0 --NX 768.
#          Eliminates seed-projection problem for outer-peaked modes (kz=1,3..6).
# Mode 6 (NAB_CIRC_AZ2): log-cosh Az1, eigenfunction Az2/Az3 seed (arg[19]).
# Server: t140 (/DATA/cm/lcpfct/ymgpu2d/)

ALPHA=1.0
V0=0.05
AMP=0.001
MODE=6
HYP=5e-5
KZ0=1
BP=14
EPS=0.15
XI_SPONGE=20.0
SIGMA=5.0

for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    SEED="eigenmode_seed_kz${k}_a1.00_V0.050_sp20.0.bin"
    echo "=== C24 kz=${k} starting at $(date) ==="
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        -1 -1 -1 -1 "" $SEED \
        > run_c24_k${k}.log 2>&1
    echo "=== C24 kz=${k} done at $(date) ==="
done
