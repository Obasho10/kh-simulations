#!/bin/bash
# kz=0 deviation-mapping grid v3 -- abi (3 GPUs), fine pass (alpha in [1.6,4.4] step 0.2 valley refinement, 63 pts, staged 2026-07-19)
WDIR=/DATA/s23103/lcpfct/ymgpu2d
mkdir -p $WDIR/logs $WDIR/outputs

run_gpu1() {
    export CUDA_VISIBLE_DEVICES=1
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/kz0v3fine_abi1_progress.log
    echo "=== kz0v3fine abi1 start $(date) ===" >> $LOG
# ---- smoke test: NAB_DTANH binary + noise-driven kz=0 extractor ----
cat > /tmp/kz0v3fine_smoke_abi1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 2e-4
target_tu = 50
run_tag = smokefineabi1
EOINI
rm -rf $WDIR/outputs/ym_k1_a2.000*smokefineabi1*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_smoke_abi1.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000*smokefineabi1" >> $LOG 2>&1)
python3 - "$WDIR" abi1 <<'EOPY' >> $LOG 2>&1 || { echo "[abi1] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k1_a2.000*smokefine" + stream + "*/timeseries_k0.csv")
assert fs, "smoke: no timeseries_k0.csv written"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert len(rows) >= 5, "smoke: too few rows (%d)" % len(rows)
amps = [float(r['amp']) for r in rows]
assert amps[-1] > amps[0], "smoke: kz=0 amplitude did not grow"
print("[%s] smoke test OK (kz0v3fine): amp0=%.3e ampf=%.3e" % (stream, amps[0], amps[-1]))
EOPY
rm -rf $WDIR/outputs/ym_k1_a2.000*smokefineabi1*

cat > /tmp/kz0v3fine_abi1_a1.8_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a1p8_v0p03
EOINI
echo "[abi1] a=1.8 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a1.8_v0.03.ini >> $LOG 2>&1) || echo "[abi1] a=1.8 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.800_*_kz0v3fine_a1p8_v0p03" >> $LOG 2>&1)
echo "[abi1] a=1.8 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a1.8_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a1p8_v0p05
EOINI
echo "[abi1] a=1.8 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a1.8_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=1.8 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.800_*_kz0v3fine_a1p8_v0p05" >> $LOG 2>&1)
echo "[abi1] a=1.8 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a1.8_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.8
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a1p8_v0p07
EOINI
echo "[abi1] a=1.8 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a1.8_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=1.8 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.800_*_kz0v3fine_a1p8_v0p07" >> $LOG 2>&1)
echo "[abi1] a=1.8 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a1.8_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.8
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a1p8_v0p09
EOINI
echo "[abi1] a=1.8 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a1.8_v0.09.ini >> $LOG 2>&1) || echo "[abi1] a=1.8 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.800_*_kz0v3fine_a1p8_v0p09" >> $LOG 2>&1)
echo "[abi1] a=1.8 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a1.8_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a1p8_v0p2
EOINI
echo "[abi1] a=1.8 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a1.8_v0.2.ini >> $LOG 2>&1) || echo "[abi1] a=1.8 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.800_*_kz0v3fine_a1p8_v0p2" >> $LOG 2>&1)
echo "[abi1] a=1.8 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a2.2_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.2
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a2p2_v0p04
EOINI
echo "[abi1] a=2.2 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a2.2_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=2.2 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.200_*_kz0v3fine_a2p2_v0p04" >> $LOG 2>&1)
echo "[abi1] a=2.2 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a2.2_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.2
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a2p2_v0p06
EOINI
echo "[abi1] a=2.2 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a2.2_v0.06.ini >> $LOG 2>&1) || echo "[abi1] a=2.2 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.200_*_kz0v3fine_a2p2_v0p06" >> $LOG 2>&1)
echo "[abi1] a=2.2 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a2.2_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.2
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a2p2_v0p08
EOINI
echo "[abi1] a=2.2 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a2.2_v0.08.ini >> $LOG 2>&1) || echo "[abi1] a=2.2 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.200_*_kz0v3fine_a2p2_v0p08" >> $LOG 2>&1)
echo "[abi1] a=2.2 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a2.2_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a2p2_v0p1
EOINI
echo "[abi1] a=2.2 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a2.2_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=2.2 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.200_*_kz0v3fine_a2p2_v0p1" >> $LOG 2>&1)
echo "[abi1] a=2.2 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a2.6_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.6
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a2p6_v0p03
EOINI
echo "[abi1] a=2.6 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a2.6_v0.03.ini >> $LOG 2>&1) || echo "[abi1] a=2.6 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.600_*_kz0v3fine_a2p6_v0p03" >> $LOG 2>&1)
echo "[abi1] a=2.6 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a2.6_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.6
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a2p6_v0p05
EOINI
echo "[abi1] a=2.6 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a2.6_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=2.6 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.600_*_kz0v3fine_a2p6_v0p05" >> $LOG 2>&1)
echo "[abi1] a=2.6 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a2.6_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.6
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a2p6_v0p07
EOINI
echo "[abi1] a=2.6 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a2.6_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=2.6 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.600_*_kz0v3fine_a2p6_v0p07" >> $LOG 2>&1)
echo "[abi1] a=2.6 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a2.6_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.6
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a2p6_v0p09
EOINI
echo "[abi1] a=2.6 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a2.6_v0.09.ini >> $LOG 2>&1) || echo "[abi1] a=2.6 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.600_*_kz0v3fine_a2p6_v0p09" >> $LOG 2>&1)
echo "[abi1] a=2.6 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a2.6_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.6
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a2p6_v0p2
EOINI
echo "[abi1] a=2.6 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a2.6_v0.2.ini >> $LOG 2>&1) || echo "[abi1] a=2.6 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.600_*_kz0v3fine_a2p6_v0p2" >> $LOG 2>&1)
echo "[abi1] a=2.6 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a3.0_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p0_v0p04
EOINI
echo "[abi1] a=3.0 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a3.0_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=3.0 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.000_*_kz0v3fine_a3p0_v0p04" >> $LOG 2>&1)
echo "[abi1] a=3.0 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a3.0_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p0_v0p06
EOINI
echo "[abi1] a=3.0 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a3.0_v0.06.ini >> $LOG 2>&1) || echo "[abi1] a=3.0 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.000_*_kz0v3fine_a3p0_v0p06" >> $LOG 2>&1)
echo "[abi1] a=3.0 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a3.0_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p0_v0p08
EOINI
echo "[abi1] a=3.0 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a3.0_v0.08.ini >> $LOG 2>&1) || echo "[abi1] a=3.0 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.000_*_kz0v3fine_a3p0_v0p08" >> $LOG 2>&1)
echo "[abi1] a=3.0 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a3.0_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p0_v0p1
EOINI
echo "[abi1] a=3.0 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a3.0_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=3.0 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.000_*_kz0v3fine_a3p0_v0p1" >> $LOG 2>&1)
echo "[abi1] a=3.0 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a3.4_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.4
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p4_v0p03
EOINI
echo "[abi1] a=3.4 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a3.4_v0.03.ini >> $LOG 2>&1) || echo "[abi1] a=3.4 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.400_*_kz0v3fine_a3p4_v0p03" >> $LOG 2>&1)
echo "[abi1] a=3.4 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a3.4_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.4
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p4_v0p05
EOINI
echo "[abi1] a=3.4 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a3.4_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=3.4 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.400_*_kz0v3fine_a3p4_v0p05" >> $LOG 2>&1)
echo "[abi1] a=3.4 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a3.4_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.4
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p4_v0p07
EOINI
echo "[abi1] a=3.4 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a3.4_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=3.4 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.400_*_kz0v3fine_a3p4_v0p07" >> $LOG 2>&1)
echo "[abi1] a=3.4 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a3.4_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.4
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p4_v0p09
EOINI
echo "[abi1] a=3.4 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a3.4_v0.09.ini >> $LOG 2>&1) || echo "[abi1] a=3.4 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.400_*_kz0v3fine_a3p4_v0p09" >> $LOG 2>&1)
echo "[abi1] a=3.4 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a3.4_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.4
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p4_v0p2
EOINI
echo "[abi1] a=3.4 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a3.4_v0.2.ini >> $LOG 2>&1) || echo "[abi1] a=3.4 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.400_*_kz0v3fine_a3p4_v0p2" >> $LOG 2>&1)
echo "[abi1] a=3.4 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a3.8_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.8
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p8_v0p04
EOINI
echo "[abi1] a=3.8 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a3.8_v0.04.ini >> $LOG 2>&1) || echo "[abi1] a=3.8 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.800_*_kz0v3fine_a3p8_v0p04" >> $LOG 2>&1)
echo "[abi1] a=3.8 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a3.8_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.8
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p8_v0p06
EOINI
echo "[abi1] a=3.8 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a3.8_v0.06.ini >> $LOG 2>&1) || echo "[abi1] a=3.8 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.800_*_kz0v3fine_a3p8_v0p06" >> $LOG 2>&1)
echo "[abi1] a=3.8 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a3.8_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.8
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p8_v0p08
EOINI
echo "[abi1] a=3.8 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a3.8_v0.08.ini >> $LOG 2>&1) || echo "[abi1] a=3.8 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.800_*_kz0v3fine_a3p8_v0p08" >> $LOG 2>&1)
echo "[abi1] a=3.8 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a3.8_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p8_v0p1
EOINI
echo "[abi1] a=3.8 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a3.8_v0.1.ini >> $LOG 2>&1) || echo "[abi1] a=3.8 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.800_*_kz0v3fine_a3p8_v0p1" >> $LOG 2>&1)
echo "[abi1] a=3.8 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a4.2_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a4p2_v0p03
EOINI
echo "[abi1] a=4.2 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a4.2_v0.03.ini >> $LOG 2>&1) || echo "[abi1] a=4.2 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.200_*_kz0v3fine_a4p2_v0p03" >> $LOG 2>&1)
echo "[abi1] a=4.2 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a4.2_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a4p2_v0p05
EOINI
echo "[abi1] a=4.2 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a4.2_v0.05.ini >> $LOG 2>&1) || echo "[abi1] a=4.2 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.200_*_kz0v3fine_a4p2_v0p05" >> $LOG 2>&1)
echo "[abi1] a=4.2 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a4.2_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.2
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a4p2_v0p07
EOINI
echo "[abi1] a=4.2 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a4.2_v0.07.ini >> $LOG 2>&1) || echo "[abi1] a=4.2 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.200_*_kz0v3fine_a4p2_v0p07" >> $LOG 2>&1)
echo "[abi1] a=4.2 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a4.2_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.2
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a4p2_v0p09
EOINI
echo "[abi1] a=4.2 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a4.2_v0.09.ini >> $LOG 2>&1) || echo "[abi1] a=4.2 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.200_*_kz0v3fine_a4p2_v0p09" >> $LOG 2>&1)
echo "[abi1] a=4.2 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi1_a4.2_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a4p2_v0p2
EOINI
echo "[abi1] a=4.2 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi1_a4.2_v0.2.ini >> $LOG 2>&1) || echo "[abi1] a=4.2 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.200_*_kz0v3fine_a4p2_v0p2" >> $LOG 2>&1)
echo "[abi1] a=4.2 V0=0.2 kz=0(noise) done $(date)" >> $LOG

    echo "=== abi1 ALL DONE $(date) ===" >> $LOG
}

