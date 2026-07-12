# Spin-KH → the Exchange-Band Instability — State of the Work

**Date: 2026-07-12.** This document presents the `spinkh/` project to a physicist
audience at any level: where it came from, the honest negative result at its
center, the (arguably stronger) positive result that replaced the original goal,
the material feasibility case, and what remains shaky. Figures live in
`presentation/plots/`; the new explanatory ones regenerate with
`python3 presentation/make_plots.py`. Source documents: `MAPPING.md` (the
correspondence), `DERIVATION.md` (T-S1 microscopics), `TS2_RESULTS.md` (the
structural verdict), `BAND_THEORY.md` (the analytic theory of the surviving
mode), `B1_LITERATURE.md` (novelty check), `soc_params.py` (material budgets),
`README.md` (task ledger).

**Relationship to `../ymgpu2d/`**: this is the condensed-matter branch of the
Yang–Mills shear-instability program (`../ymgpu2d/PRESENTATION.md`). Everything
here is phrased in the same code units (lengths in shear widths, velocities in
V₀, coupling κ ↔ α_YM) so results are directly comparable to the plasma
campaign tables.

---

## 1. One-paragraph summary

The Pauli equation with spin-orbit coupling (SOC) is *exactly* a U(1)×SU(2) gauge
theory in which the SU(2) vector potential is a fixed, material-defined background
(Tokatly 2008) — so the plasma program's most criticized approximation (the
frozen non-Abelian background) is the *exact physical situation* in a
semiconductor, and counter-streaming spin-polarized electron currents realize the
colored two-beam setup. We asked whether the plasma's shear instability transfers
to this solid-state system. The answer, established by a controlled
mediator-replacement experiment on the plasma eigenproblem, is **no — provably**:
the plasma loop requires a mediator sourced by the spin/color *current*, while
the solid's only strong internal field (electron–electron exchange) is sourced by
the spin *density*, and density-sourced local mediators give Re γ ≤ 0
structurally. What survives — and is quantitatively *stronger* in real materials —
is the **exchange-band instability**: counter-streaming, counter-polarized spin
populations locked by the exchange field are pumped by their Doppler detuning,
growing at rates up to the full exchange rate λ_xc (~10¹² s⁻¹ in GaAs, orders of
magnitude above dissipation) inside the band −2λ < Δ < 0, with pattern
wavevector k_z* = λ_xc/V₀ − κ|𝒜| — i.e. **wavelength set by drift bias,
long-wavelength band edge set by the SOC gate, and even gate-programmable
"instability islands"** that grow where nothing else does. The analytic theory,
numerical validation (to 0.2–2%), threshold law, and a measured-diffusivity
material budget (GaAs persistent-spin-helix wells supercritical by ~30–170×) are
done; a literature check finds the configuration unclaimed. The main open items:
one unexplained systematic in island positioning, real-frequency spectra, the
saturation/nonlinear question (GPU work reusing ymgpu2d), and residual
older-literature risk.

---

## 2. Background for the non-specialist

**Spin-orbit coupling as a gauge field.** In many semiconductors, an electron's
spin feels a magnetic-field-like torque that depends on its momentum (Rashba and
Dresselhaus SOC). Tokatly's observation: this is not merely *like* a gauge
coupling, it *is* one — the Pauli Hamiltonian can be written exactly as

```
H = (1/2m)(p − e A − (ħ/2) σ^a 𝒜^a)²  + …
```

with a **non-dynamical SU(2) potential 𝒜 fixed by the material**. For the
special "[110] Dresselhaus" and "persistent-spin-helix" (PSH, Rashba=Dresselhaus)
configurations, only one color-component survives — 𝒜_z¹ — which is *exactly*
the gauge structure of the plasma code (A_x = 0, only A_z¹ ≠ 0, frozen). Even
better, the SOC strength is gate-voltage tunable, so a patterned gate writes a
designer 𝒜_z¹(x) profile — a laboratory version of the plasma code's log-cosh
background.

**The dictionary** (full table in `MAPPING.md` §2):

