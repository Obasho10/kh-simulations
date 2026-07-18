#!/usr/bin/env python3
"""Generate the T1.1 EPS-scan campaign (staged 2026-07-18, queued to launch
right after the recorrection campaign frees up a node — see
RESEARCH_ROADMAP.md T1.1 and FINDINGS.md "EPS-scan status + next-up queue").

Question: is the fastest-growing wavelength set by the gauge coupling alpha
(kz_peak ~ 2*alpha, EPS-independent per the T1.2 exact-action theory) or by
the shear width EPS (classical-KH-like, kz_peak*EPS ~ const)? The previous
attempt (~07-13->07-16) is fully invalid (conjugate-helicity bug on every
timeseries + narrow-EPS legs predate the log_cosh_stable overflow fix) and
its field dumps were deleted -- nothing to salvage, full rerun needed.

Grid: EPS in {0.10, 0.15, 0.225, 0.30, 0.45} x alpha in {1.0, 2.0} x V0=0.05
x kz=1..8 (int tier, k_mode=kz, default Lz=2pi/NZ=64) = 80 points.

For each point this script:
  1. Runs the eigensolver-based safe-sponge hunt (find_safe_sponge.py) at
     that exact EPS (xi_sponge is in xi=(x-Lx/2)/EPS units, so the *value*
     needed is EPS-invariant in theory -- alpha, V0, kz alone set xi_crit and
     xi_char -- but the hunt is re-run per EPS anyway because it is a probe
     of the discrete eigensolver spectrum, which is NOT EPS-invariant: EPS/DX
     sets the solver's own resolution of both the KH mode and the tachyonic
     branch, exactly the resolution rule this scan is partly testing).
  2. Records the classified real (localised, "intended" shear-driven KH) and
     outer (delocalised, tachyonic Nielsen-Olesen) branches at that sponge,
     so the manifest carries a per-point tachyonic-contamination check before
     any GPU time is spent -- see analysis/eps_tachyon_scan.py for the fuller
     writeup of how EPS affects each branch.
  3. Picks nx_override to hold EPS/DX >= 6 (roadmap resolution rule); only
     EPS=0.10 needs it (36*pi/EPS grid points needed; default NX=768 already
     clears the bound for EPS>=0.15).
  4. For EPS>=0.30, doubles the domain (lx_override=12pi, nx_override=1536 to
     keep dx identical to every other leg) -- found 2026-07-18 that at the
     default 6pi box the periodic domain's own xi-half-width (3*pi/EPS)
     shrinks faster than the vetted xi_sponge does as EPS grows, so by
     EPS=0.45 the "safe" sponge (xi_sponge=21) sits AT the domain edge
     (edge_xi=20.94) -- it never activates, and the eigensolver's "no outer
     branch found" verdict there is a false negative, not evidence of a clean
     point. See eps_tachyon_scan.py's wrap_buffer check.
  5. Generates the matching 6-field eigenmode seed via `ym_eigenmode.py
     --export-seed` (EPS-tagged filename, see ym_eigenmode.py fix 2026-07-18
     -- old filenames had no EPS marker and would have silently collided;
     same fix applied for Lx, needed by point 4).

Output: scripts/epsscan_<node>.sh + seeds/eigenmode_seed_..._EPS*.bin +
sweep/epsscan_manifest.csv. Launch with:
  nohup bash scripts/epsscan_<node>.sh > logs/epsscan_<node>.log 2>&1 &
"""
import os, sys, math, subprocess, time
import numpy as np
import pandas as pd

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..'))
SCRIPT_DIR = os.path.join(ROOT, 'scripts')
SEED_DIR = os.path.join(ROOT, 'seeds')
SWEEP_DIR = os.path.join(ROOT, 'sweep')

sys.path.insert(0, HERE)
import ym_eigenmode as E
import find_safe_sponge as F

EPS_LIST = [0.10, 0.15, 0.225, 0.30, 0.45]
ALPHA_LIST = [1.0, 2.0]
V0 = 0.05
KZ_LIST = list(range(1, 9))

LX_DEFAULT = 6.0 * math.pi
NX_SIM_DEFAULT = 768
DX0 = LX_DEFAULT / NX_SIM_DEFAULT     # 0.02454 -- the resolution held fixed across every EPS leg
NX_SOLVER_DEFAULT = 384                # standard analysis-grid NX used throughout the project
BP_INT = 14              # NZ/4.5 rule at default NZ=64
SEC_PER_TU_A5000 = 0.87

