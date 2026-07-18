#!/usr/bin/env python3
"""Generate the kz=0 chromo-Weibel growth-rate extension campaign (staged
2026-07-19, part of the comprehensive post-intkz campaign alongside the T1.1
EPS-scan and T1.4 warm-closure rerun -- see RESEARCH_ROADMAP.md and
FINDINGS.md "Campaign 8" for the original experiment this extends).

Background: the kz=0 mode of By2/Az2 is a *spatially uniform* (kx=0, kz=0)
chromo-Weibel-like instability of the two counter-streaming colour beams,
with NO dependence on the shear width EPS, the sponge, or any of the
KH-mode machinery -- its analytic rate is the purely local dispersion
relation

    gamma(kz=0) = (sqrt(alpha^3/2) * V0)^(1/3) * sin(pi/3)

(FINDINGS.md, "Key discovery: the kz=0 Weibel-like mode"). This was
originally mapped by Campaign 8 (2026-06-30): 200 points (alpha in
[1,6] linear x10, V0 in [0.001,0.4] log x20) using run_mode=3 (NAB_DTANH,
a DOUBLE shear layer). That geometry has a documented artifact: the two
Az1 wells split the kz=0 eigenfunction into symmetric/antisymmetric
("bonding"/"antibonding") combinations, suppressing the measured gamma by a
factor ~alpha^0.88 at low alpha relative to the true single-well/uniform
rate -- validated to only 0.5% at alpha=2, where the two wells decouple.

Extension here uses the CURRENT production geometry instead: run_mode=6
(NAB_CIRC_AZ2, single shear layer, the geometry every other measurement in
this program uses), which has no double-well artifact, so the WKB
polynomial can be tested across the FULL alpha range, not just alpha=2.
Technique notes:
  - k_mode=0 hits the kernel_ym_init k_mode==6 branch's xi_char formula
    (1/sqrt(alpha*kz*V0 + 1e-12)) at kz=0, which blows the width up to
    ~1e6 -- i.e. the seeded Az2 profile is (to any physical precision)
    spatially uniform, exactly matching the physics being measured. No
    separate eigenmode seed file is needed (seed_profile_file left unset).
  - suppress_kz0=0 is *mandatory* here (it usually zeroes exactly this
    channel every step -- see main_ym.cu step 6c/6e); kz_suppress_max=0 and
    kz_suppress_hi=0 leave the bandpass off (irrelevant to a kz=0
    measurement, the DFT projection is orthogonal to other kz anyway).
  - **init_by1_eq=1 and vz_edge_taper=50 are BOTH required alongside
    suppress_kz0=0** -- found the hard way (2026-07-19, first launch):
    without them the run is dominated within a few TU by a completely
    different, much faster instability -- exactly the two obstructions
    documented in OUTER_REGION.md's self-consistent-background test
    (FINDINGS.md "Self-consistent (unfrozen Az1) test", 2026-07-15/16): (1)
    the periodic-wrap vz discontinuity collapse (the *actual* reason
    suppress_kz0=1 is mandatory in production, not the Weibel mode alone),
    and (2) the secular By1 pump from an out-of-equilibrium color-1 sector.
    Both were already diagnosed and fixed by these exact two .ini keys
    during an earlier investigation; this experiment simply needed to reuse
    them (and didn't, the first time -- see FINDINGS.md 2026-07-19 "kz=0
    campaign contaminated" for the full story: measured gamma came out
    3-6x too fast and clustered around near-identical values across
    unrelated (alpha,V0) pairs, both signatures of a shared numerical
    artifact rather than the intended alpha/V0-dependent physical rate).
    With both fixes applied, OUTER_REGION.md's own reference point
    (alpha=1, V0=0.05) reduces to exactly this experiment's target rate
    (gamma=0.284, their measured blowup rate) -- i.e. the fix is verified
    against an independent prior measurement, not just self-consistent.
  - xi_sponge=0 (disabled): the sponge exists to confine a *localised*
    shear-layer eigenmode; this mode is uniform, so sponging part of the
    domain would only reduce the effective sampled volume for no benefit
    (and Campaign 8 didn't use one either).
  - EPS is left at the production default (0.15) -- the Weibel rate itself
    doesn't depend on EPS, and the measured (X-averaged) amplitude is
    dominated by the outer bulk region where |vz|~V0 is already uniform to
    good approximation (EPS << Lx), matching the historical result.

Grid: alpha in {0.5,1,1.5,2,2.5,3,4,5,6} x V0 in
{0.01,0.02,0.03,0.05,0.07,0.08,0.1,0.2} (both grids reused from the
project's standard production V0 set, for direct comparability with the
existing kz>=1 archive) = 72 points, ~1.75 GPU-h on an A5000.

Output: scripts/kz0ext_abi.sh (3-GPU parallel, LPT-balanced) +
sweep/kz0ext_manifest.csv. Launch with:
  nohup bash scripts/kz0ext_abi.sh > logs/kz0ext_abi.log 2>&1 &
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
EPS = 0.15
BP_OFF = 0
SEC_PER_TU_A5000 = 0.87
ABI_SLOWDOWN = 9200.0 / 4500.0   # same constant used throughout the project (recorr generator)

ABI_WDIR = "/DATA/s23103/lcpfct/ymgpu2d"
ABI_GPUS = (0, 1, 2)


def gamma_kz0(alpha, V0):
    C = math.sqrt(alpha ** 3 / 2.0) * V0
    return C ** (1.0 / 3.0) * math.sin(math.pi / 3.0)


def build_grid():
    rows = []
    for alpha in ALPHA_LIST:
        for V0 in V0_LIST:
            g = gamma_kz0(alpha, V0)
            tu = float(np.clip(15.0 / g, 100, 400)) if g > 0 else 250.0
            rows.append(dict(alpha=alpha, V0=V0, gamma_wkb_kz0=g, target_tu=round(tu, 1),
                             cost_a5000=tu * SEC_PER_TU_A5000))
    return pd.DataFrame(rows)


INI_TEMPLATE = """cat > {ini} <<'EOINI'
k_mode = 0
alpha_YM = {alpha}
V0 = {V0}
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
init_by1_eq = 1
vz_edge_taper = 50
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = {eps}
kz_suppress_hi = 0
target_tu = {target_tu}
run_tag = kz0ext
EOINI
echo "[{stream}] a={alpha} V0={V0} kz=0 (tu={target_tu}) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled {ini} >> $LOG 2>&1) || echo "[{stream}] a={alpha} V0={V0} kz=0 CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a{alpha:.3f}_*_v{V0:.4f}_*_kz0ext" >> $LOG 2>&1)
echo "[{stream}] a={alpha} V0={V0} kz=0 done $(date)" >> $LOG
"""

SMOKE_TEMPLATE = """# ---- smoke test: k_mode=0 uniform seed + suppress_kz0=0 path + extractor ----
cat > /tmp/kz0ext_smoke_{stream}.ini <<'EOINI'
k_mode = 0
alpha_YM = 2.0
V0 = 0.1
perturb_amp = 0.001
run_mode = 6
xi_sponge = 0
suppress_kz0 = 0
init_by1_eq = 1
vz_edge_taper = 50
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
target_tu = 2
run_tag = smoke{stream}
EOINI
rm -rf $WDIR/outputs/ym_k0_a2.000*smoke{stream}*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/kz0ext_smoke_{stream}.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k0_a2.000*smoke{stream}" >> $LOG 2>&1)
python3 - "$WDIR" {stream} <<'EOPY' >> $LOG 2>&1 || {{ echo "[{stream}] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }}
import csv, glob, math, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k0_a2.000*smoke" + stream + "*/timeseries_k0.csv")
assert fs, "smoke: no timeseries written (k_mode=0 path likely broken)"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert rows and 'amp_conj' in rows[0], "smoke: extractor is not the fixed version"
a0 = float(rows[0]['amp'])
assert a0 > 0 and math.log(a0) > -20, "smoke: kz=0 seed missing (logamp=%.1f)" % (math.log(a0) if a0 > 0 else -99)
print("[%s] smoke test OK (kz=0 uniform seed + suppress_kz0=0 path): logamp0=%.1f" % (stream, math.log(a0)))
EOPY
rm -rf $WDIR/outputs/ym_k0_a2.000*smoke{stream}*
"""


def emit_abi(assign, path):
    lines = ["#!/bin/bash", "# kz=0 growth-rate extension -- abi (3 GPUs, staged 2026-07-19)",
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
            ini = f"/tmp/kz0ext_{stream}_a{r['alpha']}_v{r['V0']}.ini"
            block = INI_TEMPLATE.format(ini=ini, stream=stream, alpha=r['alpha'], V0=r['V0'],
                                        eps=EPS, target_tu=r['target_tu'])
            lines.extend(block.split("\n"))
        lines.append(f'    echo "=== {stream} ALL DONE $(date) ===" >> $LOG')
        lines.append("}")
        lines.append("")
    lines.append('echo "=== abi: launching 3-GPU kz=0 extension campaign $(date) ==="')
    for g in ABI_GPUS:
        lines.append(f"run_gpu{g} & PID{g}=$!")
    for g in ABI_GPUS:
        lines.append(f"wait $PID{g} && echo 'GPU{g} finished' || echo 'GPU{g} FAILED'")
    with open(path, 'w') as f:
        f.write("\n".join(lines) + "\n")


def main():
    df = build_grid()

    # LPT-balance across the 3 abi GPUs, ABI_SLOWDOWN-aware (same constant/method as
    # gen_recorrection_campaign.py).
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
    print("No seed files needed (k_mode=0 auto-generates a uniform seed in kernel_ym_init).")


if __name__ == '__main__':
    main()
