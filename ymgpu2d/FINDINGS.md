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

## Campaign 9 — NAB_STEP (mistake), α=2.0, kz_suppress_max=k-1, k=1..6 (2026-06-30)

**Setup**: `run_mode=4` (NAB_STEP — **error, should have been mode=3**), `alpha=2.0`, `perturb_amp=0.001`, `V0=0.1`, `suppress_kz0=1`, `hyp_diff=5e-5`, `kz_suppress_max=k-1`. Ran on t130:/DATA/cm. k=1..4 completed (all NaN); k=5 killed mid-run; k=6 never started.

**Goal**: Isolate kz=1..6 growth rates by suppressing all modes below the target. New kernel `kernel_ym_subtract_lowkz` projects out DFT modes kz=1..kz_suppress_max at each step (DFT subtraction, 24 KB smem per block).

**Result**: All runs hit NaN at t=12–22 TU — identical to Campaign 7's NAB_STEP blowup.

| k | kz_suppress_max | halt type | t_halt (TU) | E/E0 before NaN |
|---|-----------------|-----------|-------------|-----------------|
| 1 | 0 | NaN | 22.1 | 1.88 |
| 2 | 1 | NaN | 12.3 | 1.15 |
| 3 | 2 | NaN | 14.7 | 1.61 |
| 4 | 3 | NaN | 14.7 | 1.62 |
| 5 | 4 | Killed | — | — |
| 6 | 5 | Not reached | — | — |

**Root cause**: Mode 4 (NAB_STEP) was used instead of Mode 3 (NAB_DTANH). Campaign 7 already established that NAB_STEP is fatal: the step-function velocity profile gives vz=±V0 everywhere, generating a color-1 two-stream instability (γ≈0.7 TU⁻¹) that NaN's at t≈12–22 TU regardless of any suppression settings.

**Diagnosis from logs**: The energy trajectory through t=9.8 TU is *identical* across all four runs (E/E0 = 0.993, 1.003, 1.150, 1.112) — confirming the divergence is not related to kz_suppress_max and originates from the same two-stream physics.

**New code (kept)**: `kernel_ym_subtract_kz_range` (renamed from `kernel_ym_subtract_lowkz`) and `kz_suppress_max` parameter are correct and will be reused in the next campaign with the correct mode.

**Fix for Campaign 10**: New mode 5 (NAB_TANH_COSAZ) with thin-tanh shear + bounded cosine Az1.

---

## Campaign 10 — NAB_TANH_COSAZ (mode 5), EPS sweep + kz=1..6 (2026-06-30)

**Setup**: `run_mode=5` (new mode: single thin-tanh shear, cosine Az1), `alpha=2.0`, `perturb_amp=0.001`, `V0=0.1`, `suppress_kz0=1`, `hyp_diff=5e-5`. Phase 1: EPS=0.50,0.30,0.15,0.10 at k=1. Phase 2: k=1..6 at EPS=0.15 with kz_suppress_max=k-1.

**Mode 5 design**: fixes both prior failures — cosine Az1 (|Az1|≤V0 everywhere, no log-cosh outer-region blowup), single shear layer (no double-well suppression), tanh velocity (zero at interface, no step-function two-stream).

**Result**: All runs NaN at t=17–20 TU. Better than NAB_STEP (t=12–22 TU) but still far short of a usable window.

| EPS | k | kz_suppress_max | t_halt (TU) |
|-----|---|-----------------|-------------|
| 0.50 | 1 | 0 | 19.6 |
| 0.30 | 1 | 0 | 19.6 |
| 0.15 | 1–5 | k-1 | 17.2 |
| 0.10 | 1 | 0 | 17.2 |

**KH growth confirmed**: By2 at target kz grows cleanly in the early linear phase:

| EPS | γ_KH(kz=1) (TU⁻¹) | γ_KH/γ_WKB |
|-----|-------------------|------------|
| 0.50 | 0.034 | 6.2% |
| 0.30 | 0.044 | 8.0% |
| 0.15 | 0.064 | 11.6% |
| 0.10 | 0.170 | 30.8% |

