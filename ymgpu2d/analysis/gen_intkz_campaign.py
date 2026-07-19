#!/usr/bin/env python3
"""Generate the trimmed integer-kz campaign (2026-07-18, post-recorrection).

User-specified focus after the recorrection audit:
  - integer kz only, extended 1..12 (no sub-integer / half / fine tiers)
  - alpha > 0.3: 0.3..1.0 step 0.1, then 1.5..6.0 step 0.5  (18 values)
  - V0 = {0.03,0.04,0.05,0.07,0.08,0.10,0.20}  (dropped 0.01 & 0.02;
    new below-0.1 velocities 0.04/0.07/0.08)
  - nodes: t126,t132,t133,t140 (A5000) + abi x3 (1080Ti)  -- NOT t130
  - reuse the 158 already-measured valid int points from sweep/recorr_results.csv

Everything is int-tier so cellmult=1, bp=14, no lz/nz override. Reuses the
INI/SMOKE templates + emit_single/emit_abi from gen_recorrection_campaign so the
per-stream self-smoke-test (aborts on bad binary/extractor) is inherited.

Output: scripts/intkz_{t126,t132,t133,t140,abi}.sh + scripts/intkz_manifest.csv
"""
import os, sys, math
import numpy as np
import pandas as pd

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '..'))
SCRIPT_DIR = os.path.join(ROOT, 'scripts')
sys.path.insert(0, HERE)
import gen_recorrection_campaign as G   # templates, emit_single/emit_abi, cost model

VETTED = "/tmp/claude-1001/-home-user-kh-ymgpu2d/c827bb50-bf13-4f4e-80bd-ca451edb3cce/scratchpad/vetted_sponges.csv"

# streams: (name, class, workdir).  t132 rebuilt at the FULL path (the original
# recorr generator used "/DATA/ym_kh" without /ymgpu2d -- that was why t132 died).
STREAMS = [
    ("t126", "a5000",  "/DATA/cm/lcpfct/ymgpu2d"),
    ("t132", "a5000",  "/DATA/ym_kh/ymgpu2d"),
    ("t133", "a5000",  "/DATA/ym_kh/ymgpu2d"),
    ("t140", "a5000",  "/DATA/cm/lcpfct/ymgpu2d"),
    ("abi0", "1080ti", "/DATA/s23103/lcpfct/ymgpu2d"),
    ("abi1", "1080ti", "/DATA/s23103/lcpfct/ymgpu2d"),
    ("abi2", "1080ti", "/DATA/s23103/lcpfct/ymgpu2d"),
]

KZ = list(range(1, 10))   # integer kz 1..9 (kz>=10 dropped: under-resolved on NZ=64,
                          # decays; verified fixable only at NZ>=256, 4x cost -- not worth it)
ALPHA = sorted(set([round(x, 1) for x in np.arange(0.3, 1.001, 0.1)] +
                   [round(x, 1) for x in np.arange(1.5, 6.001, 0.5)]))
V0 = [0.03, 0.04, 0.05, 0.07, 0.08, 0.10, 0.20]


def build_grid():
    vmap = {}
    if os.path.exists(VETTED):
        vet = pd.read_csv(VETTED)
        vmap = {tuple(np.round(x, 3)): s for x, s in
                zip(vet[['alpha', 'V0', 'kz']].values, vet['xi_sponge'])}

    # points already measured with the corrected pipeline -> reuse, don't rerun
    done = set()
    rr = os.path.join(ROOT, 'sweep', 'recorr_results.csv')
    if os.path.exists(rr):
        d = pd.read_csv(rr)
        # Reuse any point with a measured positive growth rate (plateau OR max-R2
        # fit). For the abi rebalance "remaining" = not-yet-measured; re-running a
        # completed no-plateau point with identical settings won't add a plateau.
        d = d[(d.tier == 'int') & (d.gamma_sim > 1e-6)]
        done = set(zip(d.alpha.round(3), d.V0.round(4), d.kz.round(3)))

    rows, n_reuse = [], 0
    for v in V0:
        for a in ALPHA:
            for kz in KZ:
                key = (round(a, 3), round(v, 4), round(float(kz), 3))
                if key in done:
                    n_reuse += 1
                    continue
                xs = vmap.get((round(a, 3), round(v, 3), round(float(kz), 3)))
                if xs is None:
                    xi_char = 1.0 / math.sqrt(max(a * kz * v, 1e-12))
                    xs = min(max(8.0, math.ceil(3 * xi_char)), 14.0)
                gw = G.wkb_gamma(a, v, kz)
                tu = round(float(np.clip(15.0 / gw, 100, 400)) if gw > 0 else 250.0, 1)
                rows.append(dict(alpha=a, V0=v, kz=float(kz), tier='int',
                                 k_mode=int(kz), xi_sponge=float(xs), target_tu=tu,
                                 bp=G.BP_INT, cellmult=1,
                                 cost_a5000=tu * G.SEC_PER_TU_A5000))
    print(f"grid {len(KZ)*len(ALPHA)*len(V0)} pts; reuse {n_reuse}; to run {len(rows)}",
          file=sys.stderr)
    return pd.DataFrame(rows)


def main():
    df = build_grid()

    # speed-aware LPT assignment (abi x2.04)
    finish = {s[0]: 0.0 for s in STREAMS}
    cls = {s[0]: s[1] for s in STREAMS}
    assign = {}
    for idx in df.sort_values('cost_a5000', ascending=False).index:
        best, best_t = None, None
        for name, c, _ in STREAMS:
            cost = df.at[idx, 'cost_a5000'] * (G.ABI_SLOWDOWN if c == '1080ti' else 1.0)
            t = finish[name] + cost
            if best_t is None or t < best_t:
                best, best_t = name, t
        finish[best] += df.at[idx, 'cost_a5000'] * (G.ABI_SLOWDOWN if cls[best] == '1080ti' else 1.0)
        assign[idx] = best
    df['stream'] = pd.Series(assign)
    df['own_cost'] = [c * (G.ABI_SLOWDOWN if cls[s] == '1080ti' else 1.0)
                      for c, s in zip(df['cost_a5000'], df['stream'])]
    df = df.sort_values(['stream', 'own_cost']).reset_index(drop=True)

    print(f"\nTotal runs: {len(df)}")
    print("By V0:", df.groupby('V0').size().to_dict())
    print("By kz:", df.groupby('kz').size().to_dict())
    print(f"Makespan (x1.5 overhead): {max(finish.values())*1.5/3600:.1f} h")
    for name, c, _ in STREAMS:
        print(f"  {name:5s} ({c:6s}): {(df['stream']==name).sum():4d} runs, "
              f"~{finish[name]*1.5/3600:.1f} h")

    os.makedirs(SCRIPT_DIR, exist_ok=True)
    df.to_csv(os.path.join(SCRIPT_DIR, 'intkz_manifest.csv'), index=False)
    for name, c, wdir in STREAMS:
        if not name.startswith('abi'):
            G.emit_single(name, wdir, df[df['stream'] == name],
                          os.path.join(SCRIPT_DIR, f'intkz_{name}.sh'))
    G.emit_abi({f'abi{g}': df[df['stream'] == f'abi{g}'] for g in range(3)},
               os.path.join(SCRIPT_DIR, 'intkz_abi.sh'))
    print("\nWritten scripts/intkz_{t126,t132,t133,t140,abi}.sh + intkz_manifest.csv")


if __name__ == '__main__':
    main()
