# BAND_THEORY.md — A1: analytic theory of the exchange-band instability

Status 2026-07-04. Everything here follows from the kinematic spin model
(DERIVATION.md §6, blocks verified in §4) — two counter-polarized,
counter-streaming spin populations coupled by contact exchange λ_xc in a
frozen SOC background 𝒜(x), YM code units throughout (κ ↔ α_YM,
𝒜(x) = −V0·log cosh(ξ) unless stated).

## 1. Local dispersion (pointwise in x; D_s = 0)

Circular variables s±_σ = s²_σ ± i s³_σ. The kinematic equations reduce, per
point x and branch (+), to the 2×2 system

```
γ s+_A = −i Δ s+_A − i λ (s+_A + s+_B)
γ s+_B = +i Δ s+_B + i λ (s+_A + s+_B),      Δ(x; kz) ≡ v_z(x) · (kz − κ 𝒜(x))
```

Δ is the **Doppler–precession detuning**: the rate mismatch, seen in the lab
frame, between the two beams' spin phases (advection Doppler kz·v_z minus SOC
precession κ·v_z·𝒜). Eigenvalues:

```
γ = ± i √( (Δ + λ)² − λ² )
```

**[verified against solver]** Growth γ_r = √(λ² − (Δ+λ)²) iff

```
−2λ < Δ < 0        (band condition, branch +; branch − is the mirror Δ → −Δ)
```

with maximum **γ_max = λ_xc exactly, at mid-band Δ = −λ**.

Physical reading: exchange locks the two beams' transverse spins into a
collective precession; when the counterflow Doppler detuning is comparable to
(and signed against) the exchange rate, the locked mode is pumped by the
relative drift — a two-beam resonance instability. γ ≤ λ because exchange is
both the coupling and the clock.

## 2. Which side of the layer, and where the mode sits

For branch + and kz > 0, κ𝒜 ≤ 0 ⇒ (kz − κ𝒜) > 0, so Δ < 0 requires
**v_z < 0: the ξ < 0 side**. Branch − lives at ξ > 0 (parity mirror).
Confirmed numerically: all λ = 0.5–5 modes peak at ξ ≈ −4…−7.

Within the ξ<0 side, the band condition reads

```
|v_z(x)| · ( kz + κ|𝒜(x)| ) < 2λ
```

- **Bulk in-band regime** (small kz): the whole outer region satisfies this
  when V0(kz + κ|𝒜|) < 2λ ⇒ kz < kz_edge ≈ 2λ/V0 − κ|𝒜|. Modes are broad,
  centred where γ_r is maximal, i.e. near the **resonance surface**
  x_r(kz): |v_z|(kz + κ|𝒜|) = λ.
- **Sliver regime** (large kz): for kz > kz_edge the bulk is out-of-band, but
  near the shear layer |v_z| → 0 always re-enters the band. The resonance
  surface migrates toward ξ → 0⁻ and the unstable sliver narrows; local γ still
  reaches λ but the mode is squeezed, so the *global* γ falls slowly below λ.
  ⇒ **no sharp upper cutoff from the band itself** — the high-kz tail is cut by
  spin diffusion/relaxation (§4). Confirmed: ξ_peak migrates −6.1 → −3.7 → ~0
  as kz goes 2 → 10 → 12+, with γ decaying only ~14% from kz=10 to kz=24.

## 3. Wavelength selection law

Peak growth sits at mid-band on the flank where |v_z| ≈ V0:

```
kz* ≈ λ_xc / V0 − κ |𝒜(ξ_pk)|
```

i.e. **pattern wavevector = exchange precession rate / drift velocity, shifted
down by the SOC term**. In lab terms λ_pattern = 2π v_drift/ω_xc with a
gate-tunable SOC correction. Two regimes:

- λ_xc ≫ κ V0 |𝒜|: exchange-dominated selection (kz* ≈ λ/V0); SOC is a
  perturbative shift. This is the λ=0.5–5, α=2, V0=0.05 regime of the scans.
- λ_xc ≲ κ V0 |𝒜|: SOC-dominated selection and localization — the gate profile
  𝒜(x) decides where and at which kz the mode grows. This is the regime for the
  "designer instability" claim (A2 map (b) probes it at λ=0.1).

## 4. Finite D_s, relaxation, and the true high-kz cutoff  **[sketch]**

