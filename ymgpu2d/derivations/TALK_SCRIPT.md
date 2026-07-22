# Speaker script — "The Non-Abelian Kelvin–Helmholtz Instability"

For `presentation_summary.pdf` (21 slides). Target **35 min** at a comfortable pace;
§Cut-list brings it to 30, §Stretch material fills 40+. Times in brackets are
[slide budget / cumulative clock]. Spoken text is written to be said aloud —
rephrase freely, but every number in it matches the deck as of 2026-07-22 (post-fix).

**One-sentence thesis (memorize):** *A genuinely shear-driven instability of a
non-Abelian plasma, reduced exactly to a single ODE, with a growth-rate ceiling
γ³ ≤ αV₀² and a wavelength selected by coupling and confinement — not by the flow
profile — confirmed on over a thousand GPU runs.*

---

## Slide 1 — Title [0:30 / 0:30]

**Say:** Thank you. Today I want to show you a plasma instability that, as far as
we can tell, has not been described before: the non-Abelian analogue of the
Kelvin–Helmholtz instability. The talk has two halves — an analytic theory that we
can push all the way to exact results, and a large GPU simulation campaign that
tests every one of those results. I'll keep the two interleaved: each time the
theory makes a claim, I'll show you the data that checks it.

**Transition:** So first — why this problem.

## Slide 2 — Motivation [2:30 / 3:00]

**Say:** The classical Kelvin–Helmholtz instability is textbook physics: two fluid
streams sliding past each other, the interface rolls up. Every plasma physicist
knows it. But now let the two streams carry *color* charge, and let the field
between them be a non-Abelian gauge field. That situation is physically relevant
anywhere colored matter flows with shear — the electroweak plasma of the early
universe, the quark–gluon plasma in heavy-ion collisions, and proposed dark
non-Abelian sectors.

And here is the surprising gap: there is no prior treatment of a genuinely
*shear-driven* non-Abelian instability. The literature has two-stream-driven color
instabilities — Manuel and Mrówczyński — and the anisotropy-driven chromo-Weibel
family. Neither is shear. We did a systematic literature search; the shear-driven
case with a full wavenumber map appears to be genuinely open.

**Emphasize:** the green box — this is the roadmap. Derivation from first
principles → exact reduction to one ODE → a growth ceiling and a
wavelength-selection rule → confrontation with GPU data. Four beats; the talk
follows them in order.

**Transition:** Let me define the system precisely.

## Slide 3 — The simulated system [3:00 / 6:00]

**Say:** The model is deliberately minimal but fully non-Abelian. Geometry: 2D, x
across the layer, z along the flow. Two cold fluid beams, A and B,
counter-streaming: beam A moves at +V₀ tanh ξ in z, beam B at −V₀ tanh ξ — a
single shear layer at ξ = 0. Beam A carries color charge +1 along the color-1
axis, beam B carries −1. The gauge sector is SU(2): for each of the three colors,
fields Eₓ, E_z, B_y, and the potential A_z.

Walk the equations briefly [point as you go]: top row is standard fluid —
continuity and momentum with the color Lorentz force summed over colors. The color
charge itself *precesses*: ∂ₜQ = α v_z (Q × A_z) — that's pure non-Abelian
physics, charge is not a scalar here. Bottom rows are Maxwell plus the commutator
terms: Ampère picks up −α(A_z × B_y), Faraday picks up +α(A_z × Eₓ). Set α = 0 and
every arrow of new physics disappears.

One background object matters throughout: the frozen potential
A_z1 = −V₀ ln cosh ξ, and I'll always quote it through u(ξ) ≡ −α A_z1 ≥ 0 — think
of u as "how strong the color background is at position ξ." It grows linearly in
|ξ| away from the layer.

**If asked why A_z1 is frozen:** it's the standard linear-analysis device — a
prescribed background, like a fixed magnetic field in MHD stability theory; the
kz=0 anchor was *also* reproduced on a fully unfrozen configuration (comes on
slide 6).

**Transition:** Linearize around this and something clean happens.

## Slide 4 — The six-field linear system [2:00 / 8:00]

**Say:** Perturb in the color-2/3 sector — those two colors are the ones charged
±1 under the residual color-1 symmetry the background leaves unbroken. The linear
dynamics closes on just six complex fields: the magnetic perturbation b, the two
electric components, the potential a, and one color-charge perturbation per beam.

