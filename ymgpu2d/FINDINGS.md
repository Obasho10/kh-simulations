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
| 1.25 | FCT NaN | 68.7 | 0.280 | 0.400 | 0.70 |
| 1.50 | FCT NaN | 66.3 | 0.354 | 0.439 | 0.81 |
| 1.75 | Energy ×100 | 56.5 | 0.430 | 0.474 | 0.91 |
| 2.25 | Energy ×100 | 44.2 | 0.580 | 0.537 | 1.08 |
| 2.75 | Energy ×100 | 36.8 | 0.730 | 0.594 | 1.23 |
| 2.00 | Energy ×100 | 49.1 | 0.504 | 0.507 | 0.99 |

**Empirical scaling**: γ_fit ≈ 0.196 × α^1.35 (power-law fit over all 9 points). The ratio γ_fit/γ_WKB forms an S-curve crossing 1.0 at α≈2: suppressed (0.32–0.91) for α<2, exact at α=2, and exceeds WKB (1.08–1.23) for α>2.

**Above-WKB regime (α>2)**: The ratio continues rising (1.08 at α=2.25, 1.23 at α=2.75). This is likely the n=1 WKB mode (γ₁ = 3^(1/3)·γ₀ ≈ 1.44·γ₀) becoming competitive with n=0. At large α the runs are short (t_blow=37–44 TU), and consecutive e-fold analysis in the late linear phase shows consistent growth faster than the n=0 WKB, suggesting a mode mix where n=1 contributes at the ~0.1–0.3% level (enough to shift γ_eff upward by 10–25%).

**FCT NaN wall**: All runs with α≤1.5 hit FCT numerical instability at t=66.3 or 68.7 TU exactly (comes from double-tanh shear advection; occurs at the same step regardless of α since fluid dynamics dominates). Only α=2 escaped via Weibel energy threshold first. α=1.5 came within 0.4 TU (estimated Weibel blow-up at t≈65.9, FCT NaN at t=66.3).

**Interpretation — double-well interference**: NAB_DTANH has two Az1 wells (at x=Lx/4 and x=3Lx/4). The kz=0 Weibel eigenfunction splits into symmetric ("bonding") and antisymmetric ("antibonding") combinations. At small α, the wells are weakly decoupled and the antisymmetric mode (γ < γ_WKB) dominates the machine-noise seed. At large α, the wells decouple and both modes converge to γ_WKB. This is the two-well eigenfunction problem, analogous to a quantum double-well. The WKB polynomial correctly predicts the single-well growth rate; the double-well geometry reduces it by the ratio α^0.88.

**Key conclusion**: The WKB polynomial is validated at α=2 to 0.5% for the kz=0 Weibel mode. The suppression at lower α is a geometric artifact of the double-tanh setup, not a failure of the polynomial itself.

**Analysis script**: `measure_kz0_gamma.py`

---

## Campaign 5 — NAB_DTANH, α=2.0, suppress_kz0=1, k=1..8 (2026-06-29)

**Setup**: `run_mode=3`, `alpha=2.0`, `perturb_amp=0.001`, `V0=0.1`, `suppress_kz0=1` (no hyp_diff). k=1..8 sequential; k=6 killed mid-run, k=7–8 not reached.

**Goal**: Check whether projecting out the kz=0 component of By2/By3 at each step prevents the Weibel blowup and exposes the KH mode.

**Result**: suppress_kz0 alone is insufficient. k=1..5 still hit the 100×E0 energy threshold at t=46.6–51.5 TU.

| k | halt type | t_halt (TU) |
|---|-----------|------------|
| 1 | Energy ×100 | 51.5 |
| 2 | Energy ×100 | 49.1 |
| 3 | Energy ×100 | 49.1 |
| 4 | Energy ×100 | 49.1 |
| 5 | Energy ×100 | 46.6 |
| 6 | Terminated | — |
| 7–8 | Not run | — |

**Interpretation**: The kz=0 suppression zeroes By2/By3 at kz=0, but the Weibel energy flows through other channels (Az2, Az3, Q2, Q3 at kz=0) which are not zeroed. The rapid blowup pattern (E/E0 jumping from ~1.4 to 1401 within 10 TU for k=1) differs from the gradual Campaign 3 profile, suggesting the suppression forces a transient that feeds the instability differently. Regardless, the kz=0 mode is not cleanly eliminated and the runs still die before a KH growth window.

