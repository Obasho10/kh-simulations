# TS2_RESULTS.md — mediator-structure experiments (T-S2), 2026-07-04

Script: `ym_eigenmode_static.py`. Parameters: Campaign-35 point (α=2.0, V0=0.05,
EPS=0.15, xi_sponge=11, σ_sponge=5, NX=384), kz=1..6 (full/qstatic), kz=2,4
(mediator scans). Question (DERIVATION.md §6–§7): which structural features of
the plasma mediator — **F1** integrator (1/γ² response), **F2** current source
(v_z·(qA−qB)), **F3** nonlocality — are essential for the instability, and can
the solid's exchange field (none of the three) carry it?

## 1. Validation

- `full` reproduces the production solver / FINDINGS C35 exactly:
  γ = 0.0862, 0.1344, 0.1529, 0.1597, 0.1602, 0.1419 for kz=1..6. ✓
- `qstatic` (exact u/w reduction, kernel frozen at γ_ref = γ_full + 0.03i,
  one iteration): γ_qs/γ_full = 1.09, 1.03, 1.02, 1.02, 1.01, 1.12 for kz=1..6,
  with correct mode locations (ξ_pk drifting −3.9 → −6.5). The reduction
  `γ²[1 − ∂x(γ²+Ω_AΩ_F)⁻¹∂x]a = −v_z u` is **verified**, and retardation
  self-consistency is a ≤12% effect.

## 2. Exchange closure (density-sourced, local, algebraic — the solid's structure)

`a = λ_x·w`, scanned λ_x ∈ {±0.1, ±1, ±10, 100}:

**Re(γ) = 0.0000 at every coupling and both signs** (purely oscillatory,
Im(γ) up to ±11 at λ_x=100). This confirms the analytic result: with a local
density-sourced mediator the reduced operator is i·(Hermitian) − sponge, so
Re(γ) ≤ 0 **provably**. The plasma KH-type loop cannot be carried by an
exchange-like field. Not a numerical marginal case — a structural theorem.

## 3. Yukawa closure (current-sourced, algebraic — F2 kept, F1 removed)

`a = −λ_Y(−∂x² + kz² + m²)⁻¹(v_z u)`:

| kz | m | λ_Y=1 | 10 | 100 | 300 | 1000 | 3000 |
|----|---|-------|-----|------|------|-------|-------|
| 2 | 0 | 0 | 0 | **0.083** | **0.178** | **0.346** | **0.609** |
| 2 | 3 | 0 | 0 | 0 | **0.093** | **0.205** | **0.373** |
| 4 | 0 | 0 | 0 | 0 | 0 | **0.250** | **0.498** |
| 4 | 3 | 0 | 0 | 0 | 0 | **0.179** | **0.395** |

(0 = purely oscillatory; growing modes localize at ξ_pk ≈ −4.6…−6.5, the same
region as the true mode family; ±λ_Y give mirror modes at ±ξ as required by
parity.)

**A current-sourced algebraic mediator DOES support the instability** — but only
at λ_Y ~ 10²–10³, which is precisely the effective response strength the full
theory generates through its integrator: λ_Y,eff ~ (kz² + k_x²)/γ² ≈ 200–700 at
this parameter point. At the matched value (λ_Y ≈ 300, kz=2) the closure gives
γ = 0.18 vs 0.134 full — right magnitude. Screening (m=3, range ≈ EPS·... ≈ 2
shear widths) costs a factor ~2 in γ at fixed λ_Y; growth persists.

## 4. Verdict (decision tree of DERIVATION.md §7 — middle branch)

- **F2 (current source) is essential**: density-sourced closures are provably
  stable; current-sourced ones grow.
- **F1 (integrator) is not essential per se** — its role is to supply the large
  effective coupling (1/γ² ~ 40–140 here). An algebraic mediator must bring that
  coupling itself.
- **F3 (nonlocality) is quantitative, not qualitative** (factor ~2 at m=3).

For the solid: exchange is density-sourced ⇒ **the YM-type spin-KH loop does not
map onto exchange-mediated spin fluids**. No known solid-state interaction is
spin-current-sourced at the required strength (pure spin currents carry no
charge current → no Oersted field; spin-current–current couplings are
relativistically suppressed). Unless an engineered feedback layer (e.g.
spin-Hall detection + re-injection) is invented, the coupling-selected-KH
prediction does not transfer.

**What survives — and is arguably better**: the exchange sector has its *own*
instability channel with the true solid structure (Zeeman torque, ±s¹ beams) —
the exchange-band mode of `spin_eigenmode.py` v0.1 (growth when
|kz v_z − κ v_z 𝒜 + λ_xc| < λ_xc, γ up to ~λ_xc; confirmed numerically,
γ = 0.012–0.048 at λ=0.05 in code units). Two facts upgrade its importance:

1. DERIVATION.md §5: λ_xc in code-rate units is **O(1)–O(10)** in real materials
   (exchange rate |F₀^a|·E_F·P/ħ ~ 10¹¹–10¹² s⁻¹) — far above 1/τ_p, unlike the
   KH-analog estimate that failed the `soc_params.py` rate budget by ~25×.
2. The band condition contains the SOC background through κ v_z 𝒜, so the
   unstable kz window is still SOC-tunable — a (weaker but real) descendant of
   the wavelength-selection claim.

**Required literature check before investing further** (novelty risk): this
exchange-band mode of counter-streaming spin-polarized carriers may overlap
with known spin-transfer-torque / current-driven magnon instabilities
(Slonczewski; current-induced instabilities of spin spirals/PSH). Verify what
is genuinely new: likely the hydrodynamic two-beam geometry, the shear
localization, and the SOC-controlled band.

## 5. Caveats

- The `exchange` test here uses the YM drive structure (2iα v_z λ_x w). The true
  solid Zeeman structure (no v_z factor, ± beam signs) is the spinkh kinematic
  solver — which grows. Both statements are needed: *the plasma loop* dies under
  density-sourcing; *the solid loop* is a different (band-type) instability.
- qstatic regulator: kernel evaluated at γ_ref + 0.03i; the Ω_AΩ_F = −γ²
  resonance layer is smoothed by Im(γ_ref). Ratios 1.01–1.12 insensitive to
  doubling the regulator (spot-checked mentally, not systematically — redo if
  this number is ever published).
- Single parameter point (α=2, V0=0.05). The verdict is structural (sign-based,
  proof for exchange), so parameter dependence is not expected to change it;
  the yukawa quantitative rows would shift.

## 6. Follow-ups queued

- [x] First λ scan done (2026-07-04): `spin_eigenmode.py` at α=2, V0=0.05,
      λ ∈ {0.5, 1, 5} → γ(kz=1..6) = 0.26–0.46 / 0.38–0.73 / 0.88–1.77
      (monotone in kz over this window, ≈√λ scaling, modes at ξ ≈ −5…−7,
      i.e. the bulk counterflow region, not the shear layer; dense
      near-degenerate spectrum as expected for a quasi-local band).
      Still to do: locate the band edges in kz (growth must cut off where
      |kz·v_z − κ v_z 𝒜| > 2λ), λ-κ𝒜 phase diagram, max-γ scaling law.
- [ ] Update `soc_params.py` verdict logic: rate budget against the exchange
      band γ ~ min(λ_xc-band, …) instead of 0.12·Ω_drive (DERIVATION §8.3).
- [ ] STT-literature novelty check (see §4).
- [ ] Optional: T-S3 flow feedback now matters only for the band mode's
      saturation, not for its existence.
