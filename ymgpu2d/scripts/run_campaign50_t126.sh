#!/bin/bash
# Campaign 50: α=2.0, V0=0.05, Lz=8π (NZ=256) — fine kz_phys resolution through peak/dip
# kz_phys = k_mode/4: 0.25, 0.50, 0.75, 1.00, 1.25, 1.50
# xi_sponge=13 (same as C45 to ensure consistent mode selection)
# Predictions (xi_sponge=13): 0.25→0.102, 0.50→0.320, 0.75→0.060, 1.00→0.084, 1.25→0.105, 1.50→0.119
ALPHA=2.0; V0=0.05; MODE=6; HYP=5e-5; KZ0=1; BP=14; EPS=0.15
XI_SPONGE=13.0; SIGMA=5.0; TARGET_TU=100; LZ=25.1327; NZ=256

for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    SEED="eigenmode_seed_kz${k}_a2.00_V0.050_sp13.0_lz25.1327.bin"
    cat > run_c50_k${k}.ini <<EOF
k_mode          = $k
alpha_YM        = $ALPHA
V0              = $V0
perturb_amp     = 0.001
run_mode        = $MODE
xi_sponge       = $XI_SPONGE
sigma_sponge    = $SIGMA
suppress_kz0    = $KZ0
hyp_diff        = $HYP
kz_suppress_max = $KZ_SUPP
eps_override    = $EPS
kz_suppress_hi  = $BP
nz_override     = $NZ
lz_override     = $LZ
target_tu       = $TARGET_TU
seed_profile_file = $SEED
EOF
    echo "=== C50 k_mode=${k} (kz_phys=$(echo "scale=3; $k/4" | bc)) starting at $(date) ==="
    ./ym_coupled run_c50_k${k}.ini > run_c50_k${k}.log 2>&1
    echo "=== C50 k_mode=${k} done at $(date) ==="
done
