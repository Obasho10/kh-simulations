#!/bin/bash
# Campaign 6: k-scan with kz=0 suppression + z-hyperdiffusion
# mode=3 (NAB_DTANH), alpha=2.0, suppress_kz0=1, hyp_diff=5e-5
#
# suppress_kz0=1  kills the kz=0 Weibel eigenmode exactly
# hyp_diff=5e-5   kills the kz>=74 near-Nyquist numerical instability
#                 (<0.6% total attenuation on kz=1..8 over 200k steps)
#
# Runs k=1..8 sequentially. Output dirs: ym_k{K}_a2.000_dtanh_nkz0_hd5e-05/

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
HYP_DIFF=5e-5

echo "========================================================"
echo " Campaign 6: NAB_DTANH alpha=${ALPHA} suppress_kz0=1 hyp_diff=${HYP_DIFF}"
echo " k = 1 2 3 4 5 6 7 8   (sequential)"
echo " Started: $(date)"
echo "========================================================"

for K in 1 2 3 4 5 6 7 8; do
    echo ""
    echo "--- k=${K}  start: $(date) ---"
    ./ym_coupled $K $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA_SPONGE $FREEZE $SUPPRESS_KZ0 $HYP_DIFF
    echo "--- k=${K}  done:  $(date) ---"
done

echo ""
echo "========================================================"
echo " All runs complete: $(date)"
echo "========================================================"
