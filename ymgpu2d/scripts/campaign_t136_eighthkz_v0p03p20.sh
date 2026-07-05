#!/bin/bash
# eighth-kz kz<=3 on t136: 360 runs
set -e
WDIR=/DATA/cm/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs
echo "=== start $(date) ==="

cat > /tmp/a0.1_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.1
V0 = 0.03
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
echo "a=0.1 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.1_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.1_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.1
V0 = 0.05
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
echo "a=0.1 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.1_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.1_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.1
V0 = 0.1
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
echo "a=0.1 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.1_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.1_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.1
V0 = 0.2
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
echo "a=0.1 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.1_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.2_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.2
V0 = 0.03
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
echo "a=0.2 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.2_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.2_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.2
V0 = 0.05
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
echo "a=0.2 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.2_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.2_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.2
V0 = 0.1
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
echo "a=0.2 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.2_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.2_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.2
V0 = 0.2
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
echo "a=0.2 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.2_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.3_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.3
V0 = 0.03
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
echo "a=0.3 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.3_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.3_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.3
V0 = 0.05
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
echo "a=0.3 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.3_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.3_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.3
V0 = 0.1
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
echo "a=0.3 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.3_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.3_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 46.0
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
echo "a=0.3 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.3_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.4_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.4
V0 = 0.03
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
echo "a=0.4 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.4_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.4_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.4
V0 = 0.05
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
echo "a=0.4 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.4_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.4_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.4
V0 = 0.1
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
echo "a=0.4 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.4_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.4_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 34.0
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
echo "a=0.4 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.4_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.5_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.5
V0 = 0.03
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
echo "a=0.5 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.5_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.5_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.5
V0 = 0.05
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
echo "a=0.5 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.5_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.5_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.5
V0 = 0.1
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
echo "a=0.5 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.5_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.5_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
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
echo "a=0.5 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.5_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.6_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.6
V0 = 0.03
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
echo "a=0.6 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.6_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.6_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.6
V0 = 0.05
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
echo "a=0.6 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.6_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.6_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 46.0
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
echo "a=0.6 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.6_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.6_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
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
echo "a=0.6 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.6_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.7_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.7
V0 = 0.03
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
echo "a=0.7 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.7_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.7_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.7
V0 = 0.05
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
echo "a=0.7 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.7_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.7_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 39.0
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
echo "a=0.7 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.7_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.7_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 19.0
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
echo "a=0.7 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.7_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.8_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.8
V0 = 0.03
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
echo "a=0.8 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.8_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.8_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.8
V0 = 0.05
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
echo "a=0.8 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.8_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.8_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 34.0
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
echo "a=0.8 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.8_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.8_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 17.0
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
echo "a=0.8 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.8_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.9_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.9
V0 = 0.03
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
echo "a=0.9 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.9_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.9_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.9
V0 = 0.05
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
echo "a=0.9 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.9_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.9_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
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
echo "a=0.9 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.9_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.9_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 15.0
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
echo "a=0.9 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.9_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.0_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.0
V0 = 0.03
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
echo "a=1.0 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.0_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.0_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.0
V0 = 0.05
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
echo "a=1.0 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.0_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.0_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
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
echo "a=1.0 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.0_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.0_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
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
echo "a=1.0 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.0_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.1_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.1
V0 = 0.03
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
echo "a=1.1 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.1_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.1_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 50.0
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
echo "a=1.1 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.1_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.1_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
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
echo "a=1.1 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.1_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.1_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
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
echo "a=1.1 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.1_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.2_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.2
V0 = 0.03
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
echo "a=1.2 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.2_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.2_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 46.0
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
echo "a=1.2 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.2_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.2_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
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
echo "a=1.2 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.2_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.2_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
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
echo "a=1.2 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.2_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.3_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.3
V0 = 0.03
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
echo "a=1.3 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.3_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.3_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 42.0
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
echo "a=1.3 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.3_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.3_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
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
echo "a=1.3 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.3_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.3_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
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
echo "a=1.3 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.3_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.4_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.4
V0 = 0.03
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
echo "a=1.4 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.4_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.4_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 39.0
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
echo "a=1.4 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.4_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.4_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 19.0
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
echo "a=1.4 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.4_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.4_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
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
echo "a=1.4 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.4_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.5_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.5
V0 = 0.03
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
echo "a=1.5 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.5_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.5_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 36.0
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
echo "a=1.5 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.5_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.5_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
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
echo "a=1.5 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.5_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.5_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
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
echo "a=1.5 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.5_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.6_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.6
V0 = 0.03
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
echo "a=1.6 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.6_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.6_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 34.0
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
echo "a=1.6 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.6_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.6_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 17.0
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
echo "a=1.6 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.6_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.6_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
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
echo "a=1.6 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.6_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.7_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
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
echo "a=1.7 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.7_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.7_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
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
echo "a=1.7 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.7_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.7_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
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
echo "a=1.7 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.7_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.7_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
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
echo "a=1.7 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.7_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.8_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 51.0
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
echo "a=1.8 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.8_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.8_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
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
echo "a=1.8 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.8_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.8_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 15.0
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
echo "a=1.8 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.8_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.8_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
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
echo "a=1.8 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.8_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.9_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 48.0
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
echo "a=1.9 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.9_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.9_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 29.0
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
echo "a=1.9 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.9_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.9_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
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
echo "a=1.9 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.9_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a1.9_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
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
echo "a=1.9 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.9_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.0_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 46.0
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
echo "a=2.0 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.0_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.0_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
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
echo "a=2.0 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.0_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.0_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
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
echo "a=2.0 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.0_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.0_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
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
echo "a=2.0 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.0_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.1_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 43.0
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
echo "a=2.1 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.1_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.1_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
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
echo "a=2.1 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.1_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.1_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
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
echo "a=2.1 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.1_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.1_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
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
echo "a=2.1 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.1_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.2_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 41.0
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
echo "a=2.2 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.2_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.2_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
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
echo "a=2.2 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.2_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.2_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
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
echo "a=2.2 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.2_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.2_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
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
echo "a=2.2 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.2_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.3_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 40.0
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
echo "a=2.3 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.3_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.3_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
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
echo "a=2.3 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.3_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.3_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
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
echo "a=2.3 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.3_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.3_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
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
echo "a=2.3 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.3_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.4_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 38.0
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
echo "a=2.4 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.4_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.4_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
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
echo "a=2.4 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.4_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.4_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
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
echo "a=2.4 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.4_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.4_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
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
echo "a=2.4 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.4_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.5_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 36.0
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
echo "a=2.5 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.5_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.5_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
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
echo "a=2.5 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.5_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.5_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
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
echo "a=2.5 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.5_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.5_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
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
echo "a=2.5 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.5_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.6_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 35.0
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
echo "a=2.6 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.6_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.6_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
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
echo "a=2.6 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.6_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.6_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
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
echo "a=2.6 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.6_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.6_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
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
echo "a=2.6 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.6_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.7_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 34.0
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
echo "a=2.7 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.7_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.7_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 20.0
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
echo "a=2.7 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.7_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.7_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
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
echo "a=2.7 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.7_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.7_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
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
echo "a=2.7 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.7_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.8_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
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
echo "a=2.8 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.8_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.8_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 19.0
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
echo "a=2.8 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.8_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.8_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
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
echo "a=2.8 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.8_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.8_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
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
echo "a=2.8 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.8_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.9_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 31.0
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
echo "a=2.9 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.9_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.9_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 19.0
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
echo "a=2.9 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.9_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.9_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
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
echo "a=2.9 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.9_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a2.9_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
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
echo "a=2.9 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.9_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a3.0_v0.03_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
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
echo "a=3.0 V0=0.03 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a3.0_v0.03_kz2.125.ini
echo "done $(date)"

