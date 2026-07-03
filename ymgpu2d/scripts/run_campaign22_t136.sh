#!/bin/bash
# Campaign 22: NAB_CIRC_AZ2 (Mode 6), alpha=1.0, V0=0.05 — low coupling exploration
#
# Why this parameter point:
#   xi_crit(kz=1) = kz/(alpha*V0) ~ 20 >> xi_sponge=10 => NO outer EM instability.
#   All eigenmodes peak at xi~10 (sponge boundary), gamma~0.08-0.12 TU^-1.
#   WKB better approximation at small alpha*V0 (ex/WKB 0.39..1.27 vs 0.48..0.80 in C18).
#   No Im(gamma): pure exponential growth, easy to fit.
#   Xi_sponge=10 (relaxed, same as C18) is safe — no tight-sponge trade-off needed.
# Server: t136 (RTX A5000, sm_86).

ALPHA=1.0
V0=0.05
AMP=0.001
MODE=6
HYP=5e-5
KZ0=1
BP=14
EPS=0.15
XI_SPONGE=10.0
SIGMA=5.0

cd /DATA/cm/lcpfct/ymgpu2d

echo "=== Campaign 22 (t136): Mode 6 NAB_CIRC_AZ2, alpha=1.0, V0=0.05, xi_sponge=10.0 ==="
echo "    xi_crit(kz=1)~20 >> xi_sponge=10: outer EM fully suppressed, no tight sponge needed"
echo "    Eigenvalue predictions: gamma_exact=0.080/0.110/0.120/0.122/0.119/0.115 TU^-1 (kz=1..6)"
echo "    WKB: 0.203/0.153/0.127/0.111/0.099/0.091 TU^-1 (ex/WKB=0.39..1.27)"
echo "    All modes: Az/By=94-1190, use Az_circ for measurement, xi_peak~10.1"
echo ""

for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    echo "--- k=$k (kz_suppress_max=$KZ_SUPP) ---"
    ./ym_coupled $k $ALPHA $AMP $MODE $V0 $XI_SPONGE $SIGMA -1 $KZ0 $HYP $KZ_SUPP $EPS $BP \
        > run_c22_k${k}.log 2>&1
    echo "    Done: k=$k"
done

echo ""
echo "Campaign 22 complete."
