#!/bin/bash
# Lx-reduction + extreme-parameter resolution campaign -- t133 stream
# See ymgpu2d/LX_RESOLUTION_PLAN.md
set -u
WDIR=/DATA/ym_kh/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs
LOG=$WDIR/logs/lx_resolution_t133_runs.log
: > $LOG
echo "=== lx_resolution t133 start $(date) ===" >> $LOG

    # [1a] lx1a_2pi: box axis @ reference anchor, DX held fixed
    cat > /tmp/lx1a_2pi.ini <<'EOINI'
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
    eps_override = 0.15
    kz_suppress_hi = 14
    nz_override = 256
    nx_override = 256
    lx_override = 6.283185307179586
    courant_override = 0.01
    target_tu = 25.0
    run_tag = lx1a_2pi
EOINI
    rm -rf /DATA/ym_kh/ymgpu2d/outputs/ym_k1_a1.0*lx1a_2pi*
    echo "[lx1a_2pi] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/ym_kh/ymgpu2d/outputs && /DATA/ym_kh/ymgpu2d/ym_coupled /tmp/lx1a_2pi.ini >> $LOG 2>&1) || echo "[lx1a_2pi] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx1a_2pi] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/ym_kh/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.0*lx1a_2pi*" >> $LOG 2>&1)

    # [1b] lx1b_2pi: predicted-unsafe box, same xi_sponge NOT re-derived
    cat > /tmp/lx1b_2pi.ini <<'EOINI'
    k_mode = 3
    alpha_YM = 1.1
    V0 = 0.03
    perturb_amp = 0.001
    run_mode = 6
    xi_sponge = 55.0
    sigma_sponge = 5.0
    suppress_kz0 = 1
    hyp_diff = 5e-5
    kz_suppress_max = 2
    eps_override = 0.15
    kz_suppress_hi = 14
    nz_override = 64
    nx_override = 256
    lx_override = 6.283185307179586
    courant_override = 0.1
    target_tu = 50.0
    run_tag = lx1b_2pi
EOINI
    rm -rf /DATA/ym_kh/ymgpu2d/outputs/ym_k3_a1.1*lx1b_2pi*
    echo "[lx1b_2pi] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/ym_kh/ymgpu2d/outputs && /DATA/ym_kh/ymgpu2d/ym_coupled /tmp/lx1b_2pi.ini >> $LOG 2>&1) || echo "[lx1b_2pi] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx1b_2pi] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/ym_kh/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.1*lx1b_2pi*" >> $LOG 2>&1)

    # [3a] lx3a_fullcombined: all three refined axes together -- true finest-grid ceiling
    cat > /tmp/lx3a_fullcombined.ini <<'EOINI'
    k_mode = 5
    alpha_YM = 3.0
    V0 = 0.1
    perturb_amp = 0.001
    run_mode = 6
    xi_sponge = 8.0
    sigma_sponge = 5.0
    suppress_kz0 = 1
    hyp_diff = 5e-5
    kz_suppress_max = 4
    eps_override = 0.15
    kz_suppress_hi = 14
    nz_override = 128
    nx_override = 1152
    courant_override = 0.05
    target_tu = 100.0
    run_tag = lx3a_fullcombined
EOINI
    rm -rf /DATA/ym_kh/ymgpu2d/outputs/ym_k5_a3.0*lx3a_fullcombined*
    echo "[lx3a_fullcombined] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/ym_kh/ymgpu2d/outputs && /DATA/ym_kh/ymgpu2d/ym_coupled /tmp/lx3a_fullcombined.ini >> $LOG 2>&1) || echo "[lx3a_fullcombined] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3a_fullcombined] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/ym_kh/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a3.0*lx3a_fullcombined*" >> $LOG 2>&1)

    # [3b] lx3b_b1_fine: V0=0.10 >= hard-wall threshold -> xi_cut mechanism -- finer courant, same NX (already boosted for narrow EPS)
    cat > /tmp/lx3b_b1_fine.ini <<'EOINI'
    k_mode = 5
    alpha_YM = 6.0
    V0 = 0.1
    perturb_amp = 0.001
    run_mode = 6
    xi_cut = 5.0
    sigma_sponge = 5.0
    suppress_kz0 = 1
    hyp_diff = 5e-5
    kz_suppress_max = 4
    eps_override = 0.1
    kz_suppress_hi = 14
    nz_override = 64
    nx_override = 1152
    courant_override = 0.02
    target_tu = 65.0
    run_tag = lx3b_b1_fine
EOINI
    rm -rf /DATA/ym_kh/ymgpu2d/outputs/ym_k5_a6.0*lx3b_b1_fine*
    echo "[lx3b_b1_fine] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/ym_kh/ymgpu2d/outputs && /DATA/ym_kh/ymgpu2d/ym_coupled /tmp/lx3b_b1_fine.ini >> $LOG 2>&1) || echo "[lx3b_b1_fine] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3b_b1_fine] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/ym_kh/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a6.0*lx3b_b1_fine*" >> $LOG 2>&1)

    # [3b] lx3b_b3_fine: V0=0.05 <= 0.07 -> sponge mechanism, sp from blind formula ceiling-ish -- finer courant, same NX (already boosted for narrow EPS)
    cat > /tmp/lx3b_b3_fine.ini <<'EOINI'
    k_mode = 8
    alpha_YM = 10.0
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
    run_tag = lx3b_b3_fine
EOINI
    rm -rf /DATA/ym_kh/ymgpu2d/outputs/ym_k8_a10.0*lx3b_b3_fine*
    echo "[lx3b_b3_fine] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/ym_kh/ymgpu2d/outputs && /DATA/ym_kh/ymgpu2d/ym_coupled /tmp/lx3b_b3_fine.ini >> $LOG 2>&1) || echo "[lx3b_b3_fine] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3b_b3_fine] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/ym_kh/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a10.0*lx3b_b3_fine*" >> $LOG 2>&1)

echo "=== lx_resolution t133 ALL DONE $(date) ===" >> $LOG
