#!/bin/bash
# Campaign 20b: NAB_CIRC_AZ2 (Mode 6), alpha=2.0, V0=0.2 — REDO with tight sponge
# C20 failed (NaN at 2.45 TU) because xi_sponge=10 allowed γ_outer≈3.6 TU⁻¹.
# Fix: xi_sponge=5.0 (just above ξ_crit=2.5 for kz=1), sigma=15 (3× stronger damping).
# At ξ=5 with α=2, V0=0.2: Ω_A = kz - 2×0.2×log(cosh(5)) ≈ kz - 1.87
#   kz=1: γ_outer(ξ=5) ≈ √(0.87×3.87) ≈ 1.84 TU⁻¹ → manageable with sigma=15
# Tradeoff: kz≥3 (ξ_crit=7.5) will be strongly sponge-damped — only kz=1,2 measurable.
# Server: t130.

ALPHA=2.0
V0=0.2
AMP=0.001
MODE=6
HYP=5e-5
KZ0=1
BP=14
EPS=0.15
XI_SPONGE=5.0
SIGMA=15.0

cd /DATA/cm/lcpfct/ymgpu2d

echo "=== Campaign 20b (t130): Mode 6 NAB_CIRC_AZ2, alpha=2.0, V0=0.2, xi_sponge=5.0 ==="
echo "    ξ_crit(kz=1)=2.5, xi_sponge=5.0, sigma=15 (tight sponge to contain outer EM)"
echo "    Solver: γ_exact(kz=1)=0.252 [ξ_peak=3.27, inside sponge], (kz=2)=0.256"
echo "    kz=3..6 will be sponge-damped (ξ_crit≥7.5 > xi_sponge=5) — not measurable."
echo ""

for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    echo "--- k=$k (kz_suppress_max=$KZ_SUPP) ---"
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        > run_c20b_k${k}.log 2>&1
    echo "    Done: k=$k"
done

echo ""
echo "Campaign 20b complete."
