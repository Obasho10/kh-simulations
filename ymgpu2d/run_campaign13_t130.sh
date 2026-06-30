#!/bin/bash
# Campaign 13: extend suppress_kz0 to zero By1/Ex1/Ez1 at kz=0 (color-1 Weibel fix)
#
# Root cause of t≈14.7 TU NaN (Campaign 12 and all previous):
#   By1[kz=0] (z-uniform magnetic field from streaming current) grows via Weibel
#   filamentation instability at γ≈0.05 TU⁻¹.  At t≈9.8 TU it reaches a critical
#   amplitude (~0.04) and triggers a nonlinear mode explosion: By1[kz=7,10] jump
#   from 1e-8 to 0.27 in 4.9 TU (γ_nonlinear≈3.4 TU⁻¹).  This drives ½pz²/n → NaN.
#
# Previous filters did NOT touch color-1 EM sector (By1, Ex1, Ez1, Az1).
# suppress_kz0 only zeroed color-2/3 kz=0 components.
#
# Fix: extend kernel_ym_subtract_zmean (15 fields instead of 12):
#   NEW: By1[kz=0], Ex1[kz=0], Ez1[kz=0] → zeroed each step
#   (Az1 is frozen and not touched)
#   KEPT: By2/3, Ex2/3, Ez2/3, Az2/3, Q2A/3A, Q2B/3B → zeroed each step
#
# All other filters identical to Campaign 12:
#   color-2/3 kz range filter (kz≠k_target → zero)
#   fluid pz+n kz range filter (kz≠k_target → zero)
#
# Argv: k alpha amp mode V0 xi sigma freeze suppress_kz0 hyp kz_suppress_max eps bp

ALPHA=2.0
V0=0.1
AMP=0.001
MODE=5
HYP=5e-5
KZ0=1
BP=14        # covers kz=k+1..14 (two-stream band kz < sqrt(2)/V0 ≈ 14.1)
EPS=0.15

cd /DATA/cm/lcpfct/ymgpu2d

echo "=== Campaign 13: color-1 Weibel fix (suppress By1/Ex1/Ez1 at kz=0) ==="

echo "--- Phase 1: k=1 diagnostic run (kz_suppress_max=0) ---"
nohup ./ym_coupled 1 $ALPHA $AMP $MODE $V0 0 5.0 -1 $KZ0 $HYP 0 $EPS $BP \
    > run_c13_eps${EPS}_k1_ph1.log 2>&1
echo "k=1 phase1 done"

echo "=== Phase 2: kz=1..6 full sweep (kz_suppress_max=k-1) ==="
for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    echo "--- k=$k  EPS=$EPS  kz_suppress_max=$KZ_SUPP  bp=$BP ---"
    nohup ./ym_coupled $k $ALPHA $AMP $MODE $V0 0 5.0 -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        > run_c13_eps${EPS}_k${k}_bp${BP}.log 2>&1
    echo "k=$k done"
done

echo "Campaign 13 complete."
