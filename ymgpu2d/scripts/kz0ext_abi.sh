#!/bin/bash
# kz=0 growth-rate extension -- abi (3 GPUs, staged 2026-07-19)
WDIR=/DATA/s23103/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs

run_gpu0() {
    export CUDA_VISIBLE_DEVICES=0
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/kz0ext_abi0_progress.log
    echo "=== kz0ext abi0 start $(date) ===" >> $LOG
# ---- smoke test: k_mode=0 uniform seed + suppress_kz0=0 path + extractor ----
cat > /tmp/kz0ext_smoke_abi0.ini <<'EOINI'
k_mode = 0
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 2
run_tag = smokeabi0
EOINI
rm -rf $WDIR/outputs/ym_k0_a2.000*smokeabi0*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_smoke_abi0.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a2.000*smokeabi0" >> $LOG 2>&1)
python3 - "$WDIR" abi0 <<'EOPY' >> $LOG 2>&1 || { echo "[abi0] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, math, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k0_a2.000*smoke" + stream + "*/timeseries_k0.csv")
assert fs, "smoke: no timeseries written (k_mode=0 path likely broken)"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert rows and 'amp_conj' in rows[0], "smoke: extractor is not the fixed version"
a0 = float(rows[0]['amp'])
assert a0 > 0 and math.log(a0) > -20, "smoke: kz=0 seed missing (logamp=%.1f)" % (math.log(a0) if a0 > 0 else -99)
print("[%s] smoke test OK (kz=0 uniform seed + suppress_kz0=0 path): logamp0=%.1f" % (stream, math.log(a0)))
EOPY
rm -rf $WDIR/outputs/ym_k0_a2.000*smokeabi0*

cat > /tmp/kz0ext_abi0_a0.5_v0.01.ini <<'EOINI'
k_mode = 0
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 127.6
run_tag = kz0ext
EOINI
echo "[abi0] a=0.5 V0=0.01 kz=0 (tu=127.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a0.5_v0.01.ini >> $LOG 2>&1) || echo "[abi0] a=0.5 V0=0.01 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a0.500_*_v0.0100_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=0.5 V0=0.01 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a0.5_v0.08.ini <<'EOINI'
k_mode = 0
alpha_YM = 0.5
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=0.5 V0=0.08 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a0.5_v0.08.ini >> $LOG 2>&1) || echo "[abi0] a=0.5 V0=0.08 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a0.500_*_v0.0800_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=0.5 V0=0.08 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a1.0_v0.01.ini <<'EOINI'
k_mode = 0
alpha_YM = 1.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=1.0 V0=0.01 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a1.0_v0.01.ini >> $LOG 2>&1) || echo "[abi0] a=1.0 V0=0.01 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a1.000_*_v0.0100_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=1.0 V0=0.01 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a1.0_v0.05.ini <<'EOINI'
k_mode = 0
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=1.0 V0=0.05 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a1.0_v0.05.ini >> $LOG 2>&1) || echo "[abi0] a=1.0 V0=0.05 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a1.000_*_v0.0500_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=1.0 V0=0.05 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a1.0_v0.1.ini <<'EOINI'
k_mode = 0
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=1.0 V0=0.1 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a1.0_v0.1.ini >> $LOG 2>&1) || echo "[abi0] a=1.0 V0=0.1 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a1.000_*_v0.1000_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=1.0 V0=0.1 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a1.5_v0.02.ini <<'EOINI'
k_mode = 0
alpha_YM = 1.5
V0 = 0.02
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=1.5 V0=0.02 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a1.5_v0.02.ini >> $LOG 2>&1) || echo "[abi0] a=1.5 V0=0.02 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a1.500_*_v0.0200_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=1.5 V0=0.02 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a1.5_v0.07.ini <<'EOINI'
k_mode = 0
alpha_YM = 1.5
V0 = 0.07
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=1.5 V0=0.07 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a1.5_v0.07.ini >> $LOG 2>&1) || echo "[abi0] a=1.5 V0=0.07 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a1.500_*_v0.0700_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=1.5 V0=0.07 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a1.5_v0.2.ini <<'EOINI'
k_mode = 0
alpha_YM = 1.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=1.5 V0=0.2 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a1.5_v0.2.ini >> $LOG 2>&1) || echo "[abi0] a=1.5 V0=0.2 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a1.500_*_v0.2000_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=1.5 V0=0.2 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a2.0_v0.03.ini <<'EOINI'
k_mode = 0
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=2.0 V0=0.03 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a2.0_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.03 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a2.000_*_v0.0300_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.03 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a2.0_v0.08.ini <<'EOINI'
k_mode = 0
alpha_YM = 2.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=2.0 V0=0.08 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a2.0_v0.08.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.08 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a2.000_*_v0.0800_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.08 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a2.5_v0.01.ini <<'EOINI'
k_mode = 0
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=2.5 V0=0.01 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a2.5_v0.01.ini >> $LOG 2>&1) || echo "[abi0] a=2.5 V0=0.01 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a2.500_*_v0.0100_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=2.5 V0=0.01 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a2.5_v0.05.ini <<'EOINI'
k_mode = 0
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=2.5 V0=0.05 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a2.5_v0.05.ini >> $LOG 2>&1) || echo "[abi0] a=2.5 V0=0.05 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a2.500_*_v0.0500_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=2.5 V0=0.05 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a2.5_v0.1.ini <<'EOINI'
k_mode = 0
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=2.5 V0=0.1 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a2.5_v0.1.ini >> $LOG 2>&1) || echo "[abi0] a=2.5 V0=0.1 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a2.500_*_v0.1000_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=2.5 V0=0.1 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a3.0_v0.02.ini <<'EOINI'
k_mode = 0
alpha_YM = 3.0
V0 = 0.02
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=3.0 V0=0.02 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a3.0_v0.02.ini >> $LOG 2>&1) || echo "[abi0] a=3.0 V0=0.02 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a3.000_*_v0.0200_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=3.0 V0=0.02 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a3.0_v0.07.ini <<'EOINI'
k_mode = 0
alpha_YM = 3.0
V0 = 0.07
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=3.0 V0=0.07 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a3.0_v0.07.ini >> $LOG 2>&1) || echo "[abi0] a=3.0 V0=0.07 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a3.000_*_v0.0700_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=3.0 V0=0.07 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a3.0_v0.2.ini <<'EOINI'
k_mode = 0
alpha_YM = 3.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=3.0 V0=0.2 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a3.0_v0.2.ini >> $LOG 2>&1) || echo "[abi0] a=3.0 V0=0.2 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a3.000_*_v0.2000_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=3.0 V0=0.2 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a4.0_v0.03.ini <<'EOINI'
k_mode = 0
alpha_YM = 4.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=4.0 V0=0.03 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a4.0_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=4.0 V0=0.03 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a4.000_*_v0.0300_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=4.0 V0=0.03 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a4.0_v0.08.ini <<'EOINI'
k_mode = 0
alpha_YM = 4.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=4.0 V0=0.08 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a4.0_v0.08.ini >> $LOG 2>&1) || echo "[abi0] a=4.0 V0=0.08 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a4.000_*_v0.0800_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=4.0 V0=0.08 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a5.0_v0.01.ini <<'EOINI'
k_mode = 0
alpha_YM = 5.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=5.0 V0=0.01 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a5.0_v0.01.ini >> $LOG 2>&1) || echo "[abi0] a=5.0 V0=0.01 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a5.000_*_v0.0100_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=5.0 V0=0.01 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a5.0_v0.05.ini <<'EOINI'
k_mode = 0
alpha_YM = 5.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=5.0 V0=0.05 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a5.0_v0.05.ini >> $LOG 2>&1) || echo "[abi0] a=5.0 V0=0.05 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a5.000_*_v0.0500_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=5.0 V0=0.05 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a5.0_v0.1.ini <<'EOINI'
k_mode = 0
alpha_YM = 5.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=5.0 V0=0.1 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a5.0_v0.1.ini >> $LOG 2>&1) || echo "[abi0] a=5.0 V0=0.1 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a5.000_*_v0.1000_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=5.0 V0=0.1 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a6.0_v0.02.ini <<'EOINI'
k_mode = 0
alpha_YM = 6.0
V0 = 0.02
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=6.0 V0=0.02 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a6.0_v0.02.ini >> $LOG 2>&1) || echo "[abi0] a=6.0 V0=0.02 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a6.000_*_v0.0200_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=6.0 V0=0.02 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a6.0_v0.07.ini <<'EOINI'
k_mode = 0
alpha_YM = 6.0
V0 = 0.07
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=6.0 V0=0.07 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a6.0_v0.07.ini >> $LOG 2>&1) || echo "[abi0] a=6.0 V0=0.07 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a6.000_*_v0.0700_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=6.0 V0=0.07 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a6.0_v0.2.ini <<'EOINI'
k_mode = 0
alpha_YM = 6.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi0] a=6.0 V0=0.2 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a6.0_v0.2.ini >> $LOG 2>&1) || echo "[abi0] a=6.0 V0=0.2 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a6.000_*_v0.2000_*_kz0ext" >> $LOG 2>&1)
echo "[abi0] a=6.0 V0=0.2 kz=0 done $(date)" >> $LOG

    echo "=== abi0 ALL DONE $(date) ===" >> $LOG
}

