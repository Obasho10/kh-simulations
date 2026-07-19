#!/usr/bin/env python3
"""T2.1 complex-omega table + T2.5 dimensionless collapse.

Uses the sigma-chased DOMINANT localised eigenvalue (avoids the §8.8 overtone
artifact) across a (alpha, V0, kz) grid. Returns the COMPLEX eigenvalue so
Re(gamma)=growth and Im(gamma)=oscillation frequency Re(omega) are both tabulated.
"""
import os, sys
os.environ.setdefault('OMP_NUM_THREADS','1'); os.environ.setdefault('OPENBLAS_NUM_THREADS','1')
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, matplotlib
matplotlib.use('Agg'); import matplotlib.pyplot as plt
import ym_eigenmode as E
from exact_action_wkb import ceiling  # (alpha*V0**2)**(1/3)

NX=384; EPS=0.15; XSP=20.0

def chased_complex(kz, alpha, V0):
    """sigma-chased dominant localised COMPLEX eigenvalue (or None)."""
    s0 = E.wkb_growth_rate(kz, alpha, V0)
    sig = max(0.55*s0 if (np.isfinite(s0) and s0>0) else 0.1, 0.02)
    best=None
    for it in range(8):
        try:
            ev,evec = E.solve_eigenmode(kz,alpha,V0,EPS,NX,n_eigs=10,sigma=sig,
                                        xi_sponge=XSP,sigma_sponge=5.0)
        except Exception:
            return best
        if ev is None: return best
        cand=[(v.real,v) for j,v in enumerate(ev)
              if v.real>1e-4 and E.is_localised(evec[:,j],NX,EPS,xi_inner=XSP)]
        if not cand: break
        gmax,vmax = max(cand,key=lambda t:t[0])
        if best is None or gmax>best.real: best=vmax
        if gmax >= 0.9*max(v.real for v in ev) and it<7:
            sig = gmax*1.4; continue
        break
    return best

alphas=[1.0,1.5,2.0,2.5,3.0]; V0s=[0.03,0.05,0.10]; kzs=list(range(1,9))
grid={}   # (alpha,V0) -> list of (kz, complex gamma)
print("solving grid (sigma-chased dominant complex eigenvalue)...", flush=True)
for a in alphas:
    for v in V0s:
        row=[]
        for k in kzs:
            g=chased_complex(k,a,v)
            row.append((k, g))
        grid[(a,v)]=row
    print(f"  alpha={a} done", flush=True)

# ---------- T2.1 complex-omega table (reference series) ----------
print("\n================ T2.1 COMPLEX-omega TABLE ================")
for v in V0s:
    print(f"\n-- V0={v}: dominant-mode complex eigenvalue  gamma = Re(growth) + i*Im(freq) --")
    hdr="alpha\\kz " + "".join(f"{k:>16d}" for k in kzs)
    print(hdr)
    for a in alphas:
        cells=[]
        for k,g in grid[(a,v)]:
            if g is None: cells.append(f"{'--':>16}")
            else: cells.append(f"{g.real:>7.4f}{g.imag:+7.4f}i")
        print(f"{a:>6.1f}  " + "".join(cells))
maxim=max((abs(g.imag) for row in grid.values() for _,g in row if g is not None), default=0)
print(f"\nmax |Im(gamma)| over grid = {maxim:.4e}  "
      f"({'purely growing (non-oscillatory) everywhere' if maxim<1e-3 else 'oscillatory modes present'})")

# ---------- T2.5 dimensionless collapse ----------
# The tachyonic OUTER branch (gamma^2 = alpha^2 Az1^2 - kz^2, §8.2) overtakes the
# shear-layer KH mode at low kz / high alphaV0 and the sigma-chase latches onto it.
# It is NOT bounded by the (alphaV0^2)^1/3 KH ceiling, so mask gamma > 1.15*ceil as
# tachyonic and take the KH peak over the remaining (genuine shear-layer) modes.
print("\n================ T2.5 DIMENSIONLESS COLLAPSE ================")
print("(KH peak = max Re(gamma) over modes with gamma <= 1.15*ceiling; "
      "faster low-kz modes are the tachyonic outer branch, §8.2, and are masked)")
print(f"{'alpha':>6} {'V0':>6} {'aV0':>7} {'gKH_peak':>9} {'kz_peak':>8} "
      f"{'ceil=(aV0^2)^1/3':>16} {'gKH/ceil':>10} {'n_tach_masked':>14}")
rows=[]
for a in alphas:
    for v in V0s:
        pairs=[(k,g.real) for k,g in grid[(a,v)] if g is not None]
        if not pairs: continue
        ceil=ceiling(a,v)
        kh=[(k,gr) for k,gr in pairs if gr <= 1.15*ceil]   # genuine KH modes
        ntach=len(pairs)-len(kh)
        if not kh: continue
        kpk,gpk=max(kh,key=lambda t:t[1])
        rows.append((a,v,gpk,kpk,ceil,gpk/ceil))
        print(f"{a:>6.1f} {v:>6.2f} {a*v:>7.3f} {gpk:>9.4f} {kpk:>8d} "
              f"{ceil:>16.4f} {gpk/ceil:>10.4f} {ntach:>14d}")
r=np.array([x[5] for x in rows])
print(f"\ngKH_peak/ceil : mean={r.mean():.4f}  std={r.std():.4f}  "
      f"(spread {100*r.std()/r.mean():.1f}%)  min={r.min():.4f} max={r.max():.4f}")
print(f"-> {'COLLAPSES' if r.std()/r.mean()<0.05 else 'does not tightly collapse'} onto the "
      f"(alphaV0^2)^1/3 ceiling across alpha in [1,3], V0 in [0.03,0.1] (10x range in alphaV0)")

# collapse figure: gamma/ceiling vs kz/(a/V0)^1/3 (confinement wavenumber scale)
fig,ax=plt.subplots(1,2,figsize=(13,5))
cmap=plt.cm.viridis
for a in alphas:
    for v in V0s:
        ceil=ceiling(a,v)
        row=[(k,g) for k,g in grid[(a,v)] if g is not None and g.real<=1.15*ceil]  # mask tachyonic
        if not row: continue
        ks=np.array([k for k,g in row]); gs=np.array([g.real for k,g in row])
        ksc=(a/v)**(1/3)
        c=cmap((a-1.0)/2.0); ls={0.03:':',0.05:'-',0.10:'--'}[v]
        ax[0].plot(ks, gs, ls, color=c, alpha=.8)
        ax[1].plot(ks/ksc, gs/ceil, ls, color=c, marker='o', ms=3, alpha=.8,
                   label=f'α={a},V0={v}')
ax[0].set_xlabel('kz'); ax[0].set_ylabel('γ (raw)'); ax[0].set_title('Raw dispersion γ(kz)'); ax[0].grid(alpha=.3)
ax[1].set_xlabel('kz / (α/V0)^{1/3}'); ax[1].set_ylabel('γ / (αV0²)^{1/3}')
ax[1].set_title('Dimensionless collapse'); ax[1].grid(alpha=.3); ax[1].legend(fontsize=7,ncol=2)
fig.suptitle('T2.5 Dimensionless collapse of the non-Abelian KH dispersion (σ-chased eigensolver)')
plt.tight_layout(rect=[0,0,1,0.96]); plt.savefig('plots/t2p5_collapse.png',dpi=140,bbox_inches='tight')
print("\nsaved plots/t2p5_collapse.png")
