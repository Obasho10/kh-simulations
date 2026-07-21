#!/usr/bin/env python3
"""Coarse kz=0 deviation-mapping grid (staged 2026-07-19), v3 of the kz=0
chromo-Weibel extension -- see gen_kz0_campaign.py for the full method
history (three prior contamination fixes) and FINDINGS.md "kz=0 extension
campaign CLOSED OUT" for the known limitation this inherits: the
best-window log-linear fit locks onto a long pre-asymptotic transient at
low alpha*V0, not the true eigenvalue, producing a systematic bias that
flips sign near the historically-validated anchor (alpha=2, V0=0.1).

This campaign does NOT fix that limitation. It exists to *map* the bias
(the user wants to see how the deviation actually looks) over a denser,
wider grid than the closed-out 72-point one, as phase 1 of a two-phase
study: coarse grid first, then finer alpha resolution only in the band
where |rel_err| declines (the transition the closed-out campaign found
near alpha=2, V0=0.1) -- see gen_kz0_grid2_refine.py.

Grid: V0 in {0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.10,0.20} (9 values) x
alpha in {0.4,0.8,...,8.0} (20 values, step 0.4) = 180 points.
alpha=0 excluded (gamma_kz0(0)=0, degenerate).

Method: identical to gen_kz0_campaign.py v2 -- run_mode=3 (NAB_DTANH),
k_mode=1 seed, kz=0 grows from machine noise, target_tu=800 flat (each run
self-halts at its own 100xE0 energy threshold, so wall-time is bounded by
the point's own saturation time, not by target_tu itself). hyp_diff=2e-4
unchanged -- max gamma in this grid (alpha=8, V0=0.2) is 1.28 TU^-1, still
under Campaign 8's 1.39 TU^-1 safety margin for that hyp_diff value.

run_tag prefix "kz0v3" (distinct from the closed-out grid's "kz0ext") so
both datasets can coexist in outputs/ and remote_data/ without glob
collisions.

Launch with: ssh -f abi "cd /DATA/s23103/lcpfct/ymgpu2d && \
    bash scripts/kz0v3_abi.sh > logs/kz0v3_abi.log 2>&1"
Validate with: python3 analysis/measure_kz0_grid2_accuracy.py remote_data/kz0v3
"""
import os, math
import numpy as np
import pandas as pd

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..'))
SCRIPT_DIR = os.path.join(ROOT, 'scripts')
SWEEP_DIR = os.path.join(ROOT, 'sweep')

ALPHA_LIST = [round(0.4 * i, 1) for i in range(1, 21)]  # 0.4 .. 8.0
V0_LIST = [0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.10, 0.20]
HYP_DIFF = 2e-4
SEC_PER_TU_A5000 = 0.87
ABI_SLOWDOWN = 9200.0 / 4500.0
TARGET_TU = 800.0

ABI_WDIR = "/DATA/s23103/lcpfct/ymgpu2d"
ABI_GPUS = (0, 1, 2)

RUN_TAG_PREFIX = "kz0v3"


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
cat > /tmp/kz0v3_smoke_{stream}.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 2e-4
target_tu = 50
run_tag = smokev3{stream}
EOINI
rm -rf $WDIR/outputs/ym_k1_a2.000*smokev3{stream}*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0v3_smoke_{stream}.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000*smokev3{stream}" >> $LOG 2>&1)
python3 - "$WDIR" {stream} <<'EOPY' >> $LOG 2>&1 || {{ echo "[{stream}] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }}
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
rm -rf $WDIR/outputs/ym_k1_a2.000*smokev3{stream}*
"""


def emit_abi(assign, path):
    lines = ["#!/bin/bash", "# kz=0 deviation-mapping grid v3 -- abi (3 GPUs), coarse pass "
             "(9 V0 x 20 alpha = 180 pts, staged 2026-07-19)",
             f"WDIR={ABI_WDIR}", "mkdir -p $WDIR/logs $WDIR/outputs", ""]
    for g in ABI_GPUS:
        stream = f"abi{g}"
        pts = assign[stream]
        lines.append(f"run_gpu{g}() {{")
        lines.append(f"    export CUDA_VISIBLE_DEVICES={g}")
        lines.append(f"    WDIR={ABI_WDIR}")
        lines.append(f"    LOG=$WDIR/logs/kz0v3_{stream}_progress.log")
        lines.append(f'    echo "=== kz0v3 {stream} start $(date) ===" >> $LOG')
        lines.extend(SMOKE_TEMPLATE.format(stream=stream).split("\n"))
        for _, r in pts.iterrows():
            run_tag = f"{RUN_TAG_PREFIX}_a{r['alpha']}_v{r['V0']}".replace('.', 'p')
            ini = f"/tmp/kz0v3_{stream}_a{r['alpha']}_v{r['V0']}.ini"
            block = INI_TEMPLATE.format(ini=ini, stream=stream, alpha=r['alpha'], V0=r['V0'],
                                        hyp_diff=HYP_DIFF, target_tu=r['target_tu'],
                                        run_tag=run_tag)
            lines.extend(block.split("\n"))
        lines.append(f'    echo "=== {stream} ALL DONE $(date) ===" >> $LOG')
        lines.append("}")
        lines.append("")
    lines.append('echo "=== abi: launching 3-GPU kz0v3 coarse grid (180 pts) $(date) ==="')
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
    df.to_csv(os.path.join(SWEEP_DIR, 'kz0v3_manifest.csv'), index=False)

    emit_abi({f"abi{g}": df[df['stream'] == f"abi{g}"].sort_values(['alpha', 'V0'])
             for g in ABI_GPUS}, os.path.join(SCRIPT_DIR, 'kz0v3_abi.sh'))

    tot_cost = df['cost_a5000'].sum()
    print(f"Total runs: {len(df)}  (est. {tot_cost/3600:.2f} GPU-h on an A5000-equivalent pace, "
          f"flat target_tu={TARGET_TU:.0f} -- real wall time bounded by each point's own "
          f"auto-halt, typically far less; prior 72-pt campaign at same target_tu averaged "
          f"~80s/run wall on abi)")
    for g in ABI_GPUS:
        n = (df['stream'] == f"abi{g}").sum()
        print(f"  abi{g}: {n} runs")
    print("Written scripts/kz0v3_abi.sh + sweep/kz0v3_manifest.csv")


if __name__ == '__main__':
    main()