run_gpu2() {
    export CUDA_VISIBLE_DEVICES=2
    WDIR=/DATA/s23103/lcpfct/ymgpu2d
    LOG=$WDIR/logs/kz0v3fine_abi2_progress.log
    echo "=== kz0v3fine abi2 start $(date) ===" >> $LOG
# ---- smoke test: NAB_DTANH binary + noise-driven kz=0 extractor ----
cat > /tmp/kz0v3fine_smoke_abi2.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 2e-4
target_tu = 50
run_tag = smokefineabi2
EOINI
rm -rf $WDIR/outputs/ym_k1_a2.000*smokefineabi2*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_smoke_abi2.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000*smokefineabi2" >> $LOG 2>&1)
python3 - "$WDIR" abi2 <<'EOPY' >> $LOG 2>&1 || { echo "[abi2] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }
import csv, glob, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k1_a2.000*smokefine" + stream + "*/timeseries_k0.csv")
assert fs, "smoke: no timeseries_k0.csv written"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert len(rows) >= 5, "smoke: too few rows (%d)" % len(rows)
amps = [float(r['amp']) for r in rows]
assert amps[-1] > amps[0], "smoke: kz=0 amplitude did not grow"
print("[%s] smoke test OK (kz0v3fine): amp0=%.3e ampf=%.3e" % (stream, amps[0], amps[-1]))
EOPY
rm -rf $WDIR/outputs/ym_k1_a2.000*smokefineabi2*

cat > /tmp/kz0v3fine_abi2_a1.8_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.8
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a1p8_v0p04
EOINI
echo "[abi2] a=1.8 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a1.8_v0.04.ini >> $LOG 2>&1) || echo "[abi2] a=1.8 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.800_*_kz0v3fine_a1p8_v0p04" >> $LOG 2>&1)
echo "[abi2] a=1.8 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a1.8_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.8
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a1p8_v0p06
EOINI
echo "[abi2] a=1.8 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a1.8_v0.06.ini >> $LOG 2>&1) || echo "[abi2] a=1.8 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.800_*_kz0v3fine_a1p8_v0p06" >> $LOG 2>&1)
echo "[abi2] a=1.8 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a1.8_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.8
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a1p8_v0p08
EOINI
echo "[abi2] a=1.8 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a1.8_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=1.8 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.800_*_kz0v3fine_a1p8_v0p08" >> $LOG 2>&1)
echo "[abi2] a=1.8 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a1.8_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 1.8
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a1p8_v0p1
EOINI
echo "[abi2] a=1.8 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a1.8_v0.1.ini >> $LOG 2>&1) || echo "[abi2] a=1.8 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a1.800_*_kz0v3fine_a1p8_v0p1" >> $LOG 2>&1)
echo "[abi2] a=1.8 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a2.2_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.2
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a2p2_v0p03
EOINI
echo "[abi2] a=2.2 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a2.2_v0.03.ini >> $LOG 2>&1) || echo "[abi2] a=2.2 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.200_*_kz0v3fine_a2p2_v0p03" >> $LOG 2>&1)
echo "[abi2] a=2.2 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a2.2_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.2
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a2p2_v0p05
EOINI
echo "[abi2] a=2.2 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a2.2_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=2.2 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.200_*_kz0v3fine_a2p2_v0p05" >> $LOG 2>&1)
echo "[abi2] a=2.2 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a2.2_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.2
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a2p2_v0p07
EOINI
echo "[abi2] a=2.2 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a2.2_v0.07.ini >> $LOG 2>&1) || echo "[abi2] a=2.2 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.200_*_kz0v3fine_a2p2_v0p07" >> $LOG 2>&1)
echo "[abi2] a=2.2 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a2.2_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.2
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a2p2_v0p09
EOINI
echo "[abi2] a=2.2 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a2.2_v0.09.ini >> $LOG 2>&1) || echo "[abi2] a=2.2 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.200_*_kz0v3fine_a2p2_v0p09" >> $LOG 2>&1)
echo "[abi2] a=2.2 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a2.2_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.2
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a2p2_v0p2
EOINI
echo "[abi2] a=2.2 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a2.2_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=2.2 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.200_*_kz0v3fine_a2p2_v0p2" >> $LOG 2>&1)
echo "[abi2] a=2.2 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a2.6_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.6
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a2p6_v0p04
EOINI
echo "[abi2] a=2.6 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a2.6_v0.04.ini >> $LOG 2>&1) || echo "[abi2] a=2.6 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.600_*_kz0v3fine_a2p6_v0p04" >> $LOG 2>&1)
echo "[abi2] a=2.6 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a2.6_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.6
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a2p6_v0p06
EOINI
echo "[abi2] a=2.6 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a2.6_v0.06.ini >> $LOG 2>&1) || echo "[abi2] a=2.6 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.600_*_kz0v3fine_a2p6_v0p06" >> $LOG 2>&1)
echo "[abi2] a=2.6 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a2.6_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.6
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a2p6_v0p08
EOINI
echo "[abi2] a=2.6 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a2.6_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=2.6 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.600_*_kz0v3fine_a2p6_v0p08" >> $LOG 2>&1)
echo "[abi2] a=2.6 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a2.6_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.6
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a2p6_v0p1
EOINI
echo "[abi2] a=2.6 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a2.6_v0.1.ini >> $LOG 2>&1) || echo "[abi2] a=2.6 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.600_*_kz0v3fine_a2p6_v0p1" >> $LOG 2>&1)
echo "[abi2] a=2.6 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a3.0_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p0_v0p03
EOINI
echo "[abi2] a=3.0 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a3.0_v0.03.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.000_*_kz0v3fine_a3p0_v0p03" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a3.0_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p0_v0p05
EOINI
echo "[abi2] a=3.0 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a3.0_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.000_*_kz0v3fine_a3p0_v0p05" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a3.0_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p0_v0p07
EOINI
echo "[abi2] a=3.0 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a3.0_v0.07.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.000_*_kz0v3fine_a3p0_v0p07" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a3.0_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p0_v0p09
EOINI
echo "[abi2] a=3.0 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a3.0_v0.09.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.000_*_kz0v3fine_a3p0_v0p09" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a3.0_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.0
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p0_v0p2
EOINI
echo "[abi2] a=3.0 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a3.0_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=3.0 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.000_*_kz0v3fine_a3p0_v0p2" >> $LOG 2>&1)
echo "[abi2] a=3.0 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a3.4_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.4
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p4_v0p04
EOINI
echo "[abi2] a=3.4 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a3.4_v0.04.ini >> $LOG 2>&1) || echo "[abi2] a=3.4 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.400_*_kz0v3fine_a3p4_v0p04" >> $LOG 2>&1)
echo "[abi2] a=3.4 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a3.4_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.4
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p4_v0p06
EOINI
echo "[abi2] a=3.4 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a3.4_v0.06.ini >> $LOG 2>&1) || echo "[abi2] a=3.4 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.400_*_kz0v3fine_a3p4_v0p06" >> $LOG 2>&1)
echo "[abi2] a=3.4 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a3.4_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.4
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p4_v0p08
EOINI
echo "[abi2] a=3.4 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a3.4_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=3.4 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.400_*_kz0v3fine_a3p4_v0p08" >> $LOG 2>&1)
echo "[abi2] a=3.4 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a3.4_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.4
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p4_v0p1
EOINI
echo "[abi2] a=3.4 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a3.4_v0.1.ini >> $LOG 2>&1) || echo "[abi2] a=3.4 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.400_*_kz0v3fine_a3p4_v0p1" >> $LOG 2>&1)
echo "[abi2] a=3.4 V0=0.1 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a3.8_v0.03.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.8
V0 = 0.03
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p8_v0p03
EOINI
echo "[abi2] a=3.8 V0=0.03 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a3.8_v0.03.ini >> $LOG 2>&1) || echo "[abi2] a=3.8 V0=0.03 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.800_*_kz0v3fine_a3p8_v0p03" >> $LOG 2>&1)
echo "[abi2] a=3.8 V0=0.03 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a3.8_v0.05.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.8
V0 = 0.05
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p8_v0p05
EOINI
echo "[abi2] a=3.8 V0=0.05 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a3.8_v0.05.ini >> $LOG 2>&1) || echo "[abi2] a=3.8 V0=0.05 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.800_*_kz0v3fine_a3p8_v0p05" >> $LOG 2>&1)
echo "[abi2] a=3.8 V0=0.05 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a3.8_v0.07.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.8
V0 = 0.07
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p8_v0p07
EOINI
echo "[abi2] a=3.8 V0=0.07 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a3.8_v0.07.ini >> $LOG 2>&1) || echo "[abi2] a=3.8 V0=0.07 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.800_*_kz0v3fine_a3p8_v0p07" >> $LOG 2>&1)
echo "[abi2] a=3.8 V0=0.07 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a3.8_v0.09.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.8
V0 = 0.09
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p8_v0p09
EOINI
echo "[abi2] a=3.8 V0=0.09 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a3.8_v0.09.ini >> $LOG 2>&1) || echo "[abi2] a=3.8 V0=0.09 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.800_*_kz0v3fine_a3p8_v0p09" >> $LOG 2>&1)
echo "[abi2] a=3.8 V0=0.09 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a3.8_v0.2.ini <<'EOINI'
k_mode = 1
alpha_YM = 3.8
V0 = 0.2
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a3p8_v0p2
EOINI
echo "[abi2] a=3.8 V0=0.2 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a3.8_v0.2.ini >> $LOG 2>&1) || echo "[abi2] a=3.8 V0=0.2 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a3.800_*_kz0v3fine_a3p8_v0p2" >> $LOG 2>&1)
echo "[abi2] a=3.8 V0=0.2 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a4.2_v0.04.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.2
V0 = 0.04
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a4p2_v0p04
EOINI
echo "[abi2] a=4.2 V0=0.04 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a4.2_v0.04.ini >> $LOG 2>&1) || echo "[abi2] a=4.2 V0=0.04 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.200_*_kz0v3fine_a4p2_v0p04" >> $LOG 2>&1)
echo "[abi2] a=4.2 V0=0.04 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a4.2_v0.06.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.2
V0 = 0.06
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a4p2_v0p06
EOINI
echo "[abi2] a=4.2 V0=0.06 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a4.2_v0.06.ini >> $LOG 2>&1) || echo "[abi2] a=4.2 V0=0.06 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.200_*_kz0v3fine_a4p2_v0p06" >> $LOG 2>&1)
echo "[abi2] a=4.2 V0=0.06 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a4.2_v0.08.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.2
V0 = 0.08
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a4p2_v0p08
EOINI
echo "[abi2] a=4.2 V0=0.08 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a4.2_v0.08.ini >> $LOG 2>&1) || echo "[abi2] a=4.2 V0=0.08 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.200_*_kz0v3fine_a4p2_v0p08" >> $LOG 2>&1)
echo "[abi2] a=4.2 V0=0.08 kz=0(noise) done $(date)" >> $LOG

cat > /tmp/kz0v3fine_abi2_a4.2_v0.1.ini <<'EOINI'
k_mode = 1
alpha_YM = 4.2
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 0.0002
target_tu = 800.0
run_tag = kz0v3fine_a4p2_v0p1
EOINI
echo "[abi2] a=4.2 V0=0.1 kz=0(noise) (tu=800.0) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_abi2_a4.2_v0.1.ini >> $LOG 2>&1) || echo "[abi2] a=4.2 V0=0.1 kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a4.200_*_kz0v3fine_a4p2_v0p1" >> $LOG 2>&1)
echo "[abi2] a=4.2 V0=0.1 kz=0(noise) done $(date)" >> $LOG

    echo "=== abi2 ALL DONE $(date) ===" >> $LOG
}

echo "=== abi: launching 3-GPU kz0v3fine refinement grid (63 pts) $(date) ==="
run_gpu1 & PID1=$!
run_gpu2 & PID2=$!
wait $PID1 && echo 'GPU1 finished' || echo 'GPU1 FAILED'
wait $PID2 && echo 'GPU2 finished' || echo 'GPU2 FAILED'
