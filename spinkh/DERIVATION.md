# DERIVATION.md — T-S1: linearized spin-fluid model from the Pauli/Tokatly Hamiltonian

Status 2026-07-04: first careful pass. Every step is either **[verified]** (checked
algebraically here) or **[sketch]** (structure right, O(1) factors need one more
pass). Read together with `TS2_RESULTS.md` (numerical mediator tests) — §7 uses
its conclusions.

---

## 0. Summary of what this derivation establishes

1. The kinematic spin blocks used in `spin_eigenmode.py` v0.1 are **correct for
   the two-beam background** (including the subtle self-exchange cancellation,
   §4) — no sign changes needed.
2. The SOC precession term has *exactly* the YM structure `−κ v_z 𝒜(x) s³`
   because the microscopic torque is sourced by the **spin current**, and the
   fluid closure gives J_s ≈ v_z s (§3).
3. The solid's induced field (exchange) is an **algebraic, density-sourced**
   mediator: `b_xc^a = λ_xc s_tot^a`. The plasma's mediator `a` is an
   **integrating, current-sourced** field: `γ² K a = −v_z(q_A−q_B)`. These
   differ in two independent structural ways (§6) — T-S2 tests each separately.
4. λ_xc in code units is **O(1)–O(10)**, i.e. *not* small (§5): if a
   density-sourced algebraic mediator supports the instability at all, the
   coupling strength is available in real materials.