The structure to notice [point at the right side]: the background enters only
through two *shifted wavenumbers*, Ω_A = k_z − u and Ω_F = k_z + u. Ampère sees
Ω_A, Faraday sees Ω_F. That asymmetric shift is the covariant derivative in
disguise — it is *the* fingerprint of the non-Abelian coupling, and everything in
this talk flows from it.

This six-field system is not just formal: solved as an eigenvalue problem, it
agrees with the full nonlinear 2D simulation at the 1–4% level on the core
validation series, and 4–9% median over the entire wavenumber map. So when I
manipulate these six equations analytically, I'm manipulating something the
simulation has already certified.

**Transition:** First manipulation: freeze the background locally.

## Slide 5 — Two branches [2:30 / 10:30]

**Say:** Freeze u and v at their local values and Fourier-transform. The system
factorizes into two independent blocks — two instability branches from one
background.

The electromagnetic pair (b, eₓ) gives γ² = −Ω_A Ω_F = u² − k_z². Wherever the
background shift u exceeds the wavenumber, one circular polarization goes
*tachyonic*. This is flow-independent — it would grow with V₀ = 0 velocity if the
potential were still there. It's a Nielsen–Olesen-class instability: a charged
vector field on a strong color background. That's the *outer* branch, living far
from the layer where u is large.

The charge block gives the branch we care about: γ² = −g, where g is a
*resonance* — look at the denominator, γ² + v²Ω_A². The flow shakes the beams'
color charges at their local precession frequency; the two beams respond
differently because they stream oppositely; and their *difference* current feeds
back into the field. That loop is the non-Abelian Kelvin–Helmholtz mechanism, and
it lives *inside* the layer where the flow varies.

**Emphasize:** one background, two fates — outer tachyonic, inner shear-driven.
The talk is about the second, but the first sets the boundary conditions.

**Transition:** Before any hard analysis — one exact anchor.

## Slide 6 — The k_z = 0 anchor [2:00 / 12:30]

**Say:** At k_z = 0 the shear-branch dispersion relation collapses to a cubic with
a closed-form root — the boxed formula, growth rate (√(α³/2) V₀)^(1/3) times
sin 60°. No fitting, no approximation.

Physically this limit is *filamentation*, not bunching — nothing varies along z;
the background rotates the two transverse colors into each other while the
counter-streaming currents pump energy in. It's a member of the chromo-Weibel
family, arising here as the k_z → 0 endpoint of our shear branch — which is
exactly where our story attaches to known physics.

And it is our cleanest validation: at α = 2, V₀ = 0.1 the simulation gives
γ = 0.5039 against the predicted 0.5065 — half a percent, over *nine decades* of
exponential growth. This one number exercises every non-Abelian term in the code
simultaneously — both commutator terms, the precession, the full feedback chain —
at the one point where the theory has no slack. And it reproduces on a second,
fully independent configuration — unfrozen background, live color-1 — three weeks
and many campaigns apart.

**If asked for the second configuration's numbers:** α = 1, V₀ = 0.05, γ = 0.284,
matching the same formula.

**Transition:** Now the central analytic result.

## Slide 7 — Reduction to a single ODE [2:30 / 15:00]

**Say:** Here is the structural gift of this system: among the six fields there is
only one chain of spatial derivatives. Every field is algebraic in terms of a(x),
the potential perturbation. Eliminate them all and the entire linear problem
becomes one second-order ODE — the boxed equation. This is *exact*, not WKB, not
an approximation: solving it reproduces the six-field eigenvalues to better than
10⁻¹⁰ relative.

Two functions control everything. 𝒟(x) = γ² + k_z² − u² changes sign precisely
where the two branches of the previous slide meet: 𝒟 > 0 is a trapped shear well,
𝒟 < 0 is the tachyonic outer region. And g(x) is the only *drive* — and notice it
dies as v³ at the layer center. The physics: to extract energy the wave must shake
the charges, get the two beams to respond *differently*, and collect that
difference as a current — all three factors need flow.

**Emphasize [pointing at fig_anatomy]:** well in the middle, tachyonic walls
outside — the mode is a trapped state in this landscape.

