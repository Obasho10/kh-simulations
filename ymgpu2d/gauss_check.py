#!/usr/bin/env python3
"""
Verify and plot conservation of the non-Abelian Gauss law constraint:

    G^a ≡ ∂_x Ex^a + ∂_z Ez^a + α(Az × Ez)^a − ρ^a = 0

where ρ^a = Q^a_A·nA + Q^a_B·nB is the color charge density from both beams
and (Az×Ez)^a = ε^abc Az^b Ez^c is the non-Abelian correction.

Requires the 25-column CSV format (C36+ runs: added Ex/Ez/n/Q2/Q3).

Usage:
    python3 gauss_check.py <run_dir> [--alpha A] [--V0 V] [--EPS E] [--stride N]

The script produces:
  - Time series of RMS(G^a) for each color a=1,2,3
  - Individual term breakdown (div E, non-Abelian, charge density)
  - Relative error: RMS(G^a) / RMS(∇·E^a + α(Az×Ez)^a)
  - Spatial map of G^a at the midpoint snapshot
"""
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import glob, re, os, sys
from pathlib import Path

# ── grid constants (fast default) ────────────────────────────────────────────
NX_DEFAULT = 768
NZ_DEFAULT = 64
LX = 6 * np.pi
LZ = 2 * np.pi

def az1_background(x_centers, V0, EPS):
    """Az1 = -V0 * log(cosh(ξ)), ξ = (x - Lx/2)/EPS — NAB_CIRC_AZ2 frozen field."""
    xi = (x_centers - LX / 2) / EPS
    return -V0 * np.log(np.cosh(xi))

def load_and_compute(csv_path, alpha, V0, EPS, NX, NZ):
    DX = LX / NX
    DZ = LZ / NZ

    df = pd.read_csv(csv_path)
    r  = lambda col: df[col].values.reshape(NZ, NX)

    # Electric fields — Yee staggered: Ex at (x+½,z), Ez at (x,z+½)
    Ex1 = r('Ex1'); Ex2 = r('Ex2'); Ex3 = r('Ex3')
    Ez1 = r('Ez1'); Ez2 = r('Ez2'); Ez3 = r('Ez3')

    # Potentials (cell centres)
    Az2 = r('Az2'); Az3 = r('Az3')

    # Fluid quantities
    nA  = r('nA');  nB  = r('nB')
    Q1A = r('Q1A'); Q2A = r('Q2A'); Q3A = r('Q3A')
    Q1B = r('Q1B'); Q2B = r('Q2B'); Q3B = r('Q3B')

    # Reconstruct frozen Az1 background at cell-centre x positions
    x_c = (np.arange(NX) + 0.5) * DX
    Az1 = np.tile(az1_background(x_c, V0, EPS), (NZ, 1))   # (NZ, NX)

    # ── ∂_x Ex + ∂_z Ez on Yee grid (periodic BC) ────────────────────────
    # Ex at (i+½, j):  ∂_x Ex[i,j] = (Ex[i+½] − Ex[i−½]) / DX
    def divE(Ex, Ez):
        return (Ex - np.roll(Ex, 1, axis=1)) / DX \
             + (Ez - np.roll(Ez, 1, axis=0)) / DZ

    dE1 = divE(Ex1, Ez1)
    dE2 = divE(Ex2, Ez2)
    dE3 = divE(Ex3, Ez3)

    # ── α(Az × Ez)^a — average Ez from z+½ face to cell centre ──────────
    def face_to_centre_z(Ez):
        return 0.5 * (Ez + np.roll(Ez, 1, axis=0))

    Ez1c = face_to_centre_z(Ez1)
    Ez2c = face_to_centre_z(Ez2)
    Ez3c = face_to_centre_z(Ez3)

    # (Az × Ez)^a = ε^abc Az^b Ez^c
    nab1 = alpha * (Az2 * Ez3c - Az3 * Ez2c)
    nab2 = alpha * (Az3 * Ez1c - Az1 * Ez3c)
    nab3 = alpha * (Az1 * Ez2c - Az2 * Ez1c)

    # ── charge density ρ^a = Q^a_A nA + Q^a_B nB ─────────────────────────
    rho1 = Q1A * nA + Q1B * nB
    rho2 = Q2A * nA + Q2B * nB
    rho3 = Q3A * nA + Q3B * nB

    # ── Gauss residuals G^a = ∇·E^a + α(Az×Ez)^a − ρ^a ──────────────────
    G1 = dE1 + nab1 - rho1
    G2 = dE2 + nab2 - rho2
    G3 = dE3 + nab3 - rho3

    # ── normalisation: total LHS magnitude ───────────────────────────────
    lhs1 = dE1 + nab1
    lhs2 = dE2 + nab2
    lhs3 = dE3 + nab3

    # Total E-field derivative scale (all colours combined) — used to normalise
    # G^a so that the relative error is meaningful even when ρ^a≈0 (neutral plasma).
    # G^a has units of E/length; Etot_scale ≈ rms(all Ex,Ez)/DX has the same units.
    DX = LX / NX
    all_E = (np.abs(Ex1)+np.abs(Ex2)+np.abs(Ex3)
           + np.abs(Ez1)+np.abs(Ez2)+np.abs(Ez3))
    Etot_scale = rms(all_E) / DX + 1e-30

    return dict(G1=G1, G2=G2, G3=G3,
                dE1=dE1, dE2=dE2, dE3=dE3,
                nab1=nab1, nab2=nab2, nab3=nab3,
                rho1=rho1, rho2=rho2, rho3=rho3,
                lhs1=lhs1, lhs2=lhs2, lhs3=lhs3,
                Etot_scale=Etot_scale,
                Az1=Az1, Az2=Az2, Az3=Az3)

