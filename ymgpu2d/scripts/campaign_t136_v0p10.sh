#!/bin/bash
# Sequential single-GPU campaign for t136: V0=0.1
# 203 runs
# Launch: nohup bash scripts/campaign_t136_v0p10.sh > logs/campaign_t136_v0p10.log 2>&1 &

set -e
mkdir -p logs
echo "=== start $(date) ==="

cat > /tmp/a0.1_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.1
V0 = 0.1
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
echo "a=0.1 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.1_v0.1_k1.ini
echo "a=0.1 V0=0.1 kz=1 done $(date)"

cat > /tmp/a0.1_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.1
V0 = 0.1
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
echo "a=0.1 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.1_v0.1_k2.ini
echo "a=0.1 V0=0.1 kz=2 done $(date)"

cat > /tmp/a0.1_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.1
V0 = 0.1
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
echo "a=0.1 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.1_v0.1_k3.ini
echo "a=0.1 V0=0.1 kz=3 done $(date)"

cat > /tmp/a0.1_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.1
V0 = 0.1
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
echo "a=0.1 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.1_v0.1_k4.ini
echo "a=0.1 V0=0.1 kz=4 done $(date)"

cat > /tmp/a0.1_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.1
V0 = 0.1
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
echo "a=0.1 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.1_v0.1_k5.ini
echo "a=0.1 V0=0.1 kz=5 done $(date)"

cat > /tmp/a0.1_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.1
V0 = 0.1
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
echo "a=0.1 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.1_v0.1_k6.ini
echo "a=0.1 V0=0.1 kz=6 done $(date)"

cat > /tmp/a0.1_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.1
V0 = 0.1
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
echo "a=0.1 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.1_v0.1_k7.ini
echo "a=0.1 V0=0.1 kz=7 done $(date)"

cat > /tmp/a0.1_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.1
V0 = 0.1
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
echo "a=0.1 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.1_v0.1_k8.ini
echo "a=0.1 V0=0.1 kz=8 done $(date)"

cat > /tmp/a0.2_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.2
V0 = 0.1
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
echo "a=0.2 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.2_v0.1_k1.ini
echo "a=0.2 V0=0.1 kz=1 done $(date)"

cat > /tmp/a0.2_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.2
V0 = 0.1
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
echo "a=0.2 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.2_v0.1_k2.ini
echo "a=0.2 V0=0.1 kz=2 done $(date)"

cat > /tmp/a0.2_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.2
V0 = 0.1
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
echo "a=0.2 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.2_v0.1_k3.ini
echo "a=0.2 V0=0.1 kz=3 done $(date)"

cat > /tmp/a0.2_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.2
V0 = 0.1
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
echo "a=0.2 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.2_v0.1_k4.ini
echo "a=0.2 V0=0.1 kz=4 done $(date)"

cat > /tmp/a0.2_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.2
V0 = 0.1
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
echo "a=0.2 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.2_v0.1_k5.ini
echo "a=0.2 V0=0.1 kz=5 done $(date)"

cat > /tmp/a0.2_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.2
V0 = 0.1
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
echo "a=0.2 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.2_v0.1_k6.ini
echo "a=0.2 V0=0.1 kz=6 done $(date)"

cat > /tmp/a0.2_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.2
V0 = 0.1
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
echo "a=0.2 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.2_v0.1_k7.ini
echo "a=0.2 V0=0.1 kz=7 done $(date)"

cat > /tmp/a0.2_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.2
V0 = 0.1
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
echo "a=0.2 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.2_v0.1_k8.ini
echo "a=0.2 V0=0.1 kz=8 done $(date)"

cat > /tmp/a0.3_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.3 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.3_v0.1_k1.ini
echo "a=0.3 V0=0.1 kz=1 done $(date)"

cat > /tmp/a0.3_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.3 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.3_v0.1_k2.ini
echo "a=0.3 V0=0.1 kz=2 done $(date)"

cat > /tmp/a0.3_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.3 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.3_v0.1_k3.ini
echo "a=0.3 V0=0.1 kz=3 done $(date)"

cat > /tmp/a0.3_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.3 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.3_v0.1_k4.ini
echo "a=0.3 V0=0.1 kz=4 done $(date)"

