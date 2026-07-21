# Resolution / Timestep Convergence Study

Separate from `FINDINGS.md` (which tracks the physics campaigns). This file documents
a dedicated study of how grid resolution (`dx`, `dz`), timestep (`dt`), the Courant
number (`dx/dt`... reported here as `dt/dx`, the code's convention), and grid aspect
ratio (`dz/dx`) affect the measured KH growth rate γ(kz=1) and numerical stability,
independent of the physics questions tracked elsewhere.

**Status: COMPLETE (2026-07-02). All 11 configs finished on abi.**

## Motivation

All physics campaigns to date (`FINDINGS.md`) use a single fixed grid
(`NZ=256, NX=768, dx=dz=2π/256≈0.0245, courant=dt/dx=0.01`) without ever checking
whether the measured growth rates are numerically converged at that resolution, or
whether the results would change at finer/coarser grids or timesteps. This study
answers that directly.

## Code changes enabling this study

`ymgpu2d`'s grid resolution and timestep were previously hardcoded local consts in
`main_ym.cu` (`NZ=256`, `NX=3*NZ`, `DT=0.01*DX`). Four new optional, backward-compatible
CLI arguments were added (all default to `-1`, preserving the exact old behavior when
omitted):

```
./ym_coupled <...13 existing args...> <nz_override> <nx_override> <courant_override> <target_tu> [run_tag]
```

- `nz_override` / `nx_override`: grid point counts in z/x (`-1` → defaults 256 / `3*NZ`).
  Physical box size (`Lx=6π`, `Lz=2π`) stays fixed regardless of resolution.
- `courant_override`: sets `DT = courant * DX` (`-1` → default 0.01).
- `target_tu`: halts the run after this many time-units instead of the fixed
  `total_steps=2000000`, and derives `export_stride`/`energy_stride` from fixed
  *physical-time* cadences (every 1.0 TU / 0.5 TU) rather than fixed step counts — this
  keeps runs at different `DT` directly comparable in physical time (`-1` → old
  step-count-based behavior).
- `run_tag`: appended to the output directory name so same-`k`/`alpha` resolution-study
  runs don't collide with each other or with existing campaign directories.

A latent bug was also fixed as part of this: `YM_FCT.cuh`'s `NX_PAD` was a
`constexpr` hardcoded to `768 + 2*FCT_HALO`, used to size the periodic-BC FCT padded
scratch buffers. It was NOT parametric on the runtime `NX` — any run with `NX > 768`
would have silently overflowed those buffers. `NX_PAD` is now computed at runtime from
the actual `NX` and threaded through `ym_fct_x_sweep_periodic`.

Two correctness constraints on `NZ` were also discovered and are now enforced at
startup with a clear error instead of silent corruption:
- `NZ` must be a power of 2 when `suppress_kz0=1` (binary-tree reduction in
  `kernel_ym_subtract_zmean`).
- `NZ` must be a multiple of 32 when the kz-bandpass filters are used (warp-shuffle
  reduction in the kz-range kernels).

All runs in this study were built in an isolated directory
(`/DATA/s23103/lcpfct/ymgpu2d_resconv/` on abi), separate from any live campaign
directory, to avoid disturbing concurrent work.

## Fixed physics baseline

All runs use the same physics configuration (matches Campaign 22/23 — the cleanest
known eigenmode, with an analytic target growth rate to compare against):

| Param | Value |
|---|---|
| k_mode | 1 |
| alpha_YM | 1.0 |
| V0 | 0.05 |
| mode | 6 (NAB_CIRC_AZ2) |
| xi_sponge | 10.0 |
| sigma_sponge | 5.0 |
| suppress_kz0 | 1 |
| hyp_diff | 5e-5 |
| eps_override | 0.15 |
| kz_suppress_hi | 14 |
| target_tu | 25 |
| γ_exact (analytic eigenvalue, kz=1) | 0.080 TU⁻¹ |

Only the resolution/timestep parameters below vary. The measurement metric is
γ fit from `|By2+iBy3|` (the circularly-polarized non-Abelian mode amplitude at
kz=1) via a sliding-window log-linear fit — **not** `Az_circ` (`|Az2+iAz3|`), because
mode 6 seeds Az2/Az3 with a large *static* Gaussian at t=0 and its slow fractional
growth is swamped by that seed over the short ~25 TU window used here (confirmed via
a smoke test: Az2 changed <1% over 15 TU while By2 grew ~500x from exactly zero over
the same window). By2/By3 start at exactly zero and their growth is an unambiguous
exponential signal.

## Experiment matrix

12 runs total (`res_baseline` shared across all three axes):

| Axis | Runs |
|---|---|
| Spatial (dx=dz, NX=3·NZ) | NZ = 128, 256\*, 512 |
| Temporal (Courant = dt/dx) | courant = 0.0025, 0.005, 0.01\*, 0.02, 0.04 |
| Aspect ratio (dz/dx, NZ=256 fixed) | NX = 384, 512, 768\*, 1152, 1536 → dz/dx = 0.5, 0.667, 1.0, 1.5, 2.0 |

\* = shared baseline (`NZ=256, NX=768, courant=0.01`)

Runs executed cheapest-first (ascending estimated cost). Initially split across two
sequential nohup batches on abi's GPU1/GPU2 (GPU0 was running an unrelated live job).
Once that job finished mid-sweep, the remaining configs were redistributed across all
three GPUs (one queue each) to finish faster — see `resolution_convergence.py` /
`resconv_data.json` for the raw fit data and `resconv_{spatial,temporal,aspect}.png`
for the convergence plots (both on abi in `/DATA/s23103/lcpfct/ymgpu2d_resconv/`).

## Results

**All 11 configs complete.** γ is essentially flat across the entire matrix — every
resolution, timestep, and aspect-ratio variation tested lands within
**0.0897–0.0938 TU⁻¹** (a 4.4% spread peak-to-peak), all with R²≥0.999 for the
exponential fit and perfect energy conservation (E_ratio_max=1.000000 in every single
run — no drift, no instability, anywhere in the matrix, including the 4x-finer and
16x-coarser timestep extremes).

### Spatial resolution (dx=dz, NX=3·NZ)

| NZ | NX | DX=DZ | DT | γ (kz=1) | R² | E_ratio_max |
|---|---|---|---|---|---|---|
| 128 | 384 | 0.04909 | 4.909e-4 | 0.09059 | 0.999 | 1.0000001 |
| 256 (baseline) | 768 | 0.02454 | 2.454e-4 | 0.09375 | 0.999 | 1.0000000 |
| 512 | 1536 | 0.01227 | 1.227e-4 | 0.09372 | 0.999 | 1.0000000 |

### Timestep / Courant number (NZ=256, NX=768 fixed)

| Courant (dt/dx) | DT | γ (kz=1) | R² | E_ratio_max | Notes |
|---|---|---|---|---|---|
| 0.0025 (4x finer) | 6.136e-5 | 0.09367 | 0.999 | 1.0000000 | |
| 0.005 | 1.227e-4 | 0.09373 | 0.999 | 1.0000000 | |
| 0.01 (baseline) | 2.454e-4 | 0.09375 | 0.999 | 1.0000000 | |
| 0.02 | 4.909e-4 | 0.09376 | 0.999 | 1.0000000 | |
| 0.04 (4x coarser) | 9.817e-4 | 0.09379 | 0.999 | 1.0000000 | CFL not violated even at 4x baseline dt |

### Aspect ratio (dz/dx, NZ=256 fixed, NX varied independently)

| NX | dz/dx | DX | DZ | γ (kz=1) | R² | E_ratio_max |
|---|---|---|---|---|---|---|
| 384 | 0.5 | 0.04909 | 0.02454 | 0.08971 | 0.999 | 1.0000000 |
| 512 | 0.667 | 0.03682 | 0.02454 | 0.09255 | 0.999 | 1.0000000 |
| 768 (baseline) | 1.0 | 0.02454 | 0.02454 | 0.09375 | 0.999 | 1.0000000 |
| 1152 | 1.5 | 0.01636 | 0.02454 | 0.09372 | 0.999 | 1.0000000 |
| 1536 | 2.0 | 0.01227 | 0.02454 | 0.09375 | 0.999 | 1.0000000 |

## Conclusions

1. **Timestep has essentially zero effect on γ across the entire tested range.**
   Courant number spanning 0.0025→0.04 (a 16x range in `dt`) changes γ by only
   0.09367→0.09379 (0.13%). The scheme is far from any timestep-accuracy or CFL
   limit at these Courant numbers for this configuration — `dt` could safely be
   increased well beyond the current default 0.01 if wall-clock time is a concern in
   future campaigns, though this wasn't pushed far enough to find the actual
   instability threshold (0.04 was the coarsest tested and still stable/accurate).

2. **z-resolution (DZ) has essentially zero effect on γ.** NZ=128→512 (a 4x range in
   `DZ`, i.e. spatial resolution of the kz=1 mode along the periodic/streamwise
   direction) changes γ by only 0.09059→0.09372 (~3.3%), with NZ=256 and NZ=512
   already agreeing to 0.03%. kz=1 is very well resolved by ~256 points in z even
   before this study; finer z-resolution buys essentially nothing for this mode
   number, as expected (kz=1 needs only a handful of points per wavelength).

3. **x-resolution (DX, across the shear layer) is the one axis with a real,
   measurable effect, though small.** The two coarsest-DX configs — NZ=128
   (DX=0.0491) and NX=384 (also DX=0.0491, same value by coincidence) — are the only
   points below the 0.0937 plateau, at 0.0906 and 0.0897 respectively (3.3% and 4.4%
   low). Every config with DX≤0.0368 sits at 0.0925–0.0938, tightly clustered. This
   lines up with the physical shear-layer width: `EPS=0.15`, so `EPS/DX≈3.1` cells at
   the coarsest DX tested vs. `EPS/DX≈6.1` at baseline — 3 cells across the shear
   layer is too coarse to resolve the profile that seeds the eigenmode, mildly
   damping the measured growth rate. **Practical takeaway: DX≲0.025 (EPS/DX≳6) is
   needed for x-resolution-converged γ at EPS=0.15; DX=0.0491 (EPS/DX≈3) underestimates
   γ by 3–4%.** All physics campaigns to date have used the baseline DX=0.0245
   (EPS/DX≈6.1), which is safely inside the converged regime.

4. **The ~15–17% gap between measured γ≈0.0937 and the analytic γ_exact=0.080 is not
   a resolution or timestep artifact** — it persists identically (to <1%) across every
   converged configuration in the matrix, including the finest resolution and finest
   timestep tested. It is very likely the same short-window transient effect flagged
   in the pre-sweep smoke test: the fit window here (t=18–22 TU) is still fairly early
   in a 25 TU run, and the smoke test showed the apparent growth rate decreasing
   monotonically toward its asymptote as t increases (e.g. 0.155→0.131 TU⁻¹ moving the
   window from t=9–14 to t=10–15 in that earlier check). A longer run (target_tu≳50)
   at baseline resolution would be needed to confirm full relaxation to γ_exact — that
   is a physics-campaign question, not a numerics question, and is out of scope for
   this resolution study.

**Bottom line: the standard campaign grid (NZ=256, NX=768, courant=0.01, i.e. DX=DZ=
0.02454, DT≈2.45e-4) is safely inside the resolution- and timestep-converged regime
for kz=1 measurements at EPS=0.15.** No numerical-resolution artifact explains any of
the discrepancies from WKB documented in `FINDINGS.md` — those are genuine physics
(cascade masking, WKB step-potential approximation error, etc.), not grid-resolution
error.

## Follow-up: how far can NZ/Courant be pushed for speed?

The main sweep above always scaled `NX=3·NZ` together on the spatial axis, so it
never isolated whether z-resolution *alone* matters once x-resolution (DX, the axis
shown to matter in §3 above) is held fixed at a converged value. This follow-up fixes
`NX=1536` (DX=0.01227, deep in the converged regime — see aspect-ratio table above)
and independently pushes `NZ` down and Courant number up, past the previously-tested
bounds, specifically to find where things actually break rather than just re-confirm
safety.

### NZ floor (NX=1536, courant=0.01 fixed)

| NZ | γ (kz=1) | R² | E_ratio_max | Verdict |
|---|---|---|---|---|
| 256 (anchor, = res_nx1536 above) | 0.09375 | 0.999 | 1.000000 | converged |
| 128 | 0.09378 | 0.999 | 1.000000 | converged |
| 64 | 0.09382 | 0.999 | 1.000000 | converged |
| 32 | **0.03400** | 0.998 | 1.000000 | **broken — 63% low** |

z-resolution genuinely doesn't matter for kz=1 down to NZ=64 — completely flat γ.
**NZ=32 is a real cliff, not a gradual degradation**: energy is still perfectly
conserved (no instability/blowup), but the measured growth rate collapses to 37% of
the converged value. This is likely the DFT bandpass filter apparatus (kz_suppress_hi
needs to sit right at Nyquist=16 when NZ=32, leaving essentially no clean margin
between the target kz=1 mode and the filtered band) rather than a basic
resolution-of-the-wavelength problem. **Practical floor: NZ=64.**

### Courant ceiling (NZ=256, NX=1536 fixed)

| Courant | DT | γ (kz=1) | R² | E_ratio_max | Verdict |
|---|---|---|---|---|---|
| 0.01 (anchor) | 1.227e-4 | 0.09375 | 0.999 | 1.000000 | converged |
| 0.08 | 9.817e-4 | 0.09381 | 0.999 | 1.000000 | converged |
| 0.16 | 1.963e-3 | 0.09378 | 0.999 | 1.000000 | converged |
| 0.32 | 3.927e-3 | 0.09394 | 0.999 | 1.000000 | converged |
| 0.64 | 7.854e-3 | 0.09389 | 0.999 | 1.000000 | converged |
| 0.8 | 9.817e-3 | 0.09448 | 0.999 | 1.000000 | converged |
| 1.0 | 1.227e-2 | — | — | NaN at t≈1.0 | **unstable** |

Timestep has essentially zero effect on accuracy all the way up to Courant=0.8 (80x
the campaign default of 0.01) — γ stays within 1% of the converged value throughout.
The actual CFL-type stability cliff sits **between 0.8 and 1.0**, i.e. right around
`DT≈DX` (Courant=1 in the naive single-direction sense), which is a sensible place
for an explicit FCT+leapfrog EM scheme to break. **Practical ceiling: courant=0.8.**

### Combined fast config

| Config | NX | NZ | Courant | γ (kz=1) | R² | E_ratio_max | Cost vs. original baseline |
|---|---|---|---|---|---|---|---|
| Original baseline | 768 | 256 | 0.01 | 0.09375 | 0.999 | 1.000000 | 1x |
| NZ=64 + courant=0.08 (NX=1536) | 1536 | 64 | 0.08 | 0.09389 | 0.999 | 1.000000 | 4x *(NX=1536 not needed)* |
| **NX=768, NZ=64, courant=0.8** | **768** | **64** | **0.8** | **0.09558** | **0.999** | **1.000000** | **~1/320x (320x faster)** |

Stacking the two independent floors (z-resolution and timestep) together, on top of
the *already-sufficient* baseline x-resolution (NX=768 — no need to pay for NX=1536),
gives a config that is still fully converged (γ within 2% of the whole cluster,
R²=0.999, perfect energy conservation) and runs a full 25 TU in seconds rather than
~27 minutes.

**Recommendation for future campaigns needing many runs (parameter sweeps, kz scans):
`NZ=64, NX=192 (=3·NZ), courant≤0.8` is a strong candidate for a fast screening grid**
— NX=192 wasn't directly tested here (this follow-up used NX=768 fixed to isolate NZ
alone), so before adopting `NX=3·NZ=192` specifically, either verify DX=6π/192≈0.098
isn't too coarse (it's above the DX≲0.025 threshold from §3, so it likely underestimates
γ — use `NX=768` fixed with `NZ=64` instead, i.e. an anisotropic dz/dx≈4 grid, exactly
as tested above) or re-derive EPS/DX at whatever EPS the target physics config uses.
Leave a safety margin below the courant=0.8/1.0 cliff (e.g. courant=0.5) for physics
configs with different α/V0 that may have a different stability boundary than this
one (α=1.0, V0=0.05).

