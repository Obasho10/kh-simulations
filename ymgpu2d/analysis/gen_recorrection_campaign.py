#!/usr/bin/env python3
"""Generate the recorrection campaign (2026-07-18): rerun every measured
(alpha, V0, kz) point whose archived best measurement was extracted with the
conjugate-helicity bug (see FINDINGS.md 2026-07-17 "CRITICAL: two pipeline
bugs" + validation), with the fully corrected pipeline:

  - correct boxes:      int Lz=2pi/NZ=64, half Lz=4pi/NZ=128, fine Lz=16pi/NZ=512
                        (lz_override/nz_override ALWAYS emitted for stretched tiers)
  - tier-scaled bp:     14 / 28 / 112  (kz_suppress_hi <= NZ/4.5 rule, and full
                        physical coverage of the kz<=14 EM band on every tier)
  - tight sponges:      find_safe_sponge-vetted xi_sponge where precomputed
                        (suspectfix manifests, 1633 pts), else clip(3*xi_char, 8, 14)
  - fixed extraction:   remote_timeseries.py with the helicity fix + amp_conj
                        (deployed to all nodes; each stream SMOKE-TESTS binary +
                        extractor before starting and aborts loudly on failure)

Point selection from sweep/all_points_vs_chased.npz (the 4195 measured points):
  - skip points whose best archived series has a HEALTHY first amplitude
    (log amp[0] > -20, i.e. pre-07-04 extraction) AND a confirmed plateau
  - skip alpha <= 0.2 (noise-floor wall, unverified but expensive) EXCEPT an
    8-run probe (V0=0.05, kz in {1,2,4,6}, alpha in {0.1,0.2}) to test whether
    that wall was itself an extraction artifact

Output: scripts/recorr_{t126,t130,t132,t133,t140,abi}.sh + scripts/recorr_manifest.csv
Launch each with: nohup bash scripts/recorr_<node>.sh > logs/recorr_<node>.log 2>&1 &
"""
import os, re, sys, math, glob
import numpy as np
import pandas as pd

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..'))
SCRIPT_DIR = os.path.join(ROOT, 'scripts')
SCRATCH = "/tmp/claude-1001/-home-user-kh-ymgpu2d/c827bb50-bf13-4f4e-80bd-ca451edb3cce/scratchpad"

LZ_HALF, NZ_HALF, BP_HALF = 4 * math.pi, 128, 28
LZ_FINE, NZ_FINE, BP_FINE = 16 * math.pi, 512, 112
BP_INT = 14

SEC_PER_TU_A5000 = 0.87
ABI_SLOWDOWN = 9200.0 / 4500.0

STREAMS = [
    ("t126", "a5000", "/DATA/cm/lcpfct/ymgpu2d"),
    ("t130", "a5000", "/DATA/cm/lcpfct/ymgpu2d"),
    ("t132", "a5000", "/DATA/ym_kh"),
    ("t133", "a5000", "/DATA/ym_kh/ymgpu2d"),
    ("t140", "a5000", "/DATA/cm/lcpfct/ymgpu2d"),
    ("abi0", "1080ti", "/DATA/s23103/lcpfct/ymgpu2d"),
    ("abi1", "1080ti", "/DATA/s23103/lcpfct/ymgpu2d"),
    ("abi2", "1080ti", "/DATA/s23103/lcpfct/ymgpu2d"),
]

ALPHA_PROBE = [(0.1, 0.05, 1.0), (0.2, 0.05, 1.0), (0.1, 0.05, 2.0), (0.2, 0.05, 2.0),
               (0.1, 0.05, 4.0), (0.2, 0.05, 4.0), (0.1, 0.05, 6.0), (0.2, 0.05, 6.0)]


def wkb_gamma(alpha, V0, kz):
    C = np.sqrt(alpha**3 / 2.0) * V0
    roots = np.roots([1.0, 0.0, -kz**2, -C, -alpha**2 * V0 * kz])
    g = roots[roots.imag > 1e-10]
    return float(np.max(g.imag)) if len(g) else 0.0