**Transition:** From this ODE, two hard predictions. First: how fast can it grow?

## Slide 8 — The growth ceiling [2:30 / 17:30]

**Say:** The drive g is a Lorentzian resonance in the local precession frequency,
and its peak value is G_max = αV₀²/γ. For the well to confine a mode at all you
need G_max > γ² somewhere. Put those together and you get the boxed inequality:
γ³ ≤ αV₀². A hard ceiling — independent of wavenumber, independent of the
shear-layer width.

The mechanism deserves a sentence, because it's pretty: the resonance width is set
by γ itself. A faster-growing mode averages the drive over a broader band and so
extracts a *weaker* peak drive. The ceiling is the fixed point of that negative
feedback — the instability throttles itself.

And it is measured: in every simulated series we tested, the peak growth rate
comes in at 95–99% of (αV₀²)^(1/3). I'll show the quantitative version — fifteen
collapsed dispersion curves — in the data section.

**Transition:** The ceiling gives natural units. Rescale.

## Slide 9 — The universal well [1:30 / 19:00]

**Say:** Define Γ = (αV₀²)^(1/3) as the rate scale and K = (α/V₀)^(1/3) as the
wavenumber scale, and the drive becomes completely universal — α and V₀ drop out.
One well shape for the entire parameter space.

The headline: growth rates scale as (αV₀²)^(1/3), wavenumbers as (α/V₀)^(1/3) —
cube roots, *not* the naive product αV₀ you'd guess dimensionally. This is a sharp,
falsifiable scaling prediction, and the data section confirms both exponents
directly.

**Transition:** Second hard prediction: *which* wavelength wins.

## Slide 10 — Quantization of the shear well [2:00 / 21:00]

**Say:** The well turns out to be shallow — it accumulates less than a quarter
wavelength of phase. So this is not a cavity-mode count; the eigenvalue is fixed
by a *connection condition* at the well's edge — tan S = κ/k_edge, phase inside
matching decay outside. It behaves like a surface mode: the growth rate hugs the
ceiling, because a tiny drop in γ buys all the well depth the mode needs, while
the *wavelength* is set by the geometry of the confining window.

This quantization condition, solved exactly, reproduces the independently computed
six-field eigenvalues to two percent worst-case, 0.2% median, across a wide survey
of α, V₀, k_z. So we now have an analytic formula chain that *is* the linear
theory, not a cartoon of it.

**Transition:** And that chain says something genuinely strange.

## Slide 11 — No intrinsic wavelength maximum [2:00 / 23:00]

**Say:** Ask the classical question: which k_z grows fastest? Classical KH has a
famous answer — the shear width picks it. Here, in an unbounded domain, *there is
no answer*: the peak drive doesn't depend on k_z, the resonance just moves further
out as k_z grows, and γ climbs monotonically toward the ceiling forever. We tested
this directly — in an unbounded numerical solve, γ reaches 99.5% of the ceiling by
k_z = 10 with no turnover.

So the peaked dispersion curves you're about to see in the simulation data are
**selected by the box, not intrinsic to the flow**. [pause] I want to be upfront:
this is the single most counter-intuitive claim of the theory — which is exactly
why we designed direct tests for it.

**Transition:** If the box picks the peak, the theory must predict *where*.

## Slide 12 — The confinement-set wavelength [2:00 / 25:00]

**Say:** The resonance location moves outward linearly with k_z. The peak occurs
when the resonance reaches the confinement radius ξ_w — beyond that, the mode
can't reach its resonance anymore and rolls off. Setting resonance location equal
to ξ_w gives the boxed formula: k_z^peak = αV₀(ξ_w − ln 2) + c·(α/V₀)^(1/3), with
c = 1 — c absorbs the small quantization offset; empirically it sits between 0.85
and 1.0.

Look at what's *in* the formula: coupling and confinement radius. Look at what's
*not*: the shear-layer width. The flow profile does not select the wavelength.
This is the sharpest and most novel claim we have, and everything from here on is
about testing it.

**Transition:** So — the data.

## Slide 13 — Non-monotonic dispersion, real data [2:00 / 27:00]

