#!/bin/bash
# tier investigation -- abi (3 GPUs)
set -e
WDIR=/DATA/s23103/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs

run_gpu0() {
    export CUDA_VISIBLE_DEVICES=0
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/tierprobe_abi0_progress.log
    echo "[GPU0] start $(date)" >> $LOG
cat > /tmp/tp_abi0_Bfine_1x_a2.6_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100
lz_override = 50.265482
nz_override = 512
run_tag = tierprobe_Bfine_1x
EOINI
echo "[GPU0] Bfine_1x a=2.6 V0=0.05 kz=0.625 nz=512 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tp_abi0_Bfine_1x_a2.6_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[GPU0] Bfine_1x a=2.6 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.600_*_v0.0500_*_tierprobe_Bfine_1x" >> ../logs/inline_extract.log 2>&1)
echo "[GPU0] Bfine_1x a=2.6 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/tp_abi0_A_half_a1.5_v0.03_kz7.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 200
lz_override = 12.566371
nz_override = 128
run_tag = tierprobe_A_half
EOINI
echo "[GPU0] A_half a=1.5 V0=0.03 kz=7 nz=128 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tp_abi0_A_half_a1.5_v0.03_kz7.ini >> $LOG 2>&1) || echo "[GPU0] A_half a=1.5 V0=0.03 kz=7 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a1.500_*_v0.0300_*_tierprobe_A_half" >> ../logs/inline_extract.log 2>&1)
echo "[GPU0] A_half a=1.5 V0=0.03 kz=7 done $(date)" >> $LOG

cat > /tmp/tp_abi0_A_half_a0.4_v0.01_kz2.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 200
lz_override = 12.566371
nz_override = 128
run_tag = tierprobe_A_half
EOINI
echo "[GPU0] A_half a=0.4 V0=0.01 kz=2 nz=128 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tp_abi0_A_half_a0.4_v0.01_kz2.ini >> $LOG 2>&1) || echo "[GPU0] A_half a=0.4 V0=0.01 kz=2 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a0.400_*_v0.0100_*_tierprobe_A_half" >> ../logs/inline_extract.log 2>&1)
echo "[GPU0] A_half a=0.4 V0=0.01 kz=2 done $(date)" >> $LOG

    echo "[GPU0] ALL DONE $(date)" >> $LOG
}

run_gpu1() {
    export CUDA_VISIBLE_DEVICES=1
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/tierprobe_abi1_progress.log
    echo "[GPU1] start $(date)" >> $LOG
cat > /tmp/tp_abi1_Bfine_1x_a2.9_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 100
lz_override = 50.265482
nz_override = 512
run_tag = tierprobe_Bfine_1x
EOINI
echo "[GPU1] Bfine_1x a=2.9 V0=0.05 kz=1.75 nz=512 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tp_abi1_Bfine_1x_a2.9_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[GPU1] Bfine_1x a=2.9 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a2.900_*_v0.0500_*_tierprobe_Bfine_1x" >> ../logs/inline_extract.log 2>&1)
echo "[GPU1] Bfine_1x a=2.9 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/tp_abi1_A_half_a1.7_v0.03_kz8.ini <<'EOINI'
k_mode = 16
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 15
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 200
lz_override = 12.566371
nz_override = 128
run_tag = tierprobe_A_half
EOINI
echo "[GPU1] A_half a=1.7 V0=0.03 kz=8 nz=128 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tp_abi1_A_half_a1.7_v0.03_kz8.ini >> $LOG 2>&1) || echo "[GPU1] A_half a=1.7 V0=0.03 kz=8 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k16_a1.700_*_v0.0300_*_tierprobe_A_half" >> ../logs/inline_extract.log 2>&1)
echo "[GPU1] A_half a=1.7 V0=0.03 kz=8 done $(date)" >> $LOG