# Node this campaign is staged for (single node -- whole scan is <2 GPU-h,
# no need to split across the recorr fleet). Swap freely at launch time.
STREAM = ("t126", "/DATA/cm/lcpfct/ymgpu2d")

# Wide-EPS box-size fix (found 2026-07-18, see eps_tachyon_scan.py "wrap_buffer"
# check): at the default LX=6pi, the periodic domain's own xi-half-width
# (3*pi/EPS) shrinks as EPS grows, and for EPS>=0.30 it gets too small to hold
# both a physical shear layer AND a sponge with any real decay buffer before
# the periodic wrap -- e.g. at EPS=0.45 the vetted xi_sponge (21) was found to
# sit at or past the domain edge (20.94) itself, i.e. the sponge never even
# activates and the eigensolver's "clean" verdict there is a false negative
# (nothing to find an outer branch IN, not evidence of no contamination).
# Fix: double the box for EPS>=0.30 (LX_WIDE=12pi) so the xi-half-width
# doubles too, and double NX in lockstep (NX_WIDE) so the physical dx is
# IDENTICAL to every other EPS leg (dx=DX0) -- this is purely a box-SIZE fix,
# not a resolution change.
EPS_WIDE_THRESHOLD = 0.30
LX_WIDE = 2.0 * LX_DEFAULT
NX_SIM_WIDE = 2 * NX_SIM_DEFAULT       # 1536, keeps dx == DX0 at the doubled box
NX_SOLVER_WIDE = 2 * NX_SOLVER_DEFAULT  # 768, keeps the solver's own dx matched too


def lx_for_eps(eps):
    return LX_WIDE if eps >= EPS_WIDE_THRESHOLD else LX_DEFAULT


def nx_solver_for_eps(eps):
    return NX_SOLVER_WIDE if eps >= EPS_WIDE_THRESHOLD else NX_SOLVER_DEFAULT


def nx_for_eps(eps, ratio_min=6.0):
    """Sim nx_override: -1 (use the LX-appropriate default) if that default
    already clears EPS/DX>=ratio_min at dx=DX0, else the smallest 64-multiple
    NX needed (this only ever fires for EPS=0.10, which needs a genuinely
    finer dx than DX0, not just a bigger box)."""
    lx = lx_for_eps(eps)
    nx_default = NX_SIM_WIDE if lx == LX_WIDE else NX_SIM_DEFAULT
    if eps / DX0 >= ratio_min:
        return nx_default if lx == LX_WIDE else -1  # wide legs must state nx_override explicitly
    nx_needed = math.ceil(lx * ratio_min / eps)
    return int(math.ceil(nx_needed / 64.0) * 64)


def build_grid():
    rows = []
    for alpha in ALPHA_LIST:
        for kz in KZ_LIST:
            for eps in EPS_LIST:
                rows.append(dict(alpha=alpha, V0=V0, kz=kz, EPS=eps))
    return pd.DataFrame(rows)


def analyze_point(alpha, V0, kz, eps, verbose=False):
    t0 = time.time()
    lx = lx_for_eps(eps)
    nx_solver = nx_solver_for_eps(eps)
    gw = E.wkb_growth_rate(float(kz), alpha, V0)
    old_lx = E.LX
    E.LX = lx   # find_safe_sponge.py / ym_eigenmode.py read the module-level LX
    try:
        sp_final, gamma_real, info = F.find_safe_xi_sponge(alpha, V0, float(kz), EPS=eps,
                                                            NX=nx_solver, verbose=verbose)
        found = F.hunt_eigs(float(kz), alpha, V0, eps, nx_solver, sp_final)
    finally:
        E.LX = old_lx
    real, outer = F.classify(found, gw)
    real_gamma_max = max((g for g, _ in real), default=float('nan'))
    outer_gamma_max = max((g for g, _ in outer), default=float('nan'))
    outer_xi_peak = None
    if outer:
        outer_xi_peak = max(outer, key=lambda p: p[0])[1]
    xi_char = 1.0 / math.sqrt(alpha * kz * V0) if alpha * kz * V0 > 0 else float('inf')
    xi_crit = kz / (alpha * V0) if alpha * V0 > 0 else float('inf')  # + ln2, see T1.2
    tu = float(np.clip(15.0 / gw, 100, 400)) if (np.isfinite(gw) and gw > 0) else 250.0
    nx_sim = nx_for_eps(eps)
    edge_xi = (lx / 2.0) / eps
    return dict(
        alpha=alpha, V0=V0, kz=kz, EPS=eps, k_mode=int(kz),
        xi_sponge=float(sp_final), gamma_wkb=gw, gamma_eig_real=real_gamma_max,
        gamma_eig_outer=outer_gamma_max, outer_xi_peak=outer_xi_peak,
        xi_char=xi_char, xi_crit=xi_crit, sponge_safe=bool(info.get('safe', False)),
        n_real=len(real), n_outer=len(outer), target_tu=round(tu, 1),
        nx_override=nx_sim, lx_override=(lx if lx != LX_DEFAULT else -1),
        edge_xi=edge_xi, wrap_buffer=edge_xi - float(sp_final),
        bp=BP_INT, cost_a5000=tu * SEC_PER_TU_A5000,
        hunt_seconds=round(time.time() - t0, 1),
    )


