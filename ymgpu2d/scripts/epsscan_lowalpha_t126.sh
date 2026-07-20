#!/bin/bash
# EPS-scan low-alpha extension -- t126: 16 runs (2026-07-20)
WDIR=/DATA/cm/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs
LOG=$WDIR/logs/epsscan_lowalpha_t126_progress.log
echo "=== epsscan_lowalpha t126 start $(date) ===" >> $LOG
cat > /tmp/epslowa_smoke_t126.ini <<'EOINI'
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
eps_override = 0.10
nx_override = 1152
kz_suppress_hi = 14
target_tu = 2
run_tag = smokelowat126_nx1152
EOINI
rm -rf $WDIR/outputs/ym_k2_a1.000*smokelowat126*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_smoke_t126.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000*smokelowat126*" >> $LOG 2>&1)
python3 - "$WDIR" t126 <<'EOPY' >> $LOG 2>&1 || { echo "[t126] SMOKE TEST FAILED -- stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, math, sys
w, stream = sys.argv[1], sys.argv[2]
dirs = glob.glob(w + "/outputs/ym_k2_a1.000*smokelowa" + stream + "*")
assert dirs, "smoke: no output dir written"
assert any("_nx1152" in d for d in dirs), "smoke: nx_override tag missing from dir name"
fs = glob.glob(w + "/outputs/ym_k2_a1.000*smokelowa" + stream + "*/timeseries_k2.csv")
assert fs, "smoke: no timeseries written"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert rows and 'amp_conj' in rows[0], "smoke: extractor is not the fixed version"
a0 = float(rows[0]['amp'])
assert a0 > 0 and math.log(a0) > -20, "smoke: seed missing from measured channel (logamp=%.1f)" % (math.log(a0) if a0 > 0 else -99)
print("[%s] smoke test OK: logamp0=%.1f" % (stream, math.log(a0)))
EOPY
rm -rf $WDIR/outputs/ym_k2_a1.000*smokelowat126*

cat > /tmp/epslowa_t126_0_a0.25_v0.1_eps0.15_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.25
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 65.0
run_tag = epsscanlowalpha
EOINI
echo "[t126] a=0.25 V0=0.1 EPS=0.15 kz=2.0(int) k=2 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t126_0_a0.25_v0.1_eps0.15_kz2.0.ini >> $LOG 2>&1) || echo "[t126] a=0.25 V0=0.1 EPS=0.15 kz=2.0(int) k=2 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.250_*_v0.1000_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t126] a=0.25 V0=0.1 EPS=0.15 kz=2.0(int) k=2 done $(date)" >> $LOG

cat > /tmp/epslowa_t126_1_a0.4_v0.1_eps0.3_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.3
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 65.0
run_tag = epsscanlowalpha
EOINI
echo "[t126] a=0.4 V0=0.1 EPS=0.3 kz=2.0(int) k=2 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t126_1_a0.4_v0.1_eps0.3_kz2.0.ini >> $LOG 2>&1) || echo "[t126] a=0.4 V0=0.1 EPS=0.3 kz=2.0(int) k=2 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.400_*_v0.1000_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t126] a=0.4 V0=0.1 EPS=0.3 kz=2.0(int) k=2 done $(date)" >> $LOG

cat > /tmp/epslowa_t126_2_a0.4_v0.1_eps0.1_kz1.0.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.1
kz_suppress_hi = 14
nx_override = 1152
target_tu = 65.0
run_tag = epsscanlowalpha
EOINI
echo "[t126] a=0.4 V0=0.1 EPS=0.1 kz=1.0(int) k=1 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t126_2_a0.4_v0.1_eps0.1_kz1.0.ini >> $LOG 2>&1) || echo "[t126] a=0.4 V0=0.1 EPS=0.1 kz=1.0(int) k=1 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a0.400_*_v0.1000_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t126] a=0.4 V0=0.1 EPS=0.1 kz=1.0(int) k=1 done $(date)" >> $LOG

