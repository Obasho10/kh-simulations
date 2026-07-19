#!/usr/bin/env python3
"""Generate the EPS-scan v2 campaign (Phase 1 of the plan in
/home/user/.claude/plans/splendid-scribbling-seal.md): a small, targeted GPU
validation of the Phase-0 CPU theory sweep (analysis/eps_collapse_theory.py),
NOT a brute-force grid. Reads sweep/eps_collapse_gridB.csv (75 (alpha,V0,EPS)
points x Model B theory prediction, produced by Phase 0 on the iMac) and
generates:

  A. 75 magnitude-check runs (one CUDA point each, at the theory-predicted
     continuous kz_peak snapped to the coarsest tier (int/half/quarter) that
     represents it to within 0.125 kz) -- tests gamma_sim vs gamma_theory.
  B. ~18 peak-location-refinement runs at 2 anchor points spanning the P
     range: int-tier bracket (nearest-integer +/-2, 5 pts) + half-tier
     flanking pair (+/-0.5 around the nearest half-integer) + quarter-tier
     flanking pair (+/-0.25 around the nearest quarter-integer), all centred
     on the theory's continuous peak -- tests whether the GPU-measured
     maximum converges to the continuous theory peak as the kz grid refines.

Window mechanism per point (from Grid B's window_type column): soft
xi_sponge (V0<=0.07) or hard xi_cut=5 (V0>=0.08 -- FINDINGS.md 2026-07-15,
the sponge fails a documented hard wall there; xi_cut is the CUDA-validated
fix, target_tu capped well below the documented ~90TU catastrophe onset).

NX/LX overrides: reuses the EPS/DX>=6 narrow-EPS boost and EPS>=0.30
box-doubling convention from the original (git-recovered, 06fd97d)
gen_epsscan_campaign.py. main_ym.cu tags nx_override/lx_override as
"_nx<N>"/"_lx<N>" in the output dir name (found stranded uncommitted on
t126/t133/t140, rescued into git 2026-07-19); remote_timeseries.py parses
that tag to reshape correctly instead of assuming the NX=768 default.

Nodes: t126, t133, t140 only (all confirmed idle A5000s; t130/t132 have
logged-in humans, abi is mid-campaign on an unrelated job -- see plan).

Output: scripts/epsscan_v2_{t126,t133,t140}.sh + sweep/epsscan_v2_manifest.csv
Launch each with: ssh -f <node> "cd <wdir> && nohup bash scripts/epsscan_v2_<node>.sh > logs/epsscan_v2_<node>.log 2>&1 &"
"""
import os, sys, math
import numpy as np
import pandas as pd

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..'))
SCRIPT_DIR = os.path.join(ROOT, 'scripts')
SWEEP_DIR = os.path.join(ROOT, 'sweep')
sys.path.insert(0, HERE)
import gen_recorrection_campaign as G   # wkb_gamma, cost model constants

STREAMS = [
    ("t126", "/DATA/cm/lcpfct/ymgpu2d"),
    ("t133", "/DATA/ym_kh/ymgpu2d"),
    ("t140", "/DATA/cm/lcpfct/ymgpu2d"),
]

# ---- tier definitions (int / half / quarter -- NOT the recorr "fine"=1/8 tier) ----
TIERS = {
    'int':     dict(lz=None,          nz=None, bp=G.BP_INT, mult=1),
    'half':    dict(lz=4 * math.pi,   nz=128,  bp=28,        mult=2),
    'quarter': dict(lz=8 * math.pi,   nz=256,  bp=56,        mult=4),  # NZ/4.5=56.9
}

# ---- x-resolution overrides (unchanged from the original epsscan campaign) ----
LX_DEFAULT, NX_SIM_DEFAULT = 6.0 * math.pi, 768
DX0 = LX_DEFAULT / NX_SIM_DEFAULT
EPS_WIDE_THRESHOLD = 0.30
LX_WIDE, NX_SIM_WIDE = 2.0 * LX_DEFAULT, 2 * NX_SIM_DEFAULT

XI_CUT_TU_CAP = 65.0   # FINDINGS.md 2026-07-15: xi_cut=5 catastrophe onset not
                       # observed before t~90 in any tested point; cap well under.


