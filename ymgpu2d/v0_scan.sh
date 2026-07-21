#!/bin/bash
set -e
cd /DATA/ym_kh/ymgpu2d
for v0 in 0.1 0.05 0.03 0.02; do
    echo "===== V0 = $v0 ====="
    cat > v0_test_${v0}.ini << EOF
k_mode          = 2
alpha_YM        = 0.0
run_mode        = 2
perturb_amp     = 0.001
V0              = $v0
eps_override    = 0.15
nx_override     = 1024
init_by1_eq     = 0
vz_edge_taper   = 50.0
warm_T          = 0.0
target_tu       = 80
run_tag         = v0scan${v0}
EOF
    ./ym_coupled v0_test_${v0}.ini 2>&1 | grep -E "HALT|completed normally"
    echo ""
done
echo DONE > v0_scan_DONE.marker