| plasma (ymgpu2d) | solid (spinkh) |
|---|---|
| color charge Q^a | spin polarization s^a |
| coupling α_YM | κ = 2mβ/ħ² (SOC strength) |
| frozen A_z¹(x) | gate-engineered SOC profile — **exact here** |
| beams Q¹=±1 at ±V₀ | counter-propagating spin-↑/spin-↓ currents (pure spin current, zero charge current) |
| color precession α·v_z(Q×A_z) | Dyakonov–Perel spin precession — **microscopically exact match, including the v_z factor** (DERIVATION.md §2–3) |
| dynamical color-2/3 gauge fields | **no analog — the crux (§4)** |
| numerical band-stop filters | real dissipation: −p/τ_p, spin diffusion D_s, 1/τ_s |

**The experimental picture.** A 2D electron gas channel in the hydrodynamic
regime (electron–electron collisions dominate — demonstrated in GaAs and
graphene), with spin-↑ carriers drifting one way on one side and spin-↓ the other
way on the other side, meeting in a shear layer. Injection by spin-Hall effect,
ferromagnetic contacts, or optical orientation; readout by Kerr-rotation
microscopy (μm-scale spin textures — the same technique that mapped the PSH
itself). The prediction is a spontaneously growing spin-texture stripe pattern
with a controllable wavelength.

---

## 3. What was done, in order

1. **T-S1, the microscopic derivation** (`DERIVATION.md`): from the
   Pauli/Tokatly Hamiltonian with contact interaction, derive the two-beam
   spin-fluid model. Key verified outcomes: the SOC torque is sourced by the
   *spin current* and the fluid closure reproduces the YM precession term
   exactly; the exchange mean field enters as b_xc^a = λ_xc·s_tot^a; a subtle
   self-torque cancellation validates the solver's linearized blocks *for this
   specific counter-polarized background* (it would not hold generally); and
   λ_xc in code-rate units is **O(1)–O(10)** in real materials — the coupling is
   not the bottleneck. It also corrected an early wrong assumption: the plasma
   loop needs **no flow feedback** (the plasma eigensolver has no δv, δn blocks
   and still matches simulations) — the decisive question was always the
   *mediator structure*.

2. **T-S2, the mediator-replacement experiment** (`ym_eigenmode_static.py`,
   `TS2_RESULTS.md`): take the *plasma* eigenproblem — reduced exactly to three
   equations (mediator / q-difference / q-sum) — and swap its mediator for
   structurally modified ones. This isolates which of three structural features
   matters: **F1** (integrator, 1/γ² response), **F2** (current-sourced), **F3**
   (nonlocal). Result in §4.

3. **The pivot**: the plasma loop does not transfer (§4), but the kinematic spin
   solver (`spin_eigenmode.py`) had already revealed the solid's *own* unstable
   channel. The program re-aimed at it (README Phase 2).

4. **A1, analytic band theory** (`BAND_THEORY.md`): closed-form local dispersion,
   band condition, selection law, flank law, threshold law. §5.

5. **A2/A2b/A3, numerical maps** (`band_map.py`, `a2b_designer.py`,
   `a3_threshold.py` → the three production figures): validation of every
   analytic claim, the SOC/gate control result, designer islands, and the
   threshold. §5–6.

6. **B1, literature/novelty check** (`B1_LITERATURE.md`): the mode's family
   tree and the delta list. §7.

7. **Material budget** (`soc_params.py band_budget()`), anchored to a *measured*
   spin diffusivity. §6.

---

## 4. The negative result — and why it is trustworthy

`presentation/plots/fig02_mediator_verdict.png`

The plasma instability loop, written exactly in reduced variables
(u = q_A − q_B, w = q_A + q_B, mediator a):

```
γ² [1 − ∂ₓ (γ² + Ω_A Ω_F)⁻¹ ∂ₓ] a = − v_z u        (mediator equation)
γ u = − i v_z Ω_A w
γ w = + 2 i α v_z a − i v_z Ω_A u
```

The plasma mediator has three structural features: **F1** it *integrates* (the
1/γ² response — this is why |Az²|/|By²| = 50–1200 in the plasma campaigns);
**F2** it is sourced by the color *current* v_z(q_A−q_B); **F3** it is *nonlocal*
(elliptic kernel with a resonant layer). The solid's exchange field
b_xc = λ·s_tot has none of the three: algebraic, density-sourced (s_A+s_B),
contact-local.

