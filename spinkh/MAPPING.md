# MAPPING.md — Exact correspondence: SU(2) YM plasma ↔ spin-orbit-coupled electron fluid

Status: theory memo, first draft (2026-07-03). Everything in §1–§4 is established
literature restated in our notation. §5 is the open research question. §6 is a
*proposed* first-cut model — signs and O(1) factors must be re-derived carefully
(task T-S1) before anything is published.

---

## 1. SOC as an exact SU(2) gauge field (Tokatly 2008)

The single-particle Pauli Hamiltonian with any linear-in-momentum SOC can be
written exactly as a U(1)×SU(2) gauge theory:

```
H = (1/2m) ( p_i − e A_i − (ħ/2) σ^a 𝒜_i^a )²  + eφ + (ħ/2) σ^a 𝔅^a
```

where `𝒜_i^a` is a **non-dynamical SU(2) vector potential fixed by the material**
and `𝔅^a` any Zeeman-like field. Examples (2DEG in the i∈{x,z} plane, spin index
a∈{1,2,3}):

- **Rashba** `H_R = (α_R/ħ)(σ_x p_z − σ_z p_x)` → two non-commuting components of 𝒜
  → nonzero SU(2) field strength `F ∝ (2mα_R/ħ²)²` even for uniform α_R
  (this is the gauge-theory statement of the intrinsic spin-Hall effect).
- **Dresselhaus [110] well** `H_D = (β/ħ) σ₁ p_z` → **a single component**
  `𝒜_z^1 = 2mβ/ħ²`, all others zero.
- **Persistent-spin-helix (PSH) point** (Rashba = Dresselhaus, α_R = β): after a
  global spin rotation, again a single component `𝒜_z^1` survives
  (Bernevig–Orenstein–Zhang, PRL 97, 236601 (2006)).

**Key structural fact**: the [110]/PSH configurations realize *exactly* the gauge
choice of the YM code — `A_x = 0`, only `A_z^1 ≠ 0` ("color-1", z-direction).
For *uniform* β this potential has zero SU(2) field strength (it can be gauged
into helix coordinates — the PSH). For **spatially modulated** β(x) it cannot:

```
F_xz^1 = ∂_x 𝒜_z^1(x) ≠ 0     ↔     By1 = −∂_x Az1   in the YM code.
```

And β(x) profiles are *experimentally engineerable*: the Rashba/effective SOC
coefficient is gate-tunable (Nitta et al., PRL 78, 1335 (1997)); a patterned top
gate imposes a designer 𝒜_z^1(x) — the laboratory version of the log-cosh or
cosine Az1 backgrounds used in the campaigns. **The frozen-Az1 assumption,
an approximation in the plasma problem, is exact here: solids have no dynamical
SU(2) gauge field.**

## 2. Correspondence table

| YM code (`ymgpu2d/`) | SOC electron fluid | Notes |
|---|---|---|
| color index a = 1,2,3 | spin components (1 = PSH/[110] axis) | exact |
| coupling α_YM | κ ≡ 2m β̄ / ħ² × (unit length) | β̄ = SOC coefficient scale |
| frozen Az1(x) | gate-engineered SOC profile 𝒜_z^1(x)/κ | **exact & non-dynamical** |
| By1 = −∂ₓAz1 | SU(2) magnetic field F_xz^1 | spin-dependent Lorentz force = spin-Hall-type force |
| Q^a (color charge/particle) | local spin polarization s^a per carrier | |
| beams A/B: Q1=±1, vz=±V0·f(x) | counter-propagating spin-up/spin-down currents | **pure spin current**: J_charge = 0, J_spin = 2V0; injectable via spin-Hall effect, ferromagnetic contacts, or optical orientation |
| precession α·v_z·(Q×Az) | SOC precession Ω(k)×s with Ω^1 ∝ β k_z | the v_z factor is *exact* (Ω is momentum-linear) |
| dynamical Az2/Az3, Ex, Ez, By (colors 2,3) | **no direct analog** — see §5 | THE open question |
| Coulomb/charge sector (color-neutral here) | real U(1) Coulomb | screens charge perturbations |
| cold fluid (T=0, no pressure) | degenerate Fermi liquid | **must add Fermi pressure** (shared with roadmap T1.4) |
| numerical filters (BP=14, memset…) | momentum relaxation −p/τ_p, spin relaxation | real dissipation replaces artificial filters |
| ω_p = 1 unit | no plasma frequency for the spin sector | rate unit chosen by mapping, see §7 |
| kz_peak ≈ 2α (headline result) | pattern wavelength λ_peak ~ L_so, independent of shear width | the lab-testable claim, §8 |
| Dyakonov–Perel dephasing | suppressed for helix textures in PSH geometry | Koralek et al., Nature 458, 610 (2009): helix lifetime ×100 |

