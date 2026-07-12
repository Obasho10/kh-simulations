# spinkh — Spin-Kelvin-Helmholtz in Spin-Orbit-Coupled Electron Fluids

Exploration of the condensed-matter realization of the `ymgpu2d/` SU(2) Yang-Mills
shear-instability program. Core observation: **the Pauli equation with spin-orbit
coupling (SOC) is exactly a U(1)×SU(2) gauge theory in which the SU(2) vector
potential is a fixed, material-defined background** (Tokatly, PRL 101, 106601
(2008)). The frozen-Az1 approximation of the plasma simulations — its most
criticizable assumption — is the *exact* physical situation in a solid.

Target result: a shear layer between counter-propagating spin-polarized electron
currents in a hydrodynamic conductor is unstable to a spin-texture mode whose
wavelength is set by the spin-orbit precession length L_so (gate-tunable), **not**
by the shear-layer width — the condensed-matter translation of the
`kz_peak ≈ 2α` coupling-selected wavelength found in the YM campaigns.

## Contents

| File | Role |
|------|------|
| `MAPPING.md` | Theory memo: exact YM ↔ SOC correspondence, gauge structure, the dynamical-sector question, first-cut model equations, predictions, materials, literature |
| `soc_params.py` | Runnable: material parameter tables (GaAs PSH quantum well, graphene/WSe₂), derived scales (L_so, precession rates, hydrodynamic window), feasibility matrix |
| `spin_eigenmode.py` | First-cut 1D linearized eigenvalue solver (kinematic limit: spin advection + SOC precession + exchange closure + spin diffusion; flow-feedback blocks stubbed with TODOs) — structure mirrors `ymgpu2d/ym_eigenmode.py` so results are directly comparable |
| `DERIVATION.md` | T-S1: derivation from the Pauli/Tokatly Hamiltonian; loop-topology analysis (integrator / current-source / nonlocality); λ_xc magnitude; corrections to MAPPING.md |
| `ym_eigenmode_static.py` | T-S2: mediator-replacement experiments on the plasma eigenproblem (full / qstatic / yukawa / exchange closures) |
| `TS2_RESULTS.md` | T-S2 numerical results and verdict (2026-07-04) |

## Task list

Phase 0 — setup (this session)
- [x] Mapping memo (`MAPPING.md`)
- [x] Parameter/feasibility script (`soc_params.py`)
- [x] Kinematic-limit solver skeleton (`spin_eigenmode.py`)

Phase 1 — theory (no GPU needed)
- [x] **T-S1** (first pass, 2026-07-04): derivation in `DERIVATION.md`. Key
      outcomes: v0.1 solver blocks confirmed (incl. self-exchange cancellation);
      SOC precession = YM structure exactly; λ_xc ≈ O(1)–O(10) in code units;
      the plasma loop needs NO flow feedback — the gate is the mediator
      structure. Remaining [sketch] items listed in DERIVATION.md §9.
- [x] **T-S2** (2026-07-04): `ym_eigenmode_static.py` + `TS2_RESULTS.md`.
      **Verdict: the YM spin-KH loop does NOT transfer to exchange-mediated
      solids** — density-sourced local mediators are provably stable (Re γ ≤ 0);
      only current-sourced mediators grow, and no solid interaction is
      spin-current-sourced. **What survives: the exchange-band instability**
      (spin_eigenmode.py), which at material-realistic λ = 0.5–5 gives
      γ = 0.26–1.8 code units (≈ √λ scaling, bulk counterflow region) — far
      above the relaxation rates that killed the KH-analog estimate.
- [ ] **T-S2b (NEW, from verdict)**: novelty check vs spin-transfer-torque /
      current-driven magnon instability literature (Slonczewski; PSH under
      current) — decide what is genuinely new in the exchange-band mode
      (hydrodynamic two-beam geometry, SOC-tunable band, shear localization?).
- [ ] **T-S3** (re-scoped): flow-feedback blocks in `spin_eigenmode.py` now
      matter for the band mode's *saturation and realism* (pressure, −p/τ_p,
      Coulomb), not its existence. Also add −1/τ_s diagonal.
- [ ] **T-S4** (re-scoped): map the exchange-band dispersion γ(kz, λ, κ𝒜, V0);
      find whether an SOC-controlled kz-selection survives (descendant of the
      wavelength-selection claim); update `soc_params.py` verdict logic to use
      the band growth rate (DERIVATION.md §8.3).

Phase 2 — the exchange-band program (re-aimed after the T-S2 verdict)

The target mode is now the **exchange-band instability** of counter-streaming
spin currents: local dispersion γ = √(λ² − (Δ+λ)²) with detuning
Δ = v_z(kz − κ𝒜(x)), band −2λ < Δ < 0, γ_max = λ_xc, peak at
kz* ≈ λ_xc/V0 − κ|𝒜| (pattern wavelength = drift velocity / exchange
precession rate, SOC-shifted). See `BAND_THEORY.md`.

