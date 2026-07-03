#!/bin/bash
# Single-GPU campaign for t126: V0=0.2
# Run: nohup bash scripts/campaign_t126_vv0p2.sh > logs/campaign_t126_vv0p2.log 2>&1 &
set -e
mkdir -p logs
TAG="t126_vv0p2"
WDIR="/DATA/cm/lcpfct/ymgpu2d"
LOG="logs/campaign_${TAG}.log"
echo "=== Start $(date) ===" >> $LOG

# alpha=0.1
cat > /tmp/t126_a0.1_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.1 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.1_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=0.1 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a0.1_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.1 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.1_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=0.1 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a0.1_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.1 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.1_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=0.1 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a0.1_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.1 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.1_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=0.1 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a0.1_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.1 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.1_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=0.1 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a0.1_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.1 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.1_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=0.1 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a0.1_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.1 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.1_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=0.1 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a0.1_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.1 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.1_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=0.1 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=0.2
cat > /tmp/t126_a0.2_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.2 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.2_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=0.2 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a0.2_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.2 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.2_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=0.2 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a0.2_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.2 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.2_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=0.2 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a0.2_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.2 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.2_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=0.2 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a0.2_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.2 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.2_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=0.2 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a0.2_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.2 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.2_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=0.2 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a0.2_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.2 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.2_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=0.2 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a0.2_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.2 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.2_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=0.2 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=0.3
cat > /tmp/t126_a0.3_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.3 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.3_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=0.3 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a0.3_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.3 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.3_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=0.3 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a0.3_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.3 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.3_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=0.3 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a0.3_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.3 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.3_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=0.3 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a0.3_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.3 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.3_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=0.3 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a0.3_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.3 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.3_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=0.3 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a0.3_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.3 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.3_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=0.3 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a0.3_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.3 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.3_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=0.3 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=0.4
cat > /tmp/t126_a0.4_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.4 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.4_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=0.4 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a0.4_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.4 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.4_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=0.4 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a0.4_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.4 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.4_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=0.4 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a0.4_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.4 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.4_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=0.4 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a0.4_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.4 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.4_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=0.4 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a0.4_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.4 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.4_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=0.4 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a0.4_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.4 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.4_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=0.4 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a0.4_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.4 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.4_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=0.4 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=0.5
cat > /tmp/t126_a0.5_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.5 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.5_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=0.5 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a0.5_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.5 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.5_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=0.5 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a0.5_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.5 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.5_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=0.5 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a0.5_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.5 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.5_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=0.5 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=0.6
cat > /tmp/t126_a0.6_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.6 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.6_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=0.6 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a0.6_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.6 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.6_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=0.6 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a0.6_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.6 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.6_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=0.6 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a0.6_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.6 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.6_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=0.6 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a0.6_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.6 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.6_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=0.6 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a0.6_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.6 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.6_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=0.6 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a0.6_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.6 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.6_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=0.6 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a0.6_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.6 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.6_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=0.6 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=0.7
cat > /tmp/t126_a0.7_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.7 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.7_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=0.7 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a0.7_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.7 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.7_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=0.7 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a0.7_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.7 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.7_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=0.7 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a0.7_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.7 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.7_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=0.7 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a0.7_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.7 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.7_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=0.7 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a0.7_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.7 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.7_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=0.7 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a0.7_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.7 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.7_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=0.7 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a0.7_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.7 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.7_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=0.7 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=0.8
cat > /tmp/t126_a0.8_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.8 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.8_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=0.8 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a0.8_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.8 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.8_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=0.8 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a0.8_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.8 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.8_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=0.8 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a0.8_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.8 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.8_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=0.8 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a0.8_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.8 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.8_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=0.8 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a0.8_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.8 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.8_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=0.8 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a0.8_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.8 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.8_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=0.8 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a0.8_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.8 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.8_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=0.8 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=0.9
cat > /tmp/t126_a0.9_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.9 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.9_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=0.9 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a0.9_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.9 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.9_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=0.9 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a0.9_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.9 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.9_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=0.9 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a0.9_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.9 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.9_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=0.9 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a0.9_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.9 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.9_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=0.9 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a0.9_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.9 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.9_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=0.9 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a0.9_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.9 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.9_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=0.9 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a0.9_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=0.9 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a0.9_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=0.9 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=1.0
cat > /tmp/t126_a1.0_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.0 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.0_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=1.0 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a1.0_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.0 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.0_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=1.0 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a1.0_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.0 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.0_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=1.0 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a1.0_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.0 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.0_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=1.0 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a1.0_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.0 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.0_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=1.0 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=1.1
cat > /tmp/t126_a1.1_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.1 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.1_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=1.1 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a1.1_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.1 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.1_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=1.1 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a1.1_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.1 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.1_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=1.1 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a1.1_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.1 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.1_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=1.1 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a1.1_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.1 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.1_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=1.1 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a1.1_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.1 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.1_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=1.1 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a1.1_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.1 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.1_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=1.1 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a1.1_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.1 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.1_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=1.1 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=1.2
cat > /tmp/t126_a1.2_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.2 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.2_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=1.2 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a1.2_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.2 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.2_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=1.2 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a1.2_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.2 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.2_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=1.2 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a1.2_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.2 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.2_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=1.2 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a1.2_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.2 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.2_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=1.2 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a1.2_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.2 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.2_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=1.2 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a1.2_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.2 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.2_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=1.2 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a1.2_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.2 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.2_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=1.2 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=1.3
cat > /tmp/t126_a1.3_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 15.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.3 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.3_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=1.3 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a1.3_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 15.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.3 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.3_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=1.3 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a1.3_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 15.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.3 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.3_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=1.3 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a1.3_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 15.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.3 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.3_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=1.3 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a1.3_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 15.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.3 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.3_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=1.3 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a1.3_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 15.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.3 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.3_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=1.3 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a1.3_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 15.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.3 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.3_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=1.3 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a1.3_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 15.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.3 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.3_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=1.3 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=1.4
cat > /tmp/t126_a1.4_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.4 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.4_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=1.4 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a1.4_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.4 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.4_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=1.4 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a1.4_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.4 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.4_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=1.4 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a1.4_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.4 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.4_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=1.4 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a1.4_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.4 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.4_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=1.4 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a1.4_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.4 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.4_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=1.4 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a1.4_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.4 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.4_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=1.4 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a1.4_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.4 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.4_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=1.4 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=1.5
cat > /tmp/t126_a1.5_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.5 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.5_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=1.5 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a1.5_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.5 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.5_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=1.5 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a1.5_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.5 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.5_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=1.5 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=1.6
cat > /tmp/t126_a1.6_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.6 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.6_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=1.6 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a1.6_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.6 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.6_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=1.6 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a1.6_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.6 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.6_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=1.6 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a1.6_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.6 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.6_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=1.6 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a1.6_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.6 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.6_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=1.6 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a1.6_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.6 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.6_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=1.6 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a1.6_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.6 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.6_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=1.6 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a1.6_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.6 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.6_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=1.6 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=1.7
cat > /tmp/t126_a1.7_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.7 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.7_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=1.7 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a1.7_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.7 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.7_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=1.7 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a1.7_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.7 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.7_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=1.7 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a1.7_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.7 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.7_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=1.7 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a1.7_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.7 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.7_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=1.7 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a1.7_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.7 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.7_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=1.7 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a1.7_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.7 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.7_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=1.7 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a1.7_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.7 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.7_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=1.7 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=1.8
cat > /tmp/t126_a1.8_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.8 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.8_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=1.8 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a1.8_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.8 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.8_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=1.8 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a1.8_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.8 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.8_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=1.8 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a1.8_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.8 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.8_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=1.8 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a1.8_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.8 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.8_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=1.8 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a1.8_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.8 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.8_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=1.8 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a1.8_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.8 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.8_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=1.8 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a1.8_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.8 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.8_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=1.8 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=1.9
cat > /tmp/t126_a1.9_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.9 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.9_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=1.9 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a1.9_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.9 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.9_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=1.9 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a1.9_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.9 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.9_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=1.9 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a1.9_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.9 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.9_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=1.9 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a1.9_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.9 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.9_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=1.9 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a1.9_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.9 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.9_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=1.9 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a1.9_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.9 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.9_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=1.9 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a1.9_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=1.9 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a1.9_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=1.9 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=2.0
cat > /tmp/t126_a2.0_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.0 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.0_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=2.0 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a2.0_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.0 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.0_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=2.0 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=2.1
cat > /tmp/t126_a2.1_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.1 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.1_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=2.1 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a2.1_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.1 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.1_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=2.1 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a2.1_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.1 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.1_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=2.1 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a2.1_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.1 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.1_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=2.1 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a2.1_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.1 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.1_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=2.1 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a2.1_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.1 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.1_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=2.1 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a2.1_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.1 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.1_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=2.1 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a2.1_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.1 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.1_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=2.1 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=2.2
cat > /tmp/t126_a2.2_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.2 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.2_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=2.2 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a2.2_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.2 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.2_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=2.2 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a2.2_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.2 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.2_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=2.2 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a2.2_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.2 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.2_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=2.2 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a2.2_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.2 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.2_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=2.2 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a2.2_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.2 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.2_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=2.2 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a2.2_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.2 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.2_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=2.2 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a2.2_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.2 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.2_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=2.2 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=2.3
cat > /tmp/t126_a2.3_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.3 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.3_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=2.3 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a2.3_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.3 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.3_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=2.3 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a2.3_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.3 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.3_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=2.3 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a2.3_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.3 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.3_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=2.3 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a2.3_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.3 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.3_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=2.3 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a2.3_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.3 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.3_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=2.3 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a2.3_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.3 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.3_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=2.3 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a2.3_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.3 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.3_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=2.3 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=2.4
cat > /tmp/t126_a2.4_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.4 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.4_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=2.4 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a2.4_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.4 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.4_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=2.4 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a2.4_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.4 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.4_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=2.4 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a2.4_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.4 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.4_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=2.4 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a2.4_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.4 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.4_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=2.4 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a2.4_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.4 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.4_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=2.4 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a2.4_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.4 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.4_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=2.4 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a2.4_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.4 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.4_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=2.4 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=2.5
cat > /tmp/t126_a2.5_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.5 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.5_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=2.5 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=2.6
cat > /tmp/t126_a2.6_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.6 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.6_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=2.6 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a2.6_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.6 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.6_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=2.6 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a2.6_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.6 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.6_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=2.6 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a2.6_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.6 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.6_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=2.6 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a2.6_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.6 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.6_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=2.6 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a2.6_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.6 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.6_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=2.6 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a2.6_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.6 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.6_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=2.6 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a2.6_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.6 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.6_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=2.6 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=2.7
cat > /tmp/t126_a2.7_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.7 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.7_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=2.7 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a2.7_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.7 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.7_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=2.7 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a2.7_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.7 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.7_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=2.7 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a2.7_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.7 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.7_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=2.7 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a2.7_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.7 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.7_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=2.7 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a2.7_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.7 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.7_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=2.7 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a2.7_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.7 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.7_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=2.7 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a2.7_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.7 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.7_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=2.7 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=2.8
cat > /tmp/t126_a2.8_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.8 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.8_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=2.8 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a2.8_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.8 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.8_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=2.8 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a2.8_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.8 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.8_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=2.8 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a2.8_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.8 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.8_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=2.8 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a2.8_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.8 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.8_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=2.8 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a2.8_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.8 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.8_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=2.8 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a2.8_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.8 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.8_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=2.8 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a2.8_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.8 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.8_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=2.8 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=2.9
cat > /tmp/t126_a2.9_v0.2_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.9 V0=0.2 kz=1 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.9_v0.2_k1.ini >> $LOG 2>&1
echo "[t126] a=2.9 V0=0.2 kz=1 done $(date)" >> $LOG
cat > /tmp/t126_a2.9_v0.2_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.9 V0=0.2 kz=2 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.9_v0.2_k2.ini >> $LOG 2>&1
echo "[t126] a=2.9 V0=0.2 kz=2 done $(date)" >> $LOG
cat > /tmp/t126_a2.9_v0.2_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.9 V0=0.2 kz=3 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.9_v0.2_k3.ini >> $LOG 2>&1
echo "[t126] a=2.9 V0=0.2 kz=3 done $(date)" >> $LOG
cat > /tmp/t126_a2.9_v0.2_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.9 V0=0.2 kz=4 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.9_v0.2_k4.ini >> $LOG 2>&1
echo "[t126] a=2.9 V0=0.2 kz=4 done $(date)" >> $LOG
cat > /tmp/t126_a2.9_v0.2_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.9 V0=0.2 kz=5 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.9_v0.2_k5.ini >> $LOG 2>&1
echo "[t126] a=2.9 V0=0.2 kz=5 done $(date)" >> $LOG
cat > /tmp/t126_a2.9_v0.2_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.9 V0=0.2 kz=6 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.9_v0.2_k6.ini >> $LOG 2>&1
echo "[t126] a=2.9 V0=0.2 kz=6 done $(date)" >> $LOG
cat > /tmp/t126_a2.9_v0.2_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.9 V0=0.2 kz=7 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.9_v0.2_k7.ini >> $LOG 2>&1
echo "[t126] a=2.9 V0=0.2 kz=7 done $(date)" >> $LOG
cat > /tmp/t126_a2.9_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=2.9 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a2.9_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=2.9 V0=0.2 kz=8 done $(date)" >> $LOG

# alpha=3.0
cat > /tmp/t126_a3.0_v0.2_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 3.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "[t126] a=3.0 V0=0.2 kz=8 start $(date)" >> $LOG
cd $WDIR && ./ym_coupled /tmp/t126_a3.0_v0.2_k8.ini >> $LOG 2>&1
echo "[t126] a=3.0 V0=0.2 kz=8 done $(date)" >> $LOG

echo "=== ALL DONE $(date) ===" >> $LOG
