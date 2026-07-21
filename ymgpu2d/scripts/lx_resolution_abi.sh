#!/bin/bash
# Lx-reduction + extreme-parameter resolution campaign -- abi (3 GPUs)
# See ymgpu2d/LX_RESOLUTION_PLAN.md
set -u
WDIR=/DATA/s23103/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs

run_gpu0() {
    export CUDA_VISIBLE_DEVICES=0
    local WDIR=/DATA/s23103/lcpfct/ymgpu2d
    local LOG=$WDIR/logs/lx_resolution_abi_gpu0.log
    : > $LOG
    echo "[GPU0] start $(date)" >> $LOG
    # [1a] lx1a_3pi: box axis @ reference anchor, DX held fixed
    cat > /tmp/lx1a_3pi.ini <<'EOINI'
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
    nx_override = 384
    lx_override = 9.42477796076938
    courant_override = 0.01
    target_tu = 25.0
    run_tag = lx1a_3pi
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k1_a1.0*lx1a_3pi*
    echo "[lx1a_3pi] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx1a_3pi.ini >> $LOG 2>&1) || echo "[lx1a_3pi] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx1a_3pi] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.0*lx1a_3pi*" >> $LOG 2>&1)

    # [1c] lx1c_6pi: current default -- wall-clock baseline
    cat > /tmp/lx1c_6pi.ini <<'EOINI'
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
    nz_override = 64
    nx_override = 768
    lx_override = 18.84955592153876
    courant_override = 0.1
    target_tu = 100.0
    run_tag = lx1c_6pi
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k1_a1.0*lx1c_6pi*
    echo "[lx1c_6pi] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx1c_6pi.ini >> $LOG 2>&1) || echo "[lx1c_6pi] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx1c_6pi] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.0*lx1c_6pi*" >> $LOG 2>&1)

    # [3a] lx3a_kz6ext: extend corner: does the gap grow past kz=5? (production grid)
    cat > /tmp/lx3a_kz6ext.ini <<'EOINI'
    k_mode = 6
    alpha_YM = 3.0
    V0 = 0.1
    perturb_amp = 0.001
    run_mode = 6
    xi_sponge = 8.0
    sigma_sponge = 5.0
    suppress_kz0 = 1
    hyp_diff = 5e-5
    kz_suppress_max = 5
    eps_override = 0.15
    kz_suppress_hi = 14
    nz_override = 64
    nx_override = 768
    courant_override = 0.1
    target_tu = 100.0
    run_tag = lx3a_kz6ext
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k6_a3.0*lx3a_kz6ext*
    echo "[lx3a_kz6ext] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx3a_kz6ext.ini >> $LOG 2>&1) || echo "[lx3a_kz6ext] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3a_kz6ext] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a3.0*lx3a_kz6ext*" >> $LOG 2>&1)

    # [3b] lx3b_b2_prod: V0=0.10 >= hard-wall threshold -> xi_cut mechanism -- production grid baseline
    cat > /tmp/lx3b_b2_prod.ini <<'EOINI'
    k_mode = 6
    alpha_YM = 6.0
    V0 = 0.1
    perturb_amp = 0.001
    run_mode = 6
    xi_cut = 5.0
    sigma_sponge = 5.0
    suppress_kz0 = 1
    hyp_diff = 5e-5
    kz_suppress_max = 5
    eps_override = 0.1
    kz_suppress_hi = 14
    nz_override = 64
    nx_override = 1152
    courant_override = 0.1
    target_tu = 65.0
    run_tag = lx3b_b2_prod
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k6_a6.0*lx3b_b2_prod*
    echo "[lx3b_b2_prod] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx3b_b2_prod.ini >> $LOG 2>&1) || echo "[lx3b_b2_prod] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3b_b2_prod] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a6.0*lx3b_b2_prod*" >> $LOG 2>&1)

    echo "[GPU0] ALL DONE $(date)" >> $LOG
}