cat > /tmp/a3.0_v0.05_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
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
echo "a=3.0 V0=0.05 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a3.0_v0.05_kz2.125.ini
echo "done $(date)"

cat > /tmp/a3.0_v0.1_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
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
echo "a=3.0 V0=0.1 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a3.0_v0.1_kz2.125.ini
echo "done $(date)"

cat > /tmp/a3.0_v0.2_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 3.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
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
echo "a=3.0 V0=0.2 kz=2.125 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a3.0_v0.2_kz2.125.ini
echo "done $(date)"

cat > /tmp/a0.1_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.1
V0 = 0.03
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
echo "a=0.1 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.1_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.1_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.1
V0 = 0.05
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
echo "a=0.1 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.1_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.1_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.1
V0 = 0.1
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
echo "a=0.1 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.1_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.1_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.1
V0 = 0.2
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
echo "a=0.1 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.1_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.2_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.2
V0 = 0.03
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
echo "a=0.2 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.2_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.2_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.2
V0 = 0.05
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
echo "a=0.2 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.2_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.2_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.2
V0 = 0.1
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
echo "a=0.2 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.2_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.2_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.2
V0 = 0.2
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
echo "a=0.2 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.2_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.3_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.3
V0 = 0.03
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
echo "a=0.3 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.3_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.3_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.3
V0 = 0.05
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
echo "a=0.3 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.3_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.3_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.3
V0 = 0.1
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
echo "a=0.3 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.3_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.3_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 48.0
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
echo "a=0.3 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.3_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.4_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.4
V0 = 0.03
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
echo "a=0.4 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.4_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.4_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.4
V0 = 0.05
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
echo "a=0.4 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.4_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.4_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.4
V0 = 0.1
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
echo "a=0.4 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.4_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.4_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 36.0
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
echo "a=0.4 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.4_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.5_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.5
V0 = 0.03
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
echo "a=0.5 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.5_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.5_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.5
V0 = 0.05
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
echo "a=0.5 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.5_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.5_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.5
V0 = 0.1
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
echo "a=0.5 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.5_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.5_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 29.0
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
echo "a=0.5 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.5_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.6_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.6
V0 = 0.03
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
echo "a=0.6 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.6_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.6_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.6
V0 = 0.05
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
echo "a=0.6 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.6_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.6_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 48.0
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
echo "a=0.6 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.6_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.6_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
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
echo "a=0.6 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.6_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.7_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.7
V0 = 0.03
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
echo "a=0.7 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.7_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.7_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.7
V0 = 0.05
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
echo "a=0.7 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.7_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.7_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 41.0
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
echo "a=0.7 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.7_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.7_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 20.0
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
echo "a=0.7 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.7_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.8_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.8
V0 = 0.03
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
echo "a=0.8 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.8_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.8_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.8
V0 = 0.05
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
echo "a=0.8 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.8_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.8_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 36.0
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
echo "a=0.8 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.8_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.8_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
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
echo "a=0.8 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.8_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.9_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.9
V0 = 0.03
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
echo "a=0.9 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.9_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.9_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.9
V0 = 0.05
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
echo "a=0.9 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.9_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.9_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
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
echo "a=0.9 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.9_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.9_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
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
echo "a=0.9 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.9_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.0_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.0
V0 = 0.03
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
echo "a=1.0 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.0_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.0_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.0
V0 = 0.05
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
echo "a=1.0 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.0_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.0_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 29.0
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
echo "a=1.0 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.0_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.0_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
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
echo "a=1.0 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.0_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.1_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.1
V0 = 0.03
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
echo "a=1.1 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.1_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.1_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 53.0
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
echo "a=1.1 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.1_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.1_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
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
echo "a=1.1 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.1_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.1_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
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
echo "a=1.1 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.1_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.2_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.2
V0 = 0.03
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
echo "a=1.2 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.2_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.2_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 48.0
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
echo "a=1.2 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.2_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.2_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
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
echo "a=1.2 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.2_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.2_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
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
echo "a=1.2 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.2_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.3_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.3
V0 = 0.03
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
echo "a=1.3 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.3_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.3_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 45.0
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
echo "a=1.3 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.3_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.3_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
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
echo "a=1.3 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.3_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.3_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
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
echo "a=1.3 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.3_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.4_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.4
V0 = 0.03
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
echo "a=1.4 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.4_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.4_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 41.0
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
echo "a=1.4 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.4_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.4_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 20.0
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
echo "a=1.4 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.4_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.4_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
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
echo "a=1.4 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.4_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.5_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.5
V0 = 0.03
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
echo "a=1.5 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.5_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.5_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 39.0
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
echo "a=1.5 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.5_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.5_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 19.0
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
echo "a=1.5 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.5_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.5_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
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
echo "a=1.5 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.5_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.6_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.6
V0 = 0.03
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
echo "a=1.6 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.6_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.6_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 36.0
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
echo "a=1.6 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.6_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.6_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
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
echo "a=1.6 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.6_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.6_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
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
echo "a=1.6 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.6_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.7_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.7
V0 = 0.03
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
echo "a=1.7 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.7_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.7_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 34.0
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
echo "a=1.7 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.7_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.7_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 17.0
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
echo "a=1.7 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.7_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.7_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
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
echo "a=1.7 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.7_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.8_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
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
echo "a=1.8 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.8_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.8_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
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
echo "a=1.8 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.8_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.8_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
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
echo "a=1.8 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.8_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.8_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
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
echo "a=1.8 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.8_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.9_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 51.0
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
echo "a=1.9 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.9_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.9_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
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
echo "a=1.9 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.9_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.9_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 15.0
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
echo "a=1.9 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.9_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a1.9_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
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
echo "a=1.9 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.9_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.0_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 48.0
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
echo "a=2.0 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.0_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.0_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 29.0
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
echo "a=2.0 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.0_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.0_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
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
echo "a=2.0 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.0_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.0_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
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
echo "a=2.0 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.0_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.1_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 46.0
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
echo "a=2.1 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.1_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.1_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 27.0
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
echo "a=2.1 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.1_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.1_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
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
echo "a=2.1 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.1_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.1_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
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
echo "a=2.1 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.1_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.2_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 44.0
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
echo "a=2.2 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.2_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.2_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
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
echo "a=2.2 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.2_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.2_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
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
echo "a=2.2 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.2_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.2_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
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
echo "a=2.2 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.2_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.3_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 42.0
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
echo "a=2.3 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.3_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.3_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
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
echo "a=2.3 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.3_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.3_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
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
echo "a=2.3 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.3_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.3_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
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
echo "a=2.3 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.3_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.4_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 40.0
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
echo "a=2.4 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.4_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.4_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
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
echo "a=2.4 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.4_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.4_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
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
echo "a=2.4 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.4_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.4_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
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
echo "a=2.4 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.4_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.5_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 39.0
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
echo "a=2.5 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.5_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.5_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
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
echo "a=2.5 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.5_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.5_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
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
echo "a=2.5 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.5_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.5_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
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
echo "a=2.5 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.5_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.6_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 37.0
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
echo "a=2.6 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.6_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.6_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
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
echo "a=2.6 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.6_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.6_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
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
echo "a=2.6 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.6_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.6_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
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
echo "a=2.6 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.6_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.7_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 36.0
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
echo "a=2.7 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.7_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.7_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
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
echo "a=2.7 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.7_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.7_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
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
echo "a=2.7 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.7_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.7_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
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
echo "a=2.7 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.7_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.8_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 34.0
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
echo "a=2.8 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.8_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.8_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 20.0
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
echo "a=2.8 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.8_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.8_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
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
echo "a=2.8 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.8_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.8_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
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
echo "a=2.8 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.8_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.9_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 33.0
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
echo "a=2.9 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.9_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.9_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 20.0
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
echo "a=2.9 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.9_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.9_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
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
echo "a=2.9 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.9_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a2.9_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
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
echo "a=2.9 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.9_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a3.0_v0.03_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
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
echo "a=3.0 V0=0.03 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a3.0_v0.03_kz2.25.ini
echo "done $(date)"

