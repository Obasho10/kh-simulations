#!/bin/bash
# kz=0 growth-rate extension -- abi (3 GPUs, staged 2026-07-19, NAB_DTANH/Campaign-3 method, v2 after the mode-6 contamination)
WDIR=/DATA/s23103/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs

run_gpu0() {
    export CUDA_VISIBLE_DEVICES=0
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/kz0ext_abi0_progress.log
    echo "=== kz0ext abi0 start $(date) ===" >> $LOG
# ---- smoke test: NAB_DTANH binary + noise-driven kz=0 extractor ----
cat > /tmp/kz0ext_smoke_abi0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 2e-4
target_tu = 50
run_tag = smokeabi0
EOINI
rm -rf $WDIR/outputs/ym_k1_a2.000*smokeabi0*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_smoke_abi0.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000*smokeabi0" >> $LOG 2>&1)
python3 - "$WDIR" abi0 <<'EOPY' >> $LOG 2>&1 || { echo "[abi0] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k1_a2.000*smoke" + stream + "*/timeseries_k0.csv")
assert fs, "smoke: no timeseries_k0.csv written (extract_kz0_noise.py or run_mode=3 path broken)"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert len(rows) >= 5, "smoke: too few rows (%d)" % len(rows)
amps = [float(r['amp']) for r in rows]
assert amps[-1] > amps[0], "smoke: kz=0 amplitude did not grow at all over 50 TU (amp0=%.3e ampf=%.3e)" % (amps[0], amps[-1])
print("[%s] smoke test OK (NAB_DTANH + noise-driven kz=0 extraction): amp0=%.3e ampf=%.3e" % (stream, amps[0], amps[-1]))
EOPY
rm -rf $WDIR/outputs/ym_k1_a2.000*smokeabi0*

cat > /tmp/kz0ext_abi0_a0.5_v0.01.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 297.8
run_tag = kz0ext_a0p5_v0p01
EOINI
echo "[abi0] a=0.5 V0=0.01 kz=0(noise) (tu=297.8) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a0.5_v0.01.ini >> $LOG 2>&1) || echo "[abi0] a=0.5 V0=0.01 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.500_*_kz0ext_a0p5_v0p01" >> $LOG 2>&1)
echo "[abi0] a=0.5 V0=0.01 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a0.5_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 148.9
run_tag = kz0ext_a0p5_v0p08
EOINI
echo "[abi0] a=0.5 V0=0.08 kz=0(noise) (tu=148.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a0.5_v0.08.ini >> $LOG 2>&1) || echo "[abi0] a=0.5 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.500_*_kz0ext_a0p5_v0p08" >> $LOG 2>&1)
echo "[abi0] a=0.5 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a0.5_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 138.2
run_tag = kz0ext_a0p5_v0p1
EOINI
echo "[abi0] a=0.5 V0=0.1 kz=0(noise) (tu=138.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a0.5_v0.1.ini >> $LOG 2>&1) || echo "[abi0] a=0.5 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.500_*_kz0ext_a0p5_v0p1" >> $LOG 2>&1)
echo "[abi0] a=0.5 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a1.0_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 123.1
run_tag = kz0ext_a1p0_v0p05
EOINI
echo "[abi0] a=1.0 V0=0.05 kz=0(noise) (tu=123.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a1.0_v0.05.ini >> $LOG 2>&1) || echo "[abi0] a=1.0 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.000_*_kz0ext_a1p0_v0p05" >> $LOG 2>&1)
echo "[abi0] a=1.0 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a1.5_v0.01.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 171.9
run_tag = kz0ext_a1p5_v0p01
EOINI
echo "[abi0] a=1.5 V0=0.01 kz=0(noise) (tu=171.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a1.5_v0.01.ini >> $LOG 2>&1) || echo "[abi0] a=1.5 V0=0.01 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.500_*_kz0ext_a1p5_v0p01" >> $LOG 2>&1)
echo "[abi0] a=1.5 V0=0.01 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a1.5_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a1p5_v0p2
EOINI
echo "[abi0] a=1.5 V0=0.2 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a1.5_v0.2.ini >> $LOG 2>&1) || echo "[abi0] a=1.5 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.500_*_kz0ext_a1p5_v0p2" >> $LOG 2>&1)
echo "[abi0] a=1.5 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a2.0_v0.02.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.02
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 118.2
run_tag = kz0ext_a2p0_v0p02
EOINI
echo "[abi0] a=2.0 V0=0.02 kz=0(noise) (tu=118.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a2.0_v0.02.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.02 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000_*_kz0ext_a2p0_v0p02" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.02 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a2.0_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 103.2
run_tag = kz0ext_a2p0_v0p03
EOINI
echo "[abi0] a=2.0 V0=0.03 kz=0(noise) (tu=103.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a2.0_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000_*_kz0ext_a2p0_v0p03" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a2.0_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a2p0_v0p07
EOINI
echo "[abi0] a=2.0 V0=0.07 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a2.0_v0.07.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000_*_kz0ext_a2p0_v0p07" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a2.0_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a2p0_v0p08
EOINI
echo "[abi0] a=2.0 V0=0.08 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a2.0_v0.08.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000_*_kz0ext_a2p0_v0p08" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a2.0_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a2p0_v0p2
EOINI
echo "[abi0] a=2.0 V0=0.2 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a2.0_v0.2.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000_*_kz0ext_a2p0_v0p2" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a2.5_v0.02.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.02
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 105.7
run_tag = kz0ext_a2p5_v0p02
EOINI
echo "[abi0] a=2.5 V0=0.02 kz=0(noise) (tu=105.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a2.5_v0.02.ini >> $LOG 2>&1) || echo "[abi0] a=2.5 V0=0.02 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.500_*_kz0ext_a2p5_v0p02" >> $LOG 2>&1)
echo "[abi0] a=2.5 V0=0.02 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a2.5_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a2p5_v0p05
EOINI
echo "[abi0] a=2.5 V0=0.05 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a2.5_v0.05.ini >> $LOG 2>&1) || echo "[abi0] a=2.5 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.500_*_kz0ext_a2p5_v0p05" >> $LOG 2>&1)
echo "[abi0] a=2.5 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a2.5_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a2p5_v0p1
EOINI
echo "[abi0] a=2.5 V0=0.1 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a2.5_v0.1.ini >> $LOG 2>&1) || echo "[abi0] a=2.5 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.500_*_kz0ext_a2p5_v0p1" >> $LOG 2>&1)
echo "[abi0] a=2.5 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a3.0_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a3p0_v0p05
EOINI
echo "[abi0] a=3.0 V0=0.05 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a3.0_v0.05.ini >> $LOG 2>&1) || echo "[abi0] a=3.0 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.000_*_kz0ext_a3p0_v0p05" >> $LOG 2>&1)
echo "[abi0] a=3.0 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a3.0_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a3p0_v0p07
EOINI
echo "[abi0] a=3.0 V0=0.07 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a3.0_v0.07.ini >> $LOG 2>&1) || echo "[abi0] a=3.0 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.000_*_kz0ext_a3p0_v0p07" >> $LOG 2>&1)
echo "[abi0] a=3.0 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a4.0_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a4p0_v0p03
EOINI
echo "[abi0] a=4.0 V0=0.03 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a4.0_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=4.0 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.000_*_kz0ext_a4p0_v0p03" >> $LOG 2>&1)
echo "[abi0] a=4.0 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a4.0_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a4p0_v0p08
EOINI
echo "[abi0] a=4.0 V0=0.08 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a4.0_v0.08.ini >> $LOG 2>&1) || echo "[abi0] a=4.0 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.000_*_kz0ext_a4p0_v0p08" >> $LOG 2>&1)
echo "[abi0] a=4.0 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a5.0_v0.01.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a5p0_v0p01
EOINI
echo "[abi0] a=5.0 V0=0.01 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a5.0_v0.01.ini >> $LOG 2>&1) || echo "[abi0] a=5.0 V0=0.01 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.000_*_kz0ext_a5p0_v0p01" >> $LOG 2>&1)
echo "[abi0] a=5.0 V0=0.01 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a5.0_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a5p0_v0p05
EOINI
echo "[abi0] a=5.0 V0=0.05 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a5.0_v0.05.ini >> $LOG 2>&1) || echo "[abi0] a=5.0 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.000_*_kz0ext_a5p0_v0p05" >> $LOG 2>&1)
echo "[abi0] a=5.0 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a5.0_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a5p0_v0p1
EOINI
echo "[abi0] a=5.0 V0=0.1 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a5.0_v0.1.ini >> $LOG 2>&1) || echo "[abi0] a=5.0 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.000_*_kz0ext_a5p0_v0p1" >> $LOG 2>&1)
echo "[abi0] a=5.0 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a6.0_v0.02.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.0
V0 = 0.02
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a6p0_v0p02
EOINI
echo "[abi0] a=6.0 V0=0.02 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a6.0_v0.02.ini >> $LOG 2>&1) || echo "[abi0] a=6.0 V0=0.02 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.000_*_kz0ext_a6p0_v0p02" >> $LOG 2>&1)
echo "[abi0] a=6.0 V0=0.02 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a6.0_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.0
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a6p0_v0p07
EOINI
echo "[abi0] a=6.0 V0=0.07 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a6.0_v0.07.ini >> $LOG 2>&1) || echo "[abi0] a=6.0 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.000_*_kz0ext_a6p0_v0p07" >> $LOG 2>&1)
echo "[abi0] a=6.0 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi0_a6.0_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a6p0_v0p2
EOINI
echo "[abi0] a=6.0 V0=0.2 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi0_a6.0_v0.2.ini >> $LOG 2>&1) || echo "[abi0] a=6.0 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.000_*_kz0ext_a6p0_v0p2" >> $LOG 2>&1)
echo "[abi0] a=6.0 V0=0.2 kz=0(noise) done $(date)" >> $LOG

    echo "=== abi0 ALL DONE $(date) ===" >> $LOG
}

