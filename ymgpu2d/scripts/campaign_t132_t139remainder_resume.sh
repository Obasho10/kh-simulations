#!/bin/bash
# eighth-kz remainder (fine points) on t132 (standing in for unreachable t139): 240 runs
set -e
WDIR=/DATA/ym_kh
mkdir -p $WDIR/logs $WDIR/outputs
echo "=== start $(date) ==="

cat > /tmp/a2.3_v0.1_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.3 V0=0.1 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.3_v0.1_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.3_v0.2_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.3 V0=0.2 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.3_v0.2_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.4_v0.03_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.4 V0=0.03 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.4_v0.03_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.4_v0.05_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.4 V0=0.05 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.4_v0.05_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.4_v0.1_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.4 V0=0.1 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.4_v0.1_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.4_v0.2_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.4 V0=0.2 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.4_v0.2_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.5_v0.03_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.5 V0=0.03 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.5_v0.03_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.5_v0.05_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.5 V0=0.05 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.5_v0.05_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.5_v0.1_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.5 V0=0.1 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.5_v0.1_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.5_v0.2_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.5 V0=0.2 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.5_v0.2_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.6_v0.03_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.6 V0=0.03 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.6_v0.03_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.6_v0.05_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.6 V0=0.05 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.6_v0.05_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.6_v0.1_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.6 V0=0.1 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.6_v0.1_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.6_v0.2_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.6 V0=0.2 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.6_v0.2_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.7_v0.03_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.7 V0=0.03 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.7_v0.03_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.7_v0.05_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.7 V0=0.05 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.7_v0.05_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.7_v0.1_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.7 V0=0.1 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.7_v0.1_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.7_v0.2_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.7 V0=0.2 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.7_v0.2_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.8_v0.03_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 21.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.8 V0=0.03 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.8_v0.03_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.8_v0.05_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.8 V0=0.05 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.8_v0.05_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.8_v0.1_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.8 V0=0.1 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.8_v0.1_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.8_v0.2_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.8 V0=0.2 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.8_v0.2_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.9_v0.03_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 20.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.9 V0=0.03 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.9_v0.03_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.9_v0.05_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.9 V0=0.05 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.9_v0.05_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.9_v0.1_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.9 V0=0.1 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.9_v0.1_kz1.375.ini
echo "done $(date)"

cat > /tmp/a2.9_v0.2_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=2.9 V0=0.2 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a2.9_v0.2_kz1.375.ini
echo "done $(date)"

cat > /tmp/a3.0_v0.03_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 19.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=3.0 V0=0.03 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a3.0_v0.03_kz1.375.ini
echo "done $(date)"

cat > /tmp/a3.0_v0.05_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=3.0 V0=0.05 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a3.0_v0.05_kz1.375.ini
echo "done $(date)"

cat > /tmp/a3.0_v0.1_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=3.0 V0=0.1 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a3.0_v0.1_kz1.375.ini
echo "done $(date)"

cat > /tmp/a3.0_v0.2_kz1.375.ini <<'EOINI'
k_mode = 11
alpha_YM = 3.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 55
target_tu = 50
lz_override = 50.2654824574
nz_override = 512
EOINI
echo "a=3.0 V0=0.2 kz=1.375 start $(date)"
cd $WDIR/outputs && $WDIR/ym_coupled /tmp/a3.0_v0.2_kz1.375.ini
echo "done $(date)"

echo "=== ALL DONE $(date) ==="
echo "=== ALL DONE $(date) ==="