The experiment (run at the plasma Campaign-35 point, α=2, V₀=0.05, where the full
solver reproduces the production code exactly):

| closure | structure | Re γ |
|---|---|---|
| full (gauge dynamics) | F1+F2+F3 | 0.134 (kz=2) — the real mode |
| qstatic (kernel frozen at γ_ref) | F2+F3, retardation removed | 1.01–1.12 × full — **retardation is a ≤12% effect** |
| exchange a = λ_x·w | none | **0.0000 at every λ_x ∈ {±0.1…100}, both signs** |
| yukawa a ∝ (−∂ₓ²+k_z²+m²)⁻¹(v_z u) | F2 (+screened F3), no F1 | grows, but only at λ_Y ~ 10²–10³ |

The exchange row is not a numerical near-miss: with a local density-sourced
mediator the reduced operator becomes i·(Hermitian) − damping, so **Re γ ≤ 0 is a
theorem**, verified numerically at every coupling. The yukawa row shows F2 is the
essential feature — a current-sourced mediator *does* carry the instability, and
the coupling it needs (λ_Y ≈ 300 at this point) is precisely what the full
theory's integrator supplies dynamically (λ_eff ~ (k_z²+k_x²)/γ² ≈ 200–700);
at matched coupling the algebraic closure even reproduces the right magnitude
(γ = 0.18 vs 0.134). Nonlocality is only a factor ~2 (m=0 → 3).

**Conclusion**: the YM-type spin-KH loop requires a spin-*current*-sourced
mediator. No solid-state interaction is spin-current-sourced at the required
strength (pure spin currents carry no charge current → no Oersted field;
spin-current–current couplings are relativistically suppressed). Short of an
engineered feedback device (spin-Hall detect + re-inject), **the plasma
wavelength-selection mechanism does not transfer to solids.** This is stated
prominently rather than buried: it is a real result, it cost one day of solver
work to establish, and it protected the project from months of misdirected
effort.

*Caveats attached to the verdict* (from `TS2_RESULTS.md` §5): the test ran at one
parameter point (defensible — the verdict is structural/sign-based, not
quantitative); the qstatic regulator sensitivity was spot-checked, not swept
(redo if that number is ever published); and the "exchange" test uses the YM
drive structure — the true solid Zeeman structure is what the kinematic solver
implements, and *that* grows, which is the pivot.

---

## 5. The positive result — the exchange-band instability

### 5.1 Mechanism (`presentation/plots/fig01_band_mechanism.png`)

Two counter-polarized (s¹ = ±1), counter-streaming (v_z = ±V₀ tanh ξ) spin
populations, coupled by contact exchange λ_xc, in a frozen SOC background 𝒜(x).
For transverse spin fluctuations s± = s² ± is³, the *local* 2×2 problem gives

```
γ = ± i √((Δ + λ)² − λ²),      Δ(x; k_z) = v_z(x)·(k_z − κ𝒜(x))
```

Δ is the **Doppler–precession detuning** between the two beams' spin phases.
Growth occurs in the band **−2λ < Δ < 0**, with maximum **γ_max = λ_xc exactly**
at mid-band Δ = −λ (fig01a). Physical reading: exchange locks the two beams'
transverse spins into a collective precession; when the counterflow Doppler
detuning is comparable to (and signed against) the exchange rate, the locked mode
is pumped by the relative drift. It is a two-beam resonance instability — the
spin analog of the plasma's precession-cascade family, *not* of its KH loop.
fig01b shows where the band condition is met across the shear layer: for
branch +, only on the v_z < 0 side, on the "resonance surface" where Δ = −λ —
confirmed by every numerical mode location.

Three exact structural facts sharpen this (all verified in `BAND_THEORY.md`):

- **Selection law**: peak growth at k_z* ≈ λ_xc/V₀ − κ|𝒜|. In lab terms:
  pattern wavelength = 2π·v_drift/ω_xc, with a gate-tunable SOC shift.
- **Flank law**: below the peak, γ(k_z) ≈ √(2λV₀(k_z + κ|𝒜|)) — validated to
  ~10% over 33 points and a factor 20 in λ.