cat > /tmp/a0.3_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.3 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.3_v0.1_k5.ini
echo "a=0.3 V0=0.1 kz=5 done $(date)"

cat > /tmp/a0.3_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.3 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.3_v0.1_k6.ini
echo "a=0.3 V0=0.1 kz=6 done $(date)"

cat > /tmp/a0.3_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.3 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.3_v0.1_k7.ini
echo "a=0.3 V0=0.1 kz=7 done $(date)"

cat > /tmp/a0.3_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.3 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.3_v0.1_k8.ini
echo "a=0.3 V0=0.1 kz=8 done $(date)"

cat > /tmp/a0.4_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.4
V0 = 0.1
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
echo "a=0.4 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.4_v0.1_k1.ini
echo "a=0.4 V0=0.1 kz=1 done $(date)"

cat > /tmp/a0.4_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.4
V0 = 0.1
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
echo "a=0.4 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.4_v0.1_k2.ini
echo "a=0.4 V0=0.1 kz=2 done $(date)"

cat > /tmp/a0.4_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.4
V0 = 0.1
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
echo "a=0.4 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.4_v0.1_k3.ini
echo "a=0.4 V0=0.1 kz=3 done $(date)"

cat > /tmp/a0.4_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.4
V0 = 0.1
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
echo "a=0.4 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.4_v0.1_k4.ini
echo "a=0.4 V0=0.1 kz=4 done $(date)"

cat > /tmp/a0.4_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.4
V0 = 0.1
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
echo "a=0.4 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.4_v0.1_k5.ini
echo "a=0.4 V0=0.1 kz=5 done $(date)"

cat > /tmp/a0.4_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.4
V0 = 0.1
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
echo "a=0.4 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.4_v0.1_k6.ini
echo "a=0.4 V0=0.1 kz=6 done $(date)"

cat > /tmp/a0.4_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.4
V0 = 0.1
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
echo "a=0.4 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.4_v0.1_k7.ini
echo "a=0.4 V0=0.1 kz=7 done $(date)"

cat > /tmp/a0.4_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.4
V0 = 0.1
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
echo "a=0.4 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.4_v0.1_k8.ini
echo "a=0.4 V0=0.1 kz=8 done $(date)"

cat > /tmp/a0.5_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.5 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.5_v0.1_k7.ini
echo "a=0.5 V0=0.1 kz=7 done $(date)"

cat > /tmp/a0.5_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.5 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.5_v0.1_k8.ini
echo "a=0.5 V0=0.1 kz=8 done $(date)"

cat > /tmp/a0.6_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.6
V0 = 0.1
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
echo "a=0.6 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.6_v0.1_k1.ini
echo "a=0.6 V0=0.1 kz=1 done $(date)"

cat > /tmp/a0.6_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.6
V0 = 0.1
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
echo "a=0.6 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.6_v0.1_k2.ini
echo "a=0.6 V0=0.1 kz=2 done $(date)"

cat > /tmp/a0.6_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.6
V0 = 0.1
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
echo "a=0.6 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.6_v0.1_k3.ini
echo "a=0.6 V0=0.1 kz=3 done $(date)"

cat > /tmp/a0.6_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.6
V0 = 0.1
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
echo "a=0.6 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.6_v0.1_k4.ini
echo "a=0.6 V0=0.1 kz=4 done $(date)"

cat > /tmp/a0.6_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.6
V0 = 0.1
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
echo "a=0.6 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.6_v0.1_k5.ini
echo "a=0.6 V0=0.1 kz=5 done $(date)"

cat > /tmp/a0.6_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.6
V0 = 0.1
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
echo "a=0.6 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.6_v0.1_k6.ini
echo "a=0.6 V0=0.1 kz=6 done $(date)"

cat > /tmp/a0.6_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.6
V0 = 0.1
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
echo "a=0.6 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.6_v0.1_k7.ini
echo "a=0.6 V0=0.1 kz=7 done $(date)"

cat > /tmp/a0.6_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.6
V0 = 0.1
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
echo "a=0.6 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.6_v0.1_k8.ini
echo "a=0.6 V0=0.1 kz=8 done $(date)"

cat > /tmp/a0.7_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.7 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.7_v0.1_k1.ini
echo "a=0.7 V0=0.1 kz=1 done $(date)"