run_gpu1() {
    export CUDA_VISIBLE_DEVICES=1
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/kz0ext_abi1_progress.log
    echo "=== kz0ext abi1 start $(date) ===" >> $LOG
# ---- smoke test: NAB_DTANH binary + noise-driven kz=0 extractor ----
cat > /tmp/kz0ext_smoke_abi1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 2e-4
target_tu = 50
run_tag = smokeabi1
EOINI
rm -rf $WDIR/outputs/ym_k1_a2.000*smokeabi1*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_smoke_abi1.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000*smokeabi1" >> $LOG 2>&1)
python3 - "$WDIR" abi1 <<'EOPY' >> $LOG 2>&1 || { echo "[abi1] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k1_a2.000*smoke" + stream + "*/timeseries_k0.csv")
assert fs, "smoke: no timeseries_k0.csv written (extract_kz0_noise.py or run_mode=3 path broken)"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert len(rows) >= 5, "smoke: too few rows (%d)" % len(rows)
amps = [float(r['amp']) for r in rows]
assert amps[-1] > amps[0], "smoke: kz=0 amplitude did not grow at all over 50 TU (amp0=%.3e ampf=%.3e)" % (amps[0], amps[-1])
print("[%s] smoke test OK (NAB_DTANH + noise-driven kz=0 extraction): amp0=%.3e ampf=%.3e" % (stream, amps[0], amps[-1]))
EOPY
rm -rf $WDIR/outputs/ym_k1_a2.000*smokeabi1*

cat > /tmp/kz0ext_abi1_a0.5_v0.02.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.02
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 236.3
run_tag = kz0ext_a0p5_v0p02
EOINI
echo "[abi1] a=0.5 V0=0.02 kz=0(noise) (tu=236.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a0.5_v0.02.ini >> $LOG 2>&1) || echo "[abi1] a=0.5 V0=0.02 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.500_*_kz0ext_a0p5_v0p02" >> $LOG 2>&1)
echo "[abi1] a=0.5 V0=0.02 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a0.5_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 174.1
run_tag = kz0ext_a0p5_v0p05
EOINI
echo "[abi1] a=0.5 V0=0.05 kz=0(noise) (tu=174.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a0.5_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=0.5 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.500_*_kz0ext_a0p5_v0p05" >> $LOG 2>&1)
echo "[abi1] a=0.5 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a0.5_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 109.7
run_tag = kz0ext_a0p5_v0p2
EOINI
echo "[abi1] a=0.5 V0=0.2 kz=0(noise) (tu=109.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a0.5_v0.2.ini >> $LOG 2>&1) || echo "[abi1] a=0.5 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.500_*_kz0ext_a0p5_v0p2" >> $LOG 2>&1)
echo "[abi1] a=0.5 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a1.0_v0.02.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.02
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 167.1
run_tag = kz0ext_a1p0_v0p02
EOINI
echo "[abi1] a=1.0 V0=0.02 kz=0(noise) (tu=167.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a1.0_v0.02.ini >> $LOG 2>&1) || echo "[abi1] a=1.0 V0=0.02 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.000_*_kz0ext_a1p0_v0p02" >> $LOG 2>&1)
echo "[abi1] a=1.0 V0=0.02 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a1.0_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 146.0
run_tag = kz0ext_a1p0_v0p03
EOINI
echo "[abi1] a=1.0 V0=0.03 kz=0(noise) (tu=146.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a1.0_v0.03.ini >> $LOG 2>&1) || echo "[abi1] a=1.0 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.000_*_kz0ext_a1p0_v0p03" >> $LOG 2>&1)
echo "[abi1] a=1.0 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a1.0_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a1p0_v0p1
EOINI
echo "[abi1] a=1.0 V0=0.1 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a1.0_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=1.0 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.000_*_kz0ext_a1p0_v0p1" >> $LOG 2>&1)
echo "[abi1] a=1.0 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a1.5_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.5
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a1p5_v0p1
EOINI
echo "[abi1] a=1.5 V0=0.1 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a1.5_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=1.5 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.500_*_kz0ext_a1p5_v0p1" >> $LOG 2>&1)
echo "[abi1] a=1.5 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a2.0_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a2p0_v0p05
EOINI
echo "[abi1] a=2.0 V0=0.05 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a2.0_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=2.0 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000_*_kz0ext_a2p0_v0p05" >> $LOG 2>&1)
echo "[abi1] a=2.0 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a2.5_v0.01.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.01
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 133.2
run_tag = kz0ext_a2p5_v0p01
EOINI
echo "[abi1] a=2.5 V0=0.01 kz=0(noise) (tu=133.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a2.5_v0.01.ini >> $LOG 2>&1) || echo "[abi1] a=2.5 V0=0.01 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.500_*_kz0ext_a2p5_v0p01" >> $LOG 2>&1)
echo "[abi1] a=2.5 V0=0.01 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a2.5_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a2p5_v0p03
EOINI
echo "[abi1] a=2.5 V0=0.03 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a2.5_v0.03.ini >> $LOG 2>&1) || echo "[abi1] a=2.5 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.500_*_kz0ext_a2p5_v0p03" >> $LOG 2>&1)
echo "[abi1] a=2.5 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a2.5_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a2p5_v0p08
EOINI
echo "[abi1] a=2.5 V0=0.08 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a2.5_v0.08.ini >> $LOG 2>&1) || echo "[abi1] a=2.5 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.500_*_kz0ext_a2p5_v0p08" >> $LOG 2>&1)
echo "[abi1] a=2.5 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a2.5_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a2p5_v0p2
EOINI
echo "[abi1] a=2.5 V0=0.2 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a2.5_v0.2.ini >> $LOG 2>&1) || echo "[abi1] a=2.5 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.500_*_kz0ext_a2p5_v0p2" >> $LOG 2>&1)
echo "[abi1] a=2.5 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a3.0_v0.01.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 121.6
run_tag = kz0ext_a3p0_v0p01
EOINI
echo "[abi1] a=3.0 V0=0.01 kz=0(noise) (tu=121.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a3.0_v0.01.ini >> $LOG 2>&1) || echo "[abi1] a=3.0 V0=0.01 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.000_*_kz0ext_a3p0_v0p01" >> $LOG 2>&1)
echo "[abi1] a=3.0 V0=0.01 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a3.0_v0.02.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.02
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a3p0_v0p02
EOINI
echo "[abi1] a=3.0 V0=0.02 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a3.0_v0.02.ini >> $LOG 2>&1) || echo "[abi1] a=3.0 V0=0.02 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.000_*_kz0ext_a3p0_v0p02" >> $LOG 2>&1)
echo "[abi1] a=3.0 V0=0.02 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a3.0_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a3p0_v0p1
EOINI
echo "[abi1] a=3.0 V0=0.1 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a3.0_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=3.0 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.000_*_kz0ext_a3p0_v0p1" >> $LOG 2>&1)
echo "[abi1] a=3.0 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a4.0_v0.01.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 105.3
run_tag = kz0ext_a4p0_v0p01
EOINI
echo "[abi1] a=4.0 V0=0.01 kz=0(noise) (tu=105.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a4.0_v0.01.ini >> $LOG 2>&1) || echo "[abi1] a=4.0 V0=0.01 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.000_*_kz0ext_a4p0_v0p01" >> $LOG 2>&1)
echo "[abi1] a=4.0 V0=0.01 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a4.0_v0.02.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.0
V0 = 0.02
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a4p0_v0p02
EOINI
echo "[abi1] a=4.0 V0=0.02 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a4.0_v0.02.ini >> $LOG 2>&1) || echo "[abi1] a=4.0 V0=0.02 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.000_*_kz0ext_a4p0_v0p02" >> $LOG 2>&1)
echo "[abi1] a=4.0 V0=0.02 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a4.0_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.0
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a4p0_v0p07
EOINI
echo "[abi1] a=4.0 V0=0.07 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a4.0_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=4.0 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.000_*_kz0ext_a4p0_v0p07" >> $LOG 2>&1)
echo "[abi1] a=4.0 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a4.0_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a4p0_v0p2
EOINI
echo "[abi1] a=4.0 V0=0.2 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a4.0_v0.2.ini >> $LOG 2>&1) || echo "[abi1] a=4.0 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.000_*_kz0ext_a4p0_v0p2" >> $LOG 2>&1)
echo "[abi1] a=4.0 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a5.0_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a5p0_v0p03
EOINI
echo "[abi1] a=5.0 V0=0.03 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a5.0_v0.03.ini >> $LOG 2>&1) || echo "[abi1] a=5.0 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.000_*_kz0ext_a5p0_v0p03" >> $LOG 2>&1)
echo "[abi1] a=5.0 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a5.0_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a5p0_v0p08
EOINI
echo "[abi1] a=5.0 V0=0.08 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a5.0_v0.08.ini >> $LOG 2>&1) || echo "[abi1] a=5.0 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.000_*_kz0ext_a5p0_v0p08" >> $LOG 2>&1)
echo "[abi1] a=5.0 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a6.0_v0.01.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a6p0_v0p01
EOINI
echo "[abi1] a=6.0 V0=0.01 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a6.0_v0.01.ini >> $LOG 2>&1) || echo "[abi1] a=6.0 V0=0.01 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.000_*_kz0ext_a6p0_v0p01" >> $LOG 2>&1)
echo "[abi1] a=6.0 V0=0.01 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a6.0_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a6p0_v0p05
EOINI
echo "[abi1] a=6.0 V0=0.05 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a6.0_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=6.0 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.000_*_kz0ext_a6p0_v0p05" >> $LOG 2>&1)
echo "[abi1] a=6.0 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi1_a6.0_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a6p0_v0p1
EOINI
echo "[abi1] a=6.0 V0=0.1 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi1_a6.0_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=6.0 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.000_*_kz0ext_a6p0_v0p1" >> $LOG 2>&1)
echo "[abi1] a=6.0 V0=0.1 kz=0(noise) done $(date)" >> $LOG

    echo "=== abi1 ALL DONE $(date) ===" >> $LOG
}

