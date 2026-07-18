#!/bin/bash
# recorrection campaign -- abi (3 GPUs, 2026-07-18)
WDIR=/DATA/s23103/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs

run_gpu0() {
    export CUDA_VISIBLE_DEVICES=0
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/recorr_abi0_progress.log
    echo "=== recorr abi0 start $(date) ===" >> $LOG
# ---- smoke test: binary deposits seed + extractor measures the right channel ----
cat > /tmp/recorr_smoke_abi0.ini <<'EOINI'
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
run_tag = smokeabi0
EOINI
rm -rf $WDIR/outputs/ym_k2_a1.000*smokeabi0*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_smoke_abi0.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000*smokeabi0" >> $LOG 2>&1)
python3 - "$WDIR" abi0 <<'EOPY' >> $LOG 2>&1 || { echo "[abi0] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, math, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k2_a1.000*smoke" + stream + "*/timeseries_k2.csv")
assert fs, "smoke: no timeseries written"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert rows and 'amp_conj' in rows[0], "smoke: extractor is not the fixed version"
a0 = float(rows[0]['amp'])
assert a0 > 0 and math.log(a0) > -20, "smoke: seed missing from measured channel (logamp=%.1f)" % (math.log(a0) if a0 > 0 else -99)
print("[%s] smoke test OK: logamp0=%.1f" % (stream, math.log(a0)))
EOPY
rm -rf $WDIR/outputs/ym_k2_a1.000*smokeabi0*

cat > /tmp/recorr_abi0_a3.0_v0.02_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 3.0
V0 = 0.02
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=3.0 V0=0.02 kz=3.0 (tier=int k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a3.0_v0.02_kz3.0.ini >> $LOG 2>&1) || echo "[abi0] a=3.0 V0=0.02 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a3.000_*_v0.0200_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=3.0 V0=0.02 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.7_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=1.7 V0=0.03 kz=2.0 (tier=int k=2 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.7_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.7 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.700_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.7 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.2_v0.03_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.2 V0=0.03 kz=4.0 (tier=int k=4 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.2_v0.03_kz4.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.2 V0=0.03 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.200_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.2 V0=0.03 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.5_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.5 V0=0.03 kz=8.0 (tier=int k=8 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.5_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.5 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a2.500_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.5 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.7_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.7 V0=0.03 kz=1.0 (tier=int k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.7_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.7 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.700_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.7 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.8_v0.03_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.8 V0=0.03 kz=7.0 (tier=int k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.8_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.8 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.800_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.8 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.4_v0.05_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=1.4 V0=0.05 kz=4.0 (tier=int k=4 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.4_v0.05_kz4.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.4 V0=0.05 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a1.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.4 V0=0.05 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.6_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=1.6 V0=0.05 kz=3.0 (tier=int k=3 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.6_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.6 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.600_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.6 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.0_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.0 V0=0.05 kz=3.0 (tier=int k=3 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.0_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.000_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.1_v0.05_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.1 V0=0.05 kz=7.0 (tier=int k=7 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.1_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.1 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.100_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.1 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.2_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.2 V0=0.05 kz=2.0 (tier=int k=2 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.2_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.2 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.200_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.2 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.2_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.2 V0=0.05 kz=3.0 (tier=int k=3 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.2_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.2 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.200_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.2 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.3_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.3 V0=0.05 kz=2.0 (tier=int k=2 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.3_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.3 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.300_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.3 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.6_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.6 V0=0.05 kz=2.0 (tier=int k=2 sp=7.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.6_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.6 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.600_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.6 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.7_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.7 V0=0.05 kz=3.0 (tier=int k=3 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.7_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.7 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.7 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.7_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.7 V0=0.05 kz=8.0 (tier=int k=8 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.7_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.7 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a2.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.7 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.8_v0.05_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.8 V0=0.05 kz=7.0 (tier=int k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.8_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.8 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.8 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.4_v0.1_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=1.4 V0=0.1 kz=2.0 (tier=int k=2 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.4_v0.1_kz2.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.4 V0=0.1 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.400_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.4 V0=0.1 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.4_v0.1_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=1.4 V0=0.1 kz=8.0 (tier=int k=8 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.4_v0.1_kz8.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.4 V0=0.1 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.400_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.4 V0=0.1 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.6_v0.1_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=1.6 V0=0.1 kz=4.0 (tier=int k=4 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.6_v0.1_kz4.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.6 V0=0.1 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a1.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.6 V0=0.1 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.8_v0.1_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=1.8 V0=0.1 kz=1.0 (tier=int k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.8_v0.1_kz1.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.8 V0=0.1 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.8 V0=0.1 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.0_v0.1_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.0 V0=0.1 kz=5.0 (tier=int k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.0_v0.1_kz5.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.1 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.1 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.1_v0.1_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.1 V0=0.1 kz=3.0 (tier=int k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.1_v0.1_kz3.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.1 V0=0.1 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.100_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.1 V0=0.1 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.3_v0.1_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.3 V0=0.1 kz=1.0 (tier=int k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.3_v0.1_kz1.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.3 V0=0.1 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.3 V0=0.1 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.4_v0.1_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.4 V0=0.1 kz=7.0 (tier=int k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.4_v0.1_kz7.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.4 V0=0.1 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.400_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.4 V0=0.1 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.8_v0.1_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.8 V0=0.1 kz=2.0 (tier=int k=2 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.8_v0.1_kz2.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.8 V0=0.1 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.8 V0=0.1 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a4.0_v0.1_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 4.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=4.0 V0=0.1 kz=4.0 (tier=int k=4 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a4.0_v0.1_kz4.0.ini >> $LOG 2>&1) || echo "[abi0] a=4.0 V0=0.1 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a4.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=4.0 V0=0.1 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.7_v0.2_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=0.7 V0=0.2 kz=2.0 (tier=int k=2 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.7_v0.2_kz2.0.ini >> $LOG 2>&1) || echo "[abi0] a=0.7 V0=0.2 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.7 V0=0.2 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.8_v0.2_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=0.8 V0=0.2 kz=4.0 (tier=int k=4 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.8_v0.2_kz4.0.ini >> $LOG 2>&1) || echo "[abi0] a=0.8 V0=0.2 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a0.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.8 V0=0.2 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.0_v0.2_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=1.0 V0=0.2 kz=5.0 (tier=int k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.0_v0.2_kz5.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.0 V0=0.2 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.0 V0=0.2 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.0_v0.2_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=1.0 V0=0.2 kz=8.0 (tier=int k=8 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.0_v0.2_kz8.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.0 V0=0.2 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.0 V0=0.2 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.1_v0.2_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=1.1 V0=0.2 kz=2.0 (tier=int k=2 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.1_v0.2_kz2.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.1 V0=0.2 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.1 V0=0.2 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.2_v0.2_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=1.2 V0=0.2 kz=6.0 (tier=int k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.2_v0.2_kz6.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.2 V0=0.2 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.200_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.2 V0=0.2 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.3_v0.2_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=1.3 V0=0.2 kz=4.0 (tier=int k=4 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.3_v0.2_kz4.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.3 V0=0.2 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a1.300_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.3 V0=0.2 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.6_v0.2_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=1.6 V0=0.2 kz=2.0 (tier=int k=2 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.6_v0.2_kz2.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.6 V0=0.2 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.600_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.6 V0=0.2 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.7_v0.2_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=1.7 V0=0.2 kz=6.0 (tier=int k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.7_v0.2_kz6.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.7 V0=0.2 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.7 V0=0.2 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.8_v0.2_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=1.8 V0=0.2 kz=5.0 (tier=int k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.8_v0.2_kz5.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.8 V0=0.2 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.8 V0=0.2 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.9_v0.2_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=1.9 V0=0.2 kz=5.0 (tier=int k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.9_v0.2_kz5.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.9 V0=0.2 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.900_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.9 V0=0.2 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.1_v0.2_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.1 V0=0.2 kz=4.0 (tier=int k=4 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.1_v0.2_kz4.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.1 V0=0.2 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.1 V0=0.2 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.1_v0.2_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.1 V0=0.2 kz=8.0 (tier=int k=8 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.1_v0.2_kz8.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.1 V0=0.2 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a2.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.1 V0=0.2 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.3_v0.2_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.3 V0=0.2 kz=3.0 (tier=int k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.3_v0.2_kz3.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.3 V0=0.2 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.300_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.3 V0=0.2 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.5_v0.2_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.5 V0=0.2 kz=5.0 (tier=int k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.5_v0.2_kz5.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.5 V0=0.2 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.500_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.5 V0=0.2 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.7_v0.2_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.7 V0=0.2 kz=1.0 (tier=int k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.7_v0.2_kz1.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.7 V0=0.2 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.7 V0=0.2 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.8_v0.2_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.8 V0=0.2 kz=5.0 (tier=int k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.8_v0.2_kz5.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.8 V0=0.2 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.8 V0=0.2 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.9_v0.2_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi0] a=2.9 V0=0.2 kz=4.0 (tier=int k=4 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.9_v0.2_kz4.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.9 V0=0.2 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.900_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.9 V0=0.2 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.3_v0.1_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 103.2
run_tag = recorr
EOINI
echo "[abi0] a=1.3 V0=0.1 kz=8.0 (tier=int k=8 sp=8.0 tu=103.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.3_v0.1_kz8.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.3 V0=0.1 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.3 V0=0.1 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.4_v0.05_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 107.2
run_tag = recorr
EOINI
echo "[abi0] a=1.4 V0=0.05 kz=5.0 (tier=int k=5 sp=8.0 tu=107.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.4_v0.05_kz5.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.4 V0=0.05 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.4 V0=0.05 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.8_v0.2_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 111.0
run_tag = recorr
EOINI
echo "[abi0] a=0.8 V0=0.2 kz=7.0 (tier=int k=7 sp=8.0 tu=111.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.8_v0.2_kz7.0.ini >> $LOG 2>&1) || echo "[abi0] a=0.8 V0=0.2 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.8 V0=0.2 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.3_v0.05_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 115.4
run_tag = recorr
EOINI
echo "[abi0] a=1.3 V0=0.05 kz=5.0 (tier=int k=5 sp=8.0 tu=115.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.3_v0.05_kz5.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.3 V0=0.05 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.300_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.3 V0=0.05 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.2_v0.01_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 118.2
run_tag = recorr
EOINI
echo "[abi0] a=2.2 V0=0.01 kz=3.0 (tier=int k=3 sp=22.0 tu=118.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.2_v0.01_kz3.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.2 V0=0.01 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.200_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.2 V0=0.01 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.1_v0.05_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 122.0
run_tag = recorr
EOINI
echo "[abi0] a=1.1 V0=0.05 kz=4.0 (tier=int k=4 sp=8.0 tu=122.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.1_v0.05_kz4.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.1 V0=0.05 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a1.100_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.1 V0=0.05 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.2_v0.03_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 125.1
run_tag = recorr
EOINI
echo "[abi0] a=1.2 V0=0.03 kz=3.0 (tier=int k=3 sp=10.0 tu=125.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.2_v0.03_kz3.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.2 V0=0.03 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.200_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.2 V0=0.03 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.9_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 129.2
run_tag = recorr
EOINI
echo "[abi0] a=0.9 V0=0.05 kz=3.0 (tier=int k=3 sp=9.0 tu=129.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.9_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[abi0] a=0.9 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a0.900_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.9 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.7_v0.03_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 134.8
run_tag = recorr
EOINI
echo "[abi0] a=1.7 V0=0.03 kz=7.0 (tier=int k=7 sp=8.0 tu=134.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.7_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.7 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.700_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.7 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.9_v0.01_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 136.8
run_tag = recorr
EOINI
echo "[abi0] a=1.9 V0=0.01 kz=3.0 (tier=int k=3 sp=22.0 tu=136.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.9_v0.01_kz3.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.9 V0=0.01 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.900_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.9 V0=0.01 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.1_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 142.9
run_tag = recorr
EOINI
echo "[abi0] a=2.1 V0=0.01 kz=4.0 (tier=int k=4 sp=22.0 tu=142.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.1_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.1 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.100_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.1 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.7_v0.01_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 147.0
run_tag = recorr
EOINI
echo "[abi0] a=2.7 V0=0.01 kz=7.0 (tier=int k=7 sp=8.0 tu=147.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.7_v0.01_kz7.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.7 V0=0.01 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.700_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.7 V0=0.01 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.2_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 152.5
run_tag = recorr
EOINI
echo "[abi0] a=2.2 V0=0.01 kz=5.0 (tier=int k=5 sp=22.0 tu=152.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.2_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.2 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.200_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.2 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.6_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 158.3
run_tag = recorr
EOINI
echo "[abi0] a=0.6 V0=0.05 kz=2.0 (tier=int k=2 sp=13.0 tu=158.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.6_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[abi0] a=0.6 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.600_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.6 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.4_v0.03_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 163.7
run_tag = recorr
EOINI
echo "[abi0] a=1.4 V0=0.03 kz=7.0 (tier=int k=7 sp=8.0 tu=163.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.4_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.4 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.400_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.4 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.8_v0.05_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 167.8
run_tag = recorr
EOINI
echo "[abi0] a=0.8 V0=0.05 kz=4.0 (tier=int k=4 sp=8.0 tu=167.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.8_v0.05_kz4.0.ini >> $LOG 2>&1) || echo "[abi0] a=0.8 V0=0.05 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a0.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.8 V0=0.05 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.7_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 175.2
run_tag = recorr
EOINI
echo "[abi0] a=0.7 V0=0.03 kz=2.0 (tier=int k=2 sp=14.0 tu=175.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.7_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[abi0] a=0.7 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.700_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.7 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.0_v0.01_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 183.7
run_tag = recorr
EOINI
echo "[abi0] a=2.0 V0=0.01 kz=6.0 (tier=int k=6 sp=8.0 tu=183.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.0_v0.01_kz6.0.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.01 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.000_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.01 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.2_v0.03_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 191.0
run_tag = recorr
EOINI
echo "[abi0] a=1.2 V0=0.03 kz=7.0 (tier=int k=7 sp=8.0 tu=191.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.2_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.2 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.200_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.2 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.6_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 193.7
run_tag = recorr
EOINI
echo "[abi0] a=0.6 V0=0.05 kz=3.0 (tier=int k=3 sp=10.0 tu=193.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.6_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[abi0] a=0.6 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a0.600_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.6 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.1_v0.01_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.1 V0=0.01 kz=0.5 (tier=half k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.1_v0.01_kz0.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.1 V0=0.01 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.100_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.1 V0=0.01 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.8_v0.01_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.8 V0=0.01 kz=1.5 (tier=half k=3 sp=22.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.8_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.8 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.800_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.8 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.8_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.8 V0=0.03 kz=0.5 (tier=half k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.8_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.8 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.800_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.8 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.3_v0.03_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.3 V0=0.03 kz=1.5 (tier=half k=3 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.3_v0.03_kz1.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.3 V0=0.03 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.300_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.3 V0=0.03 kz=1.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.4_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.4 V0=0.03 kz=0.5 (tier=half k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.4_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.4 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.400_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.4 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.6_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.6 V0=0.03 kz=0.5 (tier=half k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.6_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.6 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.6 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.7_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.7 V0=0.03 kz=0.5 (tier=half k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.7_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.7 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.700_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.7 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.0_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.0 V0=0.03 kz=0.5 (tier=half k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.0_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.000_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.1_v0.03_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.1 V0=0.03 kz=4.5 (tier=half k=9 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.1_v0.03_kz4.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.1 V0=0.03 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.100_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.1 V0=0.03 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.4_v0.03_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.4 V0=0.03 kz=7.5 (tier=half k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.4_v0.03_kz7.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.4 V0=0.03 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.400_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.4 V0=0.03 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.5_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.5 V0=0.03 kz=0.5 (tier=half k=1 sp=6.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.5_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.5 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.500_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.5 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.6_v0.03_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.6 V0=0.03 kz=5.5 (tier=half k=11 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.6_v0.03_kz5.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.6 V0=0.03 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a2.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.6 V0=0.03 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.7_v0.03_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.7 V0=0.03 kz=3.5 (tier=half k=7 sp=18.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.7_v0.03_kz3.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.7 V0=0.03 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.700_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.7 V0=0.03 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.7_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.7 V0=0.05 kz=0.5 (tier=half k=1 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.7_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.7 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.7 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.8_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.8 V0=0.05 kz=0.5 (tier=half k=1 sp=6.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.8_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.8 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.8 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.8_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.8 V0=0.05 kz=5.5 (tier=half k=11 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.8_v0.05_kz5.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.8 V0=0.05 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a1.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.8 V0=0.05 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.0_v0.05_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.0 V0=0.05 kz=4.5 (tier=half k=9 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.0_v0.05_kz4.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.05 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.000_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.05 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.1_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.1 V0=0.05 kz=5.5 (tier=half k=11 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.1_v0.05_kz5.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.1 V0=0.05 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a2.100_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.1 V0=0.05 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.5_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.5 V0=0.05 kz=7.5 (tier=half k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.5_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.5 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.500_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.5 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.6_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.6 V0=0.05 kz=2.5 (tier=half k=5 sp=7.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.6_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.6 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.600_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.6 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.6_v0.05_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.6 V0=0.05 kz=4.5 (tier=half k=9 sp=7.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.6_v0.05_kz4.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.6 V0=0.05 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.600_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.6 V0=0.05 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.9_v0.05_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.9 V0=0.05 kz=4.5 (tier=half k=9 sp=13.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.9_v0.05_kz4.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.9 V0=0.05 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.900_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.9 V0=0.05 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.6_v0.1_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.6 V0=0.1 kz=0.5 (tier=half k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.6_v0.1_kz0.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.6 V0=0.1 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.6 V0=0.1 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.3_v0.1_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.3 V0=0.1 kz=0.5 (tier=half k=1 sp=12.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.3_v0.1_kz0.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.3 V0=0.1 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.3 V0=0.1 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.6_v0.1_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.6 V0=0.1 kz=1.5 (tier=half k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.6_v0.1_kz1.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.6 V0=0.1 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.6 V0=0.1 kz=1.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.6_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.6 V0=0.1 kz=5.5 (tier=half k=11 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.6_v0.1_kz5.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.6 V0=0.1 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a1.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.6 V0=0.1 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.0_v0.1_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.0 V0=0.1 kz=0.5 (tier=half k=1 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.0_v0.1_kz0.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.1 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.1 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.0_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.0 V0=0.1 kz=6.5 (tier=half k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.0_v0.1_kz6.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.1 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.1 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.1_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.1 V0=0.1 kz=6.5 (tier=half k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.1_v0.1_kz6.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.1 V0=0.1 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.100_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.1 V0=0.1 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.3_v0.1_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.3 V0=0.1 kz=3.5 (tier=half k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.3_v0.1_kz3.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.3 V0=0.1 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.3 V0=0.1 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.5_v0.1_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.5 V0=0.1 kz=2.5 (tier=half k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.5_v0.1_kz2.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.5 V0=0.1 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.500_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.5 V0=0.1 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.6_v0.1_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.6 V0=0.1 kz=2.5 (tier=half k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.6_v0.1_kz2.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.6 V0=0.1 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.6 V0=0.1 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.7_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.7 V0=0.1 kz=4.5 (tier=half k=9 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.7_v0.1_kz4.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.7 V0=0.1 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.700_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.7 V0=0.1 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.8_v0.1_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.8 V0=0.1 kz=0.5 (tier=half k=1 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.8_v0.1_kz0.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.8 V0=0.1 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.8 V0=0.1 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.9_v0.1_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.9 V0=0.1 kz=0.5 (tier=half k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.9_v0.1_kz0.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.9 V0=0.1 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.900_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.9 V0=0.1 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.6_v0.2_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.6 V0=0.2 kz=0.5 (tier=half k=1 sp=13.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.6_v0.2_kz0.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.6 V0=0.2 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.600_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.6 V0=0.2 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.8_v0.2_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.8 V0=0.2 kz=5.5 (tier=half k=11 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.8_v0.2_kz5.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.8 V0=0.2 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a0.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.8 V0=0.2 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.1_v0.2_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.1 V0=0.2 kz=1.5 (tier=half k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.1_v0.2_kz1.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.1 V0=0.2 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.1 V0=0.2 kz=1.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.1_v0.2_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.1 V0=0.2 kz=4.5 (tier=half k=9 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.1_v0.2_kz4.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.1 V0=0.2 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.1 V0=0.2 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.5_v0.2_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.5 V0=0.2 kz=0.5 (tier=half k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.5_v0.2_kz0.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.5 V0=0.2 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.500_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.5 V0=0.2 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.7_v0.2_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.7 V0=0.2 kz=5.5 (tier=half k=11 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.7_v0.2_kz5.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.7 V0=0.2 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a1.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.7 V0=0.2 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.8_v0.2_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.8 V0=0.2 kz=4.5 (tier=half k=9 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.8_v0.2_kz4.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.8 V0=0.2 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.8 V0=0.2 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.8_v0.2_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.8 V0=0.2 kz=5.5 (tier=half k=11 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.8_v0.2_kz5.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.8 V0=0.2 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a1.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.8 V0=0.2 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.1_v0.2_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.1 V0=0.2 kz=6.5 (tier=half k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.1_v0.2_kz6.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.1 V0=0.2 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.1 V0=0.2 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.1_v0.2_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.1 V0=0.2 kz=7.5 (tier=half k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.1_v0.2_kz7.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.1 V0=0.2 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.1 V0=0.2 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.2_v0.2_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.2 V0=0.2 kz=6.5 (tier=half k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.2_v0.2_kz6.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.2 V0=0.2 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.200_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.2 V0=0.2 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.7_v0.2_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.7 V0=0.2 kz=0.5 (tier=half k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.7_v0.2_kz0.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.7 V0=0.2 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.7 V0=0.2 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.7_v0.2_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.7 V0=0.2 kz=2.5 (tier=half k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.7_v0.2_kz2.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.7 V0=0.2 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.7 V0=0.2 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.9_v0.2_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.9 V0=0.2 kz=1.5 (tier=half k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.9_v0.2_kz1.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.9 V0=0.2 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.900_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.9 V0=0.2 kz=1.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a3.0_v0.2_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 3.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=3.0 V0=0.2 kz=6.5 (tier=half k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a3.0_v0.2_kz6.5.ini >> $LOG 2>&1) || echo "[abi0] a=3.0 V0=0.2 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a3.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=3.0 V0=0.2 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.4_v0.05_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 101.7
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.4 V0=0.05 kz=4.5 (tier=half k=9 sp=8.0 tu=101.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.4_v0.05_kz4.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.4 V0=0.05 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.4 V0=0.05 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.4_v0.1_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 205.5
run_tag = recorr
EOINI
echo "[abi0] a=0.4 V0=0.1 kz=3.0 (tier=int k=3 sp=9.0 tu=205.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.4_v0.1_kz3.0.ini >> $LOG 2>&1) || echo "[abi0] a=0.4 V0=0.1 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a0.400_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.4 V0=0.1 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.1_v0.03_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 105.2
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.1 V0=0.03 kz=6.5 (tier=half k=13 sp=8.0 tu=105.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.1_v0.03_kz6.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.1 V0=0.03 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.100_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.1 V0=0.03 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.8_v0.2_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 106.9
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.8 V0=0.2 kz=6.5 (tier=half k=13 sp=8.0 tu=106.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.8_v0.2_kz6.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.8 V0=0.2 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a0.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.8 V0=0.2 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.5_v0.03_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 108.1
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.5 V0=0.03 kz=3.5 (tier=half k=7 sp=8.0 tu=108.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.5_v0.03_kz3.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.5 V0=0.03 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.500_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.5 V0=0.03 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.4_v0.2_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 221.9
run_tag = recorr
EOINI
echo "[abi0] a=0.4 V0=0.2 kz=7.0 (tier=int k=7 sp=8.0 tu=221.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.4_v0.2_kz7.0.ini >> $LOG 2>&1) || echo "[abi0] a=0.4 V0=0.2 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.400_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.4 V0=0.2 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.4_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 112.4
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.4 V0=0.05 kz=5.5 (tier=half k=11 sp=8.0 tu=112.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.4_v0.05_kz5.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.4 V0=0.05 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a1.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.4 V0=0.05 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.6_v0.01_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 229.7
run_tag = recorr
EOINI
echo "[abi0] a=1.6 V0=0.01 kz=6.0 (tier=int k=6 sp=8.0 tu=229.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.6_v0.01_kz6.0.ini >> $LOG 2>&1) || echo "[abi0] a=1.6 V0=0.01 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.600_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.6 V0=0.01 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.9_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 118.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.9 V0=0.05 kz=2.5 (tier=half k=5 sp=9.0 tu=118.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.9_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.9 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.900_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.9 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.7_v0.03_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 119.5
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.7 V0=0.03 kz=5.5 (tier=half k=11 sp=8.0 tu=119.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.7_v0.03_kz5.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.7 V0=0.03 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a1.700_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.7 V0=0.03 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.5_v0.03_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 122.5
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.5 V0=0.03 kz=4.5 (tier=half k=9 sp=8.0 tu=122.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.5_v0.03_kz4.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.5 V0=0.03 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.500_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.5 V0=0.03 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.6_v0.05_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 250.0
run_tag = recorr
EOINI
echo "[abi0] a=0.6 V0=0.05 kz=5.0 (tier=int k=5 sp=8.0 tu=250.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.6_v0.05_kz5.0.ini >> $LOG 2>&1) || echo "[abi0] a=0.6 V0=0.05 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.600_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.6 V0=0.05 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.7_v0.05_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 253.6
run_tag = recorr
EOINI
echo "[abi0] a=0.7 V0=0.05 kz=7.0 (tier=int k=7 sp=9.0 tu=253.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.7_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[abi0] a=0.7 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.7 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.6_v0.2_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 131.1
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.6 V0=0.2 kz=5.5 (tier=half k=11 sp=8.0 tu=131.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.6_v0.2_kz5.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.6 V0=0.2 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a0.600_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.6 V0=0.2 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.4_v0.01_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 132.6
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.4 V0=0.01 kz=4.5 (tier=half k=9 sp=22.0 tu=132.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.4_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.4 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.400_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.4 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.9_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 272.2
run_tag = recorr
EOINI
echo "[abi0] a=0.9 V0=0.03 kz=8.0 (tier=int k=8 sp=8.0 tu=272.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.9_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[abi0] a=0.9 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a0.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.9 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.3_v0.01_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 138.4
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.3 V0=0.01 kz=4.5 (tier=half k=9 sp=22.0 tu=138.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.3_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.3 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.300_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.3 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.7_v0.01_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 141.7
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.7 V0=0.01 kz=6.5 (tier=half k=13 sp=8.0 tu=141.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.7_v0.01_kz6.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.7 V0=0.01 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.700_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.7 V0=0.01 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.9_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 144.4
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.9 V0=0.1 kz=7.5 (tier=half k=15 sp=8.0 tu=144.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.9_v0.1_kz7.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.9 V0=0.1 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a0.900_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.9 V0=0.1 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.6_v0.1_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 148.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.6 V0=0.1 kz=3.5 (tier=half k=7 sp=8.0 tu=148.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.6_v0.1_kz3.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.6 V0=0.1 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.6 V0=0.1 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.7_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 152.2
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.7 V0=0.01 kz=7.5 (tier=half k=15 sp=8.0 tu=152.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.7_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.7 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.700_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.7 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.4_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 306.3
run_tag = recorr
EOINI
echo "[abi0] a=0.4 V0=0.03 kz=2.0 (tier=int k=2 sp=14.0 tu=306.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.4_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[abi0] a=0.4 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.400_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.4 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.6_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 158.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=2.6 V0=0.01 kz=7.5 (tier=half k=15 sp=8.0 tu=158.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.6_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[abi0] a=2.6 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.600_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.6 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.3_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 161.8
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.3 V0=0.05 kz=0.5 (tier=half k=1 sp=8.0 tu=161.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.3_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.3 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.300_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.3 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.1_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 167.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.1 V0=0.05 kz=7.5 (tier=half k=15 sp=9.0 tu=167.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.1_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.1 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.100_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.1 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.5_v0.2_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 171.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.5 V0=0.2 kz=6.5 (tier=half k=13 sp=8.0 tu=171.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.5_v0.2_kz6.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.5 V0=0.2 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a0.500_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.5 V0=0.2 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.3_v0.1_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 353.6
run_tag = recorr
EOINI
echo "[abi0] a=0.3 V0=0.1 kz=5.0 (tier=int k=5 sp=8.0 tu=353.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.3_v0.1_kz5.0.ini >> $LOG 2>&1) || echo "[abi0] a=0.3 V0=0.1 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.3 V0=0.1 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.9_v0.03_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 180.1
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.9 V0=0.03 kz=3.5 (tier=half k=7 sp=10.0 tu=180.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.9_v0.03_kz3.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.9 V0=0.03 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.9 V0=0.03 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.6_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 185.4
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.6 V0=0.1 kz=5.5 (tier=half k=11 sp=8.0 tu=185.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.6_v0.1_kz5.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.6 V0=0.1 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a0.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.6 V0=0.1 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.4_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 375.4
run_tag = recorr
EOINI
echo "[abi0] a=0.4 V0=0.01 kz=1.0 (tier=int k=1 sp=14.0 tu=375.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.4_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[abi0] a=0.4 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.400_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.4 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.4_v0.2_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 196.7
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.4 V0=0.2 kz=5.5 (tier=half k=11 sp=8.0 tu=196.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.4_v0.2_kz5.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.4 V0=0.2 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a0.400_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.4 V0=0.2 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.6_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = recorr
EOINI
echo "[abi0] a=0.6 V0=0.01 kz=5.0 (tier=int k=5 sp=14.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.6_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[abi0] a=0.6 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.600_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.6 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.6_v0.01_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = recorr
EOINI
echo "[abi0] a=0.6 V0=0.01 kz=6.0 (tier=int k=6 sp=14.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.6_v0.01_kz6.0.ini >> $LOG 2>&1) || echo "[abi0] a=0.6 V0=0.01 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a0.600_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.6 V0=0.01 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.7_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = recorr
EOINI
echo "[abi0] a=0.7 V0=0.01 kz=5.0 (tier=int k=5 sp=14.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.7_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[abi0] a=0.7 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.700_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.7 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.3_v0.03_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = recorr
EOINI
echo "[abi0] a=0.3 V0=0.03 kz=7.0 (tier=int k=7 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.3_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[abi0] a=0.3 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.300_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.3 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.3_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = recorr
EOINI
echo "[abi0] a=0.3 V0=0.05 kz=8.0 (tier=int k=8 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.3_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[abi0] a=0.3 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a0.300_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.3 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.9_v0.01_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 201.3
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.9 V0=0.01 kz=6.5 (tier=half k=13 sp=9.0 tu=201.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.9_v0.01_kz6.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.9 V0=0.01 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.900_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.9 V0=0.01 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.3_v0.2_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 209.2
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.3 V0=0.2 kz=3.5 (tier=half k=7 sp=8.0 tu=209.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.3_v0.2_kz3.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.3 V0=0.2 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.300_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.3 V0=0.2 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.5_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 222.5
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.5 V0=0.1 kz=5.5 (tier=half k=11 sp=8.0 tu=222.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.5_v0.1_kz5.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.5 V0=0.1 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a0.500_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.5 V0=0.1 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.8_v0.01_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 229.9
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.8 V0=0.01 kz=1.5 (tier=half k=3 sp=22.0 tu=229.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.8_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.8 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a0.800_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.8 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.7_v0.05_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 244.3
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.7 V0=0.05 kz=6.5 (tier=half k=13 sp=8.0 tu=244.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.7_v0.05_kz6.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.7 V0=0.05 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a0.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.7 V0=0.05 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.3_v0.2_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 262.2
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.3 V0=0.2 kz=5.5 (tier=half k=11 sp=8.0 tu=262.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.3_v0.2_kz5.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.3 V0=0.2 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a0.300_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.3 V0=0.2 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.5_v0.05_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 284.6
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.5 V0=0.05 kz=4.5 (tier=half k=9 sp=8.0 tu=284.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.5_v0.05_kz4.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.5 V0=0.05 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.500_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.5 V0=0.05 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.8_v0.01_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 296.5
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.8 V0=0.01 kz=2.5 (tier=half k=5 sp=14.0 tu=296.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.8_v0.01_kz2.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.8 V0=0.01 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.800_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.8 V0=0.01 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.5_v0.03_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 324.1
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.5 V0=0.03 kz=3.5 (tier=half k=7 sp=8.0 tu=324.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.5_v0.03_kz3.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.5 V0=0.03 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.500_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.5 V0=0.03 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.8_v0.01_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 350.8
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.8 V0=0.01 kz=3.5 (tier=half k=7 sp=14.0 tu=350.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.8_v0.01_kz3.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.8 V0=0.01 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.800_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.8 V0=0.01 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.0_v0.01_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 382.4
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=1.0 V0=0.01 kz=6.5 (tier=half k=13 sp=12.0 tu=382.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.0_v0.01_kz6.5.ini >> $LOG 2>&1) || echo "[abi0] a=1.0 V0=0.01 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.000_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.0 V0=0.01 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.3_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.3 V0=0.01 kz=7.5 (tier=half k=15 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.3_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.3 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a0.300_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.3 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.4_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.4 V0=0.01 kz=7.5 (tier=half k=15 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.4_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.4 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a0.400_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.4 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.7_v0.01_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.7 V0=0.01 kz=4.5 (tier=half k=9 sp=14.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.7_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.7 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.700_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.7 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.8_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.8 V0=0.01 kz=0.125 (tier=fine k=1 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.8_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[abi0] a=0.8 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.800_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.8 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.1_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.1 V0=0.01 kz=0.125 (tier=fine k=1 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.1_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[abi0] a=1.1 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.100_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.1 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.5_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.5 V0=0.01 kz=0.125 (tier=fine k=1 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.5_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[abi0] a=1.5 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.500_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.5 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.6_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.6 V0=0.01 kz=0.125 (tier=fine k=1 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.6_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[abi0] a=1.6 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.600_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.6 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.8_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.8 V0=0.01 kz=0.75 (tier=fine k=6 sp=18.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.8_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[abi0] a=1.8 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.800_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.8 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.2_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.2 V0=0.01 kz=0.125 (tier=fine k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.2_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[abi0] a=2.2 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.200_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.2 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.2_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.2 V0=0.01 kz=2.125 (tier=fine k=17 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.2_v0.01_kz2.125.ini >> $LOG 2>&1) || echo "[abi0] a=2.2 V0=0.01 kz=2.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k17_a2.200_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.2 V0=0.01 kz=2.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.4_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.4 V0=0.01 kz=0.75 (tier=fine k=6 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.4_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[abi0] a=2.4 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.400_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.4 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.4_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.4 V0=0.01 kz=2.25 (tier=fine k=18 sp=13.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.4_v0.01_kz2.25.ini >> $LOG 2>&1) || echo "[abi0] a=2.4 V0=0.01 kz=2.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k18_a2.400_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.4 V0=0.01 kz=2.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.5_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.5 V0=0.01 kz=2.125 (tier=fine k=17 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.5_v0.01_kz2.125.ini >> $LOG 2>&1) || echo "[abi0] a=2.5 V0=0.01 kz=2.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k17_a2.500_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.5 V0=0.01 kz=2.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.7_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.7 V0=0.01 kz=0.25 (tier=fine k=2 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.7_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[abi0] a=2.7 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.700_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.7 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.9_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.9 V0=0.01 kz=1.125 (tier=fine k=9 sp=18.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.9_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[abi0] a=2.9 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.900_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.9 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.2_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.2 V0=0.03 kz=0.25 (tier=fine k=2 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.2_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[abi0] a=1.2 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.200_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.2 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.3_v0.03_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.3 V0=0.03 kz=1.875 (tier=fine k=15 sp=12.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.3_v0.03_kz1.875.ini >> $LOG 2>&1) || echo "[abi0] a=1.3 V0=0.03 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.300_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.3 V0=0.03 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.5_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.5 V0=0.03 kz=0.25 (tier=fine k=2 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.5_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[abi0] a=1.5 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.500_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.5 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.8_v0.03_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.8 V0=0.03 kz=1.625 (tier=fine k=13 sp=11.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.8_v0.03_kz1.625.ini >> $LOG 2>&1) || echo "[abi0] a=1.8 V0=0.03 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.800_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.8 V0=0.03 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.9_v0.03_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.9 V0=0.03 kz=0.125 (tier=fine k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.9_v0.03_kz0.125.ini >> $LOG 2>&1) || echo "[abi0] a=1.9 V0=0.03 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.9 V0=0.03 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.9_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.9 V0=0.03 kz=2.75 (tier=fine k=22 sp=18.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.9_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[abi0] a=1.9 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a1.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.9 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.0_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.0 V0=0.03 kz=2.625 (tier=fine k=21 sp=18.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.0_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a2.000_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.1_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.1 V0=0.03 kz=0.25 (tier=fine k=2 sp=6.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.1_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[abi0] a=2.1 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.100_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.1 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.2_v0.03_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.2 V0=0.03 kz=1.625 (tier=fine k=13 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.2_v0.03_kz1.625.ini >> $LOG 2>&1) || echo "[abi0] a=2.2 V0=0.03 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.200_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.2 V0=0.03 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.4_v0.03_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.4 V0=0.03 kz=0.125 (tier=fine k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.4_v0.03_kz0.125.ini >> $LOG 2>&1) || echo "[abi0] a=2.4 V0=0.03 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.400_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.4 V0=0.03 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.5_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.5 V0=0.03 kz=0.25 (tier=fine k=2 sp=6.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.5_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[abi0] a=2.5 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.500_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.5 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.6_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.6 V0=0.03 kz=0.875 (tier=fine k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.6_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[abi0] a=2.6 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.6 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.8_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.8 V0=0.03 kz=0.625 (tier=fine k=5 sp=6.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.8_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[abi0] a=2.8 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.800_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.8 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.9_v0.03_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.9 V0=0.03 kz=1.875 (tier=fine k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.9_v0.03_kz1.875.ini >> $LOG 2>&1) || echo "[abi0] a=2.9 V0=0.03 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.9 V0=0.03 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.9_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.9 V0=0.03 kz=2.75 (tier=fine k=22 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.9_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[abi0] a=2.9 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a2.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.9 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a3.0_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=3.0 V0=0.03 kz=1.75 (tier=fine k=14 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a3.0_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[abi0] a=3.0 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a3.000_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=3.0 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.4_v0.05_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi0] a=0.4 V0=0.05 kz=6.5 (tier=half k=13 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.4_v0.05_kz6.5.ini >> $LOG 2>&1) || echo "[abi0] a=0.4 V0=0.05 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a0.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.4 V0=0.05 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.8_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.8 V0=0.05 kz=0.875 (tier=fine k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.8_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[abi0] a=0.8 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.8 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.1_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 1.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.1 V0=0.05 kz=1.25 (tier=fine k=10 sp=12.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.1_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[abi0] a=1.1 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a1.100_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.1 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.2_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.2 V0=0.05 kz=2.625 (tier=fine k=21 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.2_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[abi0] a=1.2 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a1.200_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.2 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.4_v0.05_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.4 V0=0.05 kz=0.125 (tier=fine k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.4_v0.05_kz0.125.ini >> $LOG 2>&1) || echo "[abi0] a=1.4 V0=0.05 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.4 V0=0.05 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.4_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.4 V0=0.05 kz=2.625 (tier=fine k=21 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.4_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[abi0] a=1.4 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a1.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.4 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.5_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.5 V0=0.05 kz=2.75 (tier=fine k=22 sp=7.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.5_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[abi0] a=1.5 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a1.500_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.5 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.7_v0.05_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.7 V0=0.05 kz=0.125 (tier=fine k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.7_v0.05_kz0.125.ini >> $LOG 2>&1) || echo "[abi0] a=1.7 V0=0.05 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.7 V0=0.05 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.8_v0.05_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.8 V0=0.05 kz=0.25 (tier=fine k=2 sp=6.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.8_v0.05_kz0.25.ini >> $LOG 2>&1) || echo "[abi0] a=1.8 V0=0.05 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.8 V0=0.05 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.9_v0.05_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.9 V0=0.05 kz=1.875 (tier=fine k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.9_v0.05_kz1.875.ini >> $LOG 2>&1) || echo "[abi0] a=1.9 V0=0.05 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.900_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.9 V0=0.05 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.0_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.0 V0=0.05 kz=2.625 (tier=fine k=21 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.0_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a2.000_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.1_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.1 V0=0.05 kz=1.25 (tier=fine k=10 sp=7.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.1_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[abi0] a=2.1 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a2.100_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.1 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.2_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.2 V0=0.05 kz=2.875 (tier=fine k=23 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.2_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[abi0] a=2.2 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a2.200_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.2 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.3_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.3 V0=0.05 kz=1.25 (tier=fine k=10 sp=6.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.3_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[abi0] a=2.3 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a2.300_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.3 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.4_v0.05_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.4 V0=0.05 kz=1.625 (tier=fine k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.4_v0.05_kz1.625.ini >> $LOG 2>&1) || echo "[abi0] a=2.4 V0=0.05 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.4 V0=0.05 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.5_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.5 V0=0.05 kz=0.75 (tier=fine k=6 sp=5.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.5_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[abi0] a=2.5 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.500_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.5 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.6_v0.05_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.6 V0=0.05 kz=1.625 (tier=fine k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.6_v0.05_kz1.625.ini >> $LOG 2>&1) || echo "[abi0] a=2.6 V0=0.05 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.600_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.6 V0=0.05 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.8_v0.05_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.8 V0=0.05 kz=0.25 (tier=fine k=2 sp=5.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.8_v0.05_kz0.25.ini >> $LOG 2>&1) || echo "[abi0] a=2.8 V0=0.05 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.8 V0=0.05 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.8_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.8 V0=0.05 kz=1.75 (tier=fine k=14 sp=6.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.8_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[abi0] a=2.8 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a2.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.8 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.8_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.8 V0=0.05 kz=2.875 (tier=fine k=23 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.8_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[abi0] a=2.8 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a2.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.8 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.9_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.9 V0=0.05 kz=1.75 (tier=fine k=14 sp=6.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.9_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[abi0] a=2.9 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a2.900_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.9 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.7_v0.1_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.7 V0=0.1 kz=0.625 (tier=fine k=5 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.7_v0.1_kz0.625.ini >> $LOG 2>&1) || echo "[abi0] a=0.7 V0=0.1 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.700_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.7 V0=0.1 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.8_v0.1_kz0.375.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.8 V0=0.1 kz=0.375 (tier=fine k=3 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.8_v0.1_kz0.375.ini >> $LOG 2>&1) || echo "[abi0] a=0.8 V0=0.1 kz=0.375 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a0.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.8 V0=0.1 kz=0.375 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.8_v0.1_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.8 V0=0.1 kz=2.625 (tier=fine k=21 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.8_v0.1_kz2.625.ini >> $LOG 2>&1) || echo "[abi0] a=0.8 V0=0.1 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a0.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.8 V0=0.1 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.9_v0.1_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.9 V0=0.1 kz=0.75 (tier=fine k=6 sp=12.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.9_v0.1_kz0.75.ini >> $LOG 2>&1) || echo "[abi0] a=0.9 V0=0.1 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a0.900_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.9 V0=0.1 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.0_v0.1_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.0 V0=0.1 kz=1.25 (tier=fine k=10 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.0_v0.1_kz1.25.ini >> $LOG 2>&1) || echo "[abi0] a=1.0 V0=0.1 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a1.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.0 V0=0.1 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.0_v0.1_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.0 V0=0.1 kz=1.875 (tier=fine k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.0_v0.1_kz1.875.ini >> $LOG 2>&1) || echo "[abi0] a=1.0 V0=0.1 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.0 V0=0.1 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.1_v0.1_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.1 V0=0.1 kz=1.625 (tier=fine k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.1_v0.1_kz1.625.ini >> $LOG 2>&1) || echo "[abi0] a=1.1 V0=0.1 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.100_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.1 V0=0.1 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.3_v0.1_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.3 V0=0.1 kz=0.875 (tier=fine k=7 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.3_v0.1_kz0.875.ini >> $LOG 2>&1) || echo "[abi0] a=1.3 V0=0.1 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.3 V0=0.1 kz=0.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.3_v0.1_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.3 V0=0.1 kz=2.75 (tier=fine k=22 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.3_v0.1_kz2.75.ini >> $LOG 2>&1) || echo "[abi0] a=1.3 V0=0.1 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a1.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.3 V0=0.1 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.4_v0.1_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.4 V0=0.1 kz=1.625 (tier=fine k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.4_v0.1_kz1.625.ini >> $LOG 2>&1) || echo "[abi0] a=1.4 V0=0.1 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.400_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.4 V0=0.1 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.5_v0.1_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.5 V0=0.1 kz=0.125 (tier=fine k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.5_v0.1_kz0.125.ini >> $LOG 2>&1) || echo "[abi0] a=1.5 V0=0.1 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.500_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.5 V0=0.1 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.5_v0.1_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.5 V0=0.1 kz=2.625 (tier=fine k=21 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.5_v0.1_kz2.625.ini >> $LOG 2>&1) || echo "[abi0] a=1.5 V0=0.1 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a1.500_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.5 V0=0.1 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.6_v0.1_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.6 V0=0.1 kz=2.875 (tier=fine k=23 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.6_v0.1_kz2.875.ini >> $LOG 2>&1) || echo "[abi0] a=1.6 V0=0.1 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a1.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.6 V0=0.1 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.7_v0.1_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.7 V0=0.1 kz=1.875 (tier=fine k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.7_v0.1_kz1.875.ini >> $LOG 2>&1) || echo "[abi0] a=1.7 V0=0.1 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.700_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.7 V0=0.1 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.8_v0.1_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.8 V0=0.1 kz=0.75 (tier=fine k=6 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.8_v0.1_kz0.75.ini >> $LOG 2>&1) || echo "[abi0] a=1.8 V0=0.1 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.8 V0=0.1 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.0_v0.1_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.0 V0=0.1 kz=0.875 (tier=fine k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.0_v0.1_kz0.875.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.1 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.1 kz=0.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.1_v0.1_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.1 V0=0.1 kz=0.75 (tier=fine k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.1_v0.1_kz0.75.ini >> $LOG 2>&1) || echo "[abi0] a=2.1 V0=0.1 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.100_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.1 V0=0.1 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.1_v0.1_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.1 V0=0.1 kz=1.25 (tier=fine k=10 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.1_v0.1_kz1.25.ini >> $LOG 2>&1) || echo "[abi0] a=2.1 V0=0.1 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a2.100_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.1 V0=0.1 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.2_v0.1_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.2 V0=0.1 kz=0.625 (tier=fine k=5 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.2_v0.1_kz0.625.ini >> $LOG 2>&1) || echo "[abi0] a=2.2 V0=0.1 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.200_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.2 V0=0.1 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.3_v0.1_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.3 V0=0.1 kz=1.625 (tier=fine k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.3_v0.1_kz1.625.ini >> $LOG 2>&1) || echo "[abi0] a=2.3 V0=0.1 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.3 V0=0.1 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.5_v0.1_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.5 V0=0.1 kz=0.625 (tier=fine k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.5_v0.1_kz0.625.ini >> $LOG 2>&1) || echo "[abi0] a=2.5 V0=0.1 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.500_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.5 V0=0.1 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.6_v0.1_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.6 V0=0.1 kz=0.625 (tier=fine k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.6_v0.1_kz0.625.ini >> $LOG 2>&1) || echo "[abi0] a=2.6 V0=0.1 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.6 V0=0.1 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.7_v0.1_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.7 V0=0.1 kz=0.75 (tier=fine k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.7_v0.1_kz0.75.ini >> $LOG 2>&1) || echo "[abi0] a=2.7 V0=0.1 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.700_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.7 V0=0.1 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.8_v0.1_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.8 V0=0.1 kz=1.75 (tier=fine k=14 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.8_v0.1_kz1.75.ini >> $LOG 2>&1) || echo "[abi0] a=2.8 V0=0.1 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a2.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.8 V0=0.1 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.9_v0.1_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.9 V0=0.1 kz=0.25 (tier=fine k=2 sp=12.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.9_v0.1_kz0.25.ini >> $LOG 2>&1) || echo "[abi0] a=2.9 V0=0.1 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.900_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.9 V0=0.1 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a3.0_v0.1_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=3.0 V0=0.1 kz=2.875 (tier=fine k=23 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a3.0_v0.1_kz2.875.ini >> $LOG 2>&1) || echo "[abi0] a=3.0 V0=0.1 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a3.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=3.0 V0=0.1 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.4_v0.2_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.4 V0=0.2 kz=0.25 (tier=fine k=2 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.4_v0.2_kz0.25.ini >> $LOG 2>&1) || echo "[abi0] a=0.4 V0=0.2 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.400_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.4 V0=0.2 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.7_v0.2_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.7 V0=0.2 kz=0.125 (tier=fine k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.7_v0.2_kz0.125.ini >> $LOG 2>&1) || echo "[abi0] a=0.7 V0=0.2 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.7 V0=0.2 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.9_v0.2_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.9 V0=0.2 kz=0.875 (tier=fine k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.9_v0.2_kz0.875.ini >> $LOG 2>&1) || echo "[abi0] a=0.9 V0=0.2 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.900_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.9 V0=0.2 kz=0.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.9_v0.2_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.9 V0=0.2 kz=1.625 (tier=fine k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.9_v0.2_kz1.625.ini >> $LOG 2>&1) || echo "[abi0] a=0.9 V0=0.2 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a0.900_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.9 V0=0.2 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.0_v0.2_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.0 V0=0.2 kz=0.75 (tier=fine k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.0_v0.2_kz0.75.ini >> $LOG 2>&1) || echo "[abi0] a=1.0 V0=0.2 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.0 V0=0.2 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.1_v0.2_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.1 V0=0.2 kz=1.875 (tier=fine k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.1_v0.2_kz1.875.ini >> $LOG 2>&1) || echo "[abi0] a=1.1 V0=0.2 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.1 V0=0.2 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.2_v0.2_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.2 V0=0.2 kz=2.75 (tier=fine k=22 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.2_v0.2_kz2.75.ini >> $LOG 2>&1) || echo "[abi0] a=1.2 V0=0.2 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a1.200_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.2 V0=0.2 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.3_v0.2_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.3 V0=0.2 kz=2.625 (tier=fine k=21 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.3_v0.2_kz2.625.ini >> $LOG 2>&1) || echo "[abi0] a=1.3 V0=0.2 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a1.300_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.3 V0=0.2 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.4_v0.2_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 1.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.4 V0=0.2 kz=1.25 (tier=fine k=10 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.4_v0.2_kz1.25.ini >> $LOG 2>&1) || echo "[abi0] a=1.4 V0=0.2 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a1.400_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.4 V0=0.2 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.8_v0.2_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.8 V0=0.2 kz=0.625 (tier=fine k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.8_v0.2_kz0.625.ini >> $LOG 2>&1) || echo "[abi0] a=1.8 V0=0.2 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.8 V0=0.2 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.8_v0.2_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.8 V0=0.2 kz=2.75 (tier=fine k=22 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.8_v0.2_kz2.75.ini >> $LOG 2>&1) || echo "[abi0] a=1.8 V0=0.2 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a1.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.8 V0=0.2 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.9_v0.2_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 1.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.9 V0=0.2 kz=1.25 (tier=fine k=10 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.9_v0.2_kz1.25.ini >> $LOG 2>&1) || echo "[abi0] a=1.9 V0=0.2 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a1.900_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.9 V0=0.2 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.0_v0.2_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.0 V0=0.2 kz=0.125 (tier=fine k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.0_v0.2_kz0.125.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.2 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.2 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.1_v0.2_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.1 V0=0.2 kz=0.75 (tier=fine k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.1_v0.2_kz0.75.ini >> $LOG 2>&1) || echo "[abi0] a=2.1 V0=0.2 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.1 V0=0.2 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.1_v0.2_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.1 V0=0.2 kz=2.75 (tier=fine k=22 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.1_v0.2_kz2.75.ini >> $LOG 2>&1) || echo "[abi0] a=2.1 V0=0.2 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a2.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.1 V0=0.2 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.2_v0.2_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.2 V0=0.2 kz=2.75 (tier=fine k=22 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.2_v0.2_kz2.75.ini >> $LOG 2>&1) || echo "[abi0] a=2.2 V0=0.2 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a2.200_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.2 V0=0.2 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.5_v0.2_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.5 V0=0.2 kz=0.125 (tier=fine k=1 sp=12.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.5_v0.2_kz0.125.ini >> $LOG 2>&1) || echo "[abi0] a=2.5 V0=0.2 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.500_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.5 V0=0.2 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.5_v0.2_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.5 V0=0.2 kz=2.875 (tier=fine k=23 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.5_v0.2_kz2.875.ini >> $LOG 2>&1) || echo "[abi0] a=2.5 V0=0.2 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a2.500_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.5 V0=0.2 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.7_v0.2_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.7 V0=0.2 kz=1.75 (tier=fine k=14 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.7_v0.2_kz1.75.ini >> $LOG 2>&1) || echo "[abi0] a=2.7 V0=0.2 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a2.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.7 V0=0.2 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.7_v0.2_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.7 V0=0.2 kz=2.75 (tier=fine k=22 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.7_v0.2_kz2.75.ini >> $LOG 2>&1) || echo "[abi0] a=2.7 V0=0.2 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a2.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.7 V0=0.2 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.8_v0.2_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.8 V0=0.2 kz=1.75 (tier=fine k=14 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.8_v0.2_kz1.75.ini >> $LOG 2>&1) || echo "[abi0] a=2.8 V0=0.2 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a2.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.8 V0=0.2 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a3.0_v0.2_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 3.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=3.0 V0=0.2 kz=1.75 (tier=fine k=14 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a3.0_v0.2_kz1.75.ini >> $LOG 2>&1) || echo "[abi0] a=3.0 V0=0.2 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a3.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=3.0 V0=0.2 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a3.0_v0.2_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 3.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=3.0 V0=0.2 kz=2.625 (tier=fine k=21 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a3.0_v0.2_kz2.625.ini >> $LOG 2>&1) || echo "[abi0] a=3.0 V0=0.2 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a3.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=3.0 V0=0.2 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.3_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 102.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.3 V0=0.01 kz=0.75 (tier=fine k=6 sp=22.0 tu=102.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.3_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[abi0] a=1.3 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.300_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.3 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.3_v0.2_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 106.4
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.3 V0=0.2 kz=0.875 (tier=fine k=7 sp=14.0 tu=106.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.3_v0.2_kz0.875.ini >> $LOG 2>&1) || echo "[abi0] a=0.3 V0=0.2 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.300_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.3 V0=0.2 kz=0.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a2.3_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 108.3
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=2.3 V0=0.01 kz=2.75 (tier=fine k=22 sp=12.0 tu=108.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a2.3_v0.01_kz2.75.ini >> $LOG 2>&1) || echo "[abi0] a=2.3 V0=0.01 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a2.300_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=2.3 V0=0.01 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.3_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 110.6
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.3 V0=0.03 kz=2.75 (tier=fine k=22 sp=8.0 tu=110.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.3_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[abi0] a=1.3 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a1.300_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.3 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.0_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 113.9
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.0 V0=0.05 kz=2.875 (tier=fine k=23 sp=8.0 tu=113.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.0_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[abi0] a=1.0 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a1.000_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.0 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.0_v0.03_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 118.9
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.0 V0=0.03 kz=1.875 (tier=fine k=15 sp=13.0 tu=118.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.0_v0.03_kz1.875.ini >> $LOG 2>&1) || echo "[abi0] a=1.0 V0=0.03 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.000_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.0 V0=0.03 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.7_v0.05_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 122.6
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.7 V0=0.05 kz=1.625 (tier=fine k=13 sp=13.0 tu=122.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.7_v0.05_kz1.625.ini >> $LOG 2>&1) || echo "[abi0] a=0.7 V0=0.05 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a0.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.7 V0=0.05 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.9_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 0.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 127.6
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.9 V0=0.03 kz=1.75 (tier=fine k=14 sp=8.0 tu=127.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.9_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[abi0] a=0.9 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a0.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.9 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.0_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 131.6
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.0 V0=0.01 kz=0.75 (tier=fine k=6 sp=14.0 tu=131.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.0_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[abi0] a=1.0 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.000_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.0 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.8_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 138.3
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.8 V0=0.01 kz=2.75 (tier=fine k=22 sp=14.0 tu=138.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.8_v0.01_kz2.75.ini >> $LOG 2>&1) || echo "[abi0] a=1.8 V0=0.01 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a1.800_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.8 V0=0.01 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.8_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 142.3
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.8 V0=0.05 kz=2.875 (tier=fine k=23 sp=8.0 tu=142.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.8_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[abi0] a=0.8 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a0.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.8 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.3_v0.2_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 0.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 148.3
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.3 V0=0.2 kz=1.75 (tier=fine k=14 sp=10.0 tu=148.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.3_v0.2_kz1.75.ini >> $LOG 2>&1) || echo "[abi0] a=0.3 V0=0.2 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a0.300_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.3 V0=0.2 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a1.6_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 155.6
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=1.6 V0=0.01 kz=2.75 (tier=fine k=22 sp=14.0 tu=155.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a1.6_v0.01_kz2.75.ini >> $LOG 2>&1) || echo "[abi0] a=1.6 V0=0.01 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a1.600_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=1.6 V0=0.01 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.4_v0.1_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 162.6
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.4 V0=0.1 kz=1.875 (tier=fine k=15 sp=11.0 tu=162.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.4_v0.1_kz1.875.ini >> $LOG 2>&1) || echo "[abi0] a=0.4 V0=0.1 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a0.400_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.4 V0=0.1 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.4_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 173.3
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.4 V0=0.03 kz=0.625 (tier=fine k=5 sp=22.0 tu=173.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.4_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[abi0] a=0.4 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.400_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.4 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.3_v0.2_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 181.3
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.3 V0=0.2 kz=2.625 (tier=fine k=21 sp=8.0 tu=181.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.3_v0.2_kz2.625.ini >> $LOG 2>&1) || echo "[abi0] a=0.3 V0=0.2 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a0.300_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.3 V0=0.2 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.3_v0.2_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 189.7
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.3 V0=0.2 kz=2.875 (tier=fine k=23 sp=8.0 tu=189.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.3_v0.2_kz2.875.ini >> $LOG 2>&1) || echo "[abi0] a=0.3 V0=0.2 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a0.300_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.3 V0=0.2 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.8_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 199.4
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.8 V0=0.01 kz=1.125 (tier=fine k=9 sp=14.0 tu=199.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.8_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[abi0] a=0.8 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.800_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.8 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.4_v0.05_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 214.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.4 V0=0.05 kz=1.625 (tier=fine k=13 sp=14.0 tu=214.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.4_v0.05_kz1.625.ini >> $LOG 2>&1) || echo "[abi0] a=0.4 V0=0.05 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a0.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.4 V0=0.05 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.7_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 227.7
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.7 V0=0.01 kz=1.125 (tier=fine k=9 sp=22.0 tu=227.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.7_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[abi0] a=0.7 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.700_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.7 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.5_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 250.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.5 V0=0.01 kz=0.75 (tier=fine k=6 sp=22.0 tu=250.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.5_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[abi0] a=0.5 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a0.500_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.5 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.5_v0.01_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 250.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.5 V0=0.01 kz=1.75 (tier=fine k=14 sp=8.0 tu=250.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.5_v0.01_kz1.75.ini >> $LOG 2>&1) || echo "[abi0] a=0.5 V0=0.01 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a0.500_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.5 V0=0.01 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.7_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 250.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.7 V0=0.01 kz=2.125 (tier=fine k=17 sp=22.0 tu=250.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.7_v0.01_kz2.125.ini >> $LOG 2>&1) || echo "[abi0] a=0.7 V0=0.01 kz=2.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k17_a0.700_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.7 V0=0.01 kz=2.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.8_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 250.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.8 V0=0.01 kz=2.375 (tier=fine k=19 sp=10.0 tu=250.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.8_v0.01_kz2.375.ini >> $LOG 2>&1) || echo "[abi0] a=0.8 V0=0.01 kz=2.375 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k19_a0.800_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.8 V0=0.01 kz=2.375 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.9_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 250.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.9 V0=0.01 kz=2.75 (tier=fine k=22 sp=10.0 tu=250.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.9_v0.01_kz2.75.ini >> $LOG 2>&1) || echo "[abi0] a=0.9 V0=0.01 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a0.900_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.9 V0=0.01 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi0_a0.3_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 250.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi0] a=0.3 V0=0.03 kz=2.625 (tier=fine k=21 sp=8.0 tu=250.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi0_a0.3_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[abi0] a=0.3 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a0.300_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi0] a=0.3 V0=0.03 kz=2.625 done $(date)" >> $LOG

    echo "=== abi0 ALL DONE $(date) ===" >> $LOG
}

run_gpu1() {
    export CUDA_VISIBLE_DEVICES=1
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/recorr_abi1_progress.log
    echo "=== recorr abi1 start $(date) ===" >> $LOG
# ---- smoke test: binary deposits seed + extractor measures the right channel ----
cat > /tmp/recorr_smoke_abi1.ini <<'EOINI'
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
run_tag = smokeabi1
EOINI
rm -rf $WDIR/outputs/ym_k2_a1.000*smokeabi1*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_smoke_abi1.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000*smokeabi1" >> $LOG 2>&1)
python3 - "$WDIR" abi1 <<'EOPY' >> $LOG 2>&1 || { echo "[abi1] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, math, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k2_a1.000*smoke" + stream + "*/timeseries_k2.csv")
assert fs, "smoke: no timeseries written"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert rows and 'amp_conj' in rows[0], "smoke: extractor is not the fixed version"
a0 = float(rows[0]['amp'])
assert a0 > 0 and math.log(a0) > -20, "smoke: seed missing from measured channel (logamp=%.1f)" % (math.log(a0) if a0 > 0 else -99)
print("[%s] smoke test OK: logamp0=%.1f" % (stream, math.log(a0)))
EOPY
rm -rf $WDIR/outputs/ym_k2_a1.000*smokeabi1*

cat > /tmp/recorr_abi1_a2.7_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.7 V0=0.01 kz=1.0 (tier=int k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.7_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.7 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.700_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.7 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a3.0_v0.02_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 3.0
V0 = 0.02
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=3.0 V0=0.02 kz=4.0 (tier=int k=4 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a3.0_v0.02_kz4.0.ini >> $LOG 2>&1) || echo "[abi1] a=3.0 V0=0.02 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a3.000_*_v0.0200_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=3.0 V0=0.02 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.6_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=1.6 V0=0.03 kz=1.0 (tier=int k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.6_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.6 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.6 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.7_v0.03_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=1.7 V0=0.03 kz=3.0 (tier=int k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.7_v0.03_kz3.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.7 V0=0.03 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.700_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.7 V0=0.03 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.1_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.1 V0=0.03 kz=1.0 (tier=int k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.1_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.1 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.100_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.1 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.4_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.4 V0=0.03 kz=2.0 (tier=int k=2 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.4_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.4 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.400_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.4 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.6_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.6 V0=0.03 kz=1.0 (tier=int k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.6_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.6 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.6 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.6_v0.03_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.6 V0=0.03 kz=3.0 (tier=int k=3 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.6_v0.03_kz3.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.6 V0=0.03 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.6 V0=0.03 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.8_v0.03_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.8 V0=0.03 kz=6.0 (tier=int k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.8_v0.03_kz6.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.8 V0=0.03 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.800_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.8 V0=0.03 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.5_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=1.5 V0=0.05 kz=2.0 (tier=int k=2 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.5_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.5 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.500_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.5 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.7_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=1.7 V0=0.05 kz=2.0 (tier=int k=2 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.7_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.7 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.7 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.1_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.1 V0=0.05 kz=1.0 (tier=int k=1 sp=5.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.1_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.1 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.100_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.1 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.6_v0.05_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.6 V0=0.05 kz=4.0 (tier=int k=4 sp=12.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.6_v0.05_kz4.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.6 V0=0.05 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.600_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.6 V0=0.05 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.7_v0.05_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.7 V0=0.05 kz=4.0 (tier=int k=4 sp=12.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.7_v0.05_kz4.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.7 V0=0.05 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.7 V0=0.05 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.8_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.8 V0=0.05 kz=1.0 (tier=int k=1 sp=6.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.8_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.8 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.8 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.4_v0.1_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=1.4 V0=0.1 kz=3.0 (tier=int k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.4_v0.1_kz3.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.4 V0=0.1 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.400_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.4 V0=0.1 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.4_v0.1_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=1.4 V0=0.1 kz=5.0 (tier=int k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.4_v0.1_kz5.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.4 V0=0.1 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.400_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.4 V0=0.1 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.8_v0.1_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=1.8 V0=0.1 kz=2.0 (tier=int k=2 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.8_v0.1_kz2.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.8 V0=0.1 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.8 V0=0.1 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.0_v0.1_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.0 V0=0.1 kz=6.0 (tier=int k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.0_v0.1_kz6.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.0 V0=0.1 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.0 V0=0.1 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.1_v0.1_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.1 V0=0.1 kz=4.0 (tier=int k=4 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.1_v0.1_kz4.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.1 V0=0.1 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.100_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.1 V0=0.1 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.3_v0.1_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.3 V0=0.1 kz=2.0 (tier=int k=2 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.3_v0.1_kz2.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.3 V0=0.1 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.3 V0=0.1 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.4_v0.1_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.4 V0=0.1 kz=8.0 (tier=int k=8 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.4_v0.1_kz8.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.4 V0=0.1 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a2.400_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.4 V0=0.1 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.6_v0.1_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.6 V0=0.1 kz=7.0 (tier=int k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.6_v0.1_kz7.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.6 V0=0.1 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.6 V0=0.1 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.8_v0.1_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.8 V0=0.1 kz=3.0 (tier=int k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.8_v0.1_kz3.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.8 V0=0.1 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.8 V0=0.1 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.8_v0.1_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.8 V0=0.1 kz=8.0 (tier=int k=8 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.8_v0.1_kz8.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.8 V0=0.1 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a2.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.8 V0=0.1 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a4.0_v0.1_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 4.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=4.0 V0=0.1 kz=5.0 (tier=int k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a4.0_v0.1_kz5.0.ini >> $LOG 2>&1) || echo "[abi1] a=4.0 V0=0.1 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a4.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=4.0 V0=0.1 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.8_v0.2_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=0.8 V0=0.2 kz=5.0 (tier=int k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.8_v0.2_kz5.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.8 V0=0.2 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.8 V0=0.2 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.9_v0.2_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=0.9 V0=0.2 kz=1.0 (tier=int k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.9_v0.2_kz1.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.9 V0=0.2 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.900_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.9 V0=0.2 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.9_v0.2_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=0.9 V0=0.2 kz=2.0 (tier=int k=2 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.9_v0.2_kz2.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.9 V0=0.2 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.900_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.9 V0=0.2 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.0_v0.2_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=1.0 V0=0.2 kz=2.0 (tier=int k=2 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.0_v0.2_kz2.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.0 V0=0.2 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.0 V0=0.2 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.0_v0.2_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=1.0 V0=0.2 kz=6.0 (tier=int k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.0_v0.2_kz6.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.0 V0=0.2 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.0 V0=0.2 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.1_v0.2_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=1.1 V0=0.2 kz=3.0 (tier=int k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.1_v0.2_kz3.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.1 V0=0.2 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.1 V0=0.2 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.2_v0.2_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=1.2 V0=0.2 kz=7.0 (tier=int k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.2_v0.2_kz7.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.2 V0=0.2 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.200_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.2 V0=0.2 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.3_v0.2_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=1.3 V0=0.2 kz=5.0 (tier=int k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.3_v0.2_kz5.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.3 V0=0.2 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.300_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.3 V0=0.2 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.7_v0.2_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=1.7 V0=0.2 kz=7.0 (tier=int k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.7_v0.2_kz7.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.7 V0=0.2 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.7 V0=0.2 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.8_v0.2_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=1.8 V0=0.2 kz=6.0 (tier=int k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.8_v0.2_kz6.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.8 V0=0.2 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.8 V0=0.2 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.9_v0.2_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=1.9 V0=0.2 kz=6.0 (tier=int k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.9_v0.2_kz6.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.9 V0=0.2 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.900_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.9 V0=0.2 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.1_v0.2_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.1 V0=0.2 kz=5.0 (tier=int k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.1_v0.2_kz5.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.1 V0=0.2 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.1 V0=0.2 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.3_v0.2_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.3 V0=0.2 kz=8.0 (tier=int k=8 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.3_v0.2_kz8.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.3 V0=0.2 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a2.300_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.3 V0=0.2 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.4_v0.2_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.4 V0=0.2 kz=6.0 (tier=int k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.4_v0.2_kz6.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.4 V0=0.2 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.400_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.4 V0=0.2 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.5_v0.2_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.5 V0=0.2 kz=6.0 (tier=int k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.5_v0.2_kz6.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.5 V0=0.2 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.500_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.5 V0=0.2 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.7_v0.2_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.7 V0=0.2 kz=3.0 (tier=int k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.7_v0.2_kz3.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.7 V0=0.2 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.7 V0=0.2 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.8_v0.2_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=2.8 V0=0.2 kz=6.0 (tier=int k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.8_v0.2_kz6.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.8 V0=0.2 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.8 V0=0.2 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a3.0_v0.2_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 3.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi1] a=3.0 V0=0.2 kz=5.0 (tier=int k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a3.0_v0.2_kz5.0.ini >> $LOG 2>&1) || echo "[abi1] a=3.0 V0=0.2 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a3.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=3.0 V0=0.2 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.6_v0.01_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.1
run_tag = recorr
EOINI
echo "[abi1] a=2.6 V0=0.01 kz=3.0 (tier=int k=3 sp=22.0 tu=100.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.6_v0.01_kz3.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.6 V0=0.01 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.600_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.6 V0=0.01 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.9_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 103.5
run_tag = recorr
EOINI
echo "[abi1] a=2.9 V0=0.01 kz=4.0 (tier=int k=4 sp=22.0 tu=103.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.9_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.9 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.900_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.9 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.0_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 106.3
run_tag = recorr
EOINI
echo "[abi1] a=2.0 V0=0.01 kz=2.0 (tier=int k=2 sp=22.0 tu=106.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.0_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.0 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.000_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.0 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.2_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 111.4
run_tag = recorr
EOINI
echo "[abi1] a=2.2 V0=0.03 kz=8.0 (tier=int k=8 sp=8.0 tu=111.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.2_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.2 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a2.200_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.2 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.3_v0.03_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 115.5
run_tag = recorr
EOINI
echo "[abi1] a=1.3 V0=0.03 kz=3.0 (tier=int k=3 sp=9.0 tu=115.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.3_v0.03_kz3.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.3 V0=0.03 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.300_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.3 V0=0.03 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.5_v0.05_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 118.3
run_tag = recorr
EOINI
echo "[abi1] a=1.5 V0=0.05 kz=7.0 (tier=int k=7 sp=7.0 tu=118.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.5_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.5 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.500_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.5 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.6_v0.03_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 121.1
run_tag = recorr
EOINI
echo "[abi1] a=1.6 V0=0.03 kz=5.0 (tier=int k=5 sp=8.0 tu=121.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.6_v0.03_kz5.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.6 V0=0.03 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.6 V0=0.03 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.6_v0.2_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 125.0
run_tag = recorr
EOINI
echo "[abi1] a=0.6 V0=0.2 kz=5.0 (tier=int k=5 sp=8.0 tu=125.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.6_v0.2_kz5.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.6 V0=0.2 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.600_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.6 V0=0.2 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.0_v0.02_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.0
V0 = 0.02
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 129.9
run_tag = recorr
EOINI
echo "[abi1] a=2.0 V0=0.02 kz=6.0 (tier=int k=6 sp=8.0 tu=129.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.0_v0.02_kz6.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.0 V0=0.02 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.000_*_v0.0200_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.0 V0=0.02 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.4_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 135.5
run_tag = recorr
EOINI
echo "[abi1] a=1.4 V0=0.05 kz=8.0 (tier=int k=8 sp=8.0 tu=135.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.4_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.4 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.4 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.6_v0.1_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 137.0
run_tag = recorr
EOINI
echo "[abi1] a=0.6 V0=0.1 kz=3.0 (tier=int k=3 sp=8.0 tu=137.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.6_v0.1_kz3.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.6 V0=0.1 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a0.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.6 V0=0.1 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.8_v0.01_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 141.8
run_tag = recorr
EOINI
echo "[abi1] a=2.8 V0=0.01 kz=7.0 (tier=int k=7 sp=8.0 tu=141.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.8_v0.01_kz7.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.8 V0=0.01 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.800_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.8 V0=0.01 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.6_v0.2_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 147.9
run_tag = recorr
EOINI
echo "[abi1] a=0.6 V0=0.2 kz=7.0 (tier=int k=7 sp=8.0 tu=147.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.6_v0.2_kz7.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.6 V0=0.2 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.600_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.6 V0=0.2 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.7_v0.1_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 151.6
run_tag = recorr
EOINI
echo "[abi1] a=0.7 V0=0.1 kz=5.0 (tier=int k=5 sp=8.0 tu=151.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.7_v0.1_kz5.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.7 V0=0.1 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.700_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.7 V0=0.1 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.2_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 158.1
run_tag = recorr
EOINI
echo "[abi1] a=1.2 V0=0.05 kz=8.0 (tier=int k=8 sp=8.0 tu=158.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.2_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.2 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.200_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.2 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.5_v0.2_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 164.3
run_tag = recorr
EOINI
echo "[abi1] a=0.5 V0=0.2 kz=6.0 (tier=int k=6 sp=8.0 tu=164.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.5_v0.2_kz6.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.5 V0=0.2 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a0.500_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.5 V0=0.2 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.4_v0.2_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 167.8
run_tag = recorr
EOINI
echo "[abi1] a=0.4 V0=0.2 kz=4.0 (tier=int k=4 sp=8.0 tu=167.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.4_v0.2_kz4.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.4 V0=0.2 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a0.400_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.4 V0=0.2 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.1_v0.03_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 176.1
run_tag = recorr
EOINI
echo "[abi1] a=1.1 V0=0.03 kz=5.0 (tier=int k=5 sp=8.0 tu=176.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.1_v0.03_kz5.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.1 V0=0.03 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.100_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.1 V0=0.03 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.2_v0.01_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 180.4
run_tag = recorr
EOINI
echo "[abi1] a=2.2 V0=0.01 kz=7.0 (tier=int k=7 sp=8.0 tu=180.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.2_v0.01_kz7.0.ini >> $LOG 2>&1) || echo "[abi1] a=2.2 V0=0.01 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.200_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.2 V0=0.01 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.5_v0.2_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 189.7
run_tag = recorr
EOINI
echo "[abi1] a=0.5 V0=0.2 kz=8.0 (tier=int k=8 sp=8.0 tu=189.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.5_v0.2_kz8.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.5 V0=0.2 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a0.500_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.5 V0=0.2 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.9_v0.05_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 197.2
run_tag = recorr
EOINI
echo "[abi1] a=0.9 V0=0.05 kz=7.0 (tier=int k=7 sp=8.0 tu=197.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.9_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.9 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.900_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.9 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.5_v0.01_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.5 V0=0.01 kz=2.5 (tier=half k=5 sp=22.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.5_v0.01_kz2.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.5 V0=0.01 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.500_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.5 V0=0.01 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.8_v0.01_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.8 V0=0.01 kz=2.5 (tier=half k=5 sp=22.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.8_v0.01_kz2.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.8 V0=0.01 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.800_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.8 V0=0.01 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.9_v0.01_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.9 V0=0.01 kz=3.5 (tier=half k=7 sp=22.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.9_v0.01_kz3.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.9 V0=0.01 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.900_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.9 V0=0.01 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.4_v0.03_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.4 V0=0.03 kz=2.5 (tier=half k=5 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.4_v0.03_kz2.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.4 V0=0.03 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.400_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.4 V0=0.03 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.9_v0.03_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.9 V0=0.03 kz=4.5 (tier=half k=9 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.9_v0.03_kz4.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.9 V0=0.03 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.9 V0=0.03 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.1_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.1 V0=0.03 kz=0.5 (tier=half k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.1_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.1 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.100_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.1 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.1_v0.03_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.1 V0=0.03 kz=3.5 (tier=half k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.1_v0.03_kz3.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.1 V0=0.03 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.100_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.1 V0=0.03 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.6_v0.03_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.6 V0=0.03 kz=4.5 (tier=half k=9 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.6_v0.03_kz4.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.6 V0=0.03 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.6 V0=0.03 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a3.0_v0.03_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=3.0 V0=0.03 kz=1.5 (tier=half k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a3.0_v0.03_kz1.5.ini >> $LOG 2>&1) || echo "[abi1] a=3.0 V0=0.03 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a3.000_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=3.0 V0=0.03 kz=1.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a3.0_v0.03_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=3.0 V0=0.03 kz=4.5 (tier=half k=9 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a3.0_v0.03_kz4.5.ini >> $LOG 2>&1) || echo "[abi1] a=3.0 V0=0.03 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a3.000_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=3.0 V0=0.03 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a3.0_v0.03_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=3.0 V0=0.03 kz=6.5 (tier=half k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a3.0_v0.03_kz6.5.ini >> $LOG 2>&1) || echo "[abi1] a=3.0 V0=0.03 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a3.000_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=3.0 V0=0.03 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.5_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=0.5 V0=0.05 kz=0.5 (tier=half k=1 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.5_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[abi1] a=0.5 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.500_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.5 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.3_v0.05_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.3 V0=0.05 kz=3.5 (tier=half k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.3_v0.05_kz3.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.3 V0=0.05 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.300_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.3 V0=0.05 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.8_v0.05_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.8 V0=0.05 kz=4.5 (tier=half k=9 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.8_v0.05_kz4.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.8 V0=0.05 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.8 V0=0.05 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.9_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.9 V0=0.05 kz=7.5 (tier=half k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.9_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.9 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.900_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.9 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.4_v0.05_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.4 V0=0.05 kz=4.5 (tier=half k=9 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.4_v0.05_kz4.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.4 V0=0.05 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.4 V0=0.05 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.4_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.4 V0=0.05 kz=5.5 (tier=half k=11 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.4_v0.05_kz5.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.4 V0=0.05 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a2.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.4 V0=0.05 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.4_v0.05_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.4 V0=0.05 kz=6.5 (tier=half k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.4_v0.05_kz6.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.4 V0=0.05 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.4 V0=0.05 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.6_v0.05_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.6 V0=0.05 kz=1.5 (tier=half k=3 sp=5.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.6_v0.05_kz1.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.6 V0=0.05 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.600_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.6 V0=0.05 kz=1.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.8_v0.05_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.8 V0=0.05 kz=1.5 (tier=half k=3 sp=6.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.8_v0.05_kz1.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.8 V0=0.05 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.8 V0=0.05 kz=1.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.9_v0.05_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.9 V0=0.05 kz=3.5 (tier=half k=7 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.9_v0.05_kz3.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.9 V0=0.05 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.900_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.9 V0=0.05 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.5_v0.09_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.5
V0 = 0.09
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.5 V0=0.09 kz=2.5 (tier=half k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.5_v0.09_kz2.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.5 V0=0.09 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.500_*_v0.0900_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.5 V0=0.09 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.9_v0.1_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=0.9 V0=0.1 kz=3.5 (tier=half k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.9_v0.1_kz3.5.ini >> $LOG 2>&1) || echo "[abi1] a=0.9 V0=0.1 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.900_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.9 V0=0.1 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.0_v0.1_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.0 V0=0.1 kz=3.5 (tier=half k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.0_v0.1_kz3.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.0 V0=0.1 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.0 V0=0.1 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.3_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.3 V0=0.1 kz=6.5 (tier=half k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.3_v0.1_kz6.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.3 V0=0.1 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.3 V0=0.1 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.6_v0.1_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.6 V0=0.1 kz=0.5 (tier=half k=1 sp=11.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.6_v0.1_kz0.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.6 V0=0.1 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.6 V0=0.1 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.6_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.6 V0=0.1 kz=4.5 (tier=half k=9 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.6_v0.1_kz4.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.6 V0=0.1 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.6 V0=0.1 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.6_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.6 V0=0.1 kz=6.5 (tier=half k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.6_v0.1_kz6.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.6 V0=0.1 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.6 V0=0.1 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.8_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.8 V0=0.1 kz=4.5 (tier=half k=9 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.8_v0.1_kz4.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.8 V0=0.1 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.8 V0=0.1 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.8_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.8 V0=0.1 kz=7.5 (tier=half k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.8_v0.1_kz7.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.8 V0=0.1 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.8 V0=0.1 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.9_v0.1_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.9 V0=0.1 kz=0.5 (tier=half k=1 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.9_v0.1_kz0.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.9 V0=0.1 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.900_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.9 V0=0.1 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.9_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.9 V0=0.1 kz=7.5 (tier=half k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.9_v0.1_kz7.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.9 V0=0.1 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.900_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.9 V0=0.1 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.0_v0.1_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.0 V0=0.1 kz=3.5 (tier=half k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.0_v0.1_kz3.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.0 V0=0.1 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.0 V0=0.1 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.3_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.3 V0=0.1 kz=4.5 (tier=half k=9 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.3_v0.1_kz4.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.3 V0=0.1 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.3 V0=0.1 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.6_v0.1_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.6 V0=0.1 kz=3.5 (tier=half k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.6_v0.1_kz3.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.6 V0=0.1 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.6 V0=0.1 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.8_v0.1_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.8 V0=0.1 kz=3.5 (tier=half k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.8_v0.1_kz3.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.8 V0=0.1 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.8 V0=0.1 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a3.0_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=3.0 V0=0.1 kz=6.5 (tier=half k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a3.0_v0.1_kz6.5.ini >> $LOG 2>&1) || echo "[abi1] a=3.0 V0=0.1 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a3.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=3.0 V0=0.1 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.9_v0.2_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=0.9 V0=0.2 kz=6.5 (tier=half k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.9_v0.2_kz6.5.ini >> $LOG 2>&1) || echo "[abi1] a=0.9 V0=0.2 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a0.900_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.9 V0=0.2 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.0_v0.2_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.0 V0=0.2 kz=4.5 (tier=half k=9 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.0_v0.2_kz4.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.0 V0=0.2 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.0 V0=0.2 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.1_v0.2_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.1 V0=0.2 kz=0.5 (tier=half k=1 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.1_v0.2_kz0.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.1 V0=0.2 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.1 V0=0.2 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.1_v0.2_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.1 V0=0.2 kz=3.5 (tier=half k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.1_v0.2_kz3.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.1 V0=0.2 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.1 V0=0.2 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.4_v0.2_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.4 V0=0.2 kz=7.5 (tier=half k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.4_v0.2_kz7.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.4 V0=0.2 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.400_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.4 V0=0.2 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.6_v0.2_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.6 V0=0.2 kz=5.5 (tier=half k=11 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.6_v0.2_kz5.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.6 V0=0.2 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a1.600_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.6 V0=0.2 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.8_v0.2_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.8 V0=0.2 kz=3.5 (tier=half k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.8_v0.2_kz3.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.8 V0=0.2 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.8 V0=0.2 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.9_v0.2_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.9 V0=0.2 kz=6.5 (tier=half k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.9_v0.2_kz6.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.9 V0=0.2 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.900_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.9 V0=0.2 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.1_v0.2_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.1 V0=0.2 kz=5.5 (tier=half k=11 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.1_v0.2_kz5.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.1 V0=0.2 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a2.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.1 V0=0.2 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.6_v0.2_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.6 V0=0.2 kz=1.5 (tier=half k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.6_v0.2_kz1.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.6 V0=0.2 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.600_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.6 V0=0.2 kz=1.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.6_v0.2_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.6 V0=0.2 kz=4.5 (tier=half k=9 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.6_v0.2_kz4.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.6 V0=0.2 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.600_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.6 V0=0.2 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a3.0_v0.2_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 3.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=3.0 V0=0.2 kz=1.5 (tier=half k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a3.0_v0.2_kz1.5.ini >> $LOG 2>&1) || echo "[abi1] a=3.0 V0=0.2 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a3.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=3.0 V0=0.2 kz=1.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a3.0_v0.2_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 3.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=3.0 V0=0.2 kz=2.5 (tier=half k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a3.0_v0.2_kz2.5.ini >> $LOG 2>&1) || echo "[abi1] a=3.0 V0=0.2 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a3.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=3.0 V0=0.2 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.0_v0.03_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 101.6
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.0 V0=0.03 kz=5.5 (tier=half k=11 sp=8.0 tu=101.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.0_v0.03_kz5.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.0 V0=0.03 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a2.000_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.0 V0=0.03 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.4_v0.2_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 205.4
run_tag = recorr
EOINI
echo "[abi1] a=0.4 V0=0.2 kz=6.0 (tier=int k=6 sp=8.0 tu=205.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.4_v0.2_kz6.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.4 V0=0.2 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a0.400_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.4 V0=0.2 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.9_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 210.8
run_tag = recorr
EOINI
echo "[abi1] a=0.9 V0=0.05 kz=8.0 (tier=int k=8 sp=8.0 tu=210.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.9_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.9 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a0.900_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.9 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.9_v0.03_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 106.9
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.9 V0=0.03 kz=5.5 (tier=half k=11 sp=8.0 tu=106.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.9_v0.03_kz5.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.9 V0=0.03 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a1.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.9 V0=0.03 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.7_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 108.1
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.7 V0=0.05 kz=7.5 (tier=half k=15 sp=8.0 tu=108.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.7_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.7 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.7 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.8_v0.05_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 221.9
run_tag = recorr
EOINI
echo "[abi1] a=0.8 V0=0.05 kz=7.0 (tier=int k=7 sp=8.0 tu=221.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.8_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.8 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.8 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.5_v0.01_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 112.3
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.5 V0=0.01 kz=3.5 (tier=half k=7 sp=22.0 tu=112.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.5_v0.01_kz3.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.5 V0=0.01 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.500_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.5 V0=0.01 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.6_v0.03_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 114.9
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.6 V0=0.03 kz=4.5 (tier=half k=9 sp=8.0 tu=114.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.6_v0.03_kz4.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.6 V0=0.03 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.6 V0=0.03 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.8_v0.01_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 235.7
run_tag = recorr
EOINI
echo "[abi1] a=1.8 V0=0.01 kz=8.0 (tier=int k=8 sp=8.0 tu=235.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.8_v0.01_kz8.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.8 V0=0.01 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.800_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.8 V0=0.01 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.4_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 239.6
run_tag = recorr
EOINI
echo "[abi1] a=1.4 V0=0.01 kz=5.0 (tier=int k=5 sp=8.0 tu=239.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.4_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[abi1] a=1.4 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.400_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.4 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.5_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 122.5
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.5 V0=0.05 kz=7.5 (tier=half k=15 sp=7.0 tu=122.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.5_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.5 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.500_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.5 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.9_v0.01_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 125.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.9 V0=0.01 kz=2.5 (tier=half k=5 sp=22.0 tu=125.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.9_v0.01_kz2.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.9 V0=0.01 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.900_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.9 V0=0.01 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.6_v0.03_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 127.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.6 V0=0.03 kz=5.5 (tier=half k=11 sp=8.0 tu=127.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.6_v0.03_kz5.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.6 V0=0.03 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a1.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.6 V0=0.03 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.2_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 131.1
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.2 V0=0.05 kz=5.5 (tier=half k=11 sp=8.0 tu=131.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.2_v0.05_kz5.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.2 V0=0.05 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a1.200_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.2 V0=0.05 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.4_v0.1_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 265.2
run_tag = recorr
EOINI
echo "[abi1] a=0.4 V0=0.1 kz=5.0 (tier=int k=5 sp=8.0 tu=265.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.4_v0.1_kz5.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.4 V0=0.1 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.400_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.4 V0=0.1 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.7_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 271.1
run_tag = recorr
EOINI
echo "[abi1] a=0.7 V0=0.05 kz=8.0 (tier=int k=8 sp=9.0 tu=271.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.7_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.7 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a0.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.7 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.7_v0.03_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 276.7
run_tag = recorr
EOINI
echo "[abi1] a=0.7 V0=0.03 kz=5.0 (tier=int k=5 sp=10.0 tu=276.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.7_v0.03_kz5.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.7 V0=0.03 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.700_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.7 V0=0.03 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.3_v0.01_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 141.7
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.3 V0=0.01 kz=1.5 (tier=half k=3 sp=22.0 tu=141.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.3_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.3 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.300_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.3 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.2_v0.01_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 144.7
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=2.2 V0=0.01 kz=4.5 (tier=half k=9 sp=22.0 tu=144.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.2_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[abi1] a=2.2 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.200_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.2 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.3_v0.2_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 295.8
run_tag = recorr
EOINI
echo "[abi1] a=0.3 V0=0.2 kz=7.0 (tier=int k=7 sp=8.0 tu=295.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.3_v0.2_kz7.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.3 V0=0.2 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.300_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.3 V0=0.2 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.7_v0.03_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 151.9
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=0.7 V0=0.03 kz=1.5 (tier=half k=3 sp=8.0 tu=151.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.7_v0.03_kz1.5.ini >> $LOG 2>&1) || echo "[abi1] a=0.7 V0=0.03 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a0.700_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.7 V0=0.03 kz=1.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.2_v0.01_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 153.5
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.2 V0=0.01 kz=1.5 (tier=half k=3 sp=22.0 tu=153.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.2_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.2 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.200_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.2 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.6_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 316.2
run_tag = recorr
EOINI
echo "[abi1] a=0.6 V0=0.05 kz=8.0 (tier=int k=8 sp=8.0 tu=316.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.6_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.6 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a0.600_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.6 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.8_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 162.4
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=0.8 V0=0.1 kz=7.5 (tier=half k=15 sp=8.0 tu=162.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.8_v0.1_kz7.5.ini >> $LOG 2>&1) || echo "[abi1] a=0.8 V0=0.1 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a0.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.8 V0=0.1 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.1_v0.03_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 167.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.1 V0=0.03 kz=4.5 (tier=half k=9 sp=8.0 tu=167.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.1_v0.03_kz4.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.1 V0=0.03 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.100_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.1 V0=0.03 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.4_v0.01_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 169.5
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.4 V0=0.01 kz=2.5 (tier=half k=5 sp=22.0 tu=169.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.4_v0.01_kz2.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.4 V0=0.01 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.400_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.4 V0=0.01 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.6_v0.03_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 353.6
run_tag = recorr
EOINI
echo "[abi1] a=0.6 V0=0.03 kz=6.0 (tier=int k=6 sp=10.0 tu=353.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.6_v0.03_kz6.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.6 V0=0.03 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a0.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.6 V0=0.03 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.6_v0.01_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 179.7
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=0.6 V0=0.01 kz=0.5 (tier=half k=1 sp=22.0 tu=179.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.6_v0.01_kz0.5.ini >> $LOG 2>&1) || echo "[abi1] a=0.6 V0=0.01 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.600_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.6 V0=0.01 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.1_v0.03_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 184.7
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.1 V0=0.03 kz=5.5 (tier=half k=11 sp=8.0 tu=184.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.1_v0.03_kz5.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.1 V0=0.03 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a1.100_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.1 V0=0.03 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.9_v0.05_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 190.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=0.9 V0=0.05 kz=6.5 (tier=half k=13 sp=8.0 tu=190.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.9_v0.05_kz6.5.ini >> $LOG 2>&1) || echo "[abi1] a=0.9 V0=0.05 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a0.900_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.9 V0=0.05 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.2_v0.01_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 197.7
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.2 V0=0.01 kz=2.5 (tier=half k=5 sp=22.0 tu=197.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.2_v0.01_kz2.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.2 V0=0.01 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.200_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.2 V0=0.01 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.3_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = recorr
EOINI
echo "[abi1] a=0.3 V0=0.01 kz=4.0 (tier=int k=4 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.3_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.3 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a0.300_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.3 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.6_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = recorr
EOINI
echo "[abi1] a=0.6 V0=0.01 kz=4.0 (tier=int k=4 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.6_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.6 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a0.600_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.6 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.9_v0.01_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = recorr
EOINI
echo "[abi1] a=0.9 V0=0.01 kz=6.0 (tier=int k=6 sp=13.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.9_v0.01_kz6.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.9 V0=0.01 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a0.900_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.9 V0=0.01 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.3_v0.03_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = recorr
EOINI
echo "[abi1] a=0.3 V0=0.03 kz=4.0 (tier=int k=4 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.3_v0.03_kz4.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.3 V0=0.03 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a0.300_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.3 V0=0.03 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.2_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = recorr
EOINI
echo "[abi1] a=0.2 V0=0.05 kz=2.0 (tier=int k=2 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.2_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[abi1] a=0.2 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.200_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.2 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.5_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 201.3
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=0.5 V0=0.1 kz=4.5 (tier=half k=9 sp=8.0 tu=201.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.5_v0.1_kz4.5.ini >> $LOG 2>&1) || echo "[abi1] a=0.5 V0=0.1 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.500_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.5 V0=0.1 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.3_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 207.1
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=0.3 V0=0.03 kz=0.5 (tier=half k=1 sp=22.0 tu=207.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.3_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[abi1] a=0.3 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.300_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.3 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.4_v0.1_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 221.9
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=0.4 V0=0.1 kz=3.5 (tier=half k=7 sp=9.0 tu=221.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.4_v0.1_kz3.5.ini >> $LOG 2>&1) || echo "[abi1] a=0.4 V0=0.1 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.400_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.4 V0=0.1 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.7_v0.03_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 231.5
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=0.7 V0=0.03 kz=3.5 (tier=half k=7 sp=12.0 tu=231.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.7_v0.03_kz3.5.ini >> $LOG 2>&1) || echo "[abi1] a=0.7 V0=0.03 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.700_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.7 V0=0.03 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.3_v0.01_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 244.8
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.3 V0=0.01 kz=4.5 (tier=half k=9 sp=8.0 tu=244.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.3_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.3 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.300_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.3 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.7_v0.03_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 262.5
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=0.7 V0=0.03 kz=4.5 (tier=half k=9 sp=10.0 tu=262.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.7_v0.03_kz4.5.ini >> $LOG 2>&1) || echo "[abi1] a=0.7 V0=0.03 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.700_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.7 V0=0.03 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.6_v0.05_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 285.1
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=0.6 V0=0.05 kz=6.5 (tier=half k=13 sp=8.0 tu=285.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.6_v0.05_kz6.5.ini >> $LOG 2>&1) || echo "[abi1] a=0.6 V0=0.05 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a0.600_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.6 V0=0.05 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.8_v0.03_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 296.5
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=0.8 V0=0.03 kz=7.5 (tier=half k=15 sp=8.0 tu=296.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.8_v0.03_kz7.5.ini >> $LOG 2>&1) || echo "[abi1] a=0.8 V0=0.03 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a0.800_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.8 V0=0.03 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.2_v0.01_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 318.7
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.2 V0=0.01 kz=6.5 (tier=half k=13 sp=11.0 tu=318.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.2_v0.01_kz6.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.2 V0=0.01 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.200_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.2 V0=0.01 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.1_v0.01_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 347.7
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.1 V0=0.01 kz=6.5 (tier=half k=13 sp=12.0 tu=347.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.1_v0.01_kz6.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.1 V0=0.01 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.100_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.1 V0=0.01 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.9_v0.01_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 390.9
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=0.9 V0=0.01 kz=5.5 (tier=half k=11 sp=14.0 tu=390.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.9_v0.01_kz5.5.ini >> $LOG 2>&1) || echo "[abi1] a=0.9 V0=0.01 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a0.900_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.9 V0=0.01 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.4_v0.01_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=0.4 V0=0.01 kz=1.5 (tier=half k=3 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.4_v0.01_kz1.5.ini >> $LOG 2>&1) || echo "[abi1] a=0.4 V0=0.01 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a0.400_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.4 V0=0.01 kz=1.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.4_v0.01_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=0.4 V0=0.01 kz=6.5 (tier=half k=13 sp=14.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.4_v0.01_kz6.5.ini >> $LOG 2>&1) || echo "[abi1] a=0.4 V0=0.01 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a0.400_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.4 V0=0.01 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.6_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=0.6 V0=0.01 kz=7.5 (tier=half k=15 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.6_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[abi1] a=0.6 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a0.600_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.6 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.0_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=1.0 V0=0.01 kz=7.5 (tier=half k=15 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.0_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[abi1] a=1.0 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.000_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.0 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.8_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.8 V0=0.01 kz=0.25 (tier=fine k=2 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.8_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[abi1] a=1.8 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.800_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.8 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.3_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.3 V0=0.01 kz=2.25 (tier=fine k=18 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.3_v0.01_kz2.25.ini >> $LOG 2>&1) || echo "[abi1] a=2.3 V0=0.01 kz=2.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k18_a2.300_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.3 V0=0.01 kz=2.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.4_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.4 V0=0.01 kz=2.125 (tier=fine k=17 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.4_v0.01_kz2.125.ini >> $LOG 2>&1) || echo "[abi1] a=2.4 V0=0.01 kz=2.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k17_a2.400_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.4 V0=0.01 kz=2.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.5_v0.01_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.5 V0=0.01 kz=1.75 (tier=fine k=14 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.5_v0.01_kz1.75.ini >> $LOG 2>&1) || echo "[abi1] a=2.5 V0=0.01 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a2.500_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.5 V0=0.01 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.7_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.7 V0=0.01 kz=0.125 (tier=fine k=1 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.7_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[abi1] a=2.7 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.700_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.7 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.7_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.7 V0=0.01 kz=0.75 (tier=fine k=6 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.7_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[abi1] a=2.7 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.700_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.7 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.9_v0.01_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.9 V0=0.01 kz=0.75 (tier=fine k=6 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.9_v0.01_kz0.75.ini >> $LOG 2>&1) || echo "[abi1] a=2.9 V0=0.01 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.900_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.9 V0=0.01 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.1_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 1.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.1 V0=0.03 kz=1.25 (tier=fine k=10 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.1_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[abi1] a=1.1 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a1.100_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.1 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.5_v0.03_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.5 V0=0.03 kz=0.125 (tier=fine k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.5_v0.03_kz0.125.ini >> $LOG 2>&1) || echo "[abi1] a=1.5 V0=0.03 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.500_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.5 V0=0.03 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.6_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.6 V0=0.03 kz=2.875 (tier=fine k=23 sp=22.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.6_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[abi1] a=1.6 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a1.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.6 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.7_v0.03_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.7 V0=0.03 kz=0.125 (tier=fine k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.7_v0.03_kz0.125.ini >> $LOG 2>&1) || echo "[abi1] a=1.7 V0=0.03 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.700_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.7 V0=0.03 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.8_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 1.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.8 V0=0.03 kz=1.25 (tier=fine k=10 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.8_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[abi1] a=1.8 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a1.800_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.8 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.0_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.0 V0=0.03 kz=1.75 (tier=fine k=14 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.0_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[abi1] a=2.0 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a2.000_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.0 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.1_v0.03_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.1 V0=0.03 kz=0.125 (tier=fine k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.1_v0.03_kz0.125.ini >> $LOG 2>&1) || echo "[abi1] a=2.1 V0=0.03 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.100_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.1 V0=0.03 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.2_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.2 V0=0.03 kz=1.25 (tier=fine k=10 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.2_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[abi1] a=2.2 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a2.200_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.2 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.5_v0.03_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.5 V0=0.03 kz=0.125 (tier=fine k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.5_v0.03_kz0.125.ini >> $LOG 2>&1) || echo "[abi1] a=2.5 V0=0.03 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.500_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.5 V0=0.03 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.6_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.6 V0=0.03 kz=0.75 (tier=fine k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.6_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[abi1] a=2.6 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.6 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.6_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.6 V0=0.03 kz=1.25 (tier=fine k=10 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.6_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[abi1] a=2.6 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a2.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.6 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.8_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.8 V0=0.03 kz=0.25 (tier=fine k=2 sp=6.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.8_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[abi1] a=2.8 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.800_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.8 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.8_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.8 V0=0.03 kz=2.875 (tier=fine k=23 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.8_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[abi1] a=2.8 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a2.800_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.8 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.9_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.9 V0=0.03 kz=1.75 (tier=fine k=14 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.9_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[abi1] a=2.9 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a2.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.9 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a3.0_v0.03_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=3.0 V0=0.03 kz=1.625 (tier=fine k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a3.0_v0.03_kz1.625.ini >> $LOG 2>&1) || echo "[abi1] a=3.0 V0=0.03 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a3.000_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=3.0 V0=0.03 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.8_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.8 V0=0.05 kz=0.75 (tier=fine k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.8_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[abi1] a=0.8 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a0.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.8 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.0_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.0 V0=0.05 kz=1.75 (tier=fine k=14 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.0_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[abi1] a=1.0 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a1.000_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.0 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.1_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.1 V0=0.05 kz=0.875 (tier=fine k=7 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.1_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[abi1] a=1.1 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.100_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.1 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.2_v0.05_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.2 V0=0.05 kz=1.875 (tier=fine k=15 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.2_v0.05_kz1.875.ini >> $LOG 2>&1) || echo "[abi1] a=1.2 V0=0.05 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.200_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.2 V0=0.05 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.4_v0.05_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.4 V0=0.05 kz=0.75 (tier=fine k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.4_v0.05_kz0.75.ini >> $LOG 2>&1) || echo "[abi1] a=1.4 V0=0.05 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.4 V0=0.05 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.4_v0.05_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.4 V0=0.05 kz=1.875 (tier=fine k=15 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.4_v0.05_kz1.875.ini >> $LOG 2>&1) || echo "[abi1] a=1.4 V0=0.05 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.4 V0=0.05 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.5_v0.05_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.5 V0=0.05 kz=1.875 (tier=fine k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.5_v0.05_kz1.875.ini >> $LOG 2>&1) || echo "[abi1] a=1.5 V0=0.05 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.500_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.5 V0=0.05 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.5_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.5 V0=0.05 kz=2.625 (tier=fine k=21 sp=7.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.5_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[abi1] a=1.5 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a1.500_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.5 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.6_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.6 V0=0.05 kz=2.875 (tier=fine k=23 sp=12.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.6_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[abi1] a=1.6 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a1.600_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.6 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.7_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.7 V0=0.05 kz=2.625 (tier=fine k=21 sp=11.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.7_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[abi1] a=1.7 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a1.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.7 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.8_v0.05_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.8 V0=0.05 kz=0.125 (tier=fine k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.8_v0.05_kz0.125.ini >> $LOG 2>&1) || echo "[abi1] a=1.8 V0=0.05 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.8 V0=0.05 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.9_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.9 V0=0.05 kz=1.75 (tier=fine k=14 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.9_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[abi1] a=1.9 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a1.900_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.9 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.9_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.9 V0=0.05 kz=2.875 (tier=fine k=23 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.9_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[abi1] a=1.9 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a1.900_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.9 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.0_v0.05_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.0 V0=0.05 kz=1.875 (tier=fine k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.0_v0.05_kz1.875.ini >> $LOG 2>&1) || echo "[abi1] a=2.0 V0=0.05 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.000_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.0 V0=0.05 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.3_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.3 V0=0.05 kz=0.875 (tier=fine k=7 sp=6.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.3_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[abi1] a=2.3 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.300_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.3 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.5_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.5 V0=0.05 kz=0.625 (tier=fine k=5 sp=5.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.5_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[abi1] a=2.5 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.500_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.5 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.5_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.5 V0=0.05 kz=0.875 (tier=fine k=7 sp=5.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.5_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[abi1] a=2.5 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.500_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.5 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.6_v0.05_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.6 V0=0.05 kz=1.25 (tier=fine k=10 sp=5.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.6_v0.05_kz1.25.ini >> $LOG 2>&1) || echo "[abi1] a=2.6 V0=0.05 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a2.600_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.6 V0=0.05 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.7_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.7 V0=0.05 kz=1.75 (tier=fine k=14 sp=6.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.7_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[abi1] a=2.7 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a2.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.7 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.8_v0.05_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.8 V0=0.05 kz=1.625 (tier=fine k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.8_v0.05_kz1.625.ini >> $LOG 2>&1) || echo "[abi1] a=2.8 V0=0.05 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.8 V0=0.05 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.8_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.8 V0=0.05 kz=2.625 (tier=fine k=21 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.8_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[abi1] a=2.8 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a2.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.8 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.9_v0.05_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.9 V0=0.05 kz=1.625 (tier=fine k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.9_v0.05_kz1.625.ini >> $LOG 2>&1) || echo "[abi1] a=2.9 V0=0.05 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.900_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.9 V0=0.05 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.3_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi1] a=0.3 V0=0.1 kz=7.5 (tier=half k=15 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.3_v0.1_kz7.5.ini >> $LOG 2>&1) || echo "[abi1] a=0.3 V0=0.1 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a0.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.3 V0=0.1 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.7_v0.1_kz0.375.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.7 V0=0.1 kz=0.375 (tier=fine k=3 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.7_v0.1_kz0.375.ini >> $LOG 2>&1) || echo "[abi1] a=0.7 V0=0.1 kz=0.375 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a0.700_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.7 V0=0.1 kz=0.375 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.7_v0.1_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.7 V0=0.1 kz=0.75 (tier=fine k=6 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.7_v0.1_kz0.75.ini >> $LOG 2>&1) || echo "[abi1] a=0.7 V0=0.1 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a0.700_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.7 V0=0.1 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.8_v0.1_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.8 V0=0.1 kz=0.25 (tier=fine k=2 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.8_v0.1_kz0.25.ini >> $LOG 2>&1) || echo "[abi1] a=0.8 V0=0.1 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.8 V0=0.1 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.8_v0.1_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.8 V0=0.1 kz=0.625 (tier=fine k=5 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.8_v0.1_kz0.625.ini >> $LOG 2>&1) || echo "[abi1] a=0.8 V0=0.1 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.8 V0=0.1 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.9_v0.1_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.9 V0=0.1 kz=0.625 (tier=fine k=5 sp=13.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.9_v0.1_kz0.625.ini >> $LOG 2>&1) || echo "[abi1] a=0.9 V0=0.1 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.900_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.9 V0=0.1 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.0_v0.1_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.0 V0=0.1 kz=0.875 (tier=fine k=7 sp=11.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.0_v0.1_kz0.875.ini >> $LOG 2>&1) || echo "[abi1] a=1.0 V0=0.1 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.0 V0=0.1 kz=0.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.1_v0.1_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.1 V0=0.1 kz=1.25 (tier=fine k=10 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.1_v0.1_kz1.25.ini >> $LOG 2>&1) || echo "[abi1] a=1.1 V0=0.1 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a1.100_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.1 V0=0.1 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.3_v0.1_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.3 V0=0.1 kz=0.75 (tier=fine k=6 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.3_v0.1_kz0.75.ini >> $LOG 2>&1) || echo "[abi1] a=1.3 V0=0.1 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.3 V0=0.1 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.3_v0.1_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.3 V0=0.1 kz=2.625 (tier=fine k=21 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.3_v0.1_kz2.625.ini >> $LOG 2>&1) || echo "[abi1] a=1.3 V0=0.1 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a1.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.3 V0=0.1 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.4_v0.1_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.4 V0=0.1 kz=0.625 (tier=fine k=5 sp=11.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.4_v0.1_kz0.625.ini >> $LOG 2>&1) || echo "[abi1] a=1.4 V0=0.1 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.400_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.4 V0=0.1 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.4_v0.1_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.4 V0=0.1 kz=1.25 (tier=fine k=10 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.4_v0.1_kz1.25.ini >> $LOG 2>&1) || echo "[abi1] a=1.4 V0=0.1 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a1.400_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.4 V0=0.1 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.5_v0.1_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.5 V0=0.1 kz=1.875 (tier=fine k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.5_v0.1_kz1.875.ini >> $LOG 2>&1) || echo "[abi1] a=1.5 V0=0.1 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.500_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.5 V0=0.1 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.6_v0.1_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.6 V0=0.1 kz=2.75 (tier=fine k=22 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.6_v0.1_kz2.75.ini >> $LOG 2>&1) || echo "[abi1] a=1.6 V0=0.1 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a1.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.6 V0=0.1 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.8_v0.1_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.8 V0=0.1 kz=0.625 (tier=fine k=5 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.8_v0.1_kz0.625.ini >> $LOG 2>&1) || echo "[abi1] a=1.8 V0=0.1 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.8 V0=0.1 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.0_v0.1_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.0 V0=0.1 kz=0.75 (tier=fine k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.0_v0.1_kz0.75.ini >> $LOG 2>&1) || echo "[abi1] a=2.0 V0=0.1 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.0 V0=0.1 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.1_v0.1_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.1 V0=0.1 kz=0.625 (tier=fine k=5 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.1_v0.1_kz0.625.ini >> $LOG 2>&1) || echo "[abi1] a=2.1 V0=0.1 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.100_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.1 V0=0.1 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.2_v0.1_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.2 V0=0.1 kz=0.25 (tier=fine k=2 sp=13.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.2_v0.1_kz0.25.ini >> $LOG 2>&1) || echo "[abi1] a=2.2 V0=0.1 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.200_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.2 V0=0.1 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.3_v0.1_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.3 V0=0.1 kz=0.625 (tier=fine k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.3_v0.1_kz0.625.ini >> $LOG 2>&1) || echo "[abi1] a=2.3 V0=0.1 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.3 V0=0.1 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.3_v0.1_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.3 V0=0.1 kz=1.25 (tier=fine k=10 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.3_v0.1_kz1.25.ini >> $LOG 2>&1) || echo "[abi1] a=2.3 V0=0.1 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a2.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.3 V0=0.1 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.5_v0.1_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.5 V0=0.1 kz=0.25 (tier=fine k=2 sp=12.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.5_v0.1_kz0.25.ini >> $LOG 2>&1) || echo "[abi1] a=2.5 V0=0.1 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.500_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.5 V0=0.1 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.6_v0.1_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.6 V0=0.1 kz=0.25 (tier=fine k=2 sp=12.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.6_v0.1_kz0.25.ini >> $LOG 2>&1) || echo "[abi1] a=2.6 V0=0.1 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.6 V0=0.1 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.7_v0.1_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.7 V0=0.1 kz=0.625 (tier=fine k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.7_v0.1_kz0.625.ini >> $LOG 2>&1) || echo "[abi1] a=2.7 V0=0.1 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.700_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.7 V0=0.1 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.9_v0.1_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.9 V0=0.1 kz=0.125 (tier=fine k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.9_v0.1_kz0.125.ini >> $LOG 2>&1) || echo "[abi1] a=2.9 V0=0.1 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.900_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.9 V0=0.1 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a3.0_v0.1_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=3.0 V0=0.1 kz=2.75 (tier=fine k=22 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a3.0_v0.1_kz2.75.ini >> $LOG 2>&1) || echo "[abi1] a=3.0 V0=0.1 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a3.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=3.0 V0=0.1 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.4_v0.2_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.4 V0=0.2 kz=0.125 (tier=fine k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.4_v0.2_kz0.125.ini >> $LOG 2>&1) || echo "[abi1] a=0.4 V0=0.2 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.400_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.4 V0=0.2 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.6_v0.2_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.6 V0=0.2 kz=1.875 (tier=fine k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.6_v0.2_kz1.875.ini >> $LOG 2>&1) || echo "[abi1] a=0.6 V0=0.2 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a0.600_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.6 V0=0.2 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.7_v0.2_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.7 V0=0.2 kz=2.875 (tier=fine k=23 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.7_v0.2_kz2.875.ini >> $LOG 2>&1) || echo "[abi1] a=0.7 V0=0.2 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a0.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.7 V0=0.2 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.9_v0.2_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.9 V0=0.2 kz=0.25 (tier=fine k=2 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.9_v0.2_kz0.25.ini >> $LOG 2>&1) || echo "[abi1] a=0.9 V0=0.2 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.900_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.9 V0=0.2 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.9_v0.2_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 0.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.9 V0=0.2 kz=1.25 (tier=fine k=10 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.9_v0.2_kz1.25.ini >> $LOG 2>&1) || echo "[abi1] a=0.9 V0=0.2 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a0.900_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.9 V0=0.2 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.0_v0.2_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.0 V0=0.2 kz=0.625 (tier=fine k=5 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.0_v0.2_kz0.625.ini >> $LOG 2>&1) || echo "[abi1] a=1.0 V0=0.2 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.0 V0=0.2 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.2_v0.2_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.2 V0=0.2 kz=1.625 (tier=fine k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.2_v0.2_kz1.625.ini >> $LOG 2>&1) || echo "[abi1] a=1.2 V0=0.2 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.200_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.2 V0=0.2 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.2_v0.2_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.2 V0=0.2 kz=2.625 (tier=fine k=21 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.2_v0.2_kz2.625.ini >> $LOG 2>&1) || echo "[abi1] a=1.2 V0=0.2 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a1.200_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.2 V0=0.2 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.3_v0.2_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.3 V0=0.2 kz=1.875 (tier=fine k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.3_v0.2_kz1.875.ini >> $LOG 2>&1) || echo "[abi1] a=1.3 V0=0.2 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.300_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.3 V0=0.2 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.5_v0.2_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.5 V0=0.2 kz=0.25 (tier=fine k=2 sp=11.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.5_v0.2_kz0.25.ini >> $LOG 2>&1) || echo "[abi1] a=1.5 V0=0.2 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.500_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.5 V0=0.2 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.5_v0.2_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.5 V0=0.2 kz=0.875 (tier=fine k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.5_v0.2_kz0.875.ini >> $LOG 2>&1) || echo "[abi1] a=1.5 V0=0.2 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.500_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.5 V0=0.2 kz=0.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.5_v0.2_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.5 V0=0.2 kz=1.875 (tier=fine k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.5_v0.2_kz1.875.ini >> $LOG 2>&1) || echo "[abi1] a=1.5 V0=0.2 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.500_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.5 V0=0.2 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.7_v0.2_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.7 V0=0.2 kz=0.25 (tier=fine k=2 sp=11.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.7_v0.2_kz0.25.ini >> $LOG 2>&1) || echo "[abi1] a=1.7 V0=0.2 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.7 V0=0.2 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.7_v0.2_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.7 V0=0.2 kz=2.625 (tier=fine k=21 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.7_v0.2_kz2.625.ini >> $LOG 2>&1) || echo "[abi1] a=1.7 V0=0.2 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a1.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.7 V0=0.2 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.8_v0.2_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.8 V0=0.2 kz=0.25 (tier=fine k=2 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.8_v0.2_kz0.25.ini >> $LOG 2>&1) || echo "[abi1] a=1.8 V0=0.2 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.8 V0=0.2 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.8_v0.2_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.8 V0=0.2 kz=2.875 (tier=fine k=23 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.8_v0.2_kz2.875.ini >> $LOG 2>&1) || echo "[abi1] a=1.8 V0=0.2 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a1.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.8 V0=0.2 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.9_v0.2_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.9 V0=0.2 kz=0.875 (tier=fine k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.9_v0.2_kz0.875.ini >> $LOG 2>&1) || echo "[abi1] a=1.9 V0=0.2 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.900_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.9 V0=0.2 kz=0.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.9_v0.2_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.9 V0=0.2 kz=2.875 (tier=fine k=23 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.9_v0.2_kz2.875.ini >> $LOG 2>&1) || echo "[abi1] a=1.9 V0=0.2 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a1.900_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.9 V0=0.2 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.1_v0.2_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.1 V0=0.2 kz=0.625 (tier=fine k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.1_v0.2_kz0.625.ini >> $LOG 2>&1) || echo "[abi1] a=2.1 V0=0.2 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.1 V0=0.2 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.1_v0.2_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.1 V0=0.2 kz=2.625 (tier=fine k=21 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.1_v0.2_kz2.625.ini >> $LOG 2>&1) || echo "[abi1] a=2.1 V0=0.2 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a2.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.1 V0=0.2 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.1_v0.2_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.1 V0=0.2 kz=2.875 (tier=fine k=23 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.1_v0.2_kz2.875.ini >> $LOG 2>&1) || echo "[abi1] a=2.1 V0=0.2 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a2.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.1 V0=0.2 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.2_v0.2_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.2 V0=0.2 kz=2.625 (tier=fine k=21 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.2_v0.2_kz2.625.ini >> $LOG 2>&1) || echo "[abi1] a=2.2 V0=0.2 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a2.200_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.2 V0=0.2 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.3_v0.2_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.3 V0=0.2 kz=1.75 (tier=fine k=14 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.3_v0.2_kz1.75.ini >> $LOG 2>&1) || echo "[abi1] a=2.3 V0=0.2 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a2.300_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.3 V0=0.2 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.4_v0.2_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.4 V0=0.2 kz=2.875 (tier=fine k=23 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.4_v0.2_kz2.875.ini >> $LOG 2>&1) || echo "[abi1] a=2.4 V0=0.2 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a2.400_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.4 V0=0.2 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.5_v0.2_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.5 V0=0.2 kz=2.75 (tier=fine k=22 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.5_v0.2_kz2.75.ini >> $LOG 2>&1) || echo "[abi1] a=2.5 V0=0.2 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a2.500_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.5 V0=0.2 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.6_v0.2_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.6 V0=0.2 kz=0.875 (tier=fine k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.6_v0.2_kz0.875.ini >> $LOG 2>&1) || echo "[abi1] a=2.6 V0=0.2 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.600_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.6 V0=0.2 kz=0.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.7_v0.2_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.7 V0=0.2 kz=1.625 (tier=fine k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.7_v0.2_kz1.625.ini >> $LOG 2>&1) || echo "[abi1] a=2.7 V0=0.2 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.7 V0=0.2 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.8_v0.2_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.8 V0=0.2 kz=1.625 (tier=fine k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.8_v0.2_kz1.625.ini >> $LOG 2>&1) || echo "[abi1] a=2.8 V0=0.2 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.8 V0=0.2 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a2.2_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 102.5
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=2.2 V0=0.01 kz=2.25 (tier=fine k=18 sp=14.0 tu=102.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a2.2_v0.01_kz2.25.ini >> $LOG 2>&1) || echo "[abi1] a=2.2 V0=0.01 kz=2.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k18_a2.200_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=2.2 V0=0.01 kz=2.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.3_v0.1_kz0.375.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 105.2
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.3 V0=0.1 kz=0.375 (tier=fine k=3 sp=14.0 tu=105.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.3_v0.1_kz0.375.ini >> $LOG 2>&1) || echo "[abi1] a=0.3 V0=0.1 kz=0.375 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a0.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.3 V0=0.1 kz=0.375 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.3_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 108.1
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.3 V0=0.03 kz=2.625 (tier=fine k=21 sp=8.0 tu=108.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.3_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[abi1] a=1.3 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a1.300_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.3 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.8_v0.01_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 110.6
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.8 V0=0.01 kz=1.75 (tier=fine k=14 sp=14.0 tu=110.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.8_v0.01_kz1.75.ini >> $LOG 2>&1) || echo "[abi1] a=1.8 V0=0.01 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a1.800_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.8 V0=0.01 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.4_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 114.5
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.4 V0=0.01 kz=1.125 (tier=fine k=9 sp=22.0 tu=114.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.4_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[abi1] a=1.4 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.400_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.4 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.9_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 118.6
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.9 V0=0.01 kz=2.25 (tier=fine k=18 sp=14.0 tu=118.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.9_v0.01_kz2.25.ini >> $LOG 2>&1) || echo "[abi1] a=1.9 V0=0.01 kz=2.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k18_a1.900_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.9 V0=0.01 kz=2.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.9_v0.03_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 123.1
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.9 V0=0.03 kz=1.625 (tier=fine k=13 sp=14.0 tu=123.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.9_v0.03_kz1.625.ini >> $LOG 2>&1) || echo "[abi1] a=0.9 V0=0.03 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a0.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.9 V0=0.03 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.5_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 126.9
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.5 V0=0.05 kz=0.875 (tier=fine k=7 sp=14.0 tu=126.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.5_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[abi1] a=0.5 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.500_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.5 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.7_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 132.5
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.7 V0=0.01 kz=2.25 (tier=fine k=18 sp=14.0 tu=132.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.7_v0.01_kz2.25.ini >> $LOG 2>&1) || echo "[abi1] a=1.7 V0=0.01 kz=2.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k18_a1.700_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.7 V0=0.01 kz=2.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.5_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 137.8
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.5 V0=0.01 kz=0.125 (tier=fine k=1 sp=14.0 tu=137.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.5_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[abi1] a=0.5 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.500_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.5 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.4_v0.2_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 142.3
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.4 V0=0.2 kz=2.875 (tier=fine k=23 sp=8.0 tu=142.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.4_v0.2_kz2.875.ini >> $LOG 2>&1) || echo "[abi1] a=0.4 V0=0.2 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a0.400_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.4 V0=0.2 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.8_v0.03_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 148.5
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.8 V0=0.03 kz=1.875 (tier=fine k=15 sp=14.0 tu=148.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.8_v0.03_kz1.875.ini >> $LOG 2>&1) || echo "[abi1] a=0.8 V0=0.03 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a0.800_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.8 V0=0.03 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.9_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 156.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.9 V0=0.03 kz=2.625 (tier=fine k=21 sp=8.0 tu=156.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.9_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[abi1] a=0.9 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a0.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.9 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.6_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 0.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 161.9
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.6 V0=0.03 kz=1.25 (tier=fine k=10 sp=14.0 tu=161.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.6_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[abi1] a=0.6 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a0.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.6 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.5_v0.05_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 171.3
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.5 V0=0.05 kz=1.625 (tier=fine k=13 sp=14.0 tu=171.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.5_v0.05_kz1.625.ini >> $LOG 2>&1) || echo "[abi1] a=0.5 V0=0.05 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a0.500_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.5 V0=0.05 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.6_v0.05_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 181.3
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.6 V0=0.05 kz=2.625 (tier=fine k=21 sp=8.0 tu=181.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.6_v0.05_kz2.625.ini >> $LOG 2>&1) || echo "[abi1] a=0.6 V0=0.05 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a0.600_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.6 V0=0.05 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.6_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 189.7
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.6 V0=0.05 kz=2.875 (tier=fine k=23 sp=8.0 tu=189.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.6_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[abi1] a=0.6 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a0.600_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.6 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a1.1_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 198.9
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=1.1 V0=0.01 kz=2.125 (tier=fine k=17 sp=14.0 tu=198.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a1.1_v0.01_kz2.125.ini >> $LOG 2>&1) || echo "[abi1] a=1.1 V0=0.01 kz=2.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k17_a1.100_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=1.1 V0=0.01 kz=2.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.3_v0.1_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 216.7
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.3 V0=0.1 kz=1.875 (tier=fine k=15 sp=13.0 tu=216.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.3_v0.1_kz1.875.ini >> $LOG 2>&1) || echo "[abi1] a=0.3 V0=0.1 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a0.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.3 V0=0.1 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.5_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 227.6
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.5 V0=0.05 kz=2.875 (tier=fine k=23 sp=8.0 tu=227.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.5_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[abi1] a=0.5 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a0.500_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.5 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.4_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 250.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.4 V0=0.01 kz=2.75 (tier=fine k=22 sp=8.0 tu=250.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.4_v0.01_kz2.75.ini >> $LOG 2>&1) || echo "[abi1] a=0.4 V0=0.01 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a0.400_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.4 V0=0.01 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.8_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 250.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.8 V0=0.01 kz=2.25 (tier=fine k=18 sp=22.0 tu=250.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.8_v0.01_kz2.25.ini >> $LOG 2>&1) || echo "[abi1] a=0.8 V0=0.01 kz=2.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k18_a0.800_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.8 V0=0.01 kz=2.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.9_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 0.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 250.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.9 V0=0.01 kz=2.375 (tier=fine k=19 sp=22.0 tu=250.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.9_v0.01_kz2.375.ini >> $LOG 2>&1) || echo "[abi1] a=0.9 V0=0.01 kz=2.375 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k19_a0.900_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.9 V0=0.01 kz=2.375 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.3_v0.03_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 250.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.3 V0=0.03 kz=1.875 (tier=fine k=15 sp=14.0 tu=250.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.3_v0.03_kz1.875.ini >> $LOG 2>&1) || echo "[abi1] a=0.3 V0=0.03 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a0.300_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.3 V0=0.03 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.4_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 250.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.4 V0=0.03 kz=2.875 (tier=fine k=23 sp=8.0 tu=250.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.4_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[abi1] a=0.4 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a0.400_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.4 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi1_a0.4_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 250.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi1] a=0.4 V0=0.05 kz=2.875 (tier=fine k=23 sp=8.0 tu=250.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi1_a0.4_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[abi1] a=0.4 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a0.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi1] a=0.4 V0=0.05 kz=2.875 done $(date)" >> $LOG

    echo "=== abi1 ALL DONE $(date) ===" >> $LOG
}

run_gpu2() {
    export CUDA_VISIBLE_DEVICES=2
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/recorr_abi2_progress.log
    echo "=== recorr abi2 start $(date) ===" >> $LOG
# ---- smoke test: binary deposits seed + extractor measures the right channel ----
cat > /tmp/recorr_smoke_abi2.ini <<'EOINI'
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
run_tag = smokeabi2
EOINI
rm -rf $WDIR/outputs/ym_k2_a1.000*smokeabi2*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_smoke_abi2.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000*smokeabi2" >> $LOG 2>&1)
python3 - "$WDIR" abi2 <<'EOPY' >> $LOG 2>&1 || { echo "[abi2] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, math, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k2_a1.000*smoke" + stream + "*/timeseries_k2.csv")
assert fs, "smoke: no timeseries written"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert rows and 'amp_conj' in rows[0], "smoke: extractor is not the fixed version"
a0 = float(rows[0]['amp'])
assert a0 > 0 and math.log(a0) > -20, "smoke: seed missing from measured channel (logamp=%.1f)" % (math.log(a0) if a0 > 0 else -99)
print("[%s] smoke test OK: logamp0=%.1f" % (stream, math.log(a0)))
EOPY
rm -rf $WDIR/outputs/ym_k2_a1.000*smokeabi2*

cat > /tmp/recorr_abi2_a2.3_v0.01_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.3 V0=0.01 kz=1.0 (tier=int k=1 sp=18.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.3_v0.01_kz1.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.3 V0=0.01 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.300_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.3 V0=0.01 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.4_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.4 V0=0.01 kz=2.0 (tier=int k=2 sp=22.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.4_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.4 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.400_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.4 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.6_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.6 V0=0.01 kz=2.0 (tier=int k=2 sp=22.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.6_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.6 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.600_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.6 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a3.0_v0.02_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 3.0
V0 = 0.02
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=3.0 V0=0.02 kz=5.0 (tier=int k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a3.0_v0.02_kz5.0.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.02 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a3.000_*_v0.0200_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.02 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.6_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=1.6 V0=0.03 kz=2.0 (tier=int k=2 sp=18.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.6_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.6 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.6 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.7_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=1.7 V0=0.03 kz=1.0 (tier=int k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.7_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.7 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.700_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.7 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.3_v0.03_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.3 V0=0.03 kz=1.0 (tier=int k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.3_v0.03_kz1.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.3 V0=0.03 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.300_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.3 V0=0.03 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.4_v0.03_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.4 V0=0.03 kz=3.0 (tier=int k=3 sp=18.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.4_v0.03_kz3.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.4 V0=0.03 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.400_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.4 V0=0.03 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.6_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.6 V0=0.03 kz=2.0 (tier=int k=2 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.6_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.6 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.6 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.7_v0.03_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.7 V0=0.03 kz=5.0 (tier=int k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.7_v0.03_kz5.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.7 V0=0.03 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.700_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.7 V0=0.03 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.7_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=1.7 V0=0.05 kz=3.0 (tier=int k=3 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.7_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.7 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.7 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.1_v0.05_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.1 V0=0.05 kz=2.0 (tier=int k=2 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.1_v0.05_kz2.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.1 V0=0.05 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.100_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.1 V0=0.05 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.3_v0.05_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.3 V0=0.05 kz=3.0 (tier=int k=3 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.3_v0.05_kz3.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.3 V0=0.05 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.300_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.3 V0=0.05 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.7_v0.05_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.7 V0=0.05 kz=6.0 (tier=int k=6 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.7_v0.05_kz6.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.7 V0=0.05 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.7 V0=0.05 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.7_v0.1_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=0.7 V0=0.1 kz=2.0 (tier=int k=2 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.7_v0.1_kz2.0.ini >> $LOG 2>&1) || echo "[abi2] a=0.7 V0=0.1 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.700_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.7 V0=0.1 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.9_v0.1_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=0.9 V0=0.1 kz=1.0 (tier=int k=1 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.9_v0.1_kz1.0.ini >> $LOG 2>&1) || echo "[abi2] a=0.9 V0=0.1 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.900_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.9 V0=0.1 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.3_v0.1_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=1.3 V0=0.1 kz=2.0 (tier=int k=2 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.3_v0.1_kz2.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.3 V0=0.1 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.3 V0=0.1 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.8_v0.1_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=1.8 V0=0.1 kz=3.0 (tier=int k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.8_v0.1_kz3.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.8 V0=0.1 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.8 V0=0.1 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.0_v0.1_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.0 V0=0.1 kz=7.0 (tier=int k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.0_v0.1_kz7.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.0 V0=0.1 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.0 V0=0.1 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.1_v0.1_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.1 V0=0.1 kz=1.0 (tier=int k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.1_v0.1_kz1.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.1 V0=0.1 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.100_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.1 V0=0.1 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.3_v0.1_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.3 V0=0.1 kz=3.0 (tier=int k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.3_v0.1_kz3.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.3 V0=0.1 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.3 V0=0.1 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.5_v0.1_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.5 V0=0.1 kz=1.0 (tier=int k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.5_v0.1_kz1.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.5 V0=0.1 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.500_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.5 V0=0.1 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.8_v0.1_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.8 V0=0.1 kz=4.0 (tier=int k=4 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.8_v0.1_kz4.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.8 V0=0.1 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.8 V0=0.1 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.9_v0.1_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.9 V0=0.1 kz=1.0 (tier=int k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.9_v0.1_kz1.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.9 V0=0.1 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.900_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.9 V0=0.1 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.9_v0.2_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=0.9 V0=0.2 kz=3.0 (tier=int k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.9_v0.2_kz3.0.ini >> $LOG 2>&1) || echo "[abi2] a=0.9 V0=0.2 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a0.900_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.9 V0=0.2 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.0_v0.2_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=1.0 V0=0.2 kz=3.0 (tier=int k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.0_v0.2_kz3.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.2 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.2 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.1_v0.2_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=1.1 V0=0.2 kz=4.0 (tier=int k=4 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.1_v0.2_kz4.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.1 V0=0.2 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a1.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.1 V0=0.2 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.3_v0.2_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=1.3 V0=0.2 kz=6.0 (tier=int k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.3_v0.2_kz6.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.3 V0=0.2 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.300_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.3 V0=0.2 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.7_v0.2_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=1.7 V0=0.2 kz=5.0 (tier=int k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.7_v0.2_kz5.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.7 V0=0.2 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.7 V0=0.2 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.7_v0.2_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=1.7 V0=0.2 kz=8.0 (tier=int k=8 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.7_v0.2_kz8.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.7 V0=0.2 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.7 V0=0.2 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.9_v0.2_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=1.9 V0=0.2 kz=7.0 (tier=int k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.9_v0.2_kz7.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.9 V0=0.2 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.900_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.9 V0=0.2 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.1_v0.2_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.1 V0=0.2 kz=3.0 (tier=int k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.1_v0.2_kz3.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.1 V0=0.2 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.1 V0=0.2 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.1_v0.2_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.1 V0=0.2 kz=6.0 (tier=int k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.1_v0.2_kz6.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.1 V0=0.2 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.1 V0=0.2 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.2_v0.2_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.2 V0=0.2 kz=6.0 (tier=int k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.2_v0.2_kz6.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.2 V0=0.2 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.200_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.2 V0=0.2 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.3_v0.2_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.3 V0=0.2 kz=2.0 (tier=int k=2 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.3_v0.2_kz2.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.3 V0=0.2 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.300_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.3 V0=0.2 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.4_v0.2_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.4 V0=0.2 kz=1.0 (tier=int k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.4_v0.2_kz1.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.4 V0=0.2 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.400_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.4 V0=0.2 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.4_v0.2_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.4 V0=0.2 kz=7.0 (tier=int k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.4_v0.2_kz7.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.4 V0=0.2 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.400_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.4 V0=0.2 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.5_v0.2_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.5 V0=0.2 kz=7.0 (tier=int k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.5_v0.2_kz7.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.5 V0=0.2 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.500_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.5 V0=0.2 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.6_v0.2_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.6 V0=0.2 kz=6.0 (tier=int k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.6_v0.2_kz6.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.6 V0=0.2 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.600_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.6 V0=0.2 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.7_v0.2_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.7 V0=0.2 kz=4.0 (tier=int k=4 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.7_v0.2_kz4.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.7 V0=0.2 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.7 V0=0.2 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.7_v0.2_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.7 V0=0.2 kz=7.0 (tier=int k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.7_v0.2_kz7.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.7 V0=0.2 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.7 V0=0.2 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.8_v0.2_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.8 V0=0.2 kz=2.0 (tier=int k=2 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.8_v0.2_kz2.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.8 V0=0.2 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.8 V0=0.2 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.8_v0.2_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=2.8 V0=0.2 kz=7.0 (tier=int k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.8_v0.2_kz7.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.8 V0=0.2 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.8 V0=0.2 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a3.0_v0.2_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 3.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[abi2] a=3.0 V0=0.2 kz=4.0 (tier=int k=4 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a3.0_v0.2_kz4.0.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.2 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a3.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.2 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a3.0_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.1
run_tag = recorr
EOINI
echo "[abi2] a=3.0 V0=0.01 kz=4.0 (tier=int k=4 sp=22.0 tu=100.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a3.0_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a3.000_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.3_v0.05_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 103.3
run_tag = recorr
EOINI
echo "[abi2] a=1.3 V0=0.05 kz=4.0 (tier=int k=4 sp=8.0 tu=103.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.3_v0.05_kz4.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.3 V0=0.05 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a1.300_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.3 V0=0.05 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.3_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 2.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 106.5
run_tag = recorr
EOINI
echo "[abi2] a=2.3 V0=0.03 kz=8.0 (tier=int k=8 sp=8.0 tu=106.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.3_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.3 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a2.300_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.3 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.7_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 111.2
run_tag = recorr
EOINI
echo "[abi2] a=2.7 V0=0.01 kz=4.0 (tier=int k=4 sp=22.0 tu=111.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.7_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.7 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.700_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.7 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.6_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 115.4
run_tag = recorr
EOINI
echo "[abi2] a=2.6 V0=0.01 kz=4.0 (tier=int k=4 sp=22.0 tu=115.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.6_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.6 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.600_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.6 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.8_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 118.1
run_tag = recorr
EOINI
echo "[abi2] a=1.8 V0=0.01 kz=2.0 (tier=int k=2 sp=22.0 tu=118.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.8_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.8 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.800_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.8 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.1_v0.1_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 122.0
run_tag = recorr
EOINI
echo "[abi2] a=1.1 V0=0.1 kz=8.0 (tier=int k=8 sp=8.0 tu=122.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.1_v0.1_kz8.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.1 V0=0.1 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.100_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.1 V0=0.1 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.4_v0.01_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 2.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 125.1
run_tag = recorr
EOINI
echo "[abi2] a=2.4 V0=0.01 kz=4.0 (tier=int k=4 sp=22.0 tu=125.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.4_v0.01_kz4.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.4 V0=0.01 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.400_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.4 V0=0.01 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.9_v0.1_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 129.1
run_tag = recorr
EOINI
echo "[abi2] a=0.9 V0=0.1 kz=6.0 (tier=int k=6 sp=8.0 tu=129.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.9_v0.1_kz6.0.ini >> $LOG 2>&1) || echo "[abi2] a=0.9 V0=0.1 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a0.900_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.9 V0=0.1 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.5_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 135.2
run_tag = recorr
EOINI
echo "[abi2] a=0.5 V0=0.05 kz=1.0 (tier=int k=1 sp=8.0 tu=135.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.5_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[abi2] a=0.5 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.500_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.5 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.9_v0.01_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 136.9
run_tag = recorr
EOINI
echo "[abi2] a=2.9 V0=0.01 kz=7.0 (tier=int k=7 sp=8.0 tu=136.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.9_v0.01_kz7.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.9 V0=0.01 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.900_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.9 V0=0.01 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.6_v0.03_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 143.2
run_tag = recorr
EOINI
echo "[abi2] a=1.6 V0=0.03 kz=7.0 (tier=int k=7 sp=8.0 tu=143.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.6_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.6 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.6 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.5_v0.01_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 147.0
run_tag = recorr
EOINI
echo "[abi2] a=2.5 V0=0.01 kz=6.0 (tier=int k=6 sp=8.0 tu=147.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.5_v0.01_kz6.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.5 V0=0.01 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.500_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.5 V0=0.01 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.4_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 151.7
run_tag = recorr
EOINI
echo "[abi2] a=1.4 V0=0.01 kz=2.0 (tier=int k=2 sp=22.0 tu=151.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.4_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.4 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.400_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.4 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.6_v0.1_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 158.2
run_tag = recorr
EOINI
echo "[abi2] a=0.6 V0=0.1 kz=4.0 (tier=int k=4 sp=8.0 tu=158.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.6_v0.1_kz4.0.ini >> $LOG 2>&1) || echo "[abi2] a=0.6 V0=0.1 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a0.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.6 V0=0.1 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.3_v0.01_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 163.4
run_tag = recorr
EOINI
echo "[abi2] a=1.3 V0=0.01 kz=2.0 (tier=int k=2 sp=22.0 tu=163.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.3_v0.01_kz2.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.3 V0=0.01 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.300_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.3 V0=0.01 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.0_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 167.7
run_tag = recorr
EOINI
echo "[abi2] a=2.0 V0=0.01 kz=5.0 (tier=int k=5 sp=8.0 tu=167.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.0_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[abi2] a=2.0 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.000_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.0 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.4_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 175.0
run_tag = recorr
EOINI
echo "[abi2] a=1.4 V0=0.03 kz=8.0 (tier=int k=8 sp=8.0 tu=175.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.4_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.4 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.400_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.4 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.9_v0.05_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 182.6
run_tag = recorr
EOINI
echo "[abi2] a=0.9 V0=0.05 kz=6.0 (tier=int k=6 sp=8.0 tu=182.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.9_v0.05_kz6.0.ini >> $LOG 2>&1) || echo "[abi2] a=0.9 V0=0.05 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a0.900_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.9 V0=0.05 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.0_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 189.7
run_tag = recorr
EOINI
echo "[abi2] a=1.0 V0=0.05 kz=8.0 (tier=int k=8 sp=8.0 tu=189.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.0_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.000_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.7_v0.01_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 197.3
run_tag = recorr
EOINI
echo "[abi2] a=1.7 V0=0.01 kz=5.0 (tier=int k=5 sp=8.0 tu=197.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.7_v0.01_kz5.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.7 V0=0.01 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.700_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.7 V0=0.01 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.9_v0.01_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.9 V0=0.01 kz=0.5 (tier=half k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.9_v0.01_kz0.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.9 V0=0.01 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.900_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.9 V0=0.01 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.9_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=0.9 V0=0.03 kz=0.5 (tier=half k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.9_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[abi2] a=0.9 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.9 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.9_v0.03_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.9 V0=0.03 kz=3.5 (tier=half k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.9_v0.03_kz3.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.9 V0=0.03 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.9 V0=0.03 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.3_v0.03_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.3 V0=0.03 kz=6.5 (tier=half k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.3_v0.03_kz6.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.3 V0=0.03 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.300_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.3 V0=0.03 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.5_v0.03_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.5 V0=0.03 kz=7.5 (tier=half k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.5_v0.03_kz7.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.5 V0=0.03 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.500_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.5 V0=0.03 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.8_v0.03_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.8 V0=0.03 kz=7.5 (tier=half k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.8_v0.03_kz7.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.8 V0=0.03 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.800_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.8 V0=0.03 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.9_v0.03_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.9 V0=0.03 kz=6.5 (tier=half k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.9_v0.03_kz6.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.9 V0=0.03 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.9 V0=0.03 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a3.0_v0.03_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=3.0 V0=0.03 kz=0.5 (tier=half k=1 sp=6.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a3.0_v0.03_kz0.5.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.03 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a3.000_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.03 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a3.0_v0.03_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=3.0 V0=0.03 kz=2.5 (tier=half k=5 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a3.0_v0.03_kz2.5.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.03 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a3.000_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.03 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a3.0_v0.03_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=3.0 V0=0.03 kz=3.5 (tier=half k=7 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a3.0_v0.03_kz3.5.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.03 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a3.000_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.03 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.6_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=0.6 V0=0.05 kz=0.5 (tier=half k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.6_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[abi2] a=0.6 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.600_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.6 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.3_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.3 V0=0.05 kz=2.5 (tier=half k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.3_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.3 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.300_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.3 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.4_v0.05_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.4 V0=0.05 kz=1.5 (tier=half k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.4_v0.05_kz1.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.4 V0=0.05 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.4 V0=0.05 kz=1.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.4_v0.05_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.4 V0=0.05 kz=3.5 (tier=half k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.4_v0.05_kz3.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.4 V0=0.05 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.4 V0=0.05 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.0_v0.05_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.0 V0=0.05 kz=3.5 (tier=half k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.0_v0.05_kz3.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.0 V0=0.05 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.000_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.0 V0=0.05 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.3_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.3 V0=0.05 kz=5.5 (tier=half k=11 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.3_v0.05_kz5.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.3 V0=0.05 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a2.300_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.3 V0=0.05 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.3_v0.05_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.3 V0=0.05 kz=6.5 (tier=half k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.3_v0.05_kz6.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.3 V0=0.05 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.300_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.3 V0=0.05 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.3_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.3 V0=0.05 kz=7.5 (tier=half k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.3_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.3 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.300_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.3 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.4_v0.05_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.4 V0=0.05 kz=3.5 (tier=half k=7 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.4_v0.05_kz3.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.4 V0=0.05 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.4 V0=0.05 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.8_v0.05_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.8 V0=0.05 kz=0.5 (tier=half k=1 sp=5.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.8_v0.05_kz0.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.8 V0=0.05 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.8 V0=0.05 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.9_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.9 V0=0.05 kz=2.5 (tier=half k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.9_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.9 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.900_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.9 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a3.0_v0.05_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=3.0 V0=0.05 kz=3.5 (tier=half k=7 sp=7.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a3.0_v0.05_kz3.5.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.05 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a3.000_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.05 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a3.0_v0.05_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=3.0 V0=0.05 kz=4.5 (tier=half k=9 sp=13.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a3.0_v0.05_kz4.5.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.05 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a3.000_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.05 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.0_v0.1_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.0 V0=0.1 kz=2.5 (tier=half k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.0_v0.1_kz2.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.1 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.1 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.3_v0.1_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.3 V0=0.1 kz=1.5 (tier=half k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.3_v0.1_kz1.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.3 V0=0.1 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.3 V0=0.1 kz=1.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.5_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.5 V0=0.1 kz=7.5 (tier=half k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.5_v0.1_kz7.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.5 V0=0.1 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.500_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.5 V0=0.1 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.7_v0.1_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.7 V0=0.1 kz=2.5 (tier=half k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.7_v0.1_kz2.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.7 V0=0.1 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.700_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.7 V0=0.1 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.7_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.7 V0=0.1 kz=6.5 (tier=half k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.7_v0.1_kz6.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.7 V0=0.1 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.700_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.7 V0=0.1 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.8_v0.1_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.8 V0=0.1 kz=3.5 (tier=half k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.8_v0.1_kz3.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.8 V0=0.1 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.8 V0=0.1 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.9_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.9 V0=0.1 kz=6.5 (tier=half k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.9_v0.1_kz6.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.9 V0=0.1 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.900_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.9 V0=0.1 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.0_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.0 V0=0.1 kz=5.5 (tier=half k=11 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.0_v0.1_kz5.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.0 V0=0.1 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a2.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.0 V0=0.1 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.1_v0.1_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.1 V0=0.1 kz=2.5 (tier=half k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.1_v0.1_kz2.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.1 V0=0.1 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.100_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.1 V0=0.1 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.2_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.2 V0=0.1 kz=6.5 (tier=half k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.2_v0.1_kz6.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.2 V0=0.1 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.200_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.2 V0=0.1 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.5_v0.1_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.5 V0=0.1 kz=1.5 (tier=half k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.5_v0.1_kz1.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.5 V0=0.1 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.500_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.5 V0=0.1 kz=1.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.6_v0.1_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.6 V0=0.1 kz=4.5 (tier=half k=9 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.6_v0.1_kz4.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.6 V0=0.1 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.6 V0=0.1 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.7_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.7 V0=0.1 kz=5.5 (tier=half k=11 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.7_v0.1_kz5.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.7 V0=0.1 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a2.700_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.7 V0=0.1 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.9_v0.1_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.9 V0=0.1 kz=3.5 (tier=half k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.9_v0.1_kz3.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.9 V0=0.1 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.900_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.9 V0=0.1 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a3.0_v0.1_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=3.0 V0=0.1 kz=3.5 (tier=half k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a3.0_v0.1_kz3.5.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.1 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a3.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.1 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.0_v0.2_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 1.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.0 V0=0.2 kz=1.5 (tier=half k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.0_v0.2_kz1.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.2 kz=1.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.2 kz=1.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.0_v0.2_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.0 V0=0.2 kz=7.5 (tier=half k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.0_v0.2_kz7.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.2 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.2 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.1_v0.2_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.1 V0=0.2 kz=2.5 (tier=half k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.1_v0.2_kz2.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.1 V0=0.2 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.1 V0=0.2 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.3_v0.2_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.3 V0=0.2 kz=6.5 (tier=half k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.3_v0.2_kz6.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.3 V0=0.2 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.300_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.3 V0=0.2 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.4_v0.2_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.4 V0=0.2 kz=6.5 (tier=half k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.4_v0.2_kz6.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.4 V0=0.2 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.400_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.4 V0=0.2 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.6_v0.2_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.6 V0=0.2 kz=4.5 (tier=half k=9 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.6_v0.2_kz4.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.6 V0=0.2 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.600_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.6 V0=0.2 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.8_v0.2_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.8 V0=0.2 kz=2.5 (tier=half k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.8_v0.2_kz2.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.8 V0=0.2 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.8 V0=0.2 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.0_v0.2_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.0 V0=0.2 kz=3.5 (tier=half k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.0_v0.2_kz3.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.0 V0=0.2 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.0 V0=0.2 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.0_v0.2_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.0 V0=0.2 kz=4.5 (tier=half k=9 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.0_v0.2_kz4.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.0 V0=0.2 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.0 V0=0.2 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.1_v0.2_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.1 V0=0.2 kz=4.5 (tier=half k=9 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.1_v0.2_kz4.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.1 V0=0.2 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.1 V0=0.2 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.2_v0.2_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.2 V0=0.2 kz=4.5 (tier=half k=9 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.2_v0.2_kz4.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.2 V0=0.2 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.200_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.2 V0=0.2 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.6_v0.2_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.6 V0=0.2 kz=3.5 (tier=half k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.6_v0.2_kz3.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.6 V0=0.2 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.600_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.6 V0=0.2 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.6_v0.03_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 101.4
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.6 V0=0.03 kz=3.5 (tier=half k=7 sp=8.0 tu=101.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.6_v0.03_kz3.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.6 V0=0.03 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.6 V0=0.03 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.3_v0.03_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 103.1
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.3 V0=0.03 kz=7.5 (tier=half k=15 sp=8.0 tu=103.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.3_v0.03_kz7.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.3 V0=0.03 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.300_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.3 V0=0.03 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.5_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 104.9
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.5 V0=0.05 kz=5.5 (tier=half k=11 sp=8.0 tu=104.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.5_v0.05_kz5.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.5 V0=0.05 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a1.500_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.5 V0=0.05 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.7_v0.05_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 214.3
run_tag = recorr
EOINI
echo "[abi2] a=0.7 V0=0.05 kz=5.0 (tier=int k=5 sp=8.0 tu=214.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.7_v0.05_kz5.0.ini >> $LOG 2>&1) || echo "[abi2] a=0.7 V0=0.05 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.7 V0=0.05 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.7_v0.03_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 108.1
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.7 V0=0.03 kz=4.5 (tier=half k=9 sp=8.0 tu=108.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.7_v0.03_kz4.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.7 V0=0.03 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.700_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.7 V0=0.03 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.0_v0.03_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 110.4
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=2.0 V0=0.03 kz=6.5 (tier=half k=13 sp=8.0 tu=110.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.0_v0.03_kz6.5.ini >> $LOG 2>&1) || echo "[abi2] a=2.0 V0=0.03 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.000_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.0 V0=0.03 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.3_v0.05_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 224.3
run_tag = recorr
EOINI
echo "[abi2] a=0.3 V0=0.05 kz=1.0 (tier=int k=1 sp=14.0 tu=224.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.3_v0.05_kz1.0.ini >> $LOG 2>&1) || echo "[abi2] a=0.3 V0=0.05 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.300_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.3 V0=0.05 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.8_v0.2_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 114.8
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=0.8 V0=0.2 kz=7.5 (tier=half k=15 sp=8.0 tu=114.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.8_v0.2_kz7.5.ini >> $LOG 2>&1) || echo "[abi2] a=0.8 V0=0.2 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a0.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.8 V0=0.2 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.7_v0.05_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 234.8
run_tag = recorr
EOINI
echo "[abi2] a=0.7 V0=0.05 kz=6.0 (tier=int k=6 sp=8.0 tu=234.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.7_v0.05_kz6.0.ini >> $LOG 2>&1) || echo "[abi2] a=0.7 V0=0.05 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a0.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.7 V0=0.05 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.0_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 121.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.0 V0=0.1 kz=6.5 (tier=half k=13 sp=8.0 tu=121.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.0_v0.1_kz6.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.1 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.1 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.5_v0.03_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 245.1
run_tag = recorr
EOINI
echo "[abi2] a=0.5 V0=0.03 kz=2.0 (tier=int k=2 sp=14.0 tu=245.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.5_v0.03_kz2.0.ini >> $LOG 2>&1) || echo "[abi2] a=0.5 V0=0.03 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.500_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.5 V0=0.03 kz=2.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.3_v0.2_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 250.0
run_tag = recorr
EOINI
echo "[abi2] a=0.3 V0=0.2 kz=5.0 (tier=int k=5 sp=8.0 tu=250.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.3_v0.2_kz5.0.ini >> $LOG 2>&1) || echo "[abi2] a=0.3 V0=0.2 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.300_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.3 V0=0.2 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.7_v0.1_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 126.9
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=0.7 V0=0.1 kz=3.5 (tier=half k=7 sp=8.0 tu=126.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.7_v0.1_kz3.5.ini >> $LOG 2>&1) || echo "[abi2] a=0.7 V0=0.1 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.700_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.7 V0=0.1 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.4_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 131.2
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.4 V0=0.05 kz=7.5 (tier=half k=15 sp=8.0 tu=131.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.4_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.4 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.4 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.6_v0.01_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 265.2
run_tag = recorr
EOINI
echo "[abi2] a=1.6 V0=0.01 kz=8.0 (tier=int k=8 sp=9.0 tu=265.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.6_v0.01_kz8.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.6 V0=0.01 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.600_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.6 V0=0.01 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.5_v0.03_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 135.4
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.5 V0=0.03 kz=5.5 (tier=half k=11 sp=8.0 tu=135.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.5_v0.03_kz5.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.5 V0=0.03 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a1.500_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.5 V0=0.03 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.6_v0.03_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 138.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.6 V0=0.03 kz=6.5 (tier=half k=13 sp=8.0 tu=138.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.6_v0.03_kz6.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.6 V0=0.03 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.6 V0=0.03 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.5_v0.01_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 1.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 282.8
run_tag = recorr
EOINI
echo "[abi2] a=1.5 V0=0.01 kz=8.0 (tier=int k=8 sp=9.0 tu=282.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.5_v0.01_kz8.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.5 V0=0.01 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.500_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.5 V0=0.01 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.6_v0.03_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 288.7
run_tag = recorr
EOINI
echo "[abi2] a=0.6 V0=0.03 kz=4.0 (tier=int k=4 sp=12.0 tu=288.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.6_v0.03_kz4.0.ini >> $LOG 2>&1) || echo "[abi2] a=0.6 V0=0.03 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a0.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.6 V0=0.03 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.6_v0.05_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 295.8
run_tag = recorr
EOINI
echo "[abi2] a=0.6 V0=0.05 kz=7.0 (tier=int k=7 sp=8.0 tu=295.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.6_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[abi2] a=0.6 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.600_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.6 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.7_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 151.7
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=0.7 V0=0.05 kz=2.5 (tier=half k=5 sp=11.0 tu=151.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.7_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[abi2] a=0.7 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.7 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.7_v0.01_kz0.5.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 154.8
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=0.7 V0=0.01 kz=0.5 (tier=half k=1 sp=22.0 tu=154.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.7_v0.01_kz0.5.ini >> $LOG 2>&1) || echo "[abi2] a=0.7 V0=0.01 kz=0.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.700_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.7 V0=0.01 kz=0.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.3_v0.2_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 316.2
run_tag = recorr
EOINI
echo "[abi2] a=0.3 V0=0.2 kz=8.0 (tier=int k=8 sp=8.0 tu=316.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.3_v0.2_kz8.0.ini >> $LOG 2>&1) || echo "[abi2] a=0.3 V0=0.2 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a0.300_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.3 V0=0.2 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.0_v0.03_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 162.1
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.0 V0=0.03 kz=3.5 (tier=half k=7 sp=10.0 tu=162.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.0_v0.03_kz3.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.03 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.000_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.03 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.1_v0.01_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 334.0
run_tag = recorr
EOINI
echo "[abi2] a=1.1 V0=0.01 kz=6.0 (tier=int k=6 sp=12.0 tu=334.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.1_v0.01_kz6.0.ini >> $LOG 2>&1) || echo "[abi2] a=1.1 V0=0.01 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.100_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.1 V0=0.01 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.3_v0.03_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 169.9
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.3 V0=0.03 kz=6.5 (tier=half k=13 sp=8.0 tu=169.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.3_v0.03_kz6.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.3 V0=0.03 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.300_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.3 V0=0.03 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.8_v0.01_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 176.8
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.8 V0=0.01 kz=4.5 (tier=half k=9 sp=10.0 tu=176.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.8_v0.01_kz4.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.8 V0=0.01 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.800_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.8 V0=0.01 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.7_v0.05_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 179.3
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=0.7 V0=0.05 kz=3.5 (tier=half k=7 sp=9.0 tu=179.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.7_v0.05_kz3.5.ini >> $LOG 2>&1) || echo "[abi2] a=0.7 V0=0.05 kz=3.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.7 V0=0.05 kz=3.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.9_v0.01_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 185.2
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.9 V0=0.01 kz=5.5 (tier=half k=11 sp=8.0 tu=185.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.9_v0.01_kz5.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.9 V0=0.01 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a1.900_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.9 V0=0.01 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.5_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 379.5
run_tag = recorr
EOINI
echo "[abi2] a=0.5 V0=0.05 kz=8.0 (tier=int k=8 sp=8.0 tu=379.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.5_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[abi2] a=0.5 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a0.500_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.5 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.8_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 196.7
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=0.8 V0=0.05 kz=5.5 (tier=half k=11 sp=8.0 tu=196.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.8_v0.05_kz5.5.ini >> $LOG 2>&1) || echo "[abi2] a=0.8 V0=0.05 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a0.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.8 V0=0.05 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.3_v0.01_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = recorr
EOINI
echo "[abi2] a=0.3 V0=0.01 kz=7.0 (tier=int k=7 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.3_v0.01_kz7.0.ini >> $LOG 2>&1) || echo "[abi2] a=0.3 V0=0.01 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.300_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.3 V0=0.01 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.3_v0.03_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = recorr
EOINI
echo "[abi2] a=0.3 V0=0.03 kz=8.0 (tier=int k=8 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.3_v0.03_kz8.0.ini >> $LOG 2>&1) || echo "[abi2] a=0.3 V0=0.03 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a0.300_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.3 V0=0.03 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.4_v0.03_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = recorr
EOINI
echo "[abi2] a=0.4 V0=0.03 kz=7.0 (tier=int k=7 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.4_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[abi2] a=0.4 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.400_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.4 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.2_v0.05_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = recorr
EOINI
echo "[abi2] a=0.2 V0=0.05 kz=4.0 (tier=int k=4 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.2_v0.05_kz4.0.ini >> $LOG 2>&1) || echo "[abi2] a=0.2 V0=0.05 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a0.200_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.2 V0=0.05 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.4_v0.05_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = recorr
EOINI
echo "[abi2] a=0.4 V0=0.05 kz=8.0 (tier=int k=8 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.4_v0.05_kz8.0.ini >> $LOG 2>&1) || echo "[abi2] a=0.4 V0=0.05 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a0.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.4 V0=0.05 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.1_v0.03_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 200.7
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.1 V0=0.03 kz=6.5 (tier=half k=13 sp=8.0 tu=200.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.1_v0.03_kz6.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.1 V0=0.03 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.100_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.1 V0=0.03 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.5_v0.05_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 12.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 212.2
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=0.5 V0=0.05 kz=2.5 (tier=half k=5 sp=12.0 tu=212.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.5_v0.05_kz2.5.ini >> $LOG 2>&1) || echo "[abi2] a=0.5 V0=0.05 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.500_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.5 V0=0.05 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.6_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 216.5
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=0.6 V0=0.1 kz=7.5 (tier=half k=15 sp=8.0 tu=216.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.6_v0.1_kz7.5.ini >> $LOG 2>&1) || echo "[abi2] a=0.6 V0=0.1 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a0.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.6 V0=0.1 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.5_v0.01_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 1.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 234.5
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.5 V0=0.01 kz=5.5 (tier=half k=11 sp=8.0 tu=234.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.5_v0.01_kz5.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.5 V0=0.01 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a1.500_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.5 V0=0.01 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.9_v0.03_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 245.3
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=0.9 V0=0.03 kz=6.5 (tier=half k=13 sp=8.0 tu=245.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.9_v0.03_kz6.5.ini >> $LOG 2>&1) || echo "[abi2] a=0.9 V0=0.03 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a0.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.9 V0=0.03 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.7_v0.05_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 262.5
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=0.7 V0=0.05 kz=7.5 (tier=half k=15 sp=9.0 tu=262.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.7_v0.05_kz7.5.ini >> $LOG 2>&1) || echo "[abi2] a=0.7 V0=0.05 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a0.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.7 V0=0.05 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.4_v0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 278.1
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=0.4 V0=0.1 kz=5.5 (tier=half k=11 sp=8.0 tu=278.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.4_v0.1_kz5.5.ini >> $LOG 2>&1) || echo "[abi2] a=0.4 V0=0.1 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a0.400_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.4 V0=0.1 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.4_v0.1_kz6.5.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 302.3
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=0.4 V0=0.1 kz=6.5 (tier=half k=13 sp=8.0 tu=302.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.4_v0.1_kz6.5.ini >> $LOG 2>&1) || echo "[abi2] a=0.4 V0=0.1 kz=6.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a0.400_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.4 V0=0.1 kz=6.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.4_v0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 324.8
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=0.4 V0=0.1 kz=7.5 (tier=half k=15 sp=8.0 tu=324.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.4_v0.1_kz7.5.ini >> $LOG 2>&1) || echo "[abi2] a=0.4 V0=0.1 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a0.400_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.4 V0=0.1 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.4_v0.05_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 355.8
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=0.4 V0=0.05 kz=4.5 (tier=half k=9 sp=8.0 tu=355.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.4_v0.05_kz4.5.ini >> $LOG 2>&1) || echo "[abi2] a=0.4 V0=0.05 kz=4.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.4 V0=0.05 kz=4.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.1_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 1.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 373.5
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=1.1 V0=0.01 kz=7.5 (tier=half k=15 sp=11.0 tu=373.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.1_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[abi2] a=1.1 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.100_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.1 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.5_v0.01_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=0.5 V0=0.01 kz=2.5 (tier=half k=5 sp=14.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.5_v0.01_kz2.5.ini >> $LOG 2>&1) || echo "[abi2] a=0.5 V0=0.01 kz=2.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.500_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.5 V0=0.01 kz=2.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.7_v0.01_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.7
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=0.7 V0=0.01 kz=5.5 (tier=half k=11 sp=14.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.7_v0.01_kz5.5.ini >> $LOG 2>&1) || echo "[abi2] a=0.7 V0=0.01 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a0.700_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.7 V0=0.01 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.8_v0.01_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=0.8 V0=0.01 kz=5.5 (tier=half k=11 sp=14.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.8_v0.01_kz5.5.ini >> $LOG 2>&1) || echo "[abi2] a=0.8 V0=0.01 kz=5.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a0.800_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.8 V0=0.01 kz=5.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.8_v0.01_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 400.0
lz_override = 12.566371
nz_override = 128
run_tag = recorr
EOINI
echo "[abi2] a=0.8 V0=0.01 kz=7.5 (tier=half k=15 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.8_v0.01_kz7.5.ini >> $LOG 2>&1) || echo "[abi2] a=0.8 V0=0.01 kz=7.5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a0.800_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.8 V0=0.01 kz=7.5 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.1_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.1 V0=0.01 kz=0.25 (tier=fine k=2 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.1_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[abi2] a=1.1 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.100_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.1 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.5_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.5 V0=0.01 kz=0.25 (tier=fine k=2 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.5_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[abi2] a=1.5 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.500_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.5 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.6_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.6 V0=0.01 kz=0.25 (tier=fine k=2 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.6_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[abi2] a=1.6 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.600_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.6 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.8_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.8 V0=0.01 kz=1.125 (tier=fine k=9 sp=22.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.8_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[abi2] a=1.8 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.800_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.8 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.2_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.2 V0=0.01 kz=0.25 (tier=fine k=2 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.2_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[abi2] a=2.2 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.200_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.2 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.4_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.4 V0=0.01 kz=1.125 (tier=fine k=9 sp=18.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.4_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[abi2] a=2.4 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.400_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.4 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.5_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.5 V0=0.01 kz=2.25 (tier=fine k=18 sp=13.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.5_v0.01_kz2.25.ini >> $LOG 2>&1) || echo "[abi2] a=2.5 V0=0.01 kz=2.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k18_a2.500_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.5 V0=0.01 kz=2.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.6_v0.01_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.6 V0=0.01 kz=0.125 (tier=fine k=1 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.6_v0.01_kz0.125.ini >> $LOG 2>&1) || echo "[abi2] a=2.6 V0=0.01 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.600_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.6 V0=0.01 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.6_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 2.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.6 V0=0.01 kz=1.125 (tier=fine k=9 sp=18.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.6_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[abi2] a=2.6 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a2.600_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.6 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.9_v0.01_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 18.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.9 V0=0.01 kz=1.25 (tier=fine k=10 sp=18.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.9_v0.01_kz1.25.ini >> $LOG 2>&1) || echo "[abi2] a=2.9 V0=0.01 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a2.900_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.9 V0=0.01 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.9_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 2.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.9 V0=0.01 kz=2.125 (tier=fine k=17 sp=13.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.9_v0.01_kz2.125.ini >> $LOG 2>&1) || echo "[abi2] a=2.9 V0=0.01 kz=2.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k17_a2.900_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.9 V0=0.01 kz=2.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.9_v0.03_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.9 V0=0.03 kz=0.875 (tier=fine k=7 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.9_v0.03_kz0.875.ini >> $LOG 2>&1) || echo "[abi2] a=0.9 V0=0.03 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.9 V0=0.03 kz=0.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.0_v0.03_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.0 V0=0.03 kz=0.125 (tier=fine k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.0_v0.03_kz0.125.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.03 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.000_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.03 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.3_v0.03_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.3 V0=0.03 kz=0.125 (tier=fine k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.3_v0.03_kz0.125.ini >> $LOG 2>&1) || echo "[abi2] a=1.3 V0=0.03 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.300_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.3 V0=0.03 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.5_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.5 V0=0.03 kz=0.625 (tier=fine k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.5_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[abi2] a=1.5 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.500_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.5 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.6_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.6 V0=0.03 kz=2.625 (tier=fine k=21 sp=22.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.6_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[abi2] a=1.6 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a1.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.6 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.8_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.8 V0=0.03 kz=1.75 (tier=fine k=14 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.8_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[abi2] a=1.8 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a1.800_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.8 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.8_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.8 V0=0.03 kz=2.875 (tier=fine k=23 sp=22.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.8_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[abi2] a=1.8 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a1.800_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.8 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.9_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.9 V0=0.03 kz=2.875 (tier=fine k=23 sp=22.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.9_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[abi2] a=1.9 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a1.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.9 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.1_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.1
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.1 V0=0.03 kz=0.625 (tier=fine k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.1_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[abi2] a=2.1 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.100_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.1 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.3_v0.03_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.3 V0=0.03 kz=0.125 (tier=fine k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.3_v0.03_kz0.125.ini >> $LOG 2>&1) || echo "[abi2] a=2.3 V0=0.03 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.300_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.3 V0=0.03 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.4_v0.03_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.4 V0=0.03 kz=0.25 (tier=fine k=2 sp=6.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.4_v0.03_kz0.25.ini >> $LOG 2>&1) || echo "[abi2] a=2.4 V0=0.03 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.400_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.4 V0=0.03 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.5_v0.03_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.5 V0=0.03 kz=0.625 (tier=fine k=5 sp=6.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.5_v0.03_kz0.625.ini >> $LOG 2>&1) || echo "[abi2] a=2.5 V0=0.03 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.500_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.5 V0=0.03 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.7_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.7 V0=0.03 kz=1.25 (tier=fine k=10 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.7_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[abi2] a=2.7 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a2.700_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.7 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.8_v0.03_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.8 V0=0.03 kz=0.75 (tier=fine k=6 sp=6.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.8_v0.03_kz0.75.ini >> $LOG 2>&1) || echo "[abi2] a=2.8 V0=0.03 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.800_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.8 V0=0.03 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.9_v0.03_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.9 V0=0.03 kz=0.125 (tier=fine k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.9_v0.03_kz0.125.ini >> $LOG 2>&1) || echo "[abi2] a=2.9 V0=0.03 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.9 V0=0.03 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.9_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.9 V0=0.03 kz=2.625 (tier=fine k=21 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.9_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[abi2] a=2.9 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a2.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.9 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.9_v0.03_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.9 V0=0.03 kz=2.875 (tier=fine k=23 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.9_v0.03_kz2.875.ini >> $LOG 2>&1) || echo "[abi2] a=2.9 V0=0.03 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a2.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.9 V0=0.03 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a3.0_v0.03_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=3.0 V0=0.03 kz=1.875 (tier=fine k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a3.0_v0.03_kz1.875.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.03 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a3.000_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.03 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a3.0_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=3.0 V0=0.03 kz=2.75 (tier=fine k=22 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a3.0_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a3.000_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.9_v0.05_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.9 V0=0.05 kz=0.125 (tier=fine k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.9_v0.05_kz0.125.ini >> $LOG 2>&1) || echo "[abi2] a=0.9 V0=0.05 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.900_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.9 V0=0.05 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.1_v0.05_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.1 V0=0.05 kz=1.625 (tier=fine k=13 sp=11.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.1_v0.05_kz1.625.ini >> $LOG 2>&1) || echo "[abi2] a=1.1 V0=0.05 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.100_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.1 V0=0.05 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.2_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.2 V0=0.05 kz=0.625 (tier=fine k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.2_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[abi2] a=1.2 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.200_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.2 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.2_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.2 V0=0.05 kz=2.75 (tier=fine k=22 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.2_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[abi2] a=1.2 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a1.200_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.2 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.4_v0.05_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.4 V0=0.05 kz=0.25 (tier=fine k=2 sp=6.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.4_v0.05_kz0.25.ini >> $LOG 2>&1) || echo "[abi2] a=1.4 V0=0.05 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.4 V0=0.05 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.4_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.4 V0=0.05 kz=2.75 (tier=fine k=22 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.4_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[abi2] a=1.4 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a1.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.4 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.5_v0.05_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.5 V0=0.05 kz=2.875 (tier=fine k=23 sp=7.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.5_v0.05_kz2.875.ini >> $LOG 2>&1) || echo "[abi2] a=1.5 V0=0.05 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a1.500_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.5 V0=0.05 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.7_v0.05_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.7 V0=0.05 kz=0.25 (tier=fine k=2 sp=5.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.7_v0.05_kz0.25.ini >> $LOG 2>&1) || echo "[abi2] a=1.7 V0=0.05 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.7 V0=0.05 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.8_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 6.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.8 V0=0.05 kz=0.625 (tier=fine k=5 sp=6.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.8_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[abi2] a=1.8 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.8 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.1_v0.05_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.1 V0=0.05 kz=1.625 (tier=fine k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.1_v0.05_kz1.625.ini >> $LOG 2>&1) || echo "[abi2] a=2.1 V0=0.05 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.100_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.1 V0=0.05 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.2_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.2 V0=0.05 kz=2.75 (tier=fine k=22 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.2_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[abi2] a=2.2 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a2.200_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.2 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.3_v0.05_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.3 V0=0.05 kz=1.625 (tier=fine k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.3_v0.05_kz1.625.ini >> $LOG 2>&1) || echo "[abi2] a=2.3 V0=0.05 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.300_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.3 V0=0.05 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.5_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.5 V0=0.05 kz=2.75 (tier=fine k=22 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.5_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[abi2] a=2.5 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a2.500_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.5 V0=0.05 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.6_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.6 V0=0.05 kz=1.75 (tier=fine k=14 sp=7.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.6_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[abi2] a=2.6 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a2.600_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.6 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.8_v0.05_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.8 V0=0.05 kz=0.625 (tier=fine k=5 sp=5.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.8_v0.05_kz0.625.ini >> $LOG 2>&1) || echo "[abi2] a=2.8 V0=0.05 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.8 V0=0.05 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.8_v0.05_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.8 V0=0.05 kz=1.875 (tier=fine k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.8_v0.05_kz1.875.ini >> $LOG 2>&1) || echo "[abi2] a=2.8 V0=0.05 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.800_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.8 V0=0.05 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.9_v0.05_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.9 V0=0.05 kz=1.875 (tier=fine k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.9_v0.05_kz1.875.ini >> $LOG 2>&1) || echo "[abi2] a=2.9 V0=0.05 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.900_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.9 V0=0.05 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a3.0_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=3.0 V0=0.05 kz=0.875 (tier=fine k=7 sp=5.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a3.0_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a3.000_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.4_v0.1_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.4 V0=0.1 kz=0.25 (tier=fine k=2 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.4_v0.1_kz0.25.ini >> $LOG 2>&1) || echo "[abi2] a=0.4 V0=0.1 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.400_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.4 V0=0.1 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.6_v0.1_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.6 V0=0.1 kz=0.125 (tier=fine k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.6_v0.1_kz0.125.ini >> $LOG 2>&1) || echo "[abi2] a=0.6 V0=0.1 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.6 V0=0.1 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.8_v0.1_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.8 V0=0.1 kz=2.75 (tier=fine k=22 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.8_v0.1_kz2.75.ini >> $LOG 2>&1) || echo "[abi2] a=0.8 V0=0.1 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a0.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.8 V0=0.1 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.9_v0.1_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.9 V0=0.1 kz=0.875 (tier=fine k=7 sp=11.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.9_v0.1_kz0.875.ini >> $LOG 2>&1) || echo "[abi2] a=0.9 V0=0.1 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.900_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.9 V0=0.1 kz=0.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.0_v0.1_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.0 V0=0.1 kz=1.625 (tier=fine k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.0_v0.1_kz1.625.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.1 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.1 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.0_v0.1_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.0 V0=0.1 kz=2.625 (tier=fine k=21 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.0_v0.1_kz2.625.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.1 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a1.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.1 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.1_v0.1_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.1 V0=0.1 kz=1.75 (tier=fine k=14 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.1_v0.1_kz1.75.ini >> $LOG 2>&1) || echo "[abi2] a=1.1 V0=0.1 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a1.100_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.1 V0=0.1 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.2_v0.1_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.2 V0=0.1 kz=0.625 (tier=fine k=5 sp=11.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.2_v0.1_kz0.625.ini >> $LOG 2>&1) || echo "[abi2] a=1.2 V0=0.1 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.200_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.2 V0=0.1 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.3_v0.1_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.3 V0=0.1 kz=2.875 (tier=fine k=23 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.3_v0.1_kz2.875.ini >> $LOG 2>&1) || echo "[abi2] a=1.3 V0=0.1 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a1.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.3 V0=0.1 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.4_v0.1_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.4 V0=0.1 kz=1.75 (tier=fine k=14 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.4_v0.1_kz1.75.ini >> $LOG 2>&1) || echo "[abi2] a=1.4 V0=0.1 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a1.400_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.4 V0=0.1 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.5_v0.1_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.5 V0=0.1 kz=0.25 (tier=fine k=2 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.5_v0.1_kz0.25.ini >> $LOG 2>&1) || echo "[abi2] a=1.5 V0=0.1 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.500_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.5 V0=0.1 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.5_v0.1_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.5 V0=0.1 kz=2.75 (tier=fine k=22 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.5_v0.1_kz2.75.ini >> $LOG 2>&1) || echo "[abi2] a=1.5 V0=0.1 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a1.500_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.5 V0=0.1 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.7_v0.1_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.7 V0=0.1 kz=1.75 (tier=fine k=14 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.7_v0.1_kz1.75.ini >> $LOG 2>&1) || echo "[abi2] a=1.7 V0=0.1 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a1.700_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.7 V0=0.1 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.8_v0.1_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.8 V0=0.1 kz=0.875 (tier=fine k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.8_v0.1_kz0.875.ini >> $LOG 2>&1) || echo "[abi2] a=1.8 V0=0.1 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.8 V0=0.1 kz=0.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.0_v0.1_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.0 V0=0.1 kz=1.25 (tier=fine k=10 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.0_v0.1_kz1.25.ini >> $LOG 2>&1) || echo "[abi2] a=2.0 V0=0.1 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a2.000_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.0 V0=0.1 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.1_v0.1_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.1 V0=0.1 kz=1.625 (tier=fine k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.1_v0.1_kz1.625.ini >> $LOG 2>&1) || echo "[abi2] a=2.1 V0=0.1 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.100_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.1 V0=0.1 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.2_v0.1_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.2 V0=0.1 kz=0.75 (tier=fine k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.2_v0.1_kz0.75.ini >> $LOG 2>&1) || echo "[abi2] a=2.2 V0=0.1 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.200_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.2 V0=0.1 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.3_v0.1_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.3 V0=0.1 kz=1.75 (tier=fine k=14 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.3_v0.1_kz1.75.ini >> $LOG 2>&1) || echo "[abi2] a=2.3 V0=0.1 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a2.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.3 V0=0.1 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.3_v0.1_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.3 V0=0.1 kz=2.75 (tier=fine k=22 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.3_v0.1_kz2.75.ini >> $LOG 2>&1) || echo "[abi2] a=2.3 V0=0.1 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a2.300_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.3 V0=0.1 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.5_v0.1_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.5 V0=0.1 kz=0.75 (tier=fine k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.5_v0.1_kz0.75.ini >> $LOG 2>&1) || echo "[abi2] a=2.5 V0=0.1 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.500_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.5 V0=0.1 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.6_v0.1_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.6 V0=0.1 kz=0.75 (tier=fine k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.6_v0.1_kz0.75.ini >> $LOG 2>&1) || echo "[abi2] a=2.6 V0=0.1 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.600_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.6 V0=0.1 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.8_v0.1_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.8 V0=0.1 kz=1.625 (tier=fine k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.8_v0.1_kz1.625.ini >> $LOG 2>&1) || echo "[abi2] a=2.8 V0=0.1 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.8 V0=0.1 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.8_v0.1_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.8 V0=0.1 kz=1.875 (tier=fine k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.8_v0.1_kz1.875.ini >> $LOG 2>&1) || echo "[abi2] a=2.8 V0=0.1 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.800_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.8 V0=0.1 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.9_v0.1_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.9 V0=0.1 kz=0.625 (tier=fine k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.9_v0.1_kz0.625.ini >> $LOG 2>&1) || echo "[abi2] a=2.9 V0=0.1 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.900_*_v0.1000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.9 V0=0.1 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.7_v0.2_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.7 V0=0.2 kz=0.25 (tier=fine k=2 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.7_v0.2_kz0.25.ini >> $LOG 2>&1) || echo "[abi2] a=0.7 V0=0.2 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.7 V0=0.2 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.8_v0.2_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.8 V0=0.2 kz=0.125 (tier=fine k=1 sp=14.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.8_v0.2_kz0.125.ini >> $LOG 2>&1) || echo "[abi2] a=0.8 V0=0.2 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.8 V0=0.2 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.8_v0.2_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.8 V0=0.2 kz=0.625 (tier=fine k=5 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.8_v0.2_kz0.625.ini >> $LOG 2>&1) || echo "[abi2] a=0.8 V0=0.2 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.8 V0=0.2 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.9_v0.2_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 0.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.9 V0=0.2 kz=1.75 (tier=fine k=14 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.9_v0.2_kz1.75.ini >> $LOG 2>&1) || echo "[abi2] a=0.9 V0=0.2 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a0.900_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.9 V0=0.2 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.0_v0.2_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.0 V0=0.2 kz=0.875 (tier=fine k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.0_v0.2_kz0.875.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.2 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.2 kz=0.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.1_v0.2_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 1.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.1 V0=0.2 kz=2.625 (tier=fine k=21 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.1_v0.2_kz2.625.ini >> $LOG 2>&1) || echo "[abi2] a=1.1 V0=0.2 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a1.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.1 V0=0.2 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.2_v0.2_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.2 V0=0.2 kz=2.875 (tier=fine k=23 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.2_v0.2_kz2.875.ini >> $LOG 2>&1) || echo "[abi2] a=1.2 V0=0.2 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a1.200_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.2 V0=0.2 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.3_v0.2_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.3 V0=0.2 kz=2.75 (tier=fine k=22 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.3_v0.2_kz2.75.ini >> $LOG 2>&1) || echo "[abi2] a=1.3 V0=0.2 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a1.300_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.3 V0=0.2 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.5_v0.2_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.5 V0=0.2 kz=2.75 (tier=fine k=22 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.5_v0.2_kz2.75.ini >> $LOG 2>&1) || echo "[abi2] a=1.5 V0=0.2 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a1.500_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.5 V0=0.2 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.7_v0.2_kz0.625.ini <<'EOINI'
k_mode = 5
alpha_YM = 1.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.7 V0=0.2 kz=0.625 (tier=fine k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.7_v0.2_kz0.625.ini >> $LOG 2>&1) || echo "[abi2] a=1.7 V0=0.2 kz=0.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.7 V0=0.2 kz=0.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.7_v0.2_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 1.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.7 V0=0.2 kz=2.875 (tier=fine k=23 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.7_v0.2_kz2.875.ini >> $LOG 2>&1) || echo "[abi2] a=1.7 V0=0.2 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a1.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.7 V0=0.2 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.8_v0.2_kz0.75.ini <<'EOINI'
k_mode = 6
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.8 V0=0.2 kz=0.75 (tier=fine k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.8_v0.2_kz0.75.ini >> $LOG 2>&1) || echo "[abi2] a=1.8 V0=0.2 kz=0.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.8 V0=0.2 kz=0.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.9_v0.2_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.9
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.9 V0=0.2 kz=1.625 (tier=fine k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.9_v0.2_kz1.625.ini >> $LOG 2>&1) || echo "[abi2] a=1.9 V0=0.2 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.900_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.9 V0=0.2 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.0_v0.2_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.0 V0=0.2 kz=0.25 (tier=fine k=2 sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.0_v0.2_kz0.25.ini >> $LOG 2>&1) || echo "[abi2] a=2.0 V0=0.2 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.0 V0=0.2 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.1_v0.2_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.1 V0=0.2 kz=0.875 (tier=fine k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.1_v0.2_kz0.875.ini >> $LOG 2>&1) || echo "[abi2] a=2.1 V0=0.2 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.1 V0=0.2 kz=0.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.1_v0.2_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 2.1
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.1 V0=0.2 kz=1.625 (tier=fine k=13 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.1_v0.2_kz1.625.ini >> $LOG 2>&1) || echo "[abi2] a=2.1 V0=0.2 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a2.100_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.1 V0=0.2 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.2_v0.2_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.2 V0=0.2 kz=2.875 (tier=fine k=23 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.2_v0.2_kz2.875.ini >> $LOG 2>&1) || echo "[abi2] a=2.2 V0=0.2 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a2.200_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.2 V0=0.2 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.5_v0.2_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.5 V0=0.2 kz=0.25 (tier=fine k=2 sp=9.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.5_v0.2_kz0.25.ini >> $LOG 2>&1) || echo "[abi2] a=2.5 V0=0.2 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.500_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.5 V0=0.2 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.6_v0.2_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 2.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.6 V0=0.2 kz=1.25 (tier=fine k=10 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.6_v0.2_kz1.25.ini >> $LOG 2>&1) || echo "[abi2] a=2.6 V0=0.2 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a2.600_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.6 V0=0.2 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.7_v0.2_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.7 V0=0.2 kz=1.875 (tier=fine k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.7_v0.2_kz1.875.ini >> $LOG 2>&1) || echo "[abi2] a=2.7 V0=0.2 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.7 V0=0.2 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.7_v0.2_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 2.7
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.7 V0=0.2 kz=2.875 (tier=fine k=23 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.7_v0.2_kz2.875.ini >> $LOG 2>&1) || echo "[abi2] a=2.7 V0=0.2 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a2.700_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.7 V0=0.2 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.8_v0.2_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 2.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.8 V0=0.2 kz=1.875 (tier=fine k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.8_v0.2_kz1.875.ini >> $LOG 2>&1) || echo "[abi2] a=2.8 V0=0.2 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a2.800_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.8 V0=0.2 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a3.0_v0.2_kz0.125.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=3.0 V0=0.2 kz=0.125 (tier=fine k=1 sp=11.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a3.0_v0.2_kz0.125.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.2 kz=0.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a3.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.2 kz=0.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a3.0_v0.2_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 3.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=3.0 V0=0.2 kz=1.875 (tier=fine k=15 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a3.0_v0.2_kz1.875.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.2 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a3.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.2 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a3.0_v0.2_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 3.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 100.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=3.0 V0=0.2 kz=2.75 (tier=fine k=22 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a3.0_v0.2_kz2.75.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.2 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a3.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.2 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.9_v0.05_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 102.4
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.9 V0=0.05 kz=1.875 (tier=fine k=15 sp=11.0 tu=102.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.9_v0.05_kz1.875.ini >> $LOG 2>&1) || echo "[abi2] a=0.9 V0=0.05 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a0.900_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.9 V0=0.05 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.6_v0.05_kz0.875.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 106.2
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.6 V0=0.05 kz=0.875 (tier=fine k=7 sp=14.0 tu=106.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.6_v0.05_kz0.875.ini >> $LOG 2>&1) || echo "[abi2] a=0.6 V0=0.05 kz=0.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.600_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.6 V0=0.05 kz=0.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.9_v0.03_kz1.25.ini <<'EOINI'
k_mode = 10
alpha_YM = 0.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 9
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 108.3
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.9 V0=0.03 kz=1.25 (tier=fine k=10 sp=14.0 tu=108.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.9_v0.03_kz1.25.ini >> $LOG 2>&1) || echo "[abi2] a=0.9 V0=0.03 kz=1.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k10_a0.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.9 V0=0.03 kz=1.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.0_v0.03_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 110.8
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.0 V0=0.03 kz=1.625 (tier=fine k=13 sp=14.0 tu=110.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.0_v0.03_kz1.625.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.03 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.000_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.03 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.5_v0.2_kz2.875.ini <<'EOINI'
k_mode = 23
alpha_YM = 0.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 113.9
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.5 V0=0.2 kz=2.875 (tier=fine k=23 sp=8.0 tu=113.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.5_v0.2_kz2.875.ini >> $LOG 2>&1) || echo "[abi2] a=0.5 V0=0.2 kz=2.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a0.500_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.5 V0=0.2 kz=2.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a2.1_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 2.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 118.6
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=2.1 V0=0.01 kz=2.75 (tier=fine k=22 sp=13.0 tu=118.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a2.1_v0.01_kz2.75.ini >> $LOG 2>&1) || echo "[abi2] a=2.1 V0=0.01 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a2.100_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=2.1 V0=0.01 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.3_v0.01_kz1.125.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 123.2
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.3 V0=0.01 kz=1.125 (tier=fine k=9 sp=14.0 tu=123.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.3_v0.01_kz1.125.ini >> $LOG 2>&1) || echo "[abi2] a=1.3 V0=0.01 kz=1.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.300_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.3 V0=0.01 kz=1.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.7_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 0.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 127.1
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.7 V0=0.05 kz=1.75 (tier=fine k=14 sp=9.0 tu=127.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.7_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[abi2] a=0.7 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a0.700_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.7 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.9_v0.03_kz1.875.ini <<'EOINI'
k_mode = 15
alpha_YM = 0.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 132.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.9 V0=0.03 kz=1.875 (tier=fine k=15 sp=14.0 tu=132.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.9_v0.03_kz1.875.ini >> $LOG 2>&1) || echo "[abi2] a=0.9 V0=0.03 kz=1.875 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a0.900_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.9 V0=0.03 kz=1.875 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.6_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.6
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 137.5
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.6 V0=0.01 kz=0.25 (tier=fine k=2 sp=14.0 tu=137.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.6_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[abi2] a=0.6 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.600_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.6 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.3_v0.2_kz1.625.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.3
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 142.9
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.3 V0=0.2 kz=1.625 (tier=fine k=13 sp=10.0 tu=142.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.3_v0.2_kz1.625.ini >> $LOG 2>&1) || echo "[abi2] a=0.3 V0=0.2 kz=1.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a0.300_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.3 V0=0.2 kz=1.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.6_v0.05_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 148.2
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.6 V0=0.05 kz=1.75 (tier=fine k=14 sp=14.0 tu=148.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.6_v0.05_kz1.75.ini >> $LOG 2>&1) || echo "[abi2] a=0.6 V0=0.05 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a0.600_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.6 V0=0.05 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.4_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.4
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 156.4
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.4 V0=0.01 kz=2.125 (tier=fine k=17 sp=14.0 tu=156.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.4_v0.01_kz2.125.ini >> $LOG 2>&1) || echo "[abi2] a=1.4 V0=0.01 kz=2.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k17_a1.400_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.4 V0=0.01 kz=2.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.5_v0.01_kz0.25.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 161.5
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.5 V0=0.01 kz=0.25 (tier=fine k=2 sp=14.0 tu=161.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.5_v0.01_kz0.25.ini >> $LOG 2>&1) || echo "[abi2] a=0.5 V0=0.01 kz=0.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.500_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.5 V0=0.01 kz=0.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.3_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 1.3
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 173.2
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.3 V0=0.01 kz=2.25 (tier=fine k=18 sp=14.0 tu=173.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.3_v0.01_kz2.25.ini >> $LOG 2>&1) || echo "[abi2] a=1.3 V0=0.01 kz=2.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k18_a1.300_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.3 V0=0.01 kz=2.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.2_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 1.2
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 182.4
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.2 V0=0.01 kz=2.125 (tier=fine k=17 sp=14.0 tu=182.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.2_v0.01_kz2.125.ini >> $LOG 2>&1) || echo "[abi2] a=1.2 V0=0.01 kz=2.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k17_a1.200_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.2 V0=0.01 kz=2.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.6_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 0.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 191.2
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.6 V0=0.03 kz=1.75 (tier=fine k=14 sp=14.0 tu=191.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.6_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[abi2] a=0.6 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a0.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.6 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.7_v0.03_kz2.625.ini <<'EOINI'
k_mode = 21
alpha_YM = 0.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 20
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 200.5
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.7 V0=0.03 kz=2.625 (tier=fine k=21 sp=8.0 tu=200.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.7_v0.03_kz2.625.ini >> $LOG 2>&1) || echo "[abi2] a=0.7 V0=0.03 kz=2.625 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k21_a0.700_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.7 V0=0.03 kz=2.625 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.1_v0.01_kz2.375.ini <<'EOINI'
k_mode = 19
alpha_YM = 1.1
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 210.3
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.1 V0=0.01 kz=2.375 (tier=fine k=19 sp=14.0 tu=210.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.1_v0.01_kz2.375.ini >> $LOG 2>&1) || echo "[abi2] a=1.1 V0=0.01 kz=2.375 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k19_a1.100_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.1 V0=0.01 kz=2.375 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.5_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 0.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 229.3
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.5 V0=0.03 kz=1.75 (tier=fine k=14 sp=14.0 tu=229.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.5_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[abi2] a=0.5 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a0.500_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.5 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a1.0_v0.01_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 1.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 248.8
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=1.0 V0=0.01 kz=2.75 (tier=fine k=22 sp=22.0 tu=248.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a1.0_v0.01_kz2.75.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.01 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a1.000_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.01 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.8_v0.01_kz2.125.ini <<'EOINI'
k_mode = 17
alpha_YM = 0.8
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 250.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.8 V0=0.01 kz=2.125 (tier=fine k=17 sp=22.0 tu=250.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.8_v0.01_kz2.125.ini >> $LOG 2>&1) || echo "[abi2] a=0.8 V0=0.01 kz=2.125 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k17_a0.800_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.8 V0=0.01 kz=2.125 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.9_v0.01_kz2.25.ini <<'EOINI'
k_mode = 18
alpha_YM = 0.9
V0 = 0.01
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 17
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 250.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.9 V0=0.01 kz=2.25 (tier=fine k=18 sp=22.0 tu=250.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.9_v0.01_kz2.25.ini >> $LOG 2>&1) || echo "[abi2] a=0.9 V0=0.01 kz=2.25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k18_a0.900_*_v0.0100_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.9 V0=0.01 kz=2.25 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.3_v0.03_kz1.75.ini <<'EOINI'
k_mode = 14
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 13
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 250.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.3 V0=0.03 kz=1.75 (tier=fine k=14 sp=14.0 tu=250.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.3_v0.03_kz1.75.ini >> $LOG 2>&1) || echo "[abi2] a=0.3 V0=0.03 kz=1.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k14_a0.300_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.3 V0=0.03 kz=1.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.4_v0.03_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 250.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.4 V0=0.03 kz=2.75 (tier=fine k=22 sp=8.0 tu=250.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.4_v0.03_kz2.75.ini >> $LOG 2>&1) || echo "[abi2] a=0.4 V0=0.03 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a0.400_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.4 V0=0.03 kz=2.75 done $(date)" >> $LOG

cat > /tmp/recorr_abi2_a0.4_v0.05_kz2.75.ini <<'EOINI'
k_mode = 22
alpha_YM = 0.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 21
eps_override = 0.15
kz_suppress_hi = 112
target_tu = 250.0
lz_override = 50.265482
nz_override = 512
run_tag = recorr
EOINI
echo "[abi2] a=0.4 V0=0.05 kz=2.75 (tier=fine k=22 sp=8.0 tu=250.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_abi2_a0.4_v0.05_kz2.75.ini >> $LOG 2>&1) || echo "[abi2] a=0.4 V0=0.05 kz=2.75 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k22_a0.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[abi2] a=0.4 V0=0.05 kz=2.75 done $(date)" >> $LOG

    echo "=== abi2 ALL DONE $(date) ===" >> $LOG
}

echo "=== abi: launching 3-GPU recorrection campaign $(date) ==="
run_gpu0 & PID0=$!
run_gpu1 & PID1=$!
run_gpu2 & PID2=$!
wait $PID0 && echo 'GPU0 finished' || echo 'GPU0 FAILED'
wait $PID1 && echo 'GPU1 finished' || echo 'GPU1 FAILED'
wait $PID2 && echo 'GPU2 finished' || echo 'GPU2 FAILED'
