#!/bin/bash
# Campaign 16: Mode 1 (NAB_CIRC, log-cosh Az1) — WKB geometry test
#
# Campaign 15 (Mode 5, cosine Az1) showed only kz=1 unstable (γ=0.090 TU⁻¹).
# WKB predicts γ=0.26-0.55 TU⁻¹ for ALL kz=1..6.  The mismatch is geometric:
#
#   Mode 5 cosine Az1: maximum (+V0) AT shear center → anti-confining
#   WKB requires log-cosh Az1: ZERO at shear center, growing outward → confining well
#
# Mode 1 (NAB_CIRC) uses Az1 = -V0*log(cosh(ξ)) with ξ=(x-Lx/2)/EPS.
#   - Az1(0) = 0 at shear center (✓ matches WKB geometry)
#   - Az1 grows as -V0|ξ|/EPS away from center (✓ provides confining coupling)
#   - WKB trapped n=0 mode has scale ξ_char = EPS/sqrt(α·kz·V0) ≈ 0.34 physical
#
# Sponge (xi_sponge=10): absorbs color-2/3 at |ξ|>10 (physical dist>1.5).
#   - Prevents log-cosh outer-region coupling (α|Az1|~12 at boundary)
#   - Also triggers 100× energy threshold (vs 5× for Mode 1 without sponge)
#   - Eigenmode (ξ_char≈2.24) fully contained within sponge (factor ×4.5)
#
# Expected: γ significantly closer to WKB (0.26-0.55 TU⁻¹) vs Mode 5 (0.090)
# and growth at kz=2..6 (WKB predicts instability there, Mode 5 showed none).
# Any remaining discrepancy (log-cosh vs step-potential shape + finite domain)
# documents the accuracy limit of the WKB approximation.

ALPHA=2.0
V0=0.1
AMP=0.001
MODE=1           # NAB_CIRC: log-cosh Az1, tanh velocity, periodic x, frozen Az1
HYP=5e-5
KZ0=1
BP=14
EPS=0.15
XI_SPONGE=10.0   # sponge starts at |ξ|=10 (physical distance 1.5 from center)
SIGMA=5.0

cd /DATA/cm/lcpfct/ymgpu2d

echo "=== Campaign 16: Mode 1 (NAB_CIRC), log-cosh Az1, WKB geometry test ==="
echo "    Mode 5 (cosine Az1) result: only kz=1 unstable at γ=0.090 TU⁻¹"
echo "    WKB predicts: kz=1..6 all unstable at γ=0.26-0.55 TU⁻¹"
echo "    This campaign uses correct geometry (log-cosh Az1 = 0 at shear center)"
echo ""

for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    echo "--- k=$k  kz_suppress_max=$KZ_SUPP  xi_sponge=$XI_SPONGE  bp=$BP ---"
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        > run_c16_k${k}_bp${BP}.log 2>&1
    echo "k=$k done"
done

echo ""
echo "Campaign 16 complete."
echo "Output dirs: ym_k<k>_a2.000_circ_sp10.0_eps0.15_nkz0[_nkz1to<k-1>]_bp14_hd5e-05"