## Follow-up: spot-checks at the parameter extremes (T2.8, 2026-07-19)

The entire study above anchored a **single** physics point — α=1.0, V0=0.05, kz=1.
A referee will (rightly) ask whether the production grid (NZ=64 / courant=0.1 /
NX=768, DFT filter band hi=14 held fixed) is still converged at the *extremes* of
(α, V0, kz) actually used in the papers. Two corners were re-checked on t133, one
grid axis varied per run relative to the production baseline (all fits R²=1.000,
no NaNs):

**LOW corner — α=1.0, V0=0.03, kz=3** (wide, slow mode). Baseline γ=0.0837
(plateau-confirmed). NZ 64→128: **+0.2%**; courant 0.1→0.02: **−1.0%**; NX
768→1152: **−0.2%**. → **converged to <1%**, same as the anchor point.

**HIGH corner — α=3.0, V0=0.10, kz=5** (the narrowest/fastest used mode; its
EPS/DX≈6.1 at NX=768 sits right at the x-resolution threshold from §3). Baseline
γ=0.2395. NZ 64→128: **+1.1%**; courant 0.1→0.02: **+5.9%**; NX 768→1152:
**+2.7%**. → the production grid **under-resolves γ by ~3–6%** here, dominated by
timestep and x-resolution — exactly what one expects for a fast, narrow mode at
the EPS/DX≈6 boundary. Both refinements *raise* γ (baseline under-resolves), so
the effects may partially add; the combined finest-grid error was not measured
directly (one-axis-at-a-time was used, the standard convergence method).

