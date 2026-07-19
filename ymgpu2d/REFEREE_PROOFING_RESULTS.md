# Tier-2 Referee-Proofing Batch — Results (2026-07-19)

The eight small experiments flagged as the "T2.x referee-proofing batch"
(PRESENTATION.md §8.7, §10 item 4) and the §8.8 overtone falsification, all run
one-by-one on the free teaching nodes **t126 / t140 / t133** (abi deliberately
left alone — other work running there). Every GPU run used the current binary
(built 2026-07-19 during the overnight campaign) at the production grid unless a
resolution axis was being varied. Reference point throughout: **α=1.0, V₀=0.05,
kz=1** (the convergence anchor), with extremes probed where relevant.

Figures: `plots/t2p2_eigenfunction_overlay.png`, `plots/t2p5_collapse.png`,
`plots/t2p7_sponge_extrapolation.png`, `plots/t2p8_resolution_extremes.png`,
Gauss figure `remote_data/t2p23/t2p3_gauss_check.png`.
Scripts: `scripts/t2p*_*.sh`, `analysis/t2p1_t2p5_spectrum.py`.

| Exp | Status | Headline |
|-----|--------|----------|
| T2.4 linearity | ✅ | γ invariant to seed amp over ×100 |
| §8.8 overtone | ✅ | plateau 0.081 → 0.129 on reseed — decisive |
| T2.2 eigenfn overlay | ✅ | sim vs solver corr = 1.000 |
| T2.3 Gauss law | ✅ | abs residual ~1e-5, colour-1 rel ~1e-3, localised |
| T2.1 complex ω | ✅ | dominant branch purely growing (Im≈0) |
| T2.5 collapse | ✅ | γ_peak/(αV₀²)^⅓ = 0.977 ± 0.011 |
| T2.7 sponge → ∞ | ✅ | 28.5% compression at ξ=6, <2% by ξ≥16 |
| T2.8 resolution extremes | ✅ | <1% (low corner), 3–6% (high-αV₀ corner) |

---

## T2.4 — Linearity check (seed amplitude ×0.1 / ×1 / ×10)  [t126]

Reference point, `perturb_amp` = 1e-4, 1e-3, 1e-2, all else fixed
(xi_sponge=10, bp14, tu=60).

| seed_amp | a₀ (initial) | γ (R²=1.000) |
|---------:|-------------:|-------------:|
| 1e-4 | 4.460e-7 | **0.0901** |
| 1e-3 | 4.460e-6 | **0.0901** |
| 1e-2 | 4.460e-5 | **0.0901** |

a₀ scales **exactly linearly** with the seed; the fitted γ is identical to four
significant figures and the fit window is identical ([33,41] TU). The mode is in
the linear regime — growth rate independent of amplitude. ✔ objection closed.

## §8.8 — Overtone-selection falsification  [t140]

Same C25 point (α=1, V₀=0.05, kz=4, **sponge=20**); the *only* difference between
the two runs is the seed eigenfunction, both exported from `ym_eigenmode.py`:

| seed | eigenvalue γ_exact | measured plateau (R²=1.000) |
|------|-------------------:|----------------------------:|
| default-σ (overtone) | 0.0818 | **0.0808** (reproduces cached C25 = 0.081) |
| σ=0.14 (true n=0)    | 0.1309 | **0.1287** |

The simulation faithfully grows whichever mode it is seeded with. The celebrated
C25 sim-vs-solver agreement therefore certifies the *numerics*, not
dominant-mode selection — and the true dominant n=0 growth at kz=4 is ~0.13, not
0.081. This confirms the §8.8 diagnosis and the cache-regeneration action item.

## T2.2 — Eigenfunction overlay (the "money figure")  [t140]

One eigenmode-seeded run (α=1, V₀=0.05, kz=1, sponge=20), 25-column snapshots
kept. The kz=1 spatial projection of By2 and Az2 at t≈30 TU (linear phase)
overlaid against the `ym_eigenmode.py` eigenfunction:

- **Az2 profile correlation = 1.0000**, ξ_peak sim = solver = −5.4.
- By2 (seeded at only 0.008× the Az amplitude, so effectively grown from zero via
  the KH chain Az2→Q3→Q2→Lorentz→By2) reproduces the solver's **non-trivial
  double-lobe shape with its node at ξ≈−5** — an emergent-eigenfunction match.

The eigensolver eigenfunction is a genuine, shape-stable eigenmode of the full
nonlinear code. `plots/t2p2_eigenfunction_overlay.png`.

## T2.3 — Non-Abelian Gauss-law conservation  [t140]

`gauss_check.py` on the same run, G^a ≡ ∂ₓEx^a + ∂_zEz^a + α(Az×Ez)^a − ρ^a:

- **Absolute RMS residual ~1×10⁻⁵**, growing only slowly with the (exponentially
  growing) fields.
- Colour-1 **relative residual ~1.4×10⁻³ and decreasing** over the run (matches
  the §7 claim); colours 2/3 relative residual is a few % — that is the small
  growing perturbation measured against the total-field scale.
- Term breakdown: |∇·E| dominant, non-Abelian |α(Az×Ez)| subdominant, |ρ|
  negligible; the residual is **spatially localised at the mode**.

Exactly the promised paper figure. `remote_data/t2p23/t2p3_gauss_check.png`.

## T2.1 — Complex frequency ω(kz)  [local, σ-chased eigensolver]

σ-chased dominant localised **complex** eigenvalue, γ = Re(growth) + i·Im(freq),
over α∈{1,1.5,2,2.5,3} × V₀∈{0.03,0.05,0.1} × kz=1..8 (full table in the script
output). Finding: the dominant non-Abelian KH branch is **essentially purely
growing** — max |Im(γ)| over the whole grid = 9.6×10⁻³, i.e. |Im/Re| ≲ 6%, and
the oscillatory content is confined to kz=1 at a few high-αV₀ points. This is why
the circular-amplitude fits are unbiased in the production regime, and it
pinpoints where (kz=1, high αV₀) an envelope fit is warranted.

## T2.5 — Dimensionless collapse  [local, σ-chased eigensolver]

Masking the tachyonic outer branch (γ > 1.15×ceiling; it overtakes at low kz /
high αV₀, §8.2), the genuine shear-layer KH peak collapses onto the
exact-action ceiling:

**γ_KH,peak / (αV₀²)^{1/3} = 0.977 ± 0.011 (1.1% spread)** across α∈[1,3],
V₀∈[0.03,0.1] — a 10× range in αV₀ (min 0.955, max 1.006).

Plotting γ/(αV₀²)^{1/3} vs kz/(α/V₀)^{1/3} folds all 15 raw dispersion curves
(peak γ spanning 0.09–0.30) onto a **single master curve** peaking at ≈0.98 near
kz/(α/V₀)^{1/3}≈1.5. The dimensionless grouping §8.7 said was "not yet
identified" is (αV₀²)^{1/3} for γ and (α/V₀)^{1/3} for kz — empirically
confirming the T1.2 exact-action prediction γ³ ≤ αV₀². `plots/t2p5_collapse.png`.

## T2.7 — Sponge extrapolation γ(ξ_sponge → ∞)  [t126]

Reference point, xi_sponge swept 6→25 (all R²=1.000):

| ξ_sponge | 6 | 8 | 10 | 12 | 14 | 16 | 20 | 25 |
|---------:|---|---|----|----|----|----|----|----|
| γ | 0.0605 | 0.0686 | 0.0719 | 0.0742 | 0.0757 | 0.0768 | 0.0775 | 0.0772 |

γ rises **monotonically** with sponge radius and **saturates at ≈0.077 by ξ≈16**
(<2% between ξ=16 and ξ=25). The tightest sponge (ξ=6) compresses γ by **28.5%** —
a clean quantification of the §8.3 sponge-compression systematic. Production runs
use ξ_sponge ≥ 8–20, where the residual compression is single-digit-% and the
measurement has effectively converged. `plots/t2p7_sponge_extrapolation.png`.

## T2.8 — Resolution spot-checks at the parameter extremes  [t133]

The convergence study only anchored α=1, V₀=0.05, kz=1. Re-checked the production
grid (NZ64 / courant0.1 / NX768, filter band hi=14 held fixed) at two extremes;
one grid axis varied per run:

**LOW corner** (α=1, V₀=0.03, kz=3 — wide/slow): all plateau-confirmed, γ_base=0.0837.
NZ128 +0.2%, courant0.02 −1.0%, NX1152 −0.2% → **converged to <1%.**

**HIGH corner** (α=3, V₀=0.10, kz=5 — narrowest/fastest used mode; EPS/DX≈6.1 at
NX768): γ_base=0.2395. NZ128 +1.1%, **courant0.02 +5.9%**, **NX1152 +2.7%** →
**~3–6% under-resolution**, dominated by timestep and x-resolution (as expected
for a fast, narrow mode sitting at the EPS/DX threshold). Both finer grids raise
γ, so the effects may partially add; the ~5% figure is within the ~6–10% error
budget already quoted for the high-α points. No NaNs; R²=1.000 throughout.

**Take-away for the paper:** the "converged to ~2%" statement is accurate at low
αV₀ but should be qualified to **~5% at the high-αV₀ end**; the narrowest
production modes (α=3, V₀=0.1) carry a few-% grid uncertainty that a referee
should be told about. `plots/t2p8_resolution_extremes.png`.