**Say:** This is real GPU data, not a theory plot: measured growth rate versus k_z
at V₀ = 0.05, five values of the coupling. Two facts. Every curve peaks at an
intermediate k_z and rolls off on both sides. And the peak *moves with the
coupling*: k_z = 4 at α = 1, k_z = 5 at α = 4, at strictly fixed shear width.

Compare classical KH: it also has a peaked dispersion curve, but the peak is
nailed to the shear width — for this profile it would sit at the same k_z for
every curve. A peak that moves when you turn a *gauge coupling* knob, with the
flow untouched, has no classical analogue.

**If asked about the α = 3 curve's dip at k_z = 4.5–5:** two points on that series
have fit-quality issues that passed the automated gate (visible as the jagged
notch); the peak identification at k_z = 4 is from the plateau-confirmed best fits
and the neighboring points rebound smoothly — the theory curve through that series
is smooth.

**Transition:** Now the two dedicated tests of the selection law.

## Slide 14 — The peak tracks confinement [2:30 / 29:30]

**Say:** Two tests on this slide. First, the table: five series spanning α from 1
to 5, V₀ from 0.03 to 0.2, and confinement radii from 5 to 20 — measured peak
versus the formula, agreeing to a few tenths in k_z essentially everywhere. These
rows are a subset of an eleven-series comparison; the formula is verified to
within ±0.6 in k_z on all of them.

Second — and this is the cleanest single experiment in the talk — the *direct
window test*. Same coupling, same shear velocity, same everything, and we only
widen the confinement radius. The measured peak moves from k_z = 4.5 to 5.5; the
formula says 4.45 to 5.85. Nothing about the flow changed. The wavelength
followed the *wall*.

**Emphasize:** that is the smoking gun for "confinement selects, flow doesn't."

**Transition:** And the ceiling's scaling prediction?

## Slide 15 — The dimensionless collapse [2:00 / 31:30]

**Say:** Take fifteen independently-run dispersion curves spanning a factor of ten
in αV₀ — left panel, the raw curves, all different. Divide each by its predicted
ceiling (αV₀²)^(1/3) and rescale k_z by (α/V₀)^(1/3) — right panel: they collapse
onto one master curve. The peak heights land at 0.977 ± 0.011 of the ceiling — a
1.1% spread across the full factor-of-ten range.

This is simultaneously the cube-root scaling confirmed, the ceiling confirmed at
the two-percent level, and the universality of the rescaled well confirmed. One
plot, three predictions.

**Transition:** Beyond curated series — the whole map.

## Slide 16 — Full-map accuracy [1:30 / 33:00]

**Say:** The full survey: a grid over α, V₀ and k_z — 1087 of 1134 points measured,
96% coverage — each compared against the independently computed eigenvalue. Median
relative error 4–9% depending on V₀. And the residual error is understood: the
simulation sits systematically slightly *below* theory, a documented compression
bias from the absorbing boundary and finite fit windows — it's a measurement-side
effect, not missing physics. The agreement is map-wide, not cherry-picked anchors.

## Slide 17 — Independence from the shear width [1:30 / 34:30]

**Say:** Last stress test of the "flow doesn't matter" claim: vary the one thing
the theory says is irrelevant — the shear-layer width — over almost a factor of
five, 91 runs. Re-express everything in the single dimensionless group the theory
prescribes, and all of it collapses onto one universal curve, median error 9.9%.
The selection law survives with the layer width changed under it.

**Transition:** One more kind of evidence — not a rate, a *shape*.

## Slide 18 — The eigenfunction matches [1:30 / 36:00]

**Say:** Growth rates are one number per run; eigenfunctions are an entire
function. Left: the dominant field's spatial profile, simulation against theory —
correlation 1.0000 to four decimal places. Right, and this is the part I like: a
companion field that we seeded at less than one percent of the driving field's
amplitude, which grew entirely through the instability's own internal feedback
chain — and it independently develops the theory's non-trivial double-lobe shape.
The instability *built* the predicted structure on its own. You can't get that by
tuning a growth-rate fit.

**Transition:** Let me put the whole ledger on one slide.

## Slide 19 — Where this leaves the physics [1:30 / 37:30]

**Say:** [walk the table, one line each] The k_z = 0 rate: closed form, half a
percent. The six-field linear theory: 1–9% against simulation everywhere. The
scalar reduction: exact to 10⁻¹⁰. The ceiling: measured at 95–99%, with the
0.977 ± 0.011 collapse. The quantization: 2% worst case. And the selection law:
confirmed by the window test and the full map.