cat > /tmp/tp_abi1_Bhalf_2x_a0.6_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 256
run_tag = tierprobe_Bhalf_2x
EOINI
echo "[GPU1] Bhalf_2x a=0.6 V0=0.05 kz=0.5 nz=256 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tp_abi1_Bhalf_2x_a0.6_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[GPU1] Bhalf_2x a=0.6 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.600_*_v0.0500_*_tierprobe_Bhalf_2x" >> ../logs/inline_extract.log 2>&1)
echo "[GPU1] Bhalf_2x a=0.6 V0=0.05 kz=0.5 done $(date)" >> $LOG

    echo "[GPU1] ALL DONE $(date)" >> $LOG
}

run_gpu2() {
    export CUDA_VISIBLE_DEVICES=2
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/tierprobe_abi2_progress.log
    echo "[GPU2] start $(date)" >> $LOG
cat > /tmp/tp_abi2_A_half_a1.9_v0.05_kz8.ini <<'EOINI'
k_mode = 16
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 15
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 200
lz_override = 12.566371
nz_override = 128
run_tag = tierprobe_A_half
EOINI
echo "[GPU2] A_half a=1.9 V0=0.05 kz=8 nz=128 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tp_abi2_A_half_a1.9_v0.05_kz8.ini >> $LOG 2>&1) || echo "[GPU2] A_half a=1.9 V0=0.05 kz=8 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k16_a1.900_*_v0.0500_*_tierprobe_A_half" >> ../logs/inline_extract.log 2>&1)
echo "[GPU2] A_half a=1.9 V0=0.05 kz=8 done $(date)" >> $LOG

cat > /tmp/tp_abi2_A_half_a1.5_v0.05_kz8.ini <<'EOINI'
k_mode = 16
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 15
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 200
lz_override = 12.566371
nz_override = 128
run_tag = tierprobe_A_half
EOINI
echo "[GPU2] A_half a=1.5 V0=0.05 kz=8 nz=128 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tp_abi2_A_half_a1.5_v0.05_kz8.ini >> $LOG 2>&1) || echo "[GPU2] A_half a=1.5 V0=0.05 kz=8 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k16_a1.500_*_v0.0500_*_tierprobe_A_half" >> ../logs/inline_extract.log 2>&1)
echo "[GPU2] A_half a=1.5 V0=0.05 kz=8 done $(date)" >> $LOG

cat > /tmp/tp_abi2_A_half_a0.6_v0.01_kz4.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 200
lz_override = 12.566371
nz_override = 128
run_tag = tierprobe_A_half
EOINI
echo "[GPU2] A_half a=0.6 V0=0.01 kz=4 nz=128 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tp_abi2_A_half_a0.6_v0.01_kz4.ini >> $LOG 2>&1) || echo "[GPU2] A_half a=0.6 V0=0.01 kz=4 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a0.600_*_v0.0100_*_tierprobe_A_half" >> ../logs/inline_extract.log 2>&1)
echo "[GPU2] A_half a=0.6 V0=0.01 kz=4 done $(date)" >> $LOG

cat > /tmp/tp_abi2_Bhalf_2x_a0.9_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 256
run_tag = tierprobe_Bhalf_2x
EOINI
echo "[GPU2] Bhalf_2x a=0.9 V0=0.03 kz=0.5 nz=256 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tp_abi2_Bhalf_2x_a0.9_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[GPU2] Bhalf_2x a=0.9 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.900_*_v0.0300_*_tierprobe_Bhalf_2x" >> ../logs/inline_extract.log 2>&1)
echo "[GPU2] Bhalf_2x a=0.9 V0=0.03 kz=0.5 done $(date)" >> $LOG

    echo "[GPU2] ALL DONE $(date)" >> $LOG
}

echo "=== abi tierprobe launch $(date) ==="
run_gpu0 & PID0=$!
run_gpu1 & PID1=$!
run_gpu2 & PID2=$!
wait $PID0 && echo 'GPU0 finished' || echo 'GPU0 FAILED'
wait $PID1 && echo 'GPU1 finished' || echo 'GPU1 FAILED'
wait $PID2 && echo 'GPU2 finished' || echo 'GPU2 FAILED'