- **Exact flow decoupling**: for this background the band mode does not couple
  to flow, density, or Coulomb perturbations *at linear order* (all three
  candidate couplings vanish identically). Consequence: Fermi pressure, momentum
  relaxation and screening do not move the threshold — **the linear threshold is
  set purely by spin-sector dissipation (D_s, 1/τ_s)**. This is why the original
  MAPPING.md worry-list items (Coulomb pinning, pressure) turned out to be
  saturation physics, not existence physics.

### 5.2 Numerical validation (`presentation/plots/fig03_band_map.png`)

The 1D eigensolver (`spin_eigenmode.py`, structure inherited from the plasma
`ym_eigenmode.py`) confirms, over λ = 0.05–1.0 (a factor 20) and three
independent (λ, V₀) points:

- γ_max/λ = 0.96–1.00 (prediction: exactly 1) — to **0.2–0.3%** at λ = 0.5, 1.0;
- k_z* matches λ/V₀ − κ|𝒜(ξ_pk)| at every tested point (10 vs 9.5; 20 vs 19.7;
  4 vs 4.2);
- the unstable side and the mode migration with k_z match the resonance-surface
  prediction;
- **at small λ the band has a genuine sharp high-k_z cutoff** (γ < 0 beyond
  ≈6–7·k_z*), i.e. clean spectral selection exactly in the materially relevant
  regime; at large λ a slow "sliver" tail persists near the shear layer (the
  shear layer always re-enters the band as |v_z| → 0 — §8.3).

Map (b) of fig03 is the **gate-control result**: at λ = 0.1, raising κ from 0 to
4 lifts the long-wavelength flank (γ at k_z = 0.25 nearly doubles) while the peak
stays pinned at k_z ≈ λ/V₀. So the two experimental knobs separate cleanly:
**drift bias sets the pattern wavelength; the SOC gate switches long-wavelength
instability on and off.** (Note this is a *different* gate effect than first
predicted — the naive expectation was a peak shift; the measured effect is a
band-edge lift. The peak-shift regime needs κV₀|𝒜| ≳ λ, which leads to…)

### 5.3 Designer islands (`presentation/plots/fig05_designer_islands.png`)

Gate-defined SOC islands 𝒜(x) = A_g·exp(−(ξ−ξ₀)²/2w²) on a PSH-tuned background:
the island carries its own local band at k_z ∈ (κA_g − 2λ/V₀, κA_g). Numerically:

- **depth selects wavelength**: γ(k_z) peaks at k_z = 10, 14, 18 for
  A_g = 6, 8, 10 — exactly the predicted κA_g − λ/V₀ — with γ_pk ≈ λ and the mode
  sitting *on the island*;
- crucially, at those k_z the background is completely stable — the island mode
  grows **where nothing else grows**;
- **position places the mode**: the mode peak tracks ξ₀ essentially exactly on
  the v_z > 0 side; on the v_z < 0 side it tracks with an **unexplained ~1
  ξ-unit inward offset** (§8.2).

Both the wavelength and the location of the unstable spin texture are therefore
gate-programmable — the "designer instability". This is the claim with PRL-level
upside if it survives realism checks (§8.2, §8.5).

### 5.4 Threshold and dissipation (`presentation/plots/fig04_threshold.png`)

Adding spin diffusion and spin relaxation to the flank law and maximizing over
k_z gives closed forms:

```
γ_net,max = 0.75·(λ² V₀² / D_s)^{1/3} − 1/τ_s
V₀_c      = (1/τ_s)^{3/2} · √D_s / (0.65 λ)
```

The numerical neutral curve crosses zero at V₀_c = 0.0168 vs the analytic 0.0172
— **2% agreement** (fig04b). Away from threshold the 1D formula overestimates
γ_net (localized modes pay an extra D_s·k_x² cost not in the formula — visible in
fig04a); near threshold the modes broaden and the law becomes exact, which is the
regime that matters for a feasibility budget. Larger exchange *lowers* the
threshold — the interaction is an ally, not an obstacle.

---

## 6. The material case (`presentation/plots/fig06_material_budget.png`)

