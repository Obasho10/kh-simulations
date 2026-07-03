#!/usr/bin/env python3
"""
Comprehensive non-Abelian KH dispersion plot: all campaigns C34-C38 + C32/C33 extensions.
Shows γ(kz) with exact eigenvalue lines and simulation circles; inset shows kz_peak migration.
"""
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
from matplotlib.lines import Line2D

# ── sim γ values from exponential fitting (R²≥0.993 everywhere) ──────────────
campaigns = {
    # label, V0, alpha, xi_sponge, kz_list, gamma_sim, gamma_exact
    'C34': dict(V0=0.05, alpha=1.5, sp=12,
        kz=  [1,      2,      3,      4,      5,      6],
        gsim=[0.0871, 0.1257, 0.1397, 0.1241, 0.1087, 0.0951],
        gex= [0.0878, 0.1274, 0.1418, 0.1261, 0.1114, 0.0992]),
    'C35': dict(V0=0.05, alpha=2.0, sp=11,
        kz=  [1,      2,      3,      4,      5,      6],
        gsim=[0.0845, 0.1334, 0.1510, 0.1564, 0.1553, 0.1347],
        gex= [0.0862, 0.1344, 0.1529, 0.1597, 0.1602, 0.1419]),
    'C32': dict(V0=0.05, alpha=2.5, sp=9,
        kz=  [1,      2,      3,      4,      5,      6,      7,      8],
        gsim=[0.0823, 0.1345, 0.1557, 0.1641, 0.1642, 0.1594, 0.1493, 0.1395],
        gex= [0.0837, 0.1359, 0.1579, 0.1674, 0.1701, 0.1687, 0.1652, 0.1605]),
    'C33': dict(V0=0.05, alpha=3.0, sp=8,
        kz=  [1,      2,      3,      4,      5,      6,      7,      8],
        gsim=[0.0790, 0.1359, 0.1599, 0.1709, 0.1727, 0.1686, 0.1587, 0.1485],
        gex= [0.0808, 0.1374, 0.1625, 0.1743, 0.1787, 0.1786, 0.1760, 0.1719]),
    'C36': dict(V0=0.03, alpha=3.0, sp=5,
        kz=  [1,      2,      3,      4,      5,      6,      7,      8,      9],
        gsim=[0.0475, 0.0819, 0.0983, 0.1070, 0.1107, 0.1099, 0.1063, 0.0994, 0.0799],
        gex= [0.0542, 0.0824, 0.0992, 0.1093, 0.1149, 0.1175, 0.1181, 0.1174, 0.1159]),
    'C37': dict(V0=0.03, alpha=4.0, sp=5,
        kz=  [1,      2,      3,      4,      5,      6,      7,      8,      9],
        gsim=[0.0507, 0.0885, 0.1069, 0.1175, 0.1221, 0.1222, 0.1189, 0.1131, 0.0938],
        gex= [0.0572, 0.0890, 0.1083, 0.1201, 0.1271, 0.1309, 0.1323, 0.1322, 0.1311]),
    'C38': dict(V0=0.03, alpha=5.0, sp=5,
        kz=  [1,      2,      3,      4,      5,      6,      7,      8,      9],
        gsim=[0.0525, 0.0935, 0.1137, 0.1261, 0.1316, 0.1323, 0.1294, 0.1237, 0.1026],
        gex= [0.0589, 0.0941, 0.1155, 0.1288, 0.1371, 0.1418, 0.1441, 0.1445, 0.1438]),
}

# ── colours: V0=0.05 → blues, V0=0.03 → reds/oranges ────────────────────────
colors_05 = ['#2166ac', '#4393c3', '#74add1', '#abd9e9']   # α=1.5,2.0,2.5,3.0
colors_03 = ['#d73027', '#f46d43', '#fdae61']              # α=3.0,4.0,5.0
label_05 = ['α=1.5', 'α=2.0', 'α=2.5', 'α=3.0']
label_03 = ['α=3.0', 'α=4.0', 'α=5.0']

order_05 = ['C34', 'C35', 'C32', 'C33']
order_03 = ['C36', 'C37', 'C38']

fig = plt.figure(figsize=(14, 10))
gs = gridspec.GridSpec(2, 2, hspace=0.35, wspace=0.35,
                       height_ratios=[2.5, 1])

ax1 = fig.add_subplot(gs[0, 0])   # V0=0.05 dispersion
ax2 = fig.add_subplot(gs[0, 1])   # V0=0.03 dispersion
ax3 = fig.add_subplot(gs[1, :])   # peak migration

# ── Panel 1: V0 = 0.05 ───────────────────────────────────────────────────────
for (name, col, lbl) in zip(order_05, colors_05, label_05):
    d = campaigns[name]
    kz, gs_, ge = np.array(d['kz']), np.array(d['gsim']), np.array(d['gex'])
    ax1.plot(kz, ge, '-', color=col, lw=2.0, label=lbl)
    ax1.plot(kz, gs_, 'o', color=col, ms=7, zorder=5)

