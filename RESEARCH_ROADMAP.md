# Research Roadmap — SU(2) Yang-Mills Shear-Instability Program

**Created 2026-07-03.** Working document: what remains to finish the simulation
program to publication standard, and the physical systems this work maps onto.
Task IDs (T-x.y) are referenced in the publication plan at the end. Check boxes
off as campaigns/analyses complete; record results in `ymgpu2d/FINDINGS.md` as usual.

**Novelty survey done 2026-07-18 → `LITERATURE.md`** (repo root): no prior
KH/shear-driven non-Abelian plasma instability work found across ~11 targeted
searches; closest prior art is Manuel–Mrówczyński chromohydrodynamics (model
equations + two-stream, no shear), the Nielsen–Olesen family (our outer
tachyonic branch — cite it), and the Abelian EMHD-KH lineage (Das & Kaw). See
LITERATURE.md §3 for the citation to-do list and the INSPIRE trail audit that
must happen before submission.

**Status snapshot (updated 2026-07-21 — the "~12 points" below is historical,
from before the intkz/recorrection campaigns; superseded)**: the trimmed
integer-kz grid (kz 1-9, α 0.3-6.0 at 18 values, V0∈{0.03,0.04,0.05,0.07,0.08,
0.10,0.20}) is now **1087/1134 (95.9%) measured**, `sweep/recorr_results.csv`
(1930 rows total incl. half/fine-tier and legacy points), median rel_err vs the
sigma-chased eigensolver 9-12% by tier. The remaining 47 points cluster
entirely at V0=0.2/α≥3.5 — a newly-characterized failure corner, not a random
gap (FINDINGS.md "3-phase unattended campaign"). The EPS scan (T1.1, below) is
separately resolved across α=0.2-6.0. The tachyonic outer branch (§ below /
PRESENTATION.md §8.3) has 46 rate-validated points across α=0.3-2.0. Original
~12-point snapshot text kept for context: Linear dispersion γ(kz; α, V0)
measured for ~12 (α,V0) points,
kz = 0.25–9, with three-level validation (WKB ← exact 1D eigensolver ← 2D GPU sim,
sim/exact = 0.94–0.99). Two novel results in hand: non-monotonic dispersion with
kz_peak ≈ 2α (V0=0.05 series), and a sharp two-branch structure below kz=1
(γ=0.32 at kz_phys=0.5 → 0.06 at 0.75, α=2, V0=0.05). kz=0 chromo-Weibel mode
validated to 0.5% at α=2, V0=0.1 only (Campaign 3, 2026-06-29). A 72-point
extension across α∈[0.5,6]×V0∈[0.01,0.2] (`gen_kz0_campaign.py`, run_mode=3/
NAB_DTANH, Campaign 3's own method) is **CLOSED OUT 2026-07-19 with mixed
results**: reproduces the α=2/V0=0.1 anchor to 0.02% (better than the
original 0.5%), but the other 71 points are **not reliable quantitative
measurements** — growth from machine noise is not a clean single
exponential (a convergence test found the true eigenvalue only emerges in
the final ~10 TU before each run's own nonlinear halt, after a long ~300+ TU
noisy pre-asymptotic transient that a global best-fit window locks onto
instead), and no automatic window-selection fix was found (tried 5
settings, all either too early or too late — a knife-edge transition, not a
tunable parameter). Treat the grid as qualitative/ordering information only;
a real quantitative sweep needs per-point manual inspection or an envelope-
based extraction, neither attempted. **Follow-up 2026-07-19 (kz0v3, 243 pts
total)**: mapped the resulting bias precisely rather than fixing it — dense
(α,V0) grid + alpha-resolution refinement in the region where it shrinks.
Median |rel_err| valley (21%) at α≈2.6-2.8, signed bias crosses zero at
α≈3.4-3.6 (well-sampled region, α≤4.4); still the same known-biased
extraction, now with a much sharper picture of where it's least wrong. See
FINDINGS.md 2026-07-19 "kz0v3: dense (alpha, V0) deviation map" +
`plots/kz0v3_relerr_map.png`. **Follow-up 2026-07-19 (kz0v4, 144 more pts)
— CAMPAIGN CLOSED OUT**: checked two things spotted in the kz0v3 heatmap.
(1) An isolated near-zero-error pixel at (α=0.8, V0=0.04) turned out to be
the fit's knife-edge sensitivity, not a real feature — densifying around it
showed immediate V0 neighbors 0.005 apart swinging from +7% to −70%, no
smooth structure, and even an independent rerun of the identical point
didn't reproduce bit-for-bit (~3% γ_fit drift, no RNG in the source —
GPU float-reduction-order sensitivity amplified over 100+ TU of noise
growth). (2) The valley's zero-bias crossing V0(α), refined to 0.1-α step,
fits a strikingly clean power law V0_cross = 0.175·α^−0.80 (median residual
0.24% over α=1.6-8.0) — real and reproducible, but almost certainly
characterizes the fit bias's own structure (how transient-undershoot and
nonlinear-overshoot trade off) rather than new kz=0 chromo-Weibel physics.
See FINDINGS.md 2026-07-19 "kz0v4: corner-anomaly check + valley power-law
characterization" + `plots/kz0v4_valley_detail.png`. **No further kz0
extension work planned** — the extraction method's bias is now characterized
as thoroughly as it's going to be without a fundamentally different
(per-point manual or envelope-based) technique; see FINDINGS.md 2026-07-19 "kz=0
extension campaign CLOSED OUT" for the full story (also documents an
earlier, now-superseded contamination from a `suppress_kz0=0` run exposing
the periodic-wrap-collapse/secular-By1-pump obstructions from
OUTER_REGION.md, fixed en route to the NAB_DTANH switch). All campaigns so
far at fixed EPS=0.15 except the T1.1 EPS-scan (120 pts, α∈{1.0,1.5,2.0},
DONE — see FINDINGS.md "EPS-scan (120 pts) and warm-closure (32 pts) GPU
results").

---

# PART I — Completing the simulation program

Ordered by leverage. Tier 1 items create the headline claims; Tier 2 items are
referee-proofing (cheap, do opportunistically); Tier 3 are follow-on projects.

## Tier 1 — Headline experiments and theory

### T1.1 EPS scan — is wavelength selection set by α or by the shear width? ⭐ HIGHEST PRIORITY — ✅ RESOLVED 2026-07-19, EXTENDED 2026-07-21
- [x] Generate 6-field eigenmode seeds for EPS ∈ {0.10, 0.15, 0.225, 0.30, 0.45}
      at (α=2.0, V0=0.05) and (α=1.0, V0=0.05), kz=1..8 (`ym_eigenmode.py` already
      takes EPS as a parameter — verify seed filenames disambiguate EPS). **Done
      2026-07-18**: `analysis/gen_epsscan_campaign.py` generates all 80 seeds
      (EPS-tagged filenames — the old naming had no EPS marker at all and would
      have silently collided; fixed in `ym_eigenmode.py`) plus a per-point
      eigensolver safe-sponge hunt that also classifies the real (intended,
      localised) vs outer (tachyonic) branch at each point — see
      `sweep/epsscan_manifest.csv` and the T1.1 tachyonic-branch note below.
- [x] Run the corresponding Mode-6 campaigns (fast grid; each kz ≈ 90 s, whole
      scan < 2 h of GPU time). Watch DX resolution rule: need EPS/DX ≳ 6, so
      EPS=0.10 requires NX ≥ 1024 (use `nx_override`). **LAUNCHED 2026-07-19
      ~02:47 IST**, expanded to 120 pts (α∈{1.0,1.5,2.0}), running on
      t126+t140 now (~2.5h wall each) — see FINDINGS.md "Comprehensive
      post-intkz campaign LAUNCHED" for the heredoc-quoting bug this almost
      shipped with (every run would have crashed instantly at seed-load).
      Two correctness fixes were required before that, both applied:
      (1) EPS=0.10 uses `nx_override=1152` (not 1024 — 1024 only gives
      EPS/DX=5.4, just under the ≳6 rule; 1152 clears it at 6.0), and (2) the
      output-directory naming (`main_ym.cu`) now tags `_nx<N>` when
      `nx_override` is set, and `remote_timeseries.py` now reads NX from that
      tag instead of a hardcoded 768 — untagged, every `nx_override` run's
      field dumps would have been silently misread (wrong reshape, wrong
      amplitudes, no crash) since `nx_override` had never actually been
      exercised by a prior campaign. A third issue found and fixed the same
      day: at the default `Lx=6π` box, the periodic domain's own ξ-half-width
      (`3π/EPS`) shrinks faster than the vetted `xi_sponge` does as EPS grows,
      and by EPS=0.45 the vetted sponge (ξ=21 at the old, buggy fallback) sat
      AT the domain edge (ξ=20.94) — it never activated, so the "clean, no
      outer branch" verdict there was a false negative, not a real check.
      Fixed by doubling the box for EPS≥0.30 (`lx_override=12π`,
      `nx_override=1536` to hold dx fixed at the same value as every other
      leg — a pure box-size fix, not a resolution change); re-hunting then
      found real, much tighter sponges there (e.g. α=2,EPS=0.45,kz=1:
      ξ_sponge 21→5, now genuinely vetted). `ym_eigenmode.py`'s seed-export
      filename also gained an `_lx<N>` tag for the same collision reason as
      the EPS tag above.
- [x] Extract kz_peak(EPS) at fixed α, and kz_peak(α) at 2–3 EPS values.
      **GPU-CONFIRMED 2026-07-19** (120 runs, t126+t140, all clean fits
      R²≥0.997): kz_peak(EPS) from real sim data — α=1.0: 4→2→2→2→2,
      α=1.5: 5→4→2→3→3, α=2.0: 5→4→3→4→3 (EPS 0.10→0.15→0.225→0.30→0.45).
      **The drift is real, not just an eigensolver artifact** — this is
      evidence *against* the "gauge-coupling-selected, EPS-free" headline
      claim, not for it. At the historical baseline EPS=0.15, kz_peak≈2α
      roughly holds (why the original series never saw this); away from
      0.15 it moves by 1-3 integer steps. Sim/exact vs the eigensolver:
      median 0.855, IQR [0.70,0.99] (healthy, in the historical range). See
      FINDINGS.md 2026-07-19 "EPS-scan (120 pts) and warm-closure (32 pts)
      GPU results" for the full per-(α,EPS) table.

**Final answer to the decision point below (2026-07-19/21)**: kz_peak **drifts**
with EPS — the "stays ≈2α, EPS-free" alternative is ruled out. But the drift is
not raw noise or a simple 1/EPS law either: both kz_peak and γ_peak collapse
cleanly onto single-valued functions of the one dimensionless group
P=(αV0²)^(1/3)/EPS (theory: `analysis/eps_collapse_theory.py`; GPU-validated
across α=0.2-6.0, EPS=0.10-0.45, 91+75 runs — FINDINGS.md "EPS-scan v2" and
"3-phase unattended campaign"). So the correct title-level claim is P-selected
wavelength, not α-selected — a sharper, still-novel result, just not the exact
form originally hypothesized. Accuracy: 9.9% median at α≥0.5, ~22% median as α
drops toward 0.2 (approaching, not yet at, the α≤0.15 unmeasurable floor). This
is the T1.2 theory follow-up that the 2026-07-19 GPU-confirmed result (above)
flagged as needed.

**Tachyonic-branch note (added 2026-07-18, `analysis/eps_tachyon_scan.py`)**:
the scan doubles as a check of how EPS affects the outer Nielsen–Olesen
tachyonic branch (OUTER_REGION.md), not just the intended shear mode. Both
`ξ_crit = kz/(αV0) + ln2` (tachyonic onset) and `ξ_char = 1/√(αkz V0)` (KH
mode width) are exactly EPS-independent — EPS only sets the overall physical
(x) scale that both branches share, so their *ratio*, and therefore whether
the sponge can separate them, does not change with EPS in principle. What
*does* change with EPS is the grid's ability to resolve that shared ξ-scale
(dξ = DX/EPS grows as EPS shrinks) — i.e. the EPS/DX≳6 rule protects the
tachyonic-branch/sponge separation exactly as much as it protects the KH
mode's own shape, not just the latter. See the manifest's `sponge_safe`,
`gamma_eig_outer`, and `xi_crit` columns for the per-point check across all
80 (α,EPS,kz) combinations before any GPU time is spent.

**Decision point**: In classical (Abelian) KH, kz_peak·EPS ≈ 0.4–0.6 — the shear
width sets the wavelength. If kz_peak stays ≈ 2α as EPS varies, the claim
*"in a non-Abelian plasma the fastest-growing wavelength is selected by the gauge
coupling, not the flow profile"* is confirmed and becomes the title-level result of
the Letter (Paper A). If kz_peak drifts with 1/EPS, the correct dimensionless
combination must be identified before any paper is written. Either way this scan
is mandatory and cheap. **Do this first.**

**Status 2026-07-18 (superseded — see the resolved answer above) — QUEUED NEXT after the recorrection campaign.** An epsscan
campaign was run (~07-13→07-16) but every timeseries was extracted with the
conjugate-helicity bug (FINDINGS.md 2026-07-17) and the field dumps were
auto-deleted — all invalid, must be rerun. Prerequisite now in main: the
float32 `cosh()` overflow fix (`log_cosh_stable`, commit b8e65ba) — without it
every EPS < ~0.105 run NaN'd at step 1, which silently poisoned the narrow-EPS
leg of the first attempt. The exact-action theory (T1.2, PHYSICS.md §11)
sharpens the prediction to test: both terms of k_z,peak ≈ αV0·ξ_w + (α/V0)^{1/3}
are EPS-free, so the scan now *tests the theory* rather than exploring blind.
Note the recorrection campaign hardcodes eps=0.15 — this scan needs its own
(small, <1 GPU-day) campaign with the fixed extractor + NZ/4.5 filter rule.

### T1.2 Analytic theory upgrade — exact-action WKB
The current WKB (eq. 33, wkb.pdf) overestimates γ by 2–6× because it approximates
the log-cosh potential by a parabolic well and assumes the step-velocity equilibrium.
- [ ] Replace the parabolic quantization with the two-turning-point action integral
      over the *actual* potential: ∮ Q(ξ; γ, kz, α, V0) dξ = (n+½)π with Q from the
      exact aᶻ equation (eq. 28 form), evaluated by numerical quadrature.
      Infrastructure: extend `anroot.py` / `ym_eigenmode.py`.
- [ ] Check it reproduces the eigensolver γ to ≲20% across the C25–C39 grid
      (vs the current 2–6× miss).
- [ ] Derive the kz_peak(α, V0) scaling from the stationarity of the action —
      i.e. *explain* kz_peak ≈ 2α (or whatever T1.1 finds). Even an asymptotic
      argument (balance of the α²V0·kz destabilizing term against kz² stabilization
      and finite-well-depth effects) closes the loop: theory + exact solver + sim
      agreeing on the non-monotonicity makes the story self-contained.

### T1.3 Sub-kz=1 branch — identify the mode-crossing
The sharp drop (γ = 0.320 at kz_phys=0.5 → 0.060 at 0.75, α=2, V0=0.05) looks like
a branch crossing between two distinct eigenmode families.
- [ ] Run `ym_eigenmode.py` as a *continuation* in kz_phys with fine steps
      (Δkz_phys = 0.05, Lz=8π grid), tracking the 3–5 leading eigenvalues, not
      just the dominant one. Plot the branches through the crossing.
- [ ] Compare eigenfunctions on both sides: peak position ξ_peak, Az/By ratio,
      parity. Hypothesis to test: inner (shear-layer) branch vs outer
      (Ω_A ≈ 0 resonance) branch, crossing or avoided-crossing near kz_phys ≈ 0.6.
- [ ] Confirm the fine structure in simulation: C50 (running) covers kz_phys =
      0.25–1.5 at Δ=0.25; if the solver predicts structure narrower than that,
      add a Δkz_phys=0.125 fill on Lz=16π (NZ=512) for 3–4 points.
- [ ] Check xi_sponge sensitivity explicitly at each point (known trap — solver
      finds spurious outer modes if xi_sponge exceeds the physical mode region).

### T1.4 Warm-fluid closure — replace numerical filters with physics ⭐ CRITICAL FOR CREDIBILITY
The current measurement isolates a mode that is *subdominant* in the cold system:
fluid two-stream (γ≈0.7–0.9), color-1 EM instability (γ≈1.1), kz=0 Weibel (γ≈0.5)
all grow faster and are removed by numerical filters (bandpass BP=14, cudaMemset of
color-1 EM, kz=0 suppression, hyperdiffusion). A referee's first question will be
"would this mode ever be observed?" The physical answer is temperature: a warm
plasma with v_th ≳ V0 stabilizes the two-stream family.
- [x] Implement a pressure term: isothermal P = n·T with −T∇n added to the
      momentum sources (runtime `warm_T` .ini key; warm_T=0 takes the exact old
      cold code path). Done 2026-07-12, smoke-tested on t130; merged to main
      2026-07-18 from the `worktree-warm-fluid-closure` branch.
- [x] ~~Verify the two-stream threshold in mode 2~~ — attempted 2026-07-12
      (FINDINGS.md "T1.4 Warm-fluid closure" section): at V0=0.05 without
      filters only the kz=0 chromo-Weibel grows (finite-kz seeds decay), and
      isotropic warm_T barely touches that channel (~11% over v_th/V0=0–3,
      physically expected — Weibel is anisotropy-driven, not pressure-limited).
      Also found: suppress_kz0 is structurally incompatible with mode 2 (step
      6e memsets By1/Ex1/Ez1, which in mode 2 are the whole physics). The
      mode-2 threshold scan is therefore not the right validation path — skip
      it and go straight to the filters-off mode-6 test below.
- [x] **QUEUED NEXT after the recorrection campaign** (with T1.1): rerun ONE
      full dispersion series (suggest C35 clone: α=2.0, V0=0.05) with
      v_th ≈ 2–3 V0 and **all filters off** (no BP, no memset, no suppress_kz0 —
      keep hyperdiffusion only if needed for grid-scale noise; state it).
      **LAUNCHED 2026-07-19 ~02:47 IST** (on t133, not t130 — t130 has an
      active human session): `analysis/gen_warmclosure_campaign.py` generates
      an exact C35 clone (α=2.0, V0=0.05, EPS=0.15, xi_sponge=11.0, extended
      to kz=1..8) x 4 warm_T legs — a cold control
      (warm_T=0, filters off, expected to be swamped by the fast channels —
      the point of the comparison) plus v_th/V0 ∈ {2.0, 2.5, 3.0}
      (warm_T=(v_th)², since c_s=√warm_T for this isothermal P=n·T closure).
      suppress_kz0=0 disables *both* the kz=0 z-mean subtraction and the
      color-1 EM memset (they share one flag in `main_ym.cu`); kz_suppress_max
      =kz_suppress_hi=0 disables the bandpass; hyp_diff kept at the standard
      5e-5 (stated per the roadmap ask — needed for grid-scale noise, <0.6%
      attenuation of kz=1..8). Since warm_T carries no tag of its own in the
      output-directory naming, the 4 legs are disambiguated via `run_tag`
      instead (`warmcl_cold`/`warmcl_wt2p0`/`warmcl_wt2p5`/`warmcl_wt3p0`) —
      24 runs total, ~0.6 GPU-h, `scripts/warmclosure_t130.sh`, launched
      alongside the EPS scan by `scripts/launch_after_recorr.sh`.
- [x] Compare γ(kz) with the filtered cold runs. **GPU results 2026-07-19
      (32 runs, t133, R²≥0.997), then per-channel energy diagnosis on a
      kz=4 rerun (raw snapshots retained, `analysis/diagnose_warmclosure_
      channels.py`) resolved the initial puzzle: warm_T DOES support the
      T1.4 credibility claim — the naive "warm vs cold" comparison was the
      wrong test.** Initial surprise: warm_T *increases* measured γ at every
      kz vs the cold (all-filters-off) control (kz=4: cold 0.122 vs warm
      ~0.150). Diagnosis found why: the kz=0-cascade hypothesis is wrong
      (kz=0 leakage is actually *smaller* in warm); instead, the colour-1 EM
      instability (γ≈1.1, the exact channel `suppress_kz0`'s memset exists
      to kill) grows at γ=1.395 in cold vs γ=0.730 in warm at the SAME
      target kz — warm_T roughly halves it, exactly the stabilization it
      was implemented for. In cold, this channel already *exceeds* the
      intended Az2/Az3 signal by 8× at t=30 (well inside the fit window) —
      **the cold control is the contaminated measurement, not the warm
      legs.** Warm's rate (0.150) sits within 1% of the eigensolver
      prediction (0.152); cold's (0.122) is 20% low. **Correct comparison
      is warm-vs-theory, not warm-vs-cold** — by that measure T1.4 is
      supported. See FINDINGS.md 2026-07-19 "Warm-closure per-channel
      energy diagnosis" for the full trace. Open: this diagnosis only
      covers kz=4 in depth; kz=1's 39%-high and kz=5's split-across-warm_T
      behaviour aren't yet explained the same way.
- [ ] Warm eigensolver cross-check still not done (add the pressure term to
      `ym_eigenmode.py` — **not** a small change: the 6-field eigensolver
      state vector [b,ex,ez,a,qA,qB] has no fluid n/p degrees of freedom at
      all, so this needs a real extension of the state vector, not a
      one-line sound-speed term). More valuable now that warm-vs-theory is
      the right comparison to make — a genuinely warm theory number would
      let every kz be checked the way kz=4 just was.

**Outcome**: if γ(kz) survives within ~10–20%, the filtered cold-plasma campaign
results are validated as the T→0 limit and the whole objection dissolves. This is
the single most valuable physics upgrade in the program.

### T1.5 Energetics — what actually drives the mode?
The eigenmode often peaks away from the shear layer ("outer EM instability"), so
"Kelvin-Helmholtz" may be the wrong name in parts of parameter space. Settle it:
- [ ] Add a per-snapshot energy-transfer diagnostic (post-processing on the 25-col
      CSV is enough): shear drive = Reynolds-stress term ⟨δp_z δv_x⟩·∂ₓV0z
      integrated over x, vs precession/coupling drive (α-proportional transfer
      terms from the Q·v·(Q×Az) and (Az×E) channels), vs Poynting redistribution.
- [ ] Produce a "drive fraction vs kz" figure for one campaign on each side of the
      dispersion peak, and one for the sub-kz=1 branch.
- [ ] Name the instability accordingly in the papers (e.g. "shear-driven
      non-Abelian mode" vs "colored KH") — this figure is the defense.

### T1.6 Self-consistent equilibrium + nonlinear saturation (Paper C core)
All current runs end at NaN/energy-threshold; the background Az1 is frozen and is
NOT the self-consistent equilibrium of the khaxn derivation (code uses the single
integral −V0·log cosh; theory wants Az1 = ∫∫V0z dx², which is unbounded and caused
the Campaign-1/2 outer blowup). Fix by changing geometry, not by freezing:
- [ ] **Non-Abelian Kolmogorov flow**: vz_A = +V0·cos(k_x x), vz_B = −V0·cos(k_x x),
      Q1 = ±1, n=1, with Az1 = −(2V0/k_x²)·cos(k_x x). Then −∂ₓ²Az1 = Jz1 exactly —
      fully periodic, bounded, self-consistent, no sponge, no frozen fields.
      Residual O(V0²) x-force imbalance (vz·By1 Lorentz term) must be balanced by a
      small equilibrium Ex1 or pressure gradient — derive and initialize it.
      Note |vz|=V0 away from nodes → needs the warm closure (T1.4) first.
- [ ] Implement as run_mode=7; validate the equilibrium holds statically (E/E0
      flat to <1% for 100 TU with no perturbation, no filters, warm closure on).
- [ ] Linear check: eigensolver for the Kolmogorov background; compare with
      mode-6-style seeded runs. (Classical Abelian analog is the
      Meshalkin–Sinai problem — the non-Abelian generalization is itself new.)
- [ ] Nonlinear campaign with Az1 *evolving*: run through saturation. Measure
      (a) saturation amplitude vs γ (trapping estimate: δv ~ γ/kz?),
      (b) color-field vortex/roll formation (2D snapshots of By2, Q2),
      (c) momentum transport across the layer → effective drag rate between beams
      (this number feeds the dark-matter application, System 1),
      (d) energy partition color-1 vs color-2/3 vs fluid KE,
      (e) kz spectra in the saturated state.
- [ ] Numerics for the nonlinear phase: adaptive DT (halve on CFL violation),
      NaN guard with checkpoint-restart, possibly courant=0.05.

## Tier 2 — Referee-proofing (each ≤ 1 day; do alongside Tier 1)

- [ ] **T2.1 Complex frequency**: extract Re(ω) from the phase rotation of the
      circ amplitude ⟨e^{−i kz z} Az₂₊ᵢ₃(x,z)⟩ between snapshots (machinery exists
      in `dispersion_ym.py`); compare with eigensolver Im parts (C19b/C20b/C21b
      showed nonzero Im(γ) cases). Report full complex ω(kz), not just growth.
- [ ] **T2.2 Eigenfunction overlay figure**: sim |By2|(x), |Az2|(x), |Q2A|(x)
      at mid-linear-phase vs solver eigenfunctions, 2–3 kz values. Money figure
      for the validation claim.
- [ ] **T2.3 Gauss law + energy conservation figure**: promote `gauss_check.py`
      output to a paper figure — RMS(G^a)/norm vs t for a production run; state
      the leapfrog scheme does not exactly preserve the non-Abelian constraint
      and show the violation stays ≪ 1.
- [ ] **T2.4 Linearity check**: one campaign point rerun with seed amplitude
      ×10 and ×0.1 — γ unchanged to <1% confirms linear-phase fits.
- [ ] **T2.5 Dimensionless collapse**: replot the full (α,V0) grid as
      γ/(V0/EPS) vs kz·EPS, γ/(αV0) vs kz/α, and γ/γ_peak vs kz/kz_peak.
      Your own data (kz_peak differs between V0=0.05 and V0=0.03 at fixed αV0)
      says α and V0 do NOT enter only through αV0 — quantify which combination
      collapses. Feeds T1.2 and defines the paper's axes.
- [ ] **T2.6 Frozen-background error bound**: rerun one mid-γ case with
      freeze_az1=0 from t=0 and measure (a) Az1 drift rate, (b) γ shift.
      Report both; expect small during linear phase — proving it beats asserting it.
- [ ] **T2.7 Sponge-free extrapolation**: for 2–3 representative (α,V0,kz) run
      xi_sponge ∈ {1, 1.5, 2}×baseline and extrapolate γ(xi_sponge→∞); mark
      sponge-clean vs sponge-limited points in every dispersion table
      (C36–C39 are known to be compressed at high kz).
- [ ] **T2.8 Resolution spot-checks at extremes**: repeat the RESOLUTION_FINDINGS
      convergence test at the two parameter corners actually used in the papers
      (highest αV0 and lowest), not just the kz=1, EPS=0.15 baseline.
- [ ] **T2.9 Housekeeping**: backfill FINDINGS.md with C40–C50 (currently only in
      scripts/session memory — the sub-kz=1 campaigns carry the most publishable
      result); fix the stale "float32" claims in CLAUDE.md/PHYSICS.md (code is
      double precision — a strength, claim it); archive one .ini per campaign in
      a `configs/` directory; tag a release + Zenodo DOI when Paper B is submitted.

## Tier 3 — Follow-on projects (each is weeks–months; pick per paper plan)

- [ ] **T3.1 3D / out-of-plane check**: add y-dependence (or a thin-y 3D slab) for
      ONE parameter point to confirm filamentation-type ky modes don't dominate
      the in-plane physics. Cheapest defensible version: linear eigensolver with
      ky ≠ 0 added (2D solver in x with (ky,kz) parameters) before any 3D code.
- [ ] **T3.2 Wong-particle kinetic validation**: PIC-style particles carrying
      color charge (Wong equations) for one parameter point; validates the cold
      two-fluid closure and directly checks the warm-closure stabilization of T1.4.
- [ ] **T3.3 Relativistic beams**: γ-factors in the fluid + relativistic Wong
      precession. Required for any quantitative QGP claim (System 3).
- [ ] **T3.4 SU(3)**: replace su2_cross helpers with f^abc structure constants,
      8 color components. Mechanical but doubles memory; only needed for QGP.

---

# PART II — The six physical systems

Model summary for the mappings: two **cold**, **non-relativistic** (V0/c ~ 0.03–0.1)
counter-streaming fluids with opposite charge under a **dynamical** SU(2) field,
plus a **frozen** color-1 background potential; units ω_p = c = 1, lengths in skin
depths c/ω_p.

## System 1 — Dark-sector plasma in galaxy-cluster mergers ⭐ PRIORITY (quantitative application)

**Why it fits**: If dark matter carries a dark non-Abelian charge, a cluster merger
IS the code's initial condition: two cold counter-streaming oppositely-charged
colored flows at v ~ 1000–4000 km/s, i.e. v/c ~ 0.003–0.013 — the same regime as the
V0=0.03–0.05 campaigns (one V0=0.01 series would bracket it). Non-relativistic and
cold are *correct* here, not approximations. The Abelian version of this analysis
exists (dark U(1): Ackerman, Buckley, Carroll & Kamionkowski, PRD 79, 023519 (2009);
Heikinheimo, Raidal, Spethmann & Veermäe, PLB 749, 236 (2015); Lasenby 2020) —
the non-Abelian version appears to be open. **Update 2026-07-18 (LITERATURE.md
§1e): the U(1) program advanced to full nonlinear PIC in 2025 — "Dark plasmas
in the nonlinear regime", PRD 111, 095031 / arXiv:2411.11958 — simulating dark
U(1) streams in cluster mergers through saturation to an effective σ/m, and
explicitly flagging non-Abelian dark sectors as future work. That paper is both
the template for Paper D and the urgency signal: the non-Abelian version is
confirmed open, and that group is closest to it.**

**What to do**:
1. Unit mapping note (no simulation needed): dark plasma frequency
   ω_p² = g_D² n/m for DM density ρ ~ 0.1–1 GeV/cm³ in a cluster, m and g_D free.
   Compute γ·t_cross for merger crossing time t_cross ~ 1 Gyr across (g_D, m) space
   using the measured γ(kz_peak; α, V0) tables. Where γ·t_cross ≲ few → instability
   irrelevant → that boundary is already an exclusion-style statement from linear
   data alone.
2. For most viable parameters ω_p·t_cross is enormous → the system is deep in the
   *saturated* regime, and the observable is the saturated momentum-transfer (drag)
   rate between the flows — exactly deliverable (c) of T1.6. **Dependency: the
   nonlinear saturation campaign.** Convert drag → effective σ/m and compare with
   Bullet-Cluster-type bounds (σ/m ≲ 1–2 cm²/g; Randall et al. 2008, Harvey et al.
   2015) → exclusion plot in (g_D/α_dark, m) space.
3. Non-Abelian-specific observable: kz_peak ≈ 2α sets the coherence scale of the
   dark magnetic fields generated in a merger — different from the Weibel-scale
   prediction of the U(1) papers. State it as the distinguishing signature.
4. Also cite/contrast: atomic/mirror dark matter, dark-photon plasma instability
   literature; check for any prior non-Abelian dark plasma instability work
   (literature scan task).

**Code changes needed**: none for step 1; T1.6 for step 2. Possibly a V0=0.01
series (sponge/xi_crit gets large — check solver first).
**Deliverable**: Paper D — "Plasma instabilities of non-Abelian dark matter in
cluster mergers" (PRD/JCAP). Step 1 alone is a strong section of Paper B.

## System 2 — Spin-orbit-coupled electron fluids (spin hydrodynamics) ⭐ PRIORITY (theory follow-up)

**Why it fits**: The Pauli equation with Rashba/Dresselhaus SOC is *exactly* a
U(1)×SU(2) gauge theory in which the SU(2) vector potential is a fixed background
set by the material (Tokatly, PRL 101, 106601 (2008)). Mapping: color ↔ spin;
color charge Q^a ↔ spin polarization s^a; the Q-precession term ↔ Dyakonov–Perel
spin precession about the SOC field; **frozen Az1 ↔ the material SOC constant —
i.e. the frozen-background "approximation" a plasma referee attacks is the exact
physical statement here.** Hydrodynamic electron flow is experimentally established
(graphene, GaAs 2DEGs: Bandurin et al., Levitov–Falkovich program), so shear layers
in electron fluids exist in the lab; counter-streaming spin-polarized currents
(pure spin current: up-spins +z, down-spins −z) reproduce the two-beam setup.

**What to do**:
1. **The mapping memo first** (theory, ~1–2 weeks, no code): write the
   correspondence Lagrangian and identify what plays the role of the *dynamical*
   color-2/3 fields — in a solid, the SU(2) field strength is non-dynamical, so the
   feedback loop (By2→Ez2→Az2→Q3→Q2) must be carried by carrier-induced effective
   fields (electron–electron exchange / Stoner mean field, or the induced spin
   density acting back through SOC). This is the make-or-break question — resolve
   it before investing in simulations. If exchange supplies the dynamical partner,
   the instability survives with renormalized coupling; if nothing does, the analog
   is a damped precession problem, and we say so.
2. Add to the model what the material imposes: degenerate Fermi pressure (= the
   T1.4 warm closure), momentum relaxation −p/τ (impurities set the hydrodynamic
   window), real U(1) Coulomb.
3. Translate the headline prediction: instability wavelength set by the spin-orbit
   precession length L_so = 1/(2m·α_R) (gate-tunable!), not by the shear-layer
   width. Estimate observability: spin texture with λ ~ L_so/2 imaged by Kerr
   microscopy or NV magnetometry in a graphene/WSe₂ or GaAs channel carrying
   counter-propagating spin currents.
4. Target collaboration/experiment section: graphene with proximity SOC,
   GaAs 2DEGs in the Gurzhi regime, PdCoO₂/WP₂ ultraclean metals.

**Code changes needed**: T1.4 (pressure) + a momentum-relaxation term (−p/τ source,
trivial); rest is theory.
**Deliverable**: Paper E — "Spin-Kelvin-Helmholtz instability in hydrodynamic
electron fluids with spin-orbit coupling" (PRB, PRL if the exchange loop closes).

## System 3 — Quark-gluon plasma / glasma (highest prestige, motivation anchor)

**Why it fits**: The post-collision initial state is two receding sheets of
counter-streaming color charge; the chromo-Weibel instability of that configuration
is the canonical isotropization mechanism (Mrówczyński; Arnold–Lenaghan–Moore;
Rebhan–Strickland; Romatschke–Venugopalan) — the code's kz=0 mode (WKB-validated to
0.5%) is in this family. The new ingredient is shear: peripheral collisions carry
huge angular momentum, and vorticity ~10²¹ s⁻¹ is *measured* (STAR Λ-polarization,
Nature 548, 62 (2017)). Prior art on hydrodynamic (Abelian) KH in heavy ions:
Csernai et al., PRC 84, 024914 (2011). Position the work as **"the shear-flow
counterpart of the chromo-Weibel instability"** — this names the referee pool.

**What to do**:
1. Now (Paper A/B motivation): honest timescale estimate — γ ~ 0.1 ω_p with
   ω_p ~ Q_s ~ 1–2 GeV → growth time a few fm/c vs QGP lifetime ~10 fm/c: marginal
   but not dismissible; one paragraph with numbers.
2. Literature framing: chromo-Weibel reviews, glasma instabilities, Csernai KH,
   STAR vorticity; make the kz=0 validation the bridge.
3. Later (own project): T3.3 relativistic fluid + T3.4 SU(3) + Bjorken-expanding
   background; question: does the coupling-selected kz_peak survive longitudinal
   expansion, and does the shear channel compete with chromo-Weibel at realistic
   anisotropy? That is a multi-month project and a full paper.

**Code changes needed**: none for motivation; T3.3+T3.4 for the real thing.
**Deliverable**: motivation sections now; "Chromo-KH in expanding glasma" as a
future flagship paper.

## System 4 — Two-component BECs with synthetic gauge fields (tabletop test)

**Why it fits**: The cold two-fluid equations are the Madelung form of a
two-component Gross–Pitaevskii system, valid at scales ≫ healing length (quantum
pressure is the only missing term). Synthetic SU(2)/spin-orbit gauge potentials are
engineered with Raman coupling (Lin, Jiménez-García & Spielman, Nature 471, 83
(2011); review: Dalibard, Gerbier, Juzeliūnas & Öhberg, RMP 83, 1523 (2011)); KH in
two-component/counterflowing condensates is established theory with experimental
cousins (Takeuchi, Suzuki, Kasamatsu, Saito & Tsubota, PRA 81, 063623 (2010);
³He A–B interface KH: Blaauwgeers et al., PRL 89, 155301 (2002)).

**What to do**:
1. Dimensionless mapping memo: code units → GP units (healing length, spin-Raman
   coupling Ω ↔ α, counterflow velocity ↔ V0); check the mode wavelengths from the
   dispersion tables sit at ≫ ξ_healing for realistic ⁸⁷Rb parameters — if not,
   quantum pressure matters and the mapping weakens (say so).
2. Predict the imaging observable: spin/density stripe pattern at the
   coupling-selected wavelength, tunable via Raman power at *fixed* flow profile —
   the clean experimental discriminator of the T1.1 claim.
3. One paragraph in Paper A ("realizable in cold-atom synthetic gauge fields")
   + a proposal-grade note to a cold-atom group if the numbers work.

**Code changes needed**: none (optionally: add a quantum-pressure term to the
eigensolver to check its effect on γ — a Bohm term in the 1D linear operator).
**Deliverable**: section in Paper A/B; possible experimental collaboration.

## System 5 — Early-universe: electroweak plasma and axion–SU(2) cosmology

**Why it fits (a — EW phase transitions)**: The hot symmetric-phase plasma is a
genuine SU(2)(×U(1)) plasma. First-order phase transitions in BSM scenarios drive
bulk flows at bubble walls; shear → instability → turbulence → gravitational-wave
spectra is the active LISA pipeline (Caprini et al., LISA CosWG reports). A
non-Abelian shear instability is an extra channel converting flow energy into gauge
fields — relevant to the GW source term and to primordial (hyper)magnetogenesis.
Honest caveat: quantitative work needs thermal-field-theory input (HTL masses,
damping) — the cold-plasma rates are indicative only.

**Why it fits (b — axion–SU(2) inflation)**: Chromo-natural-type models (Adshead &
Wyman, PRL 108, 261302 (2012); spectator axion-SU(2): Dimastrogiovanni, Fasiello &
Fujita, JCAP 01 (2017) 019) feature homogeneous SU(2) vevs — the closest
cosmological analog of the frozen Az1 background; perturbation stability of these
backgrounds is a live question, and `khaxn.pdf` already points this direction.
Shear enters naturally at (p)reheating with gradient flows rather than during
inflation itself.

**What to do**:
1. Motivation paragraphs in Papers A/B with the two anchors above; no new runs.
2. Optional small study: dimensionless comparison of γ(kz) with the perturbation
   growth rates quoted in the axion-SU(2) literature; identify whether the
   sub-kz=1 branch has a counterpart at horizon-scale kz.
3. Defer any thermal upgrade (HTL) — different machinery; flag as future work.

**Code changes needed**: none now.
**Deliverable**: motivation + discussion sections; possible later letter if (2)
turns up a clean correspondence.

## System 6 — Neutron-star mergers with deconfined quark matter (garnish only)

**Why it (marginally) fits**: KH at the merger contact interface is *the* magnetic
field amplification mechanism in MHD merger simulations (Price & Rosswog, Science
312, 719 (2006); Kiuchi et al., PRD 92, 124034 (2015) resolution studies). If
merger cores reach deconfinement, a color analog at the quark-matter contact layer
exists in principle. But it stacks speculation (deconfinement + color transport +
relativistic + dense-matter EoS) on speculation.

**What to do**: one closing-discussion sentence in Paper B/C ("analogous color-field
amplification could operate at quark-matter interfaces in NS mergers"), citing
Price–Rosswog and Kiuchi. Nothing else. Lowest priority; do not let it into an
abstract.

---

# PART III — Publication plan (tasks → papers)

| Paper | Content | Venue target | Blocking tasks |
|-------|---------|--------------|----------------|
| **A (Letter)** | Coupling-selected wavelength (kz_peak vs α, EPS-independence) + sub-kz=1 two-branch structure + analytic scaling; BEC realizability paragraph; QGP/dark-sector motivation | PRL / PRD Letter | T1.1, T1.2, T1.3 (+T2.5) |
| **B (full linear)** | Model + exact eigensolver + 6-field seeding method + full γ(kz;α,V0) maps + WKB comparison + validation stack; dark-sector unit-mapping section (System 1 step 1); Gauss/energy/convergence appendices | Phys. Plasmas / JPP / PRE | T1.4, T1.5, T2.1–T2.9 |
| **C (nonlinear)** | Non-Abelian Kolmogorov flow, saturation amplitudes, color vortices, momentum transport, spectra | PRE / JPP / PoP | T1.4 → T1.6 |
| **D (dark matter)** | Drag → σ/m exclusion plot in (α_dark, m) | PRD / JCAP | T1.6(c) + System 1 |
| **E (spin-KH)** | SOC mapping, exchange-mediated loop, lab prediction λ ~ L_so | PRB (PRL if loop closes) | System 2 step 1 (+T1.4) |
| **Future flagship** | Relativistic SU(3) chromo-KH in expanding glasma | PRL/PRD | T3.3, T3.4 |

**Suggested order of operations (next ~2–3 weeks)**:
1. T1.1 EPS scan (days; decides the Letter).
2. T2.9 housekeeping + T2.4/T2.2 while campaigns run.
3. T1.3 branch continuation (solver-only, parallel to runs).
4. T1.2 exact-action WKB.
5. T1.4 warm closure (opens C, D, E).
6. System 1 step 1 unit-mapping note + System 2 step 1 mapping memo (theory
   evenings; no GPU needed).