def tier_of(kz):
    e = int(round(kz * 8))
    return "int" if e % 8 == 0 else ("half" if e % 8 == 4 else "fine")


def first_amp_healthy(node, source):
    """True if the archived best-row timeseries starts at a healthy amplitude
    (pre-07-04 correct extraction)."""
    for f in glob.glob(os.path.join(ROOT, 'remote_data', node, source + '*', 'timeseries_k*.csv')):
        try:
            df = pd.read_csv(f)
            a = df['amp'].values
            a = a[a > 0]
            if len(a) >= 3 and math.log(a[0]) > -20:
                return True
        except Exception:
            pass
    return False


def load_points():
    d = np.load(os.path.join(ROOT, 'sweep', 'all_points_vs_chased.npz'), allow_pickle=True)
    df = pd.DataFrame({k: d[k] for k in
                       ['V0', 'alpha', 'kz', 'has_plateau', 'source', 'node']})
    df = df.drop_duplicates(subset=['alpha', 'V0', 'kz']).reset_index(drop=True)

    healthy = np.array([first_amp_healthy(n, s) for n, s in zip(df['node'], df['source'])])
    skip_valid = healthy & df['has_plateau'].values
    print(f"{len(df)} measured points; {skip_valid.sum()} still-valid "
          f"(healthy extraction + plateau) -> skipped", file=sys.stderr)
    df = df[~skip_valid].copy()

    probe = set(ALPHA_PROBE)
    is_probe = [(round(a, 3), round(v, 3), round(k, 3)) in probe
                for a, v, k in zip(df['alpha'], df['V0'], df['kz'])]
    lowa = (df['alpha'] <= 0.2) & ~np.array(is_probe)
    print(f"dropping {lowa.sum()} alpha<=0.2 points (keeping {sum(is_probe)} probe runs)",
          file=sys.stderr)
    df = df[~lowa].copy().reset_index(drop=True)

    vet = pd.read_csv(os.path.join(SCRATCH, 'vetted_sponges.csv'))
    vet['key'] = [tuple(np.round(x, 3)) for x in vet[['alpha', 'V0', 'kz']].values]
    vmap = dict(zip(vet['key'], vet['xi_sponge']))

    rows = []
    for _, r in df.iterrows():
        a, v, kz = float(r['alpha']), float(r['V0']), float(r['kz'])
        tier = tier_of(kz)
        k_mode = int(round(kz * {'int': 1, 'half': 2, 'fine': 8}[tier]))
        xs = vmap.get((round(a, 3), round(v, 3), round(kz, 3)))
        if xs is None:
            xi_char = 1.0 / math.sqrt(max(a * kz * v, 1e-12))
            xs = min(max(8.0, math.ceil(3 * xi_char)), 14.0)
        gw = wkb_gamma(a, v, kz)
        tu = float(np.clip(15.0 / gw, 100, 400)) if gw > 0 else 250.0
        if tier == 'fine':
            tu = min(tu, 250.0)
        tu = round(tu, 1)
        cellmult = {'int': 1, 'half': 2, 'fine': 8}[tier]
        rows.append(dict(alpha=a, V0=v, kz=kz, tier=tier, k_mode=k_mode,
                         xi_sponge=float(xs), target_tu=tu,
                         bp={'int': BP_INT, 'half': BP_HALF, 'fine': BP_FINE}[tier],
                         cellmult=cellmult,
                         cost_a5000=tu * cellmult * SEC_PER_TU_A5000))
    out = pd.DataFrame(rows)
    return out


