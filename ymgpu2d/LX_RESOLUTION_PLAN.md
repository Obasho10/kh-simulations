# Campaign: Can Lx shrink from 6π to 2π? + extreme-parameter resolution studies

*Status (2026-07-21): ALL PHASES DONE. Wave 1 (17 runs: Phases 0/1a/1b/1c/3a/3b)
+ wave 2 (18 runs: Phase 1b redo, Phase 2, Phase 3c, broader α≥6 sweep) — 35 GPU
runs total on t133+t140+abi, zero crashes. Results in `RESOLUTION_FINDINGS.md`
§"Lx box-size reduction + extreme-parameter close-out" + §"Wave 2 follow-up" and
`REFEREE_PROOFING_RESULTS.md` §T2.8 update. Headline: Lx=2π is safe and ~2.2x
faster for the reference anchor and most of parameter space, via the tiered
2π/3π/4π/6π policy now implemented in `analysis/lx_policy.py`'s `lx_for_point()`
(not a blanket 2π default — 34.6% of the historical archive genuinely needs the
full 6π). Phase 1b's wave-1 result was a sponge-miscalibration artifact, not a
real box-size effect — redone cleanly in wave 2 (0.01% agreement once a validly-
sized sponge is used). The α≥6 catastrophe's "resolution-independent" verdict is
overturned for the xi_cut-mechanism corner (6/7 points show onset time roughly
doubling with finer courant) but holds for the xi_sponge-mechanism corner
(immediate failure regardless). Phase 3c also surfaced a new, real artifact: kz
within ~1 unit of `kz_suppress_hi` is measurably damped at NZ=64. A mirror of the
original plan (identical content, at the time it was written) also lives at
`/home/user/.claude/plans/so-we-had-started-majestic-newell.md`.*

## Context

`ymgpu2d` has used `Lx=6π` (with `NX=768`) as the default x-domain size since the
resolution-convergence study (`RESOLUTION_FINDINGS.md`, 2026-07-02). The working
assumption was that this width was needed for a "double tanh" periodic profile
(two shear layers back to back). That assumption is now **stale**: production runs
use `run_mode=6` (`NAB_CIRC_AZ2`), a **single** tanh shear layer centered at `Lx/2`
(`YM_Init.cu`); the double-tanh profile is `run_mode=3` and is not used in any
current campaign. So nothing in the initial condition itself requires a 6π box.

However, `Lx=6π` isn't free-floating either — two independent things anchor it:

1. `EPS` (shear half-width) defaults to `Lx/6` in the code, though production
   always overrides it (`eps_override=0.15`), so this link is soft in practice.
2. **x is periodic**, so the single tanh layer needs an absorbing buffer (sponge
   `xi_sponge`, or hard wall `xi_cut`) between the shear layer and the periodic
   wrap. That buffer's *required width in physical units* scales with
   `xi_sponge_needed * EPS`, and `xi_sponge_needed` itself can range from ~5 up to
   `SP_MAX=55` ξ-units (`find_safe_sponge.py`), growing at **low kz / low α·V0**
   (`xi_crit ≈ kz/(α·V0)`). A related existing convention already doubles `Lx`
   for **wide EPS (≥0.30)** because the ξ-space (`(Lx/2)/EPS`) shrinks as EPS grows
   (`gen_epsscan_v2_campaign.py`).

Concretely, at `EPS=0.15`: `Lx=6π` gives a box half-width of **62.8 ξ-units**;
`Lx=2π` gives only **20.9 ξ-units**. The reference production sponge
(`xi_sponge=10-13`) fits 2π with room to spare. But the tachyonic/outer-region
campaign explicitly needed sponges in `[12,33]` ξ-units and states outright it
required "half-width `Lx/2/EPS=62.8` ... no `lx_override` needed" — i.e. some of
that campaign's own points would **not** fit in a 2π box. And `find_safe_sponge.py`'s
ladder tops out at 55 ξ-units for the lowest-kz/lowest-α·V0 corner — nowhere close
to fitting in 2π.

**Bottom line: shrinking Lx is a real, mostly-free win (a flat 3x in NX for the
same DX, i.e. same accuracy, at fixed cost — or a genuine 3x wall-clock speedup at
fixed accuracy), but it cannot be a blanket global default change.** It needs the
same kind of parameter-dependent tiering that already exists for wide EPS. This
campaign verifies that empirically (not just analytically) and encodes the result
as a reusable policy, mirroring the existing `nx_lx_for_eps()` convention. Bundled
into the same campaign: two **already-known, already-flagged-but-not-yet-executed**
resolution gaps at the extreme end of parameter space (the T2.8 high-α·V0 corner,
and the un-resolution-tested α≥6 early-catastrophe onset) get closed out, since the
extreme-parameter resolution question shares the exact same infrastructure/methodology.