5. Flow (momentum) feedback is **not** part of the plasma loop — the plasma
   eigensolver `ym_eigenmode.py` contains no δv, δn blocks and still matches
   simulations to 1%. T-S3 is therefore *optional physics*, not a prerequisite.
   The load-bearing question is the mediator structure (§6), not the flow
   feedback. (This corrects MAPPING.md §6's original assumption.)

## 1. Microscopic starting point

2DEG in the (x,z) plane, [110]-Dresselhaus or PSH-tuned SOC, contact e-e
interaction, plus a gate-modulated SOC coefficient β(x):

```
H = Σ_j [ p_j²/2m + (β(x_j)/ħ) σ¹_j p_{z,j} ]_sym + (U/2) Σ_{j≠l} δ(r_j − r_l) + V_dis
```

(`[·]_sym`: symmetrized ordering ½{β(x), p_z} since β varies in x.)

**[verified]** Completing the square turns the SOC term into an SU(2) minimal
coupling with a single non-zero potential component:

```
H_1 = (1/2m) ( p_z + (ħ/2) 𝒜_z(x) σ¹ )² + p_x²/2m − (ħ²/8m) 𝒜_z² ,
𝒜_z(x) = 2m β(x) / ħ²
```

The last term is a spin-independent potential O(β²) — absorb into the band
bottom. This is Tokatly's construction restricted to the [110]/PSH case; the
code's gauge (A_x = 0, only A_z^1 ≠ 0, frozen) is exact.

## 2. Heisenberg equations → moment hierarchy

Operators: density n(r), spin density s^a(r) = ⟨ψ†σ^aψ⟩, momentum density π_i,
spin current J_i^{s,a} = ⟨ψ†{v_i, σ^a}ψ⟩/2 with v_i = (p_i + (ħ/2)𝒜_z δ_{iz}σ¹)/m.

**[verified]** Spin precession from SOC: with H_so = (β/ħ)σ¹p_z and
[σ¹,σ²] = 2iσ³, [σ¹,σ³] = −2iσ²:

```
∂_t s² |_so = − 𝒜_z(x) J_z^{s,3}
∂_t s³ |_so = + 𝒜_z(x) J_z^{s,2}
∂_t s¹ |_so = 0
```

The torque is sourced by the **spin current**, not v_z s per se.

**[verified]** Fluid (drift) closure: J_z^{s,a} = v_z s^a − D_s ∂_z s^a + O(𝒜)
where the O(𝒜) piece (ħ𝒜_z/2m)·n·δ^{a1} only feeds a=1 (background channel).
For a = 2,3 (the dynamical channels):

```
∂_t s^{2,3} + ∇·(v s^{2,3}) = ∓ 𝒜_z(x) v_z s^{3,2} + D_s ∇² s^{2,3} + (exchange, §4)
```

Comparing with the YM code's precession source `α v_z (Q×Az)^a`: identical
structure with the identification **κ𝒜(x) ↔ α·Az1(x)** (both enter only as the
product). The v_z factor in the YM term is *microscopically exact* here — a
satisfying consistency check of the mapping.

## 3. What the plasma loop needs, in u/w variables

From `ymgpu2d/analysis/ym_eigenmode.py` (circular variables, u = qA − qB,
w = qA + qB, S = v_z u), eliminating b, ex, ez exactly **[verified]**:

```
γ² [ 1 − ∂x ( 1/(γ² + Ω_A Ω_F) ) ∂x ] a = − v_z u      (mediator; Ω_{A,F} = kz ± αAz1)
γ u = − i v_z Ω_A w
γ w = + 2 i α v_z a − i v_z Ω_A u
```

Three structural features of the plasma mediator:
- **(F1) integrator**: response ∝ 1/γ² (a accumulates ∫ez dt). This is why
  |Az2|/|By2| = 50–1200 in the campaigns.
- **(F2) current-sourced**: driven by u = qA − qB weighted by v_z (a color
  *current*), not by the density-like w.
- **(F3) nonlocal**: elliptic kernel with the (γ² + Ω_AΩ_F)⁻¹ resonance at the
  Ω_A Ω_F = −γ² layer (the outer-mode physics).

## 4. Exchange closure — the solid's mediator

**[verified]** Contact interaction mean field: b_xc^a(r) = λ_xc s_tot^a(r) with
λ_xc = −U/2 in the Hubbard model, or λ_xc = −F₀^a/ν₀ in Fermi-liquid form
(F₀^a < 0 ⇒ λ_xc > 0, field parallel to s). Torque: ∂_t s|_xc = (2/ħ) b_xc × s.

**[verified] Self-torque cancellation check** (validates the v0.1 solver blocks):
exchange conserves total spin — torque_tot = λ s_tot × s_tot = 0. Per beam:
torque_A = λ (s_A + s_B) × s_A = λ s_B × s_A. Linearizing about s_A⁰ = +ê₁,
s_B⁰ = −ê₁:

```
δ(torque_A)² = λ (δs_B × ê₁ + s_B⁰ × δs_A)² = λ (δs_B³ + δs_A³)
```

i.e. for THIS background (equal, opposite polarizations) the per-beam linearized
torque is λ(δs_A³ + δs_B³) — the naive "total field acts on each beam" form used
in `spin_eigenmode.py` v0.1 is exactly right, because s_B⁰ = −ê₁ flips the sign
of the self-compensation term. (For a general background this would NOT hold;
the solver is correct only for the symmetric counter-polarized setup.)

Structural classification of exchange vs §3: **algebraic (no F1), density-sourced
w = s_A + s_B (no F2), local (no F3)**. All three plasma features are absent.
Whether any of them is *essential* is precisely what T-S2 measures.

## 5. Magnitude of λ_xc in code units  **[sketch — factors of 2]**

Exchange precession rate for polarization P: ω_xc ≈ (2/ħ)|F₀^a| (n/ν₀) P
= 2|F₀^a| E_F P/ħ. SOC precession rate at the drift momentum (the code's clock):
ω_so = 𝒜_z v_drift = 2βk_drift/ħ. Ratio:

```
λ_code ≡ ω_xc/ω_so = |F₀^a| P E_F / (β k_drift) = |F₀^a| P (k_F/𝒜_z) (k_F/k_drift) / 1
```

GaAs numbers (soc_params.py): k_F/𝒜_z ≈ 127, k_drift/k_F ≈ 0.1, |F₀^a| ≈ 0.3,
P ≈ 0.2 ⇒ **λ_code ≈ 7–8**. Even with pessimistic P = 0.05: λ_code ≈ 2.
Conclusion: in code units where the YM campaigns have α·V0 ~ 0.1, the exchange
coupling is large, O(1)–O(10). If T-S2 finds the density-sourced algebraic
mediator supports growth at λ ≳ 0.1, materials deliver that coupling easily.

## 6. The structural gap, stated precisely

| Feature | plasma (YM) | solid (exchange) | separable T-S2 test |
|---|---|---|---|
| F1 integrator (1/γ²) | yes | no | `qstatic` keeps F1, removes retardation; `yukawa`/`exchange` remove F1 |
| F2 current source v_z·u | yes | no (density w) | `yukawa` keeps F2 with algebraic response; `exchange` uses w |
| F3 nonlocal kernel | yes | no (contact) | `yukawa` mass scan m: 0 → ∞ interpolates F3 → local |

Is there ANY solid mechanism that is current-sourced (F2)? A pure spin current
carries no charge current (no Oersted field); spin-current–spin-current
interactions are relativistically suppressed. Engineered feedback (spin-Hall
detection layer re-injecting a field) is conceivable but exotic — flag as a
device idea only if T-S2 shows F2 is essential.

## 7. Decision tree (fed by TS2_RESULTS.md)

- If growth survives the **exchange** closure (density-sourced, algebraic, local)
  at λ ~ O(1) → the solid supports a YM-like spin-KH mode; proceed to Paper E
  with the strong claim; T-S3 adds realism only.
- If growth survives **yukawa** (current-sourced algebraic) but not exchange →
  F2 is essential → realistic solids get only the kinematic exchange band
  (γ ≤ λ_xc, `spin_eigenmode.py` v0.1) — still an instability, but a different,
  weaker claim; reframe Paper E around it.
- If growth requires **qstatic**'s integrator (F1) → the gauge dynamics is
  essential; the solid analog fails structurally; write the mapping up as a
  negative/contrast result inside Paper B discussion instead of Paper E.

## 8. Corrections this derivation makes to earlier spinkh docs

1. MAPPING.md §5/§6 assumed the spin-KH mode requires *flow feedback* (T-S3).
   Wrong assumption: the plasma loop closes in the (mediator, q)-sector alone
   (§3); the gap is the mediator structure (§6). T-S3 remains useful physics
   (pressure, relaxation, Coulomb) but is not the gate.
2. `spin_eigenmode.py` v0.1 blocks: **confirmed** for the counter-polarized
   background (§4). Add a −1/τ_s diagonal (D'yakonov–Perel residual) when doing
   material feasibility; irrelevant for structure questions.
3. `soc_params.py` treats γ ~ 0.12·Ω_drive as the growth estimate; if the
   exchange-branch outcome of §7 applies, replace with γ ~ min(0.12·Ω_drive,
   λ_xc-band value from the kinematic solver) — revisit after T-S2.

## 9. Remaining [sketch] items for the next pass

- Factors of 2 in §5 (ν₀ spin convention; P definition).
- Momentum-equation force terms (T-S3): spin force f_x = (ħ/2)s¹v_z ∂x𝒜_z from
  the SU(2) field strength; exchange-gradient force −∂_i(b_xc·s); Fermi pressure
  closure P ∝ n² (2D). Derived structure matches MAPPING.md §6 stubs; signs
  unverified.
- The a=1 (background-channel) spin current correction (ħ𝒜_z/2m)n — feeds a
  static s¹ texture near the gate gradient; check it does not destabilize the
  background on its own.
- Beyond-fluid kinetics: the drift closure J_s = v_z s ignores the anisotropic
  part of the distribution; a two-moment (s, J_s) closure would capture
  D'yakonov–Perel self-consistently. Only needed if Paper E goes quantitative.
