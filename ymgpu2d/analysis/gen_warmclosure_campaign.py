#!/usr/bin/env python3
"""Generate the T1.4 warm-fluid-closure filters-off campaign (staged
2026-07-18, queued to launch right after the recorrection campaign frees up
a node -- see RESEARCH_ROADMAP.md T1.4 and FINDINGS.md "EPS-scan status +
next-up queue").

Question: the production measurement isolates a mode that is *subdominant*
in the cold system -- fluid two-stream (gamma~0.7-0.9), color-1 EM
(gamma~1.1), kz=0 chromo-Weibel (gamma~0.5) all grow faster and are only
kept from swamping the target mode by numerical filters (bandpass,
suppress_kz0's kz=0 z-mean subtraction AND its color-1 EM memset, and
hyperdiffusion). A referee's first question is "would this mode ever be
observed?" -- the physical answer is temperature: v_th >~ V0 should
stabilize the two-stream family via the isothermal pressure closure
(warm_T .ini key, P=n*T, c_s=sqrt(warm_T), merged 2026-07-18 from
worktree-warm-fluid-closure).

This is a C35 clone (alpha=2.0, V0=0.05, EPS=0.15, xi_sponge=11.0, mode 6,
kz=1..6 -- see scripts/run_campaign35_abi.sh) with ALL filters off
(suppress_kz0=0 disables both the kz=0 z-mean subtraction and the color-1 EM
memset; kz_suppress_max=0 and kz_suppress_hi=0 disable the bandpass) at four
warm_T legs: a cold control (warm_T=0, same as the T1.4 mode-2 test found:
filters-off cold is expected to be dominated by the fast channels) and
v_th/V0 in {2.0, 2.5, 3.0} (warm_T=(v_th)^2 since c_s=sqrt(warm_T) for this
isothermal P=n*T closure with unit-mass fluids).

NOTE: since warm_T has no tag of its own in the sim's output-directory naming
(main_ym.cu dir_ss), the four legs are disambiguated via run_tag instead
(warmcl_cold / warmcl_wt2p0 / warmcl_wt2p5 / warmcl_wt3p0) -- do not drop
this or same-kz runs at different warm_T will silently overwrite each other.

Compare gamma(kz) here against the filtered-cold C35 archive (FINDINGS.md,
"V0=0.05 complete series summary"); a warm eigensolver cross-check is NOT
yet implemented (would need fluid n/p degrees of freedom added to
ym_eigenmode.py's 6-field state vector -- a real extension, not a small
change, despite the roadmap's off-hand note; left as future work).

Output: scripts/warmclosure_<node>.sh + sweep/warmclosure_manifest.csv.
Launch with:
  nohup bash scripts/warmclosure_<node>.sh > logs/warmclosure_<node>.log 2>&1 &
"""
import os, sys
import pandas as pd

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..'))
SCRIPT_DIR = os.path.join(ROOT, 'scripts')
SWEEP_DIR = os.path.join(ROOT, 'sweep')

ALPHA = 2.0
V0 = 0.05
EPS = 0.15
XI_SPONGE = 11.0
KZ_LIST = list(range(1, 7))          # matches C35 exactly
TARGET_TU = 100
BP_OFF = 0

# (label, warm_T) -- v_th = sqrt(warm_T); v_th/V0 in {0 (cold control), 2, 2.5, 3}
WARM_LEGS = [
    ("cold", 0.0),
    ("wt2p0", round((2.0 * V0) ** 2, 6)),
    ("wt2p5", round((2.5 * V0) ** 2, 6)),
    ("wt3p0", round((3.0 * V0) ** 2, 6)),
]

# Node this campaign is staged for (separate from the eps-scan's t126 so both
# can run concurrently once nodes free up). Swap freely at launch time.
STREAM = ("t130", "/DATA/cm/lcpfct/ymgpu2d")


def build_grid():
    rows = []
    for kz in KZ_LIST:
        for label, wt in WARM_LEGS:
            rows.append(dict(alpha=ALPHA, V0=V0, EPS=EPS, kz=kz, k_mode=kz,
                             xi_sponge=XI_SPONGE, warm_T=wt, warm_label=label,
                             run_tag=f"warmcl_{label}",
                             seed_file=f"eigenmode_seed_kz{kz}_a2.00_V0.050_sp11.0.bin",
                             target_tu=TARGET_TU))
    return pd.DataFrame(rows)


INI_TEMPLATE = """cat > {ini} <<'EOINI'
k_mode = {k_mode}
alpha_YM = {alpha}
V0 = {V0}
perturb_amp = 0.001
run_mode = 6
xi_sponge = {xi_sponge}
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = {EPS}
kz_suppress_hi = 0
warm_T = {warm_T}
target_tu = {target_tu}
seed_profile_file = $WDIR/seeds/{seed}
run_tag = {run_tag}
EOINI
echo "[{stream}] kz={kz} warm_T={warm_T} ({warm_label}) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled {ini} >> $LOG 2>&1) || echo "[{stream}] kz={kz} warm_T={warm_T} CRASHED (exit $?, likely an unfiltered fast channel -- expected for the cold control) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k{k_mode}_a{alpha:.3f}_*_{run_tag}" >> $LOG 2>&1)
echo "[{stream}] kz={kz} warm_T={warm_T} ({warm_label}) done $(date)" >> $LOG
"""

