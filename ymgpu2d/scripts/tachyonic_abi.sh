#!/bin/bash
# tachyonic-instability campaign -- abi (3 GPUs, 2026-07-20)
WDIR=/DATA/s23103/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs

run_gpu0() {
    export CUDA_VISIBLE_DEVICES=0
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/tachyonic_abi0_progress.log
echo "=== tachyonic abi0 start $(date) ===" >> $LOG
cat > /tmp/tachyonic_smoke_abi0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 2
run_tag = smoketachyabi0
EOINI
rm -rf $WDIR/outputs/ym_k2_a1.000*smoketachyabi0*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_smoke_abi0.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000*smoketachyabi0" >> $LOG 2>&1)
python3 - "$WDIR" abi0 <<'EOPY' >> $LOG 2>&1 || { echo "[abi0] SMOKE TEST FAILED -- stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, math, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k2_a1.000*smoketachy" + stream + "*/timeseries_k2.csv")
assert fs, "smoke: no timeseries written"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert rows and 'amp_conj' in rows[0], "smoke: extractor is not the fixed version"
a0 = float(rows[0]['amp'])
assert a0 > 0 and math.log(a0) > -20, "smoke: seed missing from measured channel (logamp=%.1f)" % (math.log(a0) if a0 > 0 else -99)
print("[%s] smoke test OK: logamp0=%.1f" % (stream, math.log(a0)))
EOPY
rm -rf $WDIR/outputs/ym_k2_a1.000*smoketachyabi0*

cat > /tmp/tachyonic_abi0_a0.5_v0.1_kz1.0_sp30.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
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
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[abi0] a=0.5 V0=0.1 kz=1.0 (tier=int k=1 sp=30.0 tu=60.0 gpred=1.0711) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_abi0_a0.5_v0.1_kz1.0_sp30.ini >> $LOG 2>&1) || echo "[abi0] a=0.5 V0=0.1 kz=1.0 sp=30.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.500_*_v0.1000_*_tachyonic" >> $LOG 2>&1)
echo "[abi0] a=0.5 V0=0.1 kz=1.0 sp=30.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_abi0_a1.5_v0.05_kz1.0_sp20.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 20.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[abi0] a=1.5 V0=0.05 kz=1.0 (tier=int k=1 sp=20.0 tu=60.0 gpred=1.0473) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_abi0_a1.5_v0.05_kz1.0_sp20.ini >> $LOG 2>&1) || echo "[abi0] a=1.5 V0=0.05 kz=1.0 sp=20.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.500_*_v0.0500_*_tachyonic" >> $LOG 2>&1)
echo "[abi0] a=1.5 V0=0.05 kz=1.0 sp=20.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_abi0_a2.0_v0.08_kz2.0_sp19.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 19.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[abi0] a=2.0 V0=0.08 kz=2.0 (tier=int k=2 sp=19.0 tu=60.0 gpred=2.14) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_abi0_a2.0_v0.08_kz2.0_sp19.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.08 kz=2.0 sp=19.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.000_*_v0.0800_*_tachyonic" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.08 kz=2.0 sp=19.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_abi0_a1.0_v0.05_kz1.5_sp45.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 45.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[abi0] a=1.0 V0=0.05 kz=1.5 (tier=half k=3 sp=45.0 tu=60.0 gpred=1.6303) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_abi0_a1.0_v0.05_kz1.5_sp45.ini >> $LOG 2>&1) || echo "[abi0] a=1.0 V0=0.05 kz=1.5 sp=45.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.000_*_v0.0500_*_tachyonic" >> $LOG 2>&1)
echo "[abi0] a=1.0 V0=0.05 kz=1.5 sp=45.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_abi0_a1.5_v0.08_kz2.5_sp31.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.5
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 31.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[abi0] a=1.5 V0=0.08 kz=2.5 (tier=half k=5 sp=31.0 tu=60.0 gpred=2.6413) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_abi0_a1.5_v0.08_kz2.5_sp31.ini >> $LOG 2>&1) || echo "[abi0] a=1.5 V0=0.08 kz=2.5 sp=31.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.500_*_v0.0800_*_tachyonic" >> $LOG 2>&1)
echo "[abi0] a=1.5 V0=0.08 kz=2.5 sp=31.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_abi0_a0.5_v0.05_kz0.5_sp29.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 29.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[abi0] a=0.5 V0=0.05 kz=0.5 (tier=half k=1 sp=29.0 tu=60.0 gpred=0.5008) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_abi0_a0.5_v0.05_kz0.5_sp29.ini >> $LOG 2>&1) || echo "[abi0] a=0.5 V0=0.05 kz=0.5 sp=29.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.500_*_v0.0500_*_tachyonic" >> $LOG 2>&1)
echo "[abi0] a=0.5 V0=0.05 kz=0.5 sp=29.0 done $(date)" >> $LOG

