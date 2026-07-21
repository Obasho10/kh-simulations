#!/bin/bash
# Lx-resolution campaign wave 2 -- t140 stream
# See ymgpu2d/LX_RESOLUTION_PLAN.md
set -u
WDIR=/DATA/cm/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs
LOG=$WDIR/logs/lx_resolution2_t140_runs.log
: > $LOG
echo "=== lx_resolution2 t140 start $(date) ===" >> $LOG

    # [1b_redo] lx1bredo_6pi: same valid sponge, wider box -- isolates box-size alone
    cat > /tmp/lx1bredo_6pi.ini <<'EOINI'
    k_mode = 3
    alpha_YM = 1.1
    V0 = 0.03
    perturb_amp = 0.001
    run_mode = 6
    xi_sponge = 22.0
    sigma_sponge = 5.0
    suppress_kz0 = 1
    hyp_diff = 5e-5
    kz_suppress_max = 2
    eps_override = 0.15
    kz_suppress_hi = 14
    nz_override = 64
    nx_override = 768
    lx_override = 18.84955592153876
    courant_override = 0.1
    target_tu = 50.0
    run_tag = lx1bredo_6pi
EOINI
    rm -rf /DATA/cm/lcpfct/ymgpu2d/outputs/ym_k3_a1.1*lx1bredo_6pi*
    echo "[lx1bredo_6pi] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/lx1bredo_6pi.ini >> $LOG 2>&1) || echo "[lx1bredo_6pi] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx1bredo_6pi] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/cm/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.1*lx1bredo_6pi*" >> $LOG 2>&1)

    # [3c] lx3c_edge_base: kz=13 near filter-band edge (kz_suppress_hi=14), production grid
    cat > /tmp/lx3c_edge_base.ini <<'EOINI'
    k_mode = 13
    alpha_YM = 1.0
    V0 = 0.05
    perturb_amp = 0.001
    run_mode = 6
    xi_sponge = 10.0
    sigma_sponge = 5.0
    suppress_kz0 = 1
    hyp_diff = 5e-5
    kz_suppress_max = 12
    eps_override = 0.15
    kz_suppress_hi = 14
    nz_override = 64
    nx_override = 768
    courant_override = 0.1
    target_tu = 50.0
    run_tag = lx3c_edge_base
EOINI
    rm -rf /DATA/cm/lcpfct/ymgpu2d/outputs/ym_k13_a1.0*lx3c_edge_base*
    echo "[lx3c_edge_base] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/lx3c_edge_base.ini >> $LOG 2>&1) || echo "[lx3c_edge_base] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3c_edge_base] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/cm/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.0*lx3c_edge_base*" >> $LOG 2>&1)

    # [3b_wave2] lx3b2_d2_fine: alpha=6,V0=0.10,kz=7 (extends wave-1 kz=5,6 up) -- finer courant (does onset time move again?)
    cat > /tmp/lx3b2_d2_fine.ini <<'EOINI'
    k_mode = 7
    alpha_YM = 6.0
    V0 = 0.1
    perturb_amp = 0.001
    run_mode = 6
    xi_cut = 5.0
    sigma_sponge = 5.0
    suppress_kz0 = 1
    hyp_diff = 5e-5
    kz_suppress_max = 6
    eps_override = 0.1
    kz_suppress_hi = 14
    nz_override = 64
    nx_override = 1152
    courant_override = 0.02
    target_tu = 65.0
    run_tag = lx3b2_d2_fine
EOINI
    rm -rf /DATA/cm/lcpfct/ymgpu2d/outputs/ym_k7_a6.0*lx3b2_d2_fine*
    echo "[lx3b2_d2_fine] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/lx3b2_d2_fine.ini >> $LOG 2>&1) || echo "[lx3b2_d2_fine] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3b2_d2_fine] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/cm/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a6.0*lx3b2_d2_fine*" >> $LOG 2>&1)

    # [3b_wave2] lx3b2_d5_prod: alpha=10,V0=0.10,kz=8 -- hardest combo, xi_cut mechanism -- production courant
    cat > /tmp/lx3b2_d5_prod.ini <<'EOINI'
    k_mode = 8
    alpha_YM = 10.0
    V0 = 0.1
    perturb_amp = 0.001
    run_mode = 6
    xi_cut = 5.0
    sigma_sponge = 5.0
    suppress_kz0 = 1
    hyp_diff = 5e-5
    kz_suppress_max = 7
    eps_override = 0.1
    kz_suppress_hi = 14
    nz_override = 64
    nx_override = 1152
    courant_override = 0.1
    target_tu = 65.0
    run_tag = lx3b2_d5_prod
EOINI
    rm -rf /DATA/cm/lcpfct/ymgpu2d/outputs/ym_k8_a10.0*lx3b2_d5_prod*
    echo "[lx3b2_d5_prod] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/lx3b2_d5_prod.ini >> $LOG 2>&1) || echo "[lx3b2_d5_prod] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3b2_d5_prod] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/cm/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a10.0*lx3b2_d5_prod*" >> $LOG 2>&1)

echo "=== lx_resolution2 t140 ALL DONE $(date) ===" >> $LOG