run_gpu2() {
    export CUDA_VISIBLE_DEVICES=2
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/kz0ext_abi2_progress.log
    echo "=== kz0ext abi2 start $(date) ===" >> $LOG
# ---- smoke test: NAB_DTANH binary + noise-driven kz=0 extractor ----
cat > /tmp/kz0ext_smoke_abi2.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 2e-4
target_tu = 50
run_tag = smokeabi2
EOINI
rm -rf $WDIR/outputs/ym_k1_a2.000*smokeabi2*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_smoke_abi2.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000*smokeabi2" >> $LOG 2>&1)
python3 - "$WDIR" abi2 <<'EOPY' >> $LOG 2>&1 || { echo "[abi2] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k1_a2.000*smoke" + stream + "*/timeseries_k0.csv")
assert fs, "smoke: no timeseries_k0.csv written (extract_kz0_noise.py or run_mode=3 path broken)"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert len(rows) >= 5, "smoke: too few rows (%d)" % len(rows)
amps = [float(r['amp']) for r in rows]
assert amps[-1] > amps[0], "smoke: kz=0 amplitude did not grow at all over 50 TU (amp0=%.3e ampf=%.3e)" % (amps[0], amps[-1])
print("[%s] smoke test OK (NAB_DTANH + noise-driven kz=0 extraction): amp0=%.3e ampf=%.3e" % (stream, amps[0], amps[-1]))
EOPY
rm -rf $WDIR/outputs/ym_k1_a2.000*smokeabi2*

cat > /tmp/kz0ext_abi2_a0.5_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 206.5
run_tag = kz0ext_a0p5_v0p03
EOINI
echo "[abi2] a=0.5 V0=0.03 kz=0(noise) (tu=206.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a0.5_v0.03.ini >> $LOG 2>&1) || echo "[abi2] a=0.5 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.500_*_kz0ext_a0p5_v0p03" >> $LOG 2>&1)
echo "[abi2] a=0.5 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a0.5_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.5
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 155.7
run_tag = kz0ext_a0p5_v0p07
EOINI
echo "[abi2] a=0.5 V0=0.07 kz=0(noise) (tu=155.7) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a0.5_v0.07.ini >> $LOG 2>&1) || echo "[abi2] a=0.5 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.500_*_kz0ext_a0p5_v0p07" >> $LOG 2>&1)
echo "[abi2] a=0.5 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a1.0_v0.01.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 210.6
run_tag = kz0ext_a1p0_v0p01
EOINI
echo "[abi2] a=1.0 V0=0.01 kz=0(noise) (tu=210.6) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a1.0_v0.01.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.01 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.000_*_kz0ext_a1p0_v0p01" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.01 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a1.0_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 110.1
run_tag = kz0ext_a1p0_v0p07
EOINI
echo "[abi2] a=1.0 V0=0.07 kz=0(noise) (tu=110.1) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a1.0_v0.07.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.000_*_kz0ext_a1p0_v0p07" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a1.0_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 105.3
run_tag = kz0ext_a1p0_v0p08
EOINI
echo "[abi2] a=1.0 V0=0.08 kz=0(noise) (tu=105.3) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a1.0_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.000_*_kz0ext_a1p0_v0p08" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a1.0_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a1p0_v0p2
EOINI
echo "[abi2] a=1.0 V0=0.2 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a1.0_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=1.0 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.000_*_kz0ext_a1p0_v0p2" >> $LOG 2>&1)
echo "[abi2] a=1.0 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a1.5_v0.02.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.5
V0 = 0.02
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 136.5
run_tag = kz0ext_a1p5_v0p02
EOINI
echo "[abi2] a=1.5 V0=0.02 kz=0(noise) (tu=136.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a1.5_v0.02.ini >> $LOG 2>&1) || echo "[abi2] a=1.5 V0=0.02 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.500_*_kz0ext_a1p5_v0p02" >> $LOG 2>&1)
echo "[abi2] a=1.5 V0=0.02 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a1.5_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.5
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 119.2
run_tag = kz0ext_a1p5_v0p03
EOINI
echo "[abi2] a=1.5 V0=0.03 kz=0(noise) (tu=119.2) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a1.5_v0.03.ini >> $LOG 2>&1) || echo "[abi2] a=1.5 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.500_*_kz0ext_a1p5_v0p03" >> $LOG 2>&1)
echo "[abi2] a=1.5 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a1.5_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.5
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.5
run_tag = kz0ext_a1p5_v0p05
EOINI
echo "[abi2] a=1.5 V0=0.05 kz=0(noise) (tu=100.5) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a1.5_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=1.5 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.500_*_kz0ext_a1p5_v0p05" >> $LOG 2>&1)
echo "[abi2] a=1.5 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a1.5_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.5
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a1p5_v0p07
EOINI
echo "[abi2] a=1.5 V0=0.07 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a1.5_v0.07.ini >> $LOG 2>&1) || echo "[abi2] a=1.5 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.500_*_kz0ext_a1p5_v0p07" >> $LOG 2>&1)
echo "[abi2] a=1.5 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a1.5_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.5
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a1p5_v0p08
EOINI
echo "[abi2] a=1.5 V0=0.08 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a1.5_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=1.5 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.500_*_kz0ext_a1p5_v0p08" >> $LOG 2>&1)
echo "[abi2] a=1.5 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a2.0_v0.01.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.01
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 148.9
run_tag = kz0ext_a2p0_v0p01
EOINI
echo "[abi2] a=2.0 V0=0.01 kz=0(noise) (tu=148.9) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a2.0_v0.01.ini >> $LOG 2>&1) || echo "[abi2] a=2.0 V0=0.01 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000_*_kz0ext_a2p0_v0p01" >> $LOG 2>&1)
echo "[abi2] a=2.0 V0=0.01 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a2.0_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a2p0_v0p1
EOINI
echo "[abi2] a=2.0 V0=0.1 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a2.0_v0.1.ini >> $LOG 2>&1) || echo "[abi2] a=2.0 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000_*_kz0ext_a2p0_v0p1" >> $LOG 2>&1)
echo "[abi2] a=2.0 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a2.5_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.5
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a2p5_v0p07
EOINI
echo "[abi2] a=2.5 V0=0.07 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a2.5_v0.07.ini >> $LOG 2>&1) || echo "[abi2] a=2.5 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.500_*_kz0ext_a2p5_v0p07" >> $LOG 2>&1)
echo "[abi2] a=2.5 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a3.0_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a3p0_v0p03
EOINI
echo "[abi2] a=3.0 V0=0.03 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a3.0_v0.03.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.000_*_kz0ext_a3p0_v0p03" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a3.0_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a3p0_v0p08
EOINI
echo "[abi2] a=3.0 V0=0.08 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a3.0_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.000_*_kz0ext_a3p0_v0p08" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a3.0_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a3p0_v0p2
EOINI
echo "[abi2] a=3.0 V0=0.2 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a3.0_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.000_*_kz0ext_a3p0_v0p2" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a4.0_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a4p0_v0p05
EOINI
echo "[abi2] a=4.0 V0=0.05 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a4.0_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=4.0 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.000_*_kz0ext_a4p0_v0p05" >> $LOG 2>&1)
echo "[abi2] a=4.0 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a4.0_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a4p0_v0p1
EOINI
echo "[abi2] a=4.0 V0=0.1 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a4.0_v0.1.ini >> $LOG 2>&1) || echo "[abi2] a=4.0 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.000_*_kz0ext_a4p0_v0p1" >> $LOG 2>&1)
echo "[abi2] a=4.0 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a5.0_v0.02.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.0
V0 = 0.02
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a5p0_v0p02
EOINI
echo "[abi2] a=5.0 V0=0.02 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a5.0_v0.02.ini >> $LOG 2>&1) || echo "[abi2] a=5.0 V0=0.02 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.000_*_kz0ext_a5p0_v0p02" >> $LOG 2>&1)
echo "[abi2] a=5.0 V0=0.02 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a5.0_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.0
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a5p0_v0p07
EOINI
echo "[abi2] a=5.0 V0=0.07 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a5.0_v0.07.ini >> $LOG 2>&1) || echo "[abi2] a=5.0 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.000_*_kz0ext_a5p0_v0p07" >> $LOG 2>&1)
echo "[abi2] a=5.0 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a5.0_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a5p0_v0p2
EOINI
echo "[abi2] a=5.0 V0=0.2 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a5.0_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=5.0 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.000_*_kz0ext_a5p0_v0p2" >> $LOG 2>&1)
echo "[abi2] a=5.0 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a6.0_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a6p0_v0p03
EOINI
echo "[abi2] a=6.0 V0=0.03 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a6.0_v0.03.ini >> $LOG 2>&1) || echo "[abi2] a=6.0 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.000_*_kz0ext_a6p0_v0p03" >> $LOG 2>&1)
echo "[abi2] a=6.0 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0ext_abi2_a6.0_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 100.0
run_tag = kz0ext_a6p0_v0p08
EOINI
echo "[abi2] a=6.0 V0=0.08 kz=0(noise) (tu=100.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_abi2_a6.0_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=6.0 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.000_*_kz0ext_a6p0_v0p08" >> $LOG 2>&1)
echo "[abi2] a=6.0 V0=0.08 kz=0(noise) done $(date)" >> $LOG

    echo "=== abi2 ALL DONE $(date) ===" >> $LOG
}

echo "=== abi: launching 3-GPU kz=0 extension campaign (v2, NAB_DTANH) $(date) ==="
run_gpu0 & PID0=$!
run_gpu1 & PID1=$!
run_gpu2 & PID2=$!
wait $PID0 && echo 'GPU0 finished' || echo 'GPU0 FAILED'
wait $PID1 && echo 'GPU1 finished' || echo 'GPU1 FAILED'
wait $PID2 && echo 'GPU2 finished' || echo 'GPU2 FAILED'
