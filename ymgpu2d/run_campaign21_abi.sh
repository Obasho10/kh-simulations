#!/bin/bash
# Campaign 21: NAB_CIRC_AZ2 (Mode 6), alpha=3.0, V0=0.1
# Intermediate coupling. ξ_crit(kz=1)=3.3, ξ_crit(kz=3)=10 (right at sponge).
# Key physics: kz=1 shows Im(γ)=-0.06 (oscillatory growth, new regime).
# ex/WKB=0.22-0.75 across kz=1..6.
# Server: abi (farmerzone, GTX 1080 Ti sm_61, ~4500 steps/min).

ALPHA=3.0
V0=0.1
AMP=0.001
MODE=6
HYP=5e-5
KZ0=1
BP=14
EPS=0.15
XI_SPONGE=10.0
SIGMA=5.0

cd /DATA/s23103/lcpfct/ymgpu2d

echo "=== Campaign 21 (abi): Mode 6 NAB_CIRC_AZ2, alpha=3.0, V0=0.1 ==="
echo "    ξ_crit(kz=1)=3.3, ξ_crit(kz=3)=10 (right at sponge boundary)"
echo "    Solver predictions: γ_exact(kz=1)=0.147 [Im=-0.06, oscillatory!], (kz=3)=0.257"
echo "    kz=1 oscillatory growth is new physics — watch Az/By oscillations in time."
echo ""

for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    echo "--- k=$k (kz_suppress_max=$KZ_SUPP) ---"
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        > run_c21_k${k}.log 2>&1
    echo "    Done: k=$k"
done

echo ""
echo "Campaign 21 complete."