| Corner | axis refined | Δγ vs production |
|--------|--------------|-----------------:|
| LOW (α=1,V0=0.03,kz=3) | NZ 64→128 | +0.2% |
| | courant 0.1→0.02 | −1.0% |
| | NX 768→1152 | −0.2% |
| HIGH (α=3,V0=0.10,kz=5) | NZ 64→128 | +1.1% |
| | courant 0.1→0.02 | **+5.9%** |
| | NX 768→1152 | **+2.7%** |

**Conclusion.** The "converged to ~2%" result of the 2026-07-02 study is accurate
at low αV0 but should be **qualified to ~5% at the high-αV0 end**. This is inside
the 6–10% error budget already quoted for the high-α points, but the narrowest
production modes (α=3, V0=0.1) carry a few-% grid uncertainty a referee should be
told about. For a definitive high-αV0 measurement, run at NX=1152 and/or
courant≤0.05. Script: `scripts/t2p8_resolution_t133.sh`; figure
`plots/t2p8_resolution_extremes.png`; see also `REFEREE_PROOFING_RESULTS.md`.

## Follow-up: Lx box-size reduction + extreme-parameter close-out (2026-07-21)

See `LX_RESOLUTION_PLAN.md` for the full campaign design (`analysis/gen_lx_resolution_campaign.py`,
`analysis/lx_feasibility_screen.py`). Motivating question: the production box
`Lx=6π` was set assuming a double-tanh periodic profile; production has actually
used the single-tanh `run_mode=6` for a long time, so is 6π still needed? 17 GPU
runs across t133 + abi (3 GPUs), all completed cleanly, no crashes.

