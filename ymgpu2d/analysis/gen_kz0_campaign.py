#!/usr/bin/env python3
"""Generate the kz=0 chromo-Weibel growth-rate extension campaign (staged
2026-07-19, part of the comprehensive post-intkz campaign alongside the T1.1
EPS-scan and T1.4 warm-closure rerun -- see RESEARCH_ROADMAP.md and
FINDINGS.md "Campaign 3"/"Campaign 8" for the original experiment this
extends, and "kz=0 extension campaign was CONTAMINATED" for two failed
designs before this one).

Background: the kz=0 mode of By2/Az2 is a *spatially uniform* (kx=0, kz=0)
chromo-Weibel-like instability of the two counter-streaming colour beams,
with analytic rate

    gamma(kz=0) = (sqrt(alpha^3/2) * V0)^(1/3) * sin(pi/3)

validated to 0.5% at exactly one point (alpha=2, V0=0.1) in Campaign 3
(2026-06-29): run_mode=3 (NAB_DTANH), seeded k_mode=1 (an arbitrary nonzero
channel -- irrelevant to the measurement), and the kz=0 component grows on
its own from machine-precision floating-point noise (~1e-13) over ~49 TU
(~25 e-foldings) to observable amplitude. Campaign 8 planned (but never
completed/reported) a 200-point (alpha,V0) sweep with the same method.

**Two prior attempts at this exact extension both failed, in different
ways -- read before changing anything here again:**
  1. Seeding an intentional k_mode=0 "uniform" profile directly (exploiting
     kernel_ym_init's k_mode==6 xi_char formula blowing up at kz=0) in
     run_mode=6 (the modern single-shear-layer geometry, chosen specifically
     to avoid Campaign 8's double-well suppression). This measured a rate
     3-6x too fast, clustering at near-identical values across UNRELATED
     (alpha,V0) pairs that shared the same alpha*V0 product -- energy.csv
     showed a genuine >10^4x blowup within a handful of TU.
  2. Adding `init_by1_eq=1` + `vz_edge_taper=50` (OUTER_REGION.md's fixes
     for the periodic-wrap collapse / secular By1 pump, the two documented
     obstructions to a self-consistent suppress_kz0=0 run) did NOT resolve
     it -- identical contamination pattern on rerun.
  Root cause, diagnosed after #2 failed: run_mode=6's frozen Az1(xi) =
  -V0*log(cosh(xi/EPS)) grows WITHOUT BOUND away from the shear layer. The
  outer-region tachyonic branch (OUTER_REGION.md: charged color-2/3 waves
  go unstable wherever |alpha*Az1(xi)| > kz) has NO threshold at all when
  kz=0 -- literally any xi != 0 is tachyonic, with a rate growing with
  |Az1(xi)| itself, i.e. without bound. A sponge cannot fix this either: it
  only cuts the domain off at some xi_sponge, but the ENTIRE retained region
  (0 < xi < xi_sponge) still satisfies the threshold-free tachyonic
  condition, so confining the domain just changes how much of it grows
  fast, not whether it does. This is a genuine, previously-undocumented
  limitation of frozen single-well shear geometries (modes 1/5/6) for a
  kz=0 measurement specifically -- fine at kz>=1 (real threshold, sponge
  works as designed there), broken at kz=0.

**Fix: use run_mode=3 (NAB_DTANH) after all**, exactly reproducing
Campaign 3's method rather than trying to improve on it. Its PERIODIC
double-well Az1 = -V0*(log_cosh(xi1) - log_cosh(xi2)) stays bounded
everywhere (every point in the domain is within a bounded distance of one
of the two layers, so the divergence that breaks mode 6 cancels) --
avoiding the tachyonic-at-kz=0 problem entirely, which is presumably why
Campaign 3's single point actually worked. Its one known cost, the
bonding/antibonding well-splitting suppression of KZ>=1 modes, is
irrelevant here since we are not measuring a seeded finite-kz mode at all --
only the noise-driven kz=0 component, which Campaign 3 already validated
directly against this exact geometry.

Extraction: since the run is seeded at k_mode=1 (not 0) and only the kz=0
component is wanted, `remote_timeseries.py` (which infers its DFT target k
from the k_mode-derived directory name) cannot be reused as-is --
`extract_kz0_noise.py` reads the raw field dumps directly and computes
mean(Az2)/mean(Az3) per snapshot (the k=0 DFT term is exactly a plain mean),
matching remote_timeseries.py's disk-hygiene convention (deletes dumps
after).

target_tu: growth starts from ~1e-13 (machine noise), NOT a finite
perturb_amp*V0 seed, so this needs ~25-30 e-foldings (Campaign 3: 25 over 49
TU) rather than the ~15 used for seeded-eigenmode campaigns elsewhere --
target_tu = clip(35/gamma_wkb, 100, 500).

Grid: alpha in {0.5,1,1.5,2,2.5,3,4,5,6} x V0 in
{0.01,0.02,0.03,0.05,0.07,0.08,0.1,0.2} (both grids reused from the
project's standard production V0 set, for direct comparability with the
existing kz>=1 archive) = 72 points.

Output: scripts/kz0ext_abi.sh (3-GPU parallel, LPT-balanced) +
sweep/kz0ext_manifest.csv. Launch with:
  nohup bash scripts/kz0ext_abi.sh > logs/kz0ext_abi.log 2>&1 &
Validate with: python3 analysis/measure_kz0_accuracy.py <rsynced_data_dir>
"""
import os, sys, math
import numpy as np
import pandas as pd

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..'))
SCRIPT_DIR = os.path.join(ROOT, 'scripts')
SWEEP_DIR = os.path.join(ROOT, 'sweep')

