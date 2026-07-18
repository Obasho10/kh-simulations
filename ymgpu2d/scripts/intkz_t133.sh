#!/bin/bash
# recorrection campaign -- t133: 28 runs (2026-07-18)
# Launch: nohup bash scripts/recorr_t133.sh > logs/recorr_t133.log 2>&1 &
WDIR=/DATA/ym_kh/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs
LOG=$WDIR/logs/recorr_t133_progress.log
echo "=== recorr start $(date) ===" >> $LOG
# ---- smoke test: binary deposits seed + extractor measures the right channel ----
cat > /tmp/recorr_smoke_t133.ini <<'EOINI'
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
run_tag = smoket133
EOINI
rm -rf $WDIR/outputs/ym_k2_a1.000*smoket133*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_smoke_t133.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000*smoket133" >> $LOG 2>&1)
python3 - "$WDIR" t133 <<'EOPY' >> $LOG 2>&1 || { echo "[t133] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }
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
rm -rf $WDIR/outputs/ym_k2_a1.000*smoket133*

cat > /tmp/recorr_t133_a3.5_v0.2_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.5
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
echo "[t133] a=3.5 V0=0.2 kz=1.0 (tier=int k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a3.5_v0.2_kz1.0.ini >> $LOG 2>&1) || echo "[t133] a=3.5 V0=0.2 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a3.500_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[t133] a=3.5 V0=0.2 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a4.0_v0.2_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 4.0
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
echo "[t133] a=4.0 V0=0.2 kz=4.0 (tier=int k=4 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a4.0_v0.2_kz4.0.ini >> $LOG 2>&1) || echo "[t133] a=4.0 V0=0.2 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a4.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[t133] a=4.0 V0=0.2 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a4.0_v0.2_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 4.0
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
echo "[t133] a=4.0 V0=0.2 kz=8.0 (tier=int k=8 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a4.0_v0.2_kz8.0.ini >> $LOG 2>&1) || echo "[t133] a=4.0 V0=0.2 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a4.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[t133] a=4.0 V0=0.2 kz=8.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a4.5_v0.2_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 4.5
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
echo "[t133] a=4.5 V0=0.2 kz=4.0 (tier=int k=4 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a4.5_v0.2_kz4.0.ini >> $LOG 2>&1) || echo "[t133] a=4.5 V0=0.2 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a4.500_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[t133] a=4.5 V0=0.2 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a5.0_v0.2_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.0
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
echo "[t133] a=5.0 V0=0.2 kz=1.0 (tier=int k=1 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a5.0_v0.2_kz1.0.ini >> $LOG 2>&1) || echo "[t133] a=5.0 V0=0.2 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a5.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[t133] a=5.0 V0=0.2 kz=1.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a5.0_v0.2_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 5.0
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
echo "[t133] a=5.0 V0=0.2 kz=6.0 (tier=int k=6 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a5.0_v0.2_kz6.0.ini >> $LOG 2>&1) || echo "[t133] a=5.0 V0=0.2 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a5.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[t133] a=5.0 V0=0.2 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a5.5_v0.2_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 5.5
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
echo "[t133] a=5.5 V0=0.2 kz=3.0 (tier=int k=3 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a5.5_v0.2_kz3.0.ini >> $LOG 2>&1) || echo "[t133] a=5.5 V0=0.2 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a5.500_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[t133] a=5.5 V0=0.2 kz=3.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a5.5_v0.2_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 5.5
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
echo "[t133] a=5.5 V0=0.2 kz=7.0 (tier=int k=7 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a5.5_v0.2_kz7.0.ini >> $LOG 2>&1) || echo "[t133] a=5.5 V0=0.2 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a5.500_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[t133] a=5.5 V0=0.2 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a6.0_v0.2_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 6.0
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
echo "[t133] a=6.0 V0=0.2 kz=5.0 (tier=int k=5 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a6.0_v0.2_kz5.0.ini >> $LOG 2>&1) || echo "[t133] a=6.0 V0=0.2 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a6.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[t133] a=6.0 V0=0.2 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a6.0_v0.2_kz9.0.ini <<'EOINI'
k_mode = 9
alpha_YM = 6.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
run_tag = recorr
EOINI
echo "[t133] a=6.0 V0=0.2 kz=9.0 (tier=int k=9 sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a6.0_v0.2_kz9.0.ini >> $LOG 2>&1) || echo "[t133] a=6.0 V0=0.2 kz=9.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a6.000_*_v0.2000_*_recorr" >> $LOG 2>&1)
echo "[t133] a=6.0 V0=0.2 kz=9.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a0.5_v0.07_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.5
V0 = 0.07
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 277.8
run_tag = recorr
EOINI
echo "[t133] a=0.5 V0=0.07 kz=6.0 (tier=int k=6 sp=8.0 tu=277.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a0.5_v0.07_kz6.0.ini >> $LOG 2>&1) || echo "[t133] a=0.5 V0=0.07 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a0.500_*_v0.0700_*_recorr" >> $LOG 2>&1)
echo "[t133] a=0.5 V0=0.07 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a0.6_v0.07_kz9.0.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.6
V0 = 0.07
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 283.5
run_tag = recorr
EOINI
echo "[t133] a=0.6 V0=0.07 kz=9.0 (tier=int k=9 sp=8.0 tu=283.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a0.6_v0.07_kz9.0.ini >> $LOG 2>&1) || echo "[t133] a=0.6 V0=0.07 kz=9.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.600_*_v0.0700_*_recorr" >> $LOG 2>&1)
echo "[t133] a=0.6 V0=0.07 kz=9.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a0.5_v0.04_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.5
V0 = 0.04
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 300.0
run_tag = recorr
EOINI
echo "[t133] a=0.5 V0=0.04 kz=4.0 (tier=int k=4 sp=11.0 tu=300.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a0.5_v0.04_kz4.0.ini >> $LOG 2>&1) || echo "[t133] a=0.5 V0=0.04 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a0.500_*_v0.0400_*_recorr" >> $LOG 2>&1)
echo "[t133] a=0.5 V0=0.04 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a0.6_v0.04_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.6
V0 = 0.04
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 306.2
run_tag = recorr
EOINI
echo "[t133] a=0.6 V0=0.04 kz=6.0 (tier=int k=6 sp=8.0 tu=306.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a0.6_v0.04_kz6.0.ini >> $LOG 2>&1) || echo "[t133] a=0.6 V0=0.04 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a0.600_*_v0.0400_*_recorr" >> $LOG 2>&1)
echo "[t133] a=0.6 V0=0.04 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a0.5_v0.08_kz9.0.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.5
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 318.2
run_tag = recorr
EOINI
echo "[t133] a=0.5 V0=0.08 kz=9.0 (tier=int k=9 sp=8.0 tu=318.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a0.5_v0.08_kz9.0.ini >> $LOG 2>&1) || echo "[t133] a=0.5 V0=0.08 kz=9.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.500_*_v0.0800_*_recorr" >> $LOG 2>&1)
echo "[t133] a=0.5 V0=0.08 kz=9.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a0.7_v0.03_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.7
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
target_tu = 327.3
run_tag = recorr
EOINI
echo "[t133] a=0.7 V0=0.03 kz=7.0 (tier=int k=7 sp=8.0 tu=327.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a0.7_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[t133] a=0.7 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.700_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[t133] a=0.7 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a0.5_v0.07_kz9.0.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.5
V0 = 0.07
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 340.2
run_tag = recorr
EOINI
echo "[t133] a=0.5 V0=0.07 kz=9.0 (tier=int k=9 sp=8.0 tu=340.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a0.5_v0.07_kz9.0.ini >> $LOG 2>&1) || echo "[t133] a=0.5 V0=0.07 kz=9.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.500_*_v0.0700_*_recorr" >> $LOG 2>&1)
echo "[t133] a=0.5 V0=0.07 kz=9.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a0.5_v0.04_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 0.5
V0 = 0.04
perturb_amp = 0.001
run_mode = 6
xi_sponge = 9.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 367.4
run_tag = recorr
EOINI
echo "[t133] a=0.5 V0=0.04 kz=6.0 (tier=int k=6 sp=9.0 tu=367.4) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a0.5_v0.04_kz6.0.ini >> $LOG 2>&1) || echo "[t133] a=0.5 V0=0.04 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a0.500_*_v0.0400_*_recorr" >> $LOG 2>&1)
echo "[t133] a=0.5 V0=0.04 kz=6.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a0.4_v0.07_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.4
V0 = 0.07
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 375.0
run_tag = recorr
EOINI
echo "[t133] a=0.4 V0=0.07 kz=7.0 (tier=int k=7 sp=8.0 tu=375.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a0.4_v0.07_kz7.0.ini >> $LOG 2>&1) || echo "[t133] a=0.4 V0=0.07 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.400_*_v0.0700_*_recorr" >> $LOG 2>&1)
echo "[t133] a=0.4 V0=0.07 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a0.5_v0.03_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.5
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
target_tu = 387.3
run_tag = recorr
EOINI
echo "[t133] a=0.5 V0=0.03 kz=5.0 (tier=int k=5 sp=8.0 tu=387.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a0.5_v0.03_kz5.0.ini >> $LOG 2>&1) || echo "[t133] a=0.5 V0=0.03 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.500_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[t133] a=0.5 V0=0.03 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a0.3_v0.03_kz4.0.ini <<'EOINI'
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
echo "[t133] a=0.3 V0=0.03 kz=4.0 (tier=int k=4 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a0.3_v0.03_kz4.0.ini >> $LOG 2>&1) || echo "[t133] a=0.3 V0=0.03 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a0.300_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[t133] a=0.3 V0=0.03 kz=4.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a0.3_v0.03_kz7.0.ini <<'EOINI'
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
echo "[t133] a=0.3 V0=0.03 kz=7.0 (tier=int k=7 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a0.3_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[t133] a=0.3 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.300_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[t133] a=0.3 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a0.5_v0.03_kz7.0.ini <<'EOINI'
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
kz_suppress_hi = 14
target_tu = 400.0
run_tag = recorr
EOINI
echo "[t133] a=0.5 V0=0.03 kz=7.0 (tier=int k=7 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a0.5_v0.03_kz7.0.ini >> $LOG 2>&1) || echo "[t133] a=0.5 V0=0.03 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.500_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[t133] a=0.5 V0=0.03 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a0.6_v0.03_kz9.0.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = recorr
EOINI
echo "[t133] a=0.6 V0=0.03 kz=9.0 (tier=int k=9 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a0.6_v0.03_kz9.0.ini >> $LOG 2>&1) || echo "[t133] a=0.6 V0=0.03 kz=9.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.600_*_v0.0300_*_recorr" >> $LOG 2>&1)
echo "[t133] a=0.6 V0=0.03 kz=9.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a0.3_v0.04_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.3
V0 = 0.04
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = recorr
EOINI
echo "[t133] a=0.3 V0=0.04 kz=5.0 (tier=int k=5 sp=13.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a0.3_v0.04_kz5.0.ini >> $LOG 2>&1) || echo "[t133] a=0.3 V0=0.04 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.300_*_v0.0400_*_recorr" >> $LOG 2>&1)
echo "[t133] a=0.3 V0=0.04 kz=5.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a0.5_v0.04_kz9.0.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.5
V0 = 0.04
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = recorr
EOINI
echo "[t133] a=0.5 V0=0.04 kz=9.0 (tier=int k=9 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a0.5_v0.04_kz9.0.ini >> $LOG 2>&1) || echo "[t133] a=0.5 V0=0.04 kz=9.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.500_*_v0.0400_*_recorr" >> $LOG 2>&1)
echo "[t133] a=0.5 V0=0.04 kz=9.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a0.4_v0.05_kz7.0.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.4
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
target_tu = 400.0
run_tag = recorr
EOINI
echo "[t133] a=0.4 V0=0.05 kz=7.0 (tier=int k=7 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a0.4_v0.05_kz7.0.ini >> $LOG 2>&1) || echo "[t133] a=0.4 V0=0.05 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.400_*_v0.0500_*_recorr" >> $LOG 2>&1)
echo "[t133] a=0.4 V0=0.05 kz=7.0 done $(date)" >> $LOG

cat > /tmp/recorr_t133_a0.3_v0.08_kz9.0.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.3
V0 = 0.08
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 400.0
run_tag = recorr
EOINI
echo "[t133] a=0.3 V0=0.08 kz=9.0 (tier=int k=9 sp=8.0 tu=400.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_t133_a0.3_v0.08_kz9.0.ini >> $LOG 2>&1) || echo "[t133] a=0.3 V0=0.08 kz=9.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.300_*_v0.0800_*_recorr" >> $LOG 2>&1)
echo "[t133] a=0.3 V0=0.08 kz=9.0 done $(date)" >> $LOG

echo "=== t133 ALL DONE $(date) ===" >> $LOG
