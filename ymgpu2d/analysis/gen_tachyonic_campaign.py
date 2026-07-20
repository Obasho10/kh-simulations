#!/usr/bin/env python3
"""Tachyonic-instability growth-rate campaign (2026-07-20). Existing GPU
confirmation of the outer-region frozen-Az1 tachyonic branch
(gamma^2 = alpha^2*Az1(xi)^2 - kz^2, analysis/outer_region_theory.py) is
essentially ONE clean point (alpha=0.5,V0=0.05,kz=0.5,sp=52) plus a 2-point
side-study at alpha=1.0,V0=0.05 that wasn't a rate scan. This campaign adds:

  - 40 "magnitude check" points: enumerate alpha x V0 x kz, keep only
    combinations where xi_crit=kz/(alpha*V0) lands in [12,33] so a sponge at
    ~1.5x xi_crit (capped at 53) stays safely inside the default domain
    half-width Lx/2/EPS=62.8 at EPS=0.15 -- no lx_override needed.
  - 2 "profile" cascades (5 points each): fixed (alpha,V0,kz), sponge swept
    across 5 depths, to trace gamma_sim(sp) vs the local law gamma_loc(sp) --
    this is the "behavior" half of the ask, not just single-point magnitude.

RISK CONTROL: wide sponge + high alpha is exactly what triggers the
documented "late-onset catastrophe" (EPS-scan v2, 2026-07-19) -- capped at
alpha<=2.0 here, well below the alpha>=6 danger zone, since the two existing
successful tachyonic points (alpha=0.5, alpha=1.0) ran cleanly at similar
sponge widths.

Uses its own INI/SMOKE templates (run_tag='tachyonic', not 'recorr') so these
runs don't get mixed into recorr_collect.py's existing glob patterns, but
reuses gen_recorrection_campaign's cost model / LPT assignment pattern.

Output: scripts/tachyonic_{t126,t133,t136,t140,abi}.sh + sweep/tachyonic_manifest.csv
"""
import os, sys, math
import numpy as np
import pandas as pd

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..'))
SCRIPT_DIR = os.path.join(ROOT, 'scripts')
SWEEP_DIR = os.path.join(ROOT, 'sweep')
sys.path.insert(0, HERE)
import gen_recorrection_campaign as G   # SEC_PER_TU_A5000, ABI_SLOWDOWN, BP_INT
from outer_region_theory import gamma_local

SINGLE_STREAMS = [
    ("t126", "a5000",  "/DATA/cm/lcpfct/ymgpu2d"),
    ("t133", "a5000",  "/DATA/ym_kh/ymgpu2d"),
    ("t140", "a5000",  "/DATA/cm/lcpfct/ymgpu2d"),
]
ABI_WDIR = "/DATA/s23103/lcpfct/ymgpu2d"
ALL_STREAM_NAMES = [s[0] for s in SINGLE_STREAMS] + ["abi0", "abi1", "abi2"]
STREAM_CLASS = {s[0]: "a5000" for s in SINGLE_STREAMS}
STREAM_CLASS.update({"abi0": "1080ti", "abi1": "1080ti", "abi2": "1080ti"})

RUN_TAG = "tachyonic"
EPS_FIXED = 0.15
LZ_HALF, NZ_HALF, BP_HALF = 4 * math.pi, 128, 28
BP_INT = G.BP_INT

ALPHAS = [0.3, 0.5, 1.0, 1.5, 2.0]
V0S = [0.03, 0.05, 0.08, 0.10]
KZS = [0.5, 1.0, 1.5, 2.0, 2.5, 3.0]
XI_CRIT_MIN, XI_CRIT_MAX = 12.0, 33.0
SPONGE_CAP = 53.0

PROFILE_1 = dict(alpha=0.5, V0=0.05, kz=0.5, sps=[24, 29, 35, 42, 50])
PROFILE_2 = dict(alpha=1.0, V0=0.05, kz=1.5, sps=[33, 38, 44, 49, 53])


def tier_of(kz):
    return 'int' if float(kz).is_integer() else 'half'


def row_for(alpha, V0, kz, sp, group):
    tier = tier_of(kz)
    mult = 2 if tier == 'half' else 1
    k_mode = int(round(kz * mult))
    A = -V0 * np.log(np.cosh(sp))
    v = V0 * np.tanh(sp)
    g = gamma_local(kz, alpha, A, v)
    tu = round(float(np.clip(15.0 / g, 60, 150)) if g > 0 else 100.0, 1)
    bp = BP_HALF if tier == 'half' else BP_INT
    return dict(alpha=alpha, V0=V0, kz=kz, tier=tier, k_mode=k_mode,
                xi_sponge=float(sp), target_tu=tu, bp=bp, cellmult=mult,
                gamma_loc_pred=round(g, 4), group=group,
                cost_a5000=tu * mult * G.SEC_PER_TU_A5000)


