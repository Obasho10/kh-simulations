#!/bin/bash
# kz=0 deviation-mapping v4 -- corner-anomaly + valley-shape follow-up (144 pts, staged 2026-07-19)
WDIR=/DATA/s23103/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs

run_gpu1() {
    export CUDA_VISIBLE_DEVICES=1
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/kz0v4_abi1_progress.log
    echo "=== kz0v4 abi1 start $(date) ===" >> $LOG
# ---- smoke test: NAB_DTANH binary + noise-driven kz=0 extractor ----
cat > /tmp/kz0v4_smoke_abi1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 2e-4
target_tu = 50
run_tag = smokev4abi1
EOINI
rm -rf $WDIR/outputs/ym_k1_a2.000*smokev4abi1*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_smoke_abi1.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000*smokev4abi1" >> $LOG 2>&1)
python3 - "$WDIR" abi1 <<'EOPY' >> $LOG 2>&1 || { echo "[abi1] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k1_a2.000*smokev4" + stream + "*/timeseries_k0.csv")
assert fs, "smoke: no timeseries_k0.csv written"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert len(rows) >= 5, "smoke: too few rows (%d)" % len(rows)
amps = [float(r['amp']) for r in rows]
assert amps[-1] > amps[0], "smoke: kz=0 amplitude did not grow"
print("[%s] smoke test OK (kz0v4): amp0=%.3e ampf=%.3e" % (stream, amps[0], amps[-1]))
EOPY
rm -rf $WDIR/outputs/ym_k1_a2.000*smokev4abi1*

cat > /tmp/kz0v4_abi1_a0.6_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a0p6_v0p03
EOINI
echo "[abi1] a=0.6 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a0.6_v0.03.ini >> $LOG 2>&1) || echo "[abi1] a=0.6 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.600_*_kz0v4_corner_a0p6_v0p03" >> $LOG 2>&1)
echo "[abi1] a=0.6 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a0.6_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.6
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a0p6_v0p04
EOINI
echo "[abi1] a=0.6 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a0.6_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=0.6 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.600_*_kz0v4_corner_a0p6_v0p04" >> $LOG 2>&1)
echo "[abi1] a=0.6 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a0.6_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a0p6_v0p05
EOINI
echo "[abi1] a=0.6 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a0.6_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=0.6 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.600_*_kz0v4_corner_a0p6_v0p05" >> $LOG 2>&1)
echo "[abi1] a=0.6 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a0.7_v0.035.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.7
V0 = 0.035
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a0p7_v0p035
EOINI
echo "[abi1] a=0.7 V0=0.035 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a0.7_v0.035.ini >> $LOG 2>&1) || echo "[abi1] a=0.7 V0=0.035 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.700_*_kz0v4_corner_a0p7_v0p035" >> $LOG 2>&1)
echo "[abi1] a=0.7 V0=0.035 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a0.7_v0.045.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.7
V0 = 0.045
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a0p7_v0p045
EOINI
echo "[abi1] a=0.7 V0=0.045 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a0.7_v0.045.ini >> $LOG 2>&1) || echo "[abi1] a=0.7 V0=0.045 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.700_*_kz0v4_corner_a0p7_v0p045" >> $LOG 2>&1)
echo "[abi1] a=0.7 V0=0.045 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a0.8_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a0p8_v0p03
EOINI
echo "[abi1] a=0.8 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a0.8_v0.03.ini >> $LOG 2>&1) || echo "[abi1] a=0.8 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.800_*_kz0v4_corner_a0p8_v0p03" >> $LOG 2>&1)
echo "[abi1] a=0.8 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a0.8_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a0p8_v0p04
EOINI
echo "[abi1] a=0.8 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a0.8_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=0.8 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.800_*_kz0v4_corner_a0p8_v0p04" >> $LOG 2>&1)
echo "[abi1] a=0.8 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a0.8_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a0p8_v0p05
EOINI
echo "[abi1] a=0.8 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a0.8_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=0.8 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.800_*_kz0v4_corner_a0p8_v0p05" >> $LOG 2>&1)
echo "[abi1] a=0.8 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a0.9_v0.035.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.9
V0 = 0.035
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a0p9_v0p035
EOINI
echo "[abi1] a=0.9 V0=0.035 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a0.9_v0.035.ini >> $LOG 2>&1) || echo "[abi1] a=0.9 V0=0.035 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.900_*_kz0v4_corner_a0p9_v0p035" >> $LOG 2>&1)
echo "[abi1] a=0.9 V0=0.035 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a0.9_v0.045.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.9
V0 = 0.045
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a0p9_v0p045
EOINI
echo "[abi1] a=0.9 V0=0.045 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a0.9_v0.045.ini >> $LOG 2>&1) || echo "[abi1] a=0.9 V0=0.045 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.900_*_kz0v4_corner_a0p9_v0p045" >> $LOG 2>&1)
echo "[abi1] a=0.9 V0=0.045 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a1.0_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a1p0_v0p03
EOINI
echo "[abi1] a=1.0 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a1.0_v0.03.ini >> $LOG 2>&1) || echo "[abi1] a=1.0 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.000_*_kz0v4_corner_a1p0_v0p03" >> $LOG 2>&1)
echo "[abi1] a=1.0 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a1.0_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a1p0_v0p04
EOINI
echo "[abi1] a=1.0 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a1.0_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=1.0 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.000_*_kz0v4_corner_a1p0_v0p04" >> $LOG 2>&1)
echo "[abi1] a=1.0 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a1.0_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a1p0_v0p05
EOINI
echo "[abi1] a=1.0 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a1.0_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=1.0 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.000_*_kz0v4_corner_a1p0_v0p05" >> $LOG 2>&1)
echo "[abi1] a=1.0 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a1.7_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a1p7_v0p05
EOINI
echo "[abi1] a=1.7 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a1.7_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=1.7 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.700_*_kz0v4_valley_a1p7_v0p05" >> $LOG 2>&1)
echo "[abi1] a=1.7 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a1.7_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.7
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a1p7_v0p07
EOINI
echo "[abi1] a=1.7 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a1.7_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=1.7 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.700_*_kz0v4_valley_a1p7_v0p07" >> $LOG 2>&1)
echo "[abi1] a=1.7 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a1.7_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.7
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a1p7_v0p09
EOINI
echo "[abi1] a=1.7 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a1.7_v0.09.ini >> $LOG 2>&1) || echo "[abi1] a=1.7 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.700_*_kz0v4_valley_a1p7_v0p09" >> $LOG 2>&1)
echo "[abi1] a=1.7 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a1.9_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.9
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a1p9_v0p04
EOINI
echo "[abi1] a=1.9 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a1.9_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=1.9 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.900_*_kz0v4_valley_a1p9_v0p04" >> $LOG 2>&1)
echo "[abi1] a=1.9 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a1.9_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.9
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a1p9_v0p06
EOINI
echo "[abi1] a=1.9 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a1.9_v0.06.ini >> $LOG 2>&1) || echo "[abi1] a=1.9 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.900_*_kz0v4_valley_a1p9_v0p06" >> $LOG 2>&1)
echo "[abi1] a=1.9 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a1.9_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.9
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a1p9_v0p08
EOINI
echo "[abi1] a=1.9 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a1.9_v0.08.ini >> $LOG 2>&1) || echo "[abi1] a=1.9 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.900_*_kz0v4_valley_a1p9_v0p08" >> $LOG 2>&1)
echo "[abi1] a=1.9 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a1.9_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a1p9_v0p1
EOINI
echo "[abi1] a=1.9 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a1.9_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=1.9 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.900_*_kz0v4_valley_a1p9_v0p1" >> $LOG 2>&1)
echo "[abi1] a=1.9 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a2.1_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p1_v0p05
EOINI
echo "[abi1] a=2.1 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a2.1_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=2.1 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.100_*_kz0v4_valley_a2p1_v0p05" >> $LOG 2>&1)
echo "[abi1] a=2.1 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a2.1_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.1
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p1_v0p07
EOINI
echo "[abi1] a=2.1 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a2.1_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=2.1 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.100_*_kz0v4_valley_a2p1_v0p07" >> $LOG 2>&1)
echo "[abi1] a=2.1 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a2.1_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.1
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p1_v0p09
EOINI
echo "[abi1] a=2.1 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a2.1_v0.09.ini >> $LOG 2>&1) || echo "[abi1] a=2.1 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.100_*_kz0v4_valley_a2p1_v0p09" >> $LOG 2>&1)
echo "[abi1] a=2.1 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a2.3_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.3
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p3_v0p04
EOINI
echo "[abi1] a=2.3 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a2.3_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=2.3 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.300_*_kz0v4_valley_a2p3_v0p04" >> $LOG 2>&1)
echo "[abi1] a=2.3 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a2.3_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.3
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p3_v0p06
EOINI
echo "[abi1] a=2.3 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a2.3_v0.06.ini >> $LOG 2>&1) || echo "[abi1] a=2.3 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.300_*_kz0v4_valley_a2p3_v0p06" >> $LOG 2>&1)
echo "[abi1] a=2.3 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a2.3_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.3
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p3_v0p08
EOINI
echo "[abi1] a=2.3 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a2.3_v0.08.ini >> $LOG 2>&1) || echo "[abi1] a=2.3 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.300_*_kz0v4_valley_a2p3_v0p08" >> $LOG 2>&1)
echo "[abi1] a=2.3 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a2.3_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p3_v0p1
EOINI
echo "[abi1] a=2.3 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a2.3_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=2.3 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.300_*_kz0v4_valley_a2p3_v0p1" >> $LOG 2>&1)
echo "[abi1] a=2.3 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a2.5_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p5_v0p05
EOINI
echo "[abi1] a=2.5 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a2.5_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=2.5 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.500_*_kz0v4_valley_a2p5_v0p05" >> $LOG 2>&1)
echo "[abi1] a=2.5 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a2.5_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p5_v0p07
EOINI
echo "[abi1] a=2.5 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a2.5_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=2.5 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.500_*_kz0v4_valley_a2p5_v0p07" >> $LOG 2>&1)
echo "[abi1] a=2.5 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a2.5_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p5_v0p09
EOINI
echo "[abi1] a=2.5 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a2.5_v0.09.ini >> $LOG 2>&1) || echo "[abi1] a=2.5 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.500_*_kz0v4_valley_a2p5_v0p09" >> $LOG 2>&1)
echo "[abi1] a=2.5 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a2.7_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.7
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p7_v0p04
EOINI
echo "[abi1] a=2.7 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a2.7_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=2.7 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.700_*_kz0v4_valley_a2p7_v0p04" >> $LOG 2>&1)
echo "[abi1] a=2.7 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a2.7_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.7
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p7_v0p06
EOINI
echo "[abi1] a=2.7 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a2.7_v0.06.ini >> $LOG 2>&1) || echo "[abi1] a=2.7 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.700_*_kz0v4_valley_a2p7_v0p06" >> $LOG 2>&1)
echo "[abi1] a=2.7 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a2.7_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.7
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p7_v0p08
EOINI
echo "[abi1] a=2.7 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a2.7_v0.08.ini >> $LOG 2>&1) || echo "[abi1] a=2.7 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.700_*_kz0v4_valley_a2p7_v0p08" >> $LOG 2>&1)
echo "[abi1] a=2.7 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a2.7_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p7_v0p1
EOINI
echo "[abi1] a=2.7 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a2.7_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=2.7 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.700_*_kz0v4_valley_a2p7_v0p1" >> $LOG 2>&1)
echo "[abi1] a=2.7 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a2.9_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p9_v0p05
EOINI
echo "[abi1] a=2.9 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a2.9_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=2.9 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.900_*_kz0v4_valley_a2p9_v0p05" >> $LOG 2>&1)
echo "[abi1] a=2.9 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a2.9_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.9
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p9_v0p07
EOINI
echo "[abi1] a=2.9 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a2.9_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=2.9 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.900_*_kz0v4_valley_a2p9_v0p07" >> $LOG 2>&1)
echo "[abi1] a=2.9 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a2.9_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.9
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p9_v0p09
EOINI
echo "[abi1] a=2.9 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a2.9_v0.09.ini >> $LOG 2>&1) || echo "[abi1] a=2.9 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.900_*_kz0v4_valley_a2p9_v0p09" >> $LOG 2>&1)
echo "[abi1] a=2.9 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a3.1_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.1
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p1_v0p04
EOINI
echo "[abi1] a=3.1 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a3.1_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=3.1 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.100_*_kz0v4_valley_a3p1_v0p04" >> $LOG 2>&1)
echo "[abi1] a=3.1 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a3.1_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.1
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p1_v0p06
EOINI
echo "[abi1] a=3.1 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a3.1_v0.06.ini >> $LOG 2>&1) || echo "[abi1] a=3.1 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.100_*_kz0v4_valley_a3p1_v0p06" >> $LOG 2>&1)
echo "[abi1] a=3.1 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a3.1_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.1
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p1_v0p08
EOINI
echo "[abi1] a=3.1 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a3.1_v0.08.ini >> $LOG 2>&1) || echo "[abi1] a=3.1 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.100_*_kz0v4_valley_a3p1_v0p08" >> $LOG 2>&1)
echo "[abi1] a=3.1 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a3.1_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p1_v0p1
EOINI
echo "[abi1] a=3.1 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a3.1_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=3.1 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.100_*_kz0v4_valley_a3p1_v0p1" >> $LOG 2>&1)
echo "[abi1] a=3.1 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a3.3_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p3_v0p05
EOINI
echo "[abi1] a=3.3 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a3.3_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=3.3 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.300_*_kz0v4_valley_a3p3_v0p05" >> $LOG 2>&1)
echo "[abi1] a=3.3 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a3.3_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.3
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p3_v0p07
EOINI
echo "[abi1] a=3.3 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a3.3_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=3.3 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.300_*_kz0v4_valley_a3p3_v0p07" >> $LOG 2>&1)
echo "[abi1] a=3.3 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a3.3_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.3
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p3_v0p09
EOINI
echo "[abi1] a=3.3 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a3.3_v0.09.ini >> $LOG 2>&1) || echo "[abi1] a=3.3 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.300_*_kz0v4_valley_a3p3_v0p09" >> $LOG 2>&1)
echo "[abi1] a=3.3 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a3.5_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.5
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p5_v0p04
EOINI
echo "[abi1] a=3.5 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a3.5_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=3.5 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.500_*_kz0v4_valley_a3p5_v0p04" >> $LOG 2>&1)
echo "[abi1] a=3.5 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a3.5_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.5
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p5_v0p06
EOINI
echo "[abi1] a=3.5 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a3.5_v0.06.ini >> $LOG 2>&1) || echo "[abi1] a=3.5 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.500_*_kz0v4_valley_a3p5_v0p06" >> $LOG 2>&1)
echo "[abi1] a=3.5 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a3.5_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.5
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p5_v0p08
EOINI
echo "[abi1] a=3.5 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a3.5_v0.08.ini >> $LOG 2>&1) || echo "[abi1] a=3.5 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.500_*_kz0v4_valley_a3p5_v0p08" >> $LOG 2>&1)
echo "[abi1] a=3.5 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a3.5_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p5_v0p1
EOINI
echo "[abi1] a=3.5 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a3.5_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=3.5 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.500_*_kz0v4_valley_a3p5_v0p1" >> $LOG 2>&1)
echo "[abi1] a=3.5 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a3.7_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p7_v0p05
EOINI
echo "[abi1] a=3.7 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a3.7_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=3.7 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.700_*_kz0v4_valley_a3p7_v0p05" >> $LOG 2>&1)
echo "[abi1] a=3.7 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a3.7_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.7
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p7_v0p07
EOINI
echo "[abi1] a=3.7 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a3.7_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=3.7 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.700_*_kz0v4_valley_a3p7_v0p07" >> $LOG 2>&1)
echo "[abi1] a=3.7 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a3.7_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.7
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p7_v0p09
EOINI
echo "[abi1] a=3.7 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a3.7_v0.09.ini >> $LOG 2>&1) || echo "[abi1] a=3.7 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.700_*_kz0v4_valley_a3p7_v0p09" >> $LOG 2>&1)
echo "[abi1] a=3.7 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a3.9_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.9
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p9_v0p04
EOINI
echo "[abi1] a=3.9 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a3.9_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=3.9 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.900_*_kz0v4_valley_a3p9_v0p04" >> $LOG 2>&1)
echo "[abi1] a=3.9 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a3.9_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.9
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p9_v0p06
EOINI
echo "[abi1] a=3.9 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a3.9_v0.06.ini >> $LOG 2>&1) || echo "[abi1] a=3.9 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.900_*_kz0v4_valley_a3p9_v0p06" >> $LOG 2>&1)
echo "[abi1] a=3.9 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a3.9_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.9
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p9_v0p08
EOINI
echo "[abi1] a=3.9 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a3.9_v0.08.ini >> $LOG 2>&1) || echo "[abi1] a=3.9 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.900_*_kz0v4_valley_a3p9_v0p08" >> $LOG 2>&1)
echo "[abi1] a=3.9 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a3.9_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p9_v0p1
EOINI
echo "[abi1] a=3.9 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a3.9_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=3.9 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.900_*_kz0v4_valley_a3p9_v0p1" >> $LOG 2>&1)
echo "[abi1] a=3.9 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a4.1_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a4p1_v0p05
EOINI
echo "[abi1] a=4.1 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a4.1_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=4.1 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.100_*_kz0v4_valley_a4p1_v0p05" >> $LOG 2>&1)
echo "[abi1] a=4.1 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a4.1_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.1
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a4p1_v0p07
EOINI
echo "[abi1] a=4.1 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a4.1_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=4.1 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.100_*_kz0v4_valley_a4p1_v0p07" >> $LOG 2>&1)
echo "[abi1] a=4.1 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a4.1_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.1
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a4p1_v0p09
EOINI
echo "[abi1] a=4.1 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a4.1_v0.09.ini >> $LOG 2>&1) || echo "[abi1] a=4.1 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.100_*_kz0v4_valley_a4p1_v0p09" >> $LOG 2>&1)
echo "[abi1] a=4.1 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a4.3_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.3
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a4p3_v0p04
EOINI
echo "[abi1] a=4.3 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a4.3_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=4.3 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.300_*_kz0v4_valley_a4p3_v0p04" >> $LOG 2>&1)
echo "[abi1] a=4.3 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a4.3_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.3
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a4p3_v0p06
EOINI
echo "[abi1] a=4.3 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a4.3_v0.06.ini >> $LOG 2>&1) || echo "[abi1] a=4.3 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.300_*_kz0v4_valley_a4p3_v0p06" >> $LOG 2>&1)
echo "[abi1] a=4.3 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a4.3_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.3
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a4p3_v0p08
EOINI
echo "[abi1] a=4.3 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a4.3_v0.08.ini >> $LOG 2>&1) || echo "[abi1] a=4.3 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.300_*_kz0v4_valley_a4p3_v0p08" >> $LOG 2>&1)
echo "[abi1] a=4.3 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a4.3_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a4p3_v0p1
EOINI
echo "[abi1] a=4.3 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a4.3_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=4.3 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.300_*_kz0v4_valley_a4p3_v0p1" >> $LOG 2>&1)
echo "[abi1] a=4.3 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a4.6_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a4p6_v0p05
EOINI
echo "[abi1] a=4.6 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a4.6_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=4.6 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.600_*_kz0v4_valley_a4p6_v0p05" >> $LOG 2>&1)
echo "[abi1] a=4.6 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a4.6_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.6
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a4p6_v0p07
EOINI
echo "[abi1] a=4.6 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a4.6_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=4.6 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.600_*_kz0v4_valley_a4p6_v0p07" >> $LOG 2>&1)
echo "[abi1] a=4.6 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a4.6_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.6
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a4p6_v0p09
EOINI
echo "[abi1] a=4.6 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a4.6_v0.09.ini >> $LOG 2>&1) || echo "[abi1] a=4.6 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.600_*_kz0v4_valley_a4p6_v0p09" >> $LOG 2>&1)
echo "[abi1] a=4.6 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a5.0_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.0
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a5p0_v0p04
EOINI
echo "[abi1] a=5.0 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a5.0_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=5.0 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.000_*_kz0v4_valley_a5p0_v0p04" >> $LOG 2>&1)
echo "[abi1] a=5.0 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a5.0_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.0
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a5p0_v0p06
EOINI
echo "[abi1] a=5.0 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a5.0_v0.06.ini >> $LOG 2>&1) || echo "[abi1] a=5.0 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.000_*_kz0v4_valley_a5p0_v0p06" >> $LOG 2>&1)
echo "[abi1] a=5.0 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a5.0_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a5p0_v0p08
EOINI
echo "[abi1] a=5.0 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a5.0_v0.08.ini >> $LOG 2>&1) || echo "[abi1] a=5.0 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.000_*_kz0v4_valley_a5p0_v0p08" >> $LOG 2>&1)
echo "[abi1] a=5.0 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a5.0_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a5p0_v0p1
EOINI
echo "[abi1] a=5.0 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a5.0_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=5.0 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.000_*_kz0v4_valley_a5p0_v0p1" >> $LOG 2>&1)
echo "[abi1] a=5.0 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a5.4_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a5p4_v0p05
EOINI
echo "[abi1] a=5.4 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a5.4_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=5.4 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.400_*_kz0v4_valley_a5p4_v0p05" >> $LOG 2>&1)
echo "[abi1] a=5.4 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a5.4_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.4
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a5p4_v0p07
EOINI
echo "[abi1] a=5.4 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a5.4_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=5.4 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.400_*_kz0v4_valley_a5p4_v0p07" >> $LOG 2>&1)
echo "[abi1] a=5.4 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi1_a5.4_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.4
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a5p4_v0p09
EOINI
echo "[abi1] a=5.4 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi1_a5.4_v0.09.ini >> $LOG 2>&1) || echo "[abi1] a=5.4 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.400_*_kz0v4_valley_a5p4_v0p09" >> $LOG 2>&1)
echo "[abi1] a=5.4 V0=0.09 kz=0(noise) done $(date)" >> $LOG

    echo "=== abi1 ALL DONE $(date) ===" >> $LOG
}