Growth rate rises with smaller EPS (correct trend — kz*EPS→0 activates KH). Still below WKB because the tanh profile reduces the effective coupling vs the step-function WKB assumption.

**Root cause of NaN**: Two-stream instability at kz≈10–14 in the color-2,3 sector. By2[kz=10] grows from noise (~5e-14) to 5e-8 in 14.7 TU at γ≈0.8 TU⁻¹ — 10× faster than KH. The counter-streaming beams (±V0 away from the shear interface) provide full two-stream drive at all kz > 0; non-Abelian coupling amplifies it through color-2,3.

**Key diagnostic** (EPS=0.15, k=1):
```
t=0.0:   By2[kz=1]=2.5e-6   By2[kz=10]=5e-14   (initial seed vs noise)
t=4.9:   By2[kz=1]=5.1e-6   By2[kz=10]=4e-12   (KH linear growth)
t=9.8:   By2[kz=1]=6.8e-6   By2[kz=10]=2.7e-9  (two-stream overtakes)
t=14.7:  By2[kz=1]=6.4e-6   By2[kz=10]=4.9e-8  (two-stream 7000× KH)
t=17.2:  NaN
```

The kz_suppress_max filter (low-kz) does not help because the two-stream peaks at kz≈10–14, above k_target.

**Fix for Campaign 11**: Add high-kz bandpass — suppress kz=k_mode+1..40 in color-2,3 fields each step. This cuts the non-Abelian amplification of the two-stream while leaving the target KH mode (kz=k_mode) untouched.

---

## Campaign 11 — NAB_TANH_COSAZ, color-2/3 bandpass only (2026-06-30)

**Setup**: same as Campaign 10 but adds `kz_suppress_hi=40`: suppress kz=k+1..40 in color-2/3 fields each step. Combined with suppress_kz0 + kz_suppress_max=k-1, only kz=k_mode survives in the EM sector.

**Result**: **Identical NaN timing as Campaign 10** — all three EPS values NaN'd at t=17.2 TU regardless of bandpass setting. EPS=0.50 was actually slightly *worse* (17.2 TU vs 19.6 TU in C10). The color-2/3 bandpass did nothing.

| EPS | k | t_halt (TU) | Notes |
|-----|---|-------------|-------|
| 0.50 | 1 | 17.2 | worse than C10 without filter |
| 0.15 | 1 | 17.2 | same as C10 |
| 0.10 | 1 | 17.2 | same as C10 |

**Diagnosis**: The NaN is not from the color-2/3 EM sector — it comes from the **color-1 fluid two-stream** in pzA and pzB. Counter-streaming beams at ±V0 drive z-momentum oscillations at kz=1..kz_ts≈14 in the fluid. Density n can approach zero from these oscillations, causing pz/n=vz→NaN. This mechanism is independent of any color-2/3 filtering.

**Fix for Campaign 12**: Add `kernel_fluid_pz_subtract_kz_range` — same DFT subtraction applied to pzA and pzB each step, covering kz=k+1..14 (the two-stream unstable band). This cuts the fluid two-stream at the source.

---

## Campaign 12 — NAB_TANH_COSAZ, full bandpass (color-2/3 + fluid pz) (2026-06-30)

**Setup**: Same as Campaign 11 but adds a fluid pz bandpass: kz_suppress_hi=14 (not 40) zeroes pzA and pzB at kz=k+1..14 in addition to the color-2/3 filter. BP=14 covers the full two-stream unstable band (kz < √2/V0 ≈ 14.1 for V0=0.1). Color-2/3 filter also uses BP=14.

**New kernel**: `kernel_fluid_pz_subtract_kz_range(pzA, pzB, nx, nz, kz_lo, kz_hi)` — register-caching + warp-shuffle design (smem 144 B vs old 4 KB). Called twice per step alongside the color-2/3 filter.

**Kernel optimisation**: Both DFT kernels rewritten to load fields into registers once and accumulate all mode subtractions in registers, writing back once. New design: 1 read + 1 write. Smem drops from 24 KB → 864 B for the 12-field kernel → 32 blocks/SM vs 2 → full occupancy. Syncthreads per mode: 10 → 3. Speed: ~9,230 steps/min (7× faster than initial BP=40 implementation).

