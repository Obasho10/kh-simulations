# Outer-Region Growth Rates — Mechanism Investigation (2026-07-15)

Status hub for the deep-dive into what the "outer-region instability" actually
is. **Brief summaries only** — full numbers in `FINDINGS.md`
(§"Outer-region growth rates: mechanisms identified", 2026-07-15), derivations
in `PHYSICS.md` §10, program context in `PRESENTATION.md` §8.3/§8.4/item 3b.
All CPU analysis for this investigation runs on the lab iMac (`ssh imac`,
workspace `~/ym_kh/` — see CLAUDE.md §Server Setup).

## TL;DR

What the project has been calling "the outer-region instability" is **two
unrelated mechanisms**, and only one of them is an outer-region effect:

1. **Linear outer branch = tachyonic charged-wave instability of the frozen
   Az1 background.** Physical (in-model), not a numerical artifact. Color-2/3
   EM waves see the covariant wavenumber `kz_eff = kz ± α·Az1`; wherever
   `|α·Az1(ξ)| > kz` (i.e. `|ξ| > ξ_crit ≈ kz/(αV0) + ln2`) one circular
   polarization has `γ²(ξ) = α²Az1² − kz² > 0`. This is the *same term* that
   creates the WKB confining well — the outer branch is the well's own
   trapping mechanism escaping past its rim. Verified three independent ways
   (analytic local law, float64 CPU eigensolver, float32 CUDA rates agree; see
   FINDINGS). Predictable a priori; legitimately excluded by any window
   (sponge/xi_cut) inside ξ_crit. Energy source is the frozen Az1 — an
   infinite external battery; a self-consistent run would deplete it instead
   (physically: frozen chromo-backgrounds decay by charged-wave emission).

2. **The late-onset catastrophe (the "V0≥0.08 hard wall") is NOT an
   outer-region effect at all.** Direct 98-snapshot forensics on a failing
   xi_cut run shows every growing channel localized **at the shear layer,
   inside the window** (99.9% of density-perturbation power at |ξ|<5), with
   the outer region quiet. Mechanism: the physical KH mode reaches finite
   amplitude → its density response **cavitates** (nA_min: 1.0 → the 0.05
   code floor over t≈48–64, ~35 TU *before* the terminal energy jump at
   t=97.7) → the floored state survives for tens of TU → terminal blowup.
   V0 sets whether the mode is driven past the cavitation amplitude within
   100 TU (V0≤0.07 saturates benignly below it — confirmed by amplitude
   comparison across sibling runs). The eigensolver is blind to it **by
   construction**: nonlinear, and its state vector has no fluid n/p dof.

## Rejected hypotheses (tested, not just argued)

- *Outer color-1 two-stream at the retained kz as the late-catastrophe
  driver*: predicted onset times fit suspiciously well, but forensics kills
  it — PzA/nA growth is at the shear layer, not the |vz|≈V0 outer region.
  (The two-stream theory itself is validated: exact cold-beam cutoff
  `kV = √2` reproduces the documented kz_ts≈14 band at V0=0.1.)
- *Grid-scale noise from the wall discontinuity*: 5× hyperdiffusion only
  delays (documented earlier), and the cavitation is at k_mode, not Nyquist.
- *Numerical artifact (linearization/discretization) for the outer branch*:
  analytic law matches two independent discretizations; rates scale with
  physics (αAz1, kz), not grid.

## Practical consequences

- **Sweep validity**: plateau measurements completing before cavitation are
  clean — windowing removes only the background's own (model-artifact)
  instability, not shear physics. The xi_cut=5 production rule stands.
- **V0≥0.08 runs**: cap `target_tu` just past the plateau; cavitation time is
  when the mode amplitude crosses `A_cav` (≈1–2×10⁻² in spectral-amp units
  for the tested config; ≈10⁻² in timeseries-amp units) — monitor
  `timeseries` amp rather than trusting a fixed time.