Phase 2A — linear theory completion (local Python; days)
- [x] **A1** (2026-07-04): analytic band theory → `BAND_THEORY.md` (local
      dispersion, unstable side, resonance surfaces, kz* selection law,
      soft high-kz tail via shear-layer marginal sliver, diffusive cutoff).
      Validated against solver scans (kz* and γ_max=λ confirmed).
- [x] **A2** (2026-07-04, first pass): band maps → `band_map.py`,
      `band_map.npz`, `plots/band_map.png`. Selection law confirmed over
      20× in λ (γ_max/λ = 0.96–1.00); sharp high-kz cutoff found at small λ
      (clean spectral selection where it matters); SOC/gate control acts on
      the LOW-kz band edge (flank lift, ×2 at kz=0.25 for κ 0→4), while
      λ_xc/V0 sets the peak — two independent experimental knobs. Details
      in BAND_THEORY.md §8. Remaining: gate-modulated 𝒜(x)
      designer-localization study (A2b).
- [x] **A2b** (2026-07-04, first pass): designer islands → `a2b_designer.py`,
      `plots/a2b_designer.png`, BAND_THEORY.md §10. Gate island depth selects
      kz exactly (peaks at κA_g − λ/V0 = 10/14/18, γ ≈ λ, mode AT the island,
      background stable there); island position places the mode (~1 ξ-unit
      systematic on the v_z<0 side, unexplained — second-pass item). Both
      texture wavelength and position are gate-programmable.
- [x] **A3** (2026-07-04): threshold → `a3_threshold.py`,
      `plots/a3_threshold.png`, BAND_THEORY.md §9. Key structural result: the
      band mode decouples EXACTLY from flow/density/Coulomb at linear order —
      threshold is spin-dissipation-only. Flank law γ=√(2λV0(kz+κ|𝒜|))
      validated (33 pts, ±10%); threshold law V0_c = (1/τ_s)^{3/2}√D_s/(0.65λ)
      confirmed numerically to 2%. Material budget (`soc_params.py
      band_budget()`): **GaAs PSH supercritical by 28–124×**, γ_net ~ 1e11 s⁻¹,
      3–22 μm Kerr-imageable patterns; graphene/WSe₂ marginal. D_s,eff now
      ANCHORED TO MEASUREMENT (2026-07-04): Weber et al., Nature 437, 1330
      (2005), n=1.9e11 sample ⇒ D_s ≈ 1e-2 m²/s flat 5–300 K → v_c ≈ 118 m/s,
      margin ≈ 169×, γ_net ≈ 3e11 s⁻¹, pattern ≈ 2.0 μm. Remaining caveat:
      longitudinal→transverse D_s proxy (O(1) at P ≲ 0.2).
- [ ] **A4**: real frequencies Re(ω) and phase velocities of the band modes
      (sets the noise-spectrum peak in experiments).

Phase 2B — literature identity (before any writing)
- [x] **B1** (2026-07-04): novelty check done → `B1_LITERATURE.md`.
      **Verdict: proceed with Paper E** — the configuration (counterflow-driven
      exchange band in a paramagnetic 2DEG, SOC/gate band control, threshold +
      material budget) is unclaimed. Anchors: Castaing family (gradient-driven,
      ³He/cold atoms) and Bazaliy/spin-wave-Doppler family (STT, ferromagnets);
      PSH-drift experiments (Kunihashi/Altmann) provide the device platform
      minus the instability; spin Coulomb drag (Weber et al. 2005) pins D_s,eff.
      Residual risk: under-indexed JETP-era Silin-wave literature — recheck via
      citation trails when drafting.

Phase 2C — nonlinear saturation on GPU (reuses ymgpu2d; weeks)
- [ ] **C1**: new run mode `SPIN_EXCHANGE` in ym_coupled: drop the Maxwell
      sector; add one kernel b_xc^a = λ·(n_A Q_A^a + n_B Q_B^a); reuse
      kernel_ym_precession with Zeeman structure + frozen SOC background;
      pressure + −p/τ_p sources.
- [ ] **C2**: validate linear growth vs solver via eigenfunction seeding
      (existing machinery).
- [ ] **C3**: saturation study: what saturates the mode; saturated texture
      amplitude; effective spin-current degradation rate above threshold
      (→ the spin-valve-collapse observable).

Phase 2D — prediction paper
- [ ] **D1**: update `soc_params.py` to budget against the band rate; materials
      shortlist (GaAs PSH wells primary); package threshold current density,
      texture wavelength 2π·v_d/ω_xc, noise-peak frequency, gate-tunability
      curve. Paper E: "Exchange-band instability of counter-streaming spin
      currents in spin-orbit-coupled electron fluids" (PRB; PRL case if A2b
      shows clean gate-controlled selection and B1 confirms the setting is new).

## Relationship to ymgpu2d

Everything here is in **YM code units** (lengths in EPS-multiples, velocities in
V0, coupling α) so any solver output is directly comparable to the campaign tables
in `ymgpu2d/FINDINGS.md`. `soc_params.py` owns the conversion to SI/material units.
The warm-fluid closure task (RESEARCH_ROADMAP.md T1.4) is shared infrastructure:
degenerate Fermi pressure here = thermal pressure there.
