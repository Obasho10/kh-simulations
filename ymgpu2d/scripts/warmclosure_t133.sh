#!/bin/bash
# T1.4 warm-closure filters-off campaign -- t133: 32 runs (staged 2026-07-18)
# Launch: nohup bash scripts/warmclosure_t133.sh > logs/warmclosure_t133.log 2>&1 &
WDIR=/DATA/ym_kh/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs
LOG=$WDIR/logs/warmclosure_t133_progress.log
echo "=== warmclosure start $(date) ===" >> $LOG
# ---- smoke test: binary + filters-off path + warm_T pressure term all work ----
cat > /tmp/warmcl_smoke_t133.ini <<EOINI
k_mode = 2
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.015625
target_tu = 2
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz2_a2.00_V0.050_sp11.0.bin
run_tag = smoket133
EOINI
rm -rf $WDIR/outputs/ym_k2_a2.000*smoket133*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_smoke_t133.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.000*smoket133" >> $LOG 2>&1)
python3 - "$WDIR" t133 <<'EOPY' >> $LOG 2>&1 || { echo "[t133] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, math, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k2_a2.000*smoke" + stream + "*/timeseries_k2.csv")
assert fs, "smoke: no timeseries written (warm_T path or seed load likely broken)"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert rows and 'amp_conj' in rows[0], "smoke: extractor is not the fixed version"
a0 = float(rows[0]['amp'])
assert a0 > 0 and math.log(a0) > -20, "smoke: seed missing from measured channel (logamp=%.1f)" % (math.log(a0) if a0 > 0 else -99)
print("[%s] smoke test OK (filters-off + warm_T path): logamp0=%.1f" % (stream, math.log(a0)))
EOPY
rm -rf $WDIR/outputs/ym_k2_a2.000*smoket133*

