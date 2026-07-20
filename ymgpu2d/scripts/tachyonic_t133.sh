#!/bin/bash
# tachyonic-instability campaign -- t133: 11 runs (2026-07-20)
WDIR=/DATA/ym_kh/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs
LOG=$WDIR/logs/tachyonic_t133_progress.log
echo "=== tachyonic t133 start $(date) ===" >> $LOG
cat > /tmp/tachyonic_smoke_t133.ini <<'EOINI'
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
run_tag = smoketachyt133
EOINI
rm -rf $WDIR/outputs/ym_k2_a1.000*smoketachyt133*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_smoke_t133.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000*smoketachyt133" >> $LOG 2>&1)
python3 - "$WDIR" t133 <<'EOPY' >> $LOG 2>&1 || { echo "[t133] SMOKE TEST FAILED -- stream ABORTED $(date)" >> $LOG; exit 1; }
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
rm -rf $WDIR/outputs/ym_k2_a1.000*smoketachyt133*

cat > /tmp/tachyonic_t133_a1.0_v0.1_kz3.0_sp45.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.0
V0 = 0.1
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
echo "[t133] a=1.0 V0=0.1 kz=3.0 (tier=int k=3 sp=45.0 tu=60.0 gpred=3.2605) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t133_a1.0_v0.1_kz3.0_sp45.ini >> $LOG 2>&1) || echo "[t133] a=1.0 V0=0.1 kz=3.0 sp=45.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.000_*_v0.1000_*_tachyonic" >> $LOG 2>&1)
echo "[t133] a=1.0 V0=0.1 kz=3.0 sp=45.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t133_a1.5_v0.1_kz2.0_sp20.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 20.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[t133] a=1.5 V0=0.1 kz=2.0 (tier=int k=2 sp=20.0 tu=60.0 gpred=2.0945) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t133_a1.5_v0.1_kz2.0_sp20.ini >> $LOG 2>&1) || echo "[t133] a=1.5 V0=0.1 kz=2.0 sp=20.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.500_*_v0.1000_*_tachyonic" >> $LOG 2>&1)
echo "[t133] a=1.5 V0=0.1 kz=2.0 sp=20.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t133_a2.0_v0.05_kz2.0_sp30.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.0
V0 = 0.05
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
echo "[t133] a=2.0 V0=0.05 kz=2.0 (tier=int k=2 sp=30.0 tu=60.0 gpred=2.1422) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t133_a2.0_v0.05_kz2.0_sp30.ini >> $LOG 2>&1) || echo "[t133] a=2.0 V0=0.05 kz=2.0 sp=30.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.000_*_v0.0500_*_tachyonic" >> $LOG 2>&1)
echo "[t133] a=2.0 V0=0.05 kz=2.0 sp=30.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t133_a2.0_v0.1_kz3.0_sp22.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.0
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
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[t133] a=2.0 V0=0.1 kz=3.0 (tier=int k=3 sp=22.0 tu=60.0 gpred=3.0264) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t133_a2.0_v0.1_kz3.0_sp22.ini >> $LOG 2>&1) || echo "[t133] a=2.0 V0=0.1 kz=3.0 sp=22.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.000_*_v0.1000_*_tachyonic" >> $LOG 2>&1)
echo "[t133] a=2.0 V0=0.1 kz=3.0 sp=22.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t133_a0.3_v0.1_kz0.5_sp25.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.3
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
lz_override = 12.566371
nz_override = 128
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[t133] a=0.3 V0=0.1 kz=0.5 (tier=half k=1 sp=25.0 tu=60.0 gpred=0.5308) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t133_a0.3_v0.1_kz0.5_sp25.ini >> $LOG 2>&1) || echo "[t133] a=0.3 V0=0.1 kz=0.5 sp=25.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.300_*_v0.1000_*_tachyonic" >> $LOG 2>&1)
echo "[t133] a=0.3 V0=0.1 kz=0.5 sp=25.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t133_a1.0_v0.03_kz0.5_sp25.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
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
echo "[t133] a=1.0 V0=0.03 kz=0.5 (tier=half k=1 sp=25.0 tu=60.0 gpred=0.5308) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t133_a1.0_v0.03_kz0.5_sp25.ini >> $LOG 2>&1) || echo "[t133] a=1.0 V0=0.03 kz=0.5 sp=25.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.000_*_v0.0300_*_tachyonic" >> $LOG 2>&1)
echo "[t133] a=1.0 V0=0.03 kz=0.5 sp=25.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t133_a1.0_v0.1_kz1.5_sp22.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.0
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
lz_override = 12.566371
nz_override = 128
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[t133] a=1.0 V0=0.1 kz=1.5 (tier=half k=3 sp=22.0 tu=60.0 gpred=1.5132) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t133_a1.0_v0.1_kz1.5_sp22.ini >> $LOG 2>&1) || echo "[t133] a=1.0 V0=0.1 kz=1.5 sp=22.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.000_*_v0.1000_*_tachyonic" >> $LOG 2>&1)
echo "[t133] a=1.0 V0=0.1 kz=1.5 sp=22.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t133_a2.0_v0.03_kz1.5_sp38.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.0
V0 = 0.03
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
echo "[t133] a=2.0 V0=0.03 kz=1.5 (tier=half k=3 sp=38.0 tu=60.0 gpred=1.6615) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t133_a2.0_v0.03_kz1.5_sp38.ini >> $LOG 2>&1) || echo "[t133] a=2.0 V0=0.03 kz=1.5 sp=38.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.000_*_v0.0300_*_tachyonic" >> $LOG 2>&1)
echo "[t133] a=2.0 V0=0.03 kz=1.5 sp=38.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t133_a2.0_v0.1_kz2.5_sp19.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 19.0
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
echo "[t133] a=2.0 V0=0.1 kz=2.5 (tier=half k=5 sp=19.0 tu=60.0 gpred=2.675) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t133_a2.0_v0.1_kz2.5_sp19.ini >> $LOG 2>&1) || echo "[t133] a=2.0 V0=0.1 kz=2.5 sp=19.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.000_*_v0.1000_*_tachyonic" >> $LOG 2>&1)
echo "[t133] a=2.0 V0=0.1 kz=2.5 sp=19.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t133_a0.5_v0.05_kz0.5_sp50.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 50.0
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
echo "[t133] a=0.5 V0=0.05 kz=0.5 (tier=half k=1 sp=50.0 tu=60.0 gpred=1.1267) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t133_a0.5_v0.05_kz0.5_sp50.ini >> $LOG 2>&1) || echo "[t133] a=0.5 V0=0.05 kz=0.5 sp=50.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.500_*_v0.0500_*_tachyonic" >> $LOG 2>&1)
echo "[t133] a=0.5 V0=0.05 kz=0.5 sp=50.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t133_a1.0_v0.05_kz1.5_sp44.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 44.0
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
echo "[t133] a=1.0 V0=0.05 kz=1.5 (tier=half k=3 sp=44.0 tu=60.0 gpred=1.5616) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t133_a1.0_v0.05_kz1.5_sp44.ini >> $LOG 2>&1) || echo "[t133] a=1.0 V0=0.05 kz=1.5 sp=44.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.000_*_v0.0500_*_tachyonic" >> $LOG 2>&1)
echo "[t133] a=1.0 V0=0.05 kz=1.5 sp=44.0 done $(date)" >> $LOG

echo "=== t133 ALL DONE $(date) ===" >> $LOG
