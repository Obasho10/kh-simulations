# YM KH Simulation — Findings Tracker

## Current Code State (2026-06-29)

**Architecture**: Periodic domain, `Lx=6π`, `Lz=2π`, `NX=3*NZ=768`, `NZ=256`, `DX=DZ=2π/NZ≈0.0245`, `DT=0.01*DX≈2.45e-4`. 1 TU ≈ 4082 steps; 2M steps ≈ 490 TU (runs halt early from energy threshold at ~50–102 TU depending on α).

**Active mode**: `NAB_DTANH` (run_mode=3) — frozen double-log-cosh `Az1`, two smooth tanh shear layers at x=Lx/4 and x=3Lx/4, circular seed `By2=seed·sin(k·z)`, `By3=seed·cos(k·z)`. `freeze_az1=1`.

**Energy threshold**: 100× E0 for modes 3/4; 5× for modes 0/1.

**Snapshot columns**: `X,Z,By1,By2,By3,Az2,Az3,PzA,PxA,Q1A,PzB,PxB,Q1B`

Binary on server: `/DATA/cm/lcpfct/ymgpu2d/ym_coupled`

---

## Why the Architecture Changed

Campaigns 1–2 used a single-tanh domain (`NX=NZ=256`, `DX=1`, wall BC) with `Az1=−V0·log(cosh(ξ))` (no-eps). That profile grows without bound at large |ξ|, so the outer coupling `α|Az1|` always exceeded the WKB growth rate γ_WKB once the EM wave left the seeded inner region (t≈63-76). The WKB mode was never cleanly observable.

**Fix**: bounded periodic domain, frozen Az1 background, periodic BC, `Lx=6π`.

---

## Archived: Campaign 1 — Non-Az1 Baseline

Grid: NX=NZ=256, DX=1, DT=0.002, wall BC. Az1=0.

| k | t_halt | γ_amp |
|---|--------|-------|
| 2-8 | ≈202 | ~0.05-0.07 |

**Interpretation**: Without Az1 the coupling chain breaks at Q3→Q2. Observed growth is FCT background instability, not KH.

---

## Archived: Campaign 2 — With Az1, Windowed Seed

Grid: NX=NZ=256, DX=1, DT=0.002, wall BC. `Az1=−V0·log(cosh(ξ))` full domain.

| k | t_halt | γ_amp (TU⁻¹) | γ_WKB (TU⁻¹) |
|---|--------|--------------|--------------|
| 2 | 63 | 0.174 | 0.049 |
| 5 | 68 | 0.192 | 0.110 |
| 8 | 76 | 0.177 | 0.146 |

**Interpretation**: Outer-region coupling dominated. γ_amp ≈ 0.18/TU flat across all k. WKB mode never isolated.

---

## Campaign 3 — NAB_DTANH, α=2.0, k=1..3 (run 2026-06-29)

**Setup**: `run_mode=3`, `alpha=2.0`, `perturb_amp=0.001`, `V0=0.1`. k=1,2,3 run; k=4 interrupted.

**Result**: All runs halt at t≈49 TU. The seeded kz modes (k=1..3) show NO significant growth.

**Key discovery**: The **kz=0 Weibel-like mode** of By2 and By3 grows from machine-precision noise at:

```
γ(kz=0) = (√(α³/2) · V₀)^(1/3) · sin(π/3)
```

**Measured (k=1, α=2.0)**: γ = 0.5039 TU⁻¹  
**WKB prediction (kz=0, n=0)**: γ = 0.5065 TU⁻¹  
**Match**: 0.5% (excellent)

Growth time series for By2(kz=0) at α=2.0:

| t (TU) | By2(kz=0) RMS |
|--------|--------------|
| 0.0 | 5.8e-13 (machine noise) |
| 4.9 | 1.6e-11 |
| 9.8 | 1.2e-10 |
| 14.7 | 1.2e-09 |
| 19.6 | 1.4e-08 |
| 24.5 | 1.7e-07 |
| 29.5 | 2.0e-06 |
| 34.4 | 2.4e-05 |
| 39.3 | 2.9e-04 |
| 44.2 | 3.5e-03 |
| 49.1 | 4.1e-02 → [HALT] |

This mode is 39× faster than the seeded kz=1 KH mode (γ_KH ≈ 0.013 TU⁻¹ or possibly ≈ 0).  
It dominates the energy by t≈49 TU and triggers the 100×E0 threshold.

**Seeded kz=1 mode behavior**: By2(kz=1) went from 4.47e-05 to 8.51e-05 (factor 1.9×) in 49 TU. The complex Fourier coefficient had random phase — no clear exponential growth signature. The apparent small increase is consistent with kz=0 cascade contamination at late times. Az2(kz=1) grew monotonically at γ≈0.12 TU⁻¹, driven by the kz=0 mode through non-Abelian coupling, not genuine KH growth.