SMOKE_TEMPLATE = """# ---- smoke test: binary + filters-off path + warm_T pressure term all work ----
cat > /tmp/warmcl_smoke_{stream}.ini <<'EOINI'
k_mode = 2
alpha_YM = 2.0
V0 = 0.05
perturb_amp = 0.001
run_mode = 6
xi_sponge = 11.0
sigma_sponge = 5.0
suppress_kz0 = 0
hyp_diff = 5e-5
kz_suppress_max = 0
eps_override = 0.15
kz_suppress_hi = 0
warm_T = 0.015625
target_tu = 2
seed_profile_file = $WDIR/seeds/eigenmode_seed_kz2_a2.00_V0.050_sp11.0.bin
run_tag = smoke{stream}
EOINI
rm -rf $WDIR/outputs/ym_k2_a2.000*smoke{stream}*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/warmcl_smoke_{stream}.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a2.000*smoke{stream}" >> $LOG 2>&1)
python3 - "$WDIR" {stream} <<'EOPY' >> $LOG 2>&1 || {{ echo "[{stream}] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }}
import csv, glob, math, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k2_a2.000*smoke" + stream + "*/timeseries_k2.csv")
assert fs, "smoke: no timeseries written (warm_T path or seed load likely broken)"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert rows and 'amp_conj' in rows[0], "smoke: extractor is not the fixed version"
a0 = float(rows[0]['amp'])
assert a0 > 0 and math.log(a0) > -20, "smoke: seed missing from measured channel (logamp=%.1f)" % (math.log(a0) if a0 > 0 else -99)
print("[%s] smoke test OK (filters-off + warm_T path): logamp0=%.1f" % (stream, math.log(a0)))
EOPY
rm -rf $WDIR/outputs/ym_k2_a2.000*smoke{stream}*
"""


def emit_script(stream, wdir, pts, path):
    lines = ["#!/bin/bash",
             f"# T1.4 warm-closure filters-off campaign -- {stream}: {len(pts)} runs "
             "(staged 2026-07-18)",
             f"# Launch: nohup bash scripts/warmclosure_{stream}.sh > "
             f"logs/warmclosure_{stream}.log 2>&1 &",
             f"WDIR={wdir}",
             "mkdir -p $WDIR/logs $WDIR/outputs",
             f"LOG=$WDIR/logs/warmclosure_{stream}_progress.log",
             'echo "=== warmclosure start $(date) ===" >> $LOG',
             SMOKE_TEMPLATE.format(stream=stream)]
    for _, r in pts.iterrows():
        ini = f"/tmp/warmcl_{stream}_kz{r['kz']}_{r['warm_label']}.ini"
        lines.append(INI_TEMPLATE.format(
            ini=ini, stream=stream, k_mode=int(r['k_mode']), alpha=r['alpha'],
            V0=r['V0'], kz=r['kz'], EPS=r['EPS'], xi_sponge=r['xi_sponge'],
            warm_T=r['warm_T'], warm_label=r['warm_label'], run_tag=r['run_tag'],
            target_tu=r['target_tu'], seed=r['seed_file']))
    lines.append(f'echo "=== {stream} ALL DONE $(date) ===" >> $LOG')
    with open(path, 'w') as f:
        f.write("\n".join(lines) + "\n")


def main():
    df = build_grid()
    os.makedirs(SWEEP_DIR, exist_ok=True)
    os.makedirs(SCRIPT_DIR, exist_ok=True)
    df.to_csv(os.path.join(SWEEP_DIR, 'warmclosure_manifest.csv'), index=False)

    stream, wdir = STREAM
    emit_script(stream, wdir, df, os.path.join(SCRIPT_DIR, f'warmclosure_{stream}.sh'))

    cellmult = 1  # int tier
    sec_per_tu_a5000 = 0.87
    tot_cost = (df['target_tu'] * cellmult * sec_per_tu_a5000).sum()
    print(f"Total runs: {len(df)} ({len(KZ_LIST)} kz x {len(WARM_LEGS)} warm_T legs)")
    print(f"Est. cost: {tot_cost/3600:.2f} GPU-h on an A5000 "
          f"(x1.5 extraction overhead -> {tot_cost*1.5/3600:.2f} h wall) "
          f"-- assumes no early crash; the cold-control leg is expected to "
          f"crash/saturate early once the unfiltered fast channels take over, "
          f"which only shortens it.")
    print(f"Written scripts/warmclosure_{stream}.sh + sweep/warmclosure_manifest.csv")
    print("Reuses the 6 existing C35 seeds in seeds/ (a2.00_V0.050_sp11.0) -- no "
          "new seed generation needed.")


if __name__ == '__main__':
    main()