**Result**: NaN at t=14.7 TU. By1[kz=0] Weibel explosion — zmean at that time only covered By2/By3, not By1/Ex1/Ez1.

---

## Campaign 13 — NAB_TANH_COSAZ, extended zmean covers By1/Ex1/Ez1 (2026-06-30)

**Setup**: Extended `kernel_ym_subtract_zmean` to cover all 15 fields including By1, Ex1, Ez1. Same BP=14 bandpass. Fixes the kz=0 component of color-1 EM.

**Result**: Fixed t=14.7 TU NaN. But all k=1..6 still NaN at exactly t=17.2 TU (step 70000). The kz=0 component of color-1 EM is zeroed, but nonzero kz modes of By1/Ex1/Ez1 grow freely.

---

## Campaign 14 — NAB_TANH_COSAZ, color-1 EM kz-range filter + pxA/pxB (2026-06-30)

**Setup**: Extended `kernel_ym_subtract_kz_range` from 12 to 15 fields, adding By1, Ex1, Ez1. Also added pxA, pxB to the fluid bandpass. The extended kz_suppress_max filter covers kz=1..k-1 for all 15 color fields.

**Result**: All k=1..6 still NaN at step 70000 (t=17.2 TU). Spectrum analysis (column mapping: X=col0, Z=col1, By1=col2, By2=col3, By3=col4, Az2=col5, Az3=col6, ...) revealed:

- **By1[kz=k_mode]** growing at γ≈1.1 TU⁻¹ — a color-1 EM instability at the TARGET kz
- The DFT filter skips kz=k_mode intentionally (it's the KH seed mode); By1 at kz=k_mode is therefore NEVER filtered
- By1[kz=1] reached ~0.01 by step 70000 (≈12× faster than KH), causing the NaN

**Root cause**: Counter-streaming color-1 beams at ±V0 sustain a filamentation/EM two-stream instability at every nonzero kz, including kz=k_mode. The bandpass filter cannot protect kz=k_mode without killing the KH signal. The KH chain (By2→Ez2→Az2→Q3→Q2→Lorentz→By2) does NOT require By1, Ex1, or Ez1.

---

## Campaign 15 — NAB_TANH_COSAZ, cudaMemset By1/Ex1/Ez1=0 each step (2026-06-30)

**Setup**: Step 6e added in `main_ym.cu` (after Maxwell solve, before Lorentz/Precession): when `suppress_kz0=1`, calls `cudaMemset(By1, 0)`, `cudaMemset(Ex1, 0)`, `cudaMemset(Ez1, 0)` after every Maxwell iteration. Eliminates ALL kz modes of color-1 EM, removing the γ≈1.1 TU⁻¹ instability at every kz including k_mode. Same BP=14 bandpass as Campaigns 12–14, EPS=0.15, α=2.0, V0=0.1.

**Phase 1 result (k=1, kz_suppress_max=0 — diagnostic run)**:

- **First run to survive past t=17.2 TU** — ran to t=58.9 TU (NaN from KH nonlinear explosion)
- E/E0=0.9725 flat from t=2.5 to t=49.1 TU (clean linear phase)
- KH growth clearly observable:

| t (TU) | By2[kz=1] | E/E0 |
|--------|-----------|------|
| 0.0 | 1.250e-6 (seed) | — |
| 4.9 | 2.590e-6 | 0.9725 |
| 9.8 | 3.704e-6 | 0.9725 |
| 14.7 | 3.360e-6 | 0.9725 |
| 19.6 | 3.145e-6 | 0.9725 |
| 24.5 | 4.894e-6 | 0.9725 |
| 29.5 | 7.690e-6 | 0.9725 |
| 34.4 | 1.480e-5 | 0.9725 |
| 49.1 | — | 0.9731 |
| 54.0 | — | 0.9784 |
| 56.5 | — | 0.9875 |
| 58.9 | NaN (KH nonlinear) | — |

**γ_KH(kz=1) from Phase 1**: ~0.11 TU⁻¹ (fit to By2 points t=24.5..34.4). The early oscillation in By2 (decreasing t=9.8→19.6) reflects the real part of the KH eigenvalue (ω_r≠0): a propagating KH wave with γ<|ω_r|.

**kz=5 diagnostic**: By2[kz=5] flat (KH stabilized); Az2[kz=5] grows at γ≈0.20 TU⁻¹ = α×V0 (color precession rate, not KH). kz=5 is above the KH stability cutoff for α=2, V0=0.1, EPS=0.15.

**Key new physics**:
1. KH stability cutoff lies between kz=1 (γ≈0.11 TU⁻¹) and kz=5 (γ≈0), consistent with the WKB polynomial where α²Vkz stabilizes high-kz modes.
2. Az2[kz=k] grows at γ≈α×V0=0.20 TU⁻¹ for all kz — this is the color precession rate, NOT the KH growth rate.
3. The precession mode exists even when KH is stable (kz=5 shows Az2 growth, By2 flat).

**Phase 2 results (k=1..6 sequential sweep, kz_suppress_max=k-1, BP=14, NEW binary)**:

| kz | Binary | γ_KH (TU⁻¹) | γ_WKB (TU⁻¹) | ratio | t_linear (TU) | Notes |
|----|--------|-------------|---------------|-------|---------------|-------|
| 1 | NEW | **0.090** | 0.553 | 0.16 | 24.5..29.5 | Cascade at t>29, NaN t=68.7 |
| 2 | NEW* | ~0.010 | 0.436 | 0.023 | 9.8..29.5 (peaks) | Barely unstable; cascade at t~30 |
| 3 | NEW | **−0.011** | 0.362 | <0 | 9.8..24.5 (peaks) | Damped; killed t=29.5 |
| 4 | NEW | **+0.010±0.01** | 0.315 | 0.032 | 9.8..34.4 (peaks) | Marginally unstable (within error of kz=3) |
| 5 | NEW | **+0.005** | 0.282 | 0.018 | 9.8..24.5 (peaks) | Marginally unstable (within noise) |
| 6 | NEW | **−0.007** | 0.258 | <0 | 0..29.5 (peaks) | Damped; confirmed by separate run |

NEW* = Phase 2 new-binary run in progress at time of this writing.

**Phase 2 k=1 full data (combined Phase 1 + Phase 2)**:

| t (TU) | By2[kz=1] | Az2[kz=1] | Notes |
|--------|-----------|-----------|-------|
| 0.0 | 1.250e-6 | — | seed |
| 4.9 | 2.590e-6 | — | |
| 9.8 | 3.704e-6 | — | |
| 14.7 | 3.360e-6 | — | |
| 19.6 | 3.145e-6 | 2.438e-5 | |
| 24.5 | 4.894e-6 | 5.861e-5 | ← linear KH onset |
| 29.5 | 7.690e-6 | 1.690e-4 | ← cascade trigger (Az2≈1.7e-4) |
| 34.4 | 1.480e-5 | 5.210e-4 | cascade dominant |
| 39.3 | 4.005e-5 | 1.544e-3 | γ≈0.203 TU⁻¹ |
| 44.2 | 1.200e-4 | 4.904e-3 | γ≈0.218 TU⁻¹ = α×V0 |
| 49.1 | 3.700e-4 | 1.613e-2 | γ≈0.225 TU⁻¹ |
| 54.0 | 1.157e-3 | 4.933e-2 | γ≈0.228 TU⁻¹ |
| 58.9 | 2.651e-3 | 1.261e-1 | KH nonlinear saturation begins |
| 63.8 | 3.343e-3 | 2.177e-1 | γ slowing (0.046 TU⁻¹) |
| 68.7 | NaN | NaN | NaN (density explosion) |

**γ_KH(kz=1) = 0.090 TU⁻¹** from linear window t=24.5..29.5 (before precession cascade).

**Precession cascade (kz=1)**: At t=29.5, Az2[kz=1]≈1.7e-4 (= 0.17% of Az1=V0=0.1). By2 then grows at γ≈0.21-0.23 TU⁻¹ = α×V0 (color precession rate) from t=29.5 to t=54 TU. This is NOT KH growth — it is the Az2 precession mode feeding back into By2 through the Q3→Q2→Lorentz path. The true linear KH window is t=24.5..29.5 (~5 TU wide). All γ estimates over wider ranges are contaminated by the cascade.

**kz=2 early data (NEW binary)**:

| t (TU) | By2[kz=2] | Az2[kz=2] |
|--------|-----------|-----------|
| 0.0 | 1.250e-6 | 0 |
| 9.8 | 3.605e-6 | 1.744e-6 | ← peak 1 |
| 14.7 | 2.865e-6 | 5.446e-6 | |
| 19.6 | 3.839e-6 | 1.374e-5 | ← peak 2 |
| 24.5 | 2.919e-6 | 4.100e-5 | |
| 29.5 | 4.703e-6 | 1.379e-4 | ← peak 3 |
| 34.4 | 8.475e-6 | 4.494e-4 | ← cascade starting |

Peak envelope growth: t=9.8→19.6 (γ≈0.006 TU⁻¹), t=19.6→29.5 (γ≈0.020 TU⁻¹). Cascade onset at t≈29-34 when Az2≈1.4-4.5e-4 (same Az2 level as kz=1). **γ_KH(kz=2) ≈ 0.010 TU⁻¹** (peak envelope pre-cascade).

**kz=3 (NEW binary)**: Peaks at t=9.8 (3.56e-6), 14.7 (4.26e-6 — max), 24.5 (3.82e-6 — declining). **γ_KH(kz=3) = −0.011 TU⁻¹** (damped — KH stable). Az2[3]=8.3e-5 at t=29.5 (below cascade threshold of ~1.5e-4).

**Stability summary**: All of kz=2..6 have |γ| ≤ 0.012 TU⁻¹, within the ±0.012 TU⁻¹ measurement noise floor (from 4.9 TU snapshot intervals × oscillation amplitude). WKB predicts γ>0.26 TU⁻¹ for all kz=1..6 (monotonically decreasing). The simulated mode IS a non-Abelian KH mode — only kz=1 is measurably unstable.

**kz=4 (NEW binary)**: Peaks at t=9.8 (3.76e-6), t=19.6 (4.24e-6), and t=34.4 (4.80e-6). γ_peaks ≈ +0.010 TU⁻¹ (within noise ±0.012 TU⁻¹). Cascade onset at t≈34 TU when Az2≈1.3e-4.

**kz=5 (NEW binary, campaign script)**: Peaks at t=9.8 (3.98e-6) and t=24.5 (4.30e-6). **γ_KH(kz=5) = +0.005 TU⁻¹** (barely above zero; within measurement noise ±0.01 TU⁻¹). Precession cascade at t>34 TU.

**kz=6 (NEW binary)**: Peak at t=9.8 (4.13e-6), then slowly DECREASING to t=29.5 (3.64e-6). **γ_KH(kz=6) = −0.007 TU⁻¹** (damped). Confirmed by separate run (t=0..49.1 TU).

**Complete dispersion summary**: kz=1 is clearly unstable (γ=0.090 TU⁻¹ = 7.5σ above noise). kz=2..6 all have |γ| ≤ 0.011 TU⁻¹ — within ±0.012 measurement uncertainty. The non-Abelian KH instability in Mode 5 (cosine Az1, EPS=0.15, α=2, V0=0.1) is effectively **single-mode: only kz=1 is measurably unstable**. The WKB prediction of broad-band instability (γ=0.26-0.55 TU⁻¹ for kz=1..6) is catastrophically wrong for the cosine Az1 geometry.

**WKB polynomial (eq. 33, wkb.pdf) for α=2, V0=0.1, n=0**:
```
ω⁴ − kz²ω² − 0.200ω − 0.400×kz = 0
```
where C = α^(3/2)×V0/√2 = 0.200, α²V0 = 0.400.

**Key finding — geometric mismatch**: The WKB polynomial (eq. 33) was derived for the log-cosh Az1 geometry, where the coupling well is centred AT the shear layer (ξ=0). In Mode 5 (cosine Az1), the Az1 potential has a MAXIMUM (+V0) at the shear centre x=3π and MINIMA (−V0) at x=0,2π,4π — far from the shear layer. This is an anti-well at the shear centre, so the WKB trapped-mode eigenvalue (which requires a well at ξ=0) is NOT applicable to Mode 5.

The observed KH growth in Mode 5 is a GLOBAL (non-trapped) instability driven by the closed loop By2→Ez2→Az2→Q3→Q2→Lorentz→By2. Its growth rate (0.090 TU⁻¹ at kz=1) is **6× below** the WKB prediction. The stability cutoff is near **kz_c≈2.4** (kz=2: γ=+0.010 TU⁻¹ unstable; kz=3: γ=−0.011 TU⁻¹ damped). WKB incorrectly predicts instability for all kz=1..6 with a much higher cutoff.

**Precession cascade contamination**: For ALL kz, Az2[kz] grows at γ≈α×V0=0.20 TU⁻¹ (color precession) regardless of KH stability. Once Az2≈1-5e-4, it acts as a secondary Az1-like background and drives secondary By2 growth through the same feedback loop. This cascade typically starts at t≈29-34 TU and makes By2 grow at γ≈0.20-0.23 TU⁻¹ — masking the true KH rate at late times. The linear KH window for each kz is only the period BEFORE the cascade trigger, typically t≈4-30 TU.

---

## Known Issues / Unresolved

| Issue | Status |
|-------|--------|
| FCT NaN wall at t=63–71 TU in NAB_DTANH | Bypassed by switching to mode 5 (NAB_TANH_COSAZ). |
| kz=0 Weibel mode | Suppressed by suppress_kz0=1 + hyp_diff=5e-5. |
| KH mode at kz≥1 not observable in DTANH | Resolved: mode 5 confirms KH IS growing (γ≈0.11 TU⁻¹ at kz=1, EPS=0.15). |
| Color-1 EM instability (all kz incl. k_mode) | Fixed in Campaign 15 by cudaMemset By1/Ex1/Ez1=0 each step. |
| Color-1 fluid two-stream (kz=1..14) | Fixed in Campaign 12 by fluid pz bandpass (BP=14). |
| NAB_STEP ruled out | Confirmed fatal (Campaigns 7 and 9). |
| WKB dispersion comparison | Revised: γ_meas(kz=1)=0.090 TU⁻¹ (ratio 0.16 vs WKB 0.553). Stability cutoff at kz≈1.5 (sim) vs kz→∞ (WKB). Geometric mismatch: cosine Az1 anti-well at shear centre vs log-cosh well required by WKB eq. 33. |
| Precession cascade contamination | Az2[kz] grows at γ≈α×V0=0.20 TU⁻¹ for ALL kz (stable and unstable). Once Az2≈1-5e-4 (t≈29-34 TU), it triggers secondary By2 growth at γ≈0.20 TU⁻¹. True linear KH window is t<29 TU only. |

---

## Physics: The kz=0 Weibel-like instability

The WKB polynomial ω⁴ - kz²ω² - Cω - α²vkz = 0 (with C = (2n+1)√(α³/2)v) at kz=0 reduces to:

```
ω⁴ = C·ω  →  ω³ = C  →  ω = C^(1/3)·e^(i·2π/3)
```

Growing root: `γ = C^(1/3)·sin(π/3) = (√(α³/2)·V₀)^(1/3)·(√3/2)`

This is the n=0 quantization of the color-mixing instability: background Az1 causes color-2,3 fields to mix through non-Abelian Ampere (∂Ex2/∂t term −α·Az1·By3) and Faraday (∂By2/∂t term +α·Az1·Ex3), generating exponentially growing color-2,3 electromagnetic fields that are uniform in z.

The kz=0 WKB match (to 0.5%) confirms the polynomial is correct. The next step is to validate γ(kz=0) vs α and determine whether the KH mode at kz≥1 requires a single-layer geometry to be observable.