def build_grid():
    rows = []
    for a in ALPHAS:
        for v in V0S:
            for kz in KZS:
                xc = kz / (a * v)
                if not (XI_CRIT_MIN <= xc <= XI_CRIT_MAX):
                    continue
                sp = min(SPONGE_CAP, round(xc * 1.5))
                rows.append(row_for(a, v, kz, sp, 'magnitude_check'))
    for prof in (PROFILE_1, PROFILE_2):
        for sp in prof['sps']:
            rows.append(row_for(prof['alpha'], prof['V0'], prof['kz'], sp, 'profile_cascade'))
    return pd.DataFrame(rows)


INI_TEMPLATE = """cat > {ini} <<'EOINI'
k_mode = {k_mode}
alpha_YM = {alpha}
V0 = {V0}
perturb_amp = 0.001
run_mode = 6
xi_sponge = {xi_sponge}
sigma_sponge = 5.0
suppress_kz0 = 1
hyp_diff = 5e-5
kz_suppress_max = {kz_suppress_max}
eps_override = {eps}
kz_suppress_hi = {bp}
{lz_nz_block}target_tu = {target_tu}
run_tag = tachyonic
EOINI
echo "[{stream}] a={alpha} V0={V0} kz={kz} (tier={tier} k={k_mode} sp={xi_sponge} tu={target_tu} gpred={gamma_loc_pred}) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled {ini} >> $LOG 2>&1) || echo "[{stream}] a={alpha} V0={V0} kz={kz} sp={xi_sponge} CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k{k_mode}_a{alpha:.3f}_*_v{V0:.4f}_*_tachyonic" >> $LOG 2>&1)
echo "[{stream}] a={alpha} V0={V0} kz={kz} sp={xi_sponge} done $(date)" >> $LOG
"""

SMOKE_TEMPLATE = """cat > /tmp/tachyonic_smoke_{stream}.ini <<'EOINI'
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
run_tag = smoketachy{stream}
EOINI
rm -rf $WDIR/outputs/ym_k2_a1.000*smoketachy{stream}*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/tachyonic_smoke_{stream}.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000*smoketachy{stream}" >> $LOG 2>&1)
python3 - "$WDIR" {stream} <<'EOPY' >> $LOG 2>&1 || {{ echo "[{stream}] SMOKE TEST FAILED -- stream ABORTED $(date)" >> $LOG; exit 1; }}
import csv, glob, math, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k2_a1.000*smoketachy" + stream + "*/timeseries_k2.csv")
assert fs, "smoke: no timeseries written"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert rows and 'amp_conj' in rows[0], "smoke: extractor is not the fixed version"
a0 = float(rows[0]['amp'])
assert a0 > 0 and math.log(a0) > -20, "smoke: seed missing from measured channel (logamp=%.1f)" % (math.log(a0) if a0 > 0 else -99)
print("[%s] smoke test OK: logamp0=%.1f" % (stream, math.log(a0)))
EOPY
rm -rf $WDIR/outputs/ym_k2_a1.000*smoketachy{stream}*
"""


def lz_nz_block(tier):
    if tier == 'half':
        return f"lz_override = {LZ_HALF:.6f}\nnz_override = {NZ_HALF}\n"
    return ""


def ini_lines(stream, r):
    ini = f"/tmp/tachyonic_{stream}_a{r['alpha']}_v{r['V0']}_kz{r['kz']}_sp{r['xi_sponge']:.0f}.ini"
    return INI_TEMPLATE.format(
        ini=ini, stream=stream, k_mode=int(r['k_mode']), alpha=r['alpha'], V0=r['V0'],
        kz=r['kz'], tier=r['tier'], xi_sponge=r['xi_sponge'],
        kz_suppress_max=int(r['k_mode']) - 1, eps=EPS_FIXED, bp=int(r['bp']),
        lz_nz_block=lz_nz_block(r['tier']), target_tu=r['target_tu'],
        gamma_loc_pred=r['gamma_loc_pred'])


