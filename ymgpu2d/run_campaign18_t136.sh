#!/bin/bash
# Campaign 18: NAB_CIRC_AZ2 (run_mode=6) — Gaussian Az2 eigenmode seed
#
# Option 1 of the eigenmode seeding strategy:
#   Instead of seeding By2/By3 (which forces the KH chain to build Az2 from scratch
#   via the precession cascade, masking kz>=2 modes), seed Az2/Az3 directly with the
#   WKB n=0 Gaussian profile:
#
#     Az2(x,z) = A0 * exp(-ξ²/(2·ξ_char²)) * cos(kz·z)
#     Az3(x,z) = A0 * exp(-ξ²/(2·ξ_char²)) * sin(kz·z)
#
#   where ξ_char = 1/sqrt(α·kz·V0) in ξ-units (ξ = (x-Lx/2)/EPS).
#   By2/By3 start at zero and grow naturally from the Az2 seed via the KH chain.
#
# Physics motivation: in Campaign 16 (Mode 1, alpha=2), kz=1 shows a clean eigenmode
# (γ=0.281 TU⁻¹). For kz>=2, the Az2 precession cascade (γ≈0.20-0.24 TU⁻¹) builds
# from zero and dominates before KH can grow. By pre-seeding Az2 at the correct WKB
# Gaussian width, we eliminate the cascade build-up phase and measure pure γ_KH.
#
# All other parameters identical to Campaign 16.

ALPHA=2.0
V0=0.1
AMP=0.001
MODE=6           # NAB_CIRC_AZ2: Gaussian Az2 seed instead of By2 seed
HYP=5e-5
KZ0=1
BP=14
EPS=0.15
XI_SPONGE=10.0
SIGMA=5.0

cd /DATA/cm/lcpfct/ymgpu2d

echo "=== Campaign 18 (t136): Mode 6 NAB_CIRC_AZ2, Gaussian Az2 seed ==="
echo "    WKB Gaussian seed: Az2 ∝ exp(-ξ²/(2·ξ_char²)), ξ_char=1/sqrt(α·kz·V0)"
echo "    kz=1: ξ_char=2.24, σ_phys=0.336"
echo "    kz=2: ξ_char=1.58, σ_phys=0.237"
echo "    No By2 seed — By2 grows naturally via KH chain from Az2"
echo ""

for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    echo "--- k=$k (kz_suppress_max=$KZ_SUPP) ---"
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        > run_c18_k${k}.log 2>&1
    echo "    Done: k=$k"
done

echo ""
echo "Campaign 18 complete."
echo "Output dirs: ym_k<k>_a2.000_circ_az2seed_sp10.0_eps0.15_nkz0[_nkz1to<k-1>]_bp14_hd5e-05"