def nx_lx_for_eps(eps, ratio_min=6.0):
    """Returns (nx_override or None, lx_override or None)."""
    if eps >= EPS_WIDE_THRESHOLD:
        return NX_SIM_WIDE, LX_WIDE
    if eps / DX0 >= ratio_min:
        return None, None
    nx_needed = math.ceil(LX_DEFAULT * ratio_min / eps)
    return int(math.ceil(nx_needed / 64.0) * 64), None


def snap_tier(kz_continuous):
    """Coarsest tier (int/half/quarter) representing kz_continuous to within
    0.125 -- i.e. round to the nearest 0.25 first, then pick the loosest grid
    that lands exactly on that value."""
    snapped = round(kz_continuous * 4) / 4.0
    snapped = max(snapped, 0.25)
    if snapped == round(snapped):
        return 'int', snapped
    if (snapped * 2) == round(snapped * 2):
        return 'half', snapped
    return 'quarter', snapped


def ini_block(row, ini, stream, run_tag_extra=''):
    tier, kz = row['tier'], row['kz']
    mult = TIERS[tier]['mult']
    k_mode = int(round(kz * mult))
    nx, lx = nx_lx_for_eps(row['EPS'])
    run_tag = f"epsscanv2{run_tag_extra}"
    lines = [f"cat > {ini} <<'EOINI'",
             f"k_mode = {k_mode}",
             f"alpha_YM = {row['alpha']}",
             f"V0 = {row['V0']}",
             "perturb_amp = 0.001",
             "run_mode = 6"]
    if row['window_type'] == 'xi_cut':
        lines.append(f"xi_cut = {row['xi_w']}")
        lines.append("xi_sponge = 0")
    else:
        lines.append(f"xi_sponge = {row['xi_w']}")
        lines.append("sigma_sponge = 5.0")
    lines += ["suppress_kz0 = 1",
              "hyp_diff = 5e-5",
              f"kz_suppress_max = {k_mode - 1}",
              f"eps_override = {row['EPS']}",
              f"kz_suppress_hi = {TIERS[tier]['bp']}"]
    if TIERS[tier]['lz'] is not None:
        lines.append(f"lz_override = {TIERS[tier]['lz']:.6f}")
        lines.append(f"nz_override = {TIERS[tier]['nz']}")
    if nx is not None:
        lines.append(f"nx_override = {nx}")
    if lx is not None:
        lines.append(f"lx_override = {lx:.6f}")
    lines.append(f"target_tu = {row['target_tu']}")
    lines.append(f"run_tag = {run_tag}")
    lines.append("EOINI")
    tag = f"a={row['alpha']} V0={row['V0']} EPS={row['EPS']} kz={kz}({tier}) k={k_mode}"
    lines.append(f'echo "[{stream}] {tag} start $(date)" >> $LOG')
    lines.append(f"(cd $WDIR/outputs && $WDIR/ym_coupled {ini} >> $LOG 2>&1) || "
                 f'echo "[{stream}] {tag} CRASHED (exit $?) $(date)" >> $LOG')
    lines.append(f'(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py '
                 f'"ym_k{k_mode}_a{row["alpha"]:.3f}_*_v{row["V0"]:.4f}_*_{run_tag}" >> $LOG 2>&1)')
    lines.append(f'echo "[{stream}] {tag} done $(date)" >> $LOG')
    return "\n".join(lines) + "\n"


def target_tu_for(alpha, V0, kz, window_type):
    gw = G.wkb_gamma(alpha, V0, kz)
    tu = float(np.clip(15.0 / gw, 100, 400)) if gw > 0 else 250.0
    if window_type == 'xi_cut':
        tu = min(tu, XI_CUT_TU_CAP)
    return round(tu, 1)


def build_magnitude_check(df_b):
    rows = []
    for _, r in df_b.iterrows():
        if not np.isfinite(r['kz_peak']) or r['kz_peak'] <= 0:
            continue
        tier, kz = snap_tier(r['kz_peak'])
        rows.append(dict(alpha=r['alpha'], V0=r['V0'], EPS=r['EPS'], kz=kz, tier=tier,
                          xi_w=r['xi_w'], window_type=r['window_type'],
                          kz_peak_theory=r['kz_peak'], gamma_peak_theory=r['gamma_peak'],
                          P=r['P'], group='magnitude_check',
                          target_tu=target_tu_for(r['alpha'], r['V0'], kz, r['window_type'])))
    return pd.DataFrame(rows)


