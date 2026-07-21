#!/usr/bin/env python3
"""
Diagnostic plot for the color-1 EMHD_KH (mode 2) two-fluid pinch-collapse
finding: overlays the target-kz By1 signal (weighted amplitude near the
shear layer) against the density pileup (max|nA-1|) that outpaces it at
every tested V0. Also plots the Das-Kaw theory curves for reference.

Run on the node holding the run directories (data too large to move).
"""
import sys
sys.path.insert(0, '.')
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import glob
import re

from dispersion_ym import daskaw_step_rate, emhd_kh_rate

NX = 1024
LX = 6.0 * np.pi
EPS = 0.15
V0 = 0.02
DX = LX / NX
DT = 0.1 * DX
x_arr = np.arange(NX) * DX
w = 1.0 / np.cosh((x_arr - LX / 2.0) / EPS)
w /= w.sum()

d = 'ym_k2_a0.000_emhd_v0.0200_eps0.15_nx1024_v0scan0.02'
files = sorted(glob.glob(d + '/ym_*.csv'),
               key=lambda f: int(re.search(r'(\d+)', f.split('/')[-1]).group(1)))

times, amp2, npeak = [], [], []
for f in files:
    step = int(re.search(r'(\d+)', f.split('/')[-1]).group(1))
    df = pd.read_csv(f)
    nz = len(df) // NX
    By1 = df['By1'].values.reshape(nz, NX)
    Fk = np.fft.rfft(By1, axis=0)
    a2 = np.dot(np.abs(Fk[2, :]) / nz, w)
    nA = df['nA'].values
    times.append(step * DT)
    amp2.append(a2)
    npeak.append(nA.max())

times = np.array(times); amp2 = np.array(amp2); npeak = np.array(npeak)

fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(8, 8), sharex=True)

ax1.semilogy(times, amp2, 'o-', ms=3, color='C0', label='By1[kz=2] weighted amplitude (measured)')
g_th = emhd_kh_rate(2.0, v=V0, eps=EPS)
g_dk = daskaw_step_rate(2.0, v=V0)
t_ref = np.linspace(0, times.max(), 100)
ax1.semilogy(t_ref, amp2[0] * np.exp(g_th * t_ref), 'g--',
             label=f'sech-interp prediction γ={g_th:.4f}')
ax1.semilogy(t_ref, amp2[0] * np.exp(g_dk * t_ref), 'm:', lw=2,
             label=f'Das-Kaw step-profile γ={g_dk:.4f}')
ax1.set_ylabel('|By1[kz=2]| (weighted)')
ax1.set_title(f'Color-1 EMHD_KH (mode 2), V0={V0}, EPS={EPS}, kz=2: '
              'seeded signal vs pinch-collapse contamination')
ax1.legend(fontsize=8)

ax2.plot(times, npeak, 'r-', label='max(nA) — density pileup (should stay ≈1)')
ax2.axhline(1.0, color='k', ls=':', lw=1)
ax2.axhline(1.5, color='orange', ls='--', lw=1, label='50% perturbed (linear regime breaks down)')
ax2.set_xlabel('t (TU)')
ax2.set_ylabel('max(nA)')
ax2.legend(fontsize=8)

plt.tight_layout()
plt.savefig('emhd_pinch_diagnostic.png', dpi=150)
print('Saved emhd_pinch_diagnostic.png')
print(f'Density exceeds 1.5x background at t = '
      f'{times[np.argmax(npeak > 1.5)]:.2f} TU (first crossing)')
print(f'Predicted e-folding time (sech interp): {1.0/g_th:.1f} TU')
