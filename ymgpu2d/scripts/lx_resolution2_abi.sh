#!/bin/bash
# Lx-resolution campaign wave 2 -- abi (3 GPUs)
# See ymgpu2d/LX_RESOLUTION_PLAN.md
set -u
WDIR=/DATA/s23103/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs

run_gpu0() {
    export CUDA_VISIBLE_DEVICES=0
    local WDIR=/DATA/s23103/lcpfct/ymgpu2d
    local LOG=$WDIR/logs/lx_resolution2_abi_gpu0.log
    : > $LOG
    echo "[GPU0] start $(date)" >> $LOG
    # [3c] lx3c_narrow_base: narrow EPS=0.12 production grid (NX=960 per EPS/DX>=6 rule)
    cat > /tmp/lx3c_narrow_base.ini <<'EOINI'
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
    eps_override = 0.12
    kz_suppress_hi = 14
    nz_override = 64
    nx_override = 960
    courant_override = 0.1
    target_tu = 100.0
    run_tag = lx3c_narrow_base
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k1_a1.0*lx3c_narrow_base*
    echo "[lx3c_narrow_base] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx3c_narrow_base.ini >> $LOG 2>&1) || echo "[lx3c_narrow_base] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3c_narrow_base] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.0*lx3c_narrow_base*" >> $LOG 2>&1)

    # [3c] lx3c_edge_fine: kz=13 near filter-band edge, NZ refined (Filter Nyquist Rule concern)
    cat > /tmp/lx3c_edge_fine.ini <<'EOINI'
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
    nz_override = 128
    nx_override = 768
    courant_override = 0.1
    target_tu = 50.0
    run_tag = lx3c_edge_fine
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k13_a1.0*lx3c_edge_fine*
    echo "[lx3c_edge_fine] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx3c_edge_fine.ini >> $LOG 2>&1) || echo "[lx3c_edge_fine] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3c_edge_fine] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.0*lx3c_edge_fine*" >> $LOG 2>&1)

    # [3b_wave2] lx3b2_d3_prod: alpha=6,V0=0.10,kz=8 -- production courant
    cat > /tmp/lx3b2_d3_prod.ini <<'EOINI'
    k_mode = 8
    alpha_YM = 6.0
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
    run_tag = lx3b2_d3_prod
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k8_a6.0*lx3b2_d3_prod*
    echo "[lx3b2_d3_prod] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx3b2_d3_prod.ini >> $LOG 2>&1) || echo "[lx3b2_d3_prod] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3b2_d3_prod] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a6.0*lx3b2_d3_prod*" >> $LOG 2>&1)

    # [3b_wave2] lx3b2_d5_fine: alpha=10,V0=0.10,kz=8 -- hardest combo, xi_cut mechanism -- finer courant (does onset time move again?)
    cat > /tmp/lx3b2_d5_fine.ini <<'EOINI'
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
    courant_override = 0.02
    target_tu = 65.0
    run_tag = lx3b2_d5_fine
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k8_a10.0*lx3b2_d5_fine*
    echo "[lx3b2_d5_fine] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx3b2_d5_fine.ini >> $LOG 2>&1) || echo "[lx3b2_d5_fine] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3b2_d5_fine] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a10.0*lx3b2_d5_fine*" >> $LOG 2>&1)

    echo "[GPU0] ALL DONE $(date)" >> $LOG
}

run_gpu1() {
    export CUDA_VISIBLE_DEVICES=1
    local WDIR=/DATA/s23103/lcpfct/ymgpu2d
    local LOG=$WDIR/logs/lx_resolution2_abi_gpu1.log
    : > $LOG
    echo "[GPU1] start $(date)" >> $LOG
    # [3c] lx3c_narrow_fine: narrow EPS=0.12, further NX + finer courant combined
    cat > /tmp/lx3c_narrow_fine.ini <<'EOINI'
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
    eps_override = 0.12
    kz_suppress_hi = 14
    nz_override = 64
    nx_override = 1344
    courant_override = 0.05
    target_tu = 100.0
    run_tag = lx3c_narrow_fine
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k1_a1.0*lx3c_narrow_fine*
    echo "[lx3c_narrow_fine] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx3c_narrow_fine.ini >> $LOG 2>&1) || echo "[lx3c_narrow_fine] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3c_narrow_fine] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.0*lx3c_narrow_fine*" >> $LOG 2>&1)

    # [3b_wave2] lx3b2_d1_prod: alpha=6,V0=0.10,kz=4 (extends wave-1 kz=5,6 down) -- production courant
    cat > /tmp/lx3b2_d1_prod.ini <<'EOINI'
    k_mode = 4
    alpha_YM = 6.0
    V0 = 0.1
    perturb_amp = 0.001
    run_mode = 6
    xi_cut = 5.0
    sigma_sponge = 5.0
    suppress_kz0 = 1
    hyp_diff = 5e-5
    kz_suppress_max = 3
    eps_override = 0.1
    kz_suppress_hi = 14
    nz_override = 64
    nx_override = 1152
    courant_override = 0.1
    target_tu = 65.0
    run_tag = lx3b2_d1_prod
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k4_a6.0*lx3b2_d1_prod*
    echo "[lx3b2_d1_prod] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx3b2_d1_prod.ini >> $LOG 2>&1) || echo "[lx3b2_d1_prod] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3b2_d1_prod] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a6.0*lx3b2_d1_prod*" >> $LOG 2>&1)

    # [3b_wave2] lx3b2_d3_fine: alpha=6,V0=0.10,kz=8 -- finer courant (does onset time move again?)
    cat > /tmp/lx3b2_d3_fine.ini <<'EOINI'
    k_mode = 8
    alpha_YM = 6.0
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
    courant_override = 0.02
    target_tu = 65.0
    run_tag = lx3b2_d3_fine
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k8_a6.0*lx3b2_d3_fine*
    echo "[lx3b2_d3_fine] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx3b2_d3_fine.ini >> $LOG 2>&1) || echo "[lx3b2_d3_fine] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3b2_d3_fine] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a6.0*lx3b2_d3_fine*" >> $LOG 2>&1)

    echo "[GPU1] ALL DONE $(date)" >> $LOG
}

