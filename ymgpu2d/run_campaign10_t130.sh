#!/bin/bash
# Campaign 10: kz=1..6 dispersion sweep on t130 — NAB_DTANH (mode 3, NOT mode 4)
# Parameters: alpha=2, V0=0.1 (Campaign 8 sweet spot for kz=0 WKB validation)
# Suppression: kz=0 (subtract mean) + kz=1..k-1 (new DFT kernel) + high-kz hyperdiff
#
# Campaign 9 was aborted: accidentally used NAB_STEP (mode=4) which has a fatal
# color-1 two-stream instability at t≈12-22 TU regardless of suppression settings.
# This script uses NAB_DTANH (mode=3) — double-tanh shear, periodic BC, FCT NaN wall
# at t=63-71 TU gives ~60 TU of clean window.
#
# Signature: ./ym_coupled <k_mode> <alpha> <perturb_amp> <run_mode> <V0>
#            <xi_sponge> <sigma_sponge> <freeze_override> <suppress_kz0>
#            <hyp_diff> <kz_suppress_max>
#
# Storage note: t130:/DATA has ~600 GB free. Each run ~200 MB CSV → 6 runs ≈ 1.2 GB.

ALPHA=2.0
V0=0.1
AMP=0.001
MODE=3          # NAB_DTANH — double-tanh shear, bounded domain, no two-stream issue
HYP=5e-5        # hyperdiffusion kills kz>=74

cd /DATA/cm/lcpfct/ymgpu2d

for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))   # suppress kz=0..k-1; isolates target mode kz=k
    echo "=== k=$k  kz_suppress_max=$KZ_SUPP ==="
    nohup ./ym_coupled $k $ALPHA $AMP $MODE $V0 0 5.0 -1 1 $HYP $KZ_SUPP \
        > run_k${k}_a${ALPHA}_c10.log 2>&1
    echo "k=$k done"
done

echo "Campaign 10 complete."
