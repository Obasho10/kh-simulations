#!/bin/bash
# kz=0 deviation-mapping grid v3 -- abi (3 GPUs), coarse pass (9 V0 x 20 alpha = 180 pts, staged 2026-07-19)
WDIR=/DATA/s23103/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs

run_gpu0() {
    export CUDA_VISIBLE_DEVICES=0
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/kz0v3_abi0_progress.log
    echo "=== kz0v3 abi0 start $(date) ===" >> $LOG
# ---- smoke test: NAB_DTANH binary + noise-driven kz=0 extractor ----
cat > /tmp/kz0v3_smoke_abi0.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 2e-4
target_tu = 50
run_tag = smokev3abi0
EOINI
rm -rf $WDIR/outputs/ym_k1_a2.000*smokev3abi0*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_smoke_abi0.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000*smokev3abi0" >> $LOG 2>&1)
python3 - "$WDIR" abi0 <<'EOPY' >> $LOG 2>&1 || { echo "[abi0] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k1_a2.000*smokev3" + stream + "*/timeseries_k0.csv")
assert fs, "smoke: no timeseries_k0.csv written (extract_kz0_noise.py or run_mode=3 path broken)"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert len(rows) >= 5, "smoke: too few rows (%d)" % len(rows)
amps = [float(r['amp']) for r in rows]
assert amps[-1] > amps[0], "smoke: kz=0 amplitude did not grow at all over 50 TU (amp0=%.3e ampf=%.3e)" % (amps[0], amps[-1])
print("[%s] smoke test OK (kz0v3 grid, NAB_DTANH + noise-driven kz=0 extraction): amp0=%.3e ampf=%.3e" % (stream, amps[0], amps[-1]))
EOPY
rm -rf $WDIR/outputs/ym_k1_a2.000*smokev3abi0*

cat > /tmp/kz0v3_abi0_a0.4_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a0p4_v0p03
EOINI
echo "[abi0] a=0.4 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a0.4_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=0.4 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.400_*_kz0v3_a0p4_v0p03" >> $LOG 2>&1)
echo "[abi0] a=0.4 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a0.4_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.4
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a0p4_v0p06
EOINI
echo "[abi0] a=0.4 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a0.4_v0.06.ini >> $LOG 2>&1) || echo "[abi0] a=0.4 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.400_*_kz0v3_a0p4_v0p06" >> $LOG 2>&1)
echo "[abi0] a=0.4 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a0.4_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.4
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a0p4_v0p09
EOINI
echo "[abi0] a=0.4 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a0.4_v0.09.ini >> $LOG 2>&1) || echo "[abi0] a=0.4 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.400_*_kz0v3_a0p4_v0p09" >> $LOG 2>&1)
echo "[abi0] a=0.4 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a0.8_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a0p8_v0p03
EOINI
echo "[abi0] a=0.8 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a0.8_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=0.8 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.800_*_kz0v3_a0p8_v0p03" >> $LOG 2>&1)
echo "[abi0] a=0.8 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a0.8_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a0p8_v0p06
EOINI
echo "[abi0] a=0.8 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a0.8_v0.06.ini >> $LOG 2>&1) || echo "[abi0] a=0.8 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.800_*_kz0v3_a0p8_v0p06" >> $LOG 2>&1)
echo "[abi0] a=0.8 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a0.8_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a0p8_v0p09
EOINI
echo "[abi0] a=0.8 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a0.8_v0.09.ini >> $LOG 2>&1) || echo "[abi0] a=0.8 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.800_*_kz0v3_a0p8_v0p09" >> $LOG 2>&1)
echo "[abi0] a=0.8 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a1.2_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a1p2_v0p03
EOINI
echo "[abi0] a=1.2 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a1.2_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=1.2 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.200_*_kz0v3_a1p2_v0p03" >> $LOG 2>&1)
echo "[abi0] a=1.2 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a1.2_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.2
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a1p2_v0p06
EOINI
echo "[abi0] a=1.2 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a1.2_v0.06.ini >> $LOG 2>&1) || echo "[abi0] a=1.2 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.200_*_kz0v3_a1p2_v0p06" >> $LOG 2>&1)
echo "[abi0] a=1.2 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a1.2_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.2
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a1p2_v0p09
EOINI
echo "[abi0] a=1.2 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a1.2_v0.09.ini >> $LOG 2>&1) || echo "[abi0] a=1.2 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.200_*_kz0v3_a1p2_v0p09" >> $LOG 2>&1)
echo "[abi0] a=1.2 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a1.6_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a1p6_v0p03
EOINI
echo "[abi0] a=1.6 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a1.6_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=1.6 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.600_*_kz0v3_a1p6_v0p03" >> $LOG 2>&1)
echo "[abi0] a=1.6 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a1.6_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.6
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a1p6_v0p06
EOINI
echo "[abi0] a=1.6 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a1.6_v0.06.ini >> $LOG 2>&1) || echo "[abi0] a=1.6 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.600_*_kz0v3_a1p6_v0p06" >> $LOG 2>&1)
echo "[abi0] a=1.6 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a1.6_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.6
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a1p6_v0p09
EOINI
echo "[abi0] a=1.6 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a1.6_v0.09.ini >> $LOG 2>&1) || echo "[abi0] a=1.6 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.600_*_kz0v3_a1p6_v0p09" >> $LOG 2>&1)
echo "[abi0] a=1.6 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a2.0_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p0_v0p03
EOINI
echo "[abi0] a=2.0 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a2.0_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000_*_kz0v3_a2p0_v0p03" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a2.0_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p0_v0p06
EOINI
echo "[abi0] a=2.0 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a2.0_v0.06.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000_*_kz0v3_a2p0_v0p06" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a2.0_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p0_v0p09
EOINI
echo "[abi0] a=2.0 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a2.0_v0.09.ini >> $LOG 2>&1) || echo "[abi0] a=2.0 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000_*_kz0v3_a2p0_v0p09" >> $LOG 2>&1)
echo "[abi0] a=2.0 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a2.4_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p4_v0p03
EOINI
echo "[abi0] a=2.4 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a2.4_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=2.4 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.400_*_kz0v3_a2p4_v0p03" >> $LOG 2>&1)
echo "[abi0] a=2.4 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a2.4_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.4
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p4_v0p06
EOINI
echo "[abi0] a=2.4 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a2.4_v0.06.ini >> $LOG 2>&1) || echo "[abi0] a=2.4 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.400_*_kz0v3_a2p4_v0p06" >> $LOG 2>&1)
echo "[abi0] a=2.4 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a2.4_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.4
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p4_v0p09
EOINI
echo "[abi0] a=2.4 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a2.4_v0.09.ini >> $LOG 2>&1) || echo "[abi0] a=2.4 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.400_*_kz0v3_a2p4_v0p09" >> $LOG 2>&1)
echo "[abi0] a=2.4 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a2.8_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p8_v0p03
EOINI
echo "[abi0] a=2.8 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a2.8_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=2.8 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.800_*_kz0v3_a2p8_v0p03" >> $LOG 2>&1)
echo "[abi0] a=2.8 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a2.8_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.8
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p8_v0p06
EOINI
echo "[abi0] a=2.8 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a2.8_v0.06.ini >> $LOG 2>&1) || echo "[abi0] a=2.8 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.800_*_kz0v3_a2p8_v0p06" >> $LOG 2>&1)
echo "[abi0] a=2.8 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a2.8_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.8
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p8_v0p09
EOINI
echo "[abi0] a=2.8 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a2.8_v0.09.ini >> $LOG 2>&1) || echo "[abi0] a=2.8 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.800_*_kz0v3_a2p8_v0p09" >> $LOG 2>&1)
echo "[abi0] a=2.8 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a3.2_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a3p2_v0p03
EOINI
echo "[abi0] a=3.2 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a3.2_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=3.2 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.200_*_kz0v3_a3p2_v0p03" >> $LOG 2>&1)
echo "[abi0] a=3.2 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a3.2_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.2
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a3p2_v0p06
EOINI
echo "[abi0] a=3.2 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a3.2_v0.06.ini >> $LOG 2>&1) || echo "[abi0] a=3.2 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.200_*_kz0v3_a3p2_v0p06" >> $LOG 2>&1)
echo "[abi0] a=3.2 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a3.2_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.2
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a3p2_v0p09
EOINI
echo "[abi0] a=3.2 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a3.2_v0.09.ini >> $LOG 2>&1) || echo "[abi0] a=3.2 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.200_*_kz0v3_a3p2_v0p09" >> $LOG 2>&1)
echo "[abi0] a=3.2 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a3.6_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a3p6_v0p03
EOINI
echo "[abi0] a=3.6 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a3.6_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=3.6 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.600_*_kz0v3_a3p6_v0p03" >> $LOG 2>&1)
echo "[abi0] a=3.6 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a3.6_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.6
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a3p6_v0p06
EOINI
echo "[abi0] a=3.6 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a3.6_v0.06.ini >> $LOG 2>&1) || echo "[abi0] a=3.6 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.600_*_kz0v3_a3p6_v0p06" >> $LOG 2>&1)
echo "[abi0] a=3.6 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a3.6_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.6
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a3p6_v0p09
EOINI
echo "[abi0] a=3.6 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a3.6_v0.09.ini >> $LOG 2>&1) || echo "[abi0] a=3.6 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.600_*_kz0v3_a3p6_v0p09" >> $LOG 2>&1)
echo "[abi0] a=3.6 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a4.0_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p0_v0p03
EOINI
echo "[abi0] a=4.0 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a4.0_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=4.0 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.000_*_kz0v3_a4p0_v0p03" >> $LOG 2>&1)
echo "[abi0] a=4.0 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a4.0_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.0
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p0_v0p06
EOINI
echo "[abi0] a=4.0 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a4.0_v0.06.ini >> $LOG 2>&1) || echo "[abi0] a=4.0 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.000_*_kz0v3_a4p0_v0p06" >> $LOG 2>&1)
echo "[abi0] a=4.0 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a4.0_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.0
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p0_v0p09
EOINI
echo "[abi0] a=4.0 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a4.0_v0.09.ini >> $LOG 2>&1) || echo "[abi0] a=4.0 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.000_*_kz0v3_a4p0_v0p09" >> $LOG 2>&1)
echo "[abi0] a=4.0 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a4.4_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p4_v0p03
EOINI
echo "[abi0] a=4.4 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a4.4_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=4.4 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.400_*_kz0v3_a4p4_v0p03" >> $LOG 2>&1)
echo "[abi0] a=4.4 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a4.4_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.4
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p4_v0p06
EOINI
echo "[abi0] a=4.4 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a4.4_v0.06.ini >> $LOG 2>&1) || echo "[abi0] a=4.4 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.400_*_kz0v3_a4p4_v0p06" >> $LOG 2>&1)
echo "[abi0] a=4.4 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a4.4_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.4
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p4_v0p09
EOINI
echo "[abi0] a=4.4 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a4.4_v0.09.ini >> $LOG 2>&1) || echo "[abi0] a=4.4 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.400_*_kz0v3_a4p4_v0p09" >> $LOG 2>&1)
echo "[abi0] a=4.4 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a4.8_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p8_v0p03
EOINI
echo "[abi0] a=4.8 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a4.8_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=4.8 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.800_*_kz0v3_a4p8_v0p03" >> $LOG 2>&1)
echo "[abi0] a=4.8 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a4.8_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.8
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p8_v0p06
EOINI
echo "[abi0] a=4.8 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a4.8_v0.06.ini >> $LOG 2>&1) || echo "[abi0] a=4.8 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.800_*_kz0v3_a4p8_v0p06" >> $LOG 2>&1)
echo "[abi0] a=4.8 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a4.8_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.8
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p8_v0p09
EOINI
echo "[abi0] a=4.8 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a4.8_v0.09.ini >> $LOG 2>&1) || echo "[abi0] a=4.8 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.800_*_kz0v3_a4p8_v0p09" >> $LOG 2>&1)
echo "[abi0] a=4.8 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a5.2_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a5p2_v0p03
EOINI
echo "[abi0] a=5.2 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a5.2_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=5.2 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.200_*_kz0v3_a5p2_v0p03" >> $LOG 2>&1)
echo "[abi0] a=5.2 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a5.2_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.2
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a5p2_v0p06
EOINI
echo "[abi0] a=5.2 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a5.2_v0.06.ini >> $LOG 2>&1) || echo "[abi0] a=5.2 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.200_*_kz0v3_a5p2_v0p06" >> $LOG 2>&1)
echo "[abi0] a=5.2 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a5.2_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.2
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a5p2_v0p09
EOINI
echo "[abi0] a=5.2 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a5.2_v0.09.ini >> $LOG 2>&1) || echo "[abi0] a=5.2 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.200_*_kz0v3_a5p2_v0p09" >> $LOG 2>&1)
echo "[abi0] a=5.2 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a5.6_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a5p6_v0p03
EOINI
echo "[abi0] a=5.6 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a5.6_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=5.6 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.600_*_kz0v3_a5p6_v0p03" >> $LOG 2>&1)
echo "[abi0] a=5.6 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a5.6_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.6
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a5p6_v0p06
EOINI
echo "[abi0] a=5.6 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a5.6_v0.06.ini >> $LOG 2>&1) || echo "[abi0] a=5.6 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.600_*_kz0v3_a5p6_v0p06" >> $LOG 2>&1)
echo "[abi0] a=5.6 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a5.6_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.6
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a5p6_v0p09
EOINI
echo "[abi0] a=5.6 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a5.6_v0.09.ini >> $LOG 2>&1) || echo "[abi0] a=5.6 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.600_*_kz0v3_a5p6_v0p09" >> $LOG 2>&1)
echo "[abi0] a=5.6 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a6.0_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p0_v0p03
EOINI
echo "[abi0] a=6.0 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a6.0_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=6.0 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.000_*_kz0v3_a6p0_v0p03" >> $LOG 2>&1)
echo "[abi0] a=6.0 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a6.0_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.0
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p0_v0p06
EOINI
echo "[abi0] a=6.0 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a6.0_v0.06.ini >> $LOG 2>&1) || echo "[abi0] a=6.0 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.000_*_kz0v3_a6p0_v0p06" >> $LOG 2>&1)
echo "[abi0] a=6.0 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a6.0_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.0
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p0_v0p09
EOINI
echo "[abi0] a=6.0 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a6.0_v0.09.ini >> $LOG 2>&1) || echo "[abi0] a=6.0 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.000_*_kz0v3_a6p0_v0p09" >> $LOG 2>&1)
echo "[abi0] a=6.0 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a6.4_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p4_v0p03
EOINI
echo "[abi0] a=6.4 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a6.4_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=6.4 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.400_*_kz0v3_a6p4_v0p03" >> $LOG 2>&1)
echo "[abi0] a=6.4 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a6.4_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.4
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p4_v0p06
EOINI
echo "[abi0] a=6.4 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a6.4_v0.06.ini >> $LOG 2>&1) || echo "[abi0] a=6.4 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.400_*_kz0v3_a6p4_v0p06" >> $LOG 2>&1)
echo "[abi0] a=6.4 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a6.4_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.4
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p4_v0p09
EOINI
echo "[abi0] a=6.4 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a6.4_v0.09.ini >> $LOG 2>&1) || echo "[abi0] a=6.4 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.400_*_kz0v3_a6p4_v0p09" >> $LOG 2>&1)
echo "[abi0] a=6.4 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a6.8_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p8_v0p03
EOINI
echo "[abi0] a=6.8 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a6.8_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=6.8 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.800_*_kz0v3_a6p8_v0p03" >> $LOG 2>&1)
echo "[abi0] a=6.8 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a6.8_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.8
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p8_v0p06
EOINI
echo "[abi0] a=6.8 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a6.8_v0.06.ini >> $LOG 2>&1) || echo "[abi0] a=6.8 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.800_*_kz0v3_a6p8_v0p06" >> $LOG 2>&1)
echo "[abi0] a=6.8 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a6.8_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.8
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p8_v0p09
EOINI
echo "[abi0] a=6.8 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a6.8_v0.09.ini >> $LOG 2>&1) || echo "[abi0] a=6.8 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.800_*_kz0v3_a6p8_v0p09" >> $LOG 2>&1)
echo "[abi0] a=6.8 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a7.2_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 7.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a7p2_v0p03
EOINI
echo "[abi0] a=7.2 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a7.2_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=7.2 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a7.200_*_kz0v3_a7p2_v0p03" >> $LOG 2>&1)
echo "[abi0] a=7.2 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a7.2_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 7.2
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a7p2_v0p06
EOINI
echo "[abi0] a=7.2 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a7.2_v0.06.ini >> $LOG 2>&1) || echo "[abi0] a=7.2 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a7.200_*_kz0v3_a7p2_v0p06" >> $LOG 2>&1)
echo "[abi0] a=7.2 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a7.2_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 7.2
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a7p2_v0p09
EOINI
echo "[abi0] a=7.2 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a7.2_v0.09.ini >> $LOG 2>&1) || echo "[abi0] a=7.2 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a7.200_*_kz0v3_a7p2_v0p09" >> $LOG 2>&1)
echo "[abi0] a=7.2 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a7.6_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 7.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a7p6_v0p03
EOINI
echo "[abi0] a=7.6 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a7.6_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=7.6 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a7.600_*_kz0v3_a7p6_v0p03" >> $LOG 2>&1)
echo "[abi0] a=7.6 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a7.6_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 7.6
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a7p6_v0p06
EOINI
echo "[abi0] a=7.6 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a7.6_v0.06.ini >> $LOG 2>&1) || echo "[abi0] a=7.6 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a7.600_*_kz0v3_a7p6_v0p06" >> $LOG 2>&1)
echo "[abi0] a=7.6 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a7.6_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 7.6
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a7p6_v0p09
EOINI
echo "[abi0] a=7.6 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a7.6_v0.09.ini >> $LOG 2>&1) || echo "[abi0] a=7.6 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a7.600_*_kz0v3_a7p6_v0p09" >> $LOG 2>&1)
echo "[abi0] a=7.6 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a8.0_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 8.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a8p0_v0p03
EOINI
echo "[abi0] a=8.0 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a8.0_v0.03.ini >> $LOG 2>&1) || echo "[abi0] a=8.0 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a8.000_*_kz0v3_a8p0_v0p03" >> $LOG 2>&1)
echo "[abi0] a=8.0 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a8.0_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 8.0
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a8p0_v0p06
EOINI
echo "[abi0] a=8.0 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a8.0_v0.06.ini >> $LOG 2>&1) || echo "[abi0] a=8.0 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a8.000_*_kz0v3_a8p0_v0p06" >> $LOG 2>&1)
echo "[abi0] a=8.0 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi0_a8.0_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 8.0
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a8p0_v0p09
EOINI
echo "[abi0] a=8.0 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi0_a8.0_v0.09.ini >> $LOG 2>&1) || echo "[abi0] a=8.0 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a8.000_*_kz0v3_a8p0_v0p09" >> $LOG 2>&1)
echo "[abi0] a=8.0 V0=0.09 kz=0(noise) done $(date)" >> $LOG

    echo "=== abi0 ALL DONE $(date) ===" >> $LOG
}