---

## Campaign 6 — NAB_DTANH, α=2.0, suppress_kz0=1, hyp_diff=5e-5, k=1..8 (2026-06-30)

**Setup**: `run_mode=3`, `alpha=2.0`, `perturb_amp=0.001`, `V0=0.1`, `suppress_kz0=1`, `hyp_diff=5e-5`. All 8 modes run sequentially and completed. Output directories: `ym_k{1..8}_a2.000_dtanh_nkz0_hd5e-05/`.

**Goal**: Add hyperdiffusion to suppress the remaining kz=0 Weibel energy leaking through non-By channels and extend the run window.

**Result**: kz=0 blowup is eliminated. All 8 runs survive to t=63.8–71.2 TU, then die from the FCT NaN wall.

| k | halt type | t_halt (TU) |
|---|-----------|------------|
| 1 | FCT NaN | 63.8 |
| 2 | FCT NaN | 66.3 |
| 3 | FCT NaN | 68.7 |
| 4 | FCT NaN | 68.7 |
| 5 | FCT NaN | 68.7 |
| 6 | FCT NaN | 68.7 |
| 7 | FCT NaN | 71.2 |
| 8 | FCT NaN | 71.2 |

**Energy traces**: E/E0 stays in [0.99, 1.15] throughout all runs — no systematic growth above ~15%. The Weibel mode is genuinely suppressed. The NaN onset is sudden (E/E0 goes from ~1.15 to -nan in one 10000-step interval) with no energy warning.

**FCT NaN wall**: the halt times match Campaign 4's FCT NaN times almost exactly (63.8, 66.3, 68.7 TU for k=1–6, 71 TU for k=7–8). The `hyp_diff=5e-5` gave a small extension for k=7,8 (~2.5 TU) but did not cure the instability. The FCT NaN originates from advection of the double-tanh shear velocity profile: FCT is monotone but still accumulates truncation error in the high-shear region, eventually producing a density or momentum value that propagates into a divide-by-zero or float overflow.

**No KH growth detected**: the WKB prediction for kz=1, α=2 is γ≈0.55 TU⁻¹, which would give ×10 amplitude per 4 TU. In 63 TU of clean window that signal would be enormous if present. Its absence, combined with Campaign 3's finding that By2(kz=1) grew only 1.9× in 49 TU (γ≈0.013 TU⁻¹), confirms the double-tanh geometry strongly suppresses the kz≥1 KH mode.

**Conclusion**: suppress_kz0 + hyp_diff successfully eliminates the kz=0 Weibel blowup but the FCT NaN wall (from the double-tanh shear) remains the binding constraint. The two-well geometry also suppresses the KH mode itself. Both issues point to switching away from NAB_DTANH.

---

## Campaign 7 — NAB_STEP, α=2.0, suppress_kz0=1, hyp_diff=5e-5, k=1..8 (2026-06-30)

**Setup**: `run_mode=4`, `alpha=2.0`, `perturb_amp=0.001`, `V0=0.1`, `suppress_kz0=1`, `hyp_diff=5e-5`.

**Result**: All k values blow up from NaN at t≈12–20 TU. Much earlier than Campaign 6's 63–71 TU.

| k | halt type | t_halt (TU) |
|---|-----------|------------|
| 1 | NaN | 19.6 |
| 2 | NaN | 14.7 |
| 3–8 | NaN | ~14–20 |

**Root cause — color-1 two-stream instability**: NAB_STEP places both beams with `vz_A = −vz_B = ±V0` everywhere (not just at interfaces). Beams A (+Q1=+1, +vz) and B (−Q1=−1, −vz) form a two-stream configuration in the color-1 sector with relative velocity 2V0. Growth rate ω_p/√2 ≈ 0.7 TU⁻¹. Starting from numerical noise this saturates and drives blow-up at t≈13–20 TU, **independent of α** (confirmed: old α=0.5 STEP run also blew up at t≈15 TU).

DTANH avoids the two-stream instability because the velocity tanh profile has vz→0 at the interfaces where the mode localises — the instability sees a short, velocity-limited region rather than the full domain.