**No CUDA/C++ changes are needed anywhere in this plan.** `lx_override`,
`nx_override`, `courant_override`, and `eps_override` all already exist and are
wired through `YM_Config.cu` / `main_ym.cu`. Everything here is new `.ini`
generation (Python) run against the existing built `ym_coupled` binary on each
node, plus new analysis scripts. Skip the "rebuild + smoke test" step entirely
unless a future session touches the CUDA source.

---

## Phase 0 — Analytic feasibility screen (CPU only, no GPU time)

Goal: know *before* spending GPU time which parameter regions are safe at which
`Lx` tier, using data that already exists.

1. **Fix the Lx-plumbing gap in the eigensolver library path.** `ym_eigenmode.py`
   only lets `--Lx` be set via its CLI (`main()` does `global LX, LZ; LX = args.Lx`
   at line ~307); `build_matrix()`/`solve_eigenmode()` read the **module-level
   global** `E.LX` (see `find_safe_sponge.py:119`, `dx = E.LX / NX`), not a
   parameter. Add an `Lx` kwarg to `find_safe_sponge.hunt_eigs()` and
   `find_safe_xi_sponge()` that sets `E.LX = Lx` (default `6*np.pi`, preserving
   current behavior) before calling into `build_matrix`/`solve_eigenmode`. This
   is the only code change Phase 0 needs.

2. **Pure-arithmetic pass over the real historical dataset.** Load
   `sweep/all_points_vs_chased.npz` (4195 real production points: `alpha`, `V0`,
   `kz`, `eps`, `xi_sponge` all recorded — this *is* the actual parameter space
   campaigns have used, no need to invent a synthetic grid). For each point compute
   `half_width_needed = xi_sponge * eps` (the buffer width actually used, in
   physical units) and compare against `Lx/2` for each candidate tier
   `Lx ∈ {2π, 3π, 4π, 6π}` (plus the existing `2×` rule for any point with
   `eps≥0.30`). Produce a table/plot: fraction of the 4195 points safe at each
   tier, broken down by `kz` and `alpha*V0` bins. This tells you directly which
   corner of parameter space (expect: low kz, low α·V0) is the one that needs a
   wider box — do not assume, read it off the data.

3. **For points that fail the 2π check in step 2**, don't assume they're stuck —
   run `find_safe_sponge.find_safe_xi_sponge(alpha, V0, kz, Lx=2*math.pi)` (using
   the new kwarg from step 1) to see if a *tighter, re-derived* sponge (the ladder
   search already hunts downward from the blind formula) would actually fit 2π.
   Some points may have simply never needed a small sponge before because the box
   was already comfortably wide, not because a small sponge is impossible.

4. Write this as `analysis/lx_feasibility_screen.py`, output
   `sweep/lx_feasibility.csv` (columns: `alpha,V0,kz,eps,xi_sponge_used,
   half_width_needed,safe_2pi,safe_3pi,safe_4pi,safe_6pi,xi_sponge_min_at_2pi`)
   plus a plot mirroring the existing `plots/` style.

Do this on the iMac (`ssh imac`, `~/ym_kh/venv/bin/python3` — no CUDA needed, all
CPU/sparse eigensolver work) or locally; it needs no GPU node.

---

## Phase 1 — GPU convergence validation of Lx reduction

Goal: confirm empirically (not just analytically) that shrinking Lx at fixed `DX`
doesn't change the measured growth rate, and that it does deliver real wall-clock
savings — mirroring the exact methodology of `analysis/resolution_convergence.py`
(same anchor point, same `RUN_AXIS`-style bookkeeping, same γ-vs-`GAMMA_EXACT`
comparison) so results append cleanly to `RESOLUTION_FINDINGS.md`.

**1a. New "box" axis at the existing reference anchor** (`alpha=1.0, V0=0.05,
kz=1, EPS=0.15, xi_sponge=10, target_tu=25` — identical to the original study's
fixed baseline, so `GAMMA_EXACT=0.080` and the existing `res_baseline` run remain
valid comparators). Hold `DX=0.02454` fixed (the already-converged value) and vary
`Lx` alone, scaling `NX` to match:

| run_tag | Lx | NX (=Lx/0.02454, rounded) |
|---|---|---|
| `lx_2pi` | 2π | 256 |
| `lx_3pi` | 3π | 384 |
| `lx_4pi` | 4π | 512 |
| `res_baseline` (existing) | 6π | 768 |