def build_stream_lines(stream, pts):
    lines = [f'echo "=== tachyonic {stream} start $(date) ===" >> $LOG',
             SMOKE_TEMPLATE.format(stream=stream)]
    for _, r in pts.iterrows():
        lines.append(ini_lines(stream, r))
    lines.append(f'echo "=== {stream} ALL DONE $(date) ===" >> $LOG')
    return lines


def emit_single(stream, wdir, pts, path):
    lines = ["#!/bin/bash",
             f"# tachyonic-instability campaign -- {stream}: {len(pts)} runs (2026-07-20)",
             f"WDIR={wdir}", "mkdir -p $WDIR/logs $WDIR/outputs",
             f"LOG=$WDIR/logs/tachyonic_{stream}_progress.log"]
    lines += build_stream_lines(stream, pts)
    with open(path, 'w') as f:
        f.write("\n".join(lines) + "\n")


def emit_abi(assign, path):
    lines = ["#!/bin/bash", "# tachyonic-instability campaign -- abi (3 GPUs, 2026-07-20)",
             f"WDIR={ABI_WDIR}", "mkdir -p $WDIR/logs $WDIR/outputs", ""]
    for g in range(3):
        stream = f"abi{g}"
        pts = assign[stream]
        lines.append(f"run_gpu{g}() {{")
        lines.append(f"    export CUDA_VISIBLE_DEVICES={g}")
        lines.append(f"    WDIR={ABI_WDIR}")
        lines.append(f"    LOG=$WDIR/logs/tachyonic_{stream}_progress.log")
        # heredoc blocks must start at column 0 inside the function body
        for ln in build_stream_lines(stream, pts):
            lines.extend(ln.split("\n"))
        lines.append("}")
        lines.append("")
    lines.append('echo "=== abi: launching 3-GPU tachyonic campaign $(date) ==="')
    for g in range(3):
        lines.append(f"run_gpu{g} & PID{g}=$!")
    for g in range(3):
        lines.append(f"wait $PID{g} && echo 'GPU{g} finished' || echo 'GPU{g} FAILED'")
    with open(path, 'w') as f:
        f.write("\n".join(lines) + "\n")


def main():
    df = build_grid()
    print(f"Magnitude-check points: {(df['group']=='magnitude_check').sum()}")
    print(f"Profile cascade points: {(df['group']=='profile_cascade').sum()}")
    print(f"Total: {len(df)}")
    print(f"gamma_loc_pred range: {df['gamma_loc_pred'].min():.3f} - {df['gamma_loc_pred'].max():.3f}")
    print(f"target_tu range: {df['target_tu'].min():.0f} - {df['target_tu'].max():.0f}")

    finish = {s: 0.0 for s in ALL_STREAM_NAMES}
    assign = {}
    for idx in df.sort_values('cost_a5000', ascending=False).index:
        best, best_t = None, None
        for name in ALL_STREAM_NAMES:
            cost = df.at[idx, 'cost_a5000'] * (G.ABI_SLOWDOWN if STREAM_CLASS[name] == '1080ti' else 1.0)
            t = finish[name] + cost
            if best_t is None or t < best_t:
                best, best_t = name, t
        finish[best] += df.at[idx, 'cost_a5000'] * (G.ABI_SLOWDOWN if STREAM_CLASS[best] == '1080ti' else 1.0)
        assign[idx] = best
    df['stream'] = pd.Series(assign)
    df = df.sort_values(['stream', 'cost_a5000']).reset_index(drop=True)

    print(f"Estimated makespan (x1.5 overhead): {max(finish.values())*1.5/60:.1f} min per stream")
    for name in ALL_STREAM_NAMES:
        n = (df['stream'] == name).sum()
        print(f"  {name}: {n} runs, ~{finish[name]*1.5/60:.1f} min")

    os.makedirs(SCRIPT_DIR, exist_ok=True)
    df.to_csv(os.path.join(SWEEP_DIR, 'tachyonic_manifest.csv'), index=False)
    for name, _, wdir in SINGLE_STREAMS:
        emit_single(name, wdir, df[df['stream'] == name],
                    os.path.join(SCRIPT_DIR, f'tachyonic_{name}.sh'))
    emit_abi({f'abi{g}': df[df['stream'] == f'abi{g}'] for g in range(3)},
             os.path.join(SCRIPT_DIR, 'tachyonic_abi.sh'))
    print(f"\nWritten scripts/tachyonic_{{t126,t133,t136,t140,abi}}.sh + sweep/tachyonic_manifest.csv")


if __name__ == '__main__':
    main()
