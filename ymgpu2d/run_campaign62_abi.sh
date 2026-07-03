#!/bin/bash
# Campaign 62: α=3.0, V0=0.02, xi_sponge=20, kz=1..7 (abi — .ini format)
# Purpose: Low-V0 for α=3.0; bridges C36 (V0=0.03) to lower V0.
ALPHA=3.0; V0=0.02; XI_SPONGE=20.0
for k in 1 2 3 4 5 6 7; do
    KZ_SUPP=$((k-1))
    cat > run_c62_k${k}.ini <<EOF
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
    echo "=== C62 kz=${k} starting at $(date) ==="
    ./ym_coupled run_c62_k${k}.ini > run_c62_k${k}.log 2>&1
    echo "=== C62 kz=${k} done at $(date) ==="
done
