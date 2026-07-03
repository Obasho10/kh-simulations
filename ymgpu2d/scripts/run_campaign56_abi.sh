#!/bin/bash
# Campaign 56: α=2.5, V0=0.03, xi_sponge=18.0, Lz=2π standard
# Server: abi (/DATA/s23103/lcpfct/ymgpu2d/) — uses .ini format

ALPHA=2.5
V0=0.03
XI_SPONGE=18.0

for k in 1 2 3 4 5 6 7; do
    KZ_SUPP=$((k - 1))
    INI="run_c56_k${k}.ini"
    cat > $INI <<EOF
k_mode          = $k
alpha_YM        = $ALPHA
perturb_amp     = 0.001
run_mode        = 6
V0              = $V0
xi_sponge       = $XI_SPONGE
sigma_sponge    = 5.0
suppress_kz0    = 1
hyp_diff        = 5e-5
kz_suppress_max = $KZ_SUPP
eps_override    = 0.15
kz_suppress_hi  = 14
target_tu       = 100
EOF
    echo "=== C56 kz=${k} starting at $(date) ==="
    ./ym_coupled $INI > run_c56_k${k}.log 2>&1
    echo "=== C56 kz=${k} done at $(date) ==="
done