## 3. The geometry, translated

YM setup: shear layer at x = Lx/2 between beam A (Q1=+1, v_z=+V0·tanh(ξ/EPS)) and
beam B (Q1=−1, v_z=−V0·tanh(ξ/EPS)), background Az1(x), perturbations ∝ e^{ikz·z}.

Lab setup: a 2D channel (plane = (x, z)); z = transport direction, x = transverse.
Two counter-propagating spin-polarized streams — spin-↑ carriers drifting +z on one
side, spin-↓ drifting −z on the other, meeting in a shear layer of width W (device
geometry, ~0.5–5 μm). Requirements:

1. **Hydrodynamic regime**: l_ee ≪ W ≪ l_imp — demonstrated in GaAs
   (de Jong & Molenkamp, PRB 51, 13389 (1995)), graphene (Bandurin et al.,
   Science 351, 1055 (2016); Crossno et al., ibid. 1058; imaged Poiseuille flow:
   Sulpizio et al., Nature 576, 75 (2019)), PdCoO₂/WP₂ (Moll et al., ibid. 1061).
2. **PSH or [110] SOC**, ideally gate-modulated across x to shape 𝒜_z^1(x).
3. **Spin-current injection**: nonlocal spin valves (Lou et al., Nat. Phys. 3, 197
   (2007)), spin-Hall injection, or optical orientation.
4. **Imaging**: Kerr-rotation microscopy (how PSH itself was mapped — Walser et
   al., Nat. Phys. 8, 757 (2012)) or NV magnetometry, resolving μm-scale spin
   textures. Predicted signal: a stripe pattern in s²,s³ at wavelength λ_peak.

## 4. What carries over immediately

- The **eigenvalue-solver methodology** (1D linearized operator in x, sparse
  shift-invert, kz continuation) transfers wholesale; `spin_eigenmode.py` reuses
  the structure of `ym_eigenmode.py`.
- The **6-field eigenfunction seeding** lesson (C23 stray-mode problem): if we
  ever simulate this in 2D, seed all coupled fields consistently.
- The **precession-cascade physics** (Az2 growing at ~αV0 in the plasma runs) maps
  to the *kinematic* spin dynamics — precession of the injected polarization about
  the background SOC field. This is what the v0.1 kinematic solver computes.
- The **non-monotonic dispersion / coupling-selected kz_peak**, if it survives the
  closure change (§5), is the headline prediction.

## 5. THE open question: what replaces the dynamical gauge sector?

In the plasma, the instability loop is
`By2 → Ez2 → Az2 → Q3 → Q2 → Lorentz force → By2`
— its middle is *gauge-field dynamics* (retarded, wave-like, long-range).
A solid has no dynamical SU(2) field. Candidate carriers of the feedback:

1. **Electron–electron exchange (Fermi-liquid F₀ᵃ / Stoner mean field)** —
   the induced spin density s^a(r,t) generates an instantaneous, *local* effective
   Zeeman field b_xc^a = λ_xc·s^a. This is the leading candidate. Structurally it
   replaces the gauge propagator by its zero-range, zero-retardation (contact)
   limit — like giving the gauge boson a large mass. **Cross-check available in
   the plasma code (task T-S2): rerun `ym_eigenmode.py` with the EM sector taken
   to its instantaneous/static limit; if the mode survives, the exchange loop is
   plausible; if not, we know the retarded/wave character is essential and the
   solid-state analog must be rethought.**
   Note one structural difference: b_xc enters the precession as Ω += λ_xc·s
   (no v_z factor), whereas the dynamical Az2/3 entered as α·v_z·(Q×Az). The
   first-cut model (§6) keeps both terms with their correct structures.
2. **Dipolar (real magnetic) fields of the spin texture** — long-range but
   suppressed by (v/c)²; likely negligible; keep as a correction.
