#!/bin/bash
# Campaign 9: kz=1..6 dispersion sweep on t130
# Parameters: alpha=2, V0=0.1 (kz=0 sweet spot from Campaign 8)
# Suppression: kz=0 (subtract mean) + kz=1..k_mode-1 (DFT subtraction) + high-kz hyperdiff
# Each run isolates its target kz by suppressing all modes below it.
#
# Signature: ./ym_coupled <k_mode> <alpha> <perturb_amp> <run_mode> <V0>
#            <xi_sponge> <sigma_sponge> <freeze_override> <suppress_kz0>
#            <hyp_diff> <kz_suppress_max>
#
# Storage note: t130:/DATA has ~600 GB free — each run ~200 MB CSV → 6 runs ≈ 1.2 GB total.

ALPHA=2.0
V0=0.1
AMP=0.001
MODE=4          # NAB_STEP
HYP=5e-5        # hyperdiffusion kills kz>=74

cd /DATA/cm/lcpfct/ymgpu2d

for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))   # suppress kz=0..k-1; kz=1 run suppresses only kz=0 via suppress_kz0
    echo "=== k=$k  kz_suppress_max=$KZ_SUPP ==="
    nohup ./ym_coupled $k $ALPHA $AMP $MODE $V0 0 5.0 -1 1 $HYP $KZ_SUPP \
        > run_k${k}_a${ALPHA}_c9.log 2>&1
    echo "k=$k done"
done

echo "Campaign 9 complete."
