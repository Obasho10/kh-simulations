#!/bin/bash
# V0=0.01 eighth-kz on abi GPU2: kz=[2.25, 2.75, 2.125, 2.375, 2.625, 2.875], 180 runs
set -e
export CUDA_VISIBLE_DEVICES=2
WDIR=/DATA/s23103/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs
echo "=== start $(date) ==="

cat > /tmp/abi_gpu2_a0.1_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.1 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.1_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.2_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.2 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.2_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.3_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.3 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.3_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.4_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.4 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.4_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.5_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.5 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.5_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.6_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.6 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.6_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.7_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.7 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.7_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.8_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.8 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.8_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.9_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.9 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.9_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.0_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.0 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.0_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.1_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.1 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.1_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.2_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.2 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.2_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.3_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.3 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.3_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.4_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.4 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.4_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.5_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.5 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.5_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.6_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.6 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.6_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.7_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.7 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.7_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.8_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.8 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.8_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.9_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.9 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.9_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.0_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.0 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.0_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.1_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.1 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.1_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.2_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.2 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.2_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.3_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.3 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.3_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.4_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.4 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.4_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.5_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.5 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.5_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.6_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.6 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.6_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.7_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.7 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.7_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.8_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.8 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.8_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.9_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.9 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.9_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a3.0_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=3.0 V0=0.01 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a3.0_v0.01_kz2.25.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.1_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.1 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.1_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.2_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.2 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.2_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.3_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.3 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.3_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.4_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.4 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.4_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.5_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.5 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.5_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.6_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.6 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.6_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.7_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.7 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.7_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.8_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.8 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.8_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.9_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.9 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.9_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.0_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.0 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.0_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.1_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.1 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.1_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.2_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.2 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.2_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.3_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.3 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.3_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.4_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.4 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.4_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.5_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.5 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.5_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.6_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.6 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.6_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.7_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.7 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.7_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.8_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.8 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.8_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.9_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.9 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.9_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.0_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.0 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.0_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.1_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.1 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.1_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.2_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.2 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.2_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.3_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.3 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.3_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.4_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.4 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.4_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.5_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.5 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.5_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.6_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.6 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.6_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.7_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.7 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.7_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.8_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.8 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.8_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.9_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.9 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.9_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a3.0_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=3.0 V0=0.01 kz=2.75 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a3.0_v0.01_kz2.75.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.1_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.1 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.1_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.2_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.2 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.2_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.3_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.3 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.3_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.4_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.4 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.4_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.5_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.5 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.5_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.6_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.6 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.6_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.7_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.7 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.7_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.8_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.8 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.8_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.9_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.9 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.9_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.0_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.0 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.0_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.1_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.1 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.1_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.2_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.2 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.2_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.3_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.3 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.3_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.4_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.4 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.4_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.5_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.5 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.5_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.6_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.6 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.6_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.7_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.7 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.7_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.8_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.8 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.8_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.9_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.9 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.9_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.0_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.0 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.0_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.1_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.1 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.1_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.2_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.2 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.2_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.3_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.3 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.3_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.4_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.4 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.4_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.5_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.5 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.5_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.6_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.6 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.6_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.7_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.7 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.7_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.8_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.8 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.8_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.9_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.9 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.9_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a3.0_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=3.0 V0=0.01 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a3.0_v0.01_kz2.125.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.1_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.1 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.1_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.2_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.2 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.2_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.3_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.3 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.3_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.4_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.4 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.4_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.5_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.5 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.5_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.6_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.6 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.6_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.7_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.7 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.7_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.8_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.8 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.8_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.9_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.9 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.9_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.0_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.0 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.0_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.1_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.1 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.1_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.2_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.2 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.2_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.3_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.3 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.3_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.4_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.4 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.4_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.5_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.5 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.5_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.6_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.6 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.6_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.7_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.7 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.7_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.8_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.8 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.8_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.9_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.9 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.9_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.0_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.0 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.0_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.1_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.1 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.1_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.2_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.2 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.2_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.3_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.3 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.3_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.4_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.4 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.4_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.5_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.5 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.5_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.6_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.6 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.6_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.7_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.7 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.7_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.8_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.8 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.8_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.9_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.9 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.9_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a3.0_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=3.0 V0=0.01 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a3.0_v0.01_kz2.375.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.1_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.1 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.1_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.2_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.2 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.2_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.3_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.3 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.3_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.4_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.4 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.4_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.5_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.5 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.5_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.6_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.6 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.6_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.7_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.7 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.7_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.8_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.8 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.8_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.9_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.9 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.9_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.0_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.0 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.0_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.1_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.1 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.1_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.2_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.2 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.2_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.3_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.3 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.3_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.4_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.4 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.4_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.5_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.5 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.5_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.6_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.6 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.6_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.7_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.7 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.7_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.8_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.8 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.8_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.9_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.9 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.9_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.0_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.0 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.0_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.1_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.1 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.1_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.2_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.2 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.2_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.3_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.3 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.3_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.4_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.4 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.4_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.5_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.5 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.5_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.6_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.6 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.6_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.7_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.7 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.7_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.8_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.8 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.8_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.9_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.9 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.9_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a3.0_v0.01_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=3.0 V0=0.01 kz=2.625 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a3.0_v0.01_kz2.625.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.1_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.1 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.1_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.2_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.2 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.2_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.3_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.3 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.3_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.4_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.4 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.4_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.5_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.5 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.5_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.6_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.6 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.6_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.7_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.7 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.7_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.8_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.8 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.8_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a0.9_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=0.9 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a0.9_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.0_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.0 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.0_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.1_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.1 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.1_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.2_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.2 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.2_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.3_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.3 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.3_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.4_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.4 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.4_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.5_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.5 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.5_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.6_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.6 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.6_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.7_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.7 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.7_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.8_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.8 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.8_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a1.9_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=1.9 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a1.9_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.0_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.0 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.0_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.1_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.1 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.1_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.2_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.2 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.2_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.3_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.3 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.3_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.4_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.4 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.4_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.5_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.5 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.5_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.6_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.6 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.6_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.7_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.7 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.7_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.8_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.8 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.8_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a2.9_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.9 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a2.9_v0.01_kz2.875.ini
echo "done $(date)"

cat > /tmp/abi_gpu2_a3.0_v0.01_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=3.0 V0=0.01 kz=2.875 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/abi_gpu2_a3.0_v0.01_kz2.875.ini
echo "done $(date)"

echo "=== ALL DONE $(date) ==="