run_gpu1() {
    export CUDA_VISIBLE_DEVICES=1
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/kz0v3_abi1_progress.log
    echo "=== kz0v3 abi1 start $(date) ===" >> $LOG
# ---- smoke test: NAB_DTANH binary + noise-driven kz=0 extractor ----
cat > /tmp/kz0v3_smoke_abi1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 2e-4
target_tu = 50
run_tag = smokev3abi1
EOINI
rm -rf $WDIR/outputs/ym_k1_a2.000*smokev3abi1*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_smoke_abi1.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000*smokev3abi1" >> $LOG 2>&1)
python3 - "$WDIR" abi1 <<'EOPY' >> $LOG 2>&1 || { echo "[abi1] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k1_a2.000*smokev3" + stream + "*/timeseries_k0.csv")
assert fs, "smoke: no timeseries_k0.csv written (extract_kz0_noise.py or run_mode=3 path broken)"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert len(rows) >= 5, "smoke: too few rows (%d)" % len(rows)
amps = [float(r['amp']) for r in rows]
assert amps[-1] > amps[0], "smoke: kz=0 amplitude did not grow at all over 50 TU (amp0=%.3e ampf=%.3e)" % (amps[0], amps[-1])
print("[%s] smoke test OK (kz0v3 grid, NAB_DTANH + noise-driven kz=0 extraction): amp0=%.3e ampf=%.3e" % (stream, amps[0], amps[-1]))
EOPY
rm -rf $WDIR/outputs/ym_k1_a2.000*smokev3abi1*

cat > /tmp/kz0v3_abi1_a0.4_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.4
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a0p4_v0p04
EOINI
echo "[abi1] a=0.4 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a0.4_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=0.4 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.400_*_kz0v3_a0p4_v0p04" >> $LOG 2>&1)
echo "[abi1] a=0.4 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a0.4_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.4
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a0p4_v0p07
EOINI
echo "[abi1] a=0.4 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a0.4_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=0.4 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.400_*_kz0v3_a0p4_v0p07" >> $LOG 2>&1)
echo "[abi1] a=0.4 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a0.4_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a0p4_v0p1
EOINI
echo "[abi1] a=0.4 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a0.4_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=0.4 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.400_*_kz0v3_a0p4_v0p1" >> $LOG 2>&1)
echo "[abi1] a=0.4 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a0.8_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a0p8_v0p04
EOINI
echo "[abi1] a=0.8 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a0.8_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=0.8 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.800_*_kz0v3_a0p8_v0p04" >> $LOG 2>&1)
echo "[abi1] a=0.8 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a0.8_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a0p8_v0p07
EOINI
echo "[abi1] a=0.8 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a0.8_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=0.8 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.800_*_kz0v3_a0p8_v0p07" >> $LOG 2>&1)
echo "[abi1] a=0.8 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a0.8_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a0p8_v0p1
EOINI
echo "[abi1] a=0.8 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a0.8_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=0.8 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.800_*_kz0v3_a0p8_v0p1" >> $LOG 2>&1)
echo "[abi1] a=0.8 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a1.2_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.2
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a1p2_v0p04
EOINI
echo "[abi1] a=1.2 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a1.2_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=1.2 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.200_*_kz0v3_a1p2_v0p04" >> $LOG 2>&1)
echo "[abi1] a=1.2 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a1.2_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.2
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a1p2_v0p07
EOINI
echo "[abi1] a=1.2 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a1.2_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=1.2 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.200_*_kz0v3_a1p2_v0p07" >> $LOG 2>&1)
echo "[abi1] a=1.2 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a1.2_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a1p2_v0p1
EOINI
echo "[abi1] a=1.2 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a1.2_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=1.2 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.200_*_kz0v3_a1p2_v0p1" >> $LOG 2>&1)
echo "[abi1] a=1.2 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a1.6_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.6
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a1p6_v0p04
EOINI
echo "[abi1] a=1.6 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a1.6_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=1.6 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.600_*_kz0v3_a1p6_v0p04" >> $LOG 2>&1)
echo "[abi1] a=1.6 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a1.6_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.6
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a1p6_v0p07
EOINI
echo "[abi1] a=1.6 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a1.6_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=1.6 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.600_*_kz0v3_a1p6_v0p07" >> $LOG 2>&1)
echo "[abi1] a=1.6 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a1.6_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a1p6_v0p1
EOINI
echo "[abi1] a=1.6 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a1.6_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=1.6 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.600_*_kz0v3_a1p6_v0p1" >> $LOG 2>&1)
echo "[abi1] a=1.6 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a2.0_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p0_v0p04
EOINI
echo "[abi1] a=2.0 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a2.0_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=2.0 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000_*_kz0v3_a2p0_v0p04" >> $LOG 2>&1)
echo "[abi1] a=2.0 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a2.0_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p0_v0p07
EOINI
echo "[abi1] a=2.0 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a2.0_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=2.0 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000_*_kz0v3_a2p0_v0p07" >> $LOG 2>&1)
echo "[abi1] a=2.0 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a2.0_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p0_v0p1
EOINI
echo "[abi1] a=2.0 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a2.0_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=2.0 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000_*_kz0v3_a2p0_v0p1" >> $LOG 2>&1)
echo "[abi1] a=2.0 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a2.4_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.4
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p4_v0p04
EOINI
echo "[abi1] a=2.4 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a2.4_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=2.4 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.400_*_kz0v3_a2p4_v0p04" >> $LOG 2>&1)
echo "[abi1] a=2.4 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a2.4_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.4
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p4_v0p07
EOINI
echo "[abi1] a=2.4 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a2.4_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=2.4 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.400_*_kz0v3_a2p4_v0p07" >> $LOG 2>&1)
echo "[abi1] a=2.4 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a2.4_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p4_v0p1
EOINI
echo "[abi1] a=2.4 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a2.4_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=2.4 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.400_*_kz0v3_a2p4_v0p1" >> $LOG 2>&1)
echo "[abi1] a=2.4 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a2.8_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.8
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p8_v0p04
EOINI
echo "[abi1] a=2.8 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a2.8_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=2.8 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.800_*_kz0v3_a2p8_v0p04" >> $LOG 2>&1)
echo "[abi1] a=2.8 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a2.8_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.8
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p8_v0p07
EOINI
echo "[abi1] a=2.8 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a2.8_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=2.8 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.800_*_kz0v3_a2p8_v0p07" >> $LOG 2>&1)
echo "[abi1] a=2.8 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a2.8_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p8_v0p1
EOINI
echo "[abi1] a=2.8 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a2.8_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=2.8 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.800_*_kz0v3_a2p8_v0p1" >> $LOG 2>&1)
echo "[abi1] a=2.8 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a3.2_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.2
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a3p2_v0p04
EOINI
echo "[abi1] a=3.2 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a3.2_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=3.2 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.200_*_kz0v3_a3p2_v0p04" >> $LOG 2>&1)
echo "[abi1] a=3.2 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a3.2_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.2
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a3p2_v0p07
EOINI
echo "[abi1] a=3.2 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a3.2_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=3.2 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.200_*_kz0v3_a3p2_v0p07" >> $LOG 2>&1)
echo "[abi1] a=3.2 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a3.2_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a3p2_v0p1
EOINI
echo "[abi1] a=3.2 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a3.2_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=3.2 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.200_*_kz0v3_a3p2_v0p1" >> $LOG 2>&1)
echo "[abi1] a=3.2 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a3.6_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.6
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a3p6_v0p04
EOINI
echo "[abi1] a=3.6 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a3.6_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=3.6 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.600_*_kz0v3_a3p6_v0p04" >> $LOG 2>&1)
echo "[abi1] a=3.6 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a3.6_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.6
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a3p6_v0p07
EOINI
echo "[abi1] a=3.6 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a3.6_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=3.6 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.600_*_kz0v3_a3p6_v0p07" >> $LOG 2>&1)
echo "[abi1] a=3.6 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a3.6_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a3p6_v0p1
EOINI
echo "[abi1] a=3.6 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a3.6_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=3.6 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.600_*_kz0v3_a3p6_v0p1" >> $LOG 2>&1)
echo "[abi1] a=3.6 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a4.0_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.0
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p0_v0p04
EOINI
echo "[abi1] a=4.0 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a4.0_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=4.0 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.000_*_kz0v3_a4p0_v0p04" >> $LOG 2>&1)
echo "[abi1] a=4.0 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a4.0_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.0
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p0_v0p07
EOINI
echo "[abi1] a=4.0 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a4.0_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=4.0 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.000_*_kz0v3_a4p0_v0p07" >> $LOG 2>&1)
echo "[abi1] a=4.0 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a4.0_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p0_v0p1
EOINI
echo "[abi1] a=4.0 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a4.0_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=4.0 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.000_*_kz0v3_a4p0_v0p1" >> $LOG 2>&1)
echo "[abi1] a=4.0 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a4.4_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.4
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p4_v0p04
EOINI
echo "[abi1] a=4.4 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a4.4_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=4.4 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.400_*_kz0v3_a4p4_v0p04" >> $LOG 2>&1)
echo "[abi1] a=4.4 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a4.4_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.4
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p4_v0p07
EOINI
echo "[abi1] a=4.4 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a4.4_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=4.4 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.400_*_kz0v3_a4p4_v0p07" >> $LOG 2>&1)
echo "[abi1] a=4.4 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a4.4_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p4_v0p1
EOINI
echo "[abi1] a=4.4 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a4.4_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=4.4 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.400_*_kz0v3_a4p4_v0p1" >> $LOG 2>&1)
echo "[abi1] a=4.4 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a4.8_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.8
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p8_v0p04
EOINI
echo "[abi1] a=4.8 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a4.8_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=4.8 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.800_*_kz0v3_a4p8_v0p04" >> $LOG 2>&1)
echo "[abi1] a=4.8 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a4.8_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.8
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p8_v0p07
EOINI
echo "[abi1] a=4.8 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a4.8_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=4.8 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.800_*_kz0v3_a4p8_v0p07" >> $LOG 2>&1)
echo "[abi1] a=4.8 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a4.8_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p8_v0p1
EOINI
echo "[abi1] a=4.8 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a4.8_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=4.8 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.800_*_kz0v3_a4p8_v0p1" >> $LOG 2>&1)
echo "[abi1] a=4.8 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a5.2_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.2
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a5p2_v0p04
EOINI
echo "[abi1] a=5.2 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a5.2_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=5.2 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.200_*_kz0v3_a5p2_v0p04" >> $LOG 2>&1)
echo "[abi1] a=5.2 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a5.2_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.2
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a5p2_v0p07
EOINI
echo "[abi1] a=5.2 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a5.2_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=5.2 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.200_*_kz0v3_a5p2_v0p07" >> $LOG 2>&1)
echo "[abi1] a=5.2 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a5.2_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a5p2_v0p1
EOINI
echo "[abi1] a=5.2 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a5.2_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=5.2 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.200_*_kz0v3_a5p2_v0p1" >> $LOG 2>&1)
echo "[abi1] a=5.2 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a5.6_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.6
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a5p6_v0p04
EOINI
echo "[abi1] a=5.6 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a5.6_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=5.6 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.600_*_kz0v3_a5p6_v0p04" >> $LOG 2>&1)
echo "[abi1] a=5.6 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a5.6_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.6
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a5p6_v0p07
EOINI
echo "[abi1] a=5.6 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a5.6_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=5.6 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.600_*_kz0v3_a5p6_v0p07" >> $LOG 2>&1)
echo "[abi1] a=5.6 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a5.6_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a5p6_v0p1
EOINI
echo "[abi1] a=5.6 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a5.6_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=5.6 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.600_*_kz0v3_a5p6_v0p1" >> $LOG 2>&1)
echo "[abi1] a=5.6 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a6.0_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.0
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p0_v0p04
EOINI
echo "[abi1] a=6.0 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a6.0_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=6.0 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.000_*_kz0v3_a6p0_v0p04" >> $LOG 2>&1)
echo "[abi1] a=6.0 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a6.0_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.0
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p0_v0p07
EOINI
echo "[abi1] a=6.0 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a6.0_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=6.0 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.000_*_kz0v3_a6p0_v0p07" >> $LOG 2>&1)
echo "[abi1] a=6.0 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a6.0_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p0_v0p1
EOINI
echo "[abi1] a=6.0 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a6.0_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=6.0 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.000_*_kz0v3_a6p0_v0p1" >> $LOG 2>&1)
echo "[abi1] a=6.0 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a6.4_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.4
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p4_v0p04
EOINI
echo "[abi1] a=6.4 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a6.4_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=6.4 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.400_*_kz0v3_a6p4_v0p04" >> $LOG 2>&1)
echo "[abi1] a=6.4 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a6.4_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.4
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p4_v0p07
EOINI
echo "[abi1] a=6.4 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a6.4_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=6.4 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.400_*_kz0v3_a6p4_v0p07" >> $LOG 2>&1)
echo "[abi1] a=6.4 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a6.4_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p4_v0p1
EOINI
echo "[abi1] a=6.4 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a6.4_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=6.4 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.400_*_kz0v3_a6p4_v0p1" >> $LOG 2>&1)
echo "[abi1] a=6.4 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a6.8_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.8
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p8_v0p04
EOINI
echo "[abi1] a=6.8 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a6.8_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=6.8 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.800_*_kz0v3_a6p8_v0p04" >> $LOG 2>&1)
echo "[abi1] a=6.8 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a6.8_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.8
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p8_v0p07
EOINI
echo "[abi1] a=6.8 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a6.8_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=6.8 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.800_*_kz0v3_a6p8_v0p07" >> $LOG 2>&1)
echo "[abi1] a=6.8 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a6.8_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p8_v0p1
EOINI
echo "[abi1] a=6.8 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a6.8_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=6.8 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.800_*_kz0v3_a6p8_v0p1" >> $LOG 2>&1)
echo "[abi1] a=6.8 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a7.2_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 7.2
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a7p2_v0p04
EOINI
echo "[abi1] a=7.2 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a7.2_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=7.2 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a7.200_*_kz0v3_a7p2_v0p04" >> $LOG 2>&1)
echo "[abi1] a=7.2 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a7.2_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 7.2
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a7p2_v0p07
EOINI
echo "[abi1] a=7.2 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a7.2_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=7.2 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a7.200_*_kz0v3_a7p2_v0p07" >> $LOG 2>&1)
echo "[abi1] a=7.2 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a7.2_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 7.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a7p2_v0p1
EOINI
echo "[abi1] a=7.2 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a7.2_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=7.2 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a7.200_*_kz0v3_a7p2_v0p1" >> $LOG 2>&1)
echo "[abi1] a=7.2 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a7.6_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 7.6
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a7p6_v0p04
EOINI
echo "[abi1] a=7.6 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a7.6_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=7.6 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a7.600_*_kz0v3_a7p6_v0p04" >> $LOG 2>&1)
echo "[abi1] a=7.6 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a7.6_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 7.6
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a7p6_v0p07
EOINI
echo "[abi1] a=7.6 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a7.6_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=7.6 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a7.600_*_kz0v3_a7p6_v0p07" >> $LOG 2>&1)
echo "[abi1] a=7.6 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a7.6_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 7.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a7p6_v0p1
EOINI
echo "[abi1] a=7.6 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a7.6_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=7.6 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a7.600_*_kz0v3_a7p6_v0p1" >> $LOG 2>&1)
echo "[abi1] a=7.6 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a8.0_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 8.0
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a8p0_v0p04
EOINI
echo "[abi1] a=8.0 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a8.0_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=8.0 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a8.000_*_kz0v3_a8p0_v0p04" >> $LOG 2>&1)
echo "[abi1] a=8.0 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a8.0_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 8.0
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a8p0_v0p07
EOINI
echo "[abi1] a=8.0 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a8.0_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=8.0 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a8.000_*_kz0v3_a8p0_v0p07" >> $LOG 2>&1)
echo "[abi1] a=8.0 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi1_a8.0_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 8.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a8p0_v0p1
EOINI
echo "[abi1] a=8.0 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi1_a8.0_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=8.0 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a8.000_*_kz0v3_a8p0_v0p1" >> $LOG 2>&1)
echo "[abi1] a=8.0 V0=0.1 kz=0(noise) done $(date)" >> $LOG

    echo "=== abi1 ALL DONE $(date) ===" >> $LOG
}

