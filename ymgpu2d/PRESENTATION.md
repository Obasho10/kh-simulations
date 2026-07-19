# The SU(2) Yang–Mills Kelvin–Helmholtz Program — State of the Work

**Date: 2026-07-12, last updated 2026-07-19.** This document presents the `ymgpu2d/` simulation program to a
physicist audience at any level: what was built, what has been measured, what the
headline results are, where the evidence is solid, where it is shaky, and what has
to happen next. All figures referenced here live in `presentation/plots/` and the
new ones can be regenerated with `python3 presentation/make_plots.py`. The
campaign-by-campaign log is `FINDINGS.md`; derivations are in `PHYSICS.md`; the
numerics study is `RESOLUTION_FINDINGS.md`; the forward plan is
`../RESEARCH_ROADMAP.md`.

---

## 1. One-paragraph summary

We simulate two cold, counter-streaming plasma beams carrying **opposite SU(2)
color charge**, sheared past each other in a frozen non-Abelian background
potential, and measure the growth rate γ(k_z; α, V₀) of the resulting
**non-Abelian shear instability** — the Yang–Mills generalization of the
Kelvin–Helmholtz (KH) problem, motivated by `khaxn.pdf` and the WKB dispersion
relation of `wkb.pdf` (eq. 33). The program now has a **three-level validation
stack** — analytic WKB ← exact 1D linear eigensolver ← full 2D GPU simulation —
with simulation-vs-eigensolver agreement of **0.96–0.99** on the plateau-audited
points of the best-controlled campaigns (k_z=1–5; see §5.2 and §8.5 for what
"audited" means and why k_z=6-type points are excluded) and thousands of fitted
runs across a five-decade (α, V₀, k_z) grid. The
headline physics, as originally framed: **the fastest-growing wavelength is
selected by the gauge coupling (k_z,peak ≈ 2α), not by the flow profile** — the
opposite of classical KH, where the shear-layer width sets the wavelength —
(*that framing has since been revised twice; see the update below and §5.3a*)
— and the dispersion curve is
**non-monotonic**, which the WKB formula does not predict but the exact
eigensolver reproduces. (Update 2026-07-17: the exact-action theory — T1.2,
§5.4 — derives this and sharpens it: the peak is set by coupling *and*
containment radius, k_z,peak ≈ αV₀ξ_w + (α/V₀)^{1/3}, with a hard growth
ceiling γ ≤ (αV₀²)^{1/3}; "≈2α" is what this evaluates to over the surveyed
grid, and its low-α end carries a mode-selection artifact — §8.8.)

**Major update (2026-07-19).** The three experiments this document previously
named as the program's decisive pending tests have now all been run, and two of
the three changed the story:

- **The EPS scan (T1.1, §5.3a, fig16) came back *against* the EPS-free claim**:
  k_z,peak genuinely drifts with the shear width in the real simulation (by 1–3
  integer steps over EPS = 0.10–0.45), and only sits near 2α at the historical
  baseline EPS=0.15. "The flow profile does not select the wavelength" is no
  longer defensible as stated; the Letter framing must change again.
- **The warm-fluid closure (T1.4, §5.7, fig17) validates the program** — with a
  twist. With *all* filters off, the warm plasma reproduces the filtered-cold
  eigensolver to ~1% near the peak; it is the cold filters-off *control* that is
  contaminated (by the colour-1 EM channel the filters normally remove, which
  pressure suppresses — γ_By¹: 1.40 cold → 0.73 warm). The production filters
  are thereby demonstrated to be physics-preserving, not answer-shaping.
- **The Tier-2 referee-proofing batch (all 8 experiments, §8.7,
  `REFEREE_PROOFING_RESULTS.md`) passed**, including the dimensionless collapse
  γ_peak/(αV₀²)^{1/3} = 0.977 ± 0.011 and the §8.8 overtone falsification.

Two further 2026-07-17/19 events reshaped the data foundation (§8.9): two
pipeline bugs (a conjugate-helicity extraction error and a box-size labeling
error) were found to invalidate ~96% of the timeseries archived between 07-04
and 07-17 — the simulations were fine, the tape recorder was pointed at the
wrong channel — and the corrected-pipeline rerun campaign (fig18) has rebuilt
the integer-k_z map at **median 8–9% agreement with the σ-chased eigensolver**
across 1,000+ plateau-confirmed points. The remaining structural caveat is the
frozen background, which is now quantitatively bounded (back-reaction
quadratic, wrong-signed for depletion, ≲7% out to |a|≈2.5, §8.2).

---

## 2. The physical problem, from the ground up

**For a general physicist.** The classical Kelvin–Helmholtz instability is what
happens when two fluid layers slide past each other: the interface ripples, the
ripples grow exponentially, and the flow rolls up into vortices. Its fastest
growing wavelength is set by the shear-layer width. Here we ask: what happens if
the two streams are *plasmas* whose particles carry a **non-Abelian (SU(2))
charge** — "color" — interacting through Yang–Mills fields instead of ordinary
electromagnetism? Non-Abelian fields differ in one crucial way: the fields
themselves carry charge, so a background gauge potential rotates ("precesses")
the color of everything moving through it. That precession opens instability
channels that have no Abelian counterpart, and it turns out to *select the
wavelength of the instability by the coupling constant* rather than by the flow
geometry.

**Why anyone cares.** Counter-streaming colored flows appear in several real
systems (§10): the initial state of heavy-ion collisions (glasma), hypothetical
non-Abelian dark-sector plasmas in cluster mergers, hot electroweak plasma in the
early universe, and — via an exact gauge-theory mapping — spin-orbit-coupled
electron fluids in semiconductors (that mapping is the sibling project,
`../spinkh/`). In all of them the question "how fast does shear convert flow
energy into gauge fields, and at what scale?" is the relevant one, and this
program measures exactly that in the cleanest tractable setting.

**The concrete setup** (`presentation/plots/fig01_setup_profiles.png`):

- 2D periodic box (x, z), Lx=6π, Lz=2π (both now runtime-extensible; fine-k_z
  campaigns use Lz up to 16π). Units: plasma frequency ω_p = c = 1; lengths in
  skin depths c/ω_p; rates in "time units" TU = 1/ω_p.
- Beam A: velocity v_z = +V₀ tanh(ξ), color charge Q¹=+1. Beam B: v_z = −V₀
  tanh(ξ), Q¹=−1, where ξ=(x−Lx/2)/EPS and EPS=0.15 is the shear-layer half-width.
  This is a **pure "color current"**: net momentum zero, net charge zero.
- A **frozen color-1 vector potential** A_z¹(x) = −V₀ log cosh(ξ) (the "Mode 6" /
  NAB_CIRC geometry). "Frozen" = prescribed static background, not evolved.
- Cold two-fluid equations (continuity, momentum, color-charge precession) for
  each beam + non-Abelian Maxwell (Ampère, Faraday, potential) for all three
  color components, in the A_x=0 gauge. Full equations in `PHYSICS.md` §2.
- Seed perturbation ∝ e^{ik_z z}; measure exponential growth of the color-2/3
  fields; scan k_z, α (gauge coupling), V₀ (shear speed).

The instability's feedback loop (the "activation chain") is:

```
By² → Ez² → Az² → Q³ → Q² (needs Az¹≠0) → Lorentz force → By²
```

The middle of the loop is genuine gauge-field dynamics; the step Q³→Q² is color
precession about the frozen background — the non-Abelian ingredient that makes
this instability different from anything Abelian.

**Middle panel of fig01** shows the quantity that organizes almost everything in
this program: the local Doppler/precession frequencies Ω_A(ξ) = k_z + αA_z¹(ξ) and
Ω_F(ξ) = k_z − αA_z¹(ξ). Where Ω_A crosses zero (at ξ_crit = k_z/(αV₀)) the outer
region becomes unstable to a *different*, faster EM mode; the absorbing "sponge"
layer must be placed to contain it (right panel — the empirical safe limit
γ_outer(sponge edge) ≤ 1.5 TU⁻¹ became a quantitative design rule,
xi_sponge ≈ 1.3·k_z/(αV₀) capped to [5, 55]). **That design rule was found
(2026-07-14, §8.4) to not actually hold at the low-k_z/low-α·V₀ corner** — the
formula's own cap pushes xi_sponge toward 55 there, and outer-branch
eigenvalues up to γ≈1.4 (well above the 1.5 target only by luck, not
enforcement) were found sitting inside that "designed" sponge. A corrected,
per-point tool exists for V₀≲0.05 (`analysis/find_safe_sponge.py`); V₀≳0.08 is
still open — see the §11 reminder.

---

## 3. What was actually built

### 3.1 The GPU simulation (`*.cu`, `*.cuh`)

- Flux-corrected transport (FCT, Boris–Book) for the two-fluid advection —
  kernels inherited verbatim from a validated EMHD KH code (`../emhdgpu2d/`);
  Yee-staggered leapfrog for the non-Abelian Maxwell sector; explicit source
  splitting between them. **Double precision** throughout (`typedef double
  fct_real_t` — note some older docs say float32; that is stale).
- Runtime-configurable grid, box size, Courant number, and target duration via
  `.ini` files; default fast grid NZ=64, NX=768, courant=0.1, validated to be
  fully converged (§7) and ~320× cheaper than the original conservative grid.
- Seven initial-condition "modes"; the survivors are Mode 1/6 (log-cosh Az¹).
  Modes 3, 4, 5 are documented failures that shaped the design (§8.1).
