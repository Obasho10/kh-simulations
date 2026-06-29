#!/bin/bash
# Campaign 5: k-scan with kz=0 Weibel suppression
# mode=3 (NAB_DTANH), alpha=2.0, suppress_kz0=1
# Runs k=1..8 sequentially. Each run writes to ym_k{K}_a2.000_dtanh_nkz0/

set -e
cd /DATA/cm/lcpfct/ymgpu2d

ALPHA=2.0
AMP=0.001
MODE=3
V0=0.1
XI_SPONGE=0
SIGMA_SPONGE=5.0
FREEZE=-1
SUPPRESS_KZ0=1

# Remove the partial nkz0 smoke-test dir from earlier testing
rm -rf ym_k1_a2.000_dtanh_nkz0

echo "========================================================"
echo " Campaign 5: NAB_DTANH alpha=${ALPHA} suppress_kz0=1"
echo " k = 1 2 3 4 5 6 7 8   (sequential)"
echo " Started: $(date)"
echo "========================================================"

for K in 1 2 3 4 5 6 7 8; do
    echo ""
    echo "--- k=${K}  start: $(date) ---"
    ./ym_coupled $K $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA_SPONGE $FREEZE $SUPPRESS_KZ0
    echo "--- k=${K}  done:  $(date) ---"
done

echo ""
echo "========================================================"
echo " All runs complete: $(date)"
echo "========================================================"
