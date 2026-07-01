#!/bin/bash
# Campaign 20: NAB_CIRC_AZ2 (Mode 6), alpha=2.0, V0=0.2
# Higher shear velocity: ξ_crit(kz=1)=2.5 (same as C19 α=4 geometrically) but
# different WKB scaling (γ_WKB ∝ α²V0 vs coupling). Best WKB approach in the scan:
# ex/WKB reaches 0.87 at kz=4; kz=1 eigenmode peaks at ξ=3.27 (closest to ξ=0).
# Server: t130.

ALPHA=2.0
V0=0.2
AMP=0.001
MODE=6
HYP=5e-5
KZ0=1
BP=14
EPS=0.15
XI_SPONGE=10.0
SIGMA=5.0

cd /DATA/cm/lcpfct/ymgpu2d

echo "=== Campaign 20 (t130): Mode 6 NAB_CIRC_AZ2, alpha=2.0, V0=0.2 ==="
echo "    ξ_crit(kz=1)=2.5 — inner mode (ξ_peak=3.27), closest approach to WKB."
echo "    Solver predictions: γ_exact(kz=1)=0.252, (kz=4)=0.377, (kz=6)=0.275"
echo "    Expect γ_WKB match ~0.87 at kz=4 — best WKB validation run."
echo ""

for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    echo "--- k=$k (kz_suppress_max=$KZ_SUPP) ---"
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        > run_c20_k${k}.log 2>&1
    echo "    Done: k=$k"
done

echo ""
echo "Campaign 20 complete."
