#!/bin/bash
# Campaign 21b: NAB_CIRC_AZ2 (Mode 6), alpha=3.0, V0=0.1 — REDO with tight sponge
# C21 failed (NaN at 2.45 TU) because xi_sponge=10 allowed γ_outer≈2.9 TU⁻¹.
# Fix: xi_sponge=6.0, sigma=15.
# At ξ=6 with α=3, V0=0.1: Ω_A = kz - 3×0.1×log(cosh(6)) ≈ kz - 1.74
#   kz=1: γ_outer(ξ=6) ≈ √(0.74×3.74) ≈ 1.66 TU⁻¹ → borderline; sigma=15 helps
# ξ_crit(kz=1)=3.3 (mode inside sponge), ξ_crit(kz=2)=6.7 (right at sponge)
# Server: abi (farmerzone, GTX 1080 Ti sm_61, ~4500 steps/min).

ALPHA=3.0
V0=0.1
AMP=0.001
MODE=6
HYP=5e-5
KZ0=1
BP=14
EPS=0.15
XI_SPONGE=6.0
SIGMA=15.0

cd /DATA/s23103/lcpfct/ymgpu2d

echo "=== Campaign 21b (abi): Mode 6 NAB_CIRC_AZ2, alpha=3.0, V0=0.1, xi_sponge=6.0 ==="
echo "    ξ_crit(kz=1)=3.3, xi_sponge=6.0, sigma=15 (tight sponge redo)"
echo "    Solver: γ_exact(kz=1)=0.147 [Im=-0.06, oscillatory], (kz=2)=0.166"
echo "    kz=1,2 measurable; kz≥3 likely sponge-damped."
echo ""

for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    echo "--- k=$k (kz_suppress_max=$KZ_SUPP) ---"
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        > run_c21b_k${k}.log 2>&1
    echo "    Done: k=$k"
done

echo ""
echo "Campaign 21b complete."