cat > /tmp/a3.0_v0.05_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 19.0
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
echo "a=3.0 V0=0.05 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a3.0_v0.05_kz2.25.ini
echo "done $(date)"

cat > /tmp/a3.0_v0.1_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
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
echo "a=3.0 V0=0.1 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a3.0_v0.1_kz2.25.ini
echo "done $(date)"

cat > /tmp/a3.0_v0.2_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 3.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
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
echo "a=3.0 V0=0.2 kz=2.25 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a3.0_v0.2_kz2.25.ini
echo "done $(date)"

cat > /tmp/a0.1_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.1
V0 = 0.03
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
echo "a=0.1 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.1_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.1_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.1
V0 = 0.05
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
echo "a=0.1 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.1_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.1_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.1
V0 = 0.1
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
echo "a=0.1 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.1_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.1_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.1
V0 = 0.2
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
echo "a=0.1 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.1_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.2_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.2
V0 = 0.03
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
echo "a=0.2 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.2_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.2_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.2
V0 = 0.05
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
echo "a=0.2 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.2_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.2_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.2
V0 = 0.1
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
echo "a=0.2 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.2_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.2_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.2
V0 = 0.2
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
echo "a=0.2 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.2_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.3_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.3
V0 = 0.03
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
echo "a=0.3 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.3_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.3_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.3
V0 = 0.05
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
echo "a=0.3 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.3_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.3_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.3
V0 = 0.1
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
echo "a=0.3 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.3_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.3_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 51.0
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
echo "a=0.3 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.3_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.4_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.4
V0 = 0.03
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
echo "a=0.4 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.4_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.4_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.4
V0 = 0.05
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
echo "a=0.4 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.4_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.4_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.4
V0 = 0.1
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
echo "a=0.4 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.4_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.4_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 38.0
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
echo "a=0.4 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.4_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.5_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.5
V0 = 0.03
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
echo "a=0.5 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.5_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.5_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.5
V0 = 0.05
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
echo "a=0.5 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.5_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.5_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.5
V0 = 0.1
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
echo "a=0.5 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.5_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.5_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
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
echo "a=0.5 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.5_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.6_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.6
V0 = 0.03
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
echo "a=0.6 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.6_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.6_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.6
V0 = 0.05
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
echo "a=0.6 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.6_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.6_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 51.0
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
echo "a=0.6 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.6_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.6_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
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
echo "a=0.6 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.6_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.7_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.7
V0 = 0.03
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
echo "a=0.7 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.7_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.7_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.7
V0 = 0.05
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
echo "a=0.7 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.7_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.7_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 44.0
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
echo "a=0.7 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.7_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.7_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
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
echo "a=0.7 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.7_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.8_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.8
V0 = 0.03
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
echo "a=0.8 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.8_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.8_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.8
V0 = 0.05
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
echo "a=0.8 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.8_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.8_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 38.0
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
echo "a=0.8 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.8_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.8_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 19.0
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
echo "a=0.8 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.8_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.9_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.9
V0 = 0.03
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
echo "a=0.9 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.9_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.9_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.9
V0 = 0.05
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
echo "a=0.9 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.9_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.9_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 34.0
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
echo "a=0.9 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.9_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a0.9_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 17.0
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
echo "a=0.9 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a0.9_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.0_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.0
V0 = 0.03
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
echo "a=1.0 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.0_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.0_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.0
V0 = 0.05
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
echo "a=1.0 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.0_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.0_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
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
echo "a=1.0 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.0_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.0_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 15.0
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
echo "a=1.0 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.0_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.1_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.1
V0 = 0.03
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
echo "a=1.1 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.1_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.1_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.1
V0 = 0.05
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
echo "a=1.1 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.1_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.1_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
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
echo "a=1.1 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.1_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.1_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
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
echo "a=1.1 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.1_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.2_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.2
V0 = 0.03
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
echo "a=1.2 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.2_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.2_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 51.0
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
echo "a=1.2 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.2_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.2_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
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
echo "a=1.2 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.2_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.2_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
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
echo "a=1.2 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.2_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.3_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.3
V0 = 0.03
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
echo "a=1.3 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.3_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.3_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 47.0
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
echo "a=1.3 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.3_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.3_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
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
echo "a=1.3 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.3_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.3_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
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
echo "a=1.3 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.3_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.4_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.4
V0 = 0.03
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
echo "a=1.4 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.4_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.4_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 44.0
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
echo "a=1.4 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.4_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.4_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
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
echo "a=1.4 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.4_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.4_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
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
echo "a=1.4 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.4_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.5_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.5
V0 = 0.03
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
echo "a=1.5 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.5_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.5_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 41.0
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
echo "a=1.5 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.5_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.5_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 20.0
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
echo "a=1.5 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.5_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.5_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
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
echo "a=1.5 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.5_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.6_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.6
V0 = 0.03
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
echo "a=1.6 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.6_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.6_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 38.0
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
echo "a=1.6 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.6_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.6_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 19.0
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
echo "a=1.6 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.6_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.6_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
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
echo "a=1.6 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.6_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.7_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.7
V0 = 0.03
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
echo "a=1.7 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.7_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.7_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 36.0
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
echo "a=1.7 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.7_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.7_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
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
echo "a=1.7 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.7_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.7_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
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
echo "a=1.7 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.7_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.8_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.8
V0 = 0.03
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
echo "a=1.8 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.8_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.8_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 34.0
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
echo "a=1.8 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.8_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.8_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 17.0
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
echo "a=1.8 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.8_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.8_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
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
echo "a=1.8 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.8_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.9_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 54.0
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
echo "a=1.9 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.9_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.9_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 32.0
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
echo "a=1.9 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.9_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.9_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 16.0
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
echo "a=1.9 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.9_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a1.9_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
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
echo "a=1.9 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a1.9_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.0_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 51.0
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
echo "a=2.0 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.0_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.0_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
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
echo "a=2.0 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.0_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.0_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 15.0
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
echo "a=2.0 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.0_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.0_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
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
echo "a=2.0 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.0_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.1_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 49.0
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
echo "a=2.1 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.1_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.1_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 29.0
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
echo "a=2.1 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.1_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.1_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
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
echo "a=2.1 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.1_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.1_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
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
echo "a=2.1 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.1_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.2_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 46.0
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
echo "a=2.2 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.2_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.2_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
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
echo "a=2.2 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.2_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.2_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
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
echo "a=2.2 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.2_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.2_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
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
echo "a=2.2 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.2_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.3_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 44.0
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
echo "a=2.3 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.3_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.3_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 26.0
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
echo "a=2.3 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.3_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.3_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
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
echo "a=2.3 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.3_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.3_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
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
echo "a=2.3 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.3_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.4_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 42.0
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
echo "a=2.4 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.4_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.4_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
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
echo "a=2.4 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.4_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.4_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
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
echo "a=2.4 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.4_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.4_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
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
echo "a=2.4 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.4_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.5_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 41.0
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
echo "a=2.5 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.5_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.5_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
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
echo "a=2.5 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.5_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.5_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
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
echo "a=2.5 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.5_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.5_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
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
echo "a=2.5 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.5_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.6_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 39.0
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
echo "a=2.6 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.6_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.6_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
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
echo "a=2.6 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.6_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.6_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
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
echo "a=2.6 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.6_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.6_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
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
echo "a=2.6 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.6_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.7_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 38.0
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
echo "a=2.7 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.7_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.7_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
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
echo "a=2.7 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.7_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.7_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
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
echo "a=2.7 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.7_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.7_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
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
echo "a=2.7 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.7_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.8_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 36.0
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
echo "a=2.8 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.8_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.8_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
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
echo "a=2.8 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.8_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.8_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
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
echo "a=2.8 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.8_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.8_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
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
echo "a=2.8 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.8_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.9_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 35.0
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
echo "a=2.9 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.9_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.9_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
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
echo "a=2.9 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.9_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.9_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
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
echo "a=2.9 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.9_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a2.9_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 2.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
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
echo "a=2.9 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.9_v0.2_kz2.375.ini
echo "done $(date)"

cat > /tmp/a3.0_v0.03_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 34.0
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
echo "a=3.0 V0=0.03 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a3.0_v0.03_kz2.375.ini
echo "done $(date)"

cat > /tmp/a3.0_v0.05_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 20.0
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
echo "a=3.0 V0=0.05 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a3.0_v0.05_kz2.375.ini
echo "done $(date)"

cat > /tmp/a3.0_v0.1_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
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
echo "a=3.0 V0=0.1 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a3.0_v0.1_kz2.375.ini
echo "done $(date)"

cat > /tmp/a3.0_v0.2_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 3.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
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
echo "a=3.0 V0=0.2 kz=2.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a3.0_v0.2_kz2.375.ini
echo "done $(date)"

echo "=== ALL DONE $(date) ==="