cat > /tmp/a0.7_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.7 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.7_v0.1_k2.ini
echo "a=0.7 V0=0.1 kz=2 done $(date)"

cat > /tmp/a0.7_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.7 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.7_v0.1_k3.ini
echo "a=0.7 V0=0.1 kz=3 done $(date)"

cat > /tmp/a0.7_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.7 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.7_v0.1_k4.ini
echo "a=0.7 V0=0.1 kz=4 done $(date)"

cat > /tmp/a0.7_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.7 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.7_v0.1_k5.ini
echo "a=0.7 V0=0.1 kz=5 done $(date)"

cat > /tmp/a0.7_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.7 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.7_v0.1_k6.ini
echo "a=0.7 V0=0.1 kz=6 done $(date)"

cat > /tmp/a0.7_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.7 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.7_v0.1_k7.ini
echo "a=0.7 V0=0.1 kz=7 done $(date)"

cat > /tmp/a0.7_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.7 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.7_v0.1_k8.ini
echo "a=0.7 V0=0.1 kz=8 done $(date)"

cat > /tmp/a0.8_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.1
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
echo "a=0.8 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.8_v0.1_k1.ini
echo "a=0.8 V0=0.1 kz=1 done $(date)"

cat > /tmp/a0.8_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.8
V0 = 0.1
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
echo "a=0.8 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.8_v0.1_k2.ini
echo "a=0.8 V0=0.1 kz=2 done $(date)"

cat > /tmp/a0.8_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.8
V0 = 0.1
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
echo "a=0.8 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.8_v0.1_k3.ini
echo "a=0.8 V0=0.1 kz=3 done $(date)"

cat > /tmp/a0.8_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.8
V0 = 0.1
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
echo "a=0.8 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.8_v0.1_k4.ini
echo "a=0.8 V0=0.1 kz=4 done $(date)"

cat > /tmp/a0.8_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.8
V0 = 0.1
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
echo "a=0.8 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.8_v0.1_k5.ini
echo "a=0.8 V0=0.1 kz=5 done $(date)"

cat > /tmp/a0.8_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.8
V0 = 0.1
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
echo "a=0.8 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.8_v0.1_k6.ini
echo "a=0.8 V0=0.1 kz=6 done $(date)"

cat > /tmp/a0.8_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.8
V0 = 0.1
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
echo "a=0.8 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.8_v0.1_k7.ini
echo "a=0.8 V0=0.1 kz=7 done $(date)"

cat > /tmp/a0.8_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.8
V0 = 0.1
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
echo "a=0.8 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.8_v0.1_k8.ini
echo "a=0.8 V0=0.1 kz=8 done $(date)"

cat > /tmp/a0.9_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.9 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.9_v0.1_k1.ini
echo "a=0.9 V0=0.1 kz=1 done $(date)"

cat > /tmp/a0.9_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.9 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.9_v0.1_k2.ini
echo "a=0.9 V0=0.1 kz=2 done $(date)"

cat > /tmp/a0.9_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.9 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.9_v0.1_k3.ini
echo "a=0.9 V0=0.1 kz=3 done $(date)"

cat > /tmp/a0.9_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.9 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.9_v0.1_k4.ini
echo "a=0.9 V0=0.1 kz=4 done $(date)"

cat > /tmp/a0.9_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.9 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.9_v0.1_k5.ini
echo "a=0.9 V0=0.1 kz=5 done $(date)"

cat > /tmp/a0.9_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.9 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.9_v0.1_k6.ini
echo "a=0.9 V0=0.1 kz=6 done $(date)"

cat > /tmp/a0.9_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.9 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.9_v0.1_k7.ini
echo "a=0.9 V0=0.1 kz=7 done $(date)"

cat > /tmp/a0.9_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=0.9 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a0.9_v0.1_k8.ini
echo "a=0.9 V0=0.1 kz=8 done $(date)"

cat > /tmp/a1.0_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.0 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.0_v0.1_k7.ini
echo "a=1.0 V0=0.1 kz=7 done $(date)"

cat > /tmp/a1.0_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.0 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.0_v0.1_k8.ini
echo "a=1.0 V0=0.1 kz=8 done $(date)"

cat > /tmp/a1.1_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.1 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.1_v0.1_k1.ini
echo "a=1.1 V0=0.1 kz=1 done $(date)"