`soc_params.py band_budget()` evaluates the threshold law with real material
numbers. The decisive input is the transverse spin diffusivity D_s; three
scenarios bracket it, including a **measured anchor**: Weber et al., Nature 437,
1330 (2005) measured D_s ≈ 100 cm²/s in a GaAs 2DEG at matched density via
transient spin gratings (spin-Coulomb-drag limited, roughly flat 5–300 K).

| platform | D_s scenario | margin v_drift/v_c | γ_net | pattern |
|---|---|---|---|---|
| GaAs PSH QW | measured (Weber05) | **≈169×** | 3.0×10¹¹ s⁻¹ | 2.0 μm |
| GaAs PSH QW | spin-drag estimate | ≈124× | 2.4×10¹¹ s⁻¹ | 3.0 μm |
| GaAs PSH QW | ohmic (pessimistic) | ≈28× | 0.8×10¹¹ s⁻¹ | 22 μm |
| graphene/WSe₂ | spin-drag | ≈7× | 2.8×10¹¹ s⁻¹ | 8.9 μm |
| graphene/WSe₂ | ohmic | ≈5× | 2.0×10¹¹ s⁻¹ | 14.1 μm |

**GaAs persistent-spin-helix quantum wells are supercritical by 1.5–2 orders of
magnitude in every scenario**, with Kerr-imageable μm-scale patterns and growth
times of picoseconds; graphene/WSe₂ is marginal. For calibration: the *original*
KH-analog rate budget (before the pivot) **failed by ~25×** on the same
platform — the pivot moved the project from "unobservable" to "strongly
supercritical", because γ_max is now set by the interaction (λ_xc) rather than by
a fraction of the drive precession rate.

Also relevant: spin Coulomb drag damps *counterflow* of the spin populations —
i.e. the background drive itself feels a drag and must be sustained by current
bias. Because of the exact flow decoupling (§5.1), this drag does not damp the
mode at linear order; it enters the power budget and saturation physics.

---

## 7. Novelty position (from `B1_LITERATURE.md`)

The mode's family tree, and the deltas that appear to be unclaimed:

- **Castaing instability** (polarized ³He, trapped gases): same family
  (transverse fluctuations destabilized via the exchange molecular field),
  *different drive* — gradient of polarization there, relative **drift** here.
- **Bazaliy/spin-wave-Doppler current-driven instabilities**: closest solid-state
  precedent, but requires magnetic *order* (ferromagnets, STT); ours is a
  **paramagnetic** 2DEG with **two counter-streaming populations** (pure spin
  current, no Oersted complications).
- **PSH-with-drift experiments** (Kunihashi, Altmann): the exact device platform,
  fully mature experimentally — with *no instability studied*. Ideal launch pad.
- Spin-modified quantum-plasma two-stream, paramagnon amplification, Suhl
  parametric instabilities: adjacent but mechanistically distinct (charge-sector,
  injection-inversion, parametric respectively).

**Unclaimed combination**: counterflow drive + paramagnetic itinerant 2DEG +
SOC band control (uniform gate: band edge; patterned gate: islands) + threshold
law + material budget. **Verdict: proceed with the prediction paper (Paper E).**
Residual risks: under-indexed Soviet/JETP-era Silin-wave literature (mitigation:
citation-trail search when drafting); ³He counterflow spin transport (different,
superfluid-coherent physics, but a comparison paragraph should exist); bosonic
counterflow instabilities in two-component BECs (cite in the cold-atom paragraph).

---

## 8. Where we are on shaky ground — the honesty section

### 8.1 Everything rests on one closure: local contact exchange

The whole positive program uses b_xc = λ_xc·s_tot — the zero-range,
zero-retardation Stoner/Fermi-liquid mean field, with λ_xc estimated at O(1)–O(10)
code units (`DERIVATION.md` §5, explicitly tagged *[sketch — factors of 2]*).
What could go wrong: (a) the F₀^a Landau parameter and polarization P enter
multiplicatively and the factor-of-2 bookkeeping is unfinished; (b) beyond-contact
(finite-range) exchange softens the band — by the yukawa scan's factor ~2, this
is quantitative, not existential; (c) the drift closure J_s ≈ v_z·s ignores the
anisotropic distribution (a two-moment closure would capture Dyakonov–Perel
self-consistently — queued as "only if the paper goes quantitative"). None of
these threaten γ_max = λ_xc structurally; all of them move numbers by O(1).
The budget's ×30–170 margins are the insurance.

