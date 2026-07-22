#!/bin/bash
# Targeted sponge-consistency fix + peak-resolution fill, 2026-07-22.
# 1) alpha=3.0, V0=0.05: kz=4.0/4.5/5.0 previously used xi_sponge=10-13
#    (mismatched vs the xi_sponge=7 used by kz=3/3.5/6/7/8/9 in the same
#    series, and never plateau-confirmed) -- rerun at xi_sponge=7 to match.
# 2) One half-integer kz near the theory peak, for the alpha=0.05-series
#    values that don't have one yet: alpha=1.0 (kz=4.5), alpha=4.0 (kz=5.5).
#    alpha=3.0 kz=4.5 from (1) above serves this purpose for alpha=3.0.
set -e
WDIR=/DATA/cm/lcpfct/ymgpu2d
cd "$WDIR"
mkdir -p logs outputs
LOG=$WDIR/logs/spfix_t140_progress.log
echo "=== spfix t140 start $(date) ===" >> "$LOG"

run_one() {
  local tag="$1" ini="$2" glob="$3"
  echo "[spfix] $tag start $(date)" >> "$LOG"
  (cd "$WDIR/outputs" && "$WDIR/ym_coupled" "$ini" >> "$LOG" 2>&1) \
    || { echo "[spfix] $tag CRASHED (exit $?) $(date)" >> "$LOG"; return; }
  (cd "$WDIR/outputs" && python3 ../analysis/remote_timeseries.py "$glob" >> "$LOG" 2>&1)
  echo "[spfix] $tag done $(date)" >> "$LOG"
}

# --- smoke test: confirm binary + extractor healthy before spending time ---
cat > /tmp/spfix_smoke.ini <<'EOINI'
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
run_tag = spfixsmoke
EOINI
rm -rf "$WDIR"/outputs/ym_k2_a1.000*spfixsmoke*
(cd "$WDIR/outputs" && "$WDIR/ym_coupled" /tmp/spfix_smoke.ini >> "$LOG" 2>&1)
(cd "$WDIR/outputs" && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000*spfixsmoke" >> "$LOG" 2>&1)
python3 - "$WDIR" <<'EOPY' >> "$LOG" 2>&1 || { echo "[spfix] SMOKE TEST FAILED -- ABORTED $(date)" >> "$LOG"; exit 1; }
import csv, glob, math, sys
w = sys.argv[1]
fs = glob.glob(w + "/outputs/ym_k2_a1.000*spfixsmoke*/timeseries_k2.csv")
assert fs, "smoke: no timeseries written"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert rows and 'amp_conj' in rows[0], "smoke: extractor is not the fixed version"
a0 = float(rows[0]['amp'])
assert a0 > 0 and math.log(a0) > -20, "smoke: seed missing from measured channel (logamp=%.1f)" % (math.log(a0) if a0 > 0 else -99)
print("smoke test OK: logamp0=%.1f" % math.log(a0))
EOPY
rm -rf "$WDIR"/outputs/ym_k2_a1.000*spfixsmoke*
echo "[spfix] smoke test passed $(date)" >> "$LOG"

# ---------------------------------------------------------------------------
# (1a) alpha=3.0 V0=0.05 kz=4.0 (int) -- xi_sponge 10 -> 7
# ---------------------------------------------------------------------------
cat > /tmp/spfix_a3.0_v0.05_kz4.0.ini <<'EOINI'
k_mode = 4
alpha_YM = 3.0
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
run_tag = spfix
EOINI
run_one "a=3.0 V0=0.05 kz=4.0" /tmp/spfix_a3.0_v0.05_kz4.0.ini "ym_k4_a3.000_*_v0.0500_*_spfix"

# ---------------------------------------------------------------------------
# (1b) alpha=3.0 V0=0.05 kz=4.5 (half) -- xi_sponge 13 -> 7
# ---------------------------------------------------------------------------
cat > /tmp/spfix_a3.0_v0.05_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 3.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 7.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = spfix
EOINI
run_one "a=3.0 V0=0.05 kz=4.5" /tmp/spfix_a3.0_v0.05_kz4.5.ini "ym_k9_a3.000_*_v0.0500_*_spfix"

# ---------------------------------------------------------------------------
# (1c) alpha=3.0 V0=0.05 kz=5.0 (int) -- xi_sponge 13 -> 7
# ---------------------------------------------------------------------------
cat > /tmp/spfix_a3.0_v0.05_kz5.0.ini <<'EOINI'
k_mode = 5
alpha_YM = 3.0
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
run_tag = spfix
EOINI
run_one "a=3.0 V0=0.05 kz=5.0" /tmp/spfix_a3.0_v0.05_kz5.0.ini "ym_k5_a3.000_*_v0.0500_*_spfix"

# ---------------------------------------------------------------------------
# (2a) alpha=1.0 V0=0.05 kz=4.5 (half, new peak-resolution point)
#      xi_sponge=8.0 matches the kz=4/kz=5 integer neighbors
# ---------------------------------------------------------------------------
cat > /tmp/spfix_a1.0_v0.05_kz4.5.ini <<'EOINI'
k_mode = 9
alpha_YM = 1.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 8
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = spfix
EOINI
run_one "a=1.0 V0=0.05 kz=4.5" /tmp/spfix_a1.0_v0.05_kz4.5.ini "ym_k9_a1.000_*_v0.0500_*_spfix"

# ---------------------------------------------------------------------------
# (2b) alpha=4.0 V0=0.05 kz=5.5 (half, new peak-resolution point)
#      xi_sponge=8.0 matches the kz=5/kz=6 integer neighbors
# ---------------------------------------------------------------------------
cat > /tmp/spfix_a4.0_v0.05_kz5.5.ini <<'EOINI'
k_mode = 11
alpha_YM = 4.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 8.0
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = 10
eps_override = 0.15
kz_suppress_hi = 28
target_tu = 100.0
lz_override = 12.566371
nz_override = 128
run_tag = spfix
EOINI
run_one "a=4.0 V0=0.05 kz=5.5" /tmp/spfix_a4.0_v0.05_kz5.5.ini "ym_k11_a4.000_*_v0.0500_*_spfix"

echo "=== spfix t140 ALL DONE $(date) ===" >> "$LOG"