cat > /tmp/a1.1_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.1 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.1_v0.1_k2.ini
echo "a=1.1 V0=0.1 kz=2 done $(date)"

cat > /tmp/a1.1_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.1 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.1_v0.1_k3.ini
echo "a=1.1 V0=0.1 kz=3 done $(date)"

cat > /tmp/a1.1_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.1 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.1_v0.1_k4.ini
echo "a=1.1 V0=0.1 kz=4 done $(date)"

cat > /tmp/a1.1_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.1 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.1_v0.1_k5.ini
echo "a=1.1 V0=0.1 kz=5 done $(date)"

cat > /tmp/a1.1_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.1 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.1_v0.1_k6.ini
echo "a=1.1 V0=0.1 kz=6 done $(date)"

cat > /tmp/a1.1_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.1 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.1_v0.1_k7.ini
echo "a=1.1 V0=0.1 kz=7 done $(date)"

cat > /tmp/a1.1_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.1 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.1_v0.1_k8.ini
echo "a=1.1 V0=0.1 kz=8 done $(date)"

cat > /tmp/a1.2_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.2
V0 = 0.1
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
echo "a=1.2 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.2_v0.1_k1.ini
echo "a=1.2 V0=0.1 kz=1 done $(date)"

cat > /tmp/a1.2_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.2
V0 = 0.1
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
echo "a=1.2 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.2_v0.1_k2.ini
echo "a=1.2 V0=0.1 kz=2 done $(date)"

cat > /tmp/a1.2_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.2
V0 = 0.1
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
echo "a=1.2 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.2_v0.1_k3.ini
echo "a=1.2 V0=0.1 kz=3 done $(date)"

cat > /tmp/a1.2_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.2
V0 = 0.1
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
echo "a=1.2 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.2_v0.1_k4.ini
echo "a=1.2 V0=0.1 kz=4 done $(date)"

cat > /tmp/a1.2_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.2
V0 = 0.1
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
echo "a=1.2 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.2_v0.1_k5.ini
echo "a=1.2 V0=0.1 kz=5 done $(date)"

cat > /tmp/a1.2_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.2
V0 = 0.1
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
echo "a=1.2 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.2_v0.1_k6.ini
echo "a=1.2 V0=0.1 kz=6 done $(date)"

cat > /tmp/a1.2_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.2
V0 = 0.1
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
echo "a=1.2 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.2_v0.1_k7.ini
echo "a=1.2 V0=0.1 kz=7 done $(date)"

cat > /tmp/a1.2_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.2
V0 = 0.1
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
echo "a=1.2 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.2_v0.1_k8.ini
echo "a=1.2 V0=0.1 kz=8 done $(date)"

cat > /tmp/a1.3_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.3 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.3_v0.1_k1.ini
echo "a=1.3 V0=0.1 kz=1 done $(date)"

cat > /tmp/a1.3_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.3 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.3_v0.1_k2.ini
echo "a=1.3 V0=0.1 kz=2 done $(date)"

cat > /tmp/a1.3_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.3 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.3_v0.1_k3.ini
echo "a=1.3 V0=0.1 kz=3 done $(date)"

cat > /tmp/a1.3_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.3 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.3_v0.1_k4.ini
echo "a=1.3 V0=0.1 kz=4 done $(date)"

cat > /tmp/a1.3_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.3 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.3_v0.1_k5.ini
echo "a=1.3 V0=0.1 kz=5 done $(date)"

cat > /tmp/a1.3_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.3 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.3_v0.1_k6.ini
echo "a=1.3 V0=0.1 kz=6 done $(date)"

cat > /tmp/a1.3_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.3 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.3_v0.1_k7.ini
echo "a=1.3 V0=0.1 kz=7 done $(date)"

cat > /tmp/a1.3_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.3 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.3_v0.1_k8.ini
echo "a=1.3 V0=0.1 kz=8 done $(date)"

cat > /tmp/a1.4_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.4 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.4_v0.1_k1.ini
echo "a=1.4 V0=0.1 kz=1 done $(date)"

cat > /tmp/a1.4_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.4 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.4_v0.1_k2.ini
echo "a=1.4 V0=0.1 kz=2 done $(date)"