3. **Induced spin currents back-acting through SOC** — automatically included
   once the fluid feedback (flow perturbations) is in the model.

If (1) closes the loop, the instability survives with a renormalized coupling and
the project proceeds to Paper E. If nothing closes it, the honest outcome is a
damped-precession problem — worth knowing before more investment. **Task T-S1/T-S2
decide this; do them first.**

> **RESOLVED 2026-07-04** (DERIVATION.md + TS2_RESULTS.md): exchange **cannot**
> carry the YM-type loop — density-sourced local mediators are provably stable
> (Re γ ≤ 0); the loop requires a *current-sourced* mediator, which solids lack.
> The surviving (and material-strong) channel is the **exchange-band instability**
> of `spin_eigenmode.py`: γ up to ~√λ_xc-scale, λ_xc ≈ O(1)–O(10) in code units.
> Also note DERIVATION.md §8 corrects this memo's assumption that flow feedback
> (T-S3) gates the KH analog — the plasma loop closes without any flow feedback;
> the mediator structure was the real gate.

## 6. First-cut model (PROPOSED — re-derive before use, T-S1)

Per beam σ ∈ {A,B} (spin-↑ / spin-↓ dominant populations), fields n_σ, p_σ, s_σ^a.
Background: n=1, v_zσ(x) = ±V0 f(x), s_σ^1 = ±1, gate profile 𝒜(x) (in units where
the YM Az1 profiles can be reused verbatim).

Spin («color») dynamics — advection + precession about the total field:

```
∂s^a/∂t + ∇·(v s^a) = [ Ω × s ]^a
Ω^a = κ v_z 𝒜(x) δ^{a1}          (background SOC — exact, ↔ α v_z Az1)
    + κ v_z a_dyn^a               (dynamical part IF a gauge-like field exists — zero in solid)
    + λ_xc Σ_σ n_σ s_σ^a          (exchange mean field — the proposed loop carrier)
```

Momentum dynamics — Euler + spin forces + Fermi pressure + relaxation:

```
∂p_i/∂t + ∇·(v p_i) = − (1/n) ∂_i P(n)                    (Fermi pressure, P ∝ n²  in 2D)
                      − s^a v_z ∂_x 𝒜^a(x) κ ħ/2 · x̂_i     (SU(2) Lorentz force from background F_xz — TO VERIFY)
                      − (ħ/2) s^a ∂_i (λ_xc s_tot^a)        (exchange-gradient force — TO VERIFY)
                      − e(E_C + v×B)_i                      (real U(1) Coulomb)
                      − p_i/τ_p                              (momentum relaxation)
```

plus continuity and Poisson for the charge sector, and spin diffusion D_s∇²s^a as
the leading kinetic correction in the spin channel.

Linearization mirrors `ym_eigenmode.py`: perturbations ∝ e^{i kz z} ψ(x), assemble
the block operator in x, solve for eigenvalues γ = −iω. Blocks:
[s²_A, s³_A, s²_B, s³_B] (kinematic v0.1, implemented) ⊕
[δn_σ, δp_xσ, δp_zσ, φ_C] (flow feedback, stubbed — T-S3).

**Kinematic v0.1 (what `spin_eigenmode.py` currently solves)** — freeze the flow,
keep advection + background precession + exchange + spin diffusion:

```
(γ + i kz v_zσ) s_σ² = ± λ_xc (s_A³ + s_B³) − κ v_zσ 𝒜(x) s_σ³ + D_s ∂ₓ² s_σ²
(γ + i kz v_zσ) s_σ³ = ∓ λ_xc (s_A² + s_B²) + κ v_zσ 𝒜(x) s_σ² + D_s ∂ₓ² s_σ³
```

(upper sign σ=A with s_A¹=+1, lower σ=B with s_B¹=−1; from (Ω×s)² = Ω³s¹ − Ω¹s³
and (Ω×s)³ = Ω¹s² − Ω²s¹ with b_xc^{2,3} = λ_xc·s_tot^{2,3} and Ω¹ = κ v_z 𝒜.)
Local 4×4 analysis (uniform limit, s± = s²±is³) gives instability when
|kz·v_z − κ·v_z·𝒜 + λ_xc| < λ_xc, i.e. an **exchange-driven spin two-stream band**
— the spin analog of the plasma two-stream/precession-cascade family, present even
without flow feedback. This is the analog of the plasma
**precession cascade**; the KH-like mode requires the flow feedback (T-S3), exactly
as the plasma instability required the Lorentz-force closure.