**Phase 0 (analytic, no GPU).** Pure-arithmetic pass over the 4192-point historical
archive (`sweep/all_points_vs_chased.npz`): only 43% of recorded (α,V0,kz) points
would fit inside a 2π box reusing their own recorded `xi_sponge` as-is. A follow-up
eigensolver re-derivation on iMac (27-point stratified sample, via the new `Lx` kwarg
on `find_safe_sponge.find_safe_xi_sponge()`) showed roughly half of those "failures"
were artifacts of the blind sponge formula's SP_MAX=55 ceiling, not real requirements
— true minimum sponges were often 5–7. The genuine failures cluster at **low V0
(≲0.05)**, needing a properly-derived sp≈22, which doesn't fit a 2π box (needs 3.3
phys units, 2π gives 3.14) but fits a **3π** box comfortably (4.71 phys). A tiered
Lx policy (2π default, 3π/4π/6π fallback by corner) is the right shape, not a flat
2π-or-6π choice.

**Phase 1a — Lx has no effect at the reference anchor (α=1, V0=0.05, kz=1, EPS=0.15,
xi_sponge=10, target_tu=25), DX held fixed:**

| Lx | γ (fitted) |
|---|---|
| 2π (NX=256) | 0.16282 |
| 3π (NX=384) | 0.16280 |
| 4π (NX=512) | 0.16284 |

