#!/bin/bash
# Campaign 16: Mode 1 (NAB_CIRC, log-cosh Az1) — WKB geometry test
# ABI (farmerzone) version: 3× GTX 1080 Ti, run 3 k-values per GPU batch
#
# Uses CUDA_VISIBLE_DEVICES to assign each k to a separate GPU — no contention.
# Speed: ~4500 steps/min per GPU (vs t130's 9200 steps/min). Two batches of 3
# runs → each batch ~45 min → total campaign ~90 min.
#
# See run_campaign16_t130.sh for physics motivation.

ALPHA=2.0
V0=0.1
AMP=0.001
MODE=1           # NAB_CIRC: log-cosh Az1, tanh velocity, periodic x, frozen Az1
HYP=5e-5
KZ0=1
BP=14
EPS=0.15
XI_SPONGE=10.0   # sponge at |ξ|=10; prevents outer-region blowup + gives 100× energy thresh
SIGMA=5.0

export PATH=/usr/local/cuda-12.4/bin:$PATH

cd /DATA/s23103/lcpfct/ymgpu2d

echo "=== Campaign 16 (abi): Mode 1 log-cosh Az1, WKB geometry test ==="
echo "    3× GTX 1080 Ti: running k=1,2,3 then k=4,5,6 in GPU-parallel batches"
echo ""

# ── Batch 1: k=1,2,3 on GPU 0,1,2 ──
echo "--- Batch 1: k=1 (GPU0), k=2 (GPU1), k=3 (GPU2) ---"
CUDA_VISIBLE_DEVICES=0 ./ym_coupled 1 $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP 0 $EPS $BP \
    > run_c16_k1.log 2>&1 &
PIDS="$!"

CUDA_VISIBLE_DEVICES=1 ./ym_coupled 2 $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP 1 $EPS $BP \
    > run_c16_k2.log 2>&1 &
PIDS="$PIDS $!"

CUDA_VISIBLE_DEVICES=2 ./ym_coupled 3 $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP 2 $EPS $BP \
    > run_c16_k3.log 2>&1 &
PIDS="$PIDS $!"

echo "PIDs batch 1: $PIDS"
wait $PIDS
echo "--- Batch 1 complete ---"
echo ""

# ── Batch 2: k=4,5,6 on GPU 0,1,2 ──
echo "--- Batch 2: k=4 (GPU0), k=5 (GPU1), k=6 (GPU2) ---"
CUDA_VISIBLE_DEVICES=0 ./ym_coupled 4 $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP 3 $EPS $BP \
    > run_c16_k4.log 2>&1 &
PIDS="$!"

CUDA_VISIBLE_DEVICES=1 ./ym_coupled 5 $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP 4 $EPS $BP \
    > run_c16_k5.log 2>&1 &
PIDS="$PIDS $!"

CUDA_VISIBLE_DEVICES=2 ./ym_coupled 6 $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP 5 $EPS $BP \
    > run_c16_k6.log 2>&1 &
PIDS="$PIDS $!"

echo "PIDs batch 2: $PIDS"
wait $PIDS
echo "--- Batch 2 complete ---"

echo ""
echo "Campaign 16 (abi) complete."
echo "Output dirs: ym_k<k>_a2.000_circ_sp10.0_eps0.15_nkz0[_nkz1to<k-1>]_bp14_hd5e-05"