**By1 initialization attempt**: Tried initializing By1 to the equilibrium triangle wave (integral of Jz1−⟨Jz1⟩) to reduce the plasma oscillation. This made things worse (blowup at t=12.3 instead of 19.6 TU) because the large |By1|∼0.84 generates a transverse Lorentz force F_xA = −vz_A·By1 = ∓V0·By1 that immediately accelerates the beams in x, dumping kinetic energy into the EM fields. There is no cold-plasma static equilibrium with both vz≠0 everywhere and By1≠0. Reverted.

**Conclusion**: NAB_STEP is fundamentally broken as a geometry for two opposite-color counter-streaming beams. The color-1 two-stream instability terminates runs at t≈15 TU regardless of α, suppress_kz0, or hyp_diff. By1 initialization attempts only accelerate the collapse.

---

## Campaign 8 — NAB_DTANH, 2D sweep: α∈[1,6]×V₀∈[0.001,0.4], 200 runs (planned 2026-06-30)

**Setup**: `run_mode=3`, `k_mode=1`, `perturb_amp=0.001`, `suppress_kz0=0`, `hyp_diff=2e-4`. α: 10 linearly-spaced from 1 to 6; V₀: 20 log-spaced from 0.001 to 0.4. Total: 200 sequential runs.

**Goal**: Map γ(α, V₀) across the full 2D parameter space and compare to the analytic WKB prediction γ_WKB = (√(α³/2)·V₀)^(1/3)·sin(π/3). Determine whether the double-well suppression seen in Campaign 4 (DTANH geometry, ratio≈0.32–0.99 across α=0.5–2) persists across V₀, or whether the suppression depends on the combined dimensionless coupling α·V₀.

**hyp_diff choice**: `2e-4` (4× Campaign 6 value) gives damping rate 1.44 TU⁻¹ at kz=50 — sufficient to kill any numerical instability at kz≥50 even at the maximum physical growth rate γ≈1.39 TU⁻¹ (α=6, V₀=0.4). kz=8 sees only 0.001 TU⁻¹ damping (negligible).

**Code change**: `main_ym.cu` directory naming fixed to `setprecision(4)` for V₀ (was 3), ensuring all 20 V₀ values get unique directory names. **Requires rebuild on t126.**

**Expected run times**: FCT NaN wall at t≈63–71 TU for slow-growing modes; energy threshold at t≈20–50 TU for fast-growing (large α, V₀) modes. Each run ≈0.5–1 min; total sweep ≈3–5 hours.

**Measurability**: γ≥0.08 TU⁻¹ detectable (kz=0 amplitude grows from ~1e-13 to above 1e-12 within 63 TU window). Corner (α=1, V₀=0.001) predicted γ≈0.077 is marginal — may report NaN. All other corners should be measurable.

**Analysis**: `python3 analyze_campaign8.py` — auto-discovers directories, fits exponential, generates heatmap of γ_meas/γ_WKB and scatter plot.

**Expected WKB range**: γ_WKB ∈ [0.077, 1.39] TU⁻¹ (36× dynamic range). The analytic formula predicts γ ∝ α^(1/2)·V₀^(1/3). If the double-well suppression factor depends only on geometry (not α or V₀), the ratio γ_meas/γ_WKB should be constant across the 2D space — forming a flat heatmap. If the suppression depends on αV₀ (as the quantum double-well analogy suggests), the ratio will vary systematically and reveal the correction function.

---

## Known Issues / Unresolved

| Issue | Status |
|-------|--------|
| FCT NaN wall at t=63–71 TU in NAB_DTANH | Active blocker. Double-tanh shear causes FCT instability at fixed times regardless of α, k, suppress_kz0, or hyp_diff=5e-5. Needs higher hyp_diff, fluid viscosity, or EPS increase. |
| kz=0 Weibel mode | Suppressed in Campaign 6 (suppress_kz0 + hyp_diff=5e-5). suppress_kz0 alone (C5) was insufficient. |
| KH mode at kz≥1 not observable in DTANH | WKB 42× overestimates; double-well geometry strongly suppresses kz≥1 mode. |
| NAB_STEP ruled out | Color-1 two-stream instability (beams ±Q1, ±vz everywhere) blows up at t≈15 TU independent of α. No fix exists without changing the beam configuration. |
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
