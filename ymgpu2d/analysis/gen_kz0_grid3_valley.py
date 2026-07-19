#!/usr/bin/env python3
"""Phase 3 of the kz=0 deviation-mapping study: characterize the low-error
valley found in kz0v3 (coarse+fine, FINDINGS.md "kz0v3: dense (alpha, V0)
deviation map"). Two follow-up questions raised after inspecting
plots/kz0v3_relerr_map.png:

1. **Corner anomaly**: (alpha=0.8, V0=0.04) measured rel_err=+4.0%, an
   isolated near-zero pixel sandwiched between deeply negative neighbors
   (V0=0.03: -64.7%, V0=0.05: -66.5%). No RNG anywhere in the CUDA source
   (grep confirmed) -- the noise seed is pure floating-point roundoff from
   deterministic finite-difference ops, so a plain rerun reproduces the
   identical trace bit-for-bit. The only way to tell "isolated fit-window
   coincidence" from "real local structure" is to densify the surrounding
   (alpha, V0) neighborhood and see whether nearby points also dip low
   (real feature) or snap back to the -60% background (confirms it's the
   knife-edge window-selection sensitivity already documented in
   FINDINGS.md, not a physical effect).
   Grid: alpha in {0.6,0.7,0.8,0.9,1.0} x V0 in {0.030,0.035,0.040,0.045,0.050}
   = 25 points.

2. **Valley shape**: the rel_err=0 crossing V0(alpha) locus (computed by
   linear interpolation of the existing coarse+fine grid, alpha=1.6-8.0
   where the V0 grid is dense enough for a clean interpolation) is
   SMOOTH and follows approximately V0_cross ~ 0.116 * alpha^-0.525 (i.e.
   alpha*V0_cross climbing slowly from 0.196 at alpha=1.6 to 0.265 at
   alpha=8.0 -- NOT a fixed combined-coupling constant, a genuine slow
   drift). This adds finer alpha resolution (0.1 step, filling the
   remaining gaps in the already-0.2-step-resolved 1.6-4.4 band, plus
   extending to 4.6/5.0/5.4) at the V0 values that bracket each alpha's
   crossing, to pin the power-law exponent down more precisely and check
   whether the curve is truly smooth (real, if boring, numerical
   regularity of the transient-vs-nonlinear-contamination competition) or
   has its own knife-edge structure like the corner point.
   Grid: alpha in {1.7,1.9,2.1,2.3,2.5,2.7,2.9,3.1,3.3,3.5,3.7,3.9,4.1,4.3,
   4.6,5.0,5.4} (17 new values) x V0 in {0.04,...,0.10} (7 values, the
   range that brackets every crossing in this alpha range) = 119 points.

Total: 144 points. Same method as kz0v3 (run_mode=3/NAB_DTANH, target_tu=800
flat auto-halt, hyp_diff=2e-4). run_tag prefix "kz0v4" for both sub-grids
(corner points get an extra "_corner" tag suffix to keep them visually
distinct in directory listings, but glob-compatible with the same analysis
script).

Launch with: ssh -f abi "cd /DATA/s23103/lcpfct/ymgpu2d && \
    bash scripts/kz0v4_abi.sh > logs/kz0v4_abi.log 2>&1"
Validate with: python3 analysis/measure_kz0_grid2_accuracy.py remote_data/kz0v4
"""
import os, math
import pandas as pd

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..'))
SCRIPT_DIR = os.path.join(ROOT, 'scripts')
SWEEP_DIR = os.path.join(ROOT, 'sweep')

CORNER_ALPHA = [0.6, 0.7, 0.8, 0.9, 1.0]
CORNER_V0 = [0.030, 0.035, 0.040, 0.045, 0.050]

VALLEY_ALPHA = [1.7, 1.9, 2.1, 2.3, 2.5, 2.7, 2.9, 3.1, 3.3, 3.5, 3.7, 3.9,
                4.1, 4.3, 4.6, 5.0, 5.4]
VALLEY_V0 = [0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.10]

HYP_DIFF = 2e-4
SEC_PER_TU_A5000 = 0.87
ABI_SLOWDOWN = 9200.0 / 4500.0
TARGET_TU = 800.0

ABI_WDIR = "/DATA/s23103/lcpfct/ymgpu2d"
ABI_GPUS = (1, 2)  # GPU0 in use by another user's job at launch time 2026-07-19

RUN_TAG_PREFIX = "kz0v4"


def gamma_kz0(alpha, V0):
    C = math.sqrt(alpha ** 3 / 2.0) * V0
    return C ** (1.0 / 3.0) * math.sin(math.pi / 3.0)


def build_grid():
    rows = []
    for alpha in CORNER_ALPHA:
        for V0 in CORNER_V0:
            g = gamma_kz0(alpha, V0)
            rows.append(dict(alpha=alpha, V0=V0, gamma_wkb_kz0=g, target_tu=TARGET_TU,
                             cost_a5000=TARGET_TU * SEC_PER_TU_A5000, subgrid='corner'))
    for alpha in VALLEY_ALPHA:
        for V0 in VALLEY_V0:
            g = gamma_kz0(alpha, V0)
            rows.append(dict(alpha=alpha, V0=V0, gamma_wkb_kz0=g, target_tu=TARGET_TU,
                             cost_a5000=TARGET_TU * SEC_PER_TU_A5000, subgrid='valley'))
    return pd.DataFrame(rows)