echo "=== abi0 ALL DONE $(date) ===" >> $LOG
}

run_gpu1() {
    export CUDA_VISIBLE_DEVICES=1
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/tachyonic_abi1_progress.log
echo "=== tachyonic abi1 start $(date) ===" >> $LOG
cat > /tmp/tachyonic_smoke_abi1.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 2
run_tag = smoketachyabi1
EOINI
rm -rf $WDIR/outputs/ym_k2_a1.000*smoketachyabi1*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_smoke_abi1.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000*smoketachyabi1" >> $LOG 2>&1)
python3 - "$WDIR" abi1 <<'EOPY' >> $LOG 2>&1 || { echo "[abi1] SMOKE TEST FAILED -- stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, math, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k2_a1.000*smoketachy" + stream + "*/timeseries_k2.csv")
assert fs, "smoke: no timeseries written"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert rows and 'amp_conj' in rows[0], "smoke: extractor is not the fixed version"
a0 = float(rows[0]['amp'])
assert a0 > 0 and math.log(a0) > -20, "smoke: seed missing from measured channel (logamp=%.1f)" % (math.log(a0) if a0 > 0 else -99)
print("[%s] smoke test OK: logamp0=%.1f" % (stream, math.log(a0)))
EOPY
rm -rf $WDIR/outputs/ym_k2_a1.000*smoketachyabi1*

cat > /tmp/tachyonic_abi1_a0.5_v0.08_kz1.0_sp38.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 38.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[abi1] a=0.5 V0=0.08 kz=1.0 (tier=int k=1 sp=38.0 tu=60.0 gpred=1.1076) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_abi1_a0.5_v0.08_kz1.0_sp38.ini >> $LOG 2>&1) || echo "[abi1] a=0.5 V0=0.08 kz=1.0 sp=38.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.500_*_v0.0800_*_tachyonic" >> $LOG 2>&1)
echo "[abi1] a=0.5 V0=0.08 kz=1.0 sp=38.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_abi1_a1.5_v0.08_kz2.0_sp25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.5
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[abi1] a=1.5 V0=0.08 kz=2.0 (tier=int k=2 sp=25.0 tu=60.0 gpred=2.1232) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_abi1_a1.5_v0.08_kz2.0_sp25.ini >> $LOG 2>&1) || echo "[abi1] a=1.5 V0=0.08 kz=2.0 sp=25.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.500_*_v0.0800_*_tachyonic" >> $LOG 2>&1)
echo "[abi1] a=1.5 V0=0.08 kz=2.0 sp=25.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_abi1_a2.0_v0.08_kz3.0_sp28.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[abi1] a=2.0 V0=0.08 kz=3.0 (tier=int k=3 sp=28.0 tu=60.0 gpred=3.1763) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_abi1_a2.0_v0.08_kz3.0_sp28.ini >> $LOG 2>&1) || echo "[abi1] a=2.0 V0=0.08 kz=3.0 sp=28.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.000_*_v0.0800_*_tachyonic" >> $LOG 2>&1)
echo "[abi1] a=2.0 V0=0.08 kz=3.0 sp=28.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_abi1_a1.0_v0.1_kz2.5_sp38.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 38.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[abi1] a=1.0 V0=0.1 kz=2.5 (tier=half k=5 sp=38.0 tu=60.0 gpred=2.7691) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_abi1_a1.0_v0.1_kz2.5_sp38.ini >> $LOG 2>&1) || echo "[abi1] a=1.0 V0=0.1 kz=2.5 sp=38.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.000_*_v0.1000_*_tachyonic" >> $LOG 2>&1)
echo "[abi1] a=1.0 V0=0.1 kz=2.5 sp=38.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_abi1_a1.5_v0.08_kz1.5_sp19.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.5
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 19.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[abi1] a=1.5 V0=0.08 kz=1.5 (tier=half k=3 sp=19.0 tu=60.0 gpred=1.605) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_abi1_a1.5_v0.08_kz1.5_sp19.ini >> $LOG 2>&1) || echo "[abi1] a=1.5 V0=0.08 kz=1.5 sp=19.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.500_*_v0.0800_*_tachyonic" >> $LOG 2>&1)
echo "[abi1] a=1.5 V0=0.08 kz=1.5 sp=19.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_abi1_a1.0_v0.05_kz1.5_sp38.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 38.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[abi1] a=1.0 V0=0.05 kz=1.5 (tier=half k=3 sp=38.0 tu=60.0 gpred=1.1088) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_abi1_a1.0_v0.05_kz1.5_sp38.ini >> $LOG 2>&1) || echo "[abi1] a=1.0 V0=0.05 kz=1.5 sp=38.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.000_*_v0.0500_*_tachyonic" >> $LOG 2>&1)
echo "[abi1] a=1.0 V0=0.05 kz=1.5 sp=38.0 done $(date)" >> $LOG