run_gpu1() {
    export CUDA_VISIBLE_DEVICES=1
    local WDIR=/DATA/s23103/lcpfct/ymgpu2d
    local LOG=$WDIR/logs/lx_resolution_abi_gpu1.log
    : > $LOG
    echo "[GPU1] start $(date)" >> $LOG
    # [1a] lx1a_4pi: box axis @ reference anchor, DX held fixed
    cat > /tmp/lx1a_4pi.ini <<'EOINI'
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
    nx_override = 512
    lx_override = 12.566370614359172
    courant_override = 0.01
    target_tu = 25.0
    run_tag = lx1a_4pi
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k1_a1.0*lx1a_4pi*
    echo "[lx1a_4pi] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx1a_4pi.ini >> $LOG 2>&1) || echo "[lx1a_4pi] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx1a_4pi] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.0*lx1a_4pi*" >> $LOG 2>&1)

    # [1c] lx1c_2pi: 3x-cheaper candidate -- wall-clock + gamma agreement
    cat > /tmp/lx1c_2pi.ini <<'EOINI'
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
    nz_override = 64
    nx_override = 256
    lx_override = 6.283185307179586
    courant_override = 0.1
    target_tu = 100.0
    run_tag = lx1c_2pi
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k1_a1.0*lx1c_2pi*
    echo "[lx1c_2pi] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx1c_2pi.ini >> $LOG 2>&1) || echo "[lx1c_2pi] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx1c_2pi] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.0*lx1c_2pi*" >> $LOG 2>&1)

    # [3a] lx3a_kz7ext: extend corner further: kz=7 (production grid)
    cat > /tmp/lx3a_kz7ext.ini <<'EOINI'
    k_mode = 7
    alpha_YM = 3.0
    V0 = 0.1
    perturb_amp = 0.001
    run_mode = 6
    xi_sponge = 8.0
    sigma_sponge = 5.0
    suppress_kz0 = 1
    hyp_diff = 5e-5
    kz_suppress_max = 6
    eps_override = 0.15
    kz_suppress_hi = 14
    nz_override = 64
    nx_override = 768
    courant_override = 0.1
    target_tu = 100.0
    run_tag = lx3a_kz7ext
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k7_a3.0*lx3a_kz7ext*
    echo "[lx3a_kz7ext] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx3a_kz7ext.ini >> $LOG 2>&1) || echo "[lx3a_kz7ext] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3a_kz7ext] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a3.0*lx3a_kz7ext*" >> $LOG 2>&1)

    # [3b] lx3b_b2_fine: V0=0.10 >= hard-wall threshold -> xi_cut mechanism -- finer courant, same NX (already boosted for narrow EPS)
    cat > /tmp/lx3b_b2_fine.ini <<'EOINI'
    k_mode = 6
    alpha_YM = 6.0
    V0 = 0.1
    perturb_amp = 0.001
    run_mode = 6
    xi_cut = 5.0
    sigma_sponge = 5.0
    suppress_kz0 = 1
    hyp_diff = 5e-5
    kz_suppress_max = 5
    eps_override = 0.1
    kz_suppress_hi = 14
    nz_override = 64
    nx_override = 1152
    courant_override = 0.02
    target_tu = 65.0
    run_tag = lx3b_b2_fine
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k6_a6.0*lx3b_b2_fine*
    echo "[lx3b_b2_fine] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx3b_b2_fine.ini >> $LOG 2>&1) || echo "[lx3b_b2_fine] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3b_b2_fine] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a6.0*lx3b_b2_fine*" >> $LOG 2>&1)

    echo "[GPU1] ALL DONE $(date)" >> $LOG
}

run_gpu2() {
    export CUDA_VISIBLE_DEVICES=2
    local WDIR=/DATA/s23103/lcpfct/ymgpu2d
    local LOG=$WDIR/logs/lx_resolution_abi_gpu2.log
    : > $LOG
    echo "[GPU2] start $(date)" >> $LOG
    # [1b] lx1b_6pi: known-safe box (existing convention)
    cat > /tmp/lx1b_6pi.ini <<'EOINI'
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
    nx_override = 768
    lx_override = 18.84955592153876
    courant_override = 0.1
    target_tu = 50.0
    run_tag = lx1b_6pi
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k3_a1.1*lx1b_6pi*
    echo "[lx1b_6pi] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx1b_6pi.ini >> $LOG 2>&1) || echo "[lx1b_6pi] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx1b_6pi] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.1*lx1b_6pi*" >> $LOG 2>&1)

    # [3a] lx3a_combined: NX=1152 + courant=0.05 simultaneously (plan-specified definitive rerun)
    cat > /tmp/lx3a_combined.ini <<'EOINI'
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
    nz_override = 64
    nx_override = 1152
    courant_override = 0.05
    target_tu = 100.0
    run_tag = lx3a_combined
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k5_a3.0*lx3a_combined*
    echo "[lx3a_combined] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx3a_combined.ini >> $LOG 2>&1) || echo "[lx3a_combined] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3a_combined] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a3.0*lx3a_combined*" >> $LOG 2>&1)

    # [3b] lx3b_b1_prod: V0=0.10 >= hard-wall threshold -> xi_cut mechanism -- production grid baseline
    cat > /tmp/lx3b_b1_prod.ini <<'EOINI'
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
    courant_override = 0.1
    target_tu = 65.0
    run_tag = lx3b_b1_prod
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k5_a6.0*lx3b_b1_prod*
    echo "[lx3b_b1_prod] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx3b_b1_prod.ini >> $LOG 2>&1) || echo "[lx3b_b1_prod] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3b_b1_prod] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a6.0*lx3b_b1_prod*" >> $LOG 2>&1)

    # [3b] lx3b_b3_prod: V0=0.05 <= 0.07 -> sponge mechanism, sp from blind formula ceiling-ish -- production grid baseline
    cat > /tmp/lx3b_b3_prod.ini <<'EOINI'
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
    courant_override = 0.1
    target_tu = 65.0
    run_tag = lx3b_b3_prod
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k8_a10.0*lx3b_b3_prod*
    echo "[lx3b_b3_prod] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx3b_b3_prod.ini >> $LOG 2>&1) || echo "[lx3b_b3_prod] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3b_b3_prod] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a10.0*lx3b_b3_prod*" >> $LOG 2>&1)

    echo "[GPU2] ALL DONE $(date)" >> $LOG
}

echo "=== lx_resolution abi: launching 3-GPU campaign $(date) ==="
run_gpu0 &
PID0=$!
run_gpu1 &
PID1=$!
run_gpu2 &
PID2=$!

wait $PID0 && echo 'GPU0 finished' || echo 'GPU0 FAILED'
wait $PID1 && echo 'GPU1 finished' || echo 'GPU1 FAILED'
wait $PID2 && echo 'GPU2 finished' || echo 'GPU2 FAILED'
echo "=== lx_resolution abi: all done $(date) ==="