cat > /tmp/a1.4_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.4 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.4_v0.1_k3.ini
echo "a=1.4 V0=0.1 kz=3 done $(date)"

cat > /tmp/a1.4_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.4 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.4_v0.1_k4.ini
echo "a=1.4 V0=0.1 kz=4 done $(date)"

cat > /tmp/a1.4_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.4 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.4_v0.1_k5.ini
echo "a=1.4 V0=0.1 kz=5 done $(date)"

cat > /tmp/a1.4_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.4 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.4_v0.1_k6.ini
echo "a=1.4 V0=0.1 kz=6 done $(date)"

cat > /tmp/a1.4_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.4 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.4_v0.1_k7.ini
echo "a=1.4 V0=0.1 kz=7 done $(date)"

cat > /tmp/a1.4_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.4 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.4_v0.1_k8.ini
echo "a=1.4 V0=0.1 kz=8 done $(date)"

cat > /tmp/a1.5_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.5 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.5_v0.1_k7.ini
echo "a=1.5 V0=0.1 kz=7 done $(date)"

cat > /tmp/a1.5_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.5 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.5_v0.1_k8.ini
echo "a=1.5 V0=0.1 kz=8 done $(date)"

cat > /tmp/a1.6_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.6 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.6_v0.1_k1.ini
echo "a=1.6 V0=0.1 kz=1 done $(date)"

cat > /tmp/a1.6_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.6 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.6_v0.1_k2.ini
echo "a=1.6 V0=0.1 kz=2 done $(date)"

cat > /tmp/a1.6_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.6 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.6_v0.1_k3.ini
echo "a=1.6 V0=0.1 kz=3 done $(date)"

cat > /tmp/a1.6_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.6 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.6_v0.1_k4.ini
echo "a=1.6 V0=0.1 kz=4 done $(date)"

cat > /tmp/a1.6_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.6 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.6_v0.1_k5.ini
echo "a=1.6 V0=0.1 kz=5 done $(date)"

cat > /tmp/a1.6_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.6 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.6_v0.1_k6.ini
echo "a=1.6 V0=0.1 kz=6 done $(date)"

cat > /tmp/a1.6_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.6 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.6_v0.1_k7.ini
echo "a=1.6 V0=0.1 kz=7 done $(date)"

cat > /tmp/a1.6_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.6 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.6_v0.1_k8.ini
echo "a=1.6 V0=0.1 kz=8 done $(date)"

cat > /tmp/a1.7_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.7 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.7_v0.1_k1.ini
echo "a=1.7 V0=0.1 kz=1 done $(date)"

cat > /tmp/a1.7_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.7 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.7_v0.1_k2.ini
echo "a=1.7 V0=0.1 kz=2 done $(date)"

cat > /tmp/a1.7_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.7 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.7_v0.1_k3.ini
echo "a=1.7 V0=0.1 kz=3 done $(date)"

cat > /tmp/a1.7_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.7 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.7_v0.1_k4.ini
echo "a=1.7 V0=0.1 kz=4 done $(date)"

cat > /tmp/a1.7_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.7 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.7_v0.1_k5.ini
echo "a=1.7 V0=0.1 kz=5 done $(date)"

cat > /tmp/a1.7_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.7 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.7_v0.1_k6.ini
echo "a=1.7 V0=0.1 kz=6 done $(date)"

cat > /tmp/a1.7_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.7 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.7_v0.1_k7.ini
echo "a=1.7 V0=0.1 kz=7 done $(date)"

cat > /tmp/a1.7_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.7 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.7_v0.1_k8.ini
echo "a=1.7 V0=0.1 kz=8 done $(date)"

cat > /tmp/a1.8_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.8 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.8_v0.1_k1.ini
echo "a=1.8 V0=0.1 kz=1 done $(date)"

cat > /tmp/a1.8_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.8 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.8_v0.1_k2.ini
echo "a=1.8 V0=0.1 kz=2 done $(date)"

cat > /tmp/a1.8_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.8 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.8_v0.1_k3.ini
echo "a=1.8 V0=0.1 kz=3 done $(date)"

cat > /tmp/a1.8_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.8 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.8_v0.1_k4.ini
echo "a=1.8 V0=0.1 kz=4 done $(date)"

cat > /tmp/a1.8_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.8 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.8_v0.1_k5.ini
echo "a=1.8 V0=0.1 kz=5 done $(date)"

