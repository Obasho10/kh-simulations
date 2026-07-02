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