def lz_nz_block(tier):
    if tier == 'half':
        return f"lz_override = {LZ_HALF:.6f}\nnz_override = {NZ_HALF}\n"
    if tier == 'fine':
        return f"lz_override = {LZ_FINE:.6f}\nnz_override = {NZ_FINE}\n"
    return ""


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
eps_override = 0.15
kz_suppress_hi = {bp}
target_tu = {target_tu}
{lz_nz_block}run_tag = recorr
EOINI
echo "[{stream}] a={alpha} V0={V0} kz={kz} (tier={tier} k={k_mode} sp={xi_sponge} tu={target_tu}) start $(date)" >> $LOG
(cd $WDIR/outputs && $WDIR/ym_coupled {ini} >> $LOG 2>&1) || echo "[{stream}] a={alpha} V0={V0} kz={kz} CRASHED (exit $?) $(date)" >> $LOG
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k{k_mode}_a{alpha:.3f}_*_v{V0:.4f}_*_recorr" >> $LOG 2>&1)
echo "[{stream}] a={alpha} V0={V0} kz={kz} done $(date)" >> $LOG
"""

SMOKE_TEMPLATE = """# ---- smoke test: binary deposits seed + extractor measures the right channel ----
cat > /tmp/recorr_smoke_{stream}.ini <<'EOINI'
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
run_tag = smoke{stream}
EOINI
rm -rf $WDIR/outputs/ym_k2_a1.000*smoke{stream}*
(cd $WDIR/outputs && $WDIR/ym_coupled /tmp/recorr_smoke_{stream}.ini >> $LOG 2>&1)
(cd $WDIR/outputs && python3 ../analysis/remote_timeseries.py "ym_k2_a1.000*smoke{stream}" >> $LOG 2>&1)
python3 - "$WDIR" {stream} <<'EOPY' >> $LOG 2>&1 || {{ echo "[{stream}] SMOKE TEST FAILED — stream ABORTED $(date)" >> $LOG; exit 1; }}
import csv, glob, math, sys
w, stream = sys.argv[1], sys.argv[2]
fs = glob.glob(w + "/outputs/ym_k2_a1.000*smoke" + stream + "*/timeseries_k2.csv")
assert fs, "smoke: no timeseries written"
with open(fs[0]) as f:
    rows = list(csv.DictReader(f))