The one-sentence summary of the physics [read the bold text]: a shear-driven
non-Abelian instability, derived exactly and confirmed on over a thousand GPU
runs — coupling and confinement jointly select the wavelength; the flow profile
does not enter directly.

## Slide 20 — Context and next steps [1:30 / 39:00]

**Say:** Where does this sit? To our knowledge it's new — not a variant of a known
result. The nearest relatives: chromo-Weibel modes, which are anisotropy-driven,
and which we recover exactly as our k_z = 0 limit; the outer branch, which is
Nielsen–Olesen physics; and the Abelian shear instabilities of Das–Kaw and the
heavy-ion work of Csernai — the closest classical analogues, but with no
non-Abelian selection mechanism.

What remains before submission: a citation-trail audit, and a dedicated study of
the high-coupling regime — we currently keep it out of the headline claims while
we characterize its numerical behavior; I'd rather under-claim there than have a
referee find the edge for us.

## Slide 21 — Thank you [0:30 / 39:30]

**Say:** To sum up in one line: the theory is exact, it matches simulation at the
few-percent level, and it's been confirmed across the broadest parameter survey we
could build. Thank you — I'd welcome questions, and suggestions on where to push
next.

---

# Cut-list (→ ~30 min)

Cut in this order if running behind at the checkpoints:

1. **Slide 9** → 30 s: just state the two cube-root scalings, skip the figure walk. (−1:00)
2. **Slide 16** → 45 s: "96% of an 1134-point map, 4–9% median, bias understood." (−0:45)
3. **Slide 17** → 45 s: "91 runs, layer width varied ×4.5, one collapse curve, 9.9%." (−0:45)
4. **Slide 2** → 1:30: drop the literature detail, keep "no prior shear-driven work" + roadmap. (−1:00)
5. **Slide 6** → 1:15: drop the filamentation-mechanism paragraph, keep the formula + 0.5%. (−0:45)
6. **Slide 10** → 1:15: state the condition and the ≤2%/0.2% result, skip the surface-mode discussion. (−0:45)

**Checkpoints:** slide 6 done by ~13:00; slide 12 done by ~25:00; slide 15 done by
~32:00. If you're more than 2 min over at a checkpoint, apply the next cuts.

# Stretch material (→ 40+ min, or for a blackboard moment)

- **Slide 8, board derivation (2 min):** write g_max = αV₀²/γ (resonance peak of
  the Lorentzian at v Ω_A = γ, using v ≤ V₀), then confinement needs g_max > γ²,
  → γ³ < αV₀². Two lines; lands the ceiling viscerally.
- **Slide 3, activation chain (1 min):** draw
  b → e_z → a → q_A − q_B → current → b. "The loop the instability runs around;
  every arrow is one of the six equations."
- **Slide 13 (1 min):** note the ceiling rising with α across the five curves —
  the same (αV₀²)^(1/3) law visible *within* this single plot.

# Q&A bank

**Q: The background A_z1 is frozen — is any of this self-consistent?**
Freezing is the standard linear-stability device (fixed background, like
tension in a string problem). Three defenses: (1) the k_z = 0 anchor reproduces on
a fully *unfrozen*, color-1-live configuration (γ = 0.284 at α = 1, V₀ = 0.05,
matching the same closed form); (2) all growth rates are measured strictly in the
linear window, where backreaction is second-order; (3) the full deck has a
dedicated backreaction budget slide (fig_budget/fig_backreaction) if they want it.

**Q: Correlation "1.0000" — really?**
To four decimal places, on the dominant field's full spatial profile
(peak location matches too). The stronger evidence is deliberately the *companion*
field: seeded < 1%, grew its double-lobe shape purely through the feedback chain —
structure we did not put in.

**Q: What is ξ_w physically? Isn't "the box picks the wavelength" a numerical artifact?**
Inverted: the theory *predicts* the finite-domain peak and predicts no peak in the
unbounded problem — and both are confirmed (window test; unbounded solve reaching
99.5% of ceiling at k_z = 10 with no turnover). Physically ξ_w is whatever bounds
the coherent background-field region — system size, background coherence length.
The transferable statement: the selected wavelength carries information about
*confinement and coupling*, not about the shear profile. In any real system the
background is finite, so a selection always happens — but by the extrinsic scale.

