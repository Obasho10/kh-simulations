#!/usr/bin/env python3
"""Phase 2 of the kz=0 deviation-mapping study: finer alpha resolution in
the band where the coarse grid's |rel_err| declines (`gen_kz0_grid2.py`,
sweep/kz0v3_results.csv). See FINDINGS.md "kz0v3 coarse grid deviation map"
for the full derivation.

Coarse grid (alpha step 0.4, 9 V0 values) showed median |rel_err| (over V0)
falling from 56% at alpha=0.8 to a valley of 21-28% across alpha=2.4-3.6
(vs 37-48% on either side), then climbing back up past alpha=4. The valley
straddles the historically-validated anchor (alpha=2.0, V0=0.10, matched to
0.02%). This campaign fills in alpha=1.8,2.2,2.6,3.0,3.4,3.8,4.2 (step 0.2
within alpha in [1.6,4.4], padding one coarse step beyond the observed
valley on each side) x the same 9 V0 values = 63 points.

Method unchanged from gen_kz0_grid2.py (NAB_DTANH/v2, target_tu=800 flat
auto-halt, hyp_diff=2e-4). run_tag prefix "kz0v3fine" to keep separate from
both the closed-out "kz0ext" and coarse "kz0v3" datasets.

Launch with: ssh -f abi "cd /DATA/s23103/lcpfct/ymgpu2d && \
    bash scripts/kz0v3fine_abi.sh > logs/kz0v3fine_abi.log 2>&1"
Validate with: python3 analysis/measure_kz0_grid2_accuracy.py remote_data/kz0v3fine
  (glob pattern differs -- see RUN_TAG_PREFIX below; reuses the same script
  since it globs on "ym_k1_a*_kz0v3*" which also matches "kz0v3fine_*")
"""
import os, math
import pandas as pd

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..'))
SCRIPT_DIR = os.path.join(ROOT, 'scripts')
SWEEP_DIR = os.path.join(ROOT, 'sweep')

ALPHA_LIST = [1.8, 2.2, 2.6, 3.0, 3.4, 3.8, 4.2]
V0_LIST = [0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.10, 0.20]
HYP_DIFF = 2e-4
SEC_PER_TU_A5000 = 0.87
ABI_SLOWDOWN = 9200.0 / 4500.0
TARGET_TU = 800.0

ABI_WDIR = "/DATA/s23103/lcpfct/ymgpu2d"
ABI_GPUS = (1, 2)  # GPU0 in use by another user's job at launch time 2026-07-19 13:xx

RUN_TAG_PREFIX = "kz0v3fine"


def gamma_kz0(alpha, V0):
    C = math.sqrt(alpha ** 3 / 2.0) * V0
    return C ** (1.0 / 3.0) * math.sin(math.pi / 3.0)


def build_grid():
    rows = []
    for alpha in ALPHA_LIST:
        for V0 in V0_LIST:
            g = gamma_kz0(alpha, V0)
            rows.append(dict(alpha=alpha, V0=V0, gamma_wkb_kz0=g, target_tu=TARGET_TU,
                             cost_a5000=TARGET_TU * SEC_PER_TU_A5000))
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
cat > /tmp/kz0v3fine_smoke_{stream}.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 2e-4
target_tu = 50
run_tag = smokefine{stream}
EOINI
rm -rf $WDIR/outputs/ym_k1_a2.000*smokefine{stream}*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3fine_smoke_{stream}.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000*smokefine{stream}" >> $LOG 2>&1)
python3 - "$WDIR" {stream} <<'EOPY' >> $LOG 2>&1 || {{ echo "[{stream}] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }}
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
rm -rf $WDIR/outputs/ym_k1_a2.000*smokefine{stream}*
"""


def emit_abi(assign, path):
    lines = ["#!/bin/bash", "# kz=0 deviation-mapping grid v3 -- abi (3 GPUs), fine pass "
             "(alpha in [1.6,4.4] step 0.2 valley refinement, 63 pts, staged 2026-07-19)",
             f"WDIR={ABI_WDIR}", "mkdir -p $WDIR/logs $WDIR/outputs", ""]
    for g in ABI_GPUS:
        stream = f"abi{g}"
        pts = assign[stream]
        lines.append(f"run_gpu{g}() {{")
        lines.append(f"    export CUDA_VISIBLE_DEVICES={g}")
        lines.append(f"    WDIR={ABI_WDIR}")
        lines.append(f"    LOG=$WDIR/logs/kz0v3fine_{stream}_progress.log")
        lines.append(f'    echo "=== kz0v3fine {stream} start $(date) ===" >> $LOG')
        lines.extend(SMOKE_TEMPLATE.format(stream=stream).split("\n"))
        for _, r in pts.iterrows():
            run_tag = f"{RUN_TAG_PREFIX}_a{r['alpha']}_v{r['V0']}".replace('.', 'p')
            ini = f"/tmp/kz0v3fine_{stream}_a{r['alpha']}_v{r['V0']}.ini"
            block = INI_TEMPLATE.format(ini=ini, stream=stream, alpha=r['alpha'], V0=r['V0'],
                                        hyp_diff=HYP_DIFF, target_tu=r['target_tu'],
                                        run_tag=run_tag)
            lines.extend(block.split("\n"))
        lines.append(f'    echo "=== {stream} ALL DONE $(date) ===" >> $LOG')
        lines.append("}")
        lines.append("")
    lines.append('echo "=== abi: launching 3-GPU kz0v3fine refinement grid (63 pts) $(date) ==="')
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
    df.to_csv(os.path.join(SWEEP_DIR, 'kz0v3fine_manifest.csv'), index=False)

    emit_abi({f"abi{g}": df[df['stream'] == f"abi{g}"].sort_values(['alpha', 'V0'])
             for g in ABI_GPUS}, os.path.join(SCRIPT_DIR, 'kz0v3fine_abi.sh'))

    print(f"Total runs: {len(df)}")
    for g in ABI_GPUS:
        n = (df['stream'] == f"abi{g}").sum()
        print(f"  abi{g}: {n} runs")
    print("Written scripts/kz0v3fine_abi.sh + sweep/kz0v3fine_manifest.csv")


if __name__ == '__main__':
    main()
