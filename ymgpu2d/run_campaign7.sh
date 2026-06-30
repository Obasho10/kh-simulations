#!/bin/bash
# Campaign 7: NAB_STEP (mode 4) + suppress_kz0=1 + hyp_diff=5e-5, alpha=2.0, k=1..8
# Goal: eliminate FCT NaN wall (step velocity has no smooth shear) while keeping
#       kz=0 Weibel suppressed. First clean window to observe kz>=1 KH growth.
# Run from: /DATA/cm/lcpfct/ymgpu2d/

set -e
LOGFILE="campaign7.log"
BINARY="./ym_coupled"

echo "========================================================"
echo " Campaign 7: NAB_STEP alpha=2.0 suppress_kz0=1 hyp_diff=5e-5"
echo " k = 1 2 3 4 5 6 7 8   (sequential)"
echo " Started: $(date)"
echo "========================================================" | tee "$LOGFILE"

for k in 1 2 3 4 5 6 7 8; do
    echo "" | tee -a "$LOGFILE"
    echo "--- k=$k  start: $(date) ---" | tee -a "$LOGFILE"

    # args: k  alpha  perturb_amp  run_mode  V0  xi_sponge  sigma_sponge  freeze_override  suppress_kz0  hyp_diff
    $BINARY $k 2.0 0.001 4 0.1 0 5 -1 1 5e-5 2>&1 | tee -a "$LOGFILE"

    echo "--- k=$k  done:  $(date) ---" | tee -a "$LOGFILE"
done

echo "" | tee -a "$LOGFILE"
echo "========================================================"   | tee -a "$LOGFILE"
echo " All runs complete: $(date)"                                | tee -a "$LOGFILE"
echo "========================================================"   | tee -a "$LOGFILE"