cat > /tmp/epslowa_t126_3_a0.2_v0.1_eps0.3_kz1.75.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.3
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
nx_override = 1536
lx_override = 37.699112
target_tu = 65.0
run_tag = epsscanlowalpha
EOINI
echo "[t126] a=0.2 V0=0.1 EPS=0.3 kz=1.75(quarter) k=7 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t126_3_a0.2_v0.1_eps0.3_kz1.75.ini >> $LOG 2>&1) || echo "[t126] a=0.2 V0=0.1 EPS=0.3 kz=1.75(quarter) k=7 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.200_*_v0.1000_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t126] a=0.2 V0=0.1 EPS=0.3 kz=1.75(quarter) k=7 done $(date)" >> $LOG

cat > /tmp/epslowa_t126_4_a0.4_v0.1_eps0.1_kz2.25.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.1
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
nx_override = 1152
target_tu = 65.0
run_tag = epsscanlowalpha
EOINI
echo "[t126] a=0.4 V0=0.1 EPS=0.1 kz=2.25(quarter) k=9 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t126_4_a0.4_v0.1_eps0.1_kz2.25.ini >> $LOG 2>&1) || echo "[t126] a=0.4 V0=0.1 EPS=0.1 kz=2.25(quarter) k=9 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.400_*_v0.1000_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t126] a=0.4 V0=0.1 EPS=0.1 kz=2.25(quarter) k=9 done $(date)" >> $LOG

cat > /tmp/epslowa_t126_5_a0.4_v0.1_eps0.1_kz2.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.1
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
nx_override = 1152
target_tu = 65.0
run_tag = epsscanlowalpha
EOINI
echo "[t126] a=0.4 V0=0.1 EPS=0.1 kz=2.0(quarter) k=8 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t126_5_a0.4_v0.1_eps0.1_kz2.0.ini >> $LOG 2>&1) || echo "[t126] a=0.4 V0=0.1 EPS=0.1 kz=2.0(quarter) k=8 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a0.400_*_v0.1000_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t126] a=0.4 V0=0.1 EPS=0.1 kz=2.0(quarter) k=8 done $(date)" >> $LOG

cat > /tmp/epslowa_t126_6_a0.4_v0.03_eps0.1_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.1
kz_suppress_hi = 14
nx_override = 1152
target_tu = 375.0
run_tag = epsscanlowalpha
EOINI
echo "[t126] a=0.4 V0=0.03 EPS=0.1 kz=3.0(int) k=3 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t126_6_a0.4_v0.03_eps0.1_kz3.0.ini >> $LOG 2>&1) || echo "[t126] a=0.4 V0=0.03 EPS=0.1 kz=3.0(int) k=3 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a0.400_*_v0.0300_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t126] a=0.4 V0=0.03 EPS=0.1 kz=3.0(int) k=3 done $(date)" >> $LOG

cat > /tmp/epslowa_t126_7_a0.2_v0.03_eps0.45_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.45
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 400.0
run_tag = epsscanlowalpha
EOINI
echo "[t126] a=0.2 V0=0.03 EPS=0.45 kz=3.0(int) k=3 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t126_7_a0.2_v0.03_eps0.45_kz3.0.ini >> $LOG 2>&1) || echo "[t126] a=0.2 V0=0.03 EPS=0.45 kz=3.0(int) k=3 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a0.200_*_v0.0300_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t126] a=0.2 V0=0.03 EPS=0.45 kz=3.0(int) k=3 done $(date)" >> $LOG

cat > /tmp/epslowa_t126_8_a0.4_v0.05_eps0.1_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.1
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
nx_override = 1152
target_tu = 265.3
run_tag = epsscanlowalpha
EOINI
echo "[t126] a=0.4 V0=0.05 EPS=0.1 kz=2.5(half) k=5 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t126_8_a0.4_v0.05_eps0.1_kz2.5.ini >> $LOG 2>&1) || echo "[t126] a=0.4 V0=0.05 EPS=0.1 kz=2.5(half) k=5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.400_*_v0.0500_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t126] a=0.4 V0=0.05 EPS=0.1 kz=2.5(half) k=5 done $(date)" >> $LOG

cat > /tmp/epslowa_t126_9_a0.25_v0.03_eps0.15_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.25
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
target_tu = 400.0
run_tag = epsscanlowalpha
EOINI
echo "[t126] a=0.25 V0=0.03 EPS=0.15 kz=2.5(half) k=5 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t126_9_a0.25_v0.03_eps0.15_kz2.5.ini >> $LOG 2>&1) || echo "[t126] a=0.25 V0=0.03 EPS=0.15 kz=2.5(half) k=5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.250_*_v0.0300_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t126] a=0.25 V0=0.03 EPS=0.15 kz=2.5(half) k=5 done $(date)" >> $LOG