## 7. Unit mapping (owned by `soc_params.py`)

Work in YM code units (length: EPS-multiples of the shear width; velocity: V0;
coupling: α) so all solver outputs compare directly to `ymgpu2d/FINDINGS.md`.
Conversion to SI:

- κ ↔ 2mβ̄/ħ² (inverse length): identify code `α × (code unit length)⁻¹` with 2mβ̄/ħ².
- The PSH helix wavevector is q₀ = 4mβ̄/ħ² ⇒ helix wavelength λ_so = πħ²/(2mβ̄).
- Code result kz_peak ≈ 2α ⇒ **λ_peak ≈ π/α_code → λ_peak ~ λ_so/2 up to O(1)** —
  set by SOC alone.
- Rates: the natural code rate at the peak is γ ≈ 0.1–0.17 in units where the
  precession scale κ·V0·|𝒜| sets the clock; `soc_params.py` evaluates this against
  1/τ_p, 1/τ_s, and the shear rate V0/W for real materials — the feasibility matrix.

## 8. Predictions (to sharpen after T-S1–T-S4)

1. **Coupling-selected wavelength**: spin-texture stripes at λ_peak ~ λ_so/2,
   *independent of the shear-layer width* W, tunable in situ by gate voltage
   (β̄ ↦ β̄(V_g)). Contrast: any hydrodynamic KH texture would scale with W.
2. **Non-monotonic dispersion** in kz if the exchange closure preserves it
   (T-S4 quantifies).
3. **Threshold in drift velocity / SOC strength** from the relaxation budget:
   instability requires γ(V0, β̄) > 1/τ_s(helix); PSH geometry maximizes τ_s for
   precisely the helix-like textures produced.
4. Onset visible as a spin-noise / Kerr-signal line at the pattern wavevector.

## 9. Literature anchor list

- I. V. Tokatly, PRL 101, 106601 (2008) — exact SU(2) formulation of SOC.
- P.-Q. Jin, Y.-Q. Li, F.-C. Zhang, J. Phys. A 39, 7115 (2006) — SU(2)×U(1) theory of spin transport.
- B. A. Bernevig, J. Orenstein, S.-C. Zhang, PRL 97, 236601 (2006) — persistent spin helix.
- J. D. Koralek et al., Nature 458, 610 (2009) — PSH observation, helix lifetime enhancement.
- M. P. Walser et al., Nat. Phys. 8, 757 (2012) — direct PSH mapping (Kerr).
- J. Nitta et al., PRL 78, 1335 (1997) — gate-tunable Rashba coupling.
- M. I. Dyakonov, V. I. Perel (1971) — spin relaxation by precession.
- Hydrodynamic electron flow: de Jong & Molenkamp, PRB 51, 13389 (1995); D. Bandurin et al., Science 351, 1055 (2016); J. Crossno et al., Science 351, 1058 (2016); P. J. W. Moll et al., Science 351, 1061 (2016); J. A. Sulpizio et al., Nature 576, 75 (2019).
- Spin injection/valves: X. Lou et al., Nat. Phys. 3, 197 (2007).
- Spin hydrodynamics / spin superfluidity: E. B. Sonin, Adv. Phys. 59, 181 (2010); S. Takei & Y. Tserkovnyak, PRL 112, 227201 (2014).
- Graphene proximity SOC: J. O. Island et al., Nature 571, 85 (2019) and refs therein.
- (Plasma side, for the paper's framing): Tokatly-style mapping makes this the
  condensed-matter member of the same family as the `ymgpu2d` campaigns; cite the
  YM paper(s) once out.

## 10. Failure modes / honesty box

- If T-S2 shows the plasma mode dies in the instantaneous limit → exchange cannot
  carry the loop → downgrade to "driven precession textures" note, or find a
  retarded channel (none obvious). Decide before Paper E is promised.
- Charge sector: Coulomb screening may pin δn and block the density branch of the
  feedback; the spin branch (which is the interesting one) should survive — verify
  in T-S3.
- Landau damping / kinetic effects beyond fluid: the fluid description needs
  l_ee ≪ λ_peak; check per material in `soc_params.py` (it does).
- Heating at the required drift velocities; keep v_drift ≪ v_F (script checks).