rms = lambda a: np.sqrt(np.mean(a**2))

# ── CLI ───────────────────────────────────────────────────────────────────────
args = sys.argv[1:]
run_dir = args[0] if args else '.'
alpha = 2.5; V0 = 0.05; EPS = 0.15; stride_arg = 0

m = re.search(r'_a([0-9.]+)_', run_dir)
if m: alpha = float(m.group(1))
m = re.search(r'_v([0-9.]+)[_/]', run_dir)
if m: V0 = float(m.group(1))

i = 1
while i < len(args):
    if args[i] == '--alpha': alpha = float(args[i+1]); i += 2
    elif args[i] == '--V0':  V0    = float(args[i+1]); i += 2
    elif args[i] == '--EPS': EPS   = float(args[i+1]); i += 2
    elif args[i] == '--stride': stride_arg = int(args[i+1]); i += 2
    else: i += 1

print(f"α={alpha}  V0={V0}  EPS={EPS}  run_dir={run_dir}")

# ── find snapshots ────────────────────────────────────────────────────────────
csvs = sorted(glob.glob(f'{run_dir}/ym_*.csv'))
if not csvs:
    sys.exit(f"No ym_*.csv in {run_dir}")

# Check column count
hdr = pd.read_csv(csvs[0], nrows=0)
if 'Ex1' not in hdr.columns:
    sys.exit("ERROR: CSV lacks Ex1 column — need 25-col format (Campaign 36+).\n"
             "Run with the updated binary (commit deee2a5).")