- A suite of spectral surgery kernels (DFT subtraction of selected k_z ranges,
  z-mean removal, hyperdiffusion, color-1 EM zeroing) used to isolate the target
  mode from faster parasitic instabilities (§8.1 — read that section critically;
  it is the program's main vulnerability).
- **Eigenfunction seeding**: the 2D run is initialized with the exact 6-field
  (By², Ex², Ez², Az², Q²_A, Q²_B) eigenvector of the 1D linear problem, so the
  target mode grows cleanly from t=0 instead of emerging from transients. This
  fixed a real failure mode (C23: an Az-only seed converged to the *wrong*
  eigenmode, 50% error in γ).
- Runs on 5–7 GPU nodes (RTX A5000s + 3× GTX 1080 Ti); a 100-TU run at the fast
  grid takes ~90 s; full k_z sweeps take minutes. ~10,000 fitted runs to date
  (of which ~2,000 are post-2026-07-17 corrected-pipeline reruns — §8.9).

### 3.2 The 1D exact eigensolver (`analysis/ym_eigenmode.py`)

The linearized system (12 complex fields on the x-grid) assembled as a sparse
matrix; dominant eigenvalues by shift-invert ARPACK; gives γ_exact, Im(γ), the
full eigenfunctions, and the seed files for the 2D runs. This is the middle rung
of the validation ladder and the workhorse for parameter-space pre-analysis. It
matches the 2D simulation to 1–7% wherever the simulation is clean (§5.2), which
cross-validates *both* (they share physics assumptions but not numerics: spectral
vs finite-volume, eigenvalue vs initial-value).

### 3.3 The analysis pipeline (`analysis/`)

Amplitude extraction (FFT in z, circular-polarization amplitude |Az²+iAz³| —
insensitive to phase rotation from Im(γ)), sliding-window log-linear fits with
R² selection, batch analysis across all servers (`batch_analyze.py`), and five
(α, k_z) sweep tables at V₀ = 0.01–0.2 (`sweep/v0p*.npz`) holding γ_WKB, γ_sim
and relative error on a 30×80 grid each.

---

## 4. The analytic target: eq. 33 and its quantization

The WKB analysis of `wkb.pdf` reduces the linearized problem to a quartic
dispersion relation for the trapped n-th eigenmode:

```
ω⁴ − k_z²ω² − Cω − α²V₀k_z = 0,   C = (2n+1)·√(α³/2)·V₀
```

Two limits matter:

- **k_z = 0** reduces to ω³ = C: a purely-growing "chromo-Weibel-like" mode with
  γ = C^{1/3}·sin 60°. This mode needs no shear — it is driven by color mixing in
  the background potential alone — and is the code's cleanest analytic benchmark.
- **k_z ≥ 1** is the shear-driven ("KH") branch, where the −α²V₀k_z term
  destabilizes and k_z² stabilizes; the balance produces the non-trivial
  dispersion curve we are mapping.

The WKB derivation approximates the log-cosh potential by a parabolic well and
the tanh velocity by a step — both approximations fail quantitatively at
moderate/strong coupling, which is *measured* in this program (§5.4) and is the
motivation for the exact-action upgrade (roadmap T1.2).

---

## 5. Results

### 5.1 kz=0 chromo-Weibel validation — the 0.5% anchor

`presentation/plots/fig02_kz0_weibel_validation.png`

At α=2.0, V₀=0.1 the measured kz=0 growth rate is γ = 0.5039 TU⁻¹ vs the WKB
prediction 0.5065 TU⁻¹ — agreement to **0.5%**, with textbook exponential growth
over nine decades of amplitude (left panel). This validates the code's entire
non-Abelian sector (the mode exercises the Ampère/Faraday cross-terms and the
precession chain) *and* the n=0 quantization of the analytic theory at the one
point where the WKB well approximation is exact.

The right panel is also a caution: across an α scan in the *double*-shear
geometry (Campaign 4), the simulation crosses the WKB curve — suppressed below
α=2, exceeding it above. That is understood as two-well eigenmode interference
(bonding/antibonding splitting) plus n=1 contamination at high α, i.e. geometry
effects, not code error — but it is the reason all production campaigns moved to
a single-layer geometry.

**Update (2026-07-19, the kz=0 extension thread — 459 runs, now closed out).**
An independent re-validation with the current single-layer-compatible geometry
(NAB_DTANH, kz=0 growing from machine noise) reproduced the anchor point
(α=2.0, V₀=0.1) to **0.02%** — the formula and the technique are solid. But the
attempt to extend this to a full (α, V₀) grid failed *as a measurement*: growth
from machine noise is not a single exponential (a long, slow pre-asymptotic
transient precedes the true eigenmode, which emerges only in the last ~10–30 TU
before nonlinear halt), and the automatic best-R²-window fit reads the wrong
regime nearly everywhere. Rather than fix the fit (no robust automatic window
detector was found — the true window is a knife-edge), the *bias itself was
mapped* on a 300+-point grid (`plots/kz0v3_relerr_map.png`,
`plots/kz0v4_valley_detail.png`): the fit under-predicts by up to ~80% at low
αV₀, over-predicts by up to ~67% at high αV₀, and the zero-crossing locus is a
strikingly clean power law V₀_cross(α) = 0.175·α^(−0.80) (0.24% median
residual). That regularity characterizes the *extraction numerics*, not the
plasma — it is documented so nobody mistakes it for physics, and the anchor
validation is the only kz=0 number this program quotes. One isolated "accurate"
pixel in the low-α corner was independently rerun and shown to be a knife-edge
fit-window coincidence, not structure (a useful control on over-reading such
maps).

### 5.2 The validation stack at V₀=0.05 — plateau rates match the eigensolver to 1–4% (kz≤5)

`presentation/plots/fig03_validation_stack_v005.png`,
`presentation/plots/fig11_growth_curves_C25.png`

For the core V₀=0.05 series (α = 1.0, 1.5, 2.0, 2.5, 3.0 — campaigns C25,
C32–C35) with 6-field eigenmode seeding and per-campaign matched sponges:

| α | sim/exact (kz=1..5) | plateau audit | kz_peak (sim / exact) |
|---|---------------------|---------------|----------------------|
| 1.0 | 0.96–0.99 | done (fig11; see below) | 2 / 2 |
| 1.5 | 0.98–0.99 | pending | 3 / 3 |
| 2.0 | 0.97–0.99 | pending | 4 / 5 |
| 2.5 | 0.97–0.99 | pending | 4–5 / 5 |
| 3.0 | 0.97–0.99 | pending | 5 / 5 |

(kz=6 columns are deliberately excluded — see below.)

**How to read the growth curves — and how not to** (fig11). The measured
amplitude curves are **not single exponentials**. Each has three regimes:
(1) a seed-dominated transient over the first ~20–30 TU, where the static
Gaussian Az seed swamps the growing component and the local slope climbs from
roughly half its final value; (2) a **plateau** (t ≈ 35–55 TU) where the local
slope d ln A/dt is flat to three decimals; (3) a post-kink late regime
(t ≳ 55–60) where the slope declines as the run approaches its nonlinear end.
The published fitting pipeline selects the sliding window with maximum R² —
and a smooth transition between regimes is *locally the straightest part of the
curve*, so max-R² windows are actually **attracted to regime transitions**, and
"R² = 1.000" carries almost no information about window placement (at 1-TU
cadence, nearly any ~10 TU stretch is locally straight). Re-auditing the C25
series against the local slope: the kz=2–4 windows landed on the plateau; the
kz=1 window landed in the post-kink regime (its value agrees with the plateau
essentially by luck); kz=5 straddles the kink; and **kz=6 has no plateau at
all** — its local slope wanders between 0.007 and 0.10, and refitting the same
timeseries with the batch fitter gives 0.088 vs the reported 0.057, a ~50%
fitter dependence. The defensible statement is therefore: **the local-slope
plateau — a window-free quantity — matches γ_exact to 0.7–3.6% for kz = 1–5**
(0.0889/0.0897, 0.1211/0.1220, 0.0927/0.0933, 0.0810/0.0819, 0.0643/0.0667),
and the kz=6 point should not be quoted. The C32–C35 campaigns used the same
pipeline and need the same plateau audit before their per-point numbers are
quoted individually (§8.5, §11).

With that caveat stated: the 2D initial-value simulation reproduces the 1D
eigenvalue to a few percent across the audited points, which remains the
program's central methodological claim — the machinery is quantitatively under
control wherever the mode is sponge-contained, correctly seeded, *and* the fit
is read off a verified plateau.

**Second caveat (2026-07-17, §8.8):** for the α=1 series specifically, the
eigensolver values being matched at k_z ≥ 3 are well-ladder *overtones*, not
the dominant mode (the default shift-invert target rides the quartic's
underestimate). The sim/exact ratios above stand as numerics validation, but
the C25 curve's shape — including its k_z = 2 peak — is a property of the
selected overtone family; the dominant-branch peak at the same window is
k_z = 3.5 at γ = 0.135. α ≥ 2 series are unaffected near their peaks.

### 5.3 Headline result — non-monotonic dispersion and coupling-selected k_z,peak

`presentation/plots/fig04_dispersion_v005_v003.png`,
`presentation/plots/fig05_kzpeak_vs_alpha.png`

- γ(k_z) is **non-monotonic**: it peaks at an intermediate k_z and rolls off on
  both sides. The WKB quartic predicts monotonic decrease from k_z=1; the exact
  eigensolver reproduces the peak — so the non-monotonicity is real linear
  physics of the log-cosh background, not an artifact.
- The peak **migrates with coupling**: k_z,peak ≈ 2α at V₀ = 0.03–0.10 (≈1.5α on
  the V₀=0.03 slice), covering k_z,peak = 1 → 8 as α goes 0.5 → 5. fig05 collects
  every reliable campaign point; the trend is robust across a factor 20 in V₀.
- γ_peak scales as **V₀^0.85–0.92** at fixed α (sub-linear; saturating for
  αV₀ ≳ 0.15 at low α).
- In classical KH, k_z,peak·EPS ≈ 0.5 — the shear width sets the scale. Here
  EPS had been fixed at 0.15 while k_z,peak moved by a factor 8 with α. The
  T1.1 EPS scan was the designated decisive test of the claim "the gauge
  coupling, not the flow profile, selects the wavelength" — **and it has now
  been run (2026-07-19, §5.3a): the claim did not survive.** k_z,peak moves
  with EPS too.

**Reinterpretation (2026-07-17, T1.2 done — §5.4, PHYSICS.md §11):** the
exact-action theory shows the peak is **confinement-set, not intrinsic**:
k_z,peak ≈ αV₀(ξ_w − ln 2) + (α/V₀)^{1/3} where ξ_w is the sponge/cut radius;
unbounded, γ(k_z) saturates at the ceiling (αV₀²)^{1/3} with no interior
maximum. Both terms are EPS-free — the theory *predicts* the "not the flow
profile" half of the claim — but "k_z,peak ≈ 2α" is what that expression
happens to evaluate to over the surveyed (α, V₀, sponge) box, not a
fundamental linear-in-α selection. The Letter framing needs to change from
"coupling selects the wavelength" to "coupling and containment radius select
the wavelength; the flow profile does not." Additionally, the low-α end of
this trend is contaminated by an eigenmode-selection artifact (§8.8).
**(2026-07-19: the "flow profile does not" half has now also failed the direct
test — see §5.3a.)**

### 5.3a The EPS scan (T1.1, done 2026-07-19) — the peak drifts with the shear width

`presentation/plots/fig16_epsscan_dispersion.png`,
`plots/epsscan_eigensolver_prediction.png` (pre-registered eigensolver
prediction)

The designated decisive experiment: 120 GPU runs over EPS ∈ {0.10, 0.15,
0.225, 0.30, 0.45} × α ∈ {1.0, 1.5, 2.0} × k_z = 1..8 at V₀ = 0.05, with the
corrected extraction pipeline, per-point vetted sponges, the NZ/4.5 filter
rule, NX=1152 for the narrow-EPS leg (EPS/DX ≥ 6) and a doubled box for
EPS ≥ 0.30 (three latent campaign-generator bugs were found and fixed during
staging — seed-filename collisions, a hardcoded NX in the extractor, and a
wrap-buffer false-negative in the sponge vetting; FINDINGS.md 2026-07-18). All
120 runs completed and fitted cleanly (R² ≥ 0.997); sim/eigensolver median
0.855 (IQR 0.70–0.99, best at the narrowest EPS).

**Result: k_z,peak(EPS) genuinely drifts — in the eigensolver prediction and
confirmed by the GPU data** (argmax of γ_sim over k_z):

| α | EPS=0.10 | 0.15 | 0.225 | 0.30 | 0.45 |
|---|---|---|---|---|---|
| 1.0 | 4 | 2 | 2 | 2 | 2 |
| 1.5 | 5 | 4 | 2 | 3 | 3 |
| 2.0 | 5 | 4 | 3 | 4 | 3 |

At the historical baseline EPS=0.15, k_z,peak ≈ 2α roughly holds — which is
exactly why every earlier campaign, all run at EPS=0.15, saw the clean 2α
trend of fig05. Away from 0.15 in either direction the peak moves by 1–3
integer steps and does **not** track 2α. Narrower shear layers push the peak
*up* (toward higher k_z), wider layers pull it down and raise the overall γ
level (the eigensolver also shows γ at fixed k_z and fixed sponge rising ~30–40%
from EPS=0.10→0.45 — a real, currently unexplained EPS-dependence of the rate
itself, not a sponge or box artifact). Two honesty caveats cut both ways:
(a) the peak is broad and flat (a few % across 2–3 adjacent integer k_z), so
the argmax is a fragile statistic on top of a real drift — the whole-curve
shapes in fig16 are the robust evidence; (b) the α=1 row carries the §8.8
overtone caveat.

**Consequence for the headline.** "The gauge coupling, not the flow profile,
selects the wavelength" is dead as stated. What survives: (a) the coupling
still dominates — at fixed EPS the peak moves by a factor ~5 with α, while at
fixed α it moves by at most a factor ~2 across a 4.5× range in EPS; (b) the
drift has the classical *sign* (narrower layer → higher k_z,peak) but is far
weaker than the classical k_z,peak ∝ 1/EPS scaling, so the mode is still not
a textbook interface ripple; (c) the exact-action combinations for the γ
ceiling (αV₀²)^{1/3} and the k_z scale (α/V₀)^{1/3} are untouched and now
empirically confirmed (§8.7 T2.5). But the T1.2 theory's k_z,peak formula —
both of whose terms are EPS-free — is now known to be incomplete, and needs
an EPS-dependent correction term before the Letter can state a selection law.
This is the current top theory priority (§11).

There is also a **sub-k_z=1 fine-structure result** from the extended-box (Lz=4π,
8π) campaigns — a sharp two-branch structure below k_z=1 (γ = 0.32 at
k_z,phys = 0.5 falling to 0.06 at 0.75 for α=2, V₀=0.05), suggesting a crossing
between two eigenmode families. This is currently a *preliminary* claim: it lives
in per-run session records, and the raw sweep tables at those k_z are contaminated
(§8.4, fig12) — it must be re-established by the curated solver-continuation study
(roadmap T1.3) before being presented as a result.

### 5.4 The WKB gap — explained: the exact-action theory (T1.2 ✅ 2026-07-17)

`presentation/plots/fig07_sim_vs_wkb.png`,
`plots/exact_action_wkb_validation.png`

The measurement stands as before: across ~1,900 clean grid points, the median
γ_sim/γ_WKB ≈ 0.56, with a broad hump at 0.4–1.1 near and above the dispersion
peak, a long tail of tiny ratios at low k_z where WKB overestimates by up to
10–20×, and ~25% *under*estimates in the weak-coupling corner (α=0.5–1, k_z≥4).

**Update (2026-07-17): the exact-action theory now exists and closes T1.2**
(derivation: `PHYSICS.md` §11; code: `analysis/exact_action_wkb.py`). The
6-field linear system reduces *exactly* (even at the discrete level — verified
to machine precision) to one scalar ODE, (γ²a′/D)′ = (γ²+g)a, whose only drive
is the two-beam precession-charge response g = 2αv³Ω_A/(γ²+v²Ω_A²). Everything
follows from that term:

- **Hard growth ceiling γ³ ≤ αV₀²** — the drive maximizes on the
  precession-resonance surface V₀·Ω_A = γ; measured peak rates reach 95–99%
  of (αV₀²)^{1/3} in every audited series. (2026-07-19: now confirmed as a
  15-curve dimensionless collapse, γ_peak/(αV₀²)^{1/3} = 0.977 ± 0.011 —
  §8.7 T2.5, `plots/t2p5_collapse.png`.)
- **Exact-action quantization** (the branch is quantization-marginal: the
  well holds less than a quarter wave, tan S = κ/k) reproduces the σ-chased
  dominant eigensolver branch to ≤2% (median ≤0.2%) for k_z ≥ 1.5 across
  α = 1–5, V₀ = 0.03–0.2, windows ξ_w = 5–40; a closed-form square-well
  version (PHYSICS.md eq. 11.7) is within ~3% near/above the peak.
- **The dispersion peak is not intrinsic**: unbounded, γ(k_z) saturates
  monotonically at the ceiling while the mode migrates outward riding the
  resonance surface. The measured peak is the crossover where that surface
  reaches the sponge/cut radius:
  **k_z,peak ≈ αV₀(ξ_w − ln 2) + (α/V₀)^{1/3}** (verified to ±0.6 in k_z on
  11 series, including a direct test: moving the window 11→25 at fixed
  physics moved the peak 4.5→5.5). Both terms are EPS-free. See §5.3 note
  and §8.8 for what this does to the "k_z,peak ≈ 2α" framing.
- **The gap itself is diagnosed**: eq. 33's drive term −α²V₀k_z does not
  match the true beam response (three powers of v, Doppler-resonant,
  ceiling-bounded). Its low-k_z overshoot produces the 10–20× tail; its
  high-k_z decline against the true ceiling saturation produces the
  weak-coupling-corner underestimates. The k_z=0 chromo-Weibel 0.5% anchor
  (§5.1) is untouched — different geometry, where eq. 33's parabolic
  quantization is exact.

The quartic (eq. 33) is thereby retired as the theory level for k_z ≥ 1; the
exact-action model (or the eigensolver itself) replaces it.

### 5.5 Parameter-space coverage

`presentation/plots/fig06_sweep_coverage_heatmaps.png`

Five sweep tables (V₀ = 0.01, 0.03, 0.05, 0.1, 0.2) on a 30×80 (α, k_z) grid:
**3,458 of 12,000 points filled** so far from ~5,800 fitted runs (multiple
sponge/box variants per point; fills are ongoing on all available nodes). The
red × marks in fig06 are points whose stored fit fails a sanity cut
(γ_sim > 2·γ_WKB or γ_sim > 0.6 TU⁻¹) — mostly parasitic or nonlinear fits that
the raw tables currently retain (§8.4). The maps make the peak ridge and its α
migration visible directly in the V₀=0.03–0.2 panels. **(2026-07-19: these
tables are now superseded as the quantitative record by the corrected-pipeline
archive of §5.8/fig18 — treat fig06 as a coverage map, not a measurement
table.)**

### 5.6 Eigenfunction structure — what the mode actually looks like

`presentation/plots/fig08_eigenfunctions_a2_v01.png`

Exact eigenfunctions at α=2, V₀=0.10: at k_z=1 the magnetic perturbation peaks
*away* from the shear layer (|ξ| ≈ 5–10), with |Az²|/|By²| ≈ 60–190 and
color-charge structure concentrated where Ω_A ≈ 0. At higher k_z the mode
compresses toward the sponge boundary and develops oscillatory outer tails. Two
honest consequences: (a) the mode is often better described as a **shear-fed
outer EM instability** than a textbook KH ripple at the interface — the
energetics diagnostic (T1.5) will decide the right name; (b) wherever the peak
sits near the sponge, the measured γ is systematically compressed (§8.3).
(2026-07-19: the eigenfunction is now also *directly verified in the 2D code* —
the T2.2 overlay figure shows the simulation's linear-phase profile tracing
the solver eigenfunction with correlation 1.0000, including a non-trivial
double-lobe By² shape grown from an effectively unseeded field — §8.7,
`plots/t2p2_eigenfunction_overlay.png`.)

### 5.7 The warm-fluid closure (T1.4, done 2026-07-19) — filters-off validation, with a reversal

`presentation/plots/fig17_warmclosure.png`

The program's biggest standing vulnerability (§8.1) was that the measured mode
is subdominant in the cold system and only measurable behind spectral filters.
The designated fix — an isothermal-pressure warm closure (`warm_T`, giving each
beam v_th ≳ V₀) run with **all filters off** — has now been executed: a C35
clone (α=2, V₀=0.05, k_z=1..8) with a cold filters-off control plus three warm
legs (v_th/V₀ = 2.0, 2.5, 3.0), 32 runs, all surviving to clean fits.

The result validates the program, but through a sharper mechanism than the one
anticipated:

- **The three warm legs agree with each other to <2%** (despite a 2.25× spread
  in warm_T) and sit within ~1% of the filtered-cold eigensolver near the peak
  (k_z=3–4: 0.155/0.149 measured vs 0.151/0.152 predicted).
- **The cold filters-off control is the contaminated measurement, not the warm
  ones.** First read, the warm legs looked "too fast" (higher γ than cold at
  every k_z). A per-channel energy decomposition against snapshots
  (`analysis/diagnose_warmclosure_channels.py`) reversed that: in the cold run
  the colour-1 EM instability at the *target* k_z (the γ≈1.1–1.4 channel the
  production filters exist to remove) grows at γ=1.395 and is 8× the target
  signal by t=30, dragging the fit; in the warm run the same channel grows at
  half that rate (0.730) and stays ~6 orders of magnitude below the target
  mode. Pressure does exactly the stabilizing job the §8.1 defense asserted —
  now demonstrated, not asserted.
- The same decomposition quantified, for the first time, how subdominant the
  intended mode is in the unfiltered cold system: colour-1 EM + fluid kinetic
  energy exceed the measured colour-2/3 sector by 4–6 orders of magnitude.

**The honest statement of §8.1 therefore upgrades from** "the filtered cold
measurement is asserted to be the T→0 limit of a warm plasma" **to** "the
filters-off warm plasma reproduces the filtered-cold theory curve to ~1% near
the peak; the filters remove modes that a physical thermal spread suppresses."
Residual opens: the warm γ(k_z) profile is flatter than theory across
k_z=1..8 (k_z=1 reads 39% high; k_z=5 splits between warm_T values), so a true
*warm eigensolver* (fluid pressure terms added to `ym_eigenmode.py`) is the
right next theory artifact; until then the comparison is warm-sim vs cold
theory.

### 5.8 The corrected-pipeline archive (2026-07-19) — the integer-k_z map at 8–9% median accuracy

`presentation/plots/fig18_recorr_accuracy.png`

After the §8.9 pipeline bugs were fixed, the archive was rebuilt from scratch
by dedicated rerun campaigns (recorrection + the trimmed integer-k_z "intkz"
campaign; run_mode 6, EPS=0.15, vetted sponges, NZ/4.5 filter rule, fixed
extractor, plateau detection in the fitter). Status:

- **~1,500 corrected integer-k_z clean-core points** (k_z=1–9, α>0.3, V₀ =
  0.01–0.2), of which ~1,000 are plateau-confirmed, measured against the
  σ-chased eigensolver *at each run's exact sponge* (never the quartic, never
  the default-σ call — §8.8).