def pick_anchors(df_b, n=2):
    """Low-P and high-P representative points among the safe/finite ones."""
    valid = df_b[df_b['window_safe'] & np.isfinite(df_b['kz_peak']) & (df_b['kz_peak'] > 0)]
    valid = valid.sort_values('P')
    if len(valid) < n:
        return valid
    idx = np.linspace(0, len(valid) - 1, n).round().astype(int)
    return valid.iloc[idx]


def build_cascade(anchor_row):
    a, v, eps = anchor_row['alpha'], anchor_row['V0'], anchor_row['EPS']
    xi_w, wtype = anchor_row['xi_w'], anchor_row['window_type']
    kzc = anchor_row['kz_peak']
    rows = []

    def add(tier, kz):
        kz = max(round(kz * 4) / 4.0, 0.25)
        rows.append(dict(alpha=a, V0=v, EPS=eps, kz=kz, tier=tier, xi_w=xi_w,
                          window_type=wtype, kz_peak_theory=kzc,
                          gamma_peak_theory=anchor_row['gamma_peak'], P=anchor_row['P'],
                          group='cascade_anchor', target_tu=target_tu_for(a, v, kz, wtype)))

    kz_int = round(kzc)
    for d in (-2, -1, 0, 1, 2):
        if kz_int + d >= 1:
            add('int', float(kz_int + d))
    kz_half = round(kzc * 2) / 2.0
    for d in (-0.5, 0.5):
        if kz_half + d >= 0.25:
            add('half', kz_half + d)
    kz_quarter = round(kzc * 4) / 4.0
    for d in (-0.25, 0.25):
        if kz_quarter + d >= 0.25:
            add('quarter', kz_quarter + d)
    return pd.DataFrame(rows)


def dedup(df):
    key = list(zip(df['alpha'].round(3), df['V0'].round(4), df['EPS'].round(3),
                   df['tier'], df['kz'].round(3)))
    seen, keep = set(), []
    for i, k in enumerate(key):
        if k in seen:
            continue
        seen.add(k)
        keep.append(i)
    return df.iloc[keep].reset_index(drop=True)


def emit_stream(stream, wdir, pts, path):
    lines = ["#!/bin/bash",
             f"# EPS-scan v2 (theory-validation campaign) -- {stream}: {len(pts)} runs",
             f"WDIR={wdir}", "mkdir -p $WDIR/logs $WDIR/outputs",
             f"LOG=$WDIR/logs/epsscan_v2_{stream}_progress.log",
             'echo "=== epsscan_v2 start $(date) ===" >> $LOG']
    # ---- smoke test: binary + NX-tagged run_tag + fixed extractor all work ----
    lines.append(f"""cat > /tmp/epsscanv2_smoke_{stream}.ini <<'EOINI'
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
run_tag = smokev2{stream}_nx1152
EOINI
rm -rf $WDIR/outputs/ym_k2_a1.000*smokev2{stream}*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/epsscanv2_smoke_{stream}.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000*smokev2{stream}*" >> $LOG 2>&1)
python3 - "$WDIR" {stream} <<'EOPY' >> $LOG 2>&1 || {{ echo "[{stream}] SMOKE TEST FAILED -- stream ABORTED $(date)" >> $LOG; exit 1; }}
import csv, glob, math, sys
w, stream = sys.argv[1], sys.argv[2]
dirs = glob.glob(w + "/outputs/ym_k2_a1.000*smokev2" + stream + "*")
assert dirs, "smoke: no output dir written"
assert any("_nx1152" in d for d in dirs), "smoke: nx_override tag missing from dir name"
fs = glob.glob(w + "/outputs/ym_k2_a1.000*smokev2" + stream + "*/timeseries_k2.csv")
assert fs, "smoke: no timeseries written"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert rows and 'amp_conj' in rows[0], "smoke: extractor is not the fixed version"
a0 = float(rows[0]['amp'])
assert a0 > 0 and math.log(a0) > -20, "smoke: seed missing from measured channel (logamp=%.1f)" % (math.log(a0) if a0 > 0 else -99)
print("[%s] smoke test OK (nx_override tag + narrow-EPS + xi_cut/eps_override wiring): logamp0=%.1f" % (stream, math.log(a0)))
EOPY
rm -rf $WDIR/outputs/ym_k2_a1.000*smokev2{stream}*
""")
    for i, (_, r) in enumerate(pts.iterrows()):
        ini = f"/tmp/epsv2_{stream}_{i}_a{r['alpha']}_v{r['V0']}_eps{r['EPS']}_kz{r['kz']}.ini"
        lines.append(ini_block(r, ini, stream))
    lines.append(f'echo "=== {stream} ALL DONE $(date) ===" >> $LOG')
    with open(path, 'w') as f:
        f.write("\n".join(lines) + "\n")


