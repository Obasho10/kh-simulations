#!/bin/bash
# EPS-scan v2 (theory-validation campaign) -- t126: 31 runs
WDIR=/DATA/cm/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs
LOG=$WDIR/logs/epsscan_v2_t126_progress.log
echo "=== epsscan_v2 start $(date) ===" >> $LOG
cat > /tmp/epsscanv2_smoke_t126.ini <<'EOINI'
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
run_tag = smokev2t126_nx1152
EOINI
rm -rf $WDIR/outputs/ym_k2_a1.000*smokev2t126*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscanv2_smoke_t126.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000*smokev2t126*" >> $LOG 2>&1)
python3 - "$WDIR" t126 <<'EOPY' >> $LOG 2>&1 || { echo "[t126] SMOKE TEST FAILED -- stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, math, sys
w, stream = sys.argv[1], sys.argv[2]
dirs = glob.glob(w + "/outputs/ym_k2_a1.000*smokev2" + stream + "*")
assert dirs, "smoke: no output dir written"
assert any("_nx1152" in d for d in dirs), "smoke: nx_override tag missing from dir name"
fs = glob.glob(w + "/outputs/ym_k2_a1.000*smokev2" + stream + "*/timeseries_k2.csv")
assert fs, "smoke: no timeseries written"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert rows and 'amp_conj' in rows[0], "smoke: extractor is not the fixed version"
a0 = float(rows[0]['amp'])
assert a0 > 0 and math.log(a0) > -20, "smoke: seed missing from measured channel (logamp=%.1f)" % (math.log(a0) if a0 > 0 else -99)
print("[%s] smoke test OK (nx_override tag + narrow-EPS + xi_cut/eps_override wiring): logamp0=%.1f" % (stream, math.log(a0)))
EOPY
rm -rf $WDIR/outputs/ym_k2_a1.000*smokev2t126*

cat > /tmp/epsv2_t126_0_a0.5_v0.1_eps0.45_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.45
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 65.0
run_tag = epsscanv2
EOINI
echo "[t126] a=0.5 V0=0.1 EPS=0.45 kz=2.0(int) k=2 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_0_a0.5_v0.1_eps0.45_kz2.0.ini >> $LOG 2>&1) || echo "[t126] a=0.5 V0=0.1 EPS=0.45 kz=2.0(int) k=2 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.500_*_v0.1000_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=0.5 V0=0.1 EPS=0.45 kz=2.0(int) k=2 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_1_a6.0_v0.1_eps0.1_kz6.0.ini <<'EOINI'
k_mode = 6
alpha_YM = 6.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.1
kz_suppress_hi = 14
nx_override = 1152
target_tu = 65.0
run_tag = epsscanv2
EOINI
echo "[t126] a=6.0 V0=0.1 EPS=0.1 kz=6.0(int) k=6 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_1_a6.0_v0.1_eps0.1_kz6.0.ini >> $LOG 2>&1) || echo "[t126] a=6.0 V0=0.1 EPS=0.1 kz=6.0(int) k=6 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a6.000_*_v0.1000_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=6.0 V0=0.1 EPS=0.1 kz=6.0(int) k=6 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_2_a10.0_v0.1_eps0.45_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 10.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.45
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 65.0
run_tag = epsscanv2
EOINI
echo "[t126] a=10.0 V0=0.1 EPS=0.45 kz=8.0(int) k=8 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_2_a10.0_v0.1_eps0.45_kz8.0.ini >> $LOG 2>&1) || echo "[t126] a=10.0 V0=0.1 EPS=0.45 kz=8.0(int) k=8 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a10.000_*_v0.1000_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=10.0 V0=0.1 EPS=0.45 kz=8.0(int) k=8 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_3_a6.0_v0.1_eps0.1_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 6.0
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
run_tag = epsscanv2
EOINI
echo "[t126] a=6.0 V0=0.1 EPS=0.1 kz=4.0(int) k=4 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_3_a6.0_v0.1_eps0.1_kz4.0.ini >> $LOG 2>&1) || echo "[t126] a=6.0 V0=0.1 EPS=0.1 kz=4.0(int) k=4 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a6.000_*_v0.1000_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=6.0 V0=0.1 EPS=0.1 kz=4.0(int) k=4 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_4_a6.0_v0.1_eps0.1_kz8.0.ini <<'EOINI'
k_mode = 8
alpha_YM = 6.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.1
kz_suppress_hi = 14
nx_override = 1152
target_tu = 65.0
run_tag = epsscanv2
EOINI
echo "[t126] a=6.0 V0=0.1 EPS=0.1 kz=8.0(int) k=8 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_4_a6.0_v0.1_eps0.1_kz8.0.ini >> $LOG 2>&1) || echo "[t126] a=6.0 V0=0.1 EPS=0.1 kz=8.0(int) k=8 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a6.000_*_v0.1000_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=6.0 V0=0.1 EPS=0.1 kz=8.0(int) k=8 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_5_a1.5_v0.05_eps0.1_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.1
kz_suppress_hi = 14
nx_override = 1152
target_tu = 100.0
run_tag = epsscanv2
EOINI
echo "[t126] a=1.5 V0=0.05 EPS=0.1 kz=4.0(int) k=4 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_5_a1.5_v0.05_eps0.1_kz4.0.ini >> $LOG 2>&1) || echo "[t126] a=1.5 V0=0.05 EPS=0.1 kz=4.0(int) k=4 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a1.500_*_v0.0500_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=1.5 V0=0.05 EPS=0.1 kz=4.0(int) k=4 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_6_a3.0_v0.05_eps0.45_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.45
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
run_tag = epsscanv2
EOINI
echo "[t126] a=3.0 V0=0.05 EPS=0.45 kz=5.0(int) k=5 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_6_a3.0_v0.05_eps0.45_kz5.0.ini >> $LOG 2>&1) || echo "[t126] a=3.0 V0=0.05 EPS=0.45 kz=5.0(int) k=5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a3.000_*_v0.0500_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=3.0 V0=0.05 EPS=0.45 kz=5.0(int) k=5 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_7_a1.5_v0.03_eps0.3_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.3
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 115.5
run_tag = epsscanv2
EOINI
echo "[t126] a=1.5 V0=0.03 EPS=0.3 kz=4.0(int) k=4 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_7_a1.5_v0.03_eps0.3_kz4.0.ini >> $LOG 2>&1) || echo "[t126] a=1.5 V0=0.03 EPS=0.3 kz=4.0(int) k=4 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a1.500_*_v0.0300_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=1.5 V0=0.03 EPS=0.3 kz=4.0(int) k=4 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_8_a0.5_v0.1_eps0.1_kz2.5.ini <<'EOINI'
k_mode = 5
alpha_YM = 0.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.1
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
nx_override = 1152
target_tu = 65.0
run_tag = epsscanv2
EOINI
echo "[t126] a=0.5 V0=0.1 EPS=0.1 kz=2.5(half) k=5 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_8_a0.5_v0.1_eps0.1_kz2.5.ini >> $LOG 2>&1) || echo "[t126] a=0.5 V0=0.1 EPS=0.1 kz=2.5(half) k=5 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a0.500_*_v0.1000_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=0.5 V0=0.1 EPS=0.1 kz=2.5(half) k=5 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_9_a1.5_v0.1_eps0.1_kz3.5.ini <<'EOINI'
k_mode = 7
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.1
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
nx_override = 1152
target_tu = 65.0
run_tag = epsscanv2
EOINI
echo "[t126] a=1.5 V0=0.1 EPS=0.1 kz=3.5(half) k=7 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_9_a1.5_v0.1_eps0.1_kz3.5.ini >> $LOG 2>&1) || echo "[t126] a=1.5 V0=0.1 EPS=0.1 kz=3.5(half) k=7 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.500_*_v0.1000_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=1.5 V0=0.1 EPS=0.1 kz=3.5(half) k=7 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_10_a3.0_v0.1_eps0.3_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.3
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
nx_override = 1536
lx_override = 37.699112
target_tu = 65.0
run_tag = epsscanv2
EOINI
echo "[t126] a=3.0 V0=0.1 EPS=0.3 kz=4.5(half) k=9 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_10_a3.0_v0.1_eps0.3_kz4.5.ini >> $LOG 2>&1) || echo "[t126] a=3.0 V0=0.1 EPS=0.3 kz=4.5(half) k=9 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a3.000_*_v0.1000_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=3.0 V0=0.1 EPS=0.3 kz=4.5(half) k=9 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_11_a6.0_v0.1_eps0.1_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 6.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.1
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
nx_override = 1152
target_tu = 65.0
run_tag = epsscanv2
EOINI
echo "[t126] a=6.0 V0=0.1 EPS=0.1 kz=5.5(half) k=11 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_11_a6.0_v0.1_eps0.1_kz5.5.ini >> $LOG 2>&1) || echo "[t126] a=6.0 V0=0.1 EPS=0.1 kz=5.5(half) k=11 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a6.000_*_v0.1000_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=6.0 V0=0.1 EPS=0.1 kz=5.5(half) k=11 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_12_a1.5_v0.05_eps0.3_kz3.5.ini <<'EOINI'
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
eps_override = 0.3
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
run_tag = epsscanv2
EOINI
echo "[t126] a=1.5 V0=0.05 EPS=0.3 kz=3.5(half) k=7 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_12_a1.5_v0.05_eps0.3_kz3.5.ini >> $LOG 2>&1) || echo "[t126] a=1.5 V0=0.05 EPS=0.3 kz=3.5(half) k=7 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.500_*_v0.0500_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=1.5 V0=0.05 EPS=0.3 kz=3.5(half) k=7 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_13_a6.0_v0.03_eps0.1_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 6.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.1
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
nx_override = 1152
target_tu = 100.0
run_tag = epsscanv2
EOINI
echo "[t126] a=6.0 V0=0.03 EPS=0.1 kz=7.5(half) k=15 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_13_a6.0_v0.03_eps0.1_kz7.5.ini >> $LOG 2>&1) || echo "[t126] a=6.0 V0=0.03 EPS=0.1 kz=7.5(half) k=15 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a6.000_*_v0.0300_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=6.0 V0=0.03 EPS=0.1 kz=7.5(half) k=15 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_14_a10.0_v0.03_eps0.1_kz8.5.ini <<'EOINI'
k_mode = 17
alpha_YM = 10.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 16
eps_override = 0.1
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
nx_override = 1152
target_tu = 100.0
run_tag = epsscanv2
EOINI
echo "[t126] a=10.0 V0=0.03 EPS=0.1 kz=8.5(half) k=17 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_14_a10.0_v0.03_eps0.1_kz8.5.ini >> $LOG 2>&1) || echo "[t126] a=10.0 V0=0.03 EPS=0.1 kz=8.5(half) k=17 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k17_a10.000_*_v0.0300_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=10.0 V0=0.03 EPS=0.1 kz=8.5(half) k=17 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_15_a10.0_v0.05_eps0.3_kz7.5.ini <<'EOINI'
k_mode = 15
alpha_YM = 10.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 14
eps_override = 0.3
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
run_tag = epsscanv2
EOINI
echo "[t126] a=10.0 V0=0.05 EPS=0.3 kz=7.5(half) k=15 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_15_a10.0_v0.05_eps0.3_kz7.5.ini >> $LOG 2>&1) || echo "[t126] a=10.0 V0=0.05 EPS=0.3 kz=7.5(half) k=15 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a10.000_*_v0.0500_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=10.0 V0=0.05 EPS=0.3 kz=7.5(half) k=15 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_16_a1.5_v0.03_eps0.1_kz4.5.ini <<'EOINI'
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
eps_override = 0.1
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
nx_override = 1152
target_tu = 122.5
run_tag = epsscanv2
EOINI
echo "[t126] a=1.5 V0=0.03 EPS=0.1 kz=4.5(half) k=9 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_16_a1.5_v0.03_eps0.1_kz4.5.ini >> $LOG 2>&1) || echo "[t126] a=1.5 V0=0.03 EPS=0.1 kz=4.5(half) k=9 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k9_a1.500_*_v0.0300_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=1.5 V0=0.03 EPS=0.1 kz=4.5(half) k=9 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_17_a0.5_v0.03_eps0.45_kz2.0.ini <<'EOINI'
k_mode = 2
alpha_YM = 0.5
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
target_tu = 245.1
run_tag = epsscanv2
EOINI
echo "[t126] a=0.5 V0=0.03 EPS=0.45 kz=2.0(int) k=2 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_17_a0.5_v0.03_eps0.45_kz2.0.ini >> $LOG 2>&1) || echo "[t126] a=0.5 V0=0.03 EPS=0.45 kz=2.0(int) k=2 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a0.500_*_v0.0300_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=0.5 V0=0.03 EPS=0.45 kz=2.0(int) k=2 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_18_a1.5_v0.1_eps0.225_kz3.25.ini <<'EOINI'
k_mode = 13
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.225
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
target_tu = 65.0
run_tag = epsscanv2
EOINI
echo "[t126] a=1.5 V0=0.1 EPS=0.225 kz=3.25(quarter) k=13 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_18_a1.5_v0.1_eps0.225_kz3.25.ini >> $LOG 2>&1) || echo "[t126] a=1.5 V0=0.1 EPS=0.225 kz=3.25(quarter) k=13 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a1.500_*_v0.1000_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=1.5 V0=0.1 EPS=0.225 kz=3.25(quarter) k=13 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_19_a6.0_v0.1_eps0.1_kz5.75.ini <<'EOINI'
k_mode = 23
alpha_YM = 6.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 22
eps_override = 0.1
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
nx_override = 1152
target_tu = 65.0
run_tag = epsscanv2
EOINI
echo "[t126] a=6.0 V0=0.1 EPS=0.1 kz=5.75(quarter) k=23 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_19_a6.0_v0.1_eps0.1_kz5.75.ini >> $LOG 2>&1) || echo "[t126] a=6.0 V0=0.1 EPS=0.1 kz=5.75(quarter) k=23 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k23_a6.000_*_v0.1000_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=6.0 V0=0.1 EPS=0.1 kz=5.75(quarter) k=23 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_20_a6.0_v0.1_eps0.1_kz6.25.ini <<'EOINI'
k_mode = 25
alpha_YM = 6.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_cut = 5.0
xi_sponge = 0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 24
eps_override = 0.1
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
nx_override = 1152
target_tu = 65.0
run_tag = epsscanv2
EOINI
echo "[t126] a=6.0 V0=0.1 EPS=0.1 kz=6.25(quarter) k=25 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_20_a6.0_v0.1_eps0.1_kz6.25.ini >> $LOG 2>&1) || echo "[t126] a=6.0 V0=0.1 EPS=0.1 kz=6.25(quarter) k=25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k25_a6.000_*_v0.1000_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=6.0 V0=0.1 EPS=0.1 kz=6.25(quarter) k=25 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_21_a0.5_v0.03_eps0.45_kz3.0.ini <<'EOINI'
k_mode = 3
alpha_YM = 0.5
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
target_tu = 300.1
run_tag = epsscanv2
EOINI
echo "[t126] a=0.5 V0=0.03 EPS=0.45 kz=3.0(int) k=3 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_21_a0.5_v0.03_eps0.45_kz3.0.ini >> $LOG 2>&1) || echo "[t126] a=0.5 V0=0.03 EPS=0.45 kz=3.0(int) k=3 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a0.500_*_v0.0300_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=0.5 V0=0.03 EPS=0.45 kz=3.0(int) k=3 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_22_a1.5_v0.05_eps0.15_kz3.75.ini <<'EOINI'
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
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
target_tu = 100.0
run_tag = epsscanv2
EOINI
echo "[t126] a=1.5 V0=0.05 EPS=0.15 kz=3.75(quarter) k=15 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_22_a1.5_v0.05_eps0.15_kz3.75.ini >> $LOG 2>&1) || echo "[t126] a=1.5 V0=0.05 EPS=0.15 kz=3.75(quarter) k=15 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k15_a1.500_*_v0.0500_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=1.5 V0=0.05 EPS=0.15 kz=3.75(quarter) k=15 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_23_a3.0_v0.03_eps0.3_kz6.25.ini <<'EOINI'
k_mode = 25
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 22.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 24
eps_override = 0.3
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
run_tag = epsscanv2
EOINI
echo "[t126] a=3.0 V0=0.03 EPS=0.3 kz=6.25(quarter) k=25 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_23_a3.0_v0.03_eps0.3_kz6.25.ini >> $LOG 2>&1) || echo "[t126] a=3.0 V0=0.03 EPS=0.3 kz=6.25(quarter) k=25 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k25_a3.000_*_v0.0300_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=3.0 V0=0.03 EPS=0.3 kz=6.25(quarter) k=25 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_24_a3.0_v0.05_eps0.3_kz4.75.ini <<'EOINI'
k_mode = 19
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 18
eps_override = 0.3
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
run_tag = epsscanv2
EOINI
echo "[t126] a=3.0 V0=0.05 EPS=0.3 kz=4.75(quarter) k=19 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_24_a3.0_v0.05_eps0.3_kz4.75.ini >> $LOG 2>&1) || echo "[t126] a=3.0 V0=0.05 EPS=0.3 kz=4.75(quarter) k=19 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k19_a3.000_*_v0.0500_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=3.0 V0=0.05 EPS=0.3 kz=4.75(quarter) k=19 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_25_a6.0_v0.03_eps0.3_kz7.75.ini <<'EOINI'
k_mode = 31
alpha_YM = 6.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 30
eps_override = 0.3
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
run_tag = epsscanv2
EOINI
echo "[t126] a=6.0 V0=0.03 EPS=0.3 kz=7.75(quarter) k=31 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_25_a6.0_v0.03_eps0.3_kz7.75.ini >> $LOG 2>&1) || echo "[t126] a=6.0 V0=0.03 EPS=0.3 kz=7.75(quarter) k=31 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k31_a6.000_*_v0.0300_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=6.0 V0=0.03 EPS=0.3 kz=7.75(quarter) k=31 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_26_a6.0_v0.03_eps0.45_kz7.75.ini <<'EOINI'
k_mode = 31
alpha_YM = 6.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 14.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 30
eps_override = 0.45
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
run_tag = epsscanv2
EOINI
echo "[t126] a=6.0 V0=0.03 EPS=0.45 kz=7.75(quarter) k=31 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_26_a6.0_v0.03_eps0.45_kz7.75.ini >> $LOG 2>&1) || echo "[t126] a=6.0 V0=0.03 EPS=0.45 kz=7.75(quarter) k=31 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k31_a6.000_*_v0.0300_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=6.0 V0=0.03 EPS=0.45 kz=7.75(quarter) k=31 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_27_a0.5_v0.03_eps0.45_kz2.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 0.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.45
kz_suppress_hi = 28
lz_override = 12.566371
nz_override = 128
nx_override = 1536
lx_override = 37.699112
target_tu = 245.1
run_tag = epsscanv2
EOINI
echo "[t126] a=0.5 V0=0.03 EPS=0.45 kz=2.0(half) k=4 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_27_a0.5_v0.03_eps0.45_kz2.0.ini >> $LOG 2>&1) || echo "[t126] a=0.5 V0=0.03 EPS=0.45 kz=2.0(half) k=4 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a0.500_*_v0.0300_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=0.5 V0=0.03 EPS=0.45 kz=2.0(half) k=4 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_28_a0.5_v0.05_eps0.1_kz2.75.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.5
V0 = 0.05
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
target_tu = 222.6
run_tag = epsscanv2
EOINI
echo "[t126] a=0.5 V0=0.05 EPS=0.1 kz=2.75(quarter) k=11 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_28_a0.5_v0.05_eps0.1_kz2.75.ini >> $LOG 2>&1) || echo "[t126] a=0.5 V0=0.05 EPS=0.1 kz=2.75(quarter) k=11 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a0.500_*_v0.0500_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=0.5 V0=0.05 EPS=0.1 kz=2.75(quarter) k=11 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_29_a0.5_v0.05_eps0.15_kz2.75.ini <<'EOINI'
k_mode = 11
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
target_tu = 222.6
run_tag = epsscanv2
EOINI
echo "[t126] a=0.5 V0=0.05 EPS=0.15 kz=2.75(quarter) k=11 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_29_a0.5_v0.05_eps0.15_kz2.75.ini >> $LOG 2>&1) || echo "[t126] a=0.5 V0=0.05 EPS=0.15 kz=2.75(quarter) k=11 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k11_a0.500_*_v0.0500_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=0.5 V0=0.05 EPS=0.15 kz=2.75(quarter) k=11 done $(date)" >> $LOG

cat > /tmp/epsv2_t126_30_a0.5_v0.03_eps0.1_kz3.25.ini <<'EOINI'
k_mode = 13
alpha_YM = 0.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 12
eps_override = 0.1
kz_suppress_hi = 56
lz_override = 25.132741
nz_override = 256
nx_override = 1152
target_tu = 312.3
run_tag = epsscanv2
EOINI
echo "[t126] a=0.5 V0=0.03 EPS=0.1 kz=3.25(quarter) k=13 start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsv2_t126_30_a0.5_v0.03_eps0.1_kz3.25.ini >> $LOG 2>&1) || echo "[t126] a=0.5 V0=0.03 EPS=0.1 kz=3.25(quarter) k=13 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k13_a0.500_*_v0.0300_*_epsscanv2" >> $LOG 2>&1)
echo "[t126] a=0.5 V0=0.03 EPS=0.1 kz=3.25(quarter) k=13 done $(date)" >> $LOG

echo "=== t126 ALL DONE $(date) ===" >> $LOG