run_gpu2() {
    export CUDA_VISIBLE_DEVICES=2
    local WDIR=/DATA/s23103/lcpfct/ymgpu2d
    local LOG=$WDIR/logs/lx_resolution2_abi_gpu2.log
    : > $LOG
    echo "[GPU2] start $(date)" >> $LOG
    # [3c] lx3c_wide_base: wide EPS=0.30 production grid (existing box-doubling convention)
    cat > /tmp/lx3c_wide_base.ini <<'EOINI'
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
    courant_override = 0.1
    target_tu = 100.0
    run_tag = lx3c_wide_base
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k1_a1.0*lx3c_wide_base*
    echo "[lx3c_wide_base] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx3c_wide_base.ini >> $LOG 2>&1) || echo "[lx3c_wide_base] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3c_wide_base] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.0*lx3c_wide_base*" >> $LOG 2>&1)

    # [3b_wave2] lx3b2_d1_fine: alpha=6,V0=0.10,kz=4 (extends wave-1 kz=5,6 down) -- finer courant (does onset time move again?)
    cat > /tmp/lx3b2_d1_fine.ini <<'EOINI'
    k_mode = 4
    alpha_YM = 6.0
    V0 = 0.1
    perturb_amp = 0.001
    run_mode = 6
    xi_cut = 5.0
    sigma_sponge = 5.0
    suppress_kz0 = 1
    hyp_diff = 5e-5
    kz_suppress_max = 3
    eps_override = 0.1
    kz_suppress_hi = 14
    nz_override = 64
    nx_override = 1152
    courant_override = 0.02
    target_tu = 65.0
    run_tag = lx3b2_d1_fine
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k4_a6.0*lx3b2_d1_fine*
    echo "[lx3b2_d1_fine] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx3b2_d1_fine.ini >> $LOG 2>&1) || echo "[lx3b2_d1_fine] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3b2_d1_fine] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a6.0*lx3b2_d1_fine*" >> $LOG 2>&1)

    # [3b_wave2] lx3b2_d4_prod: alpha=6,V0=0.05,kz=8 -- sponge mechanism (V0<=0.07), not xi_cut -- production courant
    cat > /tmp/lx3b2_d4_prod.ini <<'EOINI'
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
    courant_override = 0.1
    target_tu = 65.0
    run_tag = lx3b2_d4_prod
EOINI
    rm -rf /DATA/s23103/lcpfct/ymgpu2d/outputs/ym_k8_a6.0*lx3b2_d4_prod*
    echo "[lx3b2_d4_prod] start $(date +%s) $(date)" >> $LOG
    _T0=$(date +%s)
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && /DATA/s23103/lcpfct/ymgpu2d/ym_coupled /tmp/lx3b2_d4_prod.ini >> $LOG 2>&1) || echo "[lx3b2_d4_prod] CRASHED (exit $?) $(date)" >> $LOG
    _T1=$(date +%s)
    echo "[lx3b2_d4_prod] done elapsed=$((_T1-_T0))s $(date)" >> $LOG
    (cd /DATA/s23103/lcpfct/ymgpu2d/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a6.0*lx3b2_d4_prod*" >> $LOG 2>&1)

    echo "[GPU2] ALL DONE $(date)" >> $LOG
}

echo "=== lx_resolution2 abi: launching 3-GPU campaign $(date) ==="
run_gpu0 &
PID0=$!
run_gpu1 &
PID1=$!
run_gpu2 &
PID2=$!

wait $PID0 && echo 'GPU0 finished' || echo 'GPU0 FAILED'
wait $PID1 && echo 'GPU1 finished' || echo 'GPU1 FAILED'
wait $PID2 && echo 'GPU2 finished' || echo 'GPU2 FAILED'
echo "=== lx_resolution2 abi: all done $(date) ==="
