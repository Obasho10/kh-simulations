# LITERATURE.md — Novelty survey for the SU(2) Yang–Mills shear-instability program (2026-07-18)

Method: ~11 targeted web searches (arXiv, INSPIRE-adjacent, journal landing pages)
across the plasma, heavy-ion, cosmology, dark-matter, and cold-atom literatures,
plus abstract fetches of the closest hits. Scope: the `ymgpu2d/` program (colored
two-fluid shear instability). The condensed-matter sibling has its own rigorous
check in `spinkh/B1_LITERATURE.md` (2026-07-04, verdict: proceed).

## 0. Verdict

**No published Kelvin–Helmholtz / shear-flow-driven instability analysis of a
non-Abelian plasma was found.** The terms "chromo-Kelvin-Helmholtz" / "color
Kelvin-Helmholtz" do not appear in the literature. The core configuration —
counter-streaming color-charged fluids in a non-Abelian background, with a
measured dispersion relation γ(k_z; α, V0), an exact eigensolver + exact-action
WKB stack, a growth ceiling (αV0²)^{1/3}, and coupling+containment wavelength
selection — appears unclaimed. All the *ingredients* exist separately in
established literatures (colored two-fluid equations, tachyonic gauge
backgrounds, anisotropy-driven chromo-instabilities, Abelian electron-KH),
which is the favorable case: a recognized frame with an unclaimed center.

Residual risk: this was a web-search survey, not an INSPIRE citation-trail
audit. Before submitting Paper A/B, walk the citation trails of Mrówczyński's
Physics Reports review and Csernai's KH paper (the intersection set is small)
— same protocol as spinkh B1's JETP-era caveat.

## 1. The landscape, by family

### 1a. Abelian heritage: EMHD shear instabilities (the program's direct ancestor)

