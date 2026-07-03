#!/bin/bash
# Campaign 11: mode-5 bandpass filter — suppress two-stream at kz~10-14 via high-kz DFT kill
#
# Campaign 10 showed:
#   - KH mode IS growing at target kz (gamma_KH ~ 0.06-0.17 TU^-1)
#   - Two-stream at kz~10 grows 10x faster (gamma_ts ~ 0.8 TU^-1), kills runs at t~17-20 TU
#   - The two-stream is amplified through the non-Abelian (color-2/3) coupling
#
# Fix: bandpass filter on color-2/3 fields — keep ONLY kz=k_mode, zero everything else.
#   Low side:  suppress kz=0 (suppress_kz0=1) + kz=1..k-1 (kz_suppress_max=k-1)
#   High side: suppress kz=k+1..40 (kz_suppress_hi=40) — covers two-stream danger zone
#
# Argv: k alpha amp mode V0 xi_sponge sigma freeze_override suppress_kz0 hyp_diff
#       kz_suppress_max eps_override kz_suppress_hi
# Note: eps_override is argv[12], kz_suppress_hi is argv[13]
#
# Storage: t130:/DATA ~600 GB free. Phase 1: 4 runs ~0.8 GB. Phase 2: 12 runs ~2.4 GB.

ALPHA=2.0
V0=0.1
AMP=0.001
MODE=5
HYP=5e-5
KZ0=1
BP=40        # suppress kz=k+1..40 (bandpass high side)

cd /DATA/cm/lcpfct/ymgpu2d

echo "=== Phase 1: confirm two-stream suppression at k=1, EPS sweep ==="
for EPS in 0.50 0.15 0.10; do
    KZ_SUPP=0   # k=1, suppress nothing below
    echo "--- k=1  EPS=$EPS  bp=$BP ---"
    nohup ./ym_coupled 1 $ALPHA $AMP $MODE $V0 0 5.0 -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        > run_bp_eps${EPS}_k1_c11.log 2>&1
    echo "done"
done

echo "=== Phase 2: kz=1..6 bandpass at EPS=0.15 ==="
EPS=0.15
for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    echo "--- k=$k  EPS=$EPS  kz_suppress_max=$KZ_SUPP  bp=$BP ---"
    nohup ./ym_coupled $k $ALPHA $AMP $MODE $V0 0 5.0 -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        > run_bp_eps${EPS}_k${k}_c11.log 2>&1
    echo "k=$k done"
done

echo "Campaign 11 complete."