### 8.2 The unexplained island offset

On the v_z < 0 side, island modes sit ~1 ξ-unit inside the island center
(fig05b, ξ₀ = −6 → mode at −4.66) — a real, reproducible systematic with no
explanation yet. Presumably branch asymmetry (the two ± branches see opposite
detuning signs), but "presumably" is not an explanation. Flagged for the A2b
second pass. Until resolved, the "position is programmable" claim carries a
±1 ξ-unit asterisk on one side.

### 8.3 The high-k_z sliver tail and pattern selection in real devices

At large λ the band theory predicts (and the solver confirms) a slowly-decaying
tail of unstable modes above k_z* — squeezed against the shear layer, where
|v_z| → 0 re-enters the band. If a real device operated there, the observed
pattern would be decided by nonlinear competition, not linear selection, and the
clean "wavelength = 2πv_d/ω_xc" story would weaken. Mitigations: (a) at
material-relevant *small* λ/V₀ ratios the cutoff is sharp (validated — fig03a,
λ = 0.05–0.1 rows) so selection is clean where it matters; (b) diffusion
suppresses the sliver (its effective k_x grows as it narrows). But the
sliver-vs-diffusion competition has only been checked at map resolution — a
dedicated study near realistic parameters belongs in the pre-paper checklist.

### 8.4 Linear theory only — saturation is untouched

Everything so far is exponential-growth-rate physics. The experimentally decisive
questions — what amplitude the texture saturates at, whether it survives as a
stationary stripe pattern, what it does to the spin-current transmission (the
proposed "spin-valve collapse" observable), and the noise spectrum — are all
Phase 2C (GPU, reusing the ymgpu2d machinery with a new `SPIN_EXCHANGE` mode:
drop Maxwell, add one exchange kernel, reuse the precession kernel). Not started.
Also missing at linear order: **A4, the real frequencies Re(ω)** — these set
where the noise peak sits in a spectrum analyzer, which is the cheapest
experimental signature; it is a small solver extension and should be done before
any experimental conversation.

### 8.5 Realism gaps on the device side

- The designer-island scan used κA_g = 12–20 (code units) — a *strong* SOC
  modulation. Achievable gate-stack modulation depths must be checked in the D1
  write-up; moderate islands select proportionally lower k_z (mechanism
  unchanged), but the headline numbers need re-anchoring.
- The budget uses the *longitudinal* D_s (measured) as proxy for the transverse
  D_⊥ (what the mode feels) — equal to O(1) at P ≲ 0.2 (Leggett–Rice corrections
  small), asserted from theory, not measured.
- The kinematic solver's validity relies on the self-exchange cancellation that
  is exact *only for the symmetric counter-polarized background* (DERIVATION.md
  §4). Real injected profiles will be asymmetric (unequal P, unequal densities);
  nothing has been computed off the symmetric point. Cheap solver extension,
  should be on the list.