- **Median |rel. err.| 9.1% (plateau-confirmed), improving monotonically with
  V₀**: 20% at V₀=0.01 (weak-signal regime) through 8–9% at V₀=0.03–0.05 to
  4–7% at V₀=0.07–0.2. The intkz campaign is paused at 87% (988/1134 grid
  points); the remaining 146 runs are queued.
- The map stops at k_z=9 by *measured* necessity: at NZ=64, k_z≥10 modes
  (~5 cells/wavelength) are killed by FCT diffusion — the seed actively
  decays — and NZ=256 still under-resolves them. A documented resolution
  cliff, not a physics boundary.
- This supersedes the older sweep tables (§5.5) as the quantitative archive;
  the old tables remain useful only as qualitative coverage maps, and their
  `rel_error` columns (vs the mislabeled quartic) should never be quoted
  (§8.4, §8.9).

---

## 6. The failure catalog — and why it is evidence, not embarrassment

A large fraction of the campaign log is documented failures. They are load-bearing:
each one identified a real instability of the counter-streaming colored system,
and the final configuration is the one that survives all of them.

| # | Failure | Mechanism | Fate |
|---|---------|-----------|------|
| 1 | Unbounded outer coupling (C1–C2) | log-cosh Az¹ grows without bound on a wall-BC domain; outer region always overtakes | → bounded/periodic redesign |
| 2 | kz=0 chromo-Weibel blowup (C3–C5) | γ≈0.5 from machine noise, hits energy threshold at t≈49 TU | → suppress_kz0 + hyperdiffusion; also the 0.5% validation |
| 3 | FCT NaN wall (C4, C6) | truncation-error accumulation advecting the double-tanh shear, t≈63–71 TU independent of physics | → abandoned double-tanh geometry |
| 4 | NAB_STEP two-stream (C7, C9) | step velocity ⇒ counter-streaming everywhere ⇒ color-1 two-stream at ω_p/√2, NaN at t≈12–22 TU, α-independent | mode 4 **ruled out** |
| 5 | Fluid pz two-stream (C10–C12) | residual outer-region two-stream at k_z≤14, γ≈0.8 | → fluid pz band-stop filter |
| 6 | Color-1 EM instability (C13–C14) | filamentation-type growth at *every* k_z incl. the target, γ≈1.1 | → zero color-1 EM each step (the KH chain does not use it) |
| 7 | Precession cascade (C15–C17) | Az² grows at γ≈αV₀ regardless of KH; masks all k_z≥2 measurements | → Mode 6: seed Az² directly with the eigenmode |
| 8 | Stray eigenmode (C23) | Az-only seed places Q² at the wrong ξ; simulation converges to a different, slower mode (50% error) | → 6-field eigenfunction seeding |
| 9 | Outer EM overrun at high αV₀ (C19–C21) | γ_outer ≈ √(Ω_A·Ω_F) ≈ 3–4 TU⁻¹ beats the sponge | → per-campaign sponge design rule |
| 10 | Stale-binary garbage (C20b/C21b first attempts; t130 360-run incident) | node binaries older than the source | → mandatory rebuild + 1-TU smoke test after every sync |

