#!/bin/bash
# tachyonic-instability campaign -- t140: 11 runs (2026-07-20)
WDIR=/DATA/cm/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs
LOG=$WDIR/logs/tachyonic_t140_progress.log
echo "=== tachyonic t140 start $(date) ===" >> $LOG
cat > /tmp/tachyonic_smoke_t140.ini <<'EOINI'
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
run_tag = smoketachyt140
EOINI
rm -rf $WDIR/outputs/ym_k2_a1.000*smoketachyt140*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_smoke_t140.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000*smoketachyt140" >> $LOG 2>&1)
python3 - "$WDIR" t140 <<'EOPY' >> $LOG 2>&1 || { echo "[t140] SMOKE TEST FAILED -- stream ABORTED $(date)" >> $LOG; exit 1; }
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
rm -rf $WDIR/outputs/ym_k2_a1.000*smoketachyt140*

cat > /tmp/tachyonic_t140_a1.0_v0.1_kz2.0_sp30.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.0
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
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[t140] a=1.0 V0=0.1 kz=2.0 (tier=int k=2 sp=30.0 tu=60.0 gpred=2.1422) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t140_a1.0_v0.1_kz2.0_sp30.ini >> $LOG 2>&1) || echo "[t140] a=1.0 V0=0.1 kz=2.0 sp=30.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000_*_v0.1000_*_tachyonic" >> $LOG 2>&1)
echo "[t140] a=1.0 V0=0.1 kz=2.0 sp=30.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t140_a1.5_v0.05_kz2.0_sp40.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 40.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[t140] a=1.5 V0=0.05 kz=2.0 (tier=int k=2 sp=40.0 tu=60.0 gpred=2.1658) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t140_a1.5_v0.05_kz2.0_sp40.ini >> $LOG 2>&1) || echo "[t140] a=1.5 V0=0.05 kz=2.0 sp=40.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.500_*_v0.0500_*_tachyonic" >> $LOG 2>&1)
echo "[t140] a=1.5 V0=0.05 kz=2.0 sp=40.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t140_a1.5_v0.1_kz3.0_sp30.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.5
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
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[t140] a=1.5 V0=0.1 kz=3.0 (tier=int k=3 sp=30.0 tu=60.0 gpred=3.2133) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t140_a1.5_v0.1_kz3.0_sp30.ini >> $LOG 2>&1) || echo "[t140] a=1.5 V0=0.1 kz=3.0 sp=30.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.500_*_v0.1000_*_tachyonic" >> $LOG 2>&1)
echo "[t140] a=1.5 V0=0.1 kz=3.0 sp=30.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t140_a2.0_v0.05_kz3.0_sp45.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 45.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[t140] a=2.0 V0=0.05 kz=3.0 (tier=int k=3 sp=45.0 tu=60.0 gpred=3.2605) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t140_a2.0_v0.05_kz3.0_sp45.ini >> $LOG 2>&1) || echo "[t140] a=2.0 V0=0.05 kz=3.0 sp=45.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.000_*_v0.0500_*_tachyonic" >> $LOG 2>&1)
echo "[t140] a=2.0 V0=0.05 kz=3.0 sp=45.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t140_a0.5_v0.05_kz0.5_sp30.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 30.0
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
echo "[t140] a=0.5 V0=0.05 kz=0.5 (tier=half k=1 sp=30.0 tu=60.0 gpred=0.5355) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t140_a0.5_v0.05_kz0.5_sp30.ini >> $LOG 2>&1) || echo "[t140] a=0.5 V0=0.05 kz=0.5 sp=30.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.500_*_v0.0500_*_tachyonic" >> $LOG 2>&1)
echo "[t140] a=0.5 V0=0.05 kz=0.5 sp=30.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t140_a0.5_v0.1_kz1.5_sp45.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.5
V0 = 0.1
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
echo "[t140] a=0.5 V0=0.1 kz=1.5 (tier=half k=3 sp=45.0 tu=60.0 gpred=1.6303) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t140_a0.5_v0.1_kz1.5_sp45.ini >> $LOG 2>&1) || echo "[t140] a=0.5 V0=0.1 kz=1.5 sp=45.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a0.500_*_v0.1000_*_tachyonic" >> $LOG 2>&1)
echo "[t140] a=0.5 V0=0.1 kz=1.5 sp=45.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t140_a1.5_v0.1_kz2.5_sp25.ini <<'EOINI'
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
lz_override = 12.566371
nz_override = 128
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[t140] a=1.5 V0=0.1 kz=2.5 (tier=half k=5 sp=25.0 tu=60.0 gpred=2.654) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t140_a1.5_v0.1_kz2.5_sp25.ini >> $LOG 2>&1) || echo "[t140] a=1.5 V0=0.1 kz=2.5 sp=25.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.500_*_v0.1000_*_tachyonic" >> $LOG 2>&1)
echo "[t140] a=1.5 V0=0.1 kz=2.5 sp=25.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t140_a2.0_v0.05_kz2.5_sp38.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.0
V0 = 0.05
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
echo "[t140] a=2.0 V0=0.05 kz=2.5 (tier=half k=5 sp=38.0 tu=60.0 gpred=2.7691) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t140_a2.0_v0.05_kz2.5_sp38.ini >> $LOG 2>&1) || echo "[t140] a=2.0 V0=0.05 kz=2.5 sp=38.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.000_*_v0.0500_*_tachyonic" >> $LOG 2>&1)
echo "[t140] a=2.0 V0=0.05 kz=2.5 sp=38.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t140_a2.0_v0.08_kz2.5_sp23.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 23.0
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
echo "[t140] a=2.0 V0=0.08 kz=2.5 (tier=half k=5 sp=23.0 tu=60.0 gpred=2.5472) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t140_a2.0_v0.08_kz2.5_sp23.ini >> $LOG 2>&1) || echo "[t140] a=2.0 V0=0.08 kz=2.5 sp=23.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.000_*_v0.0800_*_tachyonic" >> $LOG 2>&1)
echo "[t140] a=2.0 V0=0.08 kz=2.5 sp=23.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t140_a0.5_v0.05_kz0.5_sp24.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 24.0
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
echo "[t140] a=0.5 V0=0.05 kz=0.5 (tier=half k=1 sp=24.0 tu=60.0 gpred=0.2992) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t140_a0.5_v0.05_kz0.5_sp24.ini >> $LOG 2>&1) || echo "[t140] a=0.5 V0=0.05 kz=0.5 sp=24.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.500_*_v0.0500_*_tachyonic" >> $LOG 2>&1)
echo "[t140] a=0.5 V0=0.05 kz=0.5 sp=24.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t140_a1.0_v0.05_kz1.5_sp53.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 53.0
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
echo "[t140] a=1.0 V0=0.05 kz=1.5 (tier=half k=3 sp=53.0 tu=60.0 gpred=2.1424) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t140_a1.0_v0.05_kz1.5_sp53.ini >> $LOG 2>&1) || echo "[t140] a=1.0 V0=0.05 kz=1.5 sp=53.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.000_*_v0.0500_*_tachyonic" >> $LOG 2>&1)
echo "[t140] a=1.0 V0=0.05 kz=1.5 sp=53.0 done $(date)" >> $LOG

echo "=== t140 ALL DONE $(date) ===" >> $LOG
