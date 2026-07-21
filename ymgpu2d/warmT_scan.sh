#!/bin/bash
set -e
cd /DATA/ym_kh/ymgpu2d
for wt in 0.0 0.002 0.005 0.01 0.02 0.04; do
    echo "===== warm_T = $wt ====="
    cat > wt_test_${wt}.ini << EOF
k_mode          = 1
alpha_YM        = 0.0
run_mode        = 2
perturb_amp     = 0.001
V0              = 0.1
eps_override    = 0.15
nx_override     = 1024
init_by1_eq     = 0
vz_edge_taper   = 50.0
warm_T          = $wt
target_tu       = 20
run_tag         = wt${wt}
EOF
    ./ym_coupled wt_test_${wt}.ini 2>&1 | grep -E "HALT|completed normally"
    echo ""
done
echo DONE > warmT_scan_DONE.marker