run_gpu1() {
    export CUDA_VISIBLE_DEVICES=1
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/kz0ext_abi1_progress.log
    echo "=== kz0ext abi1 start $(date) ===" >> $LOG
# ---- smoke test: k_mode=0 uniform seed + suppress_kz0=0 path + extractor ----
cat > /tmp/kz0ext_smoke_abi1.ini <<'EOINI'
k_mode = 0
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 2
run_tag = smokeabi1
EOINI
rm -rf $WDIR/outputs/ym_k0_a2.000*smokeabi1*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_smoke_abi1.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a2.000*smokeabi1" >> $LOG 2>&1)
python3 - "$WDIR" abi1 <<'EOPY' >> $LOG 2>&1 || { echo "[abi1] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, math, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k0_a2.000*smoke" + stream + "*/timeseries_k0.csv")
assert fs, "smoke: no timeseries written (k_mode=0 path likely broken)"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert rows and 'amp_conj' in rows[0], "smoke: extractor is not the fixed version"
a0 = float(rows[0]['amp'])
assert a0 > 0 and math.log(a0) > -20, "smoke: kz=0 seed missing (logamp=%.1f)" % (math.log(a0) if a0 > 0 else -99)
print("[%s] smoke test OK (kz=0 uniform seed + suppress_kz0=0 path): logamp0=%.1f" % (stream, math.log(a0)))
EOPY
rm -rf $WDIR/outputs/ym_k0_a2.000*smokeabi1*

cat > /tmp/kz0ext_abi1_a0.5_v0.02.ini <<'EOINI'
k_mode = 0
alpha_YM = 0.5
V0 = 0.02
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 101.3
run_tag = kz0ext
EOINI
echo "[abi1] a=0.5 V0=0.02 kz=0 (tu=101.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a0.5_v0.02.ini >> $LOG 2>&1) || echo "[abi1] a=0.5 V0=0.02 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a0.500_*_v0.0200_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=0.5 V0=0.02 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a0.5_v0.07.ini <<'EOINI'
k_mode = 0
alpha_YM = 0.5
V0 = 0.07
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=0.5 V0=0.07 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a0.5_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=0.5 V0=0.07 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a0.500_*_v0.0700_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=0.5 V0=0.07 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a0.5_v0.2.ini <<'EOINI'
k_mode = 0
alpha_YM = 0.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=0.5 V0=0.2 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a0.5_v0.2.ini >> $LOG 2>&1) || echo "[abi1] a=0.5 V0=0.2 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a0.500_*_v0.2000_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=0.5 V0=0.2 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a1.0_v0.03.ini <<'EOINI'
k_mode = 0
alpha_YM = 1.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=1.0 V0=0.03 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a1.0_v0.03.ini >> $LOG 2>&1) || echo "[abi1] a=1.0 V0=0.03 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a1.000_*_v0.0300_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=1.0 V0=0.03 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a1.0_v0.08.ini <<'EOINI'
k_mode = 0
alpha_YM = 1.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=1.0 V0=0.08 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a1.0_v0.08.ini >> $LOG 2>&1) || echo "[abi1] a=1.0 V0=0.08 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a1.000_*_v0.0800_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=1.0 V0=0.08 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a1.5_v0.01.ini <<'EOINI'
k_mode = 0
alpha_YM = 1.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=1.5 V0=0.01 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a1.5_v0.01.ini >> $LOG 2>&1) || echo "[abi1] a=1.5 V0=0.01 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a1.500_*_v0.0100_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=1.5 V0=0.01 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a1.5_v0.05.ini <<'EOINI'
k_mode = 0
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=1.5 V0=0.05 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a1.5_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=1.5 V0=0.05 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a1.500_*_v0.0500_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=1.5 V0=0.05 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a1.5_v0.1.ini <<'EOINI'
k_mode = 0
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=1.5 V0=0.1 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a1.5_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=1.5 V0=0.1 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a1.500_*_v0.1000_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=1.5 V0=0.1 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a2.0_v0.02.ini <<'EOINI'
k_mode = 0
alpha_YM = 2.0
V0 = 0.02
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=2.0 V0=0.02 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a2.0_v0.02.ini >> $LOG 2>&1) || echo "[abi1] a=2.0 V0=0.02 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a2.000_*_v0.0200_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=2.0 V0=0.02 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a2.0_v0.07.ini <<'EOINI'
k_mode = 0
alpha_YM = 2.0
V0 = 0.07
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=2.0 V0=0.07 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a2.0_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=2.0 V0=0.07 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a2.000_*_v0.0700_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=2.0 V0=0.07 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a2.0_v0.2.ini <<'EOINI'
k_mode = 0
alpha_YM = 2.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=2.0 V0=0.2 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a2.0_v0.2.ini >> $LOG 2>&1) || echo "[abi1] a=2.0 V0=0.2 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a2.000_*_v0.2000_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=2.0 V0=0.2 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a2.5_v0.03.ini <<'EOINI'
k_mode = 0
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=2.5 V0=0.03 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a2.5_v0.03.ini >> $LOG 2>&1) || echo "[abi1] a=2.5 V0=0.03 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a2.500_*_v0.0300_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=2.5 V0=0.03 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a2.5_v0.08.ini <<'EOINI'
k_mode = 0
alpha_YM = 2.5
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=2.5 V0=0.08 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a2.5_v0.08.ini >> $LOG 2>&1) || echo "[abi1] a=2.5 V0=0.08 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a2.500_*_v0.0800_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=2.5 V0=0.08 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a3.0_v0.01.ini <<'EOINI'
k_mode = 0
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=3.0 V0=0.01 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a3.0_v0.01.ini >> $LOG 2>&1) || echo "[abi1] a=3.0 V0=0.01 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a3.000_*_v0.0100_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=3.0 V0=0.01 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a3.0_v0.05.ini <<'EOINI'
k_mode = 0
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=3.0 V0=0.05 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a3.0_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=3.0 V0=0.05 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a3.000_*_v0.0500_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=3.0 V0=0.05 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a3.0_v0.1.ini <<'EOINI'
k_mode = 0
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=3.0 V0=0.1 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a3.0_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=3.0 V0=0.1 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a3.000_*_v0.1000_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=3.0 V0=0.1 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a4.0_v0.02.ini <<'EOINI'
k_mode = 0
alpha_YM = 4.0
V0 = 0.02
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=4.0 V0=0.02 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a4.0_v0.02.ini >> $LOG 2>&1) || echo "[abi1] a=4.0 V0=0.02 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a4.000_*_v0.0200_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=4.0 V0=0.02 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a4.0_v0.07.ini <<'EOINI'
k_mode = 0
alpha_YM = 4.0
V0 = 0.07
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=4.0 V0=0.07 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a4.0_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=4.0 V0=0.07 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a4.000_*_v0.0700_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=4.0 V0=0.07 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a4.0_v0.2.ini <<'EOINI'
k_mode = 0
alpha_YM = 4.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=4.0 V0=0.2 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a4.0_v0.2.ini >> $LOG 2>&1) || echo "[abi1] a=4.0 V0=0.2 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a4.000_*_v0.2000_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=4.0 V0=0.2 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a5.0_v0.03.ini <<'EOINI'
k_mode = 0
alpha_YM = 5.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=5.0 V0=0.03 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a5.0_v0.03.ini >> $LOG 2>&1) || echo "[abi1] a=5.0 V0=0.03 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a5.000_*_v0.0300_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=5.0 V0=0.03 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a5.0_v0.08.ini <<'EOINI'
k_mode = 0
alpha_YM = 5.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=5.0 V0=0.08 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a5.0_v0.08.ini >> $LOG 2>&1) || echo "[abi1] a=5.0 V0=0.08 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a5.000_*_v0.0800_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=5.0 V0=0.08 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a6.0_v0.01.ini <<'EOINI'
k_mode = 0
alpha_YM = 6.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=6.0 V0=0.01 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a6.0_v0.01.ini >> $LOG 2>&1) || echo "[abi1] a=6.0 V0=0.01 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a6.000_*_v0.0100_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=6.0 V0=0.01 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a6.0_v0.05.ini <<'EOINI'
k_mode = 0
alpha_YM = 6.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=6.0 V0=0.05 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a6.0_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=6.0 V0=0.05 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a6.000_*_v0.0500_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=6.0 V0=0.05 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a6.0_v0.1.ini <<'EOINI'
k_mode = 0
alpha_YM = 6.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi1] a=6.0 V0=0.1 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a6.0_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=6.0 V0=0.1 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a6.000_*_v0.1000_*_kz0ext" >> $LOG 2>&1)
echo "[abi1] a=6.0 V0=0.1 kz=0 done $(date)" >> $LOG

    echo "=== abi1 ALL DONE $(date) ===" >> $LOG
}

