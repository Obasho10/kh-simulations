# YM KH Simulation — Findings Tracker

## Current Code State (2026-06-29)

**Architecture**: Periodic domain, `Lx=6π`, `Lz=2π`, `NX=3*NZ=768`, `NZ=256`, `DX=DZ=2π/NZ≈0.0245`, `DT=0.001*DX≈2.45e-5`. 1 TU ≈ 40816 steps; 2M steps ≈ 49 TU.

**Active mode**: `NAB_STEP` (run_mode=4) — frozen cosine `Az1=−V0·cos(x)` (kx=1, period 2π=Lx/3), two step-function velocity interfaces at x=2π and 4π, seed `By2=perturb_amp·V0·sin(k·z)` uniform in x. `freeze_az1=1` for modes 1,3,4.

**Energy threshold**: 100× E0 for modes 3/4; 5× for modes 0/1.

**Snapshot columns**: `X,Z,By1,By2,By3,Az2,Az3,PzA,PxA,Q1A,PzB,PxB,Q1B` (Az2,Az3 added vs. old format).

Binary on server: `/DATA/cm/lcpfct/ymgpu2d/ym_coupled` — rebuild needed after any `.cu`/`.cuh` change.

---

## Why the Architecture Changed

Campaigns 1–2 used a single-tanh domain (`NX=NZ=256`, `DX=1`, wall BC) with `Az1=−V0·log(cosh(ξ))` (no-eps). That profile grows without bound at large |ξ|, so the outer coupling `α|Az1|` always exceeded the WKB growth rate γ_WKB once the EM wave left the seeded inner region (t≈63-76). The WKB mode was never cleanly observable.

**Fix**: replace log-cosh Az1 with a **bounded periodic cosine** `Az1=−V0·cos(x)`, triple the domain to fit two velocity interfaces plus periodicity (`Lx=6π`), make BC fully periodic, and freeze Az1 as a static background. Max coupling is now `α·V0=0.05` (for α=0.5, V0=0.1), much smaller than any outer blow-up rate.

---

## Archived: Campaign 1 — Non-Az1 Baseline (old architecture)

Grid: NX=NZ=256, DX=1, DT=0.002, wall BC. Az1=0. Data in `ym_k*_a0.500_noaz1/`.

| k | t_halt | γ_amp |
|---|--------|-------|
| 2-8 | ≈202 | ~0.05-0.07 |

**Interpretation**: Without Az1 the coupling chain breaks at Q3→Q2. Observed growth is FCT background instability, not KH.

---

## Archived: Campaign 2 — With Az1, Windowed Seed (old architecture)

Grid: NX=NZ=256, DX=1, DT=0.002, wall BC. `Az1=−V0·log(cosh(ξ))` full domain. Seed windowed to |ξ|<3. Data in `ym_k*_a0.500/`.

| k | t_halt | γ_amp (TU⁻¹) | γ_WKB (TU⁻¹) |
|---|--------|--------------|--------------|
| 2 | 63 | 0.174 | 0.049 |
| 5 | 68 | 0.192 | 0.110 |
| 8 | 76 | 0.177 | 0.146 |

**Interpretation**: Outer-region coupling dominated. γ_amp ≈ 0.18/TU across all k (flat, not monotone). Halt ordered k=2 first (inverted from WKB prediction). WKB mode never isolated.

---

## Campaign 3 — NAB_STEP, Periodic Domain (current)

**Status**: Not yet run. Architecture in place.

**Setup**: `run_mode=4`, `alpha=0.5`, `perturb_amp=0.001`, `V0=0.1`. k=1..8 sweep.

**Expected behavior**:
- Max coupling: `α|Az1|max = α·V0 = 0.05/TU` — much smaller than old outer coupling (0.2-0.6/TU)
- No outer blowup: cosine Az1 is bounded, domain is periodic
- If WKB instability exists in this geometry, it should grow on a timescale ~1/γ_WKB; with 49 TU available this should be observable
- The WKB theory (wkb.pdf eq. 33) was derived for a log-cosh potential, so predictions may not directly apply to cosine Az1 — but qualitative behavior (instability exists, grows with k) should still hold

**Predicted run time**: ~5 min for all 8 k-values in parallel on t126.

**Output dirs**: `ym_k<k>_a0.500_step/`

---

## Fundamental Obstacle (Resolved for Campaign 3)

Old obstacle: outer-region non-Abelian blowup masked inner WKB mode.

| Approach | Status | Notes |
|----------|--------|-------|
| Full-eps Az1 (wall BC) | ✗ Failed | 6/TU edge coupling, 3 TU blowup |
| No-eps Az1, windowed seed (wall BC) | ✗ Dominant outer | Campaign 2; outer coupling >γ_WKB |
| Truncated Az1 |ξ|<3 (wall BC) | ✗ No WKB mode | Turning points outside active region |
| Cosine Az1, periodic BC (step velocity) | → Campaign 3 | Bounded coupling, currently untested |
| Double-tanh, periodic BC (mode 3) | Untested | Alternative smooth geometry |
| Smaller α (e.g. 0.1) | Not tried | Reduces coupling but weakens instability |

---

## Next Steps

1. **Run Campaign 3** on t126: k=1..8, α=0.5, mode=4. Check that runs complete without early halt.

2. **Measure By2 growth rate** vs k: run `dispersion_ym.py` on `ym_k*_a0.500_step/` dirs. Look for monotone γ(k) trend matching WKB prediction.

3. **If flat/no growth**: the step-function geometry may not support the WKB mode. Try mode 3 (double-tanh) as an alternative smooth background.

4. **If growth observed but wrong trend**: check whether the cosine Az1 WKB turning points exist in the new domain. May need to re-derive quantization condition for cosine potential.

5. **Vary α**: once growth rate trend is established, sweep α to map the dispersion surface γ(k, α).
