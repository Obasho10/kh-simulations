#!/bin/bash
# Campaign 19: NAB_CIRC_AZ2 (Mode 6), alpha=4.0, V0=0.1
# Higher coupling: ξ_crit(kz=1)=2.5, ξ_crit(kz=3)=7.5 — outer mode deeper inside sponge.
# Eigenvalue solver predicts γ_exact=0.21-0.32 TU⁻¹ (ex/WKB=0.26-0.63).
# Server: t136, after Campaign 18 completes.

ALPHA=4.0
V0=0.1
AMP=0.001
MODE=6
HYP=5e-5
KZ0=1
BP=14
EPS=0.15
XI_SPONGE=10.0
SIGMA=5.0

cd /DATA/cm/lcpfct/ymgpu2d

echo "=== Campaign 19 (t136): Mode 6 NAB_CIRC_AZ2, alpha=4.0, V0=0.1 ==="
echo "    ξ_crit(kz=1)=2.5, ξ_crit(kz=3)=7.5 — modes deeper inside sponge vs C18"
echo "    Solver predictions: γ_exact(kz=1)=0.213, (kz=3)=0.252, (kz=6)=0.321"
echo ""

for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    echo "--- k=$k (kz_suppress_max=$KZ_SUPP) ---"
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        > run_c19_k${k}.log 2>&1
    echo "    Done: k=$k"
done

echo ""
echo "Campaign 19 complete."
