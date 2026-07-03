#!/bin/bash
# Campaign 19b: NAB_CIRC_AZ2 (Mode 6), alpha=4.0, V0=0.1 — REDO with tight sponge
# C19 had kz=1,2 dominated by outer EM instability (γ_outer≈3.6 TU⁻¹ at xi=10).
# Fix: xi_sponge=5.0 (ξ_crit(kz=1)=2.5, ratio 0.5 as in C18), sigma=15.
# At ξ=5 with α=4, V0=0.1: Ω_A = kz - 4×0.1×log(cosh(5)) ≈ kz - 1.86
#   kz=1: γ_outer(ξ=5) ≈ √(0.86×2.86) ≈ 1.57 TU⁻¹ → same as C18 at ξ=8: manageable
# Server: t136.

ALPHA=4.0
V0=0.1
AMP=0.001
MODE=6
HYP=5e-5
KZ0=1
BP=14
EPS=0.15
XI_SPONGE=5.0
SIGMA=15.0

cd /DATA/cm/lcpfct/ymgpu2d

echo "=== Campaign 19b (t136): Mode 6 NAB_CIRC_AZ2, alpha=4.0, V0=0.1, xi_sponge=5.0 ==="
echo "    ξ_crit(kz=1)=2.5, xi_sponge=5.0 (ratio 0.5 = same as C18), sigma=15"
echo "    Outer EM rate at sponge edge ≈ 1.57 TU⁻¹ — same as C18 was at xi=8."
echo "    Solver: γ_exact(kz=1)=0.213, (kz=3)=0.252 (with tighter sponge, mode may shift)"
echo ""

for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    echo "--- k=$k (kz_suppress_max=$KZ_SUPP) ---"
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        > run_c19b_k${k}.log 2>&1
    echo "    Done: k=$k"
done

echo ""
echo "Campaign 19b complete."