ax1.set_xlabel('kz', fontsize=13)
ax1.set_ylabel('γ (TU⁻¹)', fontsize=13)
ax1.set_title('V₀ = 0.05,  EPS = 0.15', fontsize=13, fontweight='bold')
ax1.legend(fontsize=11, loc='upper right')
ax1.set_xlim(0.5, 8.5)
ax1.set_ylim(0, 0.21)
ax1.xaxis.set_major_locator(plt.MultipleLocator(1))
ax1.grid(True, alpha=0.3)

# ── Panel 2: V0 = 0.03 ───────────────────────────────────────────────────────
for (name, col, lbl) in zip(order_03, colors_03, label_03):
    d = campaigns[name]
    kz, gs_, ge = np.array(d['kz']), np.array(d['gsim']), np.array(d['gex'])
    ax2.plot(kz, ge, '-', color=col, lw=2.0, label=lbl)
    ax2.plot(kz, gs_, 'o', color=col, ms=7, zorder=5)

ax2.set_xlabel('kz', fontsize=13)
ax2.set_ylabel('γ (TU⁻¹)', fontsize=13)
ax2.set_title('V₀ = 0.03,  EPS = 0.15', fontsize=13, fontweight='bold')
ax2.legend(fontsize=11, loc='upper right')
ax2.set_xlim(0.5, 9.5)
ax2.set_ylim(0, 0.17)
ax2.xaxis.set_major_locator(plt.MultipleLocator(1))
ax2.grid(True, alpha=0.3)

# shared legend for dot vs line
for ax in [ax1, ax2]:
    ax.plot([], [], 'o-k', lw=2, ms=6, label='exact (line) / sim (dot)')

# ── Panel 3: peak kz migration ───────────────────────────────────────────────
def kz_peak(kz_arr, gamma_arr):
    idx = np.argmax(gamma_arr)
    return kz_arr[idx]

alphas_05  = [campaigns[n]['alpha'] for n in order_05]
kpeak_ex05 = [kz_peak(np.array(campaigns[n]['kz']), np.array(campaigns[n]['gex'])) for n in order_05]
kpeak_si05 = [kz_peak(np.array(campaigns[n]['kz']), np.array(campaigns[n]['gsim'])) for n in order_05]

alphas_03  = [campaigns[n]['alpha'] for n in order_03]
kpeak_ex03 = [kz_peak(np.array(campaigns[n]['kz']), np.array(campaigns[n]['gex'])) for n in order_03]
kpeak_si03 = [kz_peak(np.array(campaigns[n]['kz']), np.array(campaigns[n]['gsim'])) for n in order_03]

# αV0 as x-axis to combine both V0 values on one axis
aV_05  = [a * 0.05 for a in alphas_05]
aV_03  = [a * 0.03 for a in alphas_03]

ax3.plot(aV_05, kpeak_ex05, 'b-o',  ms=9, lw=2,   label='V₀=0.05, exact')
ax3.plot(aV_05, kpeak_si05, 'b--s', ms=9, lw=1.5, label='V₀=0.05, sim', mfc='none')
ax3.plot(aV_03, kpeak_ex03, 'r-o',  ms=9, lw=2,   label='V₀=0.03, exact')
ax3.plot(aV_03, kpeak_si03, 'r--s', ms=9, lw=1.5, label='V₀=0.03, sim', mfc='none')

# label each point with α value
for x, y, a in zip(aV_05, kpeak_ex05, alphas_05):
    ax3.annotate(f'α={a}', (x, y), textcoords='offset points', xytext=(4, 4), fontsize=9, color='b')
for x, y, a in zip(aV_03, kpeak_ex03, alphas_03):
    ax3.annotate(f'α={a}', (x, y), textcoords='offset points', xytext=(4, 4), fontsize=9, color='r')

ax3.set_xlabel('α · V₀  (coupling × velocity)', fontsize=13)
ax3.set_ylabel('kz at peak γ', fontsize=13)
ax3.set_title('Non-Abelian KH peak migration: kz_peak vs coupling strength', fontsize=13, fontweight='bold')
ax3.legend(fontsize=11, loc='upper left')
ax3.yaxis.set_major_locator(plt.MultipleLocator(1))
ax3.grid(True, alpha=0.3)
ax3.set_xlim(0.03, 0.20)

# ── figure-level legend for exact/sim ────────────────────────────────────────
legend_elements = [
    Line2D([0], [0], color='k', lw=2,   label='Exact eigenvalue (line)'),
    Line2D([0], [0], color='k', lw=0, marker='o', ms=7, label='Simulation (dot)'),
]
fig.legend(handles=legend_elements, loc='lower center', ncol=2,
           fontsize=11, bbox_to_anchor=(0.5, 0.0))

fig.suptitle('SU(2) Yang-Mills KH Dispersion  —  Mode 6 (NAB_CIRC_AZ2)\n'
             'Campaigns C34–C38 + C32/C33 extensions',
             fontsize=14, fontweight='bold', y=1.01)

plt.savefig('ym_dispersion_allcampaigns.png', dpi=150, bbox_inches='tight')
print("Saved ym_dispersion_allcampaigns.png")