`.ini` additions vs the existing baseline: `lx_override=<Lx>`, `nx_override=<NX>`,
`eps_override=0.15` (must be set explicitly — otherwise `EPS` would silently
rescale to `Lx/6` and change the physics, per `main_ym.cu:61`), `xi_sponge=10`
(unchanged — already shown safe: `10*0.15=1.5` phys ≪ `π=3.14` phys half-width
of even the 2π box). This isolates *only* the box-shrink effect. Expect flat γ
(cross-check against the existing `T2.7` sponge-extrapolation table, which shows γ
saturates by `ξ_sponge≈16` at this same anchor point — 2π's 20.9 ξ half-width
comfortably covers that).

**1b. Stress-test the predicted failure corner.** Take the lowest-kz/lowest-α·V0
point flagged `safe_2pi=False` in Phase 0's `lx_feasibility.csv` (expect something
like the tachyonic-campaign's `alpha≈0.5, kz≈0.5` region). Run it twice, identical
otherwise: once at `Lx=6π` (its existing/known-safe `xi_sponge`) and once at
`Lx=2π` (same `xi_sponge` — deliberately *not* re-derived, to see the box-too-small
failure mode directly, e.g. `E/E0` blowup or contaminated γ from the sponge no
longer having room to act before the periodic wrap). This validates the Phase 0
analytic screen against real CUDA output, the same way `find_safe_sponge.py` itself
was validated.

