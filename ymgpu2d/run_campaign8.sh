#!/bin/bash
# Campaign 8: kz=0 Weibel 2D parameter sweep — WKB validation
#
# Goal: map gamma(alpha, V0) across 200 runs and compare to analytic prediction
#       gamma_WKB = (sqrt(alpha^3/2)*V0)^(1/3) * sin(pi/3)
#
# Grid:
#   alpha: 10 linearly-spaced points from 1.0 to 6.0
#   V0:    20 log-spaced points from 0.001 to 0.4
#   Total: 200 sequential runs
#
# Setup:
#   run_mode=3 (NAB_DTANH — only viable geometry; avoids two-stream instability)
#   suppress_kz0=0   (we MEASURE the kz=0 Weibel mode, not suppress it)
#   hyp_diff=2e-4    (kills kz>=50 numerical noise; 4x Campaign 6 value)
#   k_mode=1, perturb_amp=0.001
#
# IMPORTANT: rebuild binary on t126 before running — main_ym.cu has a V0 directory
#   naming fix (setprecision 3→4) so all 20 V0 values get unique directory names.
#
# Run from: /DATA/cm/lcpfct/ymgpu2d/
# Analysis: python3 analyze_campaign8.py  (run in same directory after runs complete)

set -e

BINARY="./ym_coupled"
LOGFILE="campaign8.log"

# alpha: linspace(1.0, 6.0, 10)
ALPHA_VALS=(1.000 1.556 2.111 2.667 3.222 3.778 4.333 4.889 5.444 6.000)

# V0: logspace(log10(0.001), log10(0.4), 20)  — 4 significant figures
V0_VALS=(
    0.001000  0.001371  0.001879  0.002575  0.003530
    0.004839  0.006633  0.009092  0.012462  0.017083
    0.023416  0.032096  0.043995  0.060305  0.082662
    0.113307  0.155313  0.212892  0.291816  0.400000
)

N_ALPHA=${#ALPHA_VALS[@]}
N_V0=${#V0_VALS[@]}
TOTAL=$((N_ALPHA * N_V0))
RUN=0

echo "========================================================"
echo " Campaign 8: kz=0 Weibel 2D sweep"
echo " alpha: ${ALPHA_VALS[*]}"
echo " V0:    ${N_V0} log-spaced from 0.001 to 0.4"
echo " total: ${TOTAL} runs   hyp_diff=2e-4   suppress_kz0=0"
echo " Started: $(date)"
echo "========================================================" | tee "$LOGFILE"

# args: k  alpha  perturb_amp  run_mode  V0  xi_sponge  sigma_sponge  freeze_override  suppress_kz0  hyp_diff
for V0 in "${V0_VALS[@]}"; do
    for ALPHA in "${ALPHA_VALS[@]}"; do
        RUN=$((RUN + 1))
        echo "" | tee -a "$LOGFILE"
        echo "[$RUN/$TOTAL] alpha=$ALPHA  V0=$V0  start: $(date)" | tee -a "$LOGFILE"

        $BINARY 1 "$ALPHA" 0.001 3 "$V0" 0 5 -1 0 2e-4 2>&1 | tail -6 | tee -a "$LOGFILE"

        echo "[$RUN/$TOTAL] done: $(date)" | tee -a "$LOGFILE"
    done
done

echo ""  | tee -a "$LOGFILE"
echo "========================================================"  | tee -a "$LOGFILE"
echo " All $TOTAL runs complete: $(date)"                        | tee -a "$LOGFILE"
echo "========================================================"  | tee -a "$LOGFILE"