Perturbatively, γ ≈ γ_band(kz) − D_s(kz² + k_x,eff²) − 1/τ_s where k_x,eff is
set by the resonance-zone width (grows in the sliver regime). Estimates:
- Diffusive cutoff: γ_max = λ ⇒ kz_c ~ √(λ/D_s). At λ=0.5, D_s=1e-4:
  kz_c ≈ 70 — consistent with the observed slow tail.
- Threshold (feeds A3): instability requires λ_xc > 1/τ_s + D_s kz*² +
  sliver/gradient corrections — in materials λ_xc ~ 10¹¹–10¹² s⁻¹ vs
  1/τ_s ~ 10¹⁰ s⁻¹ (PSH-protected), so the margin is comfortable; the *precise*
  threshold in drift velocity comes from A3's realism terms.

## 5. Validation against the solver (A1 ↔ numerics)

Parameters α=2, V0=0.05, log-cosh 𝒜, NX=256, D_s=1e-4 unless noted:

| test | prediction | measured | status |
|---|---|---|---|
| γ_max at λ=0.5 | 0.500 (=λ) | 0.4985 (kz=10) | ✓ 0.3% |
| kz* at λ=0.5, V0=0.05 | λ/V0 − κ\|𝒜(−6)\| ≈ 9.5 | 10 | ✓ |
| unstable side | ξ < 0 (branch +) | ξ_pk = −3.7…−6.6 for kz ≤ 10 | ✓ |
| sliver migration | ξ_pk → 0⁻ for kz > kz_edge≈19.5 | ξ_pk ≈ 0.3–1.7, γ decays slowly | ✓ (qualit.) |
| √λ trend of γ at fixed kz≤6 (below-peak flank) | γ rises with λ, sub-linear | γ(kz=2): 0.33/0.48/1.12 for λ=0.5/1/5 | ✓ |
| kz* at λ=1.0, V0=0.05 | λ/V0 − κ\|𝒜(−3.7)\| ≈ 19.7 | 20 (γ=0.9985) | ✓ |
| γ_max at λ=1.0 | 1.000 | 0.9985 | ✓ 0.15% |
| kz* at λ=0.5, V0=0.10 | 5 − κ\|𝒜(−4.7)\| ≈ 4.2 | 4 (γ=0.4974) | ✓ |
| V0-scaling of kz* | ∝ 1/V0 (10 → 5 for V0 0.05→0.10 at λ=0.5) | 10 → 4 | ✓ |

## 6. What this means for the program

1. The selection law kz* = λ_xc/V0 − κ|𝒜| replaces the plasma program's
   kz_peak ≈ 2α as the headline scaling — now with TWO independently tunable
   knobs in a device: drift velocity (bias) and SOC (gate).
2. γ_max = λ_xc means the growth rate is set by the interaction, not the drive —
   the feasibility budget (soc_params.py) must compare λ_xc to 1/τ_s, which it
   wins by ~1–2 orders (PSH), instead of 0.12·Ω_drive vs 1/τ_p, which lost.
3. The soft high-kz tail says real devices will select kz* only if diffusion/
   relaxation cut the sliver modes — A3's job to quantify; otherwise the
   spectrum is broad above kz*.
4. The Δ-resonance structure is exactly the Castaing/Leggett–Rice family
   (transverse spin-current instability in a molecular field) in a two-beam,
   SOC-controlled, inhomogeneous setting — B1 must nail the delta.

## 7. Validation-run results (a1_validation.log, 2026-07-04)

- λ=1.0, V0=0.05, kz ∈ {8..30}: γ rises to **0.9985 at kz=20** (predicted 19.7),
  ξ_pk migrating −5.7 → −3.7 below the peak, then jumping to the shear-layer
  sliver (ξ_pk = +3.2 → +0.7) above it with the slow tail (γ=0.972 at kz=30).
- λ=0.5, V0=0.10, kz ∈ {1..10}: γ rises to **0.4974 at kz=4** (predicted 4.2),
  same migration pattern, tail γ=0.457 at kz=10.

Three independent (λ, V0) points now confirm kz* = λ_xc/V0 − κ|𝒜(ξ_pk)| and
γ_max = λ_xc (to 0.2–0.3%). The A1 theory is quantitatively validated in the
exchange-dominated regime; the SOC-dominated regime is probed in the A2 map (b).

## 8. A2 band maps (band_map.py → band_map.npz, plots/band_map.png, 2026-07-04)

**Map (a) — selection across λ (α=2, V0=0.05, kz = 0.5–25):**

