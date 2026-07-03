#!/bin/bash
# Campaign 17: Mode 1 (NAB_CIRC, log-cosh Az1), alpha=0.5 — reduced-cascade WKB test
#
# Campaign 16 (alpha=2.0) showed:
#   kz=1: γ=0.281 TU⁻¹ (clean WKB mode)
#   kz=2..6: precession cascade (γ≈0.20-0.24) masks KH signal entirely
#
# With alpha=0.5:
#   cascade rate: α×V0 = 0.05 TU⁻¹  (4× slower than C16)
#   mode width:   ξ_char = EPS/sqrt(α·kz·V0) ≈ 4.5 EPS-units at kz=1 (2× wider than C16)
#   → xi_sponge raised from 10→20 to avoid clipping the wider eigenmode
#     (at ξ=20, mode tail amplitude ≈ exp(-10) ≈ 0 for kz=1)
#
# If γ_KH(kz=2..6) > 0.05 TU⁻¹, they should now be visible above the cascade floor.
# WKB growth rates will also be smaller at α=0.5 (weaker coupling → weaker instability).

ALPHA=0.5
V0=0.1
AMP=0.001
MODE=1
HYP=5e-5
KZ0=1
BP=14
EPS=0.15
XI_SPONGE=20.0   # wider than C16 (10.0) to avoid clipping the larger-α=0.5 eigenmode
SIGMA=5.0

export PATH=/usr/local/cuda-12.4/bin:$PATH

cd /DATA/s23103/lcpfct/ymgpu2d

echo "=== Campaign 17 (abi): Mode 1, alpha=0.5, reduced cascade, WKB kz=1..6 ==="
echo "    Cascade rate: α×V0 = 0.050 TU⁻¹  (vs 0.20 in C16)"
echo "    Mode width kz=1: ξ_char≈4.5  (vs 2.2 in C16) → xi_sponge=20"
echo ""

# ── Batch 1: k=1,2,3 on GPU 0,1,2 ──
echo "--- Batch 1: k=1 (GPU0), k=2 (GPU1), k=3 (GPU2) ---"
CUDA_VISIBLE_DEVICES=0 ./ym_coupled 1 $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP 0 $EPS $BP \
    > run_c17_k1.log 2>&1 &
PIDS="$!"

CUDA_VISIBLE_DEVICES=1 ./ym_coupled 2 $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP 1 $EPS $BP \
    > run_c17_k2.log 2>&1 &
PIDS="$PIDS $!"

CUDA_VISIBLE_DEVICES=2 ./ym_coupled 3 $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP 2 $EPS $BP \
    > run_c17_k3.log 2>&1 &
PIDS="$PIDS $!"

echo "PIDs batch 1: $PIDS"
wait $PIDS
echo "--- Batch 1 complete ---"
echo ""

# ── Batch 2: k=4,5,6 on GPU 0,1,2 ──
echo "--- Batch 2: k=4 (GPU0), k=5 (GPU1), k=6 (GPU2) ---"
CUDA_VISIBLE_DEVICES=0 ./ym_coupled 4 $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP 3 $EPS $BP \
    > run_c17_k4.log 2>&1 &
PIDS="$!"

CUDA_VISIBLE_DEVICES=1 ./ym_coupled 5 $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP 4 $EPS $BP \
    > run_c17_k5.log 2>&1 &
PIDS="$PIDS $!"

CUDA_VISIBLE_DEVICES=2 ./ym_coupled 6 $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP 5 $EPS $BP \
    > run_c17_k6.log 2>&1 &
PIDS="$PIDS $!"

echo "PIDs batch 2: $PIDS"
wait $PIDS
echo "--- Batch 2 complete ---"

echo ""
echo "Campaign 17 complete."