run_gpu2() {
    export CUDA_VISIBLE_DEVICES=2
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/kz0ext_abi2_progress.log
    echo "=== kz0ext abi2 start $(date) ===" >> $LOG
# ---- smoke test: k_mode=0 uniform seed + suppress_kz0=0 path + extractor ----
cat > /tmp/kz0ext_smoke_abi2.ini <<'EOINI'
k_mode = 0
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 2
run_tag = smokeabi2
EOINI
rm -rf $WDIR/outputs/ym_k0_a2.000*smokeabi2*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_smoke_abi2.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a2.000*smokeabi2" >> $LOG 2>&1)
python3 - "$WDIR" abi2 <<'EOPY' >> $LOG 2>&1 || { echo "[abi2] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, math, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k0_a2.000*smoke" + stream + "*/timeseries_k0.csv")
assert fs, "smoke: no timeseries written (k_mode=0 path likely broken)"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert rows and 'amp_conj' in rows[0], "smoke: extractor is not the fixed version"
a0 = float(rows[0]['amp'])
assert a0 > 0 and math.log(a0) > -20, "smoke: kz=0 seed missing (logamp=%.1f)" % (math.log(a0) if a0 > 0 else -99)
print("[%s] smoke test OK (kz=0 uniform seed + suppress_kz0=0 path): logamp0=%.1f" % (stream, math.log(a0)))
EOPY
rm -rf $WDIR/outputs/ym_k0_a2.000*smokeabi2*

cat > /tmp/kz0ext_abi2_a0.5_v0.03.ini <<'EOINI'
k_mode = 0
alpha_YM = 0.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=0.5 V0=0.03 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a0.5_v0.03.ini >> $LOG 2>&1) || echo "[abi2] a=0.5 V0=0.03 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a0.500_*_v0.0300_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=0.5 V0=0.03 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a0.5_v0.05.ini <<'EOINI'
k_mode = 0
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=0.5 V0=0.05 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a0.5_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=0.5 V0=0.05 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a0.500_*_v0.0500_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=0.5 V0=0.05 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a0.5_v0.1.ini <<'EOINI'
k_mode = 0
alpha_YM = 0.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=0.5 V0=0.1 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a0.5_v0.1.ini >> $LOG 2>&1) || echo "[abi2] a=0.5 V0=0.1 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a0.500_*_v0.1000_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=0.5 V0=0.1 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a1.0_v0.02.ini <<'EOINI'
k_mode = 0
alpha_YM = 1.0
V0 = 0.02
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=1.0 V0=0.02 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a1.0_v0.02.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.02 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a1.000_*_v0.0200_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.02 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a1.0_v0.07.ini <<'EOINI'
k_mode = 0
alpha_YM = 1.0
V0 = 0.07
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=1.0 V0=0.07 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a1.0_v0.07.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.07 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a1.000_*_v0.0700_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.07 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a1.0_v0.2.ini <<'EOINI'
k_mode = 0
alpha_YM = 1.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=1.0 V0=0.2 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a1.0_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.2 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a1.000_*_v0.2000_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.2 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a1.5_v0.03.ini <<'EOINI'
k_mode = 0
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=1.5 V0=0.03 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a1.5_v0.03.ini >> $LOG 2>&1) || echo "[abi2] a=1.5 V0=0.03 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a1.500_*_v0.0300_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=1.5 V0=0.03 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a1.5_v0.08.ini <<'EOINI'
k_mode = 0
alpha_YM = 1.5
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=1.5 V0=0.08 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a1.5_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=1.5 V0=0.08 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a1.500_*_v0.0800_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=1.5 V0=0.08 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a2.0_v0.01.ini <<'EOINI'
k_mode = 0
alpha_YM = 2.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=2.0 V0=0.01 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a2.0_v0.01.ini >> $LOG 2>&1) || echo "[abi2] a=2.0 V0=0.01 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a2.000_*_v0.0100_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=2.0 V0=0.01 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a2.0_v0.05.ini <<'EOINI'
k_mode = 0
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=2.0 V0=0.05 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a2.0_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=2.0 V0=0.05 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a2.000_*_v0.0500_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=2.0 V0=0.05 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a2.0_v0.1.ini <<'EOINI'
k_mode = 0
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=2.0 V0=0.1 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a2.0_v0.1.ini >> $LOG 2>&1) || echo "[abi2] a=2.0 V0=0.1 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a2.000_*_v0.1000_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=2.0 V0=0.1 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a2.5_v0.02.ini <<'EOINI'
k_mode = 0
alpha_YM = 2.5
V0 = 0.02
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=2.5 V0=0.02 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a2.5_v0.02.ini >> $LOG 2>&1) || echo "[abi2] a=2.5 V0=0.02 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a2.500_*_v0.0200_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=2.5 V0=0.02 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a2.5_v0.07.ini <<'EOINI'
k_mode = 0
alpha_YM = 2.5
V0 = 0.07
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=2.5 V0=0.07 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a2.5_v0.07.ini >> $LOG 2>&1) || echo "[abi2] a=2.5 V0=0.07 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a2.500_*_v0.0700_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=2.5 V0=0.07 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a2.5_v0.2.ini <<'EOINI'
k_mode = 0
alpha_YM = 2.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=2.5 V0=0.2 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a2.5_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=2.5 V0=0.2 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a2.500_*_v0.2000_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=2.5 V0=0.2 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a3.0_v0.03.ini <<'EOINI'
k_mode = 0
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=3.0 V0=0.03 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a3.0_v0.03.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.03 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a3.000_*_v0.0300_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.03 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a3.0_v0.08.ini <<'EOINI'
k_mode = 0
alpha_YM = 3.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=3.0 V0=0.08 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a3.0_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.08 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a3.000_*_v0.0800_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.08 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a4.0_v0.01.ini <<'EOINI'
k_mode = 0
alpha_YM = 4.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=4.0 V0=0.01 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a4.0_v0.01.ini >> $LOG 2>&1) || echo "[abi2] a=4.0 V0=0.01 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a4.000_*_v0.0100_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=4.0 V0=0.01 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a4.0_v0.05.ini <<'EOINI'
k_mode = 0
alpha_YM = 4.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=4.0 V0=0.05 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a4.0_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=4.0 V0=0.05 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a4.000_*_v0.0500_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=4.0 V0=0.05 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a4.0_v0.1.ini <<'EOINI'
k_mode = 0
alpha_YM = 4.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=4.0 V0=0.1 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a4.0_v0.1.ini >> $LOG 2>&1) || echo "[abi2] a=4.0 V0=0.1 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a4.000_*_v0.1000_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=4.0 V0=0.1 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a5.0_v0.02.ini <<'EOINI'
k_mode = 0
alpha_YM = 5.0
V0 = 0.02
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=5.0 V0=0.02 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a5.0_v0.02.ini >> $LOG 2>&1) || echo "[abi2] a=5.0 V0=0.02 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a5.000_*_v0.0200_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=5.0 V0=0.02 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a5.0_v0.07.ini <<'EOINI'
k_mode = 0
alpha_YM = 5.0
V0 = 0.07
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=5.0 V0=0.07 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a5.0_v0.07.ini >> $LOG 2>&1) || echo "[abi2] a=5.0 V0=0.07 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a5.000_*_v0.0700_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=5.0 V0=0.07 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a5.0_v0.2.ini <<'EOINI'
k_mode = 0
alpha_YM = 5.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=5.0 V0=0.2 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a5.0_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=5.0 V0=0.2 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a5.000_*_v0.2000_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=5.0 V0=0.2 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a6.0_v0.03.ini <<'EOINI'
k_mode = 0
alpha_YM = 6.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=6.0 V0=0.03 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a6.0_v0.03.ini >> $LOG 2>&1) || echo "[abi2] a=6.0 V0=0.03 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a6.000_*_v0.0300_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=6.0 V0=0.03 kz=0 done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a6.0_v0.08.ini <<'EOINI'
k_mode = 0
alpha_YM = 6.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 100.0
run_tag = kz0ext
EOINI
echo "[abi2] a=6.0 V0=0.08 kz=0 (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a6.0_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=6.0 V0=0.08 kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a6.000_*_v0.0800_*_kz0ext" >> $LOG 2>&1)
echo "[abi2] a=6.0 V0=0.08 kz=0 done $(date)" >> $LOG

    echo "=== abi2 ALL DONE $(date) ===" >> $LOG
}

echo "=== abi: launching 3-GPU kz=0 extension campaign $(date) ==="
run_gpu0 & PID0=$!
run_gpu1 & PID1=$!
run_gpu2 & PID2=$!
wait $PID0 && echo 'GPU0 finished' || echo 'GPU0 FAILED'
wait $PID1 && echo 'GPU1 finished' || echo 'GPU1 FAILED'
wait $PID2 && echo 'GPU2 finished' || echo 'GPU2 FAILED'