ALPHA_LIST = [0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 4.0, 5.0, 6.0]
V0_LIST = [0.01, 0.02, 0.03, 0.05, 0.07, 0.08, 0.1, 0.2]
HYP_DIFF = 2e-4   # Campaign 8's choice: 4x the usual 5e-5, sized for this V0 range's
                  # max physical growth rate (see Campaign 8 "hyp_diff choice")
SEC_PER_TU_A5000 = 0.87
ABI_SLOWDOWN = 9200.0 / 4500.0

ABI_WDIR = "/DATA/s23103/lcpfct/ymgpu2d"
ABI_GPUS = (0, 1, 2)


def gamma_kz0(alpha, V0):
    C = math.sqrt(alpha ** 3 / 2.0) * V0
    return C ** (1.0 / 3.0) * math.sin(math.pi / 3.0)


TARGET_TU_V2 = 800.0
# NOTE (found 2026-07-19, see FINDINGS.md "kz=0 accuracy v2 -- pre-asymptotic
# transient, not a physical deviation"): the v1 formula here was
# clip(35/gamma_wkb, 100, 500) -- a guess that ~35 e-folds from machine noise
# would be enough. It wasn't: growth from residual roundoff noise is NOT a
# clean single exponential from t=0 -- there's a long, slower pre-asymptotic
# transient (whatever mix of numerical-error "shape" happens to be present),
# and the true fastest-growing eigenvalue only comes to dominate very late,
# right before the run's own 100xE0 energy-threshold halt. A convergence
# test (alpha=1.0, V0=0.01, target_tu=700) showed the local growth rate
# oscillating around 0.02-0.06 for t=0-330 TU, then jumping to 0.17 (matching
# the WKB prediction of 0.166 almost exactly) only in the last ~30 TU before
# the run halted at t=361.7. Fix: run everyone long enough (800 TU, well
# past every point's own natural saturation given the slowest point in this
# grid needed ~510 TU by extrapolation) and let the run's own energy
# threshold end it naturally at ITS OWN convergence point, rather than
# guessing a fixed total duration from the (very point-dependent, as it
# turns out) number of e-folds needed. This is still cheap: the run-time is
# bounded by each point's OWN saturation time, not by target_tu=800 itself
# (a fast point self-terminates in tens of TU regardless of the requested
# cap). measure_kz0_accuracy.py's window search was also changed to prefer
# late windows for the same reason.
def build_grid():
    rows = []
    for alpha in ALPHA_LIST:
        for V0 in V0_LIST:
            g = gamma_kz0(alpha, V0)
            tu = TARGET_TU_V2
            rows.append(dict(alpha=alpha, V0=V0, gamma_wkb_kz0=g, target_tu=round(tu, 1),
                             cost_a5000=tu * SEC_PER_TU_A5000))
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
cat > /tmp/kz0ext_smoke_{stream}.ini <<'EOINI'
k_mode = 1
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 3
suppress_kz0 = 0
hyp_diff = 2e-4
target_tu = 50
run_tag = smoke{stream}
EOINI
rm -rf $WDIR/outputs/ym_k1_a2.000*smoke{stream}*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_smoke_{stream}.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/extract_kz0_noise.py "ym_k1_a2.000*smoke{stream}" >> $LOG 2>&1)
python3 - "$WDIR" {stream} <<'EOPY' >> $LOG 2>&1 || {{ echo "[{stream}] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }}
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
rm -rf $WDIR/outputs/ym_k1_a2.000*smoke{stream}*
"""


def emit_abi(assign, path):
    lines = ["#!/bin/bash", "# kz=0 growth-rate extension -- abi (3 GPUs, staged 2026-07-19, "
             "NAB_DTANH/Campaign-3 method, v2 after the mode-6 contamination)",
             f"WDIR={ABI_WDIR}", "mkdir -p $WDIR/logs $WDIR/outputs", ""]
    for g in ABI_GPUS:
        stream = f"abi{g}"
        pts = assign[stream]
        lines.append(f"run_gpu{g}() {{")
        lines.append(f"    export CUDA_VISIBLE_DEVICES={g}")
        lines.append(f"    WDIR={ABI_WDIR}")
        lines.append(f"    LOG=$WDIR/logs/kz0ext_{stream}_progress.log")
        lines.append(f'    echo "=== kz0ext {stream} start $(date) ===" >> $LOG')
        lines.extend(SMOKE_TEMPLATE.format(stream=stream).split("\n"))
        for _, r in pts.iterrows():
            run_tag = f"kz0ext_a{r['alpha']}_v{r['V0']}".replace('.', 'p')
            ini = f"/tmp/kz0ext_{stream}_a{r['alpha']}_v{r['V0']}.ini"
            block = INI_TEMPLATE.format(ini=ini, stream=stream, alpha=r['alpha'], V0=r['V0'],
                                        hyp_diff=HYP_DIFF, target_tu=r['target_tu'],
                                        run_tag=run_tag)
            lines.extend(block.split("\n"))
        lines.append(f'    echo "=== {stream} ALL DONE $(date) ===" >> $LOG')
        lines.append("}")
        lines.append("")
    lines.append('echo "=== abi: launching 3-GPU kz=0 extension campaign (v2, NAB_DTANH) $(date) ==="')
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
    df.to_csv(os.path.join(SWEEP_DIR, 'kz0ext_manifest.csv'), index=False)

    emit_abi({f"abi{g}": df[df['stream'] == f"abi{g}"].sort_values(['alpha', 'V0'])
             for g in ABI_GPUS}, os.path.join(SCRIPT_DIR, 'kz0ext_abi.sh'))

    tot_cost = df['cost_a5000'].sum()
    print(f"Total runs: {len(df)}  (est. {tot_cost/3600:.2f} GPU-h on an A5000-equivalent pace)")
    for g in ABI_GPUS:
        n = (df['stream'] == f"abi{g}").sum()
        print(f"  abi{g}: {n} runs, ~{finish[f'abi{g}']*1.5/3600:.2f} h wall (incl. extraction overhead)")
    print("Written scripts/kz0ext_abi.sh + sweep/kz0ext_manifest.csv")
    print("v2: run_mode=3 (NAB_DTANH), seeded k_mode=1, kz=0 grows from machine noise "
          "(Campaign 3's exact method) -- extract_kz0_noise.py reads raw dumps directly.")


if __name__ == '__main__':
    main()