run_gpu2() {
    export CUDA_VISIBLE_DEVICES=2
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/kz0v3_abi2_progress.log
    echo "=== kz0v3 abi2 start $(date) ===" >> $LOG
# ---- smoke test: NAB_DTANH binary + noise-driven kz=0 extractor ----
cat > /tmp/kz0v3_smoke_abi2.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 2e-4
target_tu = 50
run_tag = smokev3abi2
EOINI
rm -rf $WDIR/outputs/ym_k1_a2.000*smokev3abi2*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_smoke_abi2.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000*smokev3abi2" >> $LOG 2>&1)
python3 - "$WDIR" abi2 <<'EOPY' >> $LOG 2>&1 || { echo "[abi2] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k1_a2.000*smokev3" + stream + "*/timeseries_k0.csv")
assert fs, "smoke: no timeseries_k0.csv written (extract_kz0_noise.py or run_mode=3 path broken)"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert len(rows) >= 5, "smoke: too few rows (%d)" % len(rows)
amps = [float(r['amp']) for r in rows]
assert amps[-1] > amps[0], "smoke: kz=0 amplitude did not grow at all over 50 TU (amp0=%.3e ampf=%.3e)" % (amps[0], amps[-1])
print("[%s] smoke test OK (kz0v3 grid, NAB_DTANH + noise-driven kz=0 extraction): amp0=%.3e ampf=%.3e" % (stream, amps[0], amps[-1]))
EOPY
rm -rf $WDIR/outputs/ym_k1_a2.000*smokev3abi2*

cat > /tmp/kz0v3_abi2_a0.4_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a0p4_v0p05
EOINI
echo "[abi2] a=0.4 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a0.4_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=0.4 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.400_*_kz0v3_a0p4_v0p05" >> $LOG 2>&1)
echo "[abi2] a=0.4 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a0.4_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.4
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a0p4_v0p08
EOINI
echo "[abi2] a=0.4 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a0.4_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=0.4 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.400_*_kz0v3_a0p4_v0p08" >> $LOG 2>&1)
echo "[abi2] a=0.4 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a0.4_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a0p4_v0p2
EOINI
echo "[abi2] a=0.4 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a0.4_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=0.4 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.400_*_kz0v3_a0p4_v0p2" >> $LOG 2>&1)
echo "[abi2] a=0.4 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a0.8_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a0p8_v0p05
EOINI
echo "[abi2] a=0.8 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a0.8_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=0.8 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.800_*_kz0v3_a0p8_v0p05" >> $LOG 2>&1)
echo "[abi2] a=0.8 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a0.8_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a0p8_v0p08
EOINI
echo "[abi2] a=0.8 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a0.8_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=0.8 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.800_*_kz0v3_a0p8_v0p08" >> $LOG 2>&1)
echo "[abi2] a=0.8 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a0.8_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 0.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a0p8_v0p2
EOINI
echo "[abi2] a=0.8 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a0.8_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=0.8 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a0.800_*_kz0v3_a0p8_v0p2" >> $LOG 2>&1)
echo "[abi2] a=0.8 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a1.2_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a1p2_v0p05
EOINI
echo "[abi2] a=1.2 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a1.2_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=1.2 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.200_*_kz0v3_a1p2_v0p05" >> $LOG 2>&1)
echo "[abi2] a=1.2 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a1.2_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.2
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a1p2_v0p08
EOINI
echo "[abi2] a=1.2 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a1.2_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=1.2 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.200_*_kz0v3_a1p2_v0p08" >> $LOG 2>&1)
echo "[abi2] a=1.2 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a1.2_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a1p2_v0p2
EOINI
echo "[abi2] a=1.2 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a1.2_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=1.2 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.200_*_kz0v3_a1p2_v0p2" >> $LOG 2>&1)
echo "[abi2] a=1.2 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a1.6_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a1p6_v0p05
EOINI
echo "[abi2] a=1.6 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a1.6_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=1.6 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.600_*_kz0v3_a1p6_v0p05" >> $LOG 2>&1)
echo "[abi2] a=1.6 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a1.6_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.6
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a1p6_v0p08
EOINI
echo "[abi2] a=1.6 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a1.6_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=1.6 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.600_*_kz0v3_a1p6_v0p08" >> $LOG 2>&1)
echo "[abi2] a=1.6 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a1.6_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a1p6_v0p2
EOINI
echo "[abi2] a=1.6 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a1.6_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=1.6 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.600_*_kz0v3_a1p6_v0p2" >> $LOG 2>&1)
echo "[abi2] a=1.6 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a2.0_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p0_v0p05
EOINI
echo "[abi2] a=2.0 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a2.0_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=2.0 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000_*_kz0v3_a2p0_v0p05" >> $LOG 2>&1)
echo "[abi2] a=2.0 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a2.0_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p0_v0p08
EOINI
echo "[abi2] a=2.0 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a2.0_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=2.0 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000_*_kz0v3_a2p0_v0p08" >> $LOG 2>&1)
echo "[abi2] a=2.0 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a2.0_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p0_v0p2
EOINI
echo "[abi2] a=2.0 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a2.0_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=2.0 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000_*_kz0v3_a2p0_v0p2" >> $LOG 2>&1)
echo "[abi2] a=2.0 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a2.4_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p4_v0p05
EOINI
echo "[abi2] a=2.4 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a2.4_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=2.4 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.400_*_kz0v3_a2p4_v0p05" >> $LOG 2>&1)
echo "[abi2] a=2.4 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a2.4_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.4
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p4_v0p08
EOINI
echo "[abi2] a=2.4 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a2.4_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=2.4 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.400_*_kz0v3_a2p4_v0p08" >> $LOG 2>&1)
echo "[abi2] a=2.4 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a2.4_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p4_v0p2
EOINI
echo "[abi2] a=2.4 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a2.4_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=2.4 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.400_*_kz0v3_a2p4_v0p2" >> $LOG 2>&1)
echo "[abi2] a=2.4 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a2.8_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p8_v0p05
EOINI
echo "[abi2] a=2.8 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a2.8_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=2.8 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.800_*_kz0v3_a2p8_v0p05" >> $LOG 2>&1)
echo "[abi2] a=2.8 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a2.8_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.8
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p8_v0p08
EOINI
echo "[abi2] a=2.8 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a2.8_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=2.8 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.800_*_kz0v3_a2p8_v0p08" >> $LOG 2>&1)
echo "[abi2] a=2.8 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a2.8_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a2p8_v0p2
EOINI
echo "[abi2] a=2.8 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a2.8_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=2.8 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.800_*_kz0v3_a2p8_v0p2" >> $LOG 2>&1)
echo "[abi2] a=2.8 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a3.2_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a3p2_v0p05
EOINI
echo "[abi2] a=3.2 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a3.2_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=3.2 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.200_*_kz0v3_a3p2_v0p05" >> $LOG 2>&1)
echo "[abi2] a=3.2 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a3.2_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.2
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a3p2_v0p08
EOINI
echo "[abi2] a=3.2 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a3.2_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=3.2 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.200_*_kz0v3_a3p2_v0p08" >> $LOG 2>&1)
echo "[abi2] a=3.2 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a3.2_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a3p2_v0p2
EOINI
echo "[abi2] a=3.2 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a3.2_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=3.2 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.200_*_kz0v3_a3p2_v0p2" >> $LOG 2>&1)
echo "[abi2] a=3.2 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a3.6_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a3p6_v0p05
EOINI
echo "[abi2] a=3.6 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a3.6_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=3.6 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.600_*_kz0v3_a3p6_v0p05" >> $LOG 2>&1)
echo "[abi2] a=3.6 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a3.6_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.6
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a3p6_v0p08
EOINI
echo "[abi2] a=3.6 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a3.6_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=3.6 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.600_*_kz0v3_a3p6_v0p08" >> $LOG 2>&1)
echo "[abi2] a=3.6 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a3.6_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a3p6_v0p2
EOINI
echo "[abi2] a=3.6 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a3.6_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=3.6 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.600_*_kz0v3_a3p6_v0p2" >> $LOG 2>&1)
echo "[abi2] a=3.6 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a4.0_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p0_v0p05
EOINI
echo "[abi2] a=4.0 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a4.0_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=4.0 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.000_*_kz0v3_a4p0_v0p05" >> $LOG 2>&1)
echo "[abi2] a=4.0 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a4.0_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p0_v0p08
EOINI
echo "[abi2] a=4.0 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a4.0_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=4.0 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.000_*_kz0v3_a4p0_v0p08" >> $LOG 2>&1)
echo "[abi2] a=4.0 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a4.0_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p0_v0p2
EOINI
echo "[abi2] a=4.0 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a4.0_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=4.0 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.000_*_kz0v3_a4p0_v0p2" >> $LOG 2>&1)
echo "[abi2] a=4.0 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a4.4_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p4_v0p05
EOINI
echo "[abi2] a=4.4 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a4.4_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=4.4 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.400_*_kz0v3_a4p4_v0p05" >> $LOG 2>&1)
echo "[abi2] a=4.4 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a4.4_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.4
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p4_v0p08
EOINI
echo "[abi2] a=4.4 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a4.4_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=4.4 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.400_*_kz0v3_a4p4_v0p08" >> $LOG 2>&1)
echo "[abi2] a=4.4 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a4.4_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p4_v0p2
EOINI
echo "[abi2] a=4.4 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a4.4_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=4.4 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.400_*_kz0v3_a4p4_v0p2" >> $LOG 2>&1)
echo "[abi2] a=4.4 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a4.8_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p8_v0p05
EOINI
echo "[abi2] a=4.8 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a4.8_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=4.8 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.800_*_kz0v3_a4p8_v0p05" >> $LOG 2>&1)
echo "[abi2] a=4.8 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a4.8_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.8
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p8_v0p08
EOINI
echo "[abi2] a=4.8 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a4.8_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=4.8 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.800_*_kz0v3_a4p8_v0p08" >> $LOG 2>&1)
echo "[abi2] a=4.8 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a4.8_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a4p8_v0p2
EOINI
echo "[abi2] a=4.8 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a4.8_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=4.8 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.800_*_kz0v3_a4p8_v0p2" >> $LOG 2>&1)
echo "[abi2] a=4.8 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a5.2_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a5p2_v0p05
EOINI
echo "[abi2] a=5.2 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a5.2_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=5.2 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.200_*_kz0v3_a5p2_v0p05" >> $LOG 2>&1)
echo "[abi2] a=5.2 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a5.2_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.2
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a5p2_v0p08
EOINI
echo "[abi2] a=5.2 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a5.2_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=5.2 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.200_*_kz0v3_a5p2_v0p08" >> $LOG 2>&1)
echo "[abi2] a=5.2 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a5.2_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a5p2_v0p2
EOINI
echo "[abi2] a=5.2 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a5.2_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=5.2 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.200_*_kz0v3_a5p2_v0p2" >> $LOG 2>&1)
echo "[abi2] a=5.2 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a5.6_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a5p6_v0p05
EOINI
echo "[abi2] a=5.6 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a5.6_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=5.6 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.600_*_kz0v3_a5p6_v0p05" >> $LOG 2>&1)
echo "[abi2] a=5.6 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a5.6_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.6
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a5p6_v0p08
EOINI
echo "[abi2] a=5.6 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a5.6_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=5.6 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.600_*_kz0v3_a5p6_v0p08" >> $LOG 2>&1)
echo "[abi2] a=5.6 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a5.6_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 5.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a5p6_v0p2
EOINI
echo "[abi2] a=5.6 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a5.6_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=5.6 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a5.600_*_kz0v3_a5p6_v0p2" >> $LOG 2>&1)
echo "[abi2] a=5.6 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a6.0_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p0_v0p05
EOINI
echo "[abi2] a=6.0 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a6.0_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=6.0 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.000_*_kz0v3_a6p0_v0p05" >> $LOG 2>&1)
echo "[abi2] a=6.0 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a6.0_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p0_v0p08
EOINI
echo "[abi2] a=6.0 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a6.0_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=6.0 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.000_*_kz0v3_a6p0_v0p08" >> $LOG 2>&1)
echo "[abi2] a=6.0 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a6.0_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p0_v0p2
EOINI
echo "[abi2] a=6.0 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a6.0_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=6.0 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.000_*_kz0v3_a6p0_v0p2" >> $LOG 2>&1)
echo "[abi2] a=6.0 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a6.4_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p4_v0p05
EOINI
echo "[abi2] a=6.4 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a6.4_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=6.4 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.400_*_kz0v3_a6p4_v0p05" >> $LOG 2>&1)
echo "[abi2] a=6.4 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a6.4_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.4
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p4_v0p08
EOINI
echo "[abi2] a=6.4 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a6.4_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=6.4 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.400_*_kz0v3_a6p4_v0p08" >> $LOG 2>&1)
echo "[abi2] a=6.4 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a6.4_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p4_v0p2
EOINI
echo "[abi2] a=6.4 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a6.4_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=6.4 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.400_*_kz0v3_a6p4_v0p2" >> $LOG 2>&1)
echo "[abi2] a=6.4 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a6.8_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p8_v0p05
EOINI
echo "[abi2] a=6.8 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a6.8_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=6.8 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.800_*_kz0v3_a6p8_v0p05" >> $LOG 2>&1)
echo "[abi2] a=6.8 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a6.8_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.8
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p8_v0p08
EOINI
echo "[abi2] a=6.8 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a6.8_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=6.8 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.800_*_kz0v3_a6p8_v0p08" >> $LOG 2>&1)
echo "[abi2] a=6.8 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a6.8_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 6.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a6p8_v0p2
EOINI
echo "[abi2] a=6.8 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a6.8_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=6.8 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a6.800_*_kz0v3_a6p8_v0p2" >> $LOG 2>&1)
echo "[abi2] a=6.8 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a7.2_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 7.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a7p2_v0p05
EOINI
echo "[abi2] a=7.2 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a7.2_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=7.2 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a7.200_*_kz0v3_a7p2_v0p05" >> $LOG 2>&1)
echo "[abi2] a=7.2 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a7.2_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 7.2
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a7p2_v0p08
EOINI
echo "[abi2] a=7.2 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a7.2_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=7.2 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a7.200_*_kz0v3_a7p2_v0p08" >> $LOG 2>&1)
echo "[abi2] a=7.2 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a7.2_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 7.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a7p2_v0p2
EOINI
echo "[abi2] a=7.2 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a7.2_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=7.2 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a7.200_*_kz0v3_a7p2_v0p2" >> $LOG 2>&1)
echo "[abi2] a=7.2 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a7.6_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 7.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a7p6_v0p05
EOINI
echo "[abi2] a=7.6 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a7.6_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=7.6 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a7.600_*_kz0v3_a7p6_v0p05" >> $LOG 2>&1)
echo "[abi2] a=7.6 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a7.6_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 7.6
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a7p6_v0p08
EOINI
echo "[abi2] a=7.6 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a7.6_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=7.6 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a7.600_*_kz0v3_a7p6_v0p08" >> $LOG 2>&1)
echo "[abi2] a=7.6 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a7.6_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 7.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a7p6_v0p2
EOINI
echo "[abi2] a=7.6 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a7.6_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=7.6 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a7.600_*_kz0v3_a7p6_v0p2" >> $LOG 2>&1)
echo "[abi2] a=7.6 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a8.0_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 8.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a8p0_v0p05
EOINI
echo "[abi2] a=8.0 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a8.0_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=8.0 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a8.000_*_kz0v3_a8p0_v0p05" >> $LOG 2>&1)
echo "[abi2] a=8.0 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a8.0_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 8.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a8p0_v0p08
EOINI
echo "[abi2] a=8.0 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a8.0_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=8.0 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a8.000_*_kz0v3_a8p0_v0p08" >> $LOG 2>&1)
echo "[abi2] a=8.0 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3_abi2_a8.0_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 8.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3_a8p0_v0p2
EOINI
echo "[abi2] a=8.0 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_abi2_a8.0_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=8.0 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a8.000_*_kz0v3_a8p0_v0p2" >> $LOG 2>&1)
echo "[abi2] a=8.0 V0=0.2 kz=0(noise) done $(date)" >> $LOG

    echo "=== abi2 ALL DONE $(date) ===" >> $LOG
}

echo "=== abi: launching 3-GPU kz0v3 coarse grid (180 pts) $(date) ==="
run_gpu0 & PID0=$!
run_gpu1 & PID1=$!
run_gpu2 & PID2=$!
wait $PID0 && echo 'GPU0 finished' || echo 'GPU0 FAILED'
wait $PID1 && echo 'GPU1 finished' || echo 'GPU1 FAILED'
wait $PID2 && echo 'GPU2 finished' || echo 'GPU2 FAILED'
