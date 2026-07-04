#!/bin/bash
# Half-kz gap-fill wave 2: V0=0.2, 1 runs
set -e
mkdir -p logs outputs
echo "=== start $(date) ==="

cat > /tmp/a0.5_v0.2_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
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
echo "a=0.5 V0=0.2 kz_phys=1.5 start $(date)"
cd /DATA/cm/lcpfct/ymgpu2d/outputs && /DATA/cm/lcpfct/ymgpu2d/ym_coupled /tmp/a0.5_v0.2_kz1.5.ini
echo "a=0.5 V0=0.2 kz_phys=1.5 done $(date)"

echo "=== ALL DONE $(date) ==="