cat > /tmp/a1.8_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.8 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.8_v0.1_k6.ini
echo "a=1.8 V0=0.1 kz=6 done $(date)"

cat > /tmp/a1.8_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.8 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.8_v0.1_k7.ini
echo "a=1.8 V0=0.1 kz=7 done $(date)"

cat > /tmp/a1.8_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.8 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.8_v0.1_k8.ini
echo "a=1.8 V0=0.1 kz=8 done $(date)"

cat > /tmp/a1.9_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.9 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.9_v0.1_k1.ini
echo "a=1.9 V0=0.1 kz=1 done $(date)"

cat > /tmp/a1.9_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.9 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.9_v0.1_k2.ini
echo "a=1.9 V0=0.1 kz=2 done $(date)"

cat > /tmp/a1.9_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.9 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.9_v0.1_k3.ini
echo "a=1.9 V0=0.1 kz=3 done $(date)"

cat > /tmp/a1.9_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.9 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.9_v0.1_k4.ini
echo "a=1.9 V0=0.1 kz=4 done $(date)"

cat > /tmp/a1.9_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.9 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.9_v0.1_k5.ini
echo "a=1.9 V0=0.1 kz=5 done $(date)"

cat > /tmp/a1.9_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.9 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.9_v0.1_k6.ini
echo "a=1.9 V0=0.1 kz=6 done $(date)"

cat > /tmp/a1.9_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.9 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.9_v0.1_k7.ini
echo "a=1.9 V0=0.1 kz=7 done $(date)"

cat > /tmp/a1.9_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=1.9 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a1.9_v0.1_k8.ini
echo "a=1.9 V0=0.1 kz=8 done $(date)"

cat > /tmp/a2.0_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.0 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.0_v0.1_k7.ini
echo "a=2.0 V0=0.1 kz=7 done $(date)"

cat > /tmp/a2.0_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.0 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.0_v0.1_k8.ini
echo "a=2.0 V0=0.1 kz=8 done $(date)"

cat > /tmp/a2.1_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.1 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.1_v0.1_k1.ini
echo "a=2.1 V0=0.1 kz=1 done $(date)"

cat > /tmp/a2.1_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.1 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.1_v0.1_k2.ini
echo "a=2.1 V0=0.1 kz=2 done $(date)"

cat > /tmp/a2.1_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.1 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.1_v0.1_k3.ini
echo "a=2.1 V0=0.1 kz=3 done $(date)"

cat > /tmp/a2.1_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.1 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.1_v0.1_k4.ini
echo "a=2.1 V0=0.1 kz=4 done $(date)"

cat > /tmp/a2.1_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.1 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.1_v0.1_k5.ini
echo "a=2.1 V0=0.1 kz=5 done $(date)"

cat > /tmp/a2.1_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.1 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.1_v0.1_k6.ini
echo "a=2.1 V0=0.1 kz=6 done $(date)"

cat > /tmp/a2.1_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.1 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.1_v0.1_k7.ini
echo "a=2.1 V0=0.1 kz=7 done $(date)"

cat > /tmp/a2.1_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.1 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.1_v0.1_k8.ini
echo "a=2.1 V0=0.1 kz=8 done $(date)"

cat > /tmp/a2.2_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.2 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.2_v0.1_k1.ini
echo "a=2.2 V0=0.1 kz=1 done $(date)"

cat > /tmp/a2.2_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.2 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.2_v0.1_k2.ini
echo "a=2.2 V0=0.1 kz=2 done $(date)"

cat > /tmp/a2.2_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.2 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.2_v0.1_k3.ini
echo "a=2.2 V0=0.1 kz=3 done $(date)"

cat > /tmp/a2.2_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.2 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.2_v0.1_k4.ini
echo "a=2.2 V0=0.1 kz=4 done $(date)"

cat > /tmp/a2.2_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.2 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.2_v0.1_k5.ini
echo "a=2.2 V0=0.1 kz=5 done $(date)"

cat > /tmp/a2.2_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.2 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.2_v0.1_k6.ini
echo "a=2.2 V0=0.1 kz=6 done $(date)"

cat > /tmp/a2.2_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.2 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.2_v0.1_k7.ini
echo "a=2.2 V0=0.1 kz=7 done $(date)"