- A −1/τ_s diagonal and the a=1 background-channel correction (a static s¹
  texture near gate gradients — "check it does not destabilize the background on
  its own") are known, listed, and unimplemented in the solver.
- Injected polarization P enters the budget linearly through λ_xc ∝ P; the quoted
  margins use P = 0.2 (optimistic-realistic for spin-Hall/optical injection).
  At P = 0.05 the GaAs margin drops by ~4× — still supercritical, but quote it.

### 8.6 The negative result's own caveats

Single parameter point; regulator sensitivity spot-checked; structural theorem
believed parameter-independent (§4). If the verdict is ever published as a
stand-alone statement, re-run the qstatic regulator sweep and one more (α, V₀)
point. Cost: hours.

---

## 9. Anticipated questions, by audience

**[U] = student / general physicist, [CM] = condensed-matter theorist,
[E] = experimentalist, [P] = plasma/gauge-theory colleague.** Tags: ✅ solid,
⚠️ partially resolved, ❌ open.

1. **[U] Is the SOC-as-gauge-field thing an analogy or exact?**
   ✅ Exact operator identity (Tokatly 2008; re-derived for our configuration in
   DERIVATION.md §1). For [110]/PSH configurations the surviving component matches
   the plasma code's gauge exactly. The *dynamics* differ in one respect — the
   solid's SU(2) field does not evolve — and that is not a bug: it makes the
   plasma program's frozen-background approximation exact here.

2. **[U] So the plasma instability doesn't exist in solids. Why keep going?**
   ✅ Because the solid supports a *different* instability, with growth rate set
   by the exchange interaction (huge, ~10¹² s⁻¹) instead of the drive (small),
   which flips the feasibility budget from failing by 25× to passing by 30–170×.
   Weaker inheritance from the plasma program (the SOC term shifts and gates the
   band rather than selecting the peak), but a stronger experimental case.

3. **[U] What would one actually see in the lab?**
   ✅/❌ Onset of a μm-scale transverse-spin stripe pattern (Kerr microscopy /
   NV magnetometry) above a threshold drift velocity, wavelength moving with bias
   as 2πv_d/ω_xc, long-wavelength response switchable by a gate. Amplitude at
   saturation and the noise spectrum are open (Phase 2C, A4).

4. **[CM] Isn't this just the Castaing instability?**
   ✅ Same family, different drive: Castaing needs a polarization *gradient*
   (k² < μ k·∇M₀); this needs relative *drift* between counter-polarized streams
   (Doppler-detuned resonance, band −2λ < Δ < 0) and works with uniform |s¹|.
   The families meet in the Leggett–Rice framework (which supplies our
   dissipation inputs), but the drive, geometry, and control knobs differ. B1's
   delta list is the systematic answer.

5. **[CM] Spin-transfer-torque instabilities in ferromagnets look similar.**
   ✅ Closest precedent (Bazaliy et al.; spin-wave Doppler). Deltas: no magnetic
   order needed (paramagnetic 2DEG — the "stiffness" is the exchange field of the
   *injected* polarization, not an order parameter), two counter-streaming
   populations instead of one drifting carrier gas, zero net charge current, and
   SOC as a spatial control field.

6. **[CM] Exchange conserves total spin. How can it drive an instability?**
   ✅ It doesn't add angular momentum — it locks the two beams' transverse spins
   into a collective mode; the *drift kinetic energy* is the free-energy source,
   pumped through the Doppler detuning. The self-torque cancellation check
   (DERIVATION.md §4) confirms the per-beam linearized torques are exactly the
   solver's, so the mechanism is not an artifact of double-counting exchange.

7. **[CM] At these densities, is a hydrodynamic/fluid description of spin even
   valid? Where is Landau damping?**
   ⚠️ Checked at the budget level: l_ee/pattern = 0.02–0.25 across scenarios
   (fluid valid, near its edge at the measured-D_s point). The drift closure omits
   anisotropic-distribution kinetics (§8.1c); D_s and 1/τ_s stand in for the
   damping the kinetic theory would supply. A Leggett–Rice-corrected transverse
   D_⊥ is the known first correction.

8. **[CM] Coulomb interactions and screening — why are they absent?**
   ✅ Proven irrelevant at linear order for this background: the band mode
   couples to neither density nor flow perturbations (exact decoupling,
   BAND_THEORY.md §9), so screening enters only at saturation. This is a theorem
   about the symmetric background, hence §8.5's asymmetric-background caveat.

9. **[E] What device parameters do I need, concretely?**
   ✅ GaAs PSH quantum well (α_R = β), n ≈ 2×10¹¹ cm⁻², mobility in the
   hydrodynamic window, channel ~2 μm, drift v_d ~ 2×10⁴ m/s, injected P ~ 0.2;
   patterns 2–22 μm at γ_net ~ 10¹¹ s⁻¹. Every element demonstrated separately
   in the PSH-drift literature (Kunihashi/Altmann/Walser); the combination is the
   experiment.

10. **[E] What kills it in practice?**
    ⚠️ The budget says dissipation won't (margins 28–169×). Realistic suspects:
    achieving counter-streaming *spin-polarized* flows in one channel
    (injection geometry — needs a device-level design pass), heating at the
    required bias (v_d ≪ v_F holds, checked), inhomogeneity of β across the
    channel, and the sliver-tail selection question (§8.3). The threshold being
    picosecond-scale growth means even transient observation windows suffice.

11. **[P] You replaced the mediator in *your own* eigenproblem and concluded
    about *solids*. Is that transfer airtight?**
    ⚠️ The claim has two legs: (i) the plasma loop dies under density-sourcing —
    theorem + numerics on the plasma problem; (ii) the solid's exchange loop is
    the kinematic solver's problem, which grows by a different mechanism. The
    bridge — "no solid interaction is spin-current-sourced at the required
    strength" — is a physics survey statement (Oersted argument + relativistic
    suppression), not a theorem. An engineered current-sourced feedback layer is
    explicitly left open as a device concept.