cat > /tmp/warmcl_t133_kz1_cold.ini <<EOINI
k_mode = 1
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.0
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz1_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_cold
EOINI
echo "[t133] kz=1 warm_T=0.0 (cold) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz1_cold.ini >> $LOG 2>&1) || echo "[t133] kz=1 warm_T=0.0 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.000_*_warmcl_cold" >> $LOG 2>&1)
echo "[t133] kz=1 warm_T=0.0 (cold) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz1_wt2p0.ini <<EOINI
k_mode = 1
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.01
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz1_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt2p0
EOINI
echo "[t133] kz=1 warm_T=0.01 (wt2p0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz1_wt2p0.ini >> $LOG 2>&1) || echo "[t133] kz=1 warm_T=0.01 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.000_*_warmcl_wt2p0" >> $LOG 2>&1)
echo "[t133] kz=1 warm_T=0.01 (wt2p0) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz1_wt2p5.ini <<EOINI
k_mode = 1
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.015625
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz1_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt2p5
EOINI
echo "[t133] kz=1 warm_T=0.015625 (wt2p5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz1_wt2p5.ini >> $LOG 2>&1) || echo "[t133] kz=1 warm_T=0.015625 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.000_*_warmcl_wt2p5" >> $LOG 2>&1)
echo "[t133] kz=1 warm_T=0.015625 (wt2p5) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz1_wt3p0.ini <<EOINI
k_mode = 1
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.0225
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz1_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt3p0
EOINI
echo "[t133] kz=1 warm_T=0.0225 (wt3p0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz1_wt3p0.ini >> $LOG 2>&1) || echo "[t133] kz=1 warm_T=0.0225 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k1_a2.000_*_warmcl_wt3p0" >> $LOG 2>&1)
echo "[t133] kz=1 warm_T=0.0225 (wt3p0) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz2_cold.ini <<EOINI
k_mode = 2
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.0
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz2_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_cold
EOINI
echo "[t133] kz=2 warm_T=0.0 (cold) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz2_cold.ini >> $LOG 2>&1) || echo "[t133] kz=2 warm_T=0.0 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.000_*_warmcl_cold" >> $LOG 2>&1)
echo "[t133] kz=2 warm_T=0.0 (cold) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz2_wt2p0.ini <<EOINI
k_mode = 2
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.01
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz2_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt2p0
EOINI
echo "[t133] kz=2 warm_T=0.01 (wt2p0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz2_wt2p0.ini >> $LOG 2>&1) || echo "[t133] kz=2 warm_T=0.01 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.000_*_warmcl_wt2p0" >> $LOG 2>&1)
echo "[t133] kz=2 warm_T=0.01 (wt2p0) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz2_wt2p5.ini <<EOINI
k_mode = 2
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.015625
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz2_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt2p5
EOINI
echo "[t133] kz=2 warm_T=0.015625 (wt2p5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz2_wt2p5.ini >> $LOG 2>&1) || echo "[t133] kz=2 warm_T=0.015625 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.000_*_warmcl_wt2p5" >> $LOG 2>&1)
echo "[t133] kz=2 warm_T=0.015625 (wt2p5) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz2_wt3p0.ini <<EOINI
k_mode = 2
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.0225
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz2_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt3p0
EOINI
echo "[t133] kz=2 warm_T=0.0225 (wt3p0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz2_wt3p0.ini >> $LOG 2>&1) || echo "[t133] kz=2 warm_T=0.0225 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.000_*_warmcl_wt3p0" >> $LOG 2>&1)
echo "[t133] kz=2 warm_T=0.0225 (wt3p0) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz3_cold.ini <<EOINI
k_mode = 3
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.0
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz3_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_cold
EOINI
echo "[t133] kz=3 warm_T=0.0 (cold) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz3_cold.ini >> $LOG 2>&1) || echo "[t133] kz=3 warm_T=0.0 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.000_*_warmcl_cold" >> $LOG 2>&1)
echo "[t133] kz=3 warm_T=0.0 (cold) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz3_wt2p0.ini <<EOINI
k_mode = 3
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.01
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz3_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt2p0
EOINI
echo "[t133] kz=3 warm_T=0.01 (wt2p0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz3_wt2p0.ini >> $LOG 2>&1) || echo "[t133] kz=3 warm_T=0.01 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.000_*_warmcl_wt2p0" >> $LOG 2>&1)
echo "[t133] kz=3 warm_T=0.01 (wt2p0) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz3_wt2p5.ini <<EOINI
k_mode = 3
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.015625
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz3_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt2p5
EOINI
echo "[t133] kz=3 warm_T=0.015625 (wt2p5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz3_wt2p5.ini >> $LOG 2>&1) || echo "[t133] kz=3 warm_T=0.015625 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.000_*_warmcl_wt2p5" >> $LOG 2>&1)
echo "[t133] kz=3 warm_T=0.015625 (wt2p5) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz3_wt3p0.ini <<EOINI
k_mode = 3
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.0225
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz3_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt3p0
EOINI
echo "[t133] kz=3 warm_T=0.0225 (wt3p0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz3_wt3p0.ini >> $LOG 2>&1) || echo "[t133] kz=3 warm_T=0.0225 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k3_a2.000_*_warmcl_wt3p0" >> $LOG 2>&1)
echo "[t133] kz=3 warm_T=0.0225 (wt3p0) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz4_cold.ini <<EOINI
k_mode = 4
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.0
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz4_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_cold
EOINI
echo "[t133] kz=4 warm_T=0.0 (cold) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz4_cold.ini >> $LOG 2>&1) || echo "[t133] kz=4 warm_T=0.0 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.000_*_warmcl_cold" >> $LOG 2>&1)
echo "[t133] kz=4 warm_T=0.0 (cold) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz4_wt2p0.ini <<EOINI
k_mode = 4
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.01
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz4_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt2p0
EOINI
echo "[t133] kz=4 warm_T=0.01 (wt2p0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz4_wt2p0.ini >> $LOG 2>&1) || echo "[t133] kz=4 warm_T=0.01 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.000_*_warmcl_wt2p0" >> $LOG 2>&1)
echo "[t133] kz=4 warm_T=0.01 (wt2p0) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz4_wt2p5.ini <<EOINI
k_mode = 4
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.015625
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz4_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt2p5
EOINI
echo "[t133] kz=4 warm_T=0.015625 (wt2p5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz4_wt2p5.ini >> $LOG 2>&1) || echo "[t133] kz=4 warm_T=0.015625 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.000_*_warmcl_wt2p5" >> $LOG 2>&1)
echo "[t133] kz=4 warm_T=0.015625 (wt2p5) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz4_wt3p0.ini <<EOINI
k_mode = 4
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.0225
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz4_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt3p0
EOINI
echo "[t133] kz=4 warm_T=0.0225 (wt3p0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz4_wt3p0.ini >> $LOG 2>&1) || echo "[t133] kz=4 warm_T=0.0225 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k4_a2.000_*_warmcl_wt3p0" >> $LOG 2>&1)
echo "[t133] kz=4 warm_T=0.0225 (wt3p0) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz5_cold.ini <<EOINI
k_mode = 5
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.0
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz5_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_cold
EOINI
echo "[t133] kz=5 warm_T=0.0 (cold) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz5_cold.ini >> $LOG 2>&1) || echo "[t133] kz=5 warm_T=0.0 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.000_*_warmcl_cold" >> $LOG 2>&1)
echo "[t133] kz=5 warm_T=0.0 (cold) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz5_wt2p0.ini <<EOINI
k_mode = 5
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.01
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz5_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt2p0
EOINI
echo "[t133] kz=5 warm_T=0.01 (wt2p0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz5_wt2p0.ini >> $LOG 2>&1) || echo "[t133] kz=5 warm_T=0.01 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.000_*_warmcl_wt2p0" >> $LOG 2>&1)
echo "[t133] kz=5 warm_T=0.01 (wt2p0) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz5_wt2p5.ini <<EOINI
k_mode = 5
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.015625
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz5_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt2p5
EOINI
echo "[t133] kz=5 warm_T=0.015625 (wt2p5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz5_wt2p5.ini >> $LOG 2>&1) || echo "[t133] kz=5 warm_T=0.015625 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.000_*_warmcl_wt2p5" >> $LOG 2>&1)
echo "[t133] kz=5 warm_T=0.015625 (wt2p5) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz5_wt3p0.ini <<EOINI
k_mode = 5
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.0225
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz5_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt3p0
EOINI
echo "[t133] kz=5 warm_T=0.0225 (wt3p0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz5_wt3p0.ini >> $LOG 2>&1) || echo "[t133] kz=5 warm_T=0.0225 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k5_a2.000_*_warmcl_wt3p0" >> $LOG 2>&1)
echo "[t133] kz=5 warm_T=0.0225 (wt3p0) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz6_cold.ini <<EOINI
k_mode = 6
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.0
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz6_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_cold
EOINI
echo "[t133] kz=6 warm_T=0.0 (cold) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz6_cold.ini >> $LOG 2>&1) || echo "[t133] kz=6 warm_T=0.0 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.000_*_warmcl_cold" >> $LOG 2>&1)
echo "[t133] kz=6 warm_T=0.0 (cold) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz6_wt2p0.ini <<EOINI
k_mode = 6
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.01
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz6_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt2p0
EOINI
echo "[t133] kz=6 warm_T=0.01 (wt2p0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz6_wt2p0.ini >> $LOG 2>&1) || echo "[t133] kz=6 warm_T=0.01 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.000_*_warmcl_wt2p0" >> $LOG 2>&1)
echo "[t133] kz=6 warm_T=0.01 (wt2p0) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz6_wt2p5.ini <<EOINI
k_mode = 6
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.015625
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz6_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt2p5
EOINI
echo "[t133] kz=6 warm_T=0.015625 (wt2p5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz6_wt2p5.ini >> $LOG 2>&1) || echo "[t133] kz=6 warm_T=0.015625 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.000_*_warmcl_wt2p5" >> $LOG 2>&1)
echo "[t133] kz=6 warm_T=0.015625 (wt2p5) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz6_wt3p0.ini <<EOINI
k_mode = 6
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.0225
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz6_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt3p0
EOINI
echo "[t133] kz=6 warm_T=0.0225 (wt3p0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz6_wt3p0.ini >> $LOG 2>&1) || echo "[t133] kz=6 warm_T=0.0225 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k6_a2.000_*_warmcl_wt3p0" >> $LOG 2>&1)
echo "[t133] kz=6 warm_T=0.0225 (wt3p0) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz7_cold.ini <<EOINI
k_mode = 7
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.0
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz7_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_cold
EOINI
echo "[t133] kz=7 warm_T=0.0 (cold) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz7_cold.ini >> $LOG 2>&1) || echo "[t133] kz=7 warm_T=0.0 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.000_*_warmcl_cold" >> $LOG 2>&1)
echo "[t133] kz=7 warm_T=0.0 (cold) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz7_wt2p0.ini <<EOINI
k_mode = 7
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.01
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz7_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt2p0
EOINI
echo "[t133] kz=7 warm_T=0.01 (wt2p0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz7_wt2p0.ini >> $LOG 2>&1) || echo "[t133] kz=7 warm_T=0.01 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.000_*_warmcl_wt2p0" >> $LOG 2>&1)
echo "[t133] kz=7 warm_T=0.01 (wt2p0) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz7_wt2p5.ini <<EOINI
k_mode = 7
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.015625
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz7_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt2p5
EOINI
echo "[t133] kz=7 warm_T=0.015625 (wt2p5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz7_wt2p5.ini >> $LOG 2>&1) || echo "[t133] kz=7 warm_T=0.015625 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.000_*_warmcl_wt2p5" >> $LOG 2>&1)
echo "[t133] kz=7 warm_T=0.015625 (wt2p5) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz7_wt3p0.ini <<EOINI
k_mode = 7
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.0225
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz7_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt3p0
EOINI
echo "[t133] kz=7 warm_T=0.0225 (wt3p0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz7_wt3p0.ini >> $LOG 2>&1) || echo "[t133] kz=7 warm_T=0.0225 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k7_a2.000_*_warmcl_wt3p0" >> $LOG 2>&1)
echo "[t133] kz=7 warm_T=0.0225 (wt3p0) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz8_cold.ini <<EOINI
k_mode = 8
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.0
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz8_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_cold
EOINI
echo "[t133] kz=8 warm_T=0.0 (cold) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz8_cold.ini >> $LOG 2>&1) || echo "[t133] kz=8 warm_T=0.0 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a2.000_*_warmcl_cold" >> $LOG 2>&1)
echo "[t133] kz=8 warm_T=0.0 (cold) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz8_wt2p0.ini <<EOINI
k_mode = 8
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.01
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz8_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt2p0
EOINI
echo "[t133] kz=8 warm_T=0.01 (wt2p0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz8_wt2p0.ini >> $LOG 2>&1) || echo "[t133] kz=8 warm_T=0.01 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a2.000_*_warmcl_wt2p0" >> $LOG 2>&1)
echo "[t133] kz=8 warm_T=0.01 (wt2p0) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz8_wt2p5.ini <<EOINI
k_mode = 8
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.015625
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz8_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt2p5
EOINI
echo "[t133] kz=8 warm_T=0.015625 (wt2p5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz8_wt2p5.ini >> $LOG 2>&1) || echo "[t133] kz=8 warm_T=0.015625 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a2.000_*_warmcl_wt2p5" >> $LOG 2>&1)
echo "[t133] kz=8 warm_T=0.015625 (wt2p5) done $(date)" >> $LOG

cat > /tmp/warmcl_t133_kz8_wt3p0.ini <<EOINI
k_mode = 8
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.0225
target_tu = 100
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz8_a2.00_V0.050_sp11.0.bin
run_tag = warmcl_wt3p0
EOINI
echo "[t133] kz=8 warm_T=0.0225 (wt3p0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_t133_kz8_wt3p0.ini >> $LOG 2>&1) || echo "[t133] kz=8 warm_T=0.0225 CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k8_a2.000_*_warmcl_wt3p0" >> $LOG 2>&1)
echo "[t133] kz=8 warm_T=0.0225 (wt3p0) done $(date)" >> $LOG

echo "=== t133 ALL DONE $(date) ===" >> $LOG