cat > /tmp/a2.2_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.2 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.2_v0.1_k8.ini
echo "a=2.2 V0=0.1 kz=8 done $(date)"

cat > /tmp/a2.3_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.3 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.3_v0.1_k1.ini
echo "a=2.3 V0=0.1 kz=1 done $(date)"

cat > /tmp/a2.3_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.3 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.3_v0.1_k2.ini
echo "a=2.3 V0=0.1 kz=2 done $(date)"

cat > /tmp/a2.3_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.3 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.3_v0.1_k3.ini
echo "a=2.3 V0=0.1 kz=3 done $(date)"

cat > /tmp/a2.3_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.3 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.3_v0.1_k4.ini
echo "a=2.3 V0=0.1 kz=4 done $(date)"

cat > /tmp/a2.3_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.3 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.3_v0.1_k5.ini
echo "a=2.3 V0=0.1 kz=5 done $(date)"

cat > /tmp/a2.3_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.3 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.3_v0.1_k6.ini
echo "a=2.3 V0=0.1 kz=6 done $(date)"

cat > /tmp/a2.3_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.3 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.3_v0.1_k7.ini
echo "a=2.3 V0=0.1 kz=7 done $(date)"

cat > /tmp/a2.3_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.3 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.3_v0.1_k8.ini
echo "a=2.3 V0=0.1 kz=8 done $(date)"

cat > /tmp/a2.4_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.4 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.4_v0.1_k1.ini
echo "a=2.4 V0=0.1 kz=1 done $(date)"

cat > /tmp/a2.4_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.4 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.4_v0.1_k2.ini
echo "a=2.4 V0=0.1 kz=2 done $(date)"

cat > /tmp/a2.4_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.4 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.4_v0.1_k3.ini
echo "a=2.4 V0=0.1 kz=3 done $(date)"

cat > /tmp/a2.4_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.4 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.4_v0.1_k4.ini
echo "a=2.4 V0=0.1 kz=4 done $(date)"

cat > /tmp/a2.4_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.4 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.4_v0.1_k5.ini
echo "a=2.4 V0=0.1 kz=5 done $(date)"

cat > /tmp/a2.4_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.4 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.4_v0.1_k6.ini
echo "a=2.4 V0=0.1 kz=6 done $(date)"

cat > /tmp/a2.4_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.4 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.4_v0.1_k7.ini
echo "a=2.4 V0=0.1 kz=7 done $(date)"

cat > /tmp/a2.4_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.4 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.4_v0.1_k8.ini
echo "a=2.4 V0=0.1 kz=8 done $(date)"

cat > /tmp/a2.5_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.5 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.5_v0.1_k8.ini
echo "a=2.5 V0=0.1 kz=8 done $(date)"

cat > /tmp/a2.6_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.6 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.6_v0.1_k1.ini
echo "a=2.6 V0=0.1 kz=1 done $(date)"

cat > /tmp/a2.6_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.6 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.6_v0.1_k2.ini
echo "a=2.6 V0=0.1 kz=2 done $(date)"

cat > /tmp/a2.6_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.6 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.6_v0.1_k3.ini
echo "a=2.6 V0=0.1 kz=3 done $(date)"

cat > /tmp/a2.6_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.6 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.6_v0.1_k4.ini
echo "a=2.6 V0=0.1 kz=4 done $(date)"

cat > /tmp/a2.6_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.6 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.6_v0.1_k5.ini
echo "a=2.6 V0=0.1 kz=5 done $(date)"

cat > /tmp/a2.6_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.6 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.6_v0.1_k6.ini
echo "a=2.6 V0=0.1 kz=6 done $(date)"

cat > /tmp/a2.6_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.6 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.6_v0.1_k7.ini
echo "a=2.6 V0=0.1 kz=7 done $(date)"

cat > /tmp/a2.6_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.6 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.6_v0.1_k8.ini
echo "a=2.6 V0=0.1 kz=8 done $(date)"

cat > /tmp/a2.7_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.7 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.7_v0.1_k1.ini
echo "a=2.7 V0=0.1 kz=1 done $(date)"

cat > /tmp/a2.7_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.7 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.7_v0.1_k2.ini
echo "a=2.7 V0=0.1 kz=2 done $(date)"