Items 4–6 are genuine physics of the cold system (see §8.2 for what filtering
them means); items 3, 8, 10 are numerics/process lessons now encoded in rules.
**Item 9 was not actually closed by the "per-campaign sponge design rule"** —
that rule's own formula was found (2026-07-14) to reintroduce exactly this
failure at low k_z/low α·V₀ (§8.4, §11 item 3b), fixed for V₀≲0.05 and still
open at V₀≳0.10. Treat "→ per-campaign sponge design rule" as the fate for
the *originally tested* α≥3/V₀≥0.2 regime only, not as evidence the general
mechanism is understood.

---

## 7. Numerical quality assurance

`presentation/plots/fig10a_resconv_spatial.png`, `fig10b_resconv_temporal.png`,
`fig10c_resconv_aspect.png`, `fig09_gauss_law.png`

- **Convergence study** (11 configs + follow-up floor/ceiling hunts,
  `RESOLUTION_FINDINGS.md`): γ flat to 4.4% peak-to-peak across a 4× range in
  spatial resolution, 16× in timestep, 4× in aspect ratio; energy conserved to
  1.000000 in every run. Identified hard limits: NZ=32 is a cliff (γ collapses to
  37% — filter/Nyquist interaction, not gradual), courant=1.0 is the CFL cliff;
  x-resolution needs EPS/DX ≳ 6. The production grid sits safely inside all
  three. **The WKB gap is not a resolution artifact** — it persists identically
  at every converged configuration. ⚠️ **Qualified 2026-07-19 (T2.8, §8.7)**:
  the original study anchored one point (α=1, V₀=0.05, k_z=1). Spot-checks at
  the extremes show the low-αV₀ corner converged to <1%, but the high-αV₀
  corner (α=3, V₀=0.10, k_z=5 — the narrowest, fastest production mode) is
  **~3–6% under-resolved** (timestep +5.9%, NX +2.7% on refinement). "Converged
  to ~2%" must be stated as "~5% at the high-αV₀ end" in any paper.
- **Two further resolution rules found 2026-07-17/19**: (a) the z-band-stop
  filter must satisfy **kz_suppress_hi ≤ NZ/4.5** (hi=14 at NZ=64, 28 at
  NZ=128, 112 at NZ=512) — a wider band reaches into the grid's dispersive
  near-Nyquist tail where the FCT limiter continuously deposits mode-correlated
  content, and zeroing that band strongly damps the *kept* mode (γ drops
  smoothly by up to 20% as hi grows past the rule, then collapses entirely);
  (b) at NZ=64 the map's usable range is **k_z ≤ 9** — k_z ≥ 10
  (~5 cells/wavelength) is killed by FCT diffusion outright, and NZ=256 is
  still not converged there (§5.8).
- **Energy conservation**: E/E₀ = 1.000000 through the linear phase in converged
  runs; energy-threshold or NaN halts occur only after nonlinear saturation.
- **Gauss's law** (fig09): the non-Abelian constraint ∂ₓEx^a + ∂_zEz^a +
  α(A_z×E_z)^a = ρ^a is *not* exactly preserved by the leapfrog scheme. Measured:
  relative residual ~10⁻³ of the total-field scale through the run, with the
  absolute residual growing with the (exponentially growing) fields, spatially
  localized at the mode. ✅ **T2.3 done (2026-07-19)**: the promised figure now
  exists (`gauss_check.png`; α=1, V₀=0.05, kz=1) — absolute RMS residual ~1×10⁻⁵,
  colour-1 relative residual ~1.4×10⁻³ *and decreasing* over the run, |∇·E|
  dominant with the non-Abelian term subdominant and |ρ| negligible, residual
  localized at the mode. Confirms the statement above. See
  `REFEREE_PROOFING_RESULTS.md` §T2.3.
- **Fit quality**: production campaigns report R² ≥ 0.999, but R² alone does not
  certify window placement on multi-regime curves (§8.5) — the plateau in the
  local slope is the meaningful diagnostic. Originally audited only for C25;
  as of 2026-07-19 the corrected-pipeline refits carry an explicit plateau
  detector per point (`has_plateau` in `sweep/recorr_results.csv`), and ~68%
  of the rebuilt integer-k_z clean core is plateau-confirmed (§5.8). Growth
  is measured on the circular amplitude, immune to Im(γ) phase rotation.
- **Linearity check** (seed amplitude ×10/×0.1 ⇒ γ unchanged): ✅ **T2.4 done
  (2026-07-19)** — at α=1, V₀=0.05, kz=1 the fitted γ = 0.0901 is identical to
  four significant figures across seed amplitudes 1e-4/1e-3/1e-2 (initial
  amplitude scales exactly linearly, R²=1.000, identical fit window). The
  measurement is firmly in the linear regime. See `REFEREE_PROOFING_RESULTS.md`
  §T2.4.

---

## 8. Where we are on shaky ground — the honesty section

Ordered by how likely each is to draw referee blood.

### 8.1 The measured mode is subdominant in the cold system (the filters)

The isolated mode grows at γ ≈ 0.05–0.37. In the *unfiltered* cold system, the
fluid two-stream (γ≈0.7–0.9), the color-1 EM instability (γ≈1.1) and the kz=0
chromo-Weibel (γ≈0.5) all grow faster. The measurement is possible only because
these channels are surgically removed every step (band-stop DFT filters on
color-2/3 EM and fluid p_z; zeroing of color-1 EM; kz=0 projection;
hyperdiffusion). So the honest statement of the result is: *"the non-Abelian
shear mode of the cold two-beam system, measured in the subspace where its faster
competitors are projected out."*

**Is that defensible?** Physically yes, with one argument: every filtered
instability is a cold-beam pathology. A warm plasma with thermal spread
v_th ≳ V₀ Landau-damps or pressure-stabilizes the two-stream family while leaving
the shear-driven mode (which lives on the *relative* drift structure, not the
beam resonance) essentially intact.

✅ **RESOLVED (2026-07-19): the argument is now demonstrated, not asserted.**
The T1.4 filters-off warm rerun (§5.7, fig17) shows the warm plasma reproducing
the filtered-cold eigensolver to ~1% near the peak, warm_T-independent above
threshold, with the per-channel energy diagnosis explicitly confirming the
mechanism (pressure halves the colour-1 EM channel's growth and keeps it 6
orders of magnitude below the target mode; in the cold filters-off control that
same channel overruns the measurement — the *control* is the contaminated leg).
One presentational subtlety carried forward: the validation comparison must be
warm-vs-theory, not warm-vs-cold-control, because the unfiltered cold control
is not a clean reference for anything. Residual opens are quantitative, not
existential: the warm profile is flatter than theory across k_z=1..8, and the
proper theory endpoint is a warm eigensolver (queued, §11).

### 8.2 The frozen background is not a self-consistent equilibrium — now quantitatively validated (T2.6 done)

A_z¹ is prescribed and static (freeze_az1=1). The true self-consistent
equilibrium of the khaxn derivation has A_z¹ sourced by the beams' own color
current — which is unbounded in an infinite domain and caused the C1/C2 blowups.
Freezing is the standard "fixed external field" idealization (and it is *exact*
in the condensed-matter realization — see `../spinkh/`), but in the plasma
context it means: (a) the background exerts forces the beams do not back-react
on; (b) there is no momentum-conservation statement connecting mode growth to
background depletion.