| Work | Relation |
|---|---|
| [Das & Kaw, Phys. Plasmas 8, 4518 (2001)](https://doi.org/10.1063/1.1399059) — nonlocal sausage instability of EMHD current channels | The reference paper in this repo (`4518_1_online.pdf`) and the source of the Fortran code (`emhd_original_fortran/`). Abelian. |
| [Nonlinear EMHD simulations of sausage instability, Phys. Plasmas 10, 29 (2003)](https://pubs.aip.org/aip/pop/article-abstract/10/1/29/460831) | Nonlinear follow-up, same family. |
| [Velocity-shear-driven 3D EMHD instability, Phys. Plasmas 19, 072103 (2012)](https://pubs.aip.org/aip/pop/article-abstract/19/7/072103/109604) and [2D shear-driven EMHD, Phys. Plasmas 16, 072310 (2009)](https://pubs.aip.org/aip/pop/article-abstract/16/7/072310/263102) | The electron-KH "sausage mode" program: established Abelian velocity-shear instability at skin-depth scales. |
| [Electromagnetic electron-KH PIC study (arXiv:2503.00593, 2025)](https://arxiv.org/pdf/2503.00593) | Shows the Abelian electron-KH frontier is still active. |

**Positioning**: this program is cleanly the SU(2) generalization of that
lineage — same geometry (counter-streaming skin-depth-scale shear), new
ingredient (color precession about a non-Abelian background). Cite the lineage
explicitly; it also explains the code heritage (FCT kernels).

### 1b. Chromo-instabilities of the QGP — anisotropy-driven, never shear-driven

| Work | Relation |
|---|---|
| [Mrówczyński, color filamentation (hep-ph/9606442)](https://arxiv.org/pdf/hep-ph/9606442); [chromodynamic Weibel (nucl-th/0303021)](https://arxiv.org/abs/nucl-th/0303021) | Canonical chromo-Weibel: free energy from *momentum-space anisotropy*. Our kz=0 Weibel anchor (0.5% WKB match) is in this family. |
| [Mrówczyński, Schenke, Strickland, "Color Instabilities in the QGP", Phys. Rep. 682 (2017)](https://www.sciencedirect.com/science/article/abs/pii/S0370157317300571) | The review that defines the field; the referee pool. |
| Hard-loop + lattice sims: [Rebhan et al. 1D+3V (0802.1714)](https://arxiv.org/pdf/0802.1714), [SU(3) instability sims (0812.3859)](https://arxiv.org/pdf/0812.3859), [extreme anisotropy (0706.0490)](https://arxiv.org/pdf/0706.0490), [glasma instabilities (0903.2930)](https://arxiv.org/pdf/0903.2930) | Mature simulation methodology for anisotropy-driven modes. None impose a sheared flow profile. |
| [Manuel & Mrówczyński, chromohydrodynamics (hep-ph/0606276)](https://arxiv.org/abs/hep-ph/0606276) | **Closest model-level prior art**: colored two-fluid ("chromo-hydrodynamic") equations derived from kinetic theory; finds a *two-stream* instability in linear response. No shear layers, no KH geometry, no eigensolver dispersion maps, no nonlinear/2D simulation of the fluid model. Must be cited as the model's pedigree. |
| Jackiw–Nair–Pi non-Abelian fluid mechanics (PRD 62 (2000); PRD 67 (2003)); [KK/holographic non-Abelian hydro (1605.06080)](https://arxiv.org/abs/1605.06080); [dissipative non-Abelian fluids (2605.23842, 2026)](https://arxiv.org/pdf/2605.23842) | Formal theory of colored fluids — equations, not shear-instability analyses. |
| Recent adjacent: SU(2) eigenstate thermalization / chaos (EPJ ST 2025), [glasma Lyapunov exponents (2601.19679)](https://arxiv.org/pdf/2601.19679) | Active field, none on shear. |

**The claim "shear-flow counterpart of the chromo-Weibel instability" survives
the survey** — the free-energy source (velocity shear vs momentum anisotropy)
cleanly separates this program from the entire family.

### 1c. KH in heavy-ion collisions — Abelian hydro only

[Csernai, Cheng, Horvát, Magas, Strottman, Zétényi, PRC 85, 054901 (2012)](https://journals.aps.org/prc/abstract/10.1103/PhysRevC.85.054901)
and successors ([viscous-hydro KH code, EPJ C 77 (2017)](https://link.springer.com/article/10.1140/epjc/s10052-017-4944-0))
treat the QGP droplet as an ordinary (color-neutral) viscous fluid; color
degrees of freedom play no role in the instability. Cite as motivation
(vorticity is measured — STAR Λ-polarization), distinguish sharply.

### 1d. Tachyonic gauge-field backgrounds — the outer branch has a family name

The program's outer tachyonic branch (γ² = α²Az1² − k_z², one circular
polarization destabilized where |αAz1| > k_z; PHYSICS.md §10a) is structurally
a **Nielsen–Olesen-type instability** (charged vector modes on a strong color
background, γ ~ √(gB), stabilized when background inhomogeneity k² > gB;
Nielsen & Olesen, NPB 144, 376 (1978)). Active descendants in glasma decay:
[monopole production (1308.3914)](https://arxiv.org/pdf/1308.3914),
[glasma decay (1406.2051)](https://arxiv.org/pdf/1406.2051),
[anomalous gluon production (1208.5320)](https://arxiv.org/pdf/1208.5320).

**Consequence**: OUTER_REGION.md / PHYSICS.md §10a should cite Nielsen–Olesen
— the mechanism class is known (independent corroboration of that piece of
physics). What is ours: its role as the *confining well* of the shear branch
(the well/tachyon duality across ξ_crit) and its interaction with window
design in the measurement program.

### 1e. Dark-sector application (Paper D) — U(1) done in 2024–25, non-Abelian explicitly open

| Work | Relation |
|---|---|
| [Heikinheimo et al., collisionless shocks in mergers (1504.04371)](https://arxiv.org/abs/1504.04371); Ackerman et al. PRD 79, 023519 (2009); Lasenby 2020 | The dark-U(1) plasma-instability program the roadmap already cites. |
| [**"Dark plasmas in the nonlinear regime: constraints from PIC simulations", PRD 111, 095031 (2025) / arXiv:2411.11958**](https://arxiv.org/abs/2411.11958) | PIC simulations of dark U(1) streams in cluster mergers through saturation → effective σ/m. **This is the template for Paper D, and it flags non-Abelian dark sectors as future work.** The non-Abelian version is confirmed open — and this is the adjacent group most likely to move into it. |

Non-Abelian-specific observable to lead with: coupling-set coherence length of
the generated dark fields (vs the Weibel scale of the U(1) papers).

### 1f. Cold atoms / BEC realizability (Paper A paragraph)

KH and counter-superflow instabilities in multicomponent BECs are established
and active: [Takeuchi et al. PRA 81, 063623 (2010)](https://arxiv.org/pdf/1009.1740)
(crossover paper), [three-component KH/CSI (2603.19207, 2026)](https://arxiv.org/html/2603.19207),
[SOC-BEC dynamical-instability patterning (2302.05101)](https://arxiv.org/html/2302.05101),
[skyrmion textures from quantum KHI (2408.11217)](https://arxiv.org/pdf/2408.11217).
None establishes a *coupling-selected* (vs geometry-selected) wavelength via a
synthetic SU(2) gauge field — the realizability paragraph and its
discriminating prediction stand. Cite Takeuchi and the 2026 three-component
paper; the field is moving.

### 1g. Axion–SU(2) cosmology (khaxn connection)

Tachyonic amplification of gauge perturbations on SU(2) backgrounds is a large
active literature: [perturbations in chromo-natural inflation](https://www.researchgate.net/publication/236737311_Perturbations_in_Chromo-Natural_Inflation),
[backreaction of axion-SU(2) dynamics (2311.07557)](https://arxiv.org/pdf/2311.07557),
[magnetogenesis from axion-SU(2) (2408.17413)](https://arxiv.org/pdf/2408.17413).
Closest cosmological cousin of the frozen-Az1 setup (homogeneous SU(2) vevs
whose perturbation stability is a live question). Motivation-section material;
no competitor on the shear result.

### 1h. Kinetic-level relatives (referee-risk mitigation)

[Colored particle-in-cell (CPIC) for glasma jets/heavy quarks (2303.05599)](https://arxiv.org/pdf/2303.05599)
and the Wong-equation machinery exist and are actively used. The predictable
referee line from the QGP-instability community is "cold two-fluid is too
crude" — the planned defenses are T1.4 (warm closure, now implemented) and
T3.2 (Wong-particle spot-check), both already on the roadmap. This survey
confirms both are worth their cost.

## 2. Delta list — what appears to be new

No hit found claiming any of the following:

1. **The configuration**: a velocity-shear (KH-type) instability of
   counter-streaming, oppositely-color-charged fluids under dynamical SU(2)
   fields — as opposed to anisotropy-driven (chromo-Weibel family) or
   beam-compression two-stream (chromohydrodynamics) drives.
2. **The dispersion program**: measured γ(k_z; α, V0) maps with a three-level
   validation stack (exact-action WKB ← 1D eigensolver ← 2D GPU simulation)
   for any non-Abelian fluid instability.
3. **The selection law**: growth ceiling γ ≤ (αV0²)^{1/3} from precession
   resonance, and confinement-set peak k_z,peak ≈ αV0·ξ_w + (α/V0)^{1/3} —
   wavelength selected by coupling + containment, not flow-profile width.
4. **The application deltas**: non-Abelian dark-sector merger instability
   (U(1) version published 2025, non-Abelian flagged open); SU(2)-synthetic-
   gauge coupling-selected wavelength in BEC counterflow.

## 3. What the survey says must be added to the papers

- **Cite as pedigree/positioning** (currently absent from project docs):
  Manuel & Mrówczyński (model equations), Nielsen–Olesen (tachyonic branch,
  in PHYSICS.md §10a), Das & Kaw + EMHD-KH lineage (Abelian ancestor),
  Mrówczyński–Schenke–Strickland review (field definition), Csernai (Abelian
  KH in QGP — distinguish), arXiv:2411.11958 (dark-U(1) PIC — Paper D
  template and urgency).
- **Do before submission**: INSPIRE citation-trail audit (Mrówczyński review ∩
  Csernai citers); keep the T1.4 warm run and T3.2 kinetic spot-check on the
  critical path — they answer the one predictable referee objection.
- **Urgency note**: the dark-plasma PIC group is one "try SU(2)" decision from
  the Paper D territory; the BEC-KHI community published a three-component
  generalization in 2026. The window is open but neighboring fields are moving.