# Infer NX/NZ from first snapshot
df0 = pd.read_csv(csvs[0])
NX = int(df0['X'].nunique())
NZ = int(len(df0) // NX)
print(f"Grid: NX={NX}  NZ={NZ}")

# Infer DT from energy.csv
dt_run = LX / NX * 0.1          # fallback: courant=0.1
efile  = f'{run_dir}/energy.csv'
if os.path.exists(efile):
    edf = pd.read_csv(efile)
    if len(edf) >= 2:
        dt_run = float(edf['time'].iloc[-1] - edf['time'].iloc[0]) / \
                 float(edf['step'].iloc[-1] - edf['step'].iloc[0])

# Choose stride: aim for ~60 evaluation points
stride = stride_arg if stride_arg > 0 else max(1, len(csvs) // 60)
csvs_use = csvs[::stride]
print(f"Processing {len(csvs_use)}/{len(csvs)} snapshots (stride={stride}) ...")

# ── time-series loop ──────────────────────────────────────────────────────────
times   = []
rG       = {1: [], 2: [], 3: []}
rdE      = {1: [], 2: [], 3: []}
rnab     = {1: [], 2: [], 3: []}
rrho     = {1: [], 2: [], 3: []}
rlhs     = {1: [], 2: [], 3: []}
rEtot    = []

for csv in csvs_use:
    step = int(re.search(r'\d+', Path(csv).stem).group())
    t    = step * dt_run
    d    = load_and_compute(csv, alpha, V0, EPS, NX, NZ)
    times.append(t)
    for a in (1, 2, 3):
        rG  [a].append(rms(d[f'G{a}']))
        rdE [a].append(rms(d[f'dE{a}']))
        rnab[a].append(rms(d[f'nab{a}']))
        rrho[a].append(rms(d[f'rho{a}']))
        rlhs[a].append(rms(d[f'lhs{a}']))
    rEtot.append(d['Etot_scale'])

times  = np.array(times)
rEtot  = np.array(rEtot)
for d_ in (rG, rdE, rnab, rrho, rlhs):
    for a in (1, 2, 3):
        d_[a] = np.array(d_[a])

# spatial snapshot at midpoint
mid_csv = csvs_use[len(csvs_use) // 2]
mid_step = int(re.search(r'\d+', Path(mid_csv).stem).group())
t_mid = mid_step * dt_run
mid = load_and_compute(mid_csv, alpha, V0, EPS, NX, NZ)

# ── plot ──────────────────────────────────────────────────────────────────────
colors = {1: '#1f77b4', 2: '#d62728', 3: '#2ca02c'}
clabs  = {1: 'a=1', 2: 'a=2', 3: 'a=3'}

fig = plt.figure(figsize=(16, 11))
fig.suptitle(
    f'SU(2) Non-Abelian Gauss Law: ∂ₓEx^a + ∂zEz^a + α(Az×Ez)^a − ρ^a = 0\n'
    f'α={alpha}, V₀={V0}, EPS={EPS}   [{os.path.basename(run_dir.rstrip("/"))}]',
    fontsize=12, fontweight='bold', y=1.01)

gs = fig.add_gridspec(3, 3, hspace=0.45, wspace=0.38)

# ─ row 0: RMS Gauss residuals ──────────────────────────────────────────────
ax0 = fig.add_subplot(gs[0, :2])
for a in (1, 2, 3):
    ax0.semilogy(times, rG[a], color=colors[a], lw=2, label=f'|G^{a}|_rms')
ax0.set_xlabel('t (TU)'); ax0.set_ylabel('RMS residual')
ax0.set_title('Gauss residual G^a = ∇·Eᵃ + α(Az×Ez)ᵃ − ρᵃ')
ax0.legend(fontsize=10); ax0.grid(True, alpha=0.3)

ax0r = fig.add_subplot(gs[0, 2])
# Use peak E-scale as floor so t=0 (E=0) doesn't blow up the plot
Etot_floor = max(rEtot.max() * 1e-8, 1e-20)
Etot_norm  = np.maximum(rEtot, Etot_floor)
for a in (1, 2, 3):
    # Normalise by total E-field derivative scale (all 3 colors combined).
    # For a charge-neutral plasma ρ^a≈0, LHS≈G by construction — using the
    # total field scale avoids this degeneracy and gives a true fractional error.
    rel = rG[a] / Etot_norm
    ax0r.semilogy(times, np.where(rel > 1e-14, rel, 1e-14),
                  color=colors[a], lw=2, label=clabs[a])
ax0r.axhline(1e-3, color='k', ls='--', alpha=0.5, lw=1, label='0.1%')
ax0r.axhline(1e-2, color='r', ls='--', alpha=0.4, lw=1, label='1%')
ax0r.set_xlabel('t (TU)'); ax0r.set_ylabel('|G^a| / Etot_scale')
ax0r.set_title('Relative Gauss error\n(÷ rms(all |E|)/DX — total-field scale)')
ax0r.legend(fontsize=9); ax0r.grid(True, alpha=0.3)

# ─ row 1: per-color term breakdown ────────────────────────────────────────
for col, a in enumerate((1, 2, 3)):
    ax = fig.add_subplot(gs[1, col])
    ax.semilogy(times, rdE [a], color='steelblue',  lw=1.5, ls='-',  label='|∇·Eᵃ|')
    ax.semilogy(times, rnab[a], color='tomato',     lw=1.5, ls='--', label='|α(Az×Ez)ᵃ|')
    ax.semilogy(times, rrho[a], color='seagreen',   lw=1.5, ls=':',  label='|ρᵃ|')
    ax.semilogy(times, rG  [a], color='black',      lw=2,   ls='-',  label='|Gᵃ| (residual)')
    ax.set_title(f'Color {a} term breakdown')
    ax.set_xlabel('t (TU)'); ax.set_ylabel('RMS')
    ax.legend(fontsize=8); ax.grid(True, alpha=0.3)

# ─ row 2: spatial maps of G^a at midpoint ────────────────────────────────
x_c = (np.arange(NX) + 0.5) * LX / NX
z_c = (np.arange(NZ) + 0.5) * LZ / NZ
extent = [x_c[0], x_c[-1], z_c[0], z_c[-1]]

for col, a in enumerate((1, 2, 3)):
    ax = fig.add_subplot(gs[2, col])
    Gmap = mid[f'G{a}']
    vmax = max(np.abs(Gmap).max(), 1e-12)
    im = ax.imshow(Gmap, origin='lower', extent=extent,
                   aspect='auto', cmap='RdBu_r', vmin=-vmax, vmax=vmax)
    plt.colorbar(im, ax=ax, shrink=0.85, pad=0.02)
    ax.set_xlabel('x'); ax.set_ylabel('z')
    ax.set_title(f'G^{a} spatial map  (t={t_mid:.1f} TU)\nvmax={vmax:.2e}')

plt.savefig(f'gauss_check.png', dpi=140, bbox_inches='tight')
print("Saved gauss_check.png")

# ── summary statistics ────────────────────────────────────────────────────────
print("\n── Gauss law summary ──────────────────────────────────────────")
print(f"{'Color':<8} {'G_init':>10} {'G_mid':>10} {'G_final':>10}  "
      f"{'rel_init':>10} {'rel_final':>10}  (rel = |G|/E_scale)")
for a in (1, 2, 3):
    rel0  = rG[a][ 0] / Etot_norm[ 0]
    relf  = rG[a][-1] / Etot_norm[-1]
    print(f"  a={a}   {rG[a][0]:>10.3e} {rG[a][len(rG[a])//2]:>10.3e} "
          f"{rG[a][-1]:>10.3e}   {rel0:>10.3e}   {relf:>10.3e}")