**Update (2026-07-15/16): the promised quantitative check (T2.6 — unfreeze
A_z¹, measure drift and γ shift) has now been run** (t133, two independent
tachyonic-branch configs at α=1.0, V₀=0.05; FINDINGS.md "Self-consistent
(unfrozen Az1) test"). Results:

- **Linear phase: freezing is validated.** Unfrozen (and color-1-live)
  variants grow at the same rate as the frozen reference (first config:
  γ=1.45 from snapshots vs eigensolver 1.43–1.46); freezing does not
  meaningfully distort the tachyonic branch's linear growth.
- **The back-reaction is real, quadratic, and wrong-signed for depletion.**
  Differencing seeded vs unseeded unfrozen runs isolates the mode's imprint on
  A_z¹ at k_z=0: **ΔA_z¹ ≈ −0.04·|a|²**, tracked over four decades of |a|² and
  landing exactly on the prediction at the endpoint (|a|=2.46: measured
  −0.242 vs predicted −0.242), pinned at the mode peak throughout. The wave
  makes the background **deeper** (|αA_z¹| larger), not shallower — the
  opposite of depletion.
- **Net feedback is weakly stabilizing**: the unfrozen mode grows slightly
  slower at finite amplitude (second config, γ_lin=0.64: amplitude ratio 0.998
  at |a|≈0.1 falling to 0.933 at |a|≈2.5; fitted mid-range slope 0.5156 vs
  0.5180) — two orders of magnitude too weak to saturate the branch before the
  fluid model itself dies (density cavitation / energy halt). **Depletion is
  not the saturation route for this branch, and the frozen approximation is
  accurate to a few percent everywhere it matters.**
- A byproduct of the test: a "quiet" fully self-consistent counter-streaming
  background does not exist in this model — with k_z=0 live, the beams' own
  chromo-Weibel mode (γ=0.284 at the test point) always grows. Two other
  obstructions (periodic-wrap collapse of the single-tanh v_z profile — the
  real reason `suppress_kz0=1` is mandatory in production — and a secular By¹
  pump from a non-equilibrium color-1 init) were fixed with `vz_edge_taper`
  and `init_by1_eq`; the Weibel floor is physics, not numerics.

**Scope of the validation** (what a referee should know): the test was run on
the *tachyonic outer branch*, not on the production shear-layer KH mode — and
deliberately so. That branch is the stringent case for freezing: its drive
*is* the background (γ² = α²A_z¹² − k_z²), it grows roughly an order of
magnitude faster than the KH rates at the same (α, V₀), and it was pushed to
|a|≈2.5. The transfer to the production KH measurements is a fortiori:
dispersion fits are made in the linear phase at |a|≪1, where a −0.04·|a|²
back-reaction is negligible by many further orders of magnitude. Two limits
remain: (i) both configs sit at a single physical point (α=1.0, V₀=0.05) —
the quadratic law and its sign are the general content; the −0.04 coefficient
and the −7% margin are point-specific; (ii) the unfrozen runs are only clean
inside the pre-Weibel window (~20 TU here), so "validated" covers the linear
and early-nonlinear phase — genuinely long-time self-consistent evolution
remains the Kolmogorov-flow program's domain.

Consequence for khaxn: the frozen "infinite battery" is *not* an overestimate
of the drive — in a self-consistent setting the beams continuously re-supply
the background and the charged waves locally deepen it. The instability of
such backgrounds is robust, and its endpoint is fluid-scale (cavitation)
rather than field-scale (depletion). The **non-Abelian Kolmogorov flow**
(T1.6): a fully periodic cosine equilibrium where −∂ₓ²A_z¹ = J_z¹ exactly,
no freezing, no sponge — remains the gateway to the nonlinear/saturation
study, but is no longer needed to defend the frozen-background approximation
itself.

### 8.3 Sponge dependence of the measured rates

The absorbing sponge at |ξ| > xi_sponge is both necessary (contains the outer EM
instability) and harmful (clips the eigenmode's outer tail). Every campaign whose
mode peaks near the sponge shows systematic γ compression — quantified: sim/exact
falls from ~0.99 (mode well inside) to 0.4–0.7 (mode at the edge), and the
apparent k_z,peak shifts down by 1–2 units at V₀=0.03 with a tight sponge. The
per-point workaround (use the largest-sponge run available; flag (!) points where
ξ_crit > xi_sponge) is bookkeeping, not physics. The defensible fix is the
sponge-extrapolation study (T2.7: γ(xi_sponge → ∞) for representative points).
✅ **T2.7 done (2026-07-19)**: at α=1, V₀=0.05, kz=1 the fitted γ rises
*monotonically* with sponge radius — 0.0605 (ξ=6), 0.0719 (ξ=10), 0.0768 (ξ=16),
0.0775 (ξ=20), 0.0772 (ξ=25) — and **saturates at ≈0.077 by ξ≈16** (<2% change
between ξ=16 and ξ=25). The tightest sponge (ξ=6) compresses γ by **28.5%**
relative to the converged value, directly quantifying the compression systematic.
Production runs use ξ_sponge ≥ 8–20, where the residual compression is
single-digit-%. `plots/t2p7_sponge_extrapolation.png`. **Any k_z,peak entry in
fig05 marked from a compressed campaign should still be treated as ±1 in k_z.**

### 8.4 The raw sweep tables contain contaminated fits

`presentation/plots/fig12_subkz1_contamination.png`

Probing the tables directly (this document's preparation) shows, at k_z < 3:
(a) a **flat floor γ ≈ 0.095–0.098** below k_z≈1 that is *independent of α and
V₀* — a physical rate would scale with the drive; this is almost certainly a
parasitic channel or fit floor, not the eigenmode; (b) **spikes at half-integer
k_z** (0.5, 1.5, 2.5: γ up to 4 TU⁻¹, i.e. 10–30× the eigenvalue) — these
coincide with the odd-k_mode runs of the Lz=4π wave, suggesting a
box-size/filter-indexing interaction in that campaign family; (c) the quoted
sub-k_z=1 two-branch discovery is not currently reproducible from the tables
(the curated numbers came from individual run analysis). **Consequence: nothing
below k_z ≈ 1 should be shown publicly until a quality-gated re-analysis pass
(reliability flags propagated into the npz tables, contaminated families re-run
or excluded) is done.** The integer-k_z results of §5.2–5.3 are unaffected — they
come from the curated per-campaign analyses, not the raw tables.

A related and sharper reproducibility finding (2026-07-12): a **later re-run of
the C25 series at identical nominal parameters** (α=1, V₀=0.05, xi_sponge=20, on
t140 instead of t136) shows a k_z=1 local-slope *plateau* of 0.174 — **twice the
eigensolver value** and twice the original C25 measurement — and that
contaminated value is exactly what sits in the sweep table at (α=1, V₀=0.05,
k_z=1). This is not a fit artifact (the plateau itself is wrong), so something
physical-or-numerical differs between the two runs despite identical nominal
configs (candidate suspects: binary vintage, seed file, filter configuration on
that node). Until the flagship series reproduces across nodes, cross-node
reproduction of at least one campaign belongs on the pre-publication checklist.

**Root cause found for the half-integer spikes (2026-07-14) — it was the sponge, not
a box/filter-indexing bug.** The "suggesting a box-size/filter-indexing interaction"
hypothesis above is superseded: field-decomposed one blown-up run and found
By2/By3 (color-2/3 EM) exploding at exactly the target k_z bin, independent of the
Az2/Az3 field the amplitude timeseries actually measures — this is the same
category of failure already known and fixed for color-1 (an on-target EM
instability the bandpass filter structurally cannot remove), just without the
equivalent protection for color-2/3. Querying the eigensolver's full spectrum
(not just the default near-γ_WKB shift) at the failing sponge value found a
genuine eigenvalue at γ≈1.4 — the outer-region EM instability (§8.3, already
known since Campaigns 19-21) — passing `is_localised()`'s check because that
check's tolerance scales with xi_sponge itself, and the blind `xi_sponge_for()`
formula pushes xi_sponge toward its 55 ceiling at exactly the low-k_z/low-α·V₀
corner the half-integer campaigns targeted. **Confirmed by direct fix-and-rerun**,
not just theory: tightening xi_sponge (e.g. 52→15 for one point) took a run from
γ_sim=1.49 (8× the true value, blows up at t≈21 TU) to a full clean 100-TU run
matching γ_exact to ~10%, reproduced on a second independent point.

**But this fix is scope-limited, not universal — do not assume it rescues the
whole suspect set.** `analysis/find_safe_sponge.py` automates the eigensolver-based
search. Tested against 5 points with full 100-TU CUDA confirmation: every
V₀≤0.05 point tested was clean or near-clean at the tool's recommended (much
tighter) sponge, but the one V₀=0.10 point tested **failed outright, and still
failed even at the tightest sponge tried** (near the floor) — tightening delayed
the blowup (t=38→t=91) but did not eliminate it. This strongly suggests the
outer-branch instability's strength scales with V₀ in a way sponge-tightening
alone cannot fully counter once V₀ is large enough. **Practical consequence**:
treat the half-integer/low-k_z contamination as fixable via sponge-tightening
for V₀≲0.05 (still spot-check, not blind-trust), and as an **open problem**
for V₀≳0.08 — those points may need a fundamentally different exclusion
mechanism (e.g. the eigensolver's untried `xi_cut` hard-wall option) or may not
be cleanly measurable with mode 6 as currently designed.

**Follow-up boundary-mapping (same day) found better news than the first pass
suggested.** Perturbing α, V0, k_z one at a time around a near-miss point looked
at first like a real boundary (3 of 6 directions failed at the tool's
recommendation) — until re-testing all 4 problem points at a further-tightened
sponge (sp≈6-10) showed **every one of them clean over the full 100 TU**. There
is no hard physical wall anywhere tested across α≈1.5-2.5, V0≈0.02-0.05,
k_z≈1-2.5 — the apparent boundary was the tool's margin being too loose, not a
real edge of the safe region. `find_safe_sponge.py`'s margin was revised (0.75x
→ 0.5x) accordingly. The real cost is sponge compression, confirmed directly:
one point's γ_exact fell 33% (0.172→0.115) between an unsafe-loose and a
safe-tight sponge — safety and accuracy trade off directly here, not free. Net
effect: V0≤0.05 across roughly α=0.3-2.5, k_z=0.5-2.5 now looks like a genuinely
usable, contiguous region with proper (tighter) sponge tuning; V0=0.10 is still
a confirmed hard wall.

**The V0=0.05→0.10 transition itself was then mapped** (fixed α=1.5, k_z=2.5 —
the point that failed at V0=0.10 — swept V0 upward, retesting at the sponge
floor whenever the tool's recommendation still showed contamination): it is a
**gradual transition, not a step**. V0≤0.07 fully rescues to a clean 100-TU run
at the sponge floor (confirmed at two different (α,k_z) points for V0=0.07).
V0=0.08-0.09 is a genuine transition zone — even the tightest sponge tried
leaves measurable residual contamination (mild at 0.08, moderate at 0.09;
bounded, not an outright failure, but not clean either, and would bias any
quoted γ upward). V0≥0.10 is confirmed as a hard wall **for the soft sponge**
at two sponge values, where tightening stops helping at all.

**`xi_cut` (hard-wall Dirichlet BC), implemented in CUDA 2026-07-15, closes
most of the practical gap at V0=0.09-0.10 — but a follow-up radius sweep
found it delays rather than eliminates the failure, which matters for how
it's used.** `kernel_ym_xicut` (unconditional zeroing of the outer region
every step, vs. the soft sponge's exponential damping — see §11 item 3b) at
radius 5 gives a genuine, plateau-verified measurement matching the
eigensolver to ~1% at both V0=0.09 (γ=0.1995 vs. 0.2016) and V0=0.10
(γ=0.2141 vs. 0.2163) — an accurate result in the exact regime the soft
sponge structurally could not reach (which never produced a clean plateau
at V0=0.10 at *any* radius, including its own floor). **But sweeping the
radius up (5.5, 6, 7, 10, 15) showed every one of those fails**, via a
distinctive sudden 4-6-order-of-magnitude jump (not smooth exponential
growth) after a long bounded stretch — and a cross-check at a *different*
(α, k_z) with the same xi_cut=5 also eventually hit this same jump, just
very late (t=97.7, barely inside a 100-TU run). **So xi_cut=5 is not a
stable fix, it's a much more effective delay**: the same underlying
instability that kills the soft sponge is still present, but pushed out far
enough (empirically 90-100+ TU, not guaranteed further) that a clean
plateau (established by t≈35-55, holding 15+ TU) completes with real margin
before it. 5× more hyperdiffusion did not fix it either, ruling out
"grid-scale noise from the wall's discontinuity" as the mechanism — what
actually causes the late jump is still unknown. **Revised practical
guidance**: use xi_cut=5 (not looser) for V0=0.09-0.10, and cap `target_tu`
well below the observed onset (comfortably <90 TU) rather than running to
the old energy-threshold default. Not yet done: characterize the jump
mechanism itself, map its onset-time dependence on (α, k_z) beyond one
cross-check point, test above V0=0.10, and re-verify the V0≤0.07 points
with xi_cut for the (still-valid) accuracy win.

**What the outer branch
physically *is* — a genuine secondary instability of the shear+Az1 background,
vs. a numerical artifact of the linearization/discretization, and why its rate
would scale with V₀ — is still not understood, and *why xi_cut succeeds where
xi_sponge fails* is now an equally sharp open question** — see the reminder
in §11 item 3b. A working fix is not the same as an explanation.

### 8.5 Growth-rate extraction: max-R² windows on multi-regime curves

`presentation/plots/fig11_growth_curves_C25.png`

The standard fitter (`fit_growth_rate` in `batch_analyze.py`, and the same idea
in `dispersion_ym.py`) scans all sliding windows and keeps the one with maximum
R². On curves with multiple growth regimes (§5.2: seed transient → plateau →
late decline) this criterion is **attracted to inflection points** — the
transition between two regimes is where the curve is locally straightest — so a
reported R² of 1.000 does not certify that the window sits on the physical
growth phase. Audited consequences on the flagship C25 series: two of six
windows landed cleanly on the plateau, three touched or straddled the late
kink, one (k_z=1) sat entirely in the post-kink regime, and k_z=6 — which has
no plateau at all — gave values differing by ~50% between two fitters. The
plateau in the local slope d ln A/dt is the fitter-independent quantity, and it
vindicates the C25 measurement for k_z=1–5 (§5.2) — but that audit has been done
for **one campaign of ~30**. Required before publication: (a) replace or
supplement max-R² selection with plateau detection (fit windows chosen by
flatness of the local slope, minimum plateau duration in e-folding times);
(b) re-audit every campaign whose numbers are quoted; (c) declare "no reliable
measurement" wherever no plateau exists (as at C25 k_z=6) instead of reporting
the best-R² number. Credit where due: this issue was caught by inspection of
the published growth-curve figure, not by the pipeline's own diagnostics —
which is precisely the problem.

### 8.6 Is "Kelvin–Helmholtz" even the right name?

The eigenmode frequently peaks far from the shear layer, at the Ω_A ≈ 0 surface
(fig08). The instability is driven by the shear flow (it vanishes as V₀→0) but
its spatial home and much of its character look like a background-resonant EM
mode. Without the energy-budget diagnostic (T1.5: Reynolds-stress drive vs
precession/coupling drive vs Poynting redistribution, per k_z) we cannot say
which fraction of the growth is "KH-like". This is a naming/framing risk for the
papers more than a correctness risk — but a referee who plots our own
eigenfunctions will raise it, so the diagnostic should exist before submission.

### 8.7 Smaller open flanks — Tier 2 of the roadmap (all eight ✅ as of 2026-07-19)

The full batch write-up is `REFEREE_PROOFING_RESULTS.md` (run on t126/t140/t133,
one experiment at a time; also includes the §8.8 overtone falsification and the
T2.7 sponge extrapolation reported in §8.3).

- ✅ **Complex frequency (T2.1) done (2026-07-19)**: the σ-chased dominant
  localised **complex** eigenvalue γ = Re(growth) + i·Im(freq) is now tabulated
  over α∈{1,1.5,2,2.5,3} × V₀∈{0.03,0.05,0.1} × k_z=1..8. The dominant KH branch
  is **essentially purely growing** — max |Im(γ)| over the whole grid = 9.6×10⁻³
  (|Im/Re| ≲ 6%), with the oscillatory content confined to k_z=1 at a few
  high-αV₀ points. This is why the circular-amplitude fits are unbiased in the
  production regime and pinpoints where (k_z=1, high αV₀) an envelope fit is
  warranted. `analysis/t2p1_t2p5_spectrum.py`.
- ✅ **Linearity check (T2.4) done (2026-07-19)**: γ=0.0901 invariant to seed
  amplitude ×0.1/×1/×10 (initial amplitude exactly linear, R²=1.000). See §7.
- ✅ **Eigenfunction overlay (T2.2) done (2026-07-19)** — the "money figure":
  at α=1, V₀=0.05, k_z=1 the simulation's linear-phase k_z=1 spatial profile
  traces the `ym_eigenmode.py` eigenfunction with **correlation 1.0000**, and
  By2 (grown from ~0 via the KH chain) reproduces the solver's non-trivial
  double-lobe shape and node. `plots/t2p2_eigenfunction_overlay.png`.
- ✅ **Resolution spot-checks at the extremes (T2.8) done (2026-07-19)** —
  **and they qualify the convergence claim**: the production grid is converged to
  <1% at the low-αV₀ corner (α=1, V₀=0.03, k_z=3) but **under-resolves γ by
  ~3–6% at the high-αV₀ corner** (α=3, V₀=0.10, k_z=5, the narrowest/fastest used
  mode at EPS/DX≈6.1) — courant 0.1→0.02 gives +5.9%, NX 768→1152 gives +2.7%.
  The "converged to ~2%" statement (anchored only at α=1, V₀=0.05, k_z=1) must be
  qualified to **~5% at high αV₀**; this is inside the 6–10% error budget already
  quoted for the high-α points. See RESOLUTION_FINDINGS.md and
  `plots/t2p8_resolution_extremes.png`.
- ✅ **Dimensionless collapse (T2.5) found (2026-07-19)**: masking the tachyonic
  outer branch (§8.2), the shear-layer KH peak collapses onto the exact-action
  ceiling — **γ_peak/(αV₀²)^{1/3} = 0.977 ± 0.011** (1.1% spread) across α∈[1,3],
  V₀∈[0.03,0.1] (10× range in αV₀). Plotting γ/(αV₀²)^{1/3} vs k_z/(α/V₀)^{1/3}
  folds all 15 curves onto one master curve. So α and V₀ enter through
  (αV₀²)^{1/3} (growth) and (α/V₀)^{1/3} (wavenumber), **not** αV₀ alone,
  empirically confirming the T1.2 ceiling γ³ ≤ αV₀². `plots/t2p5_collapse.png`.
- ✅ **Single EPS**: resolved by the T1.1 scan (2026-07-19, §5.3a) — and the
  answer went against the EPS-free claim; no longer a "flank", now a headline
  reframing.
- **2D geometry**: k_y modes (filamentation/Weibel out-of-plane) are excluded by
  construction; a linear solver with k_y ≠ 0 is the cheap check (T3.1). *(Still
  open — the only Tier-2-adjacent item not yet run.)*
- **Cold, non-relativistic, SU(2), classical**: acknowledged model boundaries;
  each has a roadmap item (T1.4, T3.3, T3.4) or an explicit scope statement.

### 8.8 Eigenmode-selection artifact: reference curves ride overtones at low α (found 2026-07-17)

The shear branch is a *ladder* of well overtones (n = 0, 1, 2, …, spaced a
few ×0.01 TU⁻¹ at loose windows), and `solve_eigenmode`'s default
shift-invert target σ = 0.55·γ_WKB(quartic) lands mid-ladder wherever the
quartic underestimates — i.e. exactly at low α and/or k_z above the
quartic's own peak. Concretely, at (α=1, V₀=0.05, k_z=4, window 20) the
dominant mode is γ = 0.134 (hard cut) / 0.131 (production sponge), but the
default-σ solve returns 0.106 and the cached C25 curve carries 0.082 — an
n≈3 overtone. Because production runs are *seeded with the eigensolver's
returned eigenfunction*, the simulation faithfully grew the same overtone
(plateau-audited 0.081): **the celebrated sim-vs-solver agreement certifies
the numerics, not dominant-mode selection.** The true C25-window peak is
k_z = 3.5 at γ = 0.135 (99% of the (αV₀²)^{1/3} ceiling), not k_z = 2 at
0.122. The α ≥ 2 series are unaffected near their peaks (the quartic is
accurate enough there for σ to land on n = 0). Affected artifacts:
eigensolver_grid_cache / exact_grid_cache (figs 03/04/05/13) at low α and
beyond-peak k_z, and the low-α end of fig05's k_z,peak ≈ 2α trend. Fixes:
σ-chasing is implemented (`analysis/exact_action_wkb.py::gamma_true`) — still
need to regenerate the caches with it. ✅ **CUDA falsification done (2026-07-19)**:
the C25 point (α=1, V₀=0.05, k_z=4, sponge=20) was rerun with two seeds differing
*only* in the eigenfunction — the default-σ overtone (γ_exact=0.0818) grows a
plateau of **0.0808** (reproducing the cached C25 = 0.081), while the σ=0.14
true-n0 eigenfunction (γ_exact=0.1309) grows **0.1287**. The simulation faithfully
grows whichever mode it is seeded with, so the celebrated sim-vs-solver agreement
certifies the numerics, not dominant-mode selection — exactly the diagnosis above.
See `REFEREE_PROOFING_RESULTS.md` §8.8.

### 8.9 The 2026-07-17 pipeline-bug event: 96% of the mid-July archive measured the wrong thing (and how it was rebuilt)

The single largest data-quality event in the program's history, found not by a
physics experiment but by asking "verify the measurement pipeline itself first":

- **Bug 1 — conjugate-helicity extraction.** A one-sign error introduced in the
  2026-07-04 stdlib-DFT rewrite of `remote_timeseries.py` made the extractor
  measure the (initially empty, machine-noise-level) *conjugate* helicity
  component instead of the seeded mode. Blast radius, measured by scanning
  first-amplitudes across all 7,909 archived timeseries: **7,589 (96%) tracked
  the wrong component** (everything extracted 07-04 → 07-17). Insidiously, in
  many regimes the wrong component is slaved to the growing mode and grows at
  the same γ — so fits looked clean and often agreed with theory — but it
  genuinely diverges exactly in the slow-growth/competing-mode regimes where
  the archive's "mystery buckets" lived. **The simulations were fine; the tape
  recorder was pointed at the wrong channel.** Field dumps are auto-deleted
  after extraction, so affected points needed reruns, not re-extraction.
- **Bug 2 — suspectfix box-size labels.** The suspectfix campaign generator
  never emitted its `lz_override`/`nz_override` lines, so every "half-tier"
  and "fine-tier" suspectfix run actually ran on the default Lz=2π box at 2×
  or 8× the labeled k_z. The earlier audits' "k_z<1 floor", "half-tier k_z=2.5
  undershoot" and "fine-tier 68% block" were bookkeeping artifacts stacked on
  Bug 1 — not sim deficiencies, not physics.
- **Validation of the fixes**: a 7-anchor campaign with the corrected pipeline
  resolved *every* stretched-box anomaly — genuine half/fine-box runs match
  the σ-chased eigensolver to 1–8% at integer and fractional k_z alike — and
  the investigation turned up the NZ/4.5 filter-band rule (§7) as a bonus.
- **Rebuild**: the recorrection + intkz campaigns (§5.8, fig18) re-measured
  the integer-k_z map with the fixed pipeline — ~1,500 clean-core points,
  median 9% against the σ-chased eigensolver, plateau-tagged per point.

Standing consequences: any number extracted between 07-04 and 07-17 is
untrustworthy unless its first-amplitude sanity check passes (log-amp ≈ −13,
not < −25); the pre-rebuild audits (§8.4's raw-table probes, the 07-17
full-archive audit) keep their *mechanism* conclusions but their per-point
numbers are superseded by `sweep/recorr_results.csv`. The "t140-vs-t136 2×
discrepancy" (§8.4, §9 Q18) is also resolved as moot — it compared a
wrong-helicity extraction against a correct one, so cross-node reproduction
was never actually tested; the corrected-pipeline campaigns now span 7
nodes/streams with consistent statistics, which is a stronger (if implicit)
cross-node consistency statement than the single-pair test ever was.

---

## 9. Anticipated questions, by audience

**[U] = student / non-plasma physicist, [P] = plasma theorist, [F] = field
theorist, [N] = computationalist.** Status tags: ✅ solid, ⚠️ partially resolved,
❌ open.

1. **[U] What plays the role of "fluid" here — isn't a plasma collisionless?**
   ✅ Cold-fluid equations are the exact moment closure of the Vlasov equation for
   a monoenergetic beam; each beam is such a fluid. Where the cold closure breaks
   (wave-particle resonance), we inherit the known pathologies — that is exactly
   the two-stream family we filter (§8.1) and the reason a warm closure is queued.

2. **[U] Why is the fastest wavelength interesting at all?**
   ✅ It is the observable: the pattern scale that would be imprinted on
   color-magnetic fields in any realization (QGP coherence length, dark-plasma
   field scale, spin-texture wavelength in the solid-state analog). Classical KH
   says "geometry decides"; this system says "coupling decides" — a qualitatively
   different, measurable statement.

3. **[U] What is a "frozen" background and why is it allowed?**
   ✅ §8.2. Standard external-field idealization, exact in the spin-orbit
   mapping — and now quantitatively checked here (T2.6, 2026-07-16): unfrozen
   runs grow at the same rate, and the back-reaction is quadratic
   (ΔA_z¹ ≈ −0.04·|a|²), wrong-signed for depletion, and ≲7% out to |a|≈2.5 —
   tested on the fastest, most background-coupled branch, a stricter test than
   the small-amplitude production KH fits require.

4. **[P] Your mode grows slower than instabilities you delete every step. Why
   should I believe it exists?**
   ✅ The central objection — now answered by experiment (§5.7, §8.1). With
   *all* filters off, a warm plasma (v_th ≳ 2V₀) grows the mode at the
   filtered-cold theory rate (~1% at the peak), because pressure suppresses
   the fast cold-beam channels the filters used to remove. The deleted modes
   are demonstrated cold-beam pathologies; the measured mode survives their
   removal by physics, not by construction. (The one wrinkle: the *cold*
   filters-off control is contaminated and reads low — the correct comparison
   is warm-vs-theory.)

5. **[P] Two-stream at kz≤14 was filtered — but your target modes live at
   kz=1–10. How do you know the filter doesn't touch the physics?**
   ✅/⚠️ The band-stop filter always *excludes* the target k_z (it removes
   k_z = 1..k−1 and k+1..14, keeping k). The eigensolver — which has no filters —
   agrees with the filtered simulation to a few percent, which is strong evidence
   the filter is not creating or reshaping the measured mode. Caveat: modes with
   strong harmonic content (nonlinear stage) are affected by construction; only
   linear-phase fits are quoted.

6. **[P] How is the sponge not just an absorbing wall that you tuned until you
   liked the answer?**
   ⚠️ It is tuned — against a documented, physics-derived rule
   (γ_outer(edge) ≤ 1.5 TU⁻¹) — but that rule was found (2026-07-14) to not
   actually hold at low k_z/low α·V₀: the production formula's own cap let
   outer-branch eigenvalues up to γ≈1.4 sit inside the "designed" sponge, and
   this directly explains a large fraction of the raw sweep table's
   contamination (§8.4). A corrected, eigensolver-verified per-point tool now
   exists and is confirmed by direct CUDA rerun for V₀≲0.05; it does not work
   at V₀≳0.10 (still fails even at the tightest sponge tried) — so this
   question is **not fully answered**, it is answered for part of the grid and
   openly unresolved for the rest (§11 item 3b — the V₀-scaling itself was
   later identified as amplitude competition with density cavitation, not an
   outer-region effect). The extrapolation ξ_sponge → ∞ is now done (T2.7,
   2026-07-19, §8.3): γ rises monotonically with sponge radius and saturates
   by ξ≈16 (<2% thereafter; ξ=6 compresses by 28.5%) — production sponges
   sit in the single-digit-% compression regime, and the compression is a
   quantified systematic, not a tunable. Points where the sponge binds are
   flagged, not hidden.

7. **[P] What is the actual free-energy source — shear, or the frozen field?**
   ❌ Open = §8.6. The drive vanishes with V₀, but the spatial structure is
   background-resonant. T1.5 (energy-transfer budget) will answer it; until then
   we say "shear-driven non-Abelian mode" rather than claiming classical-KH
   character.

8. **[P] Landau damping / kinetic effects?**
   ⚠️ Absent by construction (fluid). For the cold beams the fluid description is
   exact until wave-particle resonances matter; the Wong-particle validation
   (T3.2) is the planned kinetic check at one parameter point.

9. **[P] Why quote growth rates from initial-value runs at all when you trust an
   eigensolver — and vice versa?**
   ✅ Deliberate redundancy: the 1D solver can host spurious modes (sponge
   boundary modes were found and diagnosed); the 2D code confirms which
   eigenvalue is physically selected from realistic initial data, and adds the
   nonlinear-saturation capability the solver lacks. Their few-percent agreement
   is the cross-check.

10. **[P] Is Im(γ) handled? A rotating mode fit as a pure exponential
    underestimates γ.**
    ⚠️ Yes where known: fits use the circular amplitude whose modulus is immune
    to phase rotation; campaigns with strongly oscillatory eigenvalues (C19b,
    C20b) are documented as unreliable rather than quoted. Systematic Re(ω)
    reporting is pending (T2.1).

11. **[F] The A_x=0 gauge — are results gauge-invariant?**
    ✅/⚠️ The dispersion relation and growth rates are properties of
    gauge-invariant perturbations (By^a enters through the field strength; the
    measured energy growth is gauge-invariant). The *decomposition* into
    color-1/2/3 is background-gauge-dependent language. A short gauge-invariance
    statement should be written for the paper (cheap theory task, not yet done).

12. **[F] Classical Yang–Mills — where is ℏ, and does classical SU(2) even make
    sense as a plasma?**
    ✅ Same regime as all chromo-Weibel/glasma literature: large occupation
    numbers / classical statistical approximation, colored particles via Wong
    equations (whose fluid moments we evolve). SU(2) vs SU(3) is a mechanical
    extension (T3.4); no qualitative change expected for a single dominant
    background component.

13. **[F] Why 2D? Non-Abelian dynamics in 2D can differ from 3D qualitatively.**
    ⚠️ Acknowledged. In-plane (x,z) captures the shear-precession coupling; the
    known dangerous out-of-plane competitor is filamentation at k_y ≠ 0. Cheap
    check queued (linear solver with k_y; T3.1) before any 3D investment.

14. **[F] Your quartic (eq. 33) — where does it break, and is the exact solver
    the same physics or different?**
    ✅ Same linearized physics, no WKB approximations (no parabolic well, no step
    velocity, exact Doppler terms, sponge included). The measured WKB error
    (median ~2×, up to 20× at low k_z, sign flip in the weak-coupling corner) is
    a *result*, not an embarrassment — fig07 — and as of 2026-07-17 a *diagnosed*
    one: the quartic's drive term −α²V₀k_z does not match the exact beam
    response; the exact-action theory (§5.4, PHYSICS.md §11) replaces it and
    matches the eigensolver to ≤2%.

15. **[N] FCT is diffusive at sharp fronts. Is the shear layer resolved and does
    FCT damping fake a growth-rate reduction?**
    ✅ Convergence study: γ flat over 4× in DX with EPS/DX ≥ 6; the coarse-DX
    failure mode is documented (3–4% low at EPS/DX≈3). All production runs sit in
    the converged regime.

16. **[N] Spectral filters + FCT + leapfrog: any aliasing or filter-Nyquist
    interactions?**
    ⚠️ Two, both found the hard way and both now encoded as rules. (1) NZ=32
    places the filter band edge at Nyquist and collapses γ — hence the NZ=64
    floor. (2) 2026-07-17: extending the band-stop's upper edge into the
    grid's dispersive tail damps the *kept* mode (the FCT limiter deposits
    mode-correlated content at near-Nyquist wavelengths every step; zeroing
    that band acts as strong effective damping) — hence
    **kz_suppress_hi ≤ NZ/4.5**, verified scale-invariant at NZ=64/128/512
    (§7). Inside those rules, NZ=64/128/256 agree to 0.1%.

17. **[N] The leapfrog does not preserve the non-Abelian Gauss constraint. How
    big is the violation and does it grow?**
    ⚠️ Measured (fig09): relative residual ~10⁻³ through production runs, growing
    with the mode amplitude, localized at the mode. Small, but the promised
    referee-proof figure and a bound-vs-time statement (T2.3) remain to be
    finalized. A constraint-preserving scheme was consciously not attempted.

18. **[N] ~10,000 runs on shared university GPUs — how do you know a given batch
    ran the binary/config you think it did?**
    ✅/⚠️ Three incidents (stale binary, stale extraction script, and the big
    one — the 2026-07-17 conjugate-helicity extraction bug that silently
    invalidated 96% of two weeks of timeseries, §8.9) led to hard rules:
    rebuild + 1-TU smoke test after every source sync; md5-verify analysis
    scripts per node; directory-name encodes the full parameter set (now
    including NX/Lx overrides); first-amplitude sanity check on every
    extracted series; runs re-extractable from raw CSV dumps where kept. The
    honest lesson a referee should hear: the pipeline was audited *because*
    the numbers looked fine, and that audit is what caught the bug. The old
    "t140-vs-t136 2× discrepancy" dissolved with it (§8.9); the corrected
    archive spans 7 nodes with consistent statistics.

19. **[N] Your legends say R² = 1.000 everywhere. Isn't that meaningless — the
    curves visibly have several linear regimes, and some fit windows sit right
    on the transitions?**
    ⚠️ Correct, and this was caught by exactly that observation (§8.5, fig11).
    R² over a max-R²-selected sliding window certifies local straightness, which
    near a smooth regime transition is guaranteed, not informative. The
    defensible quantity is the plateau of the local slope d ln A/dt; the C25
    audit shows the plateau matches the eigensolver to 0.7–3.6% for k_z=1–5 and
    exposes k_z=6 as having no measurement at all. As of 2026-07-19 the
    corrected-pipeline refits run a plateau detector on every point and store
    the result (`has_plateau`); quoted statistics separate plateau-confirmed
    from best-window-only populations (§5.8), and "no plateau" is reported as
    such rather than papered over with an R².

---

## 10. What this connects to (the six systems, one line each)

Full mappings in `../RESEARCH_ROADMAP.md` Part II.

1. **Dark-sector plasma in cluster mergers** — non-relativistic, cold,
   counter-streaming: the code's regime *is* the physical regime; the saturated
   drag rate (needs T1.6) converts to a σ/m-style exclusion statement. Abelian
   version exists in the literature; non-Abelian appears open. ⭐ quantitative target.
2. **Spin-orbit-coupled electron fluids** — exact gauge-theory mapping where
   frozen A_z¹ is *physically exact*; fully developed as its own program with a
   pivoted headline result: see `../spinkh/PRESENTATION.md`. ⭐ theory follow-up.
3. **Quark-gluon plasma / glasma** — "the shear-flow counterpart of
   chromo-Weibel"; motivation-level now (γ ~ 0.1 ω_p ⇒ few fm/c: marginal but not
   dismissible); quantitative claim needs relativistic SU(3) (T3.3/T3.4).
4. **Two-component BECs with synthetic SU(2) gauge fields** — tabletop analog;
   coupling-selected stripe wavelength tunable by Raman power at fixed flow — a
   clean experimental discriminator if the numbers survive the healing-length check.
5. **Early universe** — EW-plasma shear flows at bubble walls (GW source term);
   axion–SU(2) backgrounds as the cosmological cousin of frozen A_z¹.
   Motivation paragraphs only.
6. **Neutron-star mergers with quark matter** — one closing sentence; speculation
   stacked on speculation; explicitly kept out of abstracts.

**Publication plan** (roadmap Part III), updated 2026-07-19: Letter A's
original headline ("coupling-selected wavelength") **did not survive the EPS
scan** (§5.3a) — the Letter must be re-founded on what did survive: the
exact-action selection law with its confirmed collapse (γ ceiling (αV₀²)^{1/3}
at 0.977±0.011, k_z scale (α/V₀)^{1/3}) plus the measured, weak,
theory-unexplained EPS drift as the honest boundary of the claim; that
re-founding is blocked on the EPS-dependent theory term (§11 item 1) and the
cache regeneration (§8.8). Full linear paper B is in markedly better shape
than a week ago: warm closure done (T1.4 ✅), all Tier-2 referee-proofing done
(✅), corrected integer-k_z map at 8–9% (§5.8) — remaining blockers are the
intkz completion (146 runs) and the warm eigensolver. Nonlinear paper C
(Kolmogorov flow, T1.6) and applications D/E unchanged.

**Novelty survey (2026-07-18, `../LITERATURE.md`)**: ~11 targeted searches
found no prior KH/shear-driven non-Abelian plasma instability work — the
configuration, the dispersion program, and the selection law all appear
unclaimed. Closest prior art, now on the must-cite list: Manuel–Mrówczyński
chromohydrodynamics (colored two-fluid equations + two-stream, no shear),
the Nielsen–Olesen family (our outer tachyonic branch belongs to it —
§8/PHYSICS §10a now say so), the Abelian EMHD-KH lineage (Das & Kaw), and
Csernai's Abelian KH in QGP. Two urgency signals: dark-U(1) merger-plasma PIC
reached the nonlinear/σ-m stage in 2025 (arXiv:2411.11958) with non-Abelian
flagged as future work, and BEC counterflow-KH published a three-component
generalization in 2026 — neighboring fields are moving toward the same ground.

---

## 11. Priority list — what would most improve this work now

Updated 2026-07-19 after the EPS-scan/warm-closure/referee-proofing wave. In
order of leverage per unit effort:

1. **EPS-dependent term in the exact-action theory** (theory-only). The scan
   (§5.3a) falsified the EPS-free peak law; the eigensolver reproduces the
   drift, so the missing physics is *in the linear model already* — find which
   term carries it (candidate: the finite-width correction to the v³ drive /
   well shape), and re-derive k_z,peak with it. The Letter's claim structure
   depends on this answer. Also explain the ~30–40% rise of γ at fixed k_z
   with EPS.
2. **Warm eigensolver** (add isothermal-pressure terms to `ym_eigenmode.py`;
   small). Turns the T1.4 validation (§5.7) from warm-sim-vs-cold-theory into
   warm-vs-warm, and should explain the flat warm profile + the k_z=1 excess.
3. **Finish the corrected map**: run the 146 owed intkz points
   (`sweep/intkz_remaining.csv`, currently on user hold), then regenerate the
   eigensolver caches with σ-chasing (§8.8) so figs 03/04/05/13 stop carrying
   overtone values, and re-cut figs 03–07 from `recorr_results.csv` instead of
   the legacy sweep tables. Re-derive the sub-k_z=1 claim from the solver
   continuation (T1.3) on corrected data. Mostly mechanical, required before
   any public number.
1–3 (old numbering) are **done**: ✅ T1.1 EPS scan (§5.3a — answer: drift is
   real, headline reframed), ✅ T1.4 warm closure (§5.7 — filters vindicated),
   and the fit-methodology/curation program is superseded by the §8.9 rebuild
   (plateau detection + vetted sponges are now the pipeline default; the
   t140-vs-t136 discrepancy dissolved with the helicity bug).
3b. **✅ RESOLVED 2026-07-15 — see `OUTER_REGION.md` (summary) and FINDINGS.md
   §"Outer-region growth rates: mechanisms identified" (full numbers),
   PHYSICS.md §10 (derivations).** Two separate mechanisms were conflated:
   (i) the loose-window contamination is a genuine linear *tachyonic
   charged-wave instability of the frozen Az1 background* (γ²=α²Az1²−kz²
   where |αAz1|>kz — the WKB well's own trapping term past its rim; physical
   in-model, not numerical, correctly excluded by windowing); (ii) the late
   catastrophe below (incl. the V₀≥0.08 "hard wall") is **not outer-region
   at all** — it is density cavitation of the physical KH mode at the shear
   layer (nA hits the 0.05 floor ~35 TU before the terminal jump; amplitude
   threshold confirmed across sibling runs; eigensolver blind by
   construction — no fluid dof). The V₀-scaling question is answered
   (amplitude competition: cavitation vs benign saturation), and the §5.1
   Weibel-scaling speculation below is moot. Original open-question text
   kept for context:

   **⚠️ REMINDER (superseded) — understand the outer-region EM instability itself, not just
   dodge it (§8.3, §8.4).** `xi_cut` (hard-wall Dirichlet BC), implemented in
   CUDA and tested 2026-07-15, **substantially outperforms the soft sponge at
   V₀=0.09-0.10 but does not eliminate the failure — it delays it**, by a lot.
   At radius 5 it gives a clean, plateau-verified measurement matching the
   eigensolver to ~1%, well before an eventual sudden (not smooth) failure
   whose onset a radius sweep placed anywhere from t≈27 (radius 15) out past
   t≈90-100 (radius 5, not reliably past 100 — a cross-check point at a
   different (α,k_z) hit it at t=97.7). The soft sponge, by contrast, never
   produced a clean plateau at V₀=0.10 at *any* radius. So the practical
   value is real (an accurate measurement with margin, where sponge gave
   none) but the framing must be "delays a shared failure mode far past the
   measurement window," not "solves it." `xi_cut` is also strictly more
   accurate than `xi_sponge` at matched radius everywhere tested (4-30% less
   compression). That the *same* late failure shows up under both mechanisms
   — just far later under the hard wall — is itself informative: it argues
   against "soft damping leaks, hard wall doesn't" as the explanation, and
   for something more fundamental (a genuine finite-amplitude/nonlinear
   effect, or something else) whose growth rate depends on how much outer
   region is left uncontained, regardless of *how* it's excluded. Tried and
   ruled out: 5× more hyperdiffusion doesn't fix the hard-wall failure either
   (only delays it slightly), so it isn't simple grid-scale noise from the
   wall's field discontinuity. Also still unknown: is the outer branch a
   genuine secondary instability of the shear+Az1 background or a numerical
   artifact of the linearization/discretization, and does its V₀-scaling
   relate to the γ~(α³V₀²)^(1/3) Weibel scaling of the k_z=0 mode in §5.1,
   evaluated in the outer region instead of the shear layer? Don't let
   "xi_cut gives a good measurement" become "the outer branch is understood,"
   or even "V₀=0.09-0.10 is safe to run long" — it's a working, well-
   characterized mitigation for extracting one clean plateau, not a stability
   fix or an explanation.
4. **✅ RESOLVED 2026-07-19 — T2.x referee-proofing batch** (+ the §8.8 overtone
   falsification): all eight run on the free teaching nodes t126/t140/t133 and
   documented in **`REFEREE_PROOFING_RESULTS.md`**. Linearity (γ invariant to seed
   ×100), eigenfunction overlay (corr=1.000), Gauss-law figure (abs residual
   ~1e-5), complex-ω table (dominant branch purely growing), dimensionless
   collapse (γ_peak/(αV₀²)^{1/3}=0.977±0.011), sponge extrapolation (28.5%
   compression at ξ=6, saturates by ξ≈16), and overtone falsification (plateau
   0.081→0.129 on reseed). **One new caveat surfaced (T2.8)**: the convergence
   claim degrades from <1% at low αV₀ to ~5% at the high-αV₀ extreme — see §8.7
   and RESOLUTION_FINDINGS.md. Remaining: regenerate the eigensolver caches with
   σ-chasing (§8.8).
5. **✅ RESOLVED 2026-07-17 — T1.2 exact-action WKB** (theory): done — see
   §5.4, PHYSICS.md §11, `analysis/exact_action_wkb.py`,
   `plots/exact_action_wkb_validation.png`. Delivered: exact scalar
   reduction of the 6-field system (machine-precision equivalent); hard
   growth ceiling γ³ ≤ αV₀²; exact-action quantization matching the
   dominant eigensolver branch to ≤2%; closed-form dispersion; and the peak
   law k_z,peak ≈ αV₀(ξ_w − ln2) + (α/V₀)^{1/3} — the peak is
   confinement-set, not intrinsic (§5.3 note). Also delivered the T2.5
   collapse variables ((αV₀²)^{1/3}, (α/V₀)^{1/3}, αV₀ξ_w) as a by-product.
   New follow-ups it created: the §8.8 overtone artifact (regenerate caches
   with σ-chasing; one cheap CUDA reseed check) and the Letter's framing
   change ("coupling + containment radius select the wavelength").
6. **T1.5 energetics** (post-processing): settles the naming question (§8.6).
   Half the tooling now exists — `analysis/diagnose_warmclosure_channels.py`
   (§5.7) already computes per-channel energies against snapshots; what
   remains is the drive-term decomposition (Reynolds stress vs precession vs
   Poynting) rather than channel bookkeeping.
7. **T1.6 non-Abelian Kolmogorov flow** (new equilibrium; the nonlinear paper):
   removes the frozen-background and sponge caveats *simultaneously* (the
   former is already quantitatively bounded by the T2.6 test, §8.2), and its
   saturation outputs feed the dark-matter application.

---

## 12. Reproducibility quick reference

- Build: `make` in `ymgpu2d/` on any node (auto-detects sm_*); binary takes one
  `.ini` (see `example.ini`). **Always rebuild + 1-TU smoke test after syncing
  source to a node.**
- A full k_z=1..8 dispersion sweep at one (α, V₀): generate seeds with
  `analysis/ym_eigenmode.py --export-seed`, launch the campaign script
  sequentially (never parallel on one GPU), ~15 min wall time.
- Analysis: `analysis/remote_timeseries.py` on-node → rsync `timeseries_k*.csv`
  → `analysis/batch_analyze.py` → `analysis/make_sweep_tables.py --fill`.
- Presentation figures: `python3 presentation/make_plots.py` (figs 01, 03–07,
  11–15 regenerate from the npz tables, `batch_best.csv`, the t136 timeseries
  mirror, and the FINDINGS master table; figs 16–18 regenerate from
  `sweep/epsscan_results.csv`, `sweep/warmclosure_results.csv` and
  `sweep/recorr_results.csv` — those CSVs are themselves rebuilt by
  `analysis/measure_epsscan_accuracy.py` / `measure_warmclosure_accuracy.py`
  from the fetched timeseries, and by `analysis/recorr_collect.py`; the
  remaining figures are curated copies from `plots/`, including
  `t2p*_*.png` (referee-proofing batch), `kz0v3_relerr_map.png` /
  `kz0v4_valley_detail.png` (kz=0 bias map) and
  `epsscan_eigensolver_prediction.png`).