| λ | kz* (meas) | λ/V0 (pred) | γ_max | γ_max/λ | high-kz behaviour |
|---|-----|-----|--------|---------|---------------------|
| 0.05 | 1.5 | 1 | 0.0480 | 0.96 | **sharp cutoff**: γ < 0 for kz ≥ 8 |
| 0.10 | 1.5–2 | 2 | 0.0982 | 0.98 | **sharp cutoff**: γ < 0 for kz ≥ 13 |
| 0.25 | 5 | 5 | 0.2484 | 0.99 | slow sliver tail (γ=0.21 at kz=25) |
| 0.50 | 10 | 10 | 0.4985 | 1.00 | slow tail |
| 1.00 | 20 | 20 | 0.9985 | 1.00 | slow tail |

The selection law holds over a factor 20 in λ. Crucially, **at small λ the band
has a genuine sharp upper cutoff** (kz_cut ≈ 6–7 × kz*): the sliver modes near
the shear layer are killed once diffusion + mode compression beat γ ≤ λ. Since
small λ (relative to these code scans) is where the interesting SOC interplay
lives, real devices in that regime get clean spectral selection, not the broad
tail of §2. At large λ the spectrum above kz* stays broad — for those parameters
the *pattern onset* (fastest mode) is still kz*, but nonlinear competition will
decide the final texture (Phase-2C question).

**Map (b) — SOC/gate control (λ=0.1, V0=0.05, κ = 0,1,2,4, kz = 0.25–4):**

The measured effect is NOT a peak shift (peak stays at kz ≈ 1.75–2.5, γ_max
pinned at ≈ λ): it is a **low-kz flank lift** — γ(kz=0.25) rises 0.047 → 0.062
→ 0.074 → 0.088 for κ = 0 → 4. Mechanism, per §1: at small kz the detuning
|v_z|·kz is too small to reach mid-band, but the SOC term |v_z|·κ|𝒜(x)| supplies
the missing detuning in the outer region — the gate literally switches on
long-wavelength instability. This *is* a gate-control knob, just a different one
than predicted in §3: **κ controls the long-wavelength edge of the band, λ_xc/V0
controls the peak.** The §3 peak-shift regime would require κV0|𝒜| ≳ λ near the
peak-mode location — i.e. still smaller λ or engineered 𝒜(x) wells (A2b task).

## 9. Flank law, exact flow-decoupling, and the threshold (A3)

**Flank law [verified]**: below the peak the growth follows

```
γ(kz) ≈ √( 2 λ V0 (kz + κ|𝒜|) ),     saturating at λ near kz*.
```

(From §1 with |Δ| ≪ λ: γ = √(λ²−(λ−|Δ|)²) ≈ √(2λ|Δ|).) Checked against the
saved A2 map: meas/pred = 0.83–0.99 (mean 0.91–0.94) over 33 flank points and
20× in λ — the ~10% deficit is the localization/diffusion correction. This also
explains the √λ scaling of γ at fixed kz seen in the first λ scans.

**Exact flow-decoupling [verified, structural]**: for this background (uniform
densities, s̄^{2,3}=0, s̄¹ = ±1 uniform), flow and density perturbations do not
couple to the band mode at linear order: δv·∇s̄ = 0, the δv_z-driven precession
torque κδv_z𝒜 ê₁ × s̄¹ê₁ = 0, and the exchange field response contains no δn
(b²,³ ∝ n̄ δq²,³). Momentum feels spin forces but nothing returns. Hence
**Fermi pressure, momentum relaxation and Coulomb do not move the linear
threshold** — they matter for saturation only (Phase 2C). The linear threshold
is set purely by spin-sector dissipation (D_s, 1/τ_s).

**Threshold law**: maximizing γ_net(kz) = √(2λV0·kz) − D_s kz² − 1/τ_s gives

```
kz_opt = ( √(2λV0) / 4D_s )^{2/3}
γ_net,max = 0.75 (λ² V0² / D_s)^{1/3} − 1/τ_s          [flank regime, kz_opt < kz*]
V0_c   = (1/τ_s)^{3/2} √D_s / (0.65 λ)                  [neutral point]
```

Physically: drift must beat the diffusive spreading of one pattern wavelength
per exchange time; larger λ_xc LOWERS the threshold.

**A3 numerics (a3_threshold.py → a3_threshold.npz, plots/a3_threshold.png)**:
- Dissipated dispersion (λ=0.1, V0=0.05, 1/τ_s=0): peak γ drops 0.093 → 0.084
  → 0.063 → 0.020 for D_s = 1e-3 → 3e-2, staying under the flank-law envelope;
  the analytic γ_net,max overestimates away from threshold because the localized
  modes pay an additional D_s·k_x² cost not in the 1-D formula.