- **xi_cut radius**: γ_exact varies only ~6% over radius 5→15 (measured), so
  radius does *not* buy growth-rate accuracy; looser radius shortens the
  post-cavitation survival time dramatically (t≈27 at r=15 vs >100 at r=5).
  Keep radius 5.
- The `find_safe_sponge.py` eigensolver screen is the right tool for
  mechanism 1 only; it can never certify against mechanism 2 — a full-length
  CUDA run (or amplitude projection) is the only check there.

## Tools added (all in `analysis/`, run on the iMac)

| script | what it does |
|---|---|
| `outer_region_theory.py` | `local`: γ_loc(ξ) envelope + tachyonic law; `validate`: eigensolver outer eigenvalues vs local prediction; `twostream`: exact cold-beam rates in code units |
| `catastrophe_forensics.py` | `extract` (run near data): reduces ym_*.csv snapshots to per-field kz-spectra, x-profiles, min-density trace; `analyze` (iMac): per-channel growth rates + localization |
| `onset_census.py` | population onset/creep statistics over all runs' energy.csv |

Data artifacts on the iMac: `~/ym_kh/forensics_diffkz.npz` (the 98-snapshot
reduction), `~/ym_kh/onset_census.csv`, `~/ym_kh/energy_pull/` (all t130/t140
energy histories as of 2026-07-15).

## Self-consistent (unfrozen Az1) test — DONE 2026-07-15/16 (t133)

Full numbers: FINDINGS.md §"Self-consistent (unfrozen Az1) test". Headlines:

- **Frozen approximation validated**: unfreezing Az1 leaves the tachyonic
  branch's linear rate unchanged (documented sp=52 blowup reproduced, γ=1.45
  vs eigensolver 1.43–1.46); unfrozen runs die ~3 TU *earlier*.
- **No depletion — the back-reaction has the opposite sign**: differencing
  seeded vs unseeded unfrozen runs isolates ΔAz1 ≈ −0.04·|a|² at the mode
  peak — the wave *deepens* the background. Confirmed at two independent
  configurations (sp=52/γ=1.45 and sp=42/γ=0.64); at the second, the law
  holds over four decades and lands exactly on the endpoint measurement
  (ΔAz1=−0.242 at |a|=2.46). The clean frozen-vs-unfrozen pair shows the
  net global effect is *weakly stabilizing* (unfrozen mode −7% in amplitude
  by |a|≈2.5 — annulus compression), two orders of magnitude too weak to
  saturate the branch. Saturation is by fluid nonlinearity, not background
  drain; the frozen approximation is accurate to a few percent.
- **A quiet self-consistent color-1 background does not exist**: three
  obstructions found — periodic-wrap vz-discontinuity collapse (fixed:
  `vz_edge_taper`), out-of-equilibrium By1 secular pump (fixed:
  `init_by1_eq`), and the kz=0 chromo-Weibel of the beams (γ=0.284 here,
  irreducible). The wrap collapse — not the Weibel alone — is the real
  reason `suppress_kz0=1` is mandatory in production.
- New code (committed): Az1 snapshot column (trailing, name-safe),
  `init_by1_eq`, `vz_edge_taper` .ini keys; `analysis/depletion_extract.py`.
  Experiment runs live on t133 `/DATA/ym_kh/ymgpu2d/outputs/*dep*`;
  reductions on the iMac (`~/ym_kh/dep_*.npz`, `dep3_*.npz`).

## Open items

- Post-cavitation survival-time dependence on window radius: characterized
  empirically, mechanism not pinned (suspect: cavitated-volume size).
- A V0=0.08–0.09 run with snapshots retained, to watch marginal cavitation
  directly (all controlled-series snapshot dirs except `diffkz` were cleaned).
- ~~Retrieve/analyze the sp=42 confirmation trio~~ — done 2026-07-16, see
  FINDINGS.md; the quadratic law and its coefficient are confirmed at
  |a|→O(1) and the frozen-vs-unfrozen growth comparison is settled.
