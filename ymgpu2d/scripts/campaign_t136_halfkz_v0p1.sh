#!/bin/bash
# Half-kz Lz=4pi campaign: V0=0.1, 240 runs
# Launch: nohup bash scripts/campaign_t136_halfkz_v0p1.sh > logs/campaign_t136_halfkz_v0p1.log 2>&1 &

set -e
mkdir -p logs
echo "=== start $(date) ==="

cat > /tmp/a0.1_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.1 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.1_v0.1_kz0.5.ini
echo "a=0.1 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a0.1_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.1 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.1_v0.1_kz1.5.ini
echo "a=0.1 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a0.1_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.1 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.1_v0.1_kz2.5.ini
echo "a=0.1 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a0.1_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.1 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.1_v0.1_kz3.5.ini
echo "a=0.1 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a0.1_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.1 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.1_v0.1_kz4.5.ini
echo "a=0.1 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a0.1_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.1 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.1_v0.1_kz5.5.ini
echo "a=0.1 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a0.1_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.1 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.1_v0.1_kz6.5.ini
echo "a=0.1 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a0.1_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 55.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.1 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.1_v0.1_kz7.5.ini
echo "a=0.1 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a0.2_v0.1_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.2 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.2_v0.1_kz0.5.ini
echo "a=0.2 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a0.2_v0.1_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.2 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.2_v0.1_kz1.5.ini
echo "a=0.2 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a0.2_v0.1_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.2 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.2_v0.1_kz2.5.ini
echo "a=0.2 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a0.2_v0.1_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.2 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.2_v0.1_kz3.5.ini
echo "a=0.2 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a0.2_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.2 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.2_v0.1_kz4.5.ini
echo "a=0.2 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a0.2_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.2 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.2_v0.1_kz5.5.ini
echo "a=0.2 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a0.2_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.2 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.2_v0.1_kz6.5.ini
echo "a=0.2 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a0.2_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.2 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.2_v0.1_kz7.5.ini
echo "a=0.2 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a0.3_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.3 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.3_v0.1_kz0.5.ini
echo "a=0.3 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a0.3_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.3 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.3_v0.1_kz1.5.ini
echo "a=0.3 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a0.3_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.3 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.3_v0.1_kz2.5.ini
echo "a=0.3 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a0.3_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.3 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.3_v0.1_kz3.5.ini
echo "a=0.3 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a0.3_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.3 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.3_v0.1_kz4.5.ini
echo "a=0.3 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a0.3_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.3 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.3_v0.1_kz5.5.ini
echo "a=0.3 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a0.3_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.3 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.3_v0.1_kz6.5.ini
echo "a=0.3 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a0.3_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.3 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.3_v0.1_kz7.5.ini
echo "a=0.3 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a0.4_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.4 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.4_v0.1_kz0.5.ini
echo "a=0.4 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a0.4_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.4 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.4_v0.1_kz1.5.ini
echo "a=0.4 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a0.4_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.4 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.4_v0.1_kz2.5.ini
echo "a=0.4 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a0.4_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.4 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.4_v0.1_kz3.5.ini
echo "a=0.4 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a0.4_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.4 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.4_v0.1_kz4.5.ini
echo "a=0.4 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a0.4_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.4 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.4_v0.1_kz5.5.ini
echo "a=0.4 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a0.4_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.4 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.4_v0.1_kz6.5.ini
echo "a=0.4 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a0.4_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.4 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.4_v0.1_kz7.5.ini
echo "a=0.4 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a0.5_v0.1_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.5 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.5_v0.1_kz0.5.ini
echo "a=0.5 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a0.5_v0.1_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.5 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.5_v0.1_kz1.5.ini
echo "a=0.5 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a0.5_v0.1_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.5 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.5_v0.1_kz2.5.ini
echo "a=0.5 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a0.5_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.5 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.5_v0.1_kz3.5.ini
echo "a=0.5 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a0.5_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.5 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.5_v0.1_kz4.5.ini
echo "a=0.5 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a0.5_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.5 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.5_v0.1_kz5.5.ini
echo "a=0.5 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a0.5_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.5 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.5_v0.1_kz6.5.ini
echo "a=0.5 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a0.5_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.5 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.5_v0.1_kz7.5.ini
echo "a=0.5 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a0.6_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.6 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.6_v0.1_kz0.5.ini
echo "a=0.6 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a0.6_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.6 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.6_v0.1_kz1.5.ini
echo "a=0.6 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a0.6_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.6 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.6_v0.1_kz2.5.ini
echo "a=0.6 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a0.6_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.6 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.6_v0.1_kz3.5.ini
echo "a=0.6 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a0.6_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.6 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.6_v0.1_kz4.5.ini
echo "a=0.6 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a0.6_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.6 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.6_v0.1_kz5.5.ini
echo "a=0.6 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a0.6_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.6 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.6_v0.1_kz6.5.ini
echo "a=0.6 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a0.6_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.6 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.6_v0.1_kz7.5.ini
echo "a=0.6 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a0.7_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.7 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.7_v0.1_kz0.5.ini
echo "a=0.7 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a0.7_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.7 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.7_v0.1_kz1.5.ini
echo "a=0.7 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a0.7_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.7 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.7_v0.1_kz2.5.ini
echo "a=0.7 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a0.7_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.7 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.7_v0.1_kz3.5.ini
echo "a=0.7 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a0.7_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.7 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.7_v0.1_kz4.5.ini
echo "a=0.7 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a0.7_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.7 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.7_v0.1_kz5.5.ini
echo "a=0.7 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a0.7_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.7 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.7_v0.1_kz6.5.ini
echo "a=0.7 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a0.7_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.7 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.7_v0.1_kz7.5.ini
echo "a=0.7 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a0.8_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.8 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.8_v0.1_kz0.5.ini
echo "a=0.8 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a0.8_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.8 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.8_v0.1_kz1.5.ini
echo "a=0.8 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a0.8_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.8 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.8_v0.1_kz2.5.ini
echo "a=0.8 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a0.8_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.8 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.8_v0.1_kz3.5.ini
echo "a=0.8 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a0.8_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.8 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.8_v0.1_kz4.5.ini
echo "a=0.8 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a0.8_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.8 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.8_v0.1_kz5.5.ini
echo "a=0.8 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a0.8_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.8 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.8_v0.1_kz6.5.ini
echo "a=0.8 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a0.8_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.8 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.8_v0.1_kz7.5.ini
echo "a=0.8 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a0.9_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.9 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.9_v0.1_kz0.5.ini
echo "a=0.9 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a0.9_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.9 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.9_v0.1_kz1.5.ini
echo "a=0.9 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a0.9_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.9 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.9_v0.1_kz2.5.ini
echo "a=0.9 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a0.9_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.9 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.9_v0.1_kz3.5.ini
echo "a=0.9 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a0.9_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.9 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.9_v0.1_kz4.5.ini
echo "a=0.9 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a0.9_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.9 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.9_v0.1_kz5.5.ini
echo "a=0.9 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a0.9_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.9 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.9_v0.1_kz6.5.ini
echo "a=0.9 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a0.9_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=0.9 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.9_v0.1_kz7.5.ini
echo "a=0.9 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a1.0_v0.1_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.0 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.0_v0.1_kz0.5.ini
echo "a=1.0 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a1.0_v0.1_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.0 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.0_v0.1_kz1.5.ini
echo "a=1.0 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a1.0_v0.1_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.0 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.0_v0.1_kz2.5.ini
echo "a=1.0 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a1.0_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.0 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.0_v0.1_kz3.5.ini
echo "a=1.0 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a1.0_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.0 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.0_v0.1_kz4.5.ini
echo "a=1.0 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a1.0_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.0 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.0_v0.1_kz5.5.ini
echo "a=1.0 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a1.0_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.0 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.0_v0.1_kz6.5.ini
echo "a=1.0 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a1.0_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.0 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.0_v0.1_kz7.5.ini
echo "a=1.0 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a1.1_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.1 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.1_v0.1_kz0.5.ini
echo "a=1.1 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a1.1_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.1 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.1_v0.1_kz1.5.ini
echo "a=1.1 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a1.1_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.1 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.1_v0.1_kz2.5.ini
echo "a=1.1 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a1.1_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.1 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.1_v0.1_kz3.5.ini
echo "a=1.1 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a1.1_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.1 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.1_v0.1_kz4.5.ini
echo "a=1.1 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a1.1_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.1 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.1_v0.1_kz5.5.ini
echo "a=1.1 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a1.1_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.1 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.1_v0.1_kz6.5.ini
echo "a=1.1 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a1.1_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.1 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.1_v0.1_kz7.5.ini
echo "a=1.1 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a1.2_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.2 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.2_v0.1_kz0.5.ini
echo "a=1.2 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a1.2_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.2 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.2_v0.1_kz1.5.ini
echo "a=1.2 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a1.2_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.2 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.2_v0.1_kz2.5.ini
echo "a=1.2 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a1.2_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.2 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.2_v0.1_kz3.5.ini
echo "a=1.2 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a1.2_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.2 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.2_v0.1_kz4.5.ini
echo "a=1.2 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a1.2_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.2 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.2_v0.1_kz5.5.ini
echo "a=1.2 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a1.2_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.2 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.2_v0.1_kz6.5.ini
echo "a=1.2 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a1.2_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.2 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.2_v0.1_kz7.5.ini
echo "a=1.2 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a1.3_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.3 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.3_v0.1_kz0.5.ini
echo "a=1.3 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a1.3_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.3 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.3_v0.1_kz1.5.ini
echo "a=1.3 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a1.3_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.3 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.3_v0.1_kz2.5.ini
echo "a=1.3 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a1.3_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.3 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.3_v0.1_kz3.5.ini
echo "a=1.3 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a1.3_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.3 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.3_v0.1_kz4.5.ini
echo "a=1.3 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a1.3_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.3 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.3_v0.1_kz5.5.ini
echo "a=1.3 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a1.3_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.3 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.3_v0.1_kz6.5.ini
echo "a=1.3 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a1.3_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.3 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.3_v0.1_kz7.5.ini
echo "a=1.3 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a1.4_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.4 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.4_v0.1_kz0.5.ini
echo "a=1.4 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a1.4_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.4 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.4_v0.1_kz1.5.ini
echo "a=1.4 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a1.4_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.4 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.4_v0.1_kz2.5.ini
echo "a=1.4 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a1.4_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.4 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.4_v0.1_kz3.5.ini
echo "a=1.4 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a1.4_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.4 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.4_v0.1_kz4.5.ini
echo "a=1.4 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a1.4_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.4 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.4_v0.1_kz5.5.ini
echo "a=1.4 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a1.4_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.4 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.4_v0.1_kz6.5.ini
echo "a=1.4 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a1.4_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.4 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.4_v0.1_kz7.5.ini
echo "a=1.4 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a1.5_v0.1_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.5 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.5_v0.1_kz0.5.ini
echo "a=1.5 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a1.5_v0.1_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.5 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.5_v0.1_kz1.5.ini
echo "a=1.5 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a1.5_v0.1_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.5 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.5_v0.1_kz2.5.ini
echo "a=1.5 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a1.5_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.5 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.5_v0.1_kz3.5.ini
echo "a=1.5 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a1.5_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.5 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.5_v0.1_kz4.5.ini
echo "a=1.5 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a1.5_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.5 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.5_v0.1_kz5.5.ini
echo "a=1.5 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a1.5_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.5 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.5_v0.1_kz6.5.ini
echo "a=1.5 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a1.5_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.5 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.5_v0.1_kz7.5.ini
echo "a=1.5 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a1.6_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.6 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.6_v0.1_kz0.5.ini
echo "a=1.6 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a1.6_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.6 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.6_v0.1_kz1.5.ini
echo "a=1.6 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a1.6_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.6 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.6_v0.1_kz2.5.ini
echo "a=1.6 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a1.6_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.6 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.6_v0.1_kz3.5.ini
echo "a=1.6 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a1.6_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.6 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.6_v0.1_kz4.5.ini
echo "a=1.6 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a1.6_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.6 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.6_v0.1_kz5.5.ini
echo "a=1.6 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a1.6_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.6 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.6_v0.1_kz6.5.ini
echo "a=1.6 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a1.6_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.6 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.6_v0.1_kz7.5.ini
echo "a=1.6 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a1.7_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.7 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.7_v0.1_kz0.5.ini
echo "a=1.7 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a1.7_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.7 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.7_v0.1_kz1.5.ini
echo "a=1.7 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a1.7_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.7 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.7_v0.1_kz2.5.ini
echo "a=1.7 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a1.7_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.7 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.7_v0.1_kz3.5.ini
echo "a=1.7 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a1.7_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.7 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.7_v0.1_kz4.5.ini
echo "a=1.7 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a1.7_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.7 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.7_v0.1_kz5.5.ini
echo "a=1.7 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a1.7_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.7 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.7_v0.1_kz6.5.ini
echo "a=1.7 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a1.7_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.7 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.7_v0.1_kz7.5.ini
echo "a=1.7 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a1.8_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.8 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.8_v0.1_kz0.5.ini
echo "a=1.8 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a1.8_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.8 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.8_v0.1_kz1.5.ini
echo "a=1.8 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a1.8_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.8 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.8_v0.1_kz2.5.ini
echo "a=1.8 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a1.8_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.8 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.8_v0.1_kz3.5.ini
echo "a=1.8 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a1.8_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.8 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.8_v0.1_kz4.5.ini
echo "a=1.8 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a1.8_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.8 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.8_v0.1_kz5.5.ini
echo "a=1.8 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a1.8_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.8 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.8_v0.1_kz6.5.ini
echo "a=1.8 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a1.8_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.8 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.8_v0.1_kz7.5.ini
echo "a=1.8 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a1.9_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.9 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.9_v0.1_kz0.5.ini
echo "a=1.9 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a1.9_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.9 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.9_v0.1_kz1.5.ini
echo "a=1.9 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a1.9_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.9 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.9_v0.1_kz2.5.ini
echo "a=1.9 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a1.9_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.9 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.9_v0.1_kz3.5.ini
echo "a=1.9 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a1.9_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.9 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.9_v0.1_kz4.5.ini
echo "a=1.9 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a1.9_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.9 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.9_v0.1_kz5.5.ini
echo "a=1.9 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a1.9_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.9 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.9_v0.1_kz6.5.ini
echo "a=1.9 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a1.9_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=1.9 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a1.9_v0.1_kz7.5.ini
echo "a=1.9 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a2.0_v0.1_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.0 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.0_v0.1_kz0.5.ini
echo "a=2.0 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a2.0_v0.1_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.0 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.0_v0.1_kz1.5.ini
echo "a=2.0 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a2.0_v0.1_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.0 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.0_v0.1_kz2.5.ini
echo "a=2.0 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a2.0_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.0 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.0_v0.1_kz3.5.ini
echo "a=2.0 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a2.0_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.0 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.0_v0.1_kz4.5.ini
echo "a=2.0 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a2.0_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.0 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.0_v0.1_kz5.5.ini
echo "a=2.0 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a2.0_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.0 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.0_v0.1_kz6.5.ini
echo "a=2.0 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a2.0_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.0 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.0_v0.1_kz7.5.ini
echo "a=2.0 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a2.1_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.1 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.1_v0.1_kz0.5.ini
echo "a=2.1 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a2.1_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.1 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.1_v0.1_kz1.5.ini
echo "a=2.1 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a2.1_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.1 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.1_v0.1_kz2.5.ini
echo "a=2.1 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a2.1_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.1 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.1_v0.1_kz3.5.ini
echo "a=2.1 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a2.1_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.1 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.1_v0.1_kz4.5.ini
echo "a=2.1 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a2.1_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.1 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.1_v0.1_kz5.5.ini
echo "a=2.1 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a2.1_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.1 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.1_v0.1_kz6.5.ini
echo "a=2.1 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a2.1_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.1 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.1_v0.1_kz7.5.ini
echo "a=2.1 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a2.2_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.2 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.2_v0.1_kz0.5.ini
echo "a=2.2 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a2.2_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.2 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.2_v0.1_kz1.5.ini
echo "a=2.2 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a2.2_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.2 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.2_v0.1_kz2.5.ini
echo "a=2.2 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a2.2_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.2 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.2_v0.1_kz3.5.ini
echo "a=2.2 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a2.2_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.2 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.2_v0.1_kz4.5.ini
echo "a=2.2 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a2.2_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.2 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.2_v0.1_kz5.5.ini
echo "a=2.2 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a2.2_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.2 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.2_v0.1_kz6.5.ini
echo "a=2.2 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a2.2_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.2 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.2_v0.1_kz7.5.ini
echo "a=2.2 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a2.3_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.3 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.3_v0.1_kz0.5.ini
echo "a=2.3 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a2.3_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.3 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.3_v0.1_kz1.5.ini
echo "a=2.3 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a2.3_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.3 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.3_v0.1_kz2.5.ini
echo "a=2.3 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a2.3_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.3 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.3_v0.1_kz3.5.ini
echo "a=2.3 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a2.3_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.3 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.3_v0.1_kz4.5.ini
echo "a=2.3 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a2.3_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.3 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.3_v0.1_kz5.5.ini
echo "a=2.3 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a2.3_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.3 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.3_v0.1_kz6.5.ini
echo "a=2.3 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a2.3_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.3 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.3_v0.1_kz7.5.ini
echo "a=2.3 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a2.4_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.4 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.4_v0.1_kz0.5.ini
echo "a=2.4 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a2.4_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.4 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.4_v0.1_kz1.5.ini
echo "a=2.4 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a2.4_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.4 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.4_v0.1_kz2.5.ini
echo "a=2.4 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a2.4_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.4 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.4_v0.1_kz3.5.ini
echo "a=2.4 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a2.4_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.4 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.4_v0.1_kz4.5.ini
echo "a=2.4 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a2.4_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.4 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.4_v0.1_kz5.5.ini
echo "a=2.4 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a2.4_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.4 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.4_v0.1_kz6.5.ini
echo "a=2.4 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a2.4_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.4 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.4_v0.1_kz7.5.ini
echo "a=2.4 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a2.5_v0.1_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.5 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.5_v0.1_kz0.5.ini
echo "a=2.5 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a2.5_v0.1_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.5 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.5_v0.1_kz1.5.ini
echo "a=2.5 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a2.5_v0.1_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.5 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.5_v0.1_kz2.5.ini
echo "a=2.5 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a2.5_v0.1_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.5 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.5_v0.1_kz3.5.ini
echo "a=2.5 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a2.5_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.5 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.5_v0.1_kz4.5.ini
echo "a=2.5 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a2.5_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.5 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.5_v0.1_kz5.5.ini
echo "a=2.5 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a2.5_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.5 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.5_v0.1_kz6.5.ini
echo "a=2.5 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a2.5_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.5 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.5_v0.1_kz7.5.ini
echo "a=2.5 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a2.6_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.6 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.6_v0.1_kz0.5.ini
echo "a=2.6 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a2.6_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.6 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.6_v0.1_kz1.5.ini
echo "a=2.6 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a2.6_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.6 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.6_v0.1_kz2.5.ini
echo "a=2.6 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a2.6_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.6 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.6_v0.1_kz3.5.ini
echo "a=2.6 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a2.6_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.6 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.6_v0.1_kz4.5.ini
echo "a=2.6 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a2.6_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.6 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.6_v0.1_kz5.5.ini
echo "a=2.6 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a2.6_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.6 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.6_v0.1_kz6.5.ini
echo "a=2.6 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a2.6_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.6 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.6_v0.1_kz7.5.ini
echo "a=2.6 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a2.7_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.7 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.7_v0.1_kz0.5.ini
echo "a=2.7 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a2.7_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.7 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.7_v0.1_kz1.5.ini
echo "a=2.7 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a2.7_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.7 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.7_v0.1_kz2.5.ini
echo "a=2.7 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a2.7_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.7 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.7_v0.1_kz3.5.ini
echo "a=2.7 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a2.7_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.7 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.7_v0.1_kz4.5.ini
echo "a=2.7 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a2.7_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.7 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.7_v0.1_kz5.5.ini
echo "a=2.7 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a2.7_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.7 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.7_v0.1_kz6.5.ini
echo "a=2.7 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a2.7_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.7 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.7_v0.1_kz7.5.ini
echo "a=2.7 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a2.8_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.8 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.8_v0.1_kz0.5.ini
echo "a=2.8 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a2.8_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.8 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.8_v0.1_kz1.5.ini
echo "a=2.8 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a2.8_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.8 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.8_v0.1_kz2.5.ini
echo "a=2.8 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a2.8_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.8 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.8_v0.1_kz3.5.ini
echo "a=2.8 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a2.8_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.8 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.8_v0.1_kz4.5.ini
echo "a=2.8 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a2.8_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.8 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.8_v0.1_kz5.5.ini
echo "a=2.8 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a2.8_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.8 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.8_v0.1_kz6.5.ini
echo "a=2.8 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a2.8_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.8 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.8_v0.1_kz7.5.ini
echo "a=2.8 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a2.9_v0.1_kz0.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.9 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.9_v0.1_kz0.5.ini
echo "a=2.9 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a2.9_v0.1_kz1.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.9 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.9_v0.1_kz1.5.ini
echo "a=2.9 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a2.9_v0.1_kz2.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.9 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.9_v0.1_kz2.5.ini
echo "a=2.9 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a2.9_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.9 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.9_v0.1_kz3.5.ini
echo "a=2.9 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a2.9_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.9 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.9_v0.1_kz4.5.ini
echo "a=2.9 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a2.9_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.9 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.9_v0.1_kz5.5.ini
echo "a=2.9 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a2.9_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.9 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.9_v0.1_kz6.5.ini
echo "a=2.9 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a2.9_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=2.9 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a2.9_v0.1_kz7.5.ini
echo "a=2.9 V0=0.1 kz_phys=7.5 done $(date)"