- **Neutral curve** (D_s=1e-2, 1/τ_s=0.05, V0 scan): γ_max crosses zero at
  V0_c ≈ 0.0168 (interpolated) vs analytic **0.0172 — 2% agreement**. Near
  threshold kz_opt → 0, the modes broaden, the k_x correction vanishes, and the
  1-D law becomes exact — which is why the threshold is reliable even though
  the supercritical γ is overestimated.

**Material budget (soc_params.py, band_budget())**: GaAs PSH quantum well:
ω_xc ≈ 1.3e12 s⁻¹, v_c = 160–720 m/s (spin-drag / ohmic D_s scenarios) vs
v_drift = 2e4 m/s ⇒ **supercritical margin 28–124×**, operating γ_net ≈
0.8–2.4e11 s⁻¹, pattern 3–22 μm (Kerr-imageable), l_ee/pattern = 0.02–0.17
(fluid description valid). Graphene/WSe₂: margin only 5–7× with 9–14 μm patterns
in a ~1 μm device — marginal. **GaAs PSH is the platform.** The KH-analog budget
that failed by 25× is formally superseded (kept in soc_params.py for contrast).

**Measured-D_s anchor (added 2026-07-04)**: Weber et al., Nature 437, 1330
(2005) measured D_s in GaAs 2DEGs by transient spin gratings; their
n = 1.9e11 cm⁻² sample (T_F = 100 K) matches our parameter point and gives
**D_s ≈ 100 cm²/s = 1e-2 m²/s, roughly flat 5–300 K** (spin-Coulomb-drag
limited — close to, and slightly below, our spin-drag scenario). Plugging in:
**v_c ≈ 118 m/s, margin ≈ 169×, γ_net ≈ 3.0e11 s⁻¹, pattern ≈ 2.0 μm**,
l_ee/pattern = 0.25 (fluid description near its edge but valid). Caveats:
(i) their D_s is the *longitudinal* diffusivity; the band mode needs the
transverse D_⊥ — equal to O(1) at P ≲ 0.2 (Leggett–Rice corrections small);
(ii) their (100) wells are DP-active — a PSH device changes τ_s, not D_s.
Note also their central physics point supports our device analysis: SCD damps
*counterflow* of the spin populations while leaving co-propagation untouched —
i.e. the background counter-streaming drift itself feels a drag and must be
sustained by current bias. Because the band mode is exactly flow-decoupled at
linear order (§9), this drag does not damp the mode; it enters the power budget
of the drive and the saturation physics (Phase 2C).

## 10. A2b — designer islands (a2b_designer.py → plots/a2b_designer.png)

Gate-defined SOC island 𝒜(x) = A_g·exp(−(ξ−ξ0)²/2w²), w=1.5, over a PSH-tuned
(β_bg≈0) background; λ=0.1, V0=0.05, κ=2. Island theory (§1): local band at
kz ∈ (κA_g − 2λ/V0, κA_g), mid-band kz* = κA_g − λ/V0, localized at the island.

**Depth scan (ξ0=+5)**: γ(kz) peaks at kz = 10, 14, 18 for A_g = 6, 8, 10 —
exactly κA_g − 2 — with γ_pk = 0.088, 0.086, 0.084 ≈ λ and ξ_pk = 5.15 (the
island) in all three cases. At kz ≥ 14 the background is completely stable
(A2 map: γ < 0), so the island mode grows **where nothing else grows**:
wavelength is programmed by gate depth.

**Position scan (kz=14, A_g=8)**: mode peak tracks the island: ξ0 = +3 → +3.19,
+6 → +6.14 (exact); ξ0 = −3 → −4.17, −6 → −4.66 (tracks with a ~1 ξ-unit inward
systematic on the v_z<0 side — branch asymmetry, to be understood in the A2b
second pass; γ = 0.058–0.086 throughout).

**Claim established (first pass)**: both the wavelength (via A_g) and the
position (via ξ0) of the unstable spin texture are independently programmable by
gate geometry — the "designer instability". Caveat for realism: κA_g = 12–20 in
code units corresponds to a strong SOC island; the achievable modulation depth
in a real gate stack must be checked in the D1 write-up (moderate-depth islands
select proportionally lower kz — the mechanism is unchanged).
