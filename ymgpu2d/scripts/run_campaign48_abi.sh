#!/bin/bash
# Campaign 48: α=3.0, V0=0.05, Lz=4π (NZ=128) — sub-kz=1 extension of C33
# kz_phys = k_mode/2: peak γ=0.386 at kz_phys=0.5, dip γ=0.070 at kz_phys=1.0
# xi_sponge=10
ALPHA=3.0; V0=0.05; MODE=6; HYP=5e-5; KZ0=1; BP=14; EPS=0.15
XI_SPONGE=10.0; SIGMA=5.0; TARGET_TU=100; LZ=12.5664; NZ=128

for k in 1 2 3 4 5 6 7; do
    KZ_SUPP=$((k - 1))
    SEED="eigenmode_seed_kz${k}_a3.00_V0.050_sp10.0_lz12.5664.bin"
    cat > run_c48_k${k}.ini <<EOF
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
    echo "=== C48 k_mode=${k} (kz_phys=$(echo "scale=3; $k/2" | bc)) starting at $(date) ==="
    ./ym_coupled run_c48_k${k}.ini > run_c48_k${k}.log 2>&1
    echo "=== C48 k_mode=${k} done at $(date) ==="
done
