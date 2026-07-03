#!/bin/bash
# Campaign 10: mode-5 (NAB_TANH_COSAZ) EPS sweep to find KH onset, then kz=1..6 at thin EPS
#
# Mode 5: single thin-tanh shear + bounded cosine Az1
#   vz_A = +V0*tanh((x-Lx/2)/EPS)    — thin shear, zero at interface (no two-stream)
#   Az1  = -V0*cos(2π x/Lx)           — bounded |Az1|<=V0 (no log-cosh blow-up)
#
# KH requires kz*EPS < 0.64 (Miles criterion):
#   EPS < 0.64 for kz=1  →  EPS=0.5 should show weak KH
#   EPS < 0.10 for kz=6  →  EPS=0.1 needed for all kz=1..6
#
# Strategy:
#   Phase 1 — EPS sweep at k=1 to find KH onset threshold
#   Phase 2 — kz=1..6 at the two thinnest EPS values that survive
#
# Signature: ./ym_coupled <k_mode> <alpha> <amp> <mode> <V0>
#            <xi_sponge> <sigma_sponge> <freeze_override> <suppress_kz0>
#            <hyp_diff> <kz_suppress_max> <eps_override>
#
# Storage: t130:/DATA ~600 GB free. Each run ~200 MB CSV. Total ~2 GB.

ALPHA=2.0
V0=0.1
AMP=0.001
MODE=5          # NAB_TANH_COSAZ
HYP=5e-5
KZ0=1           # suppress kz=0

cd /DATA/cm/lcpfct/ymgpu2d

echo "=== Phase 1: EPS sweep at k=1 ==="
for EPS in 0.50 0.30 0.15 0.10; do
    echo "--- k=1  EPS=$EPS ---"
    nohup ./ym_coupled 1 $ALPHA $AMP $MODE $V0 0 5.0 -1 $KZ0 $HYP 0 $EPS \
        > run_eps${EPS}_k1_c10.log 2>&1
    echo "EPS=$EPS done"
done

echo "=== Phase 2: kz=1..6 at EPS=0.15 and EPS=0.10 ==="
for EPS in 0.15 0.10; do
    for k in 1 2 3 4 5 6; do
        KZ_SUPP=$((k - 1))
        echo "--- k=$k  EPS=$EPS  kz_suppress_max=$KZ_SUPP ---"
        nohup ./ym_coupled $k $ALPHA $AMP $MODE $V0 0 5.0 -1 $KZ0 $HYP $KZ_SUPP $EPS \
            > run_eps${EPS}_k${k}_c10.log 2>&1
        echo "k=$k EPS=$EPS done"
    done
done

echo "Campaign 10 complete."
