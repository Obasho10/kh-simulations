#!/bin/bash
# Lx-resolution campaign wave 2 -- t133 stream
# See ymgpu2d/LX_RESOLUTION_PLAN.md
set -u
WDIR=/DATA/ym_kh/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs
LOG=$WDIR/logs/lx_resolution2_t133_runs.log
: > $LOG
echo "=== lx_resolution2 t133 start $(date) ===" >> $LOG

    # [1b_redo] lx1bredo_3pi: properly-fitting sponge (find_safe_sponge, Lx kwarg) -- smallest tier that fits
    cat > /tmp/lx1bredo_3pi.ini <<'EOINI'
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
    nx_override = 384
    lx_override = 9.42477796076938
    courant_override = 0.1
    target_tu = 50.0
    run_tag = lx1bredo_3pi
EOINI
    rm -rf /DATA/ym_kh/ymgpu2d/outputs/ym_k3_a1.1*lx1bredo_3pi*
    echo "[lx1bredo_3pi] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/ym_kh/ymgpu2d/outputs && /DATA/ym_kh/ymgpu2d/ym_coupled /tmp/lx1bredo_3pi.ini >> $LOG 2>&1) || echo "[lx1bredo_3pi] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx1bredo_3pi] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/ym_kh/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.1*lx1bredo_3pi*" >> $LOG 2>&1)

    # [3c] lx3c_wide_fine: wide EPS=0.30, finer courant
    cat > /tmp/lx3c_wide_fine.ini <<'EOINI'
    k_mode = 1
    alpha_YM = 1.0
    V0 = 0.05
    perturb_amp = 0.001
    run_mode = 6
    xi_sponge = 10.0
    sigma_sponge = 5.0
    suppress_kz0 = 1
    hyp_diff = 5e-5
    kz_suppress_max = 0
    eps_override = 0.3
    kz_suppress_hi = 14
    nz_override = 64
    nx_override = 1536
    lx_override = 37.69911184307752
    courant_override = 0.02
    target_tu = 100.0
    run_tag = lx3c_wide_fine
EOINI
    rm -rf /DATA/ym_kh/ymgpu2d/outputs/ym_k1_a1.0*lx3c_wide_fine*
    echo "[lx3c_wide_fine] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/ym_kh/ymgpu2d/outputs && /DATA/ym_kh/ymgpu2d/ym_coupled /tmp/lx3c_wide_fine.ini >> $LOG 2>&1) || echo "[lx3c_wide_fine] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3c_wide_fine] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/ym_kh/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.0*lx3c_wide_fine*" >> $LOG 2>&1)

    # [3b_wave2] lx3b2_d2_prod: alpha=6,V0=0.10,kz=7 (extends wave-1 kz=5,6 up) -- production courant
    cat > /tmp/lx3b2_d2_prod.ini <<'EOINI'
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
    courant_override = 0.1
    target_tu = 65.0
    run_tag = lx3b2_d2_prod
EOINI
    rm -rf /DATA/ym_kh/ymgpu2d/outputs/ym_k7_a6.0*lx3b2_d2_prod*
    echo "[lx3b2_d2_prod] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/ym_kh/ymgpu2d/outputs && /DATA/ym_kh/ymgpu2d/ym_coupled /tmp/lx3b2_d2_prod.ini >> $LOG 2>&1) || echo "[lx3b2_d2_prod] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3b2_d2_prod] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/ym_kh/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a6.0*lx3b2_d2_prod*" >> $LOG 2>&1)

    # [3b_wave2] lx3b2_d4_fine: alpha=6,V0=0.05,kz=8 -- sponge mechanism (V0<=0.07), not xi_cut -- finer courant (does onset time move again?)
    cat > /tmp/lx3b2_d4_fine.ini <<'EOINI'
    k_mode = 8
    alpha_YM = 6.0
    V0 = 0.05
    perturb_amp = 0.001
    run_mode = 6
    xi_sponge = 52.0
    sigma_sponge = 5.0
    suppress_kz0 = 1
    hyp_diff = 5e-5
    kz_suppress_max = 7
    eps_override = 0.1
    kz_suppress_hi = 14
    nz_override = 64
    nx_override = 1152
    courant_override = 0.02
    target_tu = 65.0
    run_tag = lx3b2_d4_fine
EOINI
    rm -rf /DATA/ym_kh/ymgpu2d/outputs/ym_k8_a6.0*lx3b2_d4_fine*
    echo "[lx3b2_d4_fine] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/ym_kh/ymgpu2d/outputs && /DATA/ym_kh/ymgpu2d/ym_coupled /tmp/lx3b2_d4_fine.ini >> $LOG 2>&1) || echo "[lx3b2_d4_fine] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3b2_d4_fine] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/ym_kh/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a6.0*lx3b2_d4_fine*" >> $LOG 2>&1)

echo "=== lx_resolution2 t133 ALL DONE $(date) ===" >> $LOG