run_gpu2() {
    export CUDA_VISIBLE_DEVICES=2
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/kz0v4_abi2_progress.log
    echo "=== kz0v4 abi2 start $(date) ===" >> $LOG
# ---- smoke test: NAB_DTANH binary + noise-driven kz=0 extractor ----
cat > /tmp/kz0v4_smoke_abi2.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 2e-4
target_tu = 50
run_tag = smokev4abi2
EOINI
rm -rf $WDIR/outputs/ym_k1_a2.000*smokev4abi2*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_smoke_abi2.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000*smokev4abi2" >> $LOG 2>&1)
python3 - "$WDIR" abi2 <<'EOPY' >> $LOG 2>&1 || { echo "[abi2] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k1_a2.000*smokev4" + stream + "*/timeseries_k0.csv")
assert fs, "smoke: no timeseries_k0.csv written"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert len(rows) >= 5, "smoke: too few rows (%d)" % len(rows)
amps = [float(r['amp']) for r in rows]
assert amps[-1] > amps[0], "smoke: kz=0 amplitude did not grow"
print("[%s] smoke test OK (kz0v4): amp0=%.3e ampf=%.3e" % (stream, amps[0], amps[-1]))
EOPY
rm -rf $WDIR/outputs/ym_k1_a2.000*smokev4abi2*

cat > /tmp/kz0v4_abi2_a0.6_v0.035.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.6
V0 = 0.035
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a0p6_v0p035
EOINI
echo "[abi2] a=0.6 V0=0.035 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a0.6_v0.035.ini >> $LOG 2>&1) || echo "[abi2] a=0.6 V0=0.035 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.600_*_kz0v4_corner_a0p6_v0p035" >> $LOG 2>&1)
echo "[abi2] a=0.6 V0=0.035 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a0.6_v0.045.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.6
V0 = 0.045
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a0p6_v0p045
EOINI
echo "[abi2] a=0.6 V0=0.045 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a0.6_v0.045.ini >> $LOG 2>&1) || echo "[abi2] a=0.6 V0=0.045 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.600_*_kz0v4_corner_a0p6_v0p045" >> $LOG 2>&1)
echo "[abi2] a=0.6 V0=0.045 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a0.7_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.7
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a0p7_v0p03
EOINI
echo "[abi2] a=0.7 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a0.7_v0.03.ini >> $LOG 2>&1) || echo "[abi2] a=0.7 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.700_*_kz0v4_corner_a0p7_v0p03" >> $LOG 2>&1)
echo "[abi2] a=0.7 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a0.7_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.7
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a0p7_v0p04
EOINI
echo "[abi2] a=0.7 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a0.7_v0.04.ini >> $LOG 2>&1) || echo "[abi2] a=0.7 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.700_*_kz0v4_corner_a0p7_v0p04" >> $LOG 2>&1)
echo "[abi2] a=0.7 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a0.7_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a0p7_v0p05
EOINI
echo "[abi2] a=0.7 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a0.7_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=0.7 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.700_*_kz0v4_corner_a0p7_v0p05" >> $LOG 2>&1)
echo "[abi2] a=0.7 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a0.8_v0.035.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.035
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a0p8_v0p035
EOINI
echo "[abi2] a=0.8 V0=0.035 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a0.8_v0.035.ini >> $LOG 2>&1) || echo "[abi2] a=0.8 V0=0.035 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.800_*_kz0v4_corner_a0p8_v0p035" >> $LOG 2>&1)
echo "[abi2] a=0.8 V0=0.035 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a0.8_v0.045.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.045
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a0p8_v0p045
EOINI
echo "[abi2] a=0.8 V0=0.045 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a0.8_v0.045.ini >> $LOG 2>&1) || echo "[abi2] a=0.8 V0=0.045 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.800_*_kz0v4_corner_a0p8_v0p045" >> $LOG 2>&1)
echo "[abi2] a=0.8 V0=0.045 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a0.9_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.9
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a0p9_v0p03
EOINI
echo "[abi2] a=0.9 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a0.9_v0.03.ini >> $LOG 2>&1) || echo "[abi2] a=0.9 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.900_*_kz0v4_corner_a0p9_v0p03" >> $LOG 2>&1)
echo "[abi2] a=0.9 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a0.9_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.9
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a0p9_v0p04
EOINI
echo "[abi2] a=0.9 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a0.9_v0.04.ini >> $LOG 2>&1) || echo "[abi2] a=0.9 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.900_*_kz0v4_corner_a0p9_v0p04" >> $LOG 2>&1)
echo "[abi2] a=0.9 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a0.9_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a0p9_v0p05
EOINI
echo "[abi2] a=0.9 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a0.9_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=0.9 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.900_*_kz0v4_corner_a0p9_v0p05" >> $LOG 2>&1)
echo "[abi2] a=0.9 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a1.0_v0.035.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.035
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a1p0_v0p035
EOINI
echo "[abi2] a=1.0 V0=0.035 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a1.0_v0.035.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.035 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.000_*_kz0v4_corner_a1p0_v0p035" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.035 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a1.0_v0.045.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.045
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_corner_a1p0_v0p045
EOINI
echo "[abi2] a=1.0 V0=0.045 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a1.0_v0.045.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.045 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.000_*_kz0v4_corner_a1p0_v0p045" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.045 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a1.7_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.7
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a1p7_v0p04
EOINI
echo "[abi2] a=1.7 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a1.7_v0.04.ini >> $LOG 2>&1) || echo "[abi2] a=1.7 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.700_*_kz0v4_valley_a1p7_v0p04" >> $LOG 2>&1)
echo "[abi2] a=1.7 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a1.7_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.7
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a1p7_v0p06
EOINI
echo "[abi2] a=1.7 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a1.7_v0.06.ini >> $LOG 2>&1) || echo "[abi2] a=1.7 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.700_*_kz0v4_valley_a1p7_v0p06" >> $LOG 2>&1)
echo "[abi2] a=1.7 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a1.7_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.7
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a1p7_v0p08
EOINI
echo "[abi2] a=1.7 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a1.7_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=1.7 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.700_*_kz0v4_valley_a1p7_v0p08" >> $LOG 2>&1)
echo "[abi2] a=1.7 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a1.7_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a1p7_v0p1
EOINI
echo "[abi2] a=1.7 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a1.7_v0.1.ini >> $LOG 2>&1) || echo "[abi2] a=1.7 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.700_*_kz0v4_valley_a1p7_v0p1" >> $LOG 2>&1)
echo "[abi2] a=1.7 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a1.9_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a1p9_v0p05
EOINI
echo "[abi2] a=1.9 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a1.9_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=1.9 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.900_*_kz0v4_valley_a1p9_v0p05" >> $LOG 2>&1)
echo "[abi2] a=1.9 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a1.9_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.9
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a1p9_v0p07
EOINI
echo "[abi2] a=1.9 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a1.9_v0.07.ini >> $LOG 2>&1) || echo "[abi2] a=1.9 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.900_*_kz0v4_valley_a1p9_v0p07" >> $LOG 2>&1)
echo "[abi2] a=1.9 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a1.9_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.9
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a1p9_v0p09
EOINI
echo "[abi2] a=1.9 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a1.9_v0.09.ini >> $LOG 2>&1) || echo "[abi2] a=1.9 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.900_*_kz0v4_valley_a1p9_v0p09" >> $LOG 2>&1)
echo "[abi2] a=1.9 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a2.1_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.1
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p1_v0p04
EOINI
echo "[abi2] a=2.1 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a2.1_v0.04.ini >> $LOG 2>&1) || echo "[abi2] a=2.1 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.100_*_kz0v4_valley_a2p1_v0p04" >> $LOG 2>&1)
echo "[abi2] a=2.1 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a2.1_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.1
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p1_v0p06
EOINI
echo "[abi2] a=2.1 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a2.1_v0.06.ini >> $LOG 2>&1) || echo "[abi2] a=2.1 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.100_*_kz0v4_valley_a2p1_v0p06" >> $LOG 2>&1)
echo "[abi2] a=2.1 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a2.1_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.1
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p1_v0p08
EOINI
echo "[abi2] a=2.1 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a2.1_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=2.1 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.100_*_kz0v4_valley_a2p1_v0p08" >> $LOG 2>&1)
echo "[abi2] a=2.1 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a2.1_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p1_v0p1
EOINI
echo "[abi2] a=2.1 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a2.1_v0.1.ini >> $LOG 2>&1) || echo "[abi2] a=2.1 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.100_*_kz0v4_valley_a2p1_v0p1" >> $LOG 2>&1)
echo "[abi2] a=2.1 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a2.3_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p3_v0p05
EOINI
echo "[abi2] a=2.3 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a2.3_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=2.3 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.300_*_kz0v4_valley_a2p3_v0p05" >> $LOG 2>&1)
echo "[abi2] a=2.3 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a2.3_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.3
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p3_v0p07
EOINI
echo "[abi2] a=2.3 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a2.3_v0.07.ini >> $LOG 2>&1) || echo "[abi2] a=2.3 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.300_*_kz0v4_valley_a2p3_v0p07" >> $LOG 2>&1)
echo "[abi2] a=2.3 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a2.3_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.3
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p3_v0p09
EOINI
echo "[abi2] a=2.3 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a2.3_v0.09.ini >> $LOG 2>&1) || echo "[abi2] a=2.3 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.300_*_kz0v4_valley_a2p3_v0p09" >> $LOG 2>&1)
echo "[abi2] a=2.3 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a2.5_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p5_v0p04
EOINI
echo "[abi2] a=2.5 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a2.5_v0.04.ini >> $LOG 2>&1) || echo "[abi2] a=2.5 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.500_*_kz0v4_valley_a2p5_v0p04" >> $LOG 2>&1)
echo "[abi2] a=2.5 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a2.5_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p5_v0p06
EOINI
echo "[abi2] a=2.5 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a2.5_v0.06.ini >> $LOG 2>&1) || echo "[abi2] a=2.5 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.500_*_kz0v4_valley_a2p5_v0p06" >> $LOG 2>&1)
echo "[abi2] a=2.5 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a2.5_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p5_v0p08
EOINI
echo "[abi2] a=2.5 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a2.5_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=2.5 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.500_*_kz0v4_valley_a2p5_v0p08" >> $LOG 2>&1)
echo "[abi2] a=2.5 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a2.5_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p5_v0p1
EOINI
echo "[abi2] a=2.5 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a2.5_v0.1.ini >> $LOG 2>&1) || echo "[abi2] a=2.5 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.500_*_kz0v4_valley_a2p5_v0p1" >> $LOG 2>&1)
echo "[abi2] a=2.5 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a2.7_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.7
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p7_v0p05
EOINI
echo "[abi2] a=2.7 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a2.7_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=2.7 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.700_*_kz0v4_valley_a2p7_v0p05" >> $LOG 2>&1)
echo "[abi2] a=2.7 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a2.7_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.7
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p7_v0p07
EOINI
echo "[abi2] a=2.7 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a2.7_v0.07.ini >> $LOG 2>&1) || echo "[abi2] a=2.7 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.700_*_kz0v4_valley_a2p7_v0p07" >> $LOG 2>&1)
echo "[abi2] a=2.7 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a2.7_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.7
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p7_v0p09
EOINI
echo "[abi2] a=2.7 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a2.7_v0.09.ini >> $LOG 2>&1) || echo "[abi2] a=2.7 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.700_*_kz0v4_valley_a2p7_v0p09" >> $LOG 2>&1)
echo "[abi2] a=2.7 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a2.9_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.9
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p9_v0p04
EOINI
echo "[abi2] a=2.9 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a2.9_v0.04.ini >> $LOG 2>&1) || echo "[abi2] a=2.9 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.900_*_kz0v4_valley_a2p9_v0p04" >> $LOG 2>&1)
echo "[abi2] a=2.9 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a2.9_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.9
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p9_v0p06
EOINI
echo "[abi2] a=2.9 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a2.9_v0.06.ini >> $LOG 2>&1) || echo "[abi2] a=2.9 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.900_*_kz0v4_valley_a2p9_v0p06" >> $LOG 2>&1)
echo "[abi2] a=2.9 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a2.9_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.9
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p9_v0p08
EOINI
echo "[abi2] a=2.9 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a2.9_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=2.9 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.900_*_kz0v4_valley_a2p9_v0p08" >> $LOG 2>&1)
echo "[abi2] a=2.9 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a2.9_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.9
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a2p9_v0p1
EOINI
echo "[abi2] a=2.9 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a2.9_v0.1.ini >> $LOG 2>&1) || echo "[abi2] a=2.9 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.900_*_kz0v4_valley_a2p9_v0p1" >> $LOG 2>&1)
echo "[abi2] a=2.9 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a3.1_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.1
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p1_v0p05
EOINI
echo "[abi2] a=3.1 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a3.1_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=3.1 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.100_*_kz0v4_valley_a3p1_v0p05" >> $LOG 2>&1)
echo "[abi2] a=3.1 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a3.1_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.1
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p1_v0p07
EOINI
echo "[abi2] a=3.1 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a3.1_v0.07.ini >> $LOG 2>&1) || echo "[abi2] a=3.1 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.100_*_kz0v4_valley_a3p1_v0p07" >> $LOG 2>&1)
echo "[abi2] a=3.1 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a3.1_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.1
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p1_v0p09
EOINI
echo "[abi2] a=3.1 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a3.1_v0.09.ini >> $LOG 2>&1) || echo "[abi2] a=3.1 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.100_*_kz0v4_valley_a3p1_v0p09" >> $LOG 2>&1)
echo "[abi2] a=3.1 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a3.3_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.3
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p3_v0p04
EOINI
echo "[abi2] a=3.3 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a3.3_v0.04.ini >> $LOG 2>&1) || echo "[abi2] a=3.3 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.300_*_kz0v4_valley_a3p3_v0p04" >> $LOG 2>&1)
echo "[abi2] a=3.3 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a3.3_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.3
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p3_v0p06
EOINI
echo "[abi2] a=3.3 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a3.3_v0.06.ini >> $LOG 2>&1) || echo "[abi2] a=3.3 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.300_*_kz0v4_valley_a3p3_v0p06" >> $LOG 2>&1)
echo "[abi2] a=3.3 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a3.3_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.3
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p3_v0p08
EOINI
echo "[abi2] a=3.3 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a3.3_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=3.3 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.300_*_kz0v4_valley_a3p3_v0p08" >> $LOG 2>&1)
echo "[abi2] a=3.3 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a3.3_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.3
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p3_v0p1
EOINI
echo "[abi2] a=3.3 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a3.3_v0.1.ini >> $LOG 2>&1) || echo "[abi2] a=3.3 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.300_*_kz0v4_valley_a3p3_v0p1" >> $LOG 2>&1)
echo "[abi2] a=3.3 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a3.5_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p5_v0p05
EOINI
echo "[abi2] a=3.5 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a3.5_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=3.5 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.500_*_kz0v4_valley_a3p5_v0p05" >> $LOG 2>&1)
echo "[abi2] a=3.5 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a3.5_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.5
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p5_v0p07
EOINI
echo "[abi2] a=3.5 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a3.5_v0.07.ini >> $LOG 2>&1) || echo "[abi2] a=3.5 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.500_*_kz0v4_valley_a3p5_v0p07" >> $LOG 2>&1)
echo "[abi2] a=3.5 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a3.5_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.5
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p5_v0p09
EOINI
echo "[abi2] a=3.5 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a3.5_v0.09.ini >> $LOG 2>&1) || echo "[abi2] a=3.5 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.500_*_kz0v4_valley_a3p5_v0p09" >> $LOG 2>&1)
echo "[abi2] a=3.5 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a3.7_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.7
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p7_v0p04
EOINI
echo "[abi2] a=3.7 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a3.7_v0.04.ini >> $LOG 2>&1) || echo "[abi2] a=3.7 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.700_*_kz0v4_valley_a3p7_v0p04" >> $LOG 2>&1)
echo "[abi2] a=3.7 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a3.7_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.7
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p7_v0p06
EOINI
echo "[abi2] a=3.7 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a3.7_v0.06.ini >> $LOG 2>&1) || echo "[abi2] a=3.7 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.700_*_kz0v4_valley_a3p7_v0p06" >> $LOG 2>&1)
echo "[abi2] a=3.7 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a3.7_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.7
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p7_v0p08
EOINI
echo "[abi2] a=3.7 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a3.7_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=3.7 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.700_*_kz0v4_valley_a3p7_v0p08" >> $LOG 2>&1)
echo "[abi2] a=3.7 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a3.7_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.7
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p7_v0p1
EOINI
echo "[abi2] a=3.7 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a3.7_v0.1.ini >> $LOG 2>&1) || echo "[abi2] a=3.7 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.700_*_kz0v4_valley_a3p7_v0p1" >> $LOG 2>&1)
echo "[abi2] a=3.7 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a3.9_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.9
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p9_v0p05
EOINI
echo "[abi2] a=3.9 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a3.9_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=3.9 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.900_*_kz0v4_valley_a3p9_v0p05" >> $LOG 2>&1)
echo "[abi2] a=3.9 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a3.9_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.9
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p9_v0p07
EOINI
echo "[abi2] a=3.9 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a3.9_v0.07.ini >> $LOG 2>&1) || echo "[abi2] a=3.9 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.900_*_kz0v4_valley_a3p9_v0p07" >> $LOG 2>&1)
echo "[abi2] a=3.9 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a3.9_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.9
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a3p9_v0p09
EOINI
echo "[abi2] a=3.9 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a3.9_v0.09.ini >> $LOG 2>&1) || echo "[abi2] a=3.9 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.900_*_kz0v4_valley_a3p9_v0p09" >> $LOG 2>&1)
echo "[abi2] a=3.9 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a4.1_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.1
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a4p1_v0p04
EOINI
echo "[abi2] a=4.1 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a4.1_v0.04.ini >> $LOG 2>&1) || echo "[abi2] a=4.1 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.100_*_kz0v4_valley_a4p1_v0p04" >> $LOG 2>&1)
echo "[abi2] a=4.1 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a4.1_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.1
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a4p1_v0p06
EOINI
echo "[abi2] a=4.1 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a4.1_v0.06.ini >> $LOG 2>&1) || echo "[abi2] a=4.1 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.100_*_kz0v4_valley_a4p1_v0p06" >> $LOG 2>&1)
echo "[abi2] a=4.1 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a4.1_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.1
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a4p1_v0p08
EOINI
echo "[abi2] a=4.1 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a4.1_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=4.1 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.100_*_kz0v4_valley_a4p1_v0p08" >> $LOG 2>&1)
echo "[abi2] a=4.1 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a4.1_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.1
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a4p1_v0p1
EOINI
echo "[abi2] a=4.1 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a4.1_v0.1.ini >> $LOG 2>&1) || echo "[abi2] a=4.1 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.100_*_kz0v4_valley_a4p1_v0p1" >> $LOG 2>&1)
echo "[abi2] a=4.1 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a4.3_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.3
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a4p3_v0p05
EOINI
echo "[abi2] a=4.3 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a4.3_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=4.3 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.300_*_kz0v4_valley_a4p3_v0p05" >> $LOG 2>&1)
echo "[abi2] a=4.3 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a4.3_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.3
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a4p3_v0p07
EOINI
echo "[abi2] a=4.3 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a4.3_v0.07.ini >> $LOG 2>&1) || echo "[abi2] a=4.3 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.300_*_kz0v4_valley_a4p3_v0p07" >> $LOG 2>&1)
echo "[abi2] a=4.3 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a4.3_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.3
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a4p3_v0p09
EOINI
echo "[abi2] a=4.3 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a4.3_v0.09.ini >> $LOG 2>&1) || echo "[abi2] a=4.3 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.300_*_kz0v4_valley_a4p3_v0p09" >> $LOG 2>&1)
echo "[abi2] a=4.3 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a4.6_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.6
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a4p6_v0p04
EOINI
echo "[abi2] a=4.6 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a4.6_v0.04.ini >> $LOG 2>&1) || echo "[abi2] a=4.6 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.600_*_kz0v4_valley_a4p6_v0p04" >> $LOG 2>&1)
echo "[abi2] a=4.6 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a4.6_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.6
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a4p6_v0p06
EOINI
echo "[abi2] a=4.6 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a4.6_v0.06.ini >> $LOG 2>&1) || echo "[abi2] a=4.6 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.600_*_kz0v4_valley_a4p6_v0p06" >> $LOG 2>&1)
echo "[abi2] a=4.6 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a4.6_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.6
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a4p6_v0p08
EOINI
echo "[abi2] a=4.6 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a4.6_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=4.6 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.600_*_kz0v4_valley_a4p6_v0p08" >> $LOG 2>&1)
echo "[abi2] a=4.6 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a4.6_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a4p6_v0p1
EOINI
echo "[abi2] a=4.6 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a4.6_v0.1.ini >> $LOG 2>&1) || echo "[abi2] a=4.6 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.600_*_kz0v4_valley_a4p6_v0p1" >> $LOG 2>&1)
echo "[abi2] a=4.6 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a5.0_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a5p0_v0p05
EOINI
echo "[abi2] a=5.0 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a5.0_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=5.0 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.000_*_kz0v4_valley_a5p0_v0p05" >> $LOG 2>&1)
echo "[abi2] a=5.0 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a5.0_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.0
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a5p0_v0p07
EOINI
echo "[abi2] a=5.0 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a5.0_v0.07.ini >> $LOG 2>&1) || echo "[abi2] a=5.0 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.000_*_kz0v4_valley_a5p0_v0p07" >> $LOG 2>&1)
echo "[abi2] a=5.0 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a5.0_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.0
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a5p0_v0p09
EOINI
echo "[abi2] a=5.0 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a5.0_v0.09.ini >> $LOG 2>&1) || echo "[abi2] a=5.0 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.000_*_kz0v4_valley_a5p0_v0p09" >> $LOG 2>&1)
echo "[abi2] a=5.0 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a5.4_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.4
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a5p4_v0p04
EOINI
echo "[abi2] a=5.4 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a5.4_v0.04.ini >> $LOG 2>&1) || echo "[abi2] a=5.4 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.400_*_kz0v4_valley_a5p4_v0p04" >> $LOG 2>&1)
echo "[abi2] a=5.4 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a5.4_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.4
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a5p4_v0p06
EOINI
echo "[abi2] a=5.4 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a5.4_v0.06.ini >> $LOG 2>&1) || echo "[abi2] a=5.4 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.400_*_kz0v4_valley_a5p4_v0p06" >> $LOG 2>&1)
echo "[abi2] a=5.4 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a5.4_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.4
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a5p4_v0p08
EOINI
echo "[abi2] a=5.4 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a5.4_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=5.4 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.400_*_kz0v4_valley_a5p4_v0p08" >> $LOG 2>&1)
echo "[abi2] a=5.4 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v4_abi2_a5.4_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v4_valley_a5p4_v0p1
EOINI
echo "[abi2] a=5.4 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_abi2_a5.4_v0.1.ini >> $LOG 2>&1) || echo "[abi2] a=5.4 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.400_*_kz0v4_valley_a5p4_v0p1" >> $LOG 2>&1)
echo "[abi2] a=5.4 V0=0.1 kz=0(noise) done $(date)" >> $LOG

    echo "=== abi2 ALL DONE $(date) ===" >> $LOG
}

echo "=== abi: launching kz0v4 corner+valley grid (144 pts) $(date) ==="
run_gpu1 & PID1=$!
run_gpu2 & PID2=$!
wait $PID1 && echo 'GPU1 finished' || echo 'GPU1 FAILED'
wait $PID2 && echo 'GPU2 finished' || echo 'GPU2 FAILED'