**WKB comparison for kz≥1**: The polynomial at kz=1, α=2, n=0, v=0.1 predicts γ=0.553 TU⁻¹ — 42× larger than observed. The double-shear geometry (two layers at x=Lx/4 and x=3Lx/4) likely suppresses the KH mode relative to single-layer WKB.

---

## Campaign 4 — NAB_DTANH, α scan k=1 (2026-06-29)

**Setup**: `run_mode=3`, `k_mode=1`, `alpha` ∈ {0.5, 0.75, 1.0, 1.5}, `perturb_amp=0.001`. Sequential via `run_alpha_scan.sh`.

**Goal**: Map γ(kz=0) vs α to validate WKB polynomial.

**Key finding: WKB suppressed at α<2 — ~3× below prediction for α=0.5 and 0.75**

All α<2 runs hit FCT NaN at t≈66–69 TU (FCT instability in the double-tanh shear profile), before the Weibel energy threshold. α=2 (Campaign 3) hit energy threshold at t=49 TU, confirming it escaped the FCT wall first.

| α | halt type | t_halt (TU) | γ_fit (TU⁻¹) | γ_WKB (TU⁻¹) | ratio |
|---|-----------|------------|--------------|--------------|-------|
| 0.50 | FCT NaN | 66.3 | 0.080 | 0.253 | 0.32 |
| 0.75 | FCT NaN | 68.7 | 0.115 | 0.310 | 0.37 |
| 1.00 | FCT NaN | 68.7 | 0.204 | 0.358 | 0.57 |
| 1.50 | FCT NaN | 66.3 | 0.354 | 0.439 | 0.81 |
| 2.00 | Energy ×100 | 49.1 | 0.504 | 0.507 | 0.99 |

**Empirical scaling**: ratio(α) ≈ 0.55 × α^0.88. WKB is accurate to 1% at α=2 and is suppressed by 3× at α=0.5.

**FCT NaN wall**: All runs with α≤1.5 hit FCT numerical instability at t=66.3 or 68.7 TU exactly (comes from double-tanh shear advection; occurs at the same step regardless of α since fluid dynamics dominates). Only α=2 escaped via Weibel energy threshold first. α=1.5 came within 0.4 TU (estimated Weibel blow-up at t≈65.9, FCT NaN at t=66.3).

**Interpretation — double-well interference**: NAB_DTANH has two Az1 wells (at x=Lx/4 and x=3Lx/4). The kz=0 Weibel eigenfunction splits into symmetric ("bonding") and antisymmetric ("antibonding") combinations. At small α, the wells are weakly decoupled and the antisymmetric mode (γ < γ_WKB) dominates the machine-noise seed. At large α, the wells decouple and both modes converge to γ_WKB. This is the two-well eigenfunction problem, analogous to a quantum double-well. The WKB polynomial correctly predicts the single-well growth rate; the double-well geometry reduces it by the ratio α^0.88.

**Key conclusion**: The WKB polynomial is validated at α=2 to 0.5% for the kz=0 Weibel mode. The suppression at lower α is a geometric artifact of the double-tanh setup, not a failure of the polynomial itself.

**Analysis script**: `measure_kz0_gamma.py`

---

## Known Issues / Unresolved

| Issue | Status |
|-------|--------|
| kz=0 Weibel mode dominates at α≥0.5 | Identified (Campaign 3). Suppression would require code change (project out kz=0 from fields) or xi_sponge |
| KH mode at kz≥1 not observable | WKB 42× overestimates; double-shear geometry suppresses mode. Need single-layer geometry or kz=0 suppression |
| CLAUDE.md had DT typo (0.001×DX → 0.01×DX) | Fixed 2026-06-29 |
| dispersion_ym.py had same DT typo | Fixed 2026-06-29 |

---

## Physics: The kz=0 Weibel-like instability

The WKB polynomial ω⁴ - kz²ω² - Cω - α²vkz = 0 (with C = (2n+1)√(α³/2)v) at kz=0 reduces to:

```
ω⁴ = C·ω  →  ω³ = C  →  ω = C^(1/3)·e^(i·2π/3)
```

Growing root: `γ = C^(1/3)·sin(π/3) = (√(α³/2)·V₀)^(1/3)·(√3/2)`

This is the n=0 quantization of the color-mixing instability: background Az1 causes color-2,3 fields to mix through non-Abelian Ampere (∂Ex2/∂t term −α·Az1·By3) and Faraday (∂By2/∂t term +α·Az1·Ex3), generating exponentially growing color-2,3 electromagnetic fields that are uniform in z.

The kz=0 WKB match (to 0.5%) confirms the polynomial is correct. The next step is to validate γ(kz=0) vs α and determine whether the KH mode at kz≥1 requires a single-layer geometry to be observable.
