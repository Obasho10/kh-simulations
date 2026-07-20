#!/bin/bash
# EPS-scan low-alpha extension -- t133: 16 runs (2026-07-20)
WDIR=/DATA/ym_kh/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs
LOG=$WDIR/logs/epsscan_lowalpha_t133_progress.log
echo "=== epsscan_lowalpha t133 start $(date) ===" >> $LOG
cat > /tmp/epslowa_smoke_t133.ini <<'EOINI'
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
run_tag = smokelowat133_nx1152
EOINI
rm -rf $WDIR/outputs/ym_k2_a1.000*smokelowat133*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_smoke_t133.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000*smokelowat133*" >> $LOG 2>&1)
python3 - "$WDIR" t133 <<'EOPY' >> $LOG 2>&1 || { echo "[t133] SMOKE TEST FAILED -- stream ABORTED $(date)" >> $LOG; exit 1; }
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
rm -rf $WDIR/outputs/ym_k2_a1.000*smokelowat133*

cat > /tmp/epslowa_t133_0_a0.4_v0.1_eps0.1_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.1
kz_suppress_hi = 14
nx_override = 1152
target_tu = 65.0
run_tag = epsscanlowalpha
EOINI
echo "[t133] a=0.4 V0=0.1 EPS=0.1 kz=4.0(int) k=4 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t133_0_a0.4_v0.1_eps0.1_kz4.0.ini >> $LOG 2>&1) || echo "[t133] a=0.4 V0=0.1 EPS=0.1 kz=4.0(int) k=4 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a0.400_*_v0.1000_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t133] a=0.4 V0=0.1 EPS=0.1 kz=4.0(int) k=4 done $(date)" >> $LOG

cat > /tmp/epslowa_t133_1_a0.2_v0.1_eps0.45_kz1.5.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.45
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
nx_override = 1536
lx_override = 37.699112
target_tu = 65.0
run_tag = epsscanlowalpha
EOINI
echo "[t133] a=0.2 V0=0.1 EPS=0.45 kz=1.5(half) k=3 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t133_1_a0.2_v0.1_eps0.45_kz1.5.ini >> $LOG 2>&1) || echo "[t133] a=0.2 V0=0.1 EPS=0.45 kz=1.5(half) k=3 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a0.200_*_v0.1000_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t133] a=0.2 V0=0.1 EPS=0.45 kz=1.5(half) k=3 done $(date)" >> $LOG

cat > /tmp/epslowa_t133_2_a0.4_v0.1_eps0.1_kz2.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.1
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
nx_override = 1152
target_tu = 65.0
run_tag = epsscanlowalpha
EOINI
echo "[t133] a=0.4 V0=0.1 EPS=0.1 kz=2.0(half) k=4 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t133_2_a0.4_v0.1_eps0.1_kz2.0.ini >> $LOG 2>&1) || echo "[t133] a=0.4 V0=0.1 EPS=0.1 kz=2.0(half) k=4 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a0.400_*_v0.1000_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t133] a=0.4 V0=0.1 EPS=0.1 kz=2.0(half) k=4 done $(date)" >> $LOG

cat > /tmp/epslowa_t133_3_a0.25_v0.1_eps0.225_kz1.75.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.25
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.225
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
target_tu = 65.0
run_tag = epsscanlowalpha
EOINI
echo "[t133] a=0.25 V0=0.1 EPS=0.225 kz=1.75(quarter) k=7 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t133_3_a0.25_v0.1_eps0.225_kz1.75.ini >> $LOG 2>&1) || echo "[t133] a=0.25 V0=0.1 EPS=0.225 kz=1.75(quarter) k=7 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.250_*_v0.1000_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t133] a=0.25 V0=0.1 EPS=0.225 kz=1.75(quarter) k=7 done $(date)" >> $LOG