cat > /tmp/epslowa_t126_10_a0.3_v0.03_eps0.15_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
target_tu = 400.0
run_tag = epsscanlowalpha
EOINI
echo "[t126] a=0.3 V0=0.03 EPS=0.15 kz=2.5(half) k=5 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t126_10_a0.3_v0.03_eps0.15_kz2.5.ini >> $LOG 2>&1) || echo "[t126] a=0.3 V0=0.03 EPS=0.15 kz=2.5(half) k=5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.300_*_v0.0300_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t126] a=0.3 V0=0.03 EPS=0.15 kz=2.5(half) k=5 done $(date)" >> $LOG

cat > /tmp/epslowa_t126_11_a0.3_v0.05_eps0.15_kz2.25.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
target_tu = 335.5
run_tag = epsscanlowalpha
EOINI
echo "[t126] a=0.3 V0=0.05 EPS=0.15 kz=2.25(quarter) k=9 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t126_11_a0.3_v0.05_eps0.15_kz2.25.ini >> $LOG 2>&1) || echo "[t126] a=0.3 V0=0.05 EPS=0.15 kz=2.25(quarter) k=9 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.300_*_v0.0500_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t126] a=0.3 V0=0.05 EPS=0.15 kz=2.25(quarter) k=9 done $(date)" >> $LOG

cat > /tmp/epslowa_t126_12_a0.2_v0.03_eps0.15_kz2.25.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
target_tu = 400.0
run_tag = epsscanlowalpha
EOINI
echo "[t126] a=0.2 V0=0.03 EPS=0.15 kz=2.25(quarter) k=9 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t126_12_a0.2_v0.03_eps0.15_kz2.25.ini >> $LOG 2>&1) || echo "[t126] a=0.2 V0=0.03 EPS=0.15 kz=2.25(quarter) k=9 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.200_*_v0.0300_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t126] a=0.2 V0=0.03 EPS=0.15 kz=2.25(quarter) k=9 done $(date)" >> $LOG

cat > /tmp/epslowa_t126_13_a0.2_v0.05_eps0.45_kz1.75.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.45
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
nx_override = 1536
lx_override = 37.699112
target_tu = 400.0
run_tag = epsscanlowalpha
EOINI
echo "[t126] a=0.2 V0=0.05 EPS=0.45 kz=1.75(quarter) k=7 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t126_13_a0.2_v0.05_eps0.45_kz1.75.ini >> $LOG 2>&1) || echo "[t126] a=0.2 V0=0.05 EPS=0.45 kz=1.75(quarter) k=7 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.200_*_v0.0500_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t126] a=0.2 V0=0.05 EPS=0.45 kz=1.75(quarter) k=7 done $(date)" >> $LOG

cat > /tmp/epslowa_t126_14_a0.25_v0.05_eps0.15_kz2.25.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.25
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
target_tu = 400.0
run_tag = epsscanlowalpha
EOINI
echo "[t126] a=0.25 V0=0.05 EPS=0.15 kz=2.25(quarter) k=9 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t126_14_a0.25_v0.05_eps0.15_kz2.25.ini >> $LOG 2>&1) || echo "[t126] a=0.25 V0=0.05 EPS=0.15 kz=2.25(quarter) k=9 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.250_*_v0.0500_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t126] a=0.25 V0=0.05 EPS=0.15 kz=2.25(quarter) k=9 done $(date)" >> $LOG

cat > /tmp/epslowa_t126_15_a0.3_v0.03_eps0.3_kz2.25.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.3
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
nx_override = 1536
lx_override = 37.699112
target_tu = 400.0
run_tag = epsscanlowalpha
EOINI
echo "[t126] a=0.3 V0=0.03 EPS=0.3 kz=2.25(quarter) k=9 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t126_15_a0.3_v0.03_eps0.3_kz2.25.ini >> $LOG 2>&1) || echo "[t126] a=0.3 V0=0.03 EPS=0.3 kz=2.25(quarter) k=9 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.300_*_v0.0300_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t126] a=0.3 V0=0.03 EPS=0.3 kz=2.25(quarter) k=9 done $(date)" >> $LOG

echo "=== t126 ALL DONE $(date) ===" >> $LOG