assert rows and 'amp_conj' in rows[0], "smoke: extractor is not the fixed version"
a0 = float(rows[0]['amp'])
assert a0 > 0 and math.log(a0) > -20, "smoke: seed missing from measured channel (logamp=%.1f)" % (math.log(a0) if a0 > 0 else -99)
print("[%s] smoke test OK: logamp0=%.1f" % (stream, math.log(a0)))
EOPY
rm -rf $WDIR/outputs/ym_k2_a1.000*smoke{stream}*
"""


def emit_single(stream, wdir, pts, path):
    lines = ["#!/bin/bash",
             f"# recorrection campaign -- {stream}: {len(pts)} runs (2026-07-18)",
             f"# Launch: nohup bash scripts/recorr_{stream}.sh > logs/recorr_{stream}.log 2>&1 &",
             f"WDIR={wdir}",
             "mkdir -p $WDIR/logs $WDIR/outputs",
             f"LOG=$WDIR/logs/recorr_{stream}_progress.log",
             'echo "=== recorr start $(date) ===" >> $LOG',
             SMOKE_TEMPLATE.format(stream=stream)]
    for _, r in pts.iterrows():
        ini = f"/tmp/recorr_{stream}_a{r['alpha']}_v{r['V0']}_kz{r['kz']}.ini"
        lines.append(INI_TEMPLATE.format(
            ini=ini, stream=stream, k_mode=int(r['k_mode']), alpha=r['alpha'],
            V0=r['V0'], kz=r['kz'], tier=r['tier'], xi_sponge=r['xi_sponge'],
            kz_suppress_max=int(r['k_mode']) - 1, bp=int(r['bp']),
            target_tu=r['target_tu'], lz_nz_block=lz_nz_block(r['tier'])))
    lines.append(f'echo "=== {stream} ALL DONE $(date) ===" >> $LOG')
    with open(path, 'w') as f:
        f.write("\n".join(lines) + "\n")


def emit_abi(assign, path):
    lines = ["#!/bin/bash", "# recorrection campaign -- abi (3 GPUs, 2026-07-18)",
             "WDIR=/DATA/s23103/lcpfct/ymgpu2d",
             "mkdir -p $WDIR/logs $WDIR/outputs", ""]
    for g in range(3):
        stream = f"abi{g}"
        pts = assign[stream]
        lines.append(f"run_gpu{g}() {{")
        lines.append(f"    export CUDA_VISIBLE_DEVICES={g}")
        lines.append("    WDIR=/DATA/s23103/lcpfct/ymgpu2d")
        lines.append(f"    LOG=$WDIR/logs/recorr_{stream}_progress.log")
        lines.append(f'    echo "=== recorr {stream} start $(date) ===" >> $LOG')
        # heredoc blocks must start at column 0 inside the function body
        lines.extend(SMOKE_TEMPLATE.format(stream=stream).split("\n"))
        for _, r in pts.iterrows():
            ini = f"/tmp/recorr_{stream}_a{r['alpha']}_v{r['V0']}_kz{r['kz']}.ini"
            block = INI_TEMPLATE.format(
                ini=ini, stream=stream, k_mode=int(r['k_mode']), alpha=r['alpha'],
                V0=r['V0'], kz=r['kz'], tier=r['tier'], xi_sponge=r['xi_sponge'],
                kz_suppress_max=int(r['k_mode']) - 1, bp=int(r['bp']),
                target_tu=r['target_tu'], lz_nz_block=lz_nz_block(r['tier']))
            lines.extend(block.split("\n"))
        lines.append(f'    echo "=== {stream} ALL DONE $(date) ===" >> $LOG')
        lines.append("}")
        lines.append("")
    lines.append('echo "=== abi: launching 3-GPU recorrection campaign $(date) ==="')
    for g in range(3):
        lines.append(f"run_gpu{g} & PID{g}=$!")
    for g in range(3):
        lines.append(f"wait $PID{g} && echo 'GPU{g} finished' || echo 'GPU{g} FAILED'")
    with open(path, 'w') as f:
        f.write("\n".join(lines) + "\n")


def main():
    df = load_points()

    # LPT assignment, speed-aware
    finish = {s[0]: 0.0 for s in STREAMS}
    cls = {s[0]: s[1] for s in STREAMS}
    assign_idx = {}
    for idx in df.sort_values('cost_a5000', ascending=False).index:
        best, best_t = None, None
        for name, c, _ in STREAMS:
            cost = df.at[idx, 'cost_a5000'] * (ABI_SLOWDOWN if c == '1080ti' else 1.0)
            t = finish[name] + cost
            if best_t is None or t < best_t:
                best, best_t = name, t
        finish[best] += df.at[idx, 'cost_a5000'] * (ABI_SLOWDOWN if cls[best] == '1080ti' else 1.0)
        assign_idx[idx] = best
    df['stream'] = pd.Series(assign_idx)
    df['own_cost'] = [c * (ABI_SLOWDOWN if cls[s] == '1080ti' else 1.0)
                      for c, s in zip(df['cost_a5000'], df['stream'])]
    df = df.sort_values(['stream', 'own_cost']).reset_index(drop=True)

    print(f"\nTotal runs: {len(df)}")
    print("By tier:", df['tier'].value_counts().to_dict())
    print("By V0:", df.groupby('V0').size().to_dict())
    tot = sum(finish.values())
    print(f"Total GPU-cost: {tot/3600:.0f} eq-hours; makespan estimate "
          f"(x1.5 extraction overhead): {max(finish.values())*1.5/3600:.1f} h")
    for name, c, _ in STREAMS:
        n = (df['stream'] == name).sum()
        print(f"  {name:5s} ({c:6s}): {n:4d} runs, ~{finish[name]*1.5/3600:.1f} h")

    os.makedirs(SCRIPT_DIR, exist_ok=True)
    df.to_csv(os.path.join(SCRIPT_DIR, 'recorr_manifest.csv'), index=False)
    for name, c, wdir in STREAMS:
        if not name.startswith('abi'):
            emit_single(name, wdir, df[df['stream'] == name],
                        os.path.join(SCRIPT_DIR, f'recorr_{name}.sh'))
    emit_abi({f'abi{g}': df[df['stream'] == f'abi{g}'] for g in range(3)},
             os.path.join(SCRIPT_DIR, 'recorr_abi.sh'))
    print(f"\nWritten scripts/recorr_{{t126,t130,t132,t133,t140,abi}}.sh + recorr_manifest.csv")


if __name__ == '__main__':
    main()