echo "=== abi1 ALL DONE $(date) ===" >> $LOG
}

run_gpu2() {
    export CUDA_VISIBLE_DEVICES=2
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/tachyonic_abi2_progress.log
echo "=== tachyonic abi2 start $(date) ===" >> $LOG
cat > /tmp/tachyonic_smoke_abi2.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 2
run_tag = smoketachyabi2
EOINI
rm -rf $WDIR/outputs/ym_k2_a1.000*smoketachyabi2*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_smoke_abi2.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000*smoketachyabi2" >> $LOG 2>&1)
python3 - "$WDIR" abi2 <<'EOPY' >> $LOG 2>&1 || { echo "[abi2] SMOKE TEST FAILED -- stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, math, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k2_a1.000*smoketachy" + stream + "*/timeseries_k2.csv")
assert fs, "smoke: no timeseries written"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert rows and 'amp_conj' in rows[0], "smoke: extractor is not the fixed version"
a0 = float(rows[0]['amp'])
assert a0 > 0 and math.log(a0) > -20, "smoke: seed missing from measured channel (logamp=%.1f)" % (math.log(a0) if a0 > 0 else -99)
print("[%s] smoke test OK: logamp0=%.1f" % (stream, math.log(a0)))
EOPY
rm -rf $WDIR/outputs/ym_k2_a1.000*smoketachyabi2*

cat > /tmp/tachyonic_abi2_a1.0_v0.05_kz1.0_sp30.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[abi2] a=1.0 V0=0.05 kz=1.0 (tier=int k=1 sp=30.0 tu=60.0 gpred=1.0711) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_abi2_a1.0_v0.05_kz1.0_sp30.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.05 kz=1.0 sp=30.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.000_*_v0.0500_*_tachyonic" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.05 kz=1.0 sp=30.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_abi2_a1.5_v0.08_kz3.0_sp38.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.5
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 38.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[abi2] a=1.5 V0=0.08 kz=3.0 (tier=int k=3 sp=38.0 tu=60.0 gpred=3.3229) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_abi2_a1.5_v0.08_kz3.0_sp38.ini >> $LOG 2>&1) || echo "[abi2] a=1.5 V0=0.08 kz=3.0 sp=38.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.500_*_v0.0800_*_tachyonic" >> $LOG 2>&1)
echo "[abi2] a=1.5 V0=0.08 kz=3.0 sp=38.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_abi2_a1.0_v0.08_kz2.5_sp47.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 47.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[abi2] a=1.0 V0=0.08 kz=2.5 (tier=half k=5 sp=47.0 tu=60.0 gpred=2.7338) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_abi2_a1.0_v0.08_kz2.5_sp47.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.08 kz=2.5 sp=47.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.000_*_v0.0800_*_tachyonic" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.08 kz=2.5 sp=47.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_abi2_a1.5_v0.05_kz1.5_sp30.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[abi2] a=1.5 V0=0.05 kz=1.5 (tier=half k=3 sp=30.0 tu=60.0 gpred=1.6066) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_abi2_a1.5_v0.05_kz1.5_sp30.ini >> $LOG 2>&1) || echo "[abi2] a=1.5 V0=0.05 kz=1.5 sp=30.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.500_*_v0.0500_*_tachyonic" >> $LOG 2>&1)
echo "[abi2] a=1.5 V0=0.05 kz=1.5 sp=30.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_abi2_a0.5_v0.05_kz0.5_sp35.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 35.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[abi2] a=0.5 V0=0.05 kz=0.5 (tier=half k=1 sp=35.0 tu=60.0 gpred=0.6969) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_abi2_a0.5_v0.05_kz0.5_sp35.ini >> $LOG 2>&1) || echo "[abi2] a=0.5 V0=0.05 kz=0.5 sp=35.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.500_*_v0.0500_*_tachyonic" >> $LOG 2>&1)
echo "[abi2] a=0.5 V0=0.05 kz=0.5 sp=35.0 done $(date)" >> $LOG

echo "=== abi2 ALL DONE $(date) ===" >> $LOG
}

echo "=== abi: launching 3-GPU tachyonic campaign $(date) ==="
run_gpu0 & PID0=$!
run_gpu1 & PID1=$!
run_gpu2 & PID2=$!
wait $PID0 && echo 'GPU0 finished' || echo 'GPU0 FAILED'
wait $PID1 && echo 'GPU1 finished' || echo 'GPU1 FAILED'
wait $PID2 && echo 'GPU2 finished' || echo 'GPU2 FAILED'