cat > /tmp/a2.7_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.7 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.7_v0.1_k3.ini
echo "a=2.7 V0=0.1 kz=3 done $(date)"

cat > /tmp/a2.7_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.7 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.7_v0.1_k4.ini
echo "a=2.7 V0=0.1 kz=4 done $(date)"

cat > /tmp/a2.7_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.7 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.7_v0.1_k5.ini
echo "a=2.7 V0=0.1 kz=5 done $(date)"

cat > /tmp/a2.7_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.7 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.7_v0.1_k6.ini
echo "a=2.7 V0=0.1 kz=6 done $(date)"

cat > /tmp/a2.7_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.7 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.7_v0.1_k7.ini
echo "a=2.7 V0=0.1 kz=7 done $(date)"

cat > /tmp/a2.7_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.7 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.7_v0.1_k8.ini
echo "a=2.7 V0=0.1 kz=8 done $(date)"

cat > /tmp/a2.8_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.8 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.8_v0.1_k1.ini
echo "a=2.8 V0=0.1 kz=1 done $(date)"

cat > /tmp/a2.8_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.8 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.8_v0.1_k2.ini
echo "a=2.8 V0=0.1 kz=2 done $(date)"

cat > /tmp/a2.8_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.8 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.8_v0.1_k3.ini
echo "a=2.8 V0=0.1 kz=3 done $(date)"

cat > /tmp/a2.8_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.8 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.8_v0.1_k4.ini
echo "a=2.8 V0=0.1 kz=4 done $(date)"

cat > /tmp/a2.8_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.8 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.8_v0.1_k5.ini
echo "a=2.8 V0=0.1 kz=5 done $(date)"

cat > /tmp/a2.8_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.8 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.8_v0.1_k6.ini
echo "a=2.8 V0=0.1 kz=6 done $(date)"

cat > /tmp/a2.8_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.8 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.8_v0.1_k7.ini
echo "a=2.8 V0=0.1 kz=7 done $(date)"

cat > /tmp/a2.8_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.8 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.8_v0.1_k8.ini
echo "a=2.8 V0=0.1 kz=8 done $(date)"

cat > /tmp/a2.9_v0.1_k1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.9 V0=0.1 kz=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.9_v0.1_k1.ini
echo "a=2.9 V0=0.1 kz=1 done $(date)"

cat > /tmp/a2.9_v0.1_k2.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.9 V0=0.1 kz=2 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.9_v0.1_k2.ini
echo "a=2.9 V0=0.1 kz=2 done $(date)"

cat > /tmp/a2.9_v0.1_k3.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.9 V0=0.1 kz=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.9_v0.1_k3.ini
echo "a=2.9 V0=0.1 kz=3 done $(date)"

cat > /tmp/a2.9_v0.1_k4.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.9 V0=0.1 kz=4 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.9_v0.1_k4.ini
echo "a=2.9 V0=0.1 kz=4 done $(date)"

cat > /tmp/a2.9_v0.1_k5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.9 V0=0.1 kz=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.9_v0.1_k5.ini
echo "a=2.9 V0=0.1 kz=5 done $(date)"

cat > /tmp/a2.9_v0.1_k6.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.9 V0=0.1 kz=6 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.9_v0.1_k6.ini
echo "a=2.9 V0=0.1 kz=6 done $(date)"

cat > /tmp/a2.9_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.9 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.9_v0.1_k7.ini
echo "a=2.9 V0=0.1 kz=7 done $(date)"

cat > /tmp/a2.9_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=2.9 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a2.9_v0.1_k8.ini
echo "a=2.9 V0=0.1 kz=8 done $(date)"

cat > /tmp/a3.0_v0.1_k7.ini <<'EOINI'
k_mode = 7
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=3.0 V0=0.1 kz=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a3.0_v0.1_k7.ini
echo "a=3.0 V0=0.1 kz=7 done $(date)"

cat > /tmp/a3.0_v0.1_k8.ini <<'EOINI'
k_mode = 8
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100
EOINI
echo "a=3.0 V0=0.1 kz=8 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d && ./ym_coupled /tmp/a3.0_v0.1_k8.ini
echo "a=3.0 V0=0.1 kz=8 done $(date)"

echo "=== ALL DONE $(date) ==="
