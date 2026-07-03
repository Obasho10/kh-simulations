#!/bin/bash
# C67: α=1.5, V0=0.01, xi_sponge=70, kz=1..6 (abi — very low V0)
ALPHA=1.5; V0=0.01; XI_SPONGE=70.0
for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k-1))
    cat > run_c67_k${k}.ini <<EOF
k_mode = $k
alpha_YM = $ALPHA
V0 = $V0
perturb_amp = 0.001
run_mode = 6
xi_sponge = $XI_SPONGE
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = $KZ_SUPP
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOF
    echo "=== C67 kz=${k} starting at $(date) ==="
    ./ym_coupled run_c67_k${k}.ini > run_c67_k${k}.log 2>&1
    echo "=== C67 kz=${k} done at $(date) ==="
done