12. **[P] The plasma program's headline was coupling-selected wavelength. What
    survived of it?**
    ✅ Honest accounting: the *mechanism* did not survive; the *program* did —
    SOC still controls the spectrum (band-edge lift by uniform gate;
    island-programmed k_z), and the methodology (1D eigensolver → maps →
    threshold → budget → GPU saturation) transferred wholesale. kz* here is set
    by λ_xc/V₀ (interaction/drive), not by κ (the coupling) — a different law,
    stated as such.

13. **[P/CM] Why should the plasma community care about this branch (or vice
    versa)?**
    ✅ It is the one physical realization where the frozen-background assumption
    is exact rather than approximate — so it functions as the plasma program's
    experimentally accessible limit case. Conversely, the mediator-structure
    theorem (density-sourced ⇒ stable) sharpens *why* the plasma instability is
    special: gauge dynamics supplies a current-sourced integrator, which is rare.

---

## 10. Priority list — what would most improve this work now

1. **A4: real frequencies Re(ω)** (solver extension, ~a day): the noise-spectrum
   prediction is the cheapest experimental handle and the paper needs it.
2. **Asymmetric-background check** (§8.5; solver, ~days): unequal P and density —
   the symmetric-point theorems (flow decoupling, self-torque cancellation) need
   perturbative robustness statements before an experimentalist trusts them.
3. **T-S2b/island second pass**: explain the v_z<0 island offset (§8.2); sliver
   vs diffusion at realistic parameters (§8.3); realistic gate-island depths (§8.5).
4. **DERIVATION.md §5 factor-of-2 pass** on λ_xc, plus the −1/τ_s diagonal in
   the solver — cheap rigor that the budget quotes depend on.
5. **Phase 2C: `SPIN_EXCHANGE` mode in ymgpu2d** (GPU, weeks): saturation
   amplitude, texture stability, spin-current degradation (the device
   observable), and validation of the linear rates by the plasma program's
   6-field-seeding methodology.
6. **Paper E drafting** with the B1 framing ("a paramagnetic, counterflow-driven
   relative of the Castaing and current-driven spin-wave instabilities"), the
   JETP-era citation-trail search folded into drafting, and the negative result
   (§4) included as a section — it is part of the story and preempts the obvious
   referee question.

---

## 11. Figure index

| file | shows |
|---|---|
| `presentation/plots/fig01_band_mechanism.png` | local dispersion γ(Δ), the unstable band, and where the band condition is met across the shear layer |
| `presentation/plots/fig02_mediator_verdict.png` | the T-S2 structural experiment: plasma vs solid mediator features; closure scan bar chart |
| `presentation/plots/fig03_band_map.png` | A2 production map: selection law over 20× in λ; SOC/gate band-edge control |
| `presentation/plots/fig04_threshold.png` | A3: dissipated dispersion vs flank law; neutral curve vs threshold law (2%) |
| `presentation/plots/fig05_designer_islands.png` | A2b: island depth selects k_z; island position places the mode (with the §8.2 offset visible) |
| `presentation/plots/fig06_material_budget.png` | supercriticality margins per material/D_s scenario, with γ_net and pattern sizes |
| `presentation/plots/fig07_kinematic_solver_v01.png` | historical: the v0.1 kinematic solver output that first showed the band channel (pre-pivot, λ=0.05) |