**Q: Why does the α = 3 curve on slide 13 have that notch at k_z ≈ 4.5–5?**
Two points with degraded fit quality that passed the automated ratio gate. The
peak call at k_z = 4 uses plateau-confirmed best fits; neighbors rebound smoothly;
the eigensolver curve through the series is smooth. Map-wide, such points are
inside the quoted 4–9% median.

**Q: Single precision, FCT scheme — how do you trust γ to a few percent?**
Dedicated convergence study: resolution halved/doubled and timestep pushed 8×
with γ stable at the 2% level; energy conservation clean; growth measured over up
to nine decades; linearity checked over a 100× seed-amplitude range (γ invariant).
Known limit: α ≲ 0.2, where the seed decays into the float32 noise floor before
growth is visible — those points are excluded, not extrapolated.

**Q: Is this gauge-invariant?**
Work in a fixed gauge (Aₓ = 0, frozen background along color-1). The measured
quantities are growth rates of field *energies* in the color-2/3 sector —
gauge-covariant under the residual symmetry. The two branches map onto known
gauge-invariant physics in their limits (Nielsen–Olesen; chromo-Weibel).

**Q: Relevance to actual QGP? This is classical, cold, 2D, SU(2).**
It's a minimal model, and we claim the *mechanism and scaling laws*, not QGP
numbers: the cube-root scalings γ ~ (αV₀²)^(1/3), k ~ (α/V₀)^(1/3), the ceiling,
and confinement-set selection are structural results that survive
dimensional/extension changes better than any absolute rate would. 3D and SU(3)
are the natural follow-ups.

**Q: What happens at α → 0 — do you recover classical KH?**
No — the branch we study *is* the non-Abelian coupling at work: γ → 0 as α^(1/3).
Classical hydrodynamic KH lives on fluid inertia at a contact discontinuity, a
separate sector here (and our beams interpenetrate rather than form one sheared
fluid). "KH" refers to the shear-driven character, and slide 13's contrast is
exactly the point where the analogy is sharpest and breaks most usefully.

**Q: Why is 4–9% the map-wide error when the anchors are sub-percent?**
The map's residual is dominated by a *known, one-signed* measurement bias:
absorbing-boundary compression plus finite fit windows push γ_sim 5–20% low. The
anchors avoid this (k_z = 0 needs no window/sponge care). Direction and mechanism
are documented; the bias narrative is itself tested by the sponge-extrapolation
experiment in the full results document.

**Q: What's in the excluded high-coupling regime?**
At α ≳ 6 the runs develop a late-time numerical catastrophe whose onset moves
with timestep refinement — so we don't yet trust its physics either way, and it
stays out of the headline claims until it's characterized. Everything quoted today
is from the regime where refinement changes nothing.

**Q: Two counter-streaming beams — why isn't this all just two-stream instability?**
Two-stream is present in the model (in the color-1/fluid sector, away from the
layer) and is filtered in production runs to expose the linear window. The shear
branch is distinct: it lives *at* the layer where the relative velocity crosses
zero, in the color-2/3 sector, needs the background potential, and matches an
independent eigenvalue calculation across the map — none of which is true of
two-stream. The k_z = 0 anchor also cleanly separates the families.

# Practical notes

- 21 slides / 35 min ≈ 1:40 per slide average — the pace is set by slides 3, 5, 7,
  8, 14 (the "heavy five"); everything else is fast.
- The three sentences worth rehearsing verbatim: the thesis sentence (top), the
  slide-11 "selected by the box, not intrinsic to the flow" beat, and the
  slide-14 window-test punchline ("the wavelength followed the wall").
- Numbers you must be able to say without looking: 0.5% (kz=0 anchor); 10⁻¹⁰
  (reduction); γ³ ≤ αV₀²; 0.977 ± 0.011; 4.5 → 5.5 vs 4.45 → 5.85 (window test);
  1087/1134; 9.9% (width independence).
- If a guide interrupts on slides 3–5 with mechanism questions, answer briefly and
  defer depth to slide 7 ("the ODE slide makes exactly that transparent — two
  slides ahead").