cat > /tmp/epslowa_t133_4_a0.25_v0.1_eps0.45_kz1.75.ini <<'EOINI'
k_mode = 7
alpha_YM = 0.25
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.45
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
nx_override = 1536
lx_override = 37.699112
target_tu = 65.0
run_tag = epsscanlowalpha
EOINI
echo "[t133] a=0.25 V0=0.1 EPS=0.45 kz=1.75(quarter) k=7 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t133_4_a0.25_v0.1_eps0.45_kz1.75.ini >> $LOG 2>&1) || echo "[t133] a=0.25 V0=0.1 EPS=0.45 kz=1.75(quarter) k=7 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a0.250_*_v0.1000_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t133] a=0.25 V0=0.1 EPS=0.45 kz=1.75(quarter) k=7 done $(date)" >> $LOG

cat > /tmp/epslowa_t133_5_a0.4_v0.1_eps0.225_kz2.25.ini <<'EOINI'
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
eps_override = 0.225
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
target_tu = 65.0
run_tag = epsscanlowalpha
EOINI
echo "[t133] a=0.4 V0=0.1 EPS=0.225 kz=2.25(quarter) k=9 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t133_5_a0.4_v0.1_eps0.225_kz2.25.ini >> $LOG 2>&1) || echo "[t133] a=0.4 V0=0.1 EPS=0.225 kz=2.25(quarter) k=9 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.400_*_v0.1000_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t133] a=0.4 V0=0.1 EPS=0.225 kz=2.25(quarter) k=9 done $(date)" >> $LOG

cat > /tmp/epslowa_t133_6_a0.25_v0.05_eps0.45_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.25
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.45
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 379.6
run_tag = epsscanlowalpha
EOINI
echo "[t133] a=0.25 V0=0.05 EPS=0.45 kz=2.0(int) k=2 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t133_6_a0.25_v0.05_eps0.45_kz2.0.ini >> $LOG 2>&1) || echo "[t133] a=0.25 V0=0.05 EPS=0.45 kz=2.0(int) k=2 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.250_*_v0.0500_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t133] a=0.25 V0=0.05 EPS=0.45 kz=2.0(int) k=2 done $(date)" >> $LOG

cat > /tmp/epslowa_t133_7_a0.2_v0.03_eps0.45_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.45
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 400.0
run_tag = epsscanlowalpha
EOINI
echo "[t133] a=0.2 V0=0.03 EPS=0.45 kz=2.0(int) k=2 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t133_7_a0.2_v0.03_eps0.45_kz2.0.ini >> $LOG 2>&1) || echo "[t133] a=0.2 V0=0.03 EPS=0.45 kz=2.0(int) k=2 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.200_*_v0.0300_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t133] a=0.2 V0=0.03 EPS=0.45 kz=2.0(int) k=2 done $(date)" >> $LOG

cat > /tmp/epslowa_t133_8_a0.4_v0.03_eps0.3_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.3
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
nx_override = 1536
lx_override = 37.699112
target_tu = 342.4
run_tag = epsscanlowalpha
EOINI
echo "[t133] a=0.4 V0=0.03 EPS=0.3 kz=2.5(half) k=5 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t133_8_a0.4_v0.03_eps0.3_kz2.5.ini >> $LOG 2>&1) || echo "[t133] a=0.4 V0=0.03 EPS=0.3 kz=2.5(half) k=5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.400_*_v0.0300_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t133] a=0.4 V0=0.03 EPS=0.3 kz=2.5(half) k=5 done $(date)" >> $LOG

cat > /tmp/epslowa_t133_9_a0.25_v0.05_eps0.3_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.25
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.3
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
nx_override = 1536
lx_override = 37.699112
target_tu = 400.0
run_tag = epsscanlowalpha
EOINI
echo "[t133] a=0.25 V0=0.05 EPS=0.3 kz=2.5(half) k=5 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t133_9_a0.25_v0.05_eps0.3_kz2.5.ini >> $LOG 2>&1) || echo "[t133] a=0.25 V0=0.05 EPS=0.3 kz=2.5(half) k=5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.250_*_v0.0500_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t133] a=0.25 V0=0.05 EPS=0.3 kz=2.5(half) k=5 done $(date)" >> $LOG