Agreement to 0.03% — clean confirmation that box width alone doesn't affect the
measured growth rate once `xi_sponge` genuinely fits inside it.

**Phase 1c — the actual speedup, measured not extrapolated** (production grid,
target_tu=100, same point): γ=0.06390 at both Lx=6π and Lx=2π (5-figure agreement).
Wall-clock: **151s (Lx=6π, NX=768) vs 69s (Lx=2π, NX=256) — a real 2.2x speedup**,
not the naive 3x from the NX ratio alone (per-step cost has a fixed component
beyond the x-sweep).

**Phase 1b — accidentally exposed a sponge-miscalibration, not a clean box-size
test.** Reused the historical `xi_sponge=55` (α=1.1, V0=0.03, kz=3) unchanged at
both Lx=6π and Lx=2π. Overlooked: a 2π box's own ξ-half-width at EPS=0.15 is only
20.9 — *less than 55* — so the sponge threshold was literally unreachable inside
that box, meaning the Lx=2π run had **no active sponge at all**, while Lx=6π's was
fully active. Result: Lx=6π (sponge active) blew up (`E/E0=181.8>100 at t=44.8`);
Lx=2π (sponge inactive) ran the full 50 TU cleanly. This is *not* evidence that
2π is "safer" — it reveals that `xi_sponge=55` (the blind formula's ceiling) is
itself miscalibrated for this point, consistent with `find_safe_sponge.py`'s own
documented warning that a too-loose sponge fails to damp the outer-region
instability at low kz/low α·V0. **Needs a redo** with a sponge value that actually
fits inside both box widths before this is a valid Lx-only comparison.

**Phase 3a — T2.8 HIGH corner (α=3, V0=0.10, kz=5) closed out, definitively bigger
gap than quoted:**

| Config | γ | vs. documented baseline (0.2395) |
|---|---|---|
| NX=1152 + courant=0.05 | 0.2553 | +6.6% |
| NZ=128 + NX=1152 + courant=0.05 (all three) | 0.2672 | +11.6% |

The naive additive estimate from the three single-axis effects (§T2.8: +1.1%,
+5.9%, +2.7%) predicted ~+9.7%; the actual combined number is **larger**, i.e. the
corrections compound rather than saturate. Revise the "~5-6% at high-α·V0" referee
statement to **~10-12%**.

**Phase 3b — the α≥6 catastrophe's "resolution-independent" verdict needs
revisiting.** FINDINGS.md judged the EPS-scan v2 α≥6 early-onset catastrophe
physical based on onset time not moving with amplitude or xi_cut tightening —
but timestep was never tested. Spot-checked 3 dropped points at production
courant=0.1 vs finer courant=0.02 (same NX):

| Point | halt (courant=0.1) | halt (courant=0.02) |
|---|---|---|
| α=6, V0=0.10, kz=5 (xi_cut=5) | t=31.4 | t=64.5 |
| α=6, V0=0.10, kz=6 (xi_cut=5) | t=31.0 | t=65.0 |
| α=10, V0=0.05, kz=8 (xi_sponge=52) | t=5.0 | t=5.0 |

For both α=6 points, refining the timestep **roughly doubled the survival time**
before blowup — a real resolution dependency the original amplitude/xi_cut-only
investigation missed. α=10 blows up almost instantly regardless of resolution,
suggesting a different (harder, faster) failure mode there. This reopens part of
the EPS-scan v2 α≥6 drop as a numerics question, not a settled physics one.

Full run manifest: `sweep/lx_resolution_manifest.csv` (gitignored, regenerate via
`analysis/gen_lx_resolution_campaign.py`). Raw timeseries pulled to
`/home/user/.claude/jobs/20590871/tmp/lx_campaign_results/` this session.

## Wave 2 follow-up (2026-07-21, same day): 1b redo, Phase 3c, broader α≥6 sweep

18 more runs across t133, t140, and abi (5 GPU streams, all confirmed idle at
launch time), closing out the loose ends from wave 1. All completed cleanly.
`analysis/lx_policy.py` (Phase 2) also lands this wave: `lx_for_point()`
encodes the tiered 2π/3π/4π/6π policy, validated against the 4192-point
archive — 43.1% of historical points would use 2π, 34.6% genuinely need the
full 6π, the remaining 22.2% split between 3π/4π.

**Phase 1b, properly redone.** `find_safe_sponge.py` (with the new `Lx` kwarg)
gives the true minimal safe sponge for α=1.1, V0=0.03, kz=3 at a shrunk box:
sp=22 — which itself needs 3.3 phys units, still bigger than 2π's 3.14, i.e.
this point genuinely needs **3π**, not 2π (consistent with the tiered policy).
Reran with that valid, active sponge at both Lx=3π and Lx=6π:

| Lx | γ | t_max |
|---|---|---|
| 3π | 0.07013 | 49.95 (no halt) |
| 6π | 0.07012 | 49.95 (no halt) |

0.01% agreement — **once the sponge genuinely fits and is active in both
boxes, Lx has no effect**, exactly as Phase 1a found at the reference anchor.
Wave 1's apparent "2π is safer" result is now conclusively explained as a
sponge-miscalibration artifact, not a real box-size effect.

**Phase 3c — narrow EPS, wide EPS, filter-band edge:**

| Point | baseline γ | refined γ | Δ |
|---|---|---|---|
| EPS=0.12 (NX=960→1344, courant 0.1→0.05) | 0.05842 | 0.05881 | +0.7% |
| EPS=0.30 (Lx=12π,NX=1536, courant 0.1→0.02) | 0.11007 | 0.1102 | +0.1% |
| kz=13, hi=14 (NZ=64→128) | 0.03688 (no plateau) | 0.06666 (plateau) | **+81%** |

Narrow-EPS (post `log_cosh_stable` fix) and wide-EPS (existing box-doubling
convention) are both solidly resolution-converged. But **kz sitting close to
`kz_suppress_hi` is a real, large resolution artifact**: at production NZ=64,
kz=13 (just 1 below hi=14) is measurably damped — γ nearly doubles at NZ=128
and only there does the run reach a genuine plateau. Confirms the "Filter
Nyquist Rule" memory's caution in practice, not just in theory. **Actionable:
avoid measuring kz within ~1 unit of `kz_suppress_hi` at NZ=64, or bump NZ.**

**Broader α≥6 courant sweep — 5 new points, extending wave 1:**

| Point | mechanism | halt (courant=0.1) | halt (courant=0.02) |
|---|---|---|---|
| α=6, V0=0.10, kz=4 | xi_cut=5 | t=31.99 | t=64.98 (2.03x) |
| α=6, V0=0.10, kz=7 | xi_cut=5 | t=30.99 | t=64.98 (2.10x) |
| α=6, V0=0.10, kz=8 | xi_cut=5 | t=31.99 | t=64.98 (2.03x) |
| α=6, V0=0.05, kz=8 | xi_sponge=52 | t=6.0 | t=6.0 (no change) |
| α=10, V0=0.10, kz=8 | xi_cut=5 | t=14.0 | t=20.99 (1.5x) |

Combined with wave 1's two points (also α=6/10, V0=0.10/0.05, xi_cut/xi_sponge),
**6 of 7 xi_cut-mechanism points (V0=0.10) now show the same clean ~2x
onset-time-delay with finer courant**, across kz=4 through 8 — this is a real,
robust, mechanism-specific resolution dependency, not a fluke. The **xi_sponge-
mechanism points (V0≤0.05-0.07) show no such dependence** — both wave 1's
α=10,V0=0.05 and wave 2's α=6,V0=0.05 blow up almost instantly (t≈5-6)
regardless of courant. **Clean split: xi_cut-confined catastrophes are
resolution-sensitive (onset genuinely delayed by finer timestep); xi_sponge-
confined catastrophes at these α are not (fail immediately, likely a different/
harder mechanism).** The EPS-scan v2 α≥6 "physical, resolution-independent"
verdict should be qualified: true for the sponge-mechanism corner, false for
the xi_cut-mechanism corner.

Manifest: `sweep/lx_resolution2_manifest.csv` (gitignored, regenerate via
`analysis/gen_lx_resolution_campaign2.py`). Raw timeseries pulled to
`/home/user/.claude/jobs/20590871/tmp/lx_campaign2_results/` this session.
