#!/bin/bash
# tachyonic-instability campaign -- t126: 11 runs (2026-07-20)
WDIR=/DATA/cm/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs
LOG=$WDIR/logs/tachyonic_t126_progress.log
echo "=== tachyonic t126 start $(date) ===" >> $LOG
cat > /tmp/tachyonic_smoke_t126.ini <<'EOINI'
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
run_tag = smoketachyt126
EOINI
rm -rf $WDIR/outputs/ym_k2_a1.000*smoketachyt126*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_smoke_t126.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000*smoketachyt126" >> $LOG 2>&1)
python3 - "$WDIR" t126 <<'EOPY' >> $LOG 2>&1 || { echo "[t126] SMOKE TEST FAILED -- stream ABORTED $(date)" >> $LOG; exit 1; }
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
rm -rf $WDIR/outputs/ym_k2_a1.000*smoketachyt126*

cat > /tmp/tachyonic_t126_a1.0_v0.08_kz1.0_sp19.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 19.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[t126] a=1.0 V0=0.08 kz=1.0 (tier=int k=1 sp=19.0 tu=60.0 gpred=1.07) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t126_a1.0_v0.08_kz1.0_sp19.ini >> $LOG 2>&1) || echo "[t126] a=1.0 V0=0.08 kz=1.0 sp=19.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.000_*_v0.0800_*_tachyonic" >> $LOG 2>&1)
echo "[t126] a=1.0 V0=0.08 kz=1.0 sp=19.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t126_a1.0_v0.08_kz2.0_sp38.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 38.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[t126] a=1.0 V0=0.08 kz=2.0 (tier=int k=2 sp=38.0 tu=60.0 gpred=2.2153) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t126_a1.0_v0.08_kz2.0_sp38.ini >> $LOG 2>&1) || echo "[t126] a=1.0 V0=0.08 kz=2.0 sp=38.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000_*_v0.0800_*_tachyonic" >> $LOG 2>&1)
echo "[t126] a=1.0 V0=0.08 kz=2.0 sp=38.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t126_a1.5_v0.03_kz1.0_sp33.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 33.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[t126] a=1.5 V0=0.03 kz=1.0 (tier=int k=1 sp=33.0 tu=60.0 gpred=1.0553) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t126_a1.5_v0.03_kz1.0_sp33.ini >> $LOG 2>&1) || echo "[t126] a=1.5 V0=0.03 kz=1.0 sp=33.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.500_*_v0.0300_*_tachyonic" >> $LOG 2>&1)
echo "[t126] a=1.5 V0=0.03 kz=1.0 sp=33.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t126_a2.0_v0.03_kz1.0_sp25.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 25.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 60.0
run_tag = tachyonic
EOINI
echo "[t126] a=2.0 V0=0.03 kz=1.0 (tier=int k=1 sp=25.0 tu=60.0 gpred=1.0616) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t126_a2.0_v0.03_kz1.0_sp25.ini >> $LOG 2>&1) || echo "[t126] a=2.0 V0=0.03 kz=1.0 sp=25.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.000_*_v0.0300_*_tachyonic" >> $LOG 2>&1)
echo "[t126] a=2.0 V0=0.03 kz=1.0 sp=25.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t126_a0.3_v0.08_kz0.5_sp31.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.3
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 31.0
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
echo "[t126] a=0.3 V0=0.08 kz=0.5 (tier=half k=1 sp=31.0 tu=60.0 gpred=0.5283) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t126_a0.3_v0.08_kz0.5_sp31.ini >> $LOG 2>&1) || echo "[t126] a=0.3 V0=0.08 kz=0.5 sp=31.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.300_*_v0.0800_*_tachyonic" >> $LOG 2>&1)
echo "[t126] a=0.3 V0=0.08 kz=0.5 sp=31.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t126_a0.5_v0.08_kz0.5_sp19.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 19.0
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
echo "[t126] a=0.5 V0=0.08 kz=0.5 (tier=half k=1 sp=19.0 tu=60.0 gpred=0.535) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t126_a0.5_v0.08_kz0.5_sp19.ini >> $LOG 2>&1) || echo "[t126] a=0.5 V0=0.08 kz=0.5 sp=19.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.500_*_v0.0800_*_tachyonic" >> $LOG 2>&1)
echo "[t126] a=0.5 V0=0.08 kz=0.5 sp=19.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t126_a1.0_v0.08_kz1.5_sp28.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 28.0
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
echo "[t126] a=1.0 V0=0.08 kz=1.5 (tier=half k=3 sp=28.0 tu=60.0 gpred=1.5882) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t126_a1.0_v0.08_kz1.5_sp28.ini >> $LOG 2>&1) || echo "[t126] a=1.0 V0=0.08 kz=1.5 sp=28.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.000_*_v0.0800_*_tachyonic" >> $LOG 2>&1)
echo "[t126] a=1.0 V0=0.08 kz=1.5 sp=28.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t126_a2.0_v0.05_kz1.5_sp22.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.0
V0 = 0.05
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
echo "[t126] a=2.0 V0=0.05 kz=1.5 (tier=half k=3 sp=22.0 tu=60.0 gpred=1.5132) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t126_a2.0_v0.05_kz1.5_sp22.ini >> $LOG 2>&1) || echo "[t126] a=2.0 V0=0.05 kz=1.5 sp=22.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.000_*_v0.0500_*_tachyonic" >> $LOG 2>&1)
echo "[t126] a=2.0 V0=0.05 kz=1.5 sp=22.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t126_a0.5_v0.05_kz0.5_sp42.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 42.0
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
echo "[t126] a=0.5 V0=0.05 kz=0.5 (tier=half k=1 sp=42.0 tu=60.0 gpred=0.9036) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t126_a0.5_v0.05_kz0.5_sp42.ini >> $LOG 2>&1) || echo "[t126] a=0.5 V0=0.05 kz=0.5 sp=42.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.500_*_v0.0500_*_tachyonic" >> $LOG 2>&1)
echo "[t126] a=0.5 V0=0.05 kz=0.5 sp=42.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t126_a1.0_v0.05_kz1.5_sp33.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 33.0
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
echo "[t126] a=1.0 V0=0.05 kz=1.5 (tier=half k=3 sp=33.0 tu=60.0 gpred=0.5994) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t126_a1.0_v0.05_kz1.5_sp33.ini >> $LOG 2>&1) || echo "[t126] a=1.0 V0=0.05 kz=1.5 sp=33.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.000_*_v0.0500_*_tachyonic" >> $LOG 2>&1)
echo "[t126] a=1.0 V0=0.05 kz=1.5 sp=33.0 done $(date)" >> $LOG

cat > /tmp/tachyonic_t126_a1.0_v0.05_kz1.5_sp49.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 49.0
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
echo "[t126] a=1.0 V0=0.05 kz=1.5 (tier=half k=3 sp=49.0 tu=60.0 gpred=1.8931) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_t126_a1.0_v0.05_kz1.5_sp49.ini >> $LOG 2>&1) || echo "[t126] a=1.0 V0=0.05 kz=1.5 sp=49.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.000_*_v0.0500_*_tachyonic" >> $LOG 2>&1)
echo "[t126] a=1.0 V0=0.05 kz=1.5 sp=49.0 done $(date)" >> $LOG

echo "=== t126 ALL DONE $(date) ===" >> $LOG