cat > /tmp/a3.0_v0.1_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=3.0 V0=0.1 kz_phys=0.5 k_mode=1 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a3.0_v0.1_kz0.5.ini
echo "a=3.0 V0=0.1 kz_phys=0.5 done $(date)"

cat > /tmp/a3.0_v0.1_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=3.0 V0=0.1 kz_phys=1.5 k_mode=3 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a3.0_v0.1_kz1.5.ini
echo "a=3.0 V0=0.1 kz_phys=1.5 done $(date)"

cat > /tmp/a3.0_v0.1_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=3.0 V0=0.1 kz_phys=2.5 k_mode=5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a3.0_v0.1_kz2.5.ini
echo "a=3.0 V0=0.1 kz_phys=2.5 done $(date)"

cat > /tmp/a3.0_v0.1_kz3.5.ini <<'EOINI'
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
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=3.0 V0=0.1 kz_phys=3.5 k_mode=7 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a3.0_v0.1_kz3.5.ini
echo "a=3.0 V0=0.1 kz_phys=3.5 done $(date)"

cat > /tmp/a3.0_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=3.0 V0=0.1 kz_phys=4.5 k_mode=9 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a3.0_v0.1_kz4.5.ini
echo "a=3.0 V0=0.1 kz_phys=4.5 done $(date)"

cat > /tmp/a3.0_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=3.0 V0=0.1 kz_phys=5.5 k_mode=11 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a3.0_v0.1_kz5.5.ini
echo "a=3.0 V0=0.1 kz_phys=5.5 done $(date)"

cat > /tmp/a3.0_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=3.0 V0=0.1 kz_phys=6.5 k_mode=13 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a3.0_v0.1_kz6.5.ini
echo "a=3.0 V0=0.1 kz_phys=6.5 done $(date)"

cat > /tmp/a3.0_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100
lz_override = 12.566371
nz_override = 128
EOINI
echo "a=3.0 V0=0.1 kz_phys=7.5 k_mode=15 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a3.0_v0.1_kz7.5.ini
echo "a=3.0 V0=0.1 kz_phys=7.5 done $(date)"

echo "=== ALL DONE $(date) ==="