def gen_seed(row):
    alpha, eps, kz, sp = row['alpha'], row['EPS'], row['kz'], row['xi_sponge']
    lx = lx_for_eps(eps)
    nx_solver = nx_solver_for_eps(eps)
    cmd = [sys.executable, os.path.join(HERE, 'ym_eigenmode.py'),
           '--alpha', str(alpha), '--V0', str(V0), '--EPS', str(eps),
           '--kz', str(int(kz)), '--xi-sponge', str(sp), '--Lx', str(lx),
           '--NX', str(nx_solver), '--export-seed']
    out = subprocess.run(cmd, cwd=SEED_DIR, capture_output=True, text=True)
    fname = None
    for line in out.stdout.splitlines():
        if 'seed saved to' in line:
            fname = line.split('seed saved to')[-1].split()[0]
    if fname is None:
        print(f"  WARNING: no seed produced for alpha={alpha} EPS={eps} kz={kz}\n"
              f"  stdout tail: {out.stdout[-400:]}\n  stderr tail: {out.stderr[-400:]}",
              file=sys.stderr)
    return fname


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
eps_override = {EPS}
kz_suppress_hi = {bp}
{nx_line}{lx_line}target_tu = {target_tu}
seed_profile_file = $WDIR/seeds/{seed}
run_tag = epsscan
EOINI
echo "[{stream}] a={alpha} EPS={EPS} kz={kz} (sp={xi_sponge} tu={target_tu}) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled {ini} >> $LOG 2>&1) || echo "[{stream}] a={alpha} EPS={EPS} kz={kz} CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k{k_mode}_a{alpha:.3f}_*_v{V0:.4f}_*_epsscan" >> $LOG 2>&1)
echo "[{stream}] a={alpha} EPS={EPS} kz={kz} done $(date)" >> $LOG
"""

SMOKE_TEMPLATE = """# ---- smoke test: binary + fixed extractor + EPS/nx tagging all work ----
cat > /tmp/epsscan_smoke_{stream}.ini <<'EOINI'
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
eps_override = 0.10
nx_override = 1152
kz_suppress_hi = 14
target_tu = 2
run_tag = smoke{stream}
EOINI
rm -rf $WDIR/outputs/ym_k2_a1.000*smoke{stream}*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscan_smoke_{stream}.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000*smoke{stream}" >> $LOG 2>&1)
python3 - "$WDIR" {stream} <<'EOPY' >> $LOG 2>&1 || {{ echo "[{stream}] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }}
import csv, glob, math, sys
w, stream = sys.argv[1], sys.argv[2]
dirs = glob.glob(w + "/outputs/ym_k2_a1.000*smoke" + stream + "*")
assert dirs, "smoke: no output dir written"
assert any("_nx1152" in d for d in dirs), "smoke: nx_override not tagged in dir name (main_ym.cu fix missing)"
fs = glob.glob(w + "/outputs/ym_k2_a1.000*smoke" + stream + "*/timeseries_k2.csv")
assert fs, "smoke: no timeseries written"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert rows and 'amp_conj' in rows[0], "smoke: extractor is not the fixed version"
a0 = float(rows[0]['amp'])
assert a0 > 0 and math.log(a0) > -20, "smoke: seed missing from measured channel (logamp=%.1f)" % (math.log(a0) if a0 > 0 else -99)
print("[%s] smoke test OK (nx_override tagging + narrow-EPS cosh fix + extractor): logamp0=%.1f" % (stream, math.log(a0)))
EOPY
rm -rf $WDIR/outputs/ym_k2_a1.000*smoke{stream}*
"""


def emit_script(stream, wdir, pts, path):
    lines = ["#!/bin/bash",
             f"# T1.1 EPS-scan campaign -- {stream}: {len(pts)} runs (staged 2026-07-18)",
             f"# Launch: nohup bash scripts/epsscan_{stream}.sh > logs/epsscan_{stream}.log 2>&1 &",
             f"WDIR={wdir}",
             "mkdir -p $WDIR/logs $WDIR/outputs",
             f"LOG=$WDIR/logs/epsscan_{stream}_progress.log",
             'echo "=== epsscan start $(date) ===" >> $LOG',
             SMOKE_TEMPLATE.format(stream=stream)]
    for _, r in pts.iterrows():
        ini = f"/tmp/epsscan_{stream}_a{r['alpha']}_eps{r['EPS']}_kz{r['kz']}.ini"
        nx_line = f"nx_override = {int(r['nx_override'])}\n" if r['nx_override'] > 0 else ""
        lx_line = f"lx_override = {r['lx_override']:.6f}\n" if r['lx_override'] > 0 else ""
        lines.append(INI_TEMPLATE.format(
            ini=ini, stream=stream, k_mode=int(r['k_mode']), alpha=r['alpha'],
            V0=r['V0'], kz=r['kz'], EPS=r['EPS'], xi_sponge=r['xi_sponge'],
            kz_suppress_max=int(r['k_mode']) - 1, bp=int(r['bp']),
            target_tu=r['target_tu'], nx_line=nx_line, lx_line=lx_line,
            seed=r['seed_file']))
    lines.append(f'echo "=== {stream} ALL DONE $(date) ===" >> $LOG')
    with open(path, 'w') as f:
        f.write("\n".join(lines) + "\n")


def main():
    grid = build_grid()
    print(f"Analyzing {len(grid)} points (eigensolver safe-sponge hunt, "
          f"NX={NX_SOLVER_DEFAULT} std / {NX_SOLVER_WIDE} wide-EPS)...",
          file=sys.stderr)
    rows = []
    for i, r in grid.iterrows():
        rows.append(analyze_point(r['alpha'], r['V0'], r['kz'], r['EPS']))
        print(f"  [{i+1}/{len(grid)}] alpha={r['alpha']} EPS={r['EPS']} kz={r['kz']} "
              f"-> sp={rows[-1]['xi_sponge']:.0f} safe={rows[-1]['sponge_safe']} "
              f"gamma_real={rows[-1]['gamma_eig_real']:.3f} "
              f"gamma_outer={rows[-1]['gamma_eig_outer']:.3f} "
              f"({rows[-1]['hunt_seconds']:.1f}s)", file=sys.stderr)
    df = pd.DataFrame(rows)

    unsafe = df[~df['sponge_safe']]
    if len(unsafe):
        print(f"\nWARNING: {len(unsafe)} point(s) never reached a clean sponge ladder rung "
              f"(tachyonic branch not fully suppressible at this EPS/alpha/kz) -- "
              f"see manifest 'sponge_safe' column, review before trusting kz_peak(EPS) there:",
              file=sys.stderr)
        print(unsafe[['alpha', 'EPS', 'kz', 'xi_sponge', 'gamma_eig_outer']].to_string(),
              file=sys.stderr)

    print("\nGenerating eigenmode seeds...", file=sys.stderr)
    os.makedirs(SEED_DIR, exist_ok=True)
    seed_files = []
    for i, r in df.iterrows():
        fn = gen_seed(r)
        seed_files.append(fn)
        print(f"  [{i+1}/{len(df)}] -> {fn}", file=sys.stderr)
    df['seed_file'] = seed_files
    missing = df['seed_file'].isna().sum()
    if missing:
        print(f"\nERROR: {missing} seed(s) failed to generate -- fix before launching.",
              file=sys.stderr)

    df['tier'] = 'int'
    os.makedirs(SWEEP_DIR, exist_ok=True)
    os.makedirs(SCRIPT_DIR, exist_ok=True)
    df.to_csv(os.path.join(SWEEP_DIR, 'epsscan_manifest.csv'), index=False)

    stream, wdir = STREAM
    emit_script(stream, wdir, df, os.path.join(SCRIPT_DIR, f'epsscan_{stream}.sh'))

    tot_cost = df['cost_a5000'].sum()
    print(f"\nTotal runs: {len(df)}  (est. {tot_cost/3600:.2f} GPU-h on an A5000, "
          f"x1.5 for extraction overhead -> {tot_cost*1.5/3600:.2f} h wall)")
    print(f"Written scripts/epsscan_{stream}.sh + sweep/epsscan_manifest.csv + "
          f"{len(df) - missing} seed files in seeds/")
    print("NOTE: requires the main_ym.cu _nx<N> dir-tag fix and the remote_timeseries.py "
          "NX-parsing fix (both 2026-07-18) synced + rebuilt on the target node first -- "
          "see scripts/launch_after_recorr.sh.")


if __name__ == '__main__':
    main()