def main():
    gb_path = os.path.join(SWEEP_DIR, 'eps_collapse_gridB.csv')
    if not os.path.exists(gb_path):
        print(f"ERROR: {gb_path} not found -- run Phase 0 (eps_collapse_theory.py --grid B) first",
              file=sys.stderr)
        sys.exit(1)
    df_b = pd.read_csv(gb_path)

    # Drop peak-finder failures: gamma_modelB has no resolvable bracket for
    # almost the whole kz range at some extrapolated corners (seen at
    # alpha=10, tight window) and find_continuous_peak can land on a small
    # spurious local max instead of returning nan -- flag by >50% deviation
    # from the point's own (alpha,V0) EPS-sibling median kz_peak.
    df_b['_bad'] = False
    for (a, v), g in df_b.groupby(['alpha', 'V0']):
        med = g['kz_peak'].median()
        dev = (g['kz_peak'] - med).abs() / med
        df_b.loc[g.index[dev > 0.5], '_bad'] = True
    n_bad = int(df_b['_bad'].sum())
    if n_bad:
        print(f"Dropping {n_bad} Grid B outlier point(s) (peak-finder failure): "
              f"{df_b[df_b['_bad']][['alpha','V0','EPS']].to_dict('records')}", file=sys.stderr)
    df_b = df_b[~df_b['_bad']].drop(columns=['_bad']).reset_index(drop=True)

    mag = build_magnitude_check(df_b)
    anchors = pick_anchors(df_b, n=2)
    cascades = pd.concat([build_cascade(r) for _, r in anchors.iterrows()], ignore_index=True) \
        if len(anchors) else pd.DataFrame()

    allpts = pd.concat([mag, cascades], ignore_index=True) if len(cascades) else mag
    allpts = dedup(allpts)

    print(f"Magnitude-check points: {len(mag)}")
    print(f"Cascade anchors: {list(zip(anchors['alpha'], anchors['V0'], anchors['EPS']))}")
    print(f"Cascade points (pre-dedup): {len(cascades)}")
    print(f"Total after dedup: {len(allpts)}")

    # cost + LPT across the 3 equal-speed A5000 streams
    allpts['cost'] = allpts['target_tu'] * allpts['tier'].map(
        lambda t: TIERS[t]['mult']) * G.SEC_PER_TU_A5000
    finish = {s[0]: 0.0 for s in STREAMS}
    assign = {}
    for idx in allpts.sort_values('cost', ascending=False).index:
        best = min(finish, key=finish.get)
        finish[best] += allpts.at[idx, 'cost']
        assign[idx] = best
    allpts['stream'] = pd.Series(assign)
    allpts = allpts.sort_values(['stream', 'cost']).reset_index(drop=True)

    print(f"Estimated makespan (x1.5 overhead): {max(finish.values())*1.5/60:.1f} min per stream")
    for name, _ in STREAMS:
        n = (allpts['stream'] == name).sum()
        print(f"  {name}: {n} runs, ~{finish[name]*1.5/60:.1f} min")

    os.makedirs(SCRIPT_DIR, exist_ok=True)
    allpts.to_csv(os.path.join(SWEEP_DIR, 'epsscan_v2_manifest.csv'), index=False)
    for name, wdir in STREAMS:
        emit_stream(name, wdir, allpts[allpts['stream'] == name],
                    os.path.join(SCRIPT_DIR, f'epsscan_v2_{name}.sh'))
    print(f"\nWritten scripts/epsscan_v2_{{t126,t133,t140}}.sh + sweep/epsscan_v2_manifest.csv")


if __name__ == '__main__':
    main()
