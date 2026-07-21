#!/bin/bash
# T1.1 EPS-scan campaign -- t140: 60 runs (staged 2026-07-18)
# Launch: nohup bash scripts/epsscan_t140.sh > logs/epsscan_t140.log 2>&1 &
WDIR=/DATA/cm/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs
LOG=$WDIR/logs/epsscan_t140_progress.log
echo "=== epsscan start $(date) ===" >> $LOG
# ---- smoke test: binary + fixed extractor + EPS/nx tagging all work ----
cat > /tmp/epsscan_smoke_t140.ini <<'EOINI'
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
run_tag = smoket140
EOINI
rm -rf $WDIR/outputs/ym_k2_a1.000*smoket140*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_smoke_t140.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000*smoket140" >> $LOG 2>&1)
python3 - "$WDIR" t140 <<'EOPY' >> $LOG 2>&1 || { echo "[t140] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, math, sys
w, stream = sys.argv[1], sys.argv[2]
dirs = glob.glob(w + "/outputs/ym_k2_a1.000*smoke" + stream + "*")
assert dirs, "smoke: no output dir written"
assert any("_nx1152" in d for d in dirs), "smoke: nx_override not tagged in dir name (main_ym.cu fix missing)"
fs = glob.glob(w + "/outputs/ym_k2_a1.000*smoke" + stream + "*/timeseries_k2.csv")
assert fs, "smoke: no timeseries written"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert rows and 'amp_conj' in rows[0], "smoke: extractor is not the fixed version"
a0 = float(rows[0]['amp'])
assert a0 > 0 and math.log(a0) > -20, "smoke: seed missing from measured channel (logamp=%.1f)" % (math.log(a0) if a0 > 0 else -99)
print("[%s] smoke test OK (nx_override tagging + narrow-EPS cosh fix + extractor): logamp0=%.1f" % (stream, math.log(a0)))
EOPY
rm -rf $WDIR/outputs/ym_k2_a1.000*smoket140*

cat > /tmp/epsscan_t140_a1.0_eps0.1_kz3.0.ini <<EOINI
k_mode = 3
alpha_YM = 1.0
V0 = 0.05
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
target_tu = 116.3
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz3_a1.00_V0.050_EPS0.100_sp8.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.0 EPS=0.1 kz=3.0 (sp=8.0 tu=116.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.0_eps0.1_kz3.0.ini >> $LOG 2>&1) || echo "[t140] a=1.0 EPS=0.1 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.0 EPS=0.1 kz=3.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.0_eps0.1_kz4.0.ini <<EOINI
k_mode = 4
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.1
kz_suppress_hi = 14
nx_override = 1152
target_tu = 134.2
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz4_a1.00_V0.050_EPS0.100_sp8.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.0 EPS=0.1 kz=4.0 (sp=8.0 tu=134.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.0_eps0.1_kz4.0.ini >> $LOG 2>&1) || echo "[t140] a=1.0 EPS=0.1 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a1.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.0 EPS=0.1 kz=4.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.0_eps0.1_kz5.0.ini <<EOINI
k_mode = 5
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.1
kz_suppress_hi = 14
nx_override = 1152
target_tu = 150.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz5_a1.00_V0.050_EPS0.100_sp8.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.0 EPS=0.1 kz=5.0 (sp=8.0 tu=150.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.0_eps0.1_kz5.0.ini >> $LOG 2>&1) || echo "[t140] a=1.0 EPS=0.1 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.0 EPS=0.1 kz=5.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.0_eps0.1_kz6.0.ini <<EOINI
k_mode = 6
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.1
kz_suppress_hi = 14
nx_override = 1152
target_tu = 164.3
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz6_a1.00_V0.050_EPS0.100_sp8.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.0 EPS=0.1 kz=6.0 (sp=8.0 tu=164.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.0_eps0.1_kz6.0.ini >> $LOG 2>&1) || echo "[t140] a=1.0 EPS=0.1 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.0 EPS=0.1 kz=6.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.0_eps0.1_kz7.0.ini <<EOINI
k_mode = 7
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.1
kz_suppress_hi = 14
nx_override = 1152
target_tu = 177.5
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz7_a1.00_V0.050_EPS0.100_sp8.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.0 EPS=0.1 kz=7.0 (sp=8.0 tu=177.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.0_eps0.1_kz7.0.ini >> $LOG 2>&1) || echo "[t140] a=1.0 EPS=0.1 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.0 EPS=0.1 kz=7.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.0_eps0.1_kz8.0.ini <<EOINI
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
eps_override = 0.1
kz_suppress_hi = 14
nx_override = 1152
target_tu = 189.7
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz8_a1.00_V0.050_EPS0.100_sp8.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.0 EPS=0.1 kz=8.0 (sp=8.0 tu=189.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.0_eps0.1_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=1.0 EPS=0.1 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.0 EPS=0.1 kz=8.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.0_eps0.15_kz1.0.ini <<EOINI
k_mode = 1
alpha_YM = 1.0
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
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz1_a1.00_V0.050_sp8.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.0 EPS=0.15 kz=1.0 (sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.0_eps0.15_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=1.0 EPS=0.15 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.0 EPS=0.15 kz=1.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.0_eps0.15_kz2.0.ini <<EOINI
k_mode = 2
alpha_YM = 1.0
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
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz2_a1.00_V0.050_sp8.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.0 EPS=0.15 kz=2.0 (sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.0_eps0.15_kz2.0.ini >> $LOG 2>&1) || echo "[t140] a=1.0 EPS=0.15 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.0 EPS=0.15 kz=2.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.0_eps0.15_kz7.0.ini <<EOINI
k_mode = 7
alpha_YM = 1.0
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
target_tu = 177.5
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz7_a1.00_V0.050_sp8.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.0 EPS=0.15 kz=7.0 (sp=8.0 tu=177.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.0_eps0.15_kz7.0.ini >> $LOG 2>&1) || echo "[t140] a=1.0 EPS=0.15 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.0 EPS=0.15 kz=7.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.0_eps0.225_kz5.0.ini <<EOINI
k_mode = 5
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.225
kz_suppress_hi = 14
target_tu = 150.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz5_a1.00_V0.050_EPS0.225_sp8.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.0 EPS=0.225 kz=5.0 (sp=8.0 tu=150.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.0_eps0.225_kz5.0.ini >> $LOG 2>&1) || echo "[t140] a=1.0 EPS=0.225 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.0 EPS=0.225 kz=5.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.0_eps0.225_kz6.0.ini <<EOINI
k_mode = 6
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.225
kz_suppress_hi = 14
target_tu = 164.3
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz6_a1.00_V0.050_EPS0.225_sp8.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.0 EPS=0.225 kz=6.0 (sp=8.0 tu=164.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.0_eps0.225_kz6.0.ini >> $LOG 2>&1) || echo "[t140] a=1.0 EPS=0.225 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.0 EPS=0.225 kz=6.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.0_eps0.3_kz1.0.ini <<EOINI
k_mode = 1
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.3
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz1_a1.00_V0.050_EPS0.300_sp8.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.0 EPS=0.3 kz=1.0 (sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.0_eps0.3_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=1.0 EPS=0.3 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.0 EPS=0.3 kz=1.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.0_eps0.3_kz3.0.ini <<EOINI
k_mode = 3
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.3
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 116.3
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz3_a1.00_V0.050_EPS0.300_sp8.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.0 EPS=0.3 kz=3.0 (sp=8.0 tu=116.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.0_eps0.3_kz3.0.ini >> $LOG 2>&1) || echo "[t140] a=1.0 EPS=0.3 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.0 EPS=0.3 kz=3.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.0_eps0.3_kz4.0.ini <<EOINI
k_mode = 4
alpha_YM = 1.0
V0 = 0.05
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
target_tu = 134.2
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz4_a1.00_V0.050_EPS0.300_sp8.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.0 EPS=0.3 kz=4.0 (sp=8.0 tu=134.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.0_eps0.3_kz4.0.ini >> $LOG 2>&1) || echo "[t140] a=1.0 EPS=0.3 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a1.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.0 EPS=0.3 kz=4.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.0_eps0.3_kz6.0.ini <<EOINI
k_mode = 6
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.3
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 164.3
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz6_a1.00_V0.050_EPS0.300_sp8.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.0 EPS=0.3 kz=6.0 (sp=8.0 tu=164.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.0_eps0.3_kz6.0.ini >> $LOG 2>&1) || echo "[t140] a=1.0 EPS=0.3 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.0 EPS=0.3 kz=6.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.0_eps0.3_kz7.0.ini <<EOINI
k_mode = 7
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 6
eps_override = 0.3
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 177.5
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz7_a1.00_V0.050_EPS0.300_sp8.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.0 EPS=0.3 kz=7.0 (sp=8.0 tu=177.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.0_eps0.3_kz7.0.ini >> $LOG 2>&1) || echo "[t140] a=1.0 EPS=0.3 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.0 EPS=0.3 kz=7.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.0_eps0.3_kz8.0.ini <<EOINI
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
eps_override = 0.3
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 189.7
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz8_a1.00_V0.050_EPS0.300_sp8.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.0 EPS=0.3 kz=8.0 (sp=8.0 tu=189.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.0_eps0.3_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=1.0 EPS=0.3 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.0 EPS=0.3 kz=8.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.0_eps0.45_kz1.0.ini <<EOINI
k_mode = 1
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 10.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.45
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz1_a1.00_V0.050_EPS0.450_sp10.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.0 EPS=0.45 kz=1.0 (sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.0_eps0.45_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=1.0 EPS=0.45 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.0 EPS=0.45 kz=1.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.0_eps0.45_kz2.0.ini <<EOINI
k_mode = 2
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 13.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.45
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz2_a1.00_V0.050_EPS0.450_sp13.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.0 EPS=0.45 kz=2.0 (sp=13.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.0_eps0.45_kz2.0.ini >> $LOG 2>&1) || echo "[t140] a=1.0 EPS=0.45 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.0 EPS=0.45 kz=2.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.5_eps0.1_kz1.0.ini <<EOINI
k_mode = 1
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.1
kz_suppress_hi = 14
nx_override = 1152
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz1_a1.50_V0.050_EPS0.100_sp7.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.5 EPS=0.1 kz=1.0 (sp=7.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.5_eps0.1_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 EPS=0.1 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.500_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.5 EPS=0.1 kz=1.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.5_eps0.1_kz3.0.ini <<EOINI
k_mode = 3
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.1
kz_suppress_hi = 14
nx_override = 1152
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz3_a1.50_V0.050_EPS0.100_sp7.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.5 EPS=0.1 kz=3.0 (sp=7.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.5_eps0.1_kz3.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 EPS=0.1 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.500_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.5 EPS=0.1 kz=3.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.5_eps0.1_kz6.0.ini <<EOINI
k_mode = 6
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.1
kz_suppress_hi = 14
nx_override = 1152
target_tu = 109.6
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz6_a1.50_V0.050_EPS0.100_sp7.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.5 EPS=0.1 kz=6.0 (sp=7.0 tu=109.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.5_eps0.1_kz6.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 EPS=0.1 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.500_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.5 EPS=0.1 kz=6.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.5_eps0.1_kz7.0.ini <<EOINI
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
eps_override = 0.1
kz_suppress_hi = 14
nx_override = 1152
target_tu = 118.3
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz7_a1.50_V0.050_EPS0.100_sp7.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.5 EPS=0.1 kz=7.0 (sp=7.0 tu=118.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.5_eps0.1_kz7.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 EPS=0.1 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.500_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.5 EPS=0.1 kz=7.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.5_eps0.15_kz2.0.ini <<EOINI
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
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz2_a1.50_V0.050_sp10.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.5 EPS=0.15 kz=2.0 (sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.5_eps0.15_kz2.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 EPS=0.15 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.500_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.5 EPS=0.15 kz=2.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.5_eps0.15_kz4.0.ini <<EOINI
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
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz4_a1.50_V0.050_sp7.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.5 EPS=0.15 kz=4.0 (sp=7.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.5_eps0.15_kz4.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 EPS=0.15 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a1.500_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.5 EPS=0.15 kz=4.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.5_eps0.15_kz5.0.ini <<EOINI
k_mode = 5
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz5_a1.50_V0.050_sp7.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.5 EPS=0.15 kz=5.0 (sp=7.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.5_eps0.15_kz5.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 EPS=0.15 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.500_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.5 EPS=0.15 kz=5.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.5_eps0.15_kz6.0.ini <<EOINI
k_mode = 6
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.15
kz_suppress_hi = 14
target_tu = 109.6
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz6_a1.50_V0.050_sp7.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.5 EPS=0.15 kz=6.0 (sp=7.0 tu=109.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.5_eps0.15_kz6.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 EPS=0.15 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.500_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.5 EPS=0.15 kz=6.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.5_eps0.15_kz7.0.ini <<EOINI
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
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz7_a1.50_V0.050_sp7.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.5 EPS=0.15 kz=7.0 (sp=7.0 tu=118.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.5_eps0.15_kz7.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 EPS=0.15 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.500_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.5 EPS=0.15 kz=7.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.5_eps0.225_kz1.0.ini <<EOINI
k_mode = 1
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.225
kz_suppress_hi = 14
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz1_a1.50_V0.050_EPS0.225_sp7.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.5 EPS=0.225 kz=1.0 (sp=7.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.5_eps0.225_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 EPS=0.225 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.500_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.5 EPS=0.225 kz=1.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.5_eps0.225_kz3.0.ini <<EOINI
k_mode = 3
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.225
kz_suppress_hi = 14
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz3_a1.50_V0.050_EPS0.225_sp7.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.5 EPS=0.225 kz=3.0 (sp=7.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.5_eps0.225_kz3.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 EPS=0.225 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.500_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.5 EPS=0.225 kz=3.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.5_eps0.225_kz7.0.ini <<EOINI
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
eps_override = 0.225
kz_suppress_hi = 14
target_tu = 118.3
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz7_a1.50_V0.050_EPS0.225_sp7.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.5 EPS=0.225 kz=7.0 (sp=7.0 tu=118.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.5_eps0.225_kz7.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 EPS=0.225 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a1.500_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.5 EPS=0.225 kz=7.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.5_eps0.225_kz8.0.ini <<EOINI
k_mode = 8
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.225
kz_suppress_hi = 14
target_tu = 126.5
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz8_a1.50_V0.050_EPS0.225_sp7.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.5 EPS=0.225 kz=8.0 (sp=7.0 tu=126.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.5_eps0.225_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 EPS=0.225 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.500_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.5 EPS=0.225 kz=8.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.5_eps0.3_kz2.0.ini <<EOINI
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
eps_override = 0.3
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz2_a1.50_V0.050_EPS0.300_sp10.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.5 EPS=0.3 kz=2.0 (sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.5_eps0.3_kz2.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 EPS=0.3 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.500_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.5 EPS=0.3 kz=2.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.5_eps0.3_kz4.0.ini <<EOINI
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
eps_override = 0.3
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz4_a1.50_V0.050_EPS0.300_sp7.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.5 EPS=0.3 kz=4.0 (sp=7.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.5_eps0.3_kz4.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 EPS=0.3 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a1.500_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.5 EPS=0.3 kz=4.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.5_eps0.3_kz6.0.ini <<EOINI
k_mode = 6
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.3
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 109.6
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz6_a1.50_V0.050_EPS0.300_sp7.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.5 EPS=0.3 kz=6.0 (sp=7.0 tu=109.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.5_eps0.3_kz6.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 EPS=0.3 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a1.500_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.5 EPS=0.3 kz=6.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.5_eps0.3_kz8.0.ini <<EOINI
k_mode = 8
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.3
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 126.5
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz8_a1.50_V0.050_EPS0.300_sp7.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.5 EPS=0.3 kz=8.0 (sp=7.0 tu=126.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.5_eps0.3_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 EPS=0.3 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.500_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.5 EPS=0.3 kz=8.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.5_eps0.45_kz1.0.ini <<EOINI
k_mode = 1
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.45
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz1_a1.50_V0.050_EPS0.450_sp7.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.5 EPS=0.45 kz=1.0 (sp=7.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.5_eps0.45_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 EPS=0.45 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a1.500_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.5 EPS=0.45 kz=1.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.5_eps0.45_kz3.0.ini <<EOINI
k_mode = 3
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 2
eps_override = 0.45
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz3_a1.50_V0.050_EPS0.450_sp7.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.5 EPS=0.45 kz=3.0 (sp=7.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.5_eps0.45_kz3.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 EPS=0.45 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a1.500_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.5 EPS=0.45 kz=3.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.5_eps0.45_kz5.0.ini <<EOINI
k_mode = 5
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.45
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz5_a1.50_V0.050_EPS0.450_sp7.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.5 EPS=0.45 kz=5.0 (sp=7.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.5_eps0.45_kz5.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 EPS=0.45 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a1.500_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.5 EPS=0.45 kz=5.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a1.5_eps0.45_kz8.0.ini <<EOINI
k_mode = 8
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.45
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 126.5
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz8_a1.50_V0.050_EPS0.450_sp7.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=1.5 EPS=0.45 kz=8.0 (sp=7.0 tu=126.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a1.5_eps0.45_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=1.5 EPS=0.45 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a1.500_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=1.5 EPS=0.45 kz=8.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a2.0_eps0.1_kz2.0.ini <<EOINI
k_mode = 2
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.1
kz_suppress_hi = 14
nx_override = 1152
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz2_a2.00_V0.050_EPS0.100_sp8.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=2.0 EPS=0.1 kz=2.0 (sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a2.0_eps0.1_kz2.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 EPS=0.1 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=2.0 EPS=0.1 kz=2.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a2.0_eps0.1_kz4.0.ini <<EOINI
k_mode = 4
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.1
kz_suppress_hi = 14
nx_override = 1152
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz4_a2.00_V0.050_EPS0.100_sp8.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=2.0 EPS=0.1 kz=4.0 (sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a2.0_eps0.1_kz4.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 EPS=0.1 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=2.0 EPS=0.1 kz=4.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a2.0_eps0.1_kz6.0.ini <<EOINI
k_mode = 6
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.1
kz_suppress_hi = 14
nx_override = 1152
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz6_a2.00_V0.050_EPS0.100_sp8.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=2.0 EPS=0.1 kz=6.0 (sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a2.0_eps0.1_kz6.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 EPS=0.1 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=2.0 EPS=0.1 kz=6.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a2.0_eps0.1_kz8.0.ini <<EOINI
k_mode = 8
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.1
kz_suppress_hi = 14
nx_override = 1152
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz8_a2.00_V0.050_EPS0.100_sp8.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=2.0 EPS=0.1 kz=8.0 (sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a2.0_eps0.1_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 EPS=0.1 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a2.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=2.0 EPS=0.1 kz=8.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a2.0_eps0.15_kz1.0.ini <<EOINI
k_mode = 1
alpha_YM = 2.0
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
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz1_a2.00_V0.050_sp5.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=2.0 EPS=0.15 kz=1.0 (sp=5.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a2.0_eps0.15_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 EPS=0.15 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=2.0 EPS=0.15 kz=1.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a2.0_eps0.15_kz3.0.ini <<EOINI
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
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz3_a2.00_V0.050_sp10.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=2.0 EPS=0.15 kz=3.0 (sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a2.0_eps0.15_kz3.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 EPS=0.15 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=2.0 EPS=0.15 kz=3.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a2.0_eps0.15_kz5.0.ini <<EOINI
k_mode = 5
alpha_YM = 2.0
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
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz5_a2.00_V0.050_sp8.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=2.0 EPS=0.15 kz=5.0 (sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a2.0_eps0.15_kz5.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 EPS=0.15 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=2.0 EPS=0.15 kz=5.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a2.0_eps0.15_kz7.0.ini <<EOINI
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
kz_suppress_hi = 14
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz7_a2.00_V0.050_sp8.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=2.0 EPS=0.15 kz=7.0 (sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a2.0_eps0.15_kz7.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 EPS=0.15 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=2.0 EPS=0.15 kz=7.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a2.0_eps0.225_kz2.0.ini <<EOINI
k_mode = 2
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 1
eps_override = 0.225
kz_suppress_hi = 14
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz2_a2.00_V0.050_EPS0.225_sp8.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=2.0 EPS=0.225 kz=2.0 (sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a2.0_eps0.225_kz2.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 EPS=0.225 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=2.0 EPS=0.225 kz=2.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a2.0_eps0.225_kz4.0.ini <<EOINI
k_mode = 4
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.225
kz_suppress_hi = 14
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz4_a2.00_V0.050_EPS0.225_sp8.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=2.0 EPS=0.225 kz=4.0 (sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a2.0_eps0.225_kz4.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 EPS=0.225 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=2.0 EPS=0.225 kz=4.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a2.0_eps0.225_kz6.0.ini <<EOINI
k_mode = 6
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.225
kz_suppress_hi = 14
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz6_a2.00_V0.050_EPS0.225_sp8.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=2.0 EPS=0.225 kz=6.0 (sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a2.0_eps0.225_kz6.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 EPS=0.225 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=2.0 EPS=0.225 kz=6.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a2.0_eps0.225_kz8.0.ini <<EOINI
k_mode = 8
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.225
kz_suppress_hi = 14
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz8_a2.00_V0.050_EPS0.225_sp8.0.bin
run_tag = epsscan
EOINI
echo "[t140] a=2.0 EPS=0.225 kz=8.0 (sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a2.0_eps0.225_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 EPS=0.225 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a2.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=2.0 EPS=0.225 kz=8.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a2.0_eps0.3_kz1.0.ini <<EOINI
k_mode = 1
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 5.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.3
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz1_a2.00_V0.050_EPS0.300_sp5.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=2.0 EPS=0.3 kz=1.0 (sp=5.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a2.0_eps0.3_kz1.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 EPS=0.3 kz=1.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=2.0 EPS=0.3 kz=1.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a2.0_eps0.3_kz3.0.ini <<EOINI
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
eps_override = 0.3
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz3_a2.00_V0.050_EPS0.300_sp10.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=2.0 EPS=0.3 kz=3.0 (sp=10.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a2.0_eps0.3_kz3.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 EPS=0.3 kz=3.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=2.0 EPS=0.3 kz=3.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a2.0_eps0.3_kz5.0.ini <<EOINI
k_mode = 5
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 4
eps_override = 0.3
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz5_a2.00_V0.050_EPS0.300_sp8.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=2.0 EPS=0.3 kz=5.0 (sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a2.0_eps0.3_kz5.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 EPS=0.3 kz=5.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=2.0 EPS=0.3 kz=5.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a2.0_eps0.3_kz7.0.ini <<EOINI
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
eps_override = 0.3
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz7_a2.00_V0.050_EPS0.300_sp8.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=2.0 EPS=0.3 kz=7.0 (sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a2.0_eps0.3_kz7.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 EPS=0.3 kz=7.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=2.0 EPS=0.3 kz=7.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a2.0_eps0.45_kz2.0.ini <<EOINI
k_mode = 2
alpha_YM = 2.0
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
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz2_a2.00_V0.050_EPS0.450_sp8.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=2.0 EPS=0.45 kz=2.0 (sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a2.0_eps0.45_kz2.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 EPS=0.45 kz=2.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=2.0 EPS=0.45 kz=2.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a2.0_eps0.45_kz4.0.ini <<EOINI
k_mode = 4
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 3
eps_override = 0.45
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz4_a2.00_V0.050_EPS0.450_sp8.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=2.0 EPS=0.45 kz=4.0 (sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a2.0_eps0.45_kz4.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 EPS=0.45 kz=4.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=2.0 EPS=0.45 kz=4.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a2.0_eps0.45_kz6.0.ini <<EOINI
k_mode = 6
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 5
eps_override = 0.45
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz6_a2.00_V0.050_EPS0.450_sp8.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=2.0 EPS=0.45 kz=6.0 (sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a2.0_eps0.45_kz6.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 EPS=0.45 kz=6.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=2.0 EPS=0.45 kz=6.0 done $(date)" >> $LOG

cat > /tmp/epsscan_t140_a2.0_eps0.45_kz8.0.ini <<EOINI
k_mode = 8
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 7
eps_override = 0.45
kz_suppress_hi = 14
nx_override = 1536
lx_override = 37.699112
target_tu = 100.0
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz8_a2.00_V0.050_EPS0.450_sp8.0_lx37.6991.bin
run_tag = epsscan
EOINI
echo "[t140] a=2.0 EPS=0.45 kz=8.0 (sp=8.0 tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_t140_a2.0_eps0.45_kz8.0.ini >> $LOG 2>&1) || echo "[t140] a=2.0 EPS=0.45 kz=8.0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a2.000_*_v0.0500_*_epsscan" >> $LOG 2>&1)
echo "[t140] a=2.0 EPS=0.45 kz=8.0 done $(date)" >> $LOG

echo "=== t140 ALL DONE $(date) ===" >> $LOG