**1c. Deliver the actual "free 3x" answer.** Run a production-realistic point
(reuse `alpha=1.0, V0=0.05, kz=1` or the T2.8 LOW corner `alpha=1,V0=0.03,kz=3`) at
production settings (`NZ=64, courant=0.1`) twice: `Lx=6π,NX=768` (current default)
vs `Lx=2π,NX=256` (same `DX`, same `EPS`, same `xi_sponge`), at a realistic
`target_tu` (100+, not the short 25 TU convergence-check window). Report both the
γ agreement (%) **and** measured wall-clock time for each — don't assume the 3x is
exactly realized (the x-sweep FCT cost is only part of the total kernel cost per
step; measure it, don't extrapolate it).

Use 3 GPU nodes round-robin (pattern in `analysis/gen_multigpu_campaign.py`) —
before launching, re-verify node availability (`who`/`ps -u` on t126/t133/t140,
last confirmed idle 2026-07-19 — re-check, don't trust the stale note) and disk
space (`df`). Never run more than one job per GPU. Background with
`ssh -f <node> "cd <wdir> && nohup bash scripts/<script>.sh > logs/<x>.log 2>&1 &"`.

---

## Phase 2 — Encode the result as a reusable Lx policy

Add to `analysis/gen_multigpu_campaign.py` (next to the existing
`xi_sponge_for()`), or a new small shared module `analysis/lx_policy.py` imported
by campaign generators:

```python
LX_TIERS = [2*math.pi, 3*math.pi, 4*math.pi, 6*math.pi]   # cheapest first
MARGIN_XI = 3.0   # extra xi-units of headroom beyond the sponge itself

def lx_for_point(alpha, V0, kz, EPS, xi_sponge=None):
    """Cheapest Lx tier whose half-width (xi-units) clears xi_sponge + margin.
    Preserves the existing EPS>=0.30 box-doubling convention."""
    if xi_sponge is None:
        xi_sponge = xi_sponge_for(alpha, V0, kz)  # existing blind formula
    needed = xi_sponge + MARGIN_XI
    base_lx = next((lx for lx in LX_TIERS if (lx/2.0)/EPS >= needed), LX_TIERS[-1])
    return base_lx * 2.0 if EPS >= 0.30 else base_lx
```

Calibrate `MARGIN_XI` and the tier list against the actual Phase 1 results (if 2π
shows any measurable compression even where Phase 0 predicted "safe", widen the
margin or add a `2.5π` tier rather than trusting the analytic screen blindly).

Wire this into future campaign generators (pair with the existing
`nx_lx_for_eps()`-style NX scaling so `DX` stays fixed at the new `Lx`). **Do not**
touch or "correct" any already-completed campaign's stored results — this is a
forward-looking default for new campaigns only; historical γ values were measured
at whatever box was actually used and remain valid.

---

## Phase 3 — Extreme-parameter resolution studies

Two specific, already-flagged, not-yet-executed gaps — same convergence
methodology as `RESOLUTION_FINDINGS.md` §T2.8, just finished properly.

**3a. Close out the T2.8 high-α·V0 corner definitively.** `REFEREE_PROOFING_RESULTS.md`
found `alpha=3, V0=0.10, kz=5` under-resolved by ~3-6% when NZ, courant, and NX were
each refined **one axis at a time** (never combined), and explicitly says "for a
definitive high-αV₀ measurement, run at NX=1152 and/or courant≤0.05" — that run was
never done. Do it: rerun this exact point with **NX=1152 AND courant=0.05
simultaneously**, compare the combined γ shift against production baseline
(`γ_base=0.2395`) and against the naive additive estimate (~+8.6%, if the two
single-axis effects were independent). Also spot-check 1-2 more high-α·V0 points
(pull candidates from `sweep/all_points_vs_chased.npz` filtering on high
`rel_err_chased` near this corner) to see if the gap grows further out.

**3b. Test whether the α≥6 early-catastrophe onset (EPS-scan v2, `FINDINGS.md`) is
resolution-independent.** This was judged physical (matches the documented
tachyonic outer-branch catastrophe) based on onset-time not moving with amplitude
or `xi_cut` tightening — but it was never checked against grid resolution or
timestep. Pick 2-3 of the dropped `alpha≥6` points from `sweep/epsscan_v2_manifest.csv`,
rerun each at (i) `NX=1152, courant=0.02` (finer grid) and (ii) the production grid,
same as baseline. If onset time and E/E0 trajectory don't move, that closes the
"not resolution-tested" caveat noted in `FINDINGS.md`; if they do move measurably,
this is a real finding that changes the interpretation of the whole EPS-scan v2
`alpha≥6` drop — flag it clearly either way, don't just silently confirm the prior.

**3c. (Time-permitting) broaden the T2.8-style spot-check grid.** Currently only 2
points (LOW: `alpha=1,V0=0.03,kz=3`; HIGH: `alpha=3,V0=0.10,kz=5`) have ever been
resolution-spot-checked. Add 1 point each for: narrow EPS (~0.10-0.12, post the
`log_cosh_stable` overflow fix — resolution behavior there was never re-checked
after the fix), wide EPS (~0.30-0.35, the box-doubling corner), and a kz near the
DFT filter band edge (`kz_suppress_hi`) at whatever tier is in use. Same one-axis
(NZ, courant, NX) spot-check as T2.8.

---

## Phase 4 — Document and record

- Append a new "Lx / box-size convergence" section to `RESOLUTION_FINDINGS.md`
  using the same table format as the existing sections (reuse
  `resolution_convergence.py`'s plotting/table code, extended with the new `box`
  `RUN_AXIS` entries).
- Update `REFEREE_PROOFING_RESULTS.md` §T2.8 with the definitive combined-grid
  number from Phase 3a (replacing "not measured directly").
- If Phase 1/2 land on a new default policy, update the `Lx=6π` mentions in
  `CLAUDE.md` and `YM_Config.cuh` comments to point at `lx_for_point()` instead of
  a flat constant, and note the α≥6 resolution-independence verdict (3b) in
  `FINDINGS.md` next to the existing EPS-scan v2 entry.
- Record a project-memory entry summarizing: whether Lx=2π is safe for the bulk of
  parameter space (and the exact corner that isn't), the T2.8 close-out number, and
  the 3b verdict — following the same style as prior closed-out campaigns.

---

## Verification

- Phase 0 output (`sweep/lx_feasibility.csv`) is a deliverable in itself — sanity
  check it against the two known facts already established (production reference
  point safe at 2π; tachyonic low-kz/low-α·V0 corner not safe at 2π) before trusting
  it on the rest of the grid.
- Phase 1: growth rates should match `RESOLUTION_FINDINGS.md`'s existing
  convergence bar (within the same ~2-5% band already established for other axes);
  any larger deviation at a Phase-0-predicted-safe point means the analytic screen
  or its margin is wrong and needs revisiting before Phase 2 encodes it.
  `E_ratio_max` should stay at 1.0 (perfect energy conservation) in every run — any
  drift indicates the box is actually too small, not a benign accuracy loss.
  Confirm the reused analysis pipeline works by running `python3
  analysis/resolution_convergence.py --root <dir> --out <new>.json` against the new
  runs before hand-editing any markdown tables.
- Phase 3: cross-check new combined-grid T2.8 number and the α≥6 resolution checks
  against the existing one-axis-at-a-time numbers already in
  `REFEREE_PROOFING_RESULTS.md`/`FINDINGS.md` — they should be consistent in sign
  and rough magnitude, not contradict the prior single-axis findings.