cat > /tmp/epslowa_t133_10_a0.2_v0.03_eps0.45_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.45
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
nx_override = 1536
lx_override = 37.699112
target_tu = 400.0
run_tag = epsscanlowalpha
EOINI
echo "[t133] a=0.2 V0=0.03 EPS=0.45 kz=2.5(half) k=5 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t133_10_a0.2_v0.03_eps0.45_kz2.5.ini >> $LOG 2>&1) || echo "[t133] a=0.2 V0=0.03 EPS=0.45 kz=2.5(half) k=5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.200_*_v0.0300_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t133] a=0.2 V0=0.03 EPS=0.45 kz=2.5(half) k=5 done $(date)" >> $LOG

cat > /tmp/epslowa_t133_11_a0.4_v0.05_eps0.225_kz2.25.ini <<'EOINI'
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
eps_override = 0.225
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
target_tu = 251.7
run_tag = epsscanlowalpha
EOINI
echo "[t133] a=0.4 V0=0.05 EPS=0.225 kz=2.25(quarter) k=9 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t133_11_a0.4_v0.05_eps0.225_kz2.25.ini >> $LOG 2>&1) || echo "[t133] a=0.4 V0=0.05 EPS=0.225 kz=2.25(quarter) k=9 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.400_*_v0.0500_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t133] a=0.4 V0=0.05 EPS=0.225 kz=2.25(quarter) k=9 done $(date)" >> $LOG

cat > /tmp/epslowa_t133_12_a0.2_v0.03_eps0.225_kz2.25.ini <<'EOINI'
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
eps_override = 0.225
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
target_tu = 400.0
run_tag = epsscanlowalpha
EOINI
echo "[t133] a=0.2 V0=0.03 EPS=0.225 kz=2.25(quarter) k=9 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t133_12_a0.2_v0.03_eps0.225_kz2.25.ini >> $LOG 2>&1) || echo "[t133] a=0.2 V0=0.03 EPS=0.225 kz=2.25(quarter) k=9 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.200_*_v0.0300_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t133] a=0.2 V0=0.03 EPS=0.225 kz=2.25(quarter) k=9 done $(date)" >> $LOG

cat > /tmp/epslowa_t133_13_a0.2_v0.05_eps0.1_kz2.25.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.1
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
nx_override = 1152
target_tu = 400.0
run_tag = epsscanlowalpha
EOINI
echo "[t133] a=0.2 V0=0.05 EPS=0.1 kz=2.25(quarter) k=9 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t133_13_a0.2_v0.05_eps0.1_kz2.25.ini >> $LOG 2>&1) || echo "[t133] a=0.2 V0=0.05 EPS=0.1 kz=2.25(quarter) k=9 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.200_*_v0.0500_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t133] a=0.2 V0=0.05 EPS=0.1 kz=2.25(quarter) k=9 done $(date)" >> $LOG

cat > /tmp/epslowa_t133_14_a0.25_v0.03_eps0.225_kz2.25.ini <<'EOINI'
k_mode = 9
alpha_YM = 0.25
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.225
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
target_tu = 400.0
run_tag = epsscanlowalpha
EOINI
echo "[t133] a=0.25 V0=0.03 EPS=0.225 kz=2.25(quarter) k=9 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t133_14_a0.25_v0.03_eps0.225_kz2.25.ini >> $LOG 2>&1) || echo "[t133] a=0.25 V0=0.03 EPS=0.225 kz=2.25(quarter) k=9 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a0.250_*_v0.0300_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t133] a=0.25 V0=0.03 EPS=0.225 kz=2.25(quarter) k=9 done $(date)" >> $LOG

cat > /tmp/epslowa_t133_15_a0.3_v0.03_eps0.1_kz2.75.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.3
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.1
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
nx_override = 1152
target_tu = 400.0
run_tag = epsscanlowalpha
EOINI
echo "[t133] a=0.3 V0=0.03 EPS=0.1 kz=2.75(quarter) k=11 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epslowa_t133_15_a0.3_v0.03_eps0.1_kz2.75.ini >> $LOG 2>&1) || echo "[t133] a=0.3 V0=0.03 EPS=0.1 kz=2.75(quarter) k=11 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a0.300_*_v0.0300_*_epsscanlowalpha" >> $LOG 2>&1)
echo "[t133] a=0.3 V0=0.03 EPS=0.1 kz=2.75(quarter) k=11 done $(date)" >> $LOG

echo "=== t133 ALL DONE $(date) ===" >> $LOG