INI_TEMPLATE = """cat > {ini} <<'EOINI'
k_mode = 1
alpha_YM = {alpha}
V0 = {V0}
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = {hyp_diff}
target_tu = {target_tu}
run_tag = {run_tag}
EOINI
echo "[{stream}] a={alpha} V0={V0} kz=0(noise) (tu={target_tu}) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled {ini} >> $LOG 2>&1) || echo "[{stream}] a={alpha} V0={V0} kz=0(noise) CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a{alpha:.3f}_*_{run_tag}" >> $LOG 2>&1)
echo "[{stream}] a={alpha} V0={V0} kz=0(noise) done $(date)" >> $LOG
"""

SMOKE_TEMPLATE = """# ---- smoke test: NAB_DTANH binary + noise-driven kz=0 extractor ----
cat > /tmp/kz0v4_smoke_{stream}.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 2e-4
target_tu = 50
run_tag = smokev4{stream}
EOINI
rm -rf $WDIR/outputs/ym_k1_a2.000*smokev4{stream}*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v4_smoke_{stream}.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000*smokev4{stream}" >> $LOG 2>&1)
python3 - "$WDIR" {stream} <<'EOPY' >> $LOG 2>&1 || {{ echo "[{stream}] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }}
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
rm -rf $WDIR/outputs/ym_k1_a2.000*smokev4{stream}*
"""


def emit_abi(assign, path):
    lines = ["#!/bin/bash", "# kz=0 deviation-mapping v4 -- corner-anomaly + valley-shape "
             "follow-up (144 pts, staged 2026-07-19)",
             f"WDIR={ABI_WDIR}", "mkdir -p $WDIR/logs $WDIR/outputs", ""]
    for g in ABI_GPUS:
        stream = f"abi{g}"
        pts = assign[stream]
        lines.append(f"run_gpu{g}() {{")
        lines.append(f"    export CUDA_VISIBLE_DEVICES={g}")
        lines.append(f"    WDIR={ABI_WDIR}")
        lines.append(f"    LOG=$WDIR/logs/kz0v4_{stream}_progress.log")
        lines.append(f'    echo "=== kz0v4 {stream} start $(date) ===" >> $LOG')
        lines.extend(SMOKE_TEMPLATE.format(stream=stream).split("\n"))
        for _, r in pts.iterrows():
            run_tag = f"{RUN_TAG_PREFIX}_{r['subgrid']}_a{r['alpha']}_v{r['V0']}".replace('.', 'p')
            ini = f"/tmp/kz0v4_{stream}_a{r['alpha']}_v{r['V0']}.ini"
            block = INI_TEMPLATE.format(ini=ini, stream=stream, alpha=r['alpha'], V0=r['V0'],
                                        hyp_diff=HYP_DIFF, target_tu=r['target_tu'],
                                        run_tag=run_tag)
            lines.extend(block.split("\n"))
        lines.append(f'    echo "=== {stream} ALL DONE $(date) ===" >> $LOG')
        lines.append("}")
        lines.append("")
    lines.append('echo "=== abi: launching kz0v4 corner+valley grid (144 pts) $(date) ==="')
    for g in ABI_GPUS:
        lines.append(f"run_gpu{g} & PID{g}=$!")
    for g in ABI_GPUS:
        lines.append(f"wait $PID{g} && echo 'GPU{g} finished' || echo 'GPU{g} FAILED'")
    with open(path, 'w') as f:
        f.write("\n".join(lines) + "\n")


def main():
    df = build_grid()

    finish = {f"abi{g}": 0.0 for g in ABI_GPUS}
    assign_idx = {}
    for idx in df.sort_values('cost_a5000', ascending=False).index:
        best = min(finish, key=finish.get)
        assign_idx[idx] = best
        finish[best] += df.at[idx, 'cost_a5000'] * ABI_SLOWDOWN
    df['stream'] = pd.Series(assign_idx)

    os.makedirs(SWEEP_DIR, exist_ok=True)
    os.makedirs(SCRIPT_DIR, exist_ok=True)
    df.to_csv(os.path.join(SWEEP_DIR, 'kz0v4_manifest.csv'), index=False)

    emit_abi({f"abi{g}": df[df['stream'] == f"abi{g}"].sort_values(['alpha', 'V0'])
             for g in ABI_GPUS}, os.path.join(SCRIPT_DIR, 'kz0v4_abi.sh'))

    print(f"Total runs: {len(df)}  (corner: {(df.subgrid=='corner').sum()}, "
          f"valley: {(df.subgrid=='valley').sum()})")
    for g in ABI_GPUS:
        n = (df['stream'] == f"abi{g}").sum()
        print(f"  abi{g}: {n} runs")
    print("Written scripts/kz0v4_abi.sh + sweep/kz0v4_manifest.csv")


if __name__ == '__main__':
    main()
