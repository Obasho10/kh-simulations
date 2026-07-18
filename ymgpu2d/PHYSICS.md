# SU(2) Yang-Mills Plasma KH Simulation — Physics and Implementation Reference

## 1. Physical System

We simulate a **2D (x–z) collisionless plasma** governed by SU(2) Yang-Mills gauge theory. The physical scenario is a **Kelvin-Helmholtz (KH) instability** in a two-beam counterstreaming plasma where the beams carry opposite color charges, creating a non-Abelian electromagnetic background that modifies the KH dispersion relation.

### Configuration (current: NAB_STEP mode)

Two counter-streaming cold plasma beams in a **periodic box** `Lx=6π × Lz=2π`, `NX=768 × NZ=256`:

| Beam | z-velocity (STEP mode) | Color charge Q1 |
|------|------------------------|-----------------|
| A    | +V₀·s(x) | +1 |
| B    | −V₀·s(x) | −1 |

where `s(x)` is the step profile: `+1` for `x<2π` and `x≥4π`, `−1` for `2π≤x<4π`. Grid spacing `DX=DZ=2π/NZ≈0.0245`, `EPS=Lx/6=π` (shear width parameter, used only for tanh modes), `V₀=0.1`, c=ε₀=1.

`kz = k_mode` (integer) exactly, because `Lz=2π` and `dz=2π/NZ`.

### Background Az1 (NAB_STEP)

```
Az1(x) = −V₀ cos(x)     (kx = 1 = 3·2π/Lx, period 2π = Lx/3)
```

This is **frozen** (`freeze_az1=1`): Az1 does not evolve — it is a static prescribed background. Wells (Az1=−V₀, maximum coupling) at x=0,2π,4π align with the velocity interfaces. Peaks (Az1=+V₀) at x=π,3π,5π.

Maximum non-Abelian coupling: `α|Az1|max = α·V₀ = 0.05/TU` (for α=0.5, V₀=0.1). This is bounded and smaller than the WKB growth rate for all k.

---

## 2. Governing Equations

### 2a. Fluid (FCT advection + source terms)

Each beam evolves via compressible advection with Lorentz and precession sources. Variables: number density n, momentum (p_x, p_z), color charges (Q1, Q2, Q3).

**Continuity:**
```
∂n/∂t + ∇·(nv) = 0
```

**Momentum:**
```
∂p_x/∂t + ∇·(v p_x) = F_x = −Σ_a Q^a (Ex^a + v_z By^a)
∂p_z/∂t + ∇·(v p_z) = F_z = −Σ_a Q^a (Ez^a − v_x By^a)
```

**Color charge precession (non-Abelian Lorentz rotation):**
```
∂Q^a/∂t + ∇·(v Q^a) = α_YM · v_z · (Q × Az)^a
```

where `(Q × Az)^a = ε^{abc} Q^b Az^c` (SU(2) adjoint cross-product):
- `(Q×Az)^1 = Q2·Az3 − Q3·Az2`
- `(Q×Az)^2 = Q3·Az1 − Q1·Az3`
- `(Q×Az)^3 = Q1·Az2 − Q2·Az1`

### 2b. Non-Abelian Maxwell equations

In the A_x=0 gauge (only z-component of vector potential non-zero), the 2D Maxwell equations are:

**Ampere (x-component):**
```
∂Ex^a/∂t = c²(−∂_z By^a − α·(Az×By)^a) − Jx^a/ε₀
```

**Ampere (z-component, no non-Abelian correction in A_x=0 gauge):**
```
∂Ez^a/∂t = c²(+∂_x By^a) − Jz^a/ε₀
```

**Faraday:**
```
∂By^a/∂t = ∂_z Ex^a − ∂_x Ez^a + α·(Az×Ex)^a
```

**Vector potential:**
```
∂Az^a/∂t = −Ez^a     (Az1 frozen for modes 1,3,4)
```

**Currents (both beams, face-averaged to Yee stagger):**
```
Jx^a = −n_A Q^a_A v_{xA} − n_B Q^a_B v_{xB}
Jz^a = −n_A Q^a_A v_{zA} − n_B Q^a_B v_{zB}
```

---

## 3. Equilibrium Backgrounds

### 3a. NAB_STEP (mode 4) — current active mode

The color-1 sector equilibrium is **prescribed**, not self-consistent:

```
Az1(x) = −V₀ cos(x)           (frozen static background)
By1(x) = ∂_x Az1 = V₀ sin(x)  (not initialized; builds from currents)
```

The cosine Az1 is chosen to: (1) be periodic on Lx/3 matching the 3-fold velocity structure; (2) have wells at velocity interfaces (maximum coupling where the shear is sharpest); (3) be bounded everywhere.

### 3b. NAB_DTANH (mode 3) — double-tanh alternative

Two smooth shear layers at x=L/4 and x=3L/4, with `ξ₁=(x−L/4)/EPS`, `ξ₂=(x−3L/4)/EPS`:

```
vz_A(x) = V₀ (tanh(ξ₁) − tanh(ξ₂) − 1)
Az1(x)  = −V₀ (log cosh(ξ₁) − log cosh(ξ₂))    (frozen)
By1(x)  = V₀ (tanh(ξ₁) − tanh(ξ₂)) / EPS        (gauge-consistent, initialized)
```

### 3c. WKB instability theory (wkb.pdf eq. 33)

The non-Abelian background Az1 modifies the KH eigenvalue problem for the color-2 sector. For a single-tanh Az1 = −V₀ log cosh(ξ), the WKB quantization for fundamental mode (n=0):

```
Q₀ = sqrt(|C₁|)
Q₀ = −γ² − kz² + α² V₀ kz / γ²
|C₁| = α³ V₀² / (2γ²)
```

Key properties (for single-tanh):
- γ increases monotonically with kz (α=0.5, V₀=0.1: k=2→0.049/TU, k=8→0.146/TU in old units)
- Requires the turning points ξ_tp (where α V₀ log cosh(ξ_tp) = sqrt(kz²+γ²)) to lie inside the domain

**Note**: this WKB formula was derived for the single-tanh log-cosh potential. For the cosine Az1 in NAB_STEP, a different quantization condition applies. The step-function velocity also changes the eigenvalue problem. Whether the same instability chain exists for cosine Az1 is to be determined numerically.

---

## 4. Activation Mechanism for the By2 Instability

Starting from Q2=Q3=0, Az2=Az3=0, the By2 seed activates through:

```
By2 → (∂Ez2/∂t = c²∂_x By2) → Ez2 grows
    → (∂Az2/∂t = −Ez2) → Az2 grows
    → (src_Q3 = α Q1 vz Az2) → Q3 grows
    → (src_Q2 = α Q3 vz Az1) → Q2 grows  ← REQUIRES Az1 ≠ 0
    → (F_z += −Q2 Ez2) → fluid Lorentz force → vz perturbation
    → (Jz2 = n Q2 vz) → modulates Ez2
    → closes the instability loop
```

The critical step is **Q3→Q2**, which requires Az1≠0. In NAB_STEP this is guaranteed by the frozen cosine background.

---

## 5. Numerical Scheme

### 5a. FCT (Flux-Corrected Transport)

The fluid equations use the **Boris-Book FCT scheme** (`FCT_Sweeps.cu`). FCT is:
- Monotone: no new extrema, positivity of density preserved
- Second-order in smooth regions, first-order at sharp fronts
- Operator-split: x-sweep and z-sweep alternated each step
- z-sweep: transpose → sweep → un-transpose

For periodic x, a ghost-cell padded version `ym_fct_x_sweep_periodic` is used with `NX_PAD=NX+2*FCT_HALO=774` (`FCT_HALO=3`).

### 5b. Non-Abelian Maxwell (finite-difference leapfrog)

Yee-grid staggered leapfrog:
- `Ex` at (x+½, z); `Ez` at (x, z+½); `By` at cell center
- All three colors updated simultaneously per kernel
- Non-Abelian cross-products use local field values (explicit in time)
- Update order: Ampere → Potential → Faraday

### 5c. Source splitting

Lorentz and precession sources are computed at **end of step** using updated fields, applied at **start of next step** inside FCT sweeps. Second-order split between Maxwell solver and FCT advection.

### 5d. Boundary conditions

- **z-direction**: periodic throughout (all modes)
- **x-direction**:
  - Mode 0: reflecting walls — `p_x=0` at x=0 and x=NX−1; `Ez^a=0` at walls
  - Modes 1–4: fully periodic (`(x+NX)%NX` indexing everywhere); periodic FCT x-sweep with ghost cells

---

## 6. Diagnostics and Output

### Energy diagnostic

```
E_total = Σ_{x,z} [ ½(|Ex|²+|Ez|²+|By|²) + ½(px_A²+pz_A²)/n_A + ½(px_B²+pz_B²)/n_B ]
```

(sum over all 3 colors for each field). Computed every 10000 steps. Written to `ym_k<k>_a<α>_step/energy.csv`. Halt condition: E/E₀ > 100 (modes 3/4) or > 5 (modes 0/1).

### Snapshot CSV

Written every 20000 steps. Columns: `X,Z,By1,By2,By3,Az2,Az3,PzA,PxA,Q1A,PzB,PxB,Q1B`.

By2 is the primary diagnostic field. Az2,Az3 track non-Abelian potential growth. Q1A/Q1B should remain ≈±1 until nonlinear saturation.

### Growth rate extraction

`dispersion_ym.py::growth_rate_from_dir`: FFT By2 in z at each snapshot, extract amplitude of mode k, compute (sech or x-average) weighted average over x, smooth envelope, find maximum R² linear fit in log-amplitude.

---

## 7. Known Stability Limits

### Old architecture (single-tanh, wall BC — archived)

| Scenario | Lifetime | Cause |
|----------|----------|-------|
| Full-eps Az1 | ~3 TU | α|Az1(edge)|≈6/TU float-noise coupling |
| No-eps Az1, windowed seed | ~63-76 TU | EM wave reaches outer high-coupling region |
| Truncated Az1 |ξ|<3 | ~202 TU | No WKB mode; FCT background instability |
| Any tanh run | ≤202 TU | FCT dissipation of tanh shear → background KH |

### New architecture (cosine Az1, periodic BC)

| Scenario | Expected lifetime | Notes |
|----------|-------------------|-------|
| NAB_STEP mode 4, baseline | ~49 TU | Halts from kz=0 Weibel energy threshold |
| NAB_STEP mode 4, suppress_kz0+hyp_diff | TBD (>49 TU) | No smooth shear → no FCT NaN wall; recommended next run |
| NAB_DTANH mode 3, baseline | ~49 TU | kz=0 Weibel hits 100×E0 threshold |
| NAB_DTANH, suppress_kz0 only | ~46–51 TU | kz=0 leaks through Az/Q channels; still energy-halts |
| NAB_DTANH, suppress_kz0+hyp_diff=5e-5 | ~63–71 TU (FCT NaN) | Weibel suppressed; FCT NaN wall from double-tanh shear |

**Key improvement**: max coupling is `α·V₀=0.05/TU` everywhere in mode 4, vs. unbounded `α·V₀·log cosh(ξ)` in old runs. No outer-region blow-up mechanism.

---

## 8. FCT Blowup — Cause and Mitigation

### Root cause

The FCT NaN wall seen in all NAB_DTANH runs at t=63–71 TU is **FCT advection instability of the smooth double-tanh shear profile**, not a physics instability. The double-tanh velocity `vz(x) = V₀(tanh(ξ₁)−tanh(ξ₂)−1)` has a continuous high-shear gradient over several cells. FCT is monotone in the sense that it prevents new extrema, but under repeated operator-split sweeps (x then z then x…) the shear region accumulates truncation error that eventually produces a NaN in the density floor or momentum divide.

The timing is set by the fluid advection alone (same t_NaN regardless of α, k, or EM coupling strength), confirming it is purely numerical.

### Mitigation options

**Option 1 — Switch to NAB_STEP (mode 4)** *(recommended)*
The step-function velocity `vz = ±V₀` is piecewise constant: no smooth gradient to advect, no FCT accumulation. Campaign 4 (STEP mode, α=2) ran to 49 TU and halted cleanly from the energy threshold, not NaN. With suppress_kz0+hyp_diff, STEP mode should survive far beyond 49 TU. The cosine Az1 provides bounded coupling and the three-fold x-periodicity is fully compatible with the periodic domain.

**Option 2 — Increase hyp_diff**
`hyp_diff=5e-5` extended k=7,8 by ~2.5 TU. To push past 80 TU in DTANH mode would likely require `hyp_diff~5e-4` or larger, which risks damping the KH mode itself (diffusion timescale `1/(hyp_diff·k⁴)` must exceed the KH growth time). Not recommended as the primary path.

**Option 3 — Reduce DT**
The FCT CFL condition is `|v|·DT/DX < 1`. Current DT=0.01·DX gives CFL=0.01·V₀=0.001 — far below the limit. Reducing DT further would not help since the instability is not a CFL violation; it is error accumulation over many steps.

**Option 4 — Add velocity sponge at shear layers**
Damp `vz` back toward equilibrium in the high-shear region at each step. This is physical damping of the shear flow and suppresses the background KH that the FCT instability seeds, but also changes the equilibrium. Not implemented; would require a new source term in the fluid kernel.

**Option 5 — Artificial smoothing of the initial profile**
Initialize with a slightly wider shear layer (larger EPS). A wider tanh is better-resolved on the grid and FCT-stable for longer. The WKB eigenfunction width scales with `1/sqrt(α·V₀/EPS)`, so widening EPS also changes the quantization levels.

### NAB_STEP ruled out (Campaigns 7, 9)

NAB_STEP was tested in Campaigns 7 and 9 (α=2, suppress_kz0=1, hyp_diff=5e-5). All k values blew up at t≈12–22 TU from a **color-1 two-stream instability**. In NAB_STEP, both beams have |vz|=V0 everywhere, so the opposite-color beams (Q1=±1, vz=±V0) create a full-domain two-stream configuration with growth rate ω_p/√2 ≈ 0.7 TU⁻¹. Independent of α — cannot be fixed by any EM filter.

### Current solution: NAB_TANH_COSAZ (mode 5) + DFT fluid pz filter

Mode 5 combines the bounded cosine Az1 of NAB_STEP (no outer-region blowup) with a tanh velocity profile (vz→0 at the shear interface). The residual outer-region two-stream at kz=1..14 is suppressed each step by `kernel_fluid_pz_subtract_kz_range` zeroing those DFT modes from pzA and pzB. The same kz range is also zeroed in the color-2/3 EM fields by `kernel_ym_subtract_kz_range`.

With this setup (Campaign 12, EPS=0.15, α=2, BP=14):
- E/E0 stays flat through t≥5 TU (no two-stream growth)
- Run speed: ~9,200 steps/min on RTX A5000
- KH mode at target kz is the only growing perturbation in the system

---

## 8. Run Modes Summary

| Mode | Velocity profile | Az1 profile | Seed | freeze_Az1 |
|------|-----------------|-------------|------|------------|
| 0 NAB_LINEAR | tanh (single) | −V₀ log cosh(ξ), full domain | By2 sin(kz), windowed |ξ|<3 | off |
| 1 NAB_CIRC | tanh (single) | same, frozen | By2 cos + By3 sin | on |
| 2 EMHD_KH | tanh (single) | 0 | By1 sin(kz) | N/A |
| 3 NAB_DTANH | double-tanh | −V₀(log cosh ξ₁−log cosh ξ₂), frozen | circular (sech₁+sech₂)·(cos,sin) | on |
| 4 NAB_STEP | step ±V₀ (**ruled out**) | −V₀ cos(x), frozen | By2 sin(kz), uniform x | on |
| 5 NAB_TANH_COSAZ | tanh (single, EPS=eps_override) | −V₀ cos(x), frozen | By2 sin(kz)·sech(ξ/EPS) | on |
| 6 NAB_CIRC_AZ2 | tanh (single) | −V₀ log cosh(ξ), frozen | **Az2/Az3 WKB Gaussian** exp(−ξ²/2ξ_char²)·(cos,sin) | on |

---

## 9. Eigenmode Seeding Strategy

### The cascade problem

In all modes seeding By2/By3, the precession cascade corrupts kz≥2 linear measurements (see Campaign 16):
- Az2 grows at γ_cascade ≈ α·V₀ from the background Az1 precession (even when Az2_init=0)
- For α=2, V₀=0.1: γ_cascade ≈ 0.20–0.24 TU⁻¹
- If γ_KH < γ_cascade, By2 decays initially and the true KH signal is buried

### Option 1 — Gaussian Az2 seed (run_mode=6, Campaign 18)

Seed `Az2/Az3` with the WKB n=0 Gaussian profile instead of `By2/By3`:

```
Az2(x,z,t=0) = A₀ · exp(−ξ²/(2·ξ_char²)) · cos(kz·z)
Az3(x,z,t=0) = A₀ · exp(−ξ²/(2·ξ_char²)) · sin(kz·z)
ξ_char = 1/sqrt(α · kz · V₀)   [in ξ-units, ξ=(x−Lx/2)/EPS]
```

| α | kz | ξ_char | σ_phys = EPS·ξ_char |
|---|----|--------|---------------------|
| 2 | 1 | 2.24 | 0.336 |
| 2 | 2 | 1.58 | 0.237 |
| 2 | 3 | 1.29 | 0.194 |
| 2 | 4 | 1.12 | 0.168 |
| 2 | 6 | 0.913 | 0.137 |

**Rationale**: Az2 is the field that the cascade builds slowly (from zero). Seeding it at the correct WKB Gaussian width pre-loads the KH activation chain at the field most directly coupled to the eigenmode. By2 starts at zero but grows immediately via the KH chain (Az2→Q3→Q2→Lorentz→By2). The cascade cannot _add_ more Az2 than is already there at the correct spatial structure.

**Expected outcome**: If the eigenmode is present, By2 should start growing at γ_KH from t≈0 (or after one KH period ~1/γ), with no initial decay phase. The co-growth signature (By2 and Az2 at the same rate with no lag) should appear at t=0 rather than at t≈10 TU as in Campaign 16.

**Limitation**: Az2_seed/By2_seed ratio ≈ 1 (equal amplitudes), whereas the true eigenmode may have |Az2|/|By2| >> 1 (from the WKB relation Az2~∂xBy2/γ²). A mismatch in this ratio launches a transient that decays within a few KH periods. Option 2 (full eigenvalue solver) eliminates this transient completely.

### Option 2 — 1D eigenvalue solver (next step)

Solve the linearized YM+fluid equations as a matrix eigenvalue problem in x-space:

```
γ · Ψ(x) = L(x, ∂/∂x) · Ψ(x)
Ψ = [By2, By3, Ex2, Ex3, Ez2, Ez3, Az2, Az3, Q2A, Q3A, Q2B, Q3B]
```

Discretize on NX=768 points → sparse complex matrix M of size ~(NX×12)². Solve with `scipy.sparse.linalg.eigs` (shift-invert at estimated γ_WKB). The dominant eigenvalue is γ_KH; the eigenvector gives the exact x-profiles of **all** fields.

**Benefits over Option 1**:
- Exact amplitude ratio between all fields (By2, Az2, Q2, Q3, Ex, Ez) — no transient at t=0
- Exact growth rate prediction without running the full 2D simulation
- Can scan (α, kz, V₀) parameter space in seconds
- Direct verification of the WKB polynomial (eq. 33) vs the full linearized system

**Implementation plan** (`ym_eigenmode.py`):
1. Build background arrays: Az1(x), vz_A(x), vz_B(x) on NX=768 grid
2. Assemble sparse block matrix M from the linearized Faraday/Ampere/fluid equations
3. Call `scipy.sparse.linalg.eigs(M, k=10, sigma=gamma_WKB_estimate)` for each kz
4. Extract dominant eigenvalue → compare to WKB
5. Extract eigenvector → write Az2(x), By2(x), Q2A(x), ... profiles
6. New init kernel reads the profile from a file (or a new run_mode=7) as seed

---

## 10. Outer-Region Growth: Tachyonic Background Instability and Cavitation (2026-07-15)

Derivations behind the OUTER_REGION.md / FINDINGS.md (2026-07-15) mechanism
identification. Numerical companions: `analysis/outer_region_theory.py`.

### 10a. Tachyonic instability of the frozen Az1 background (linear, EM)

Combine the color-2/3 fields into complex circular pairs (as in
`ym_eigenmode.py`): b = By2+iBy3, ex = Ex2+iEx3, etc. In a locally uniform
background (Az1 = A, vz = v const), with ∂t→γ, ∂z→ikz, ∂x→ikx, the linearized
system is closed by the 6×6 matrix of `outer_region_theory.local_matrix`. At
kx = 0 the magnetic/electric pair decouples:

```
γ b  = −i Ω_F ex          Ω_F = kz − αA      (Faraday + α(Az×Ex) term)
γ ex = −i Ω_A b           Ω_A = kz + αA      (Ampere − α(Az×By) term)
⇒  γ² = −Ω_A Ω_F = (αA)² − kz²
```

Interpretation: the covariant z-derivative D_z = ∂z ∓ iαAz1 gives the two
circular color polarizations effective wavenumbers kz_eff = kz ± αA. Where
|αA| > kz, the product Ω_A·Ω_F < 0 and one polarization is **tachyonic**:
γ(ξ) = sqrt(α²Az1(ξ)² − kz²). For the mode-1/6 background Az1 = −V0 log cosh ξ
(log cosh ξ ≈ ξ − ln 2 for ξ≳2) the instability region is

```
|ξ| > ξ_crit ≈ kz/(αV0) + ln 2 ,     γ_loc(ξ) ≈ sqrt( (αV0)²(ξ−ln2)² − kz² )
```

This is the same non-Abelian term that produces the α²V0kz coefficient in the
WKB quartic (eq. 33) — i.e. the confining well and the outer instability are
one mechanism on the two sides of ξ_crit. kx > 0 only subtracts (γ² → γ² −
kx² to leading order), so γ_loc is the pointwise envelope; the fluid/charge
terms (v-coupling rows) vanish from the growing branch in the outer region —
verified numerically: γ_loc = γ_tachyonic exactly at all outer eigenmode
peaks.

**Global modes**: an eigenmode must fit inside the tachyonic annulus
[ξ_crit, ξ_wall]; the x-envelope quantization costs growth, so global rates
sit below the envelope (measured 0.78× at the widest tested annulus, a
discrete ladder below that). A narrow annulus holds no bound state at all —
an Airy-type estimate with wall value U_w = γ_loc²(ξ_wall) and slope
U' = d(γ_loc²)/dx gives γ² ≈ U_w − 2.34·U'^{2/3}, negative for tight
sponges/cuts — this is *why* windowing inside or near ξ_crit kills the branch
completely rather than merely reducing it.

**Energy source**: the frozen Az1. The instability converts background
potential into charged waves; with freeze_az1=1 the battery is bottomless, so
the branch grows until the box dies. Self-consistently it would deplete Az1
(background decay by charged-wave emission) — the branch is a real linear
mode of the model as posed, but its runaway character is an artifact of the
freeze, which justifies excluding it from measurement windows.

**Literature family (added 2026-07-18, see LITERATURE.md §1d)**: this
mechanism — charged vector modes destabilized on a strong color background,
growth ~ coupling×field, stabilized where the background's effective
wavenumber exceeds the coupling scale — is the **Nielsen–Olesen instability**
class (Nielsen & Olesen, NPB 144, 376 (1978); active descendants in
glasma-decay work, e.g. arXiv:1308.3914, 1406.2051). Papers should cite it as
such: the class is known (independent corroboration of this piece of the
physics), while the well/tachyon duality across ξ_crit and its role in
shear-branch confinement and window design are this program's contribution.

### 10b. Color-1 cold two-stream in code units (for reference; NOT the
late-catastrophe mechanism)

Each beam: n=1, |Q1|=1, m=1 ⇒ per-beam ωp² = 1 (ε0=1). Counter-streaming at
±V, longitudinal color-1 channel:

```
1 = 1/(ω−kV)² + 1/(ω+kV)²   ⇒   γ²(kV) = sqrt(4(kV)²+1) − (kV)² − 1
```

Unstable band kV < √2 — at V0=0.1 this is kz < 14.1, matching the documented
kz_ts ≈ 14 two-stream band exactly. Small-kV limit γ ≈ kV; maximum γ = 0.5 at
kV = √3/2 (measured full-domain rates 0.7–0.9 include EM/Weibel corrections).
The bandpass filter kills this on kz=1..k−1, k+1..kz_hi but *retains* kz =
k_mode by design; nevertheless snapshot forensics (FINDINGS 2026-07-15) shows
the late catastrophe does not grow in the outer ±V region, ruling this out as
the driver.

### 10c. Density cavitation of the finite-amplitude KH mode (nonlinear, fluid)

Continuity, linearized about n=1: γ δn = −(ikz pz1 + ∂x px1), so the mode
carries a first-order compressive response δn ~ (kz·pz1 + kx_eff·px1)/γ, plus
a quadratic ponderomotive part growing at 2γ (the observed nA@k_mode rate ≈
2× the saturating field rate). Cavitation (δn → n, i.e. n → the 0.05 code
floor in `YM_Fluid.cu`) occurs when the momentum amplitude reaches

```
p_cav ~ γ / max(kz, kx_eff)        (order-of-magnitude threshold)
```

after which `safe_n = max(n, 0.05)` divisions decouple momentum from density
and the model is no longer the physical system: a long-lived floored-pocket
state (bounded, mildly elevated energy) persists for tens of TU before a
terminal blowup. Because the threshold is on *amplitude*, whether a run
cavitates within its length is set by drive strength (V0, via γ_exact and the
saturation level) and effective seed — hence the observed *gradual*
V0=0.05→0.10 transition and its insensitivity to window mechanism (sponge vs
cut) and radius. The linear eigensolver cannot see any of this: the effect is
nonlinear and the state vector [b,ex,ez,a,qA,qB] has no fluid n/p blocks.

---

## 11. Exact-action WKB theory of the shear branch: scalar reduction, drive
ceiling, and the confinement-set k_z peak (T1.2, 2026-07-17)

Companion code: `analysis/exact_action_wkb.py`; validation figure:
`plots/exact_action_wkb_validation.png`. This section resolves roadmap item
T1.2 (derive the k_z,peak scaling), diagnoses the WKB gap of
PRESENTATION.md §5.4, and documents an eigenmode-selection artifact in the
reference data (§11e) found along the way.

### 11a. Exact scalar reduction of the 6-field system

The eigensolver system (`ym_eigenmode.py` — the program's "exact theory"
level, validated against the 2D simulation to 1–4%) is, per circular colour
pair (b, ex, ez, a, qA, qB) with ∂t→γ, ∂z→ik_z:

```
γ b  = -iΩ_F ex + ez'      γ a  = -ez
γ ex = -iΩ_A b             γ qA = iα v a - i v Ω_A qA
γ ez = b' + v (qA - qB)    γ qB = iα v a + i v Ω_A qB
```

with Ω_A = k_z + αAz1, Ω_F = k_z - αAz1, v = V0 tanh ξ, Az1 = -V0 log cosh ξ.
Everything except a can be eliminated algebraically:

```
ex = -iΩ_A b/γ ,   ez = -γ a ,   b = -γ² a'/D ,   qA - qB = 2α v² Ω_A a / R
D(x) ≡ γ² + Ω_A Ω_F = γ² + k_z² - α²Az1² ,      R(x) ≡ γ² + v²Ω_A²
```

leaving one second-order ODE for the vector-potential amplitude:

```
( γ² a' / D )' = ( γ² + g ) a ,      g(x) ≡ 2α v³ Ω_A / R        (11.1)
```

**The reduction is exact, including at the discrete level**: the forward
(∂x ez) / backward (∂x b) stencils of the eigensolver collapse to the
flux-form finite difference of (11.1) with D on the "left node of the
face", and the xi_cut boundary maps to a zero-flux (Neumann, b=0) face on
one side and a Dirichlet (ez=0) ghost on the other — the two wall faces
are *not* equivalent. Verified: Newton root-finding on the reduced dense
operator reproduces the 6-field ARPACK eigenvalues to **rel. diff 0.0**
(below the 1e-10 tolerance) at 7 points spanning α=1–3, V0=0.03–0.1,
k_z=1–7 (`--verify-reduction`).

Physical anatomy of (11.1):

- **D** — the EM factor. D < 0 is exactly the tachyonic outer region of
  §10a (one circular polarization sees k_eff² < 0); the shear branch lives
  where D > 0.
- **g** — the *only* drive: the two-beam charge-precession response. Its
  three powers of v: one from the precession source (γq ∋ iαv a), one from
  the two-beam Doppler asymmetry (∝ vΩ_A/R), one from the current
  (j = -v(qA - qB)). The counter-streaming beams enter only through the
  symmetric combination R = γ² + v²Ω_A².
- g is **odd** in ξ (∝ v³): each circular polarization is driven on one
  side of the layer only; the mirror mode is the conjugate polarization
  (same |γ|). Eigenfunctions are one-sided — confirmed numerically, and
  explains the one-sided eigenfunctions that fig08 shows.

WKB form: a ∝ exp(±i∫√Q dx) with the exact local wavenumber

```
Q(x; γ) = -D (γ² + g) / γ²                                       (11.2)
```

### 11b. The drive ceiling γ³ ≤ αV0² and the resonance surface

In the saturated region |ξ| ≳ 2 (v = ±V0, u ≡ -αAz1 ≈ αV0(|ξ|-ln 2)), the
drive on the driven side is

```
-g = G(w) = 2α V0³ w / (γ² + V0² w²) ,      w ≡ Ω_A = k_z - u    (11.3)
```

G is maximized on the **precession-resonance surface**

```
w* = γ/V0   ⇔   V0·Ω_A(ξ_res) = γ ,   ξ_res ≈ (k_z - γ/V0)/(αV0) + ln 2
```

(the beam-frame precession frequency matches the growth rate), where
G_max = αV0²/γ. The well condition Q > 0 (with D > 0) requires G > γ², so

```
γ³ ≤ α V0²          — hard ceiling of the shear branch            (11.4)
```

independent of k_z, EPS, and window geometry. Measured dominant-branch
peak rates reach 95–99% of (αV0²)^{1/3} (table in §11d). Natural units:

```
γ = (αV0²)^{1/3} γ̂ ,   k_z = (α/V0)^{1/3} k̂ ,   w = (α/V0)^{1/3} ŵ
```

in which the well condition is universal — γ̂²(γ̂² + ŵ²) < 2ŵ, ceiling
γ̂ = 1, well edges ŵ± = [1 ± √(1-γ̂⁶)]/γ̂² — and the action is

```
S = ∫√Q dx = (EPS/(αV0²)^{1/3}) ∫ √Q̂ dŵ                          (11.5)
```

One dimensionless group P = (αV0²)^{1/3}/EPS controls the quantization
budget; (k̂, αV0ξ_w) control the geometry. **These are the dimensionless
collapse variables T2.5 was looking for**: α and V0 provably do not
combine as αV0 (consistent with the observed non-collapse in αV0) but as
(αV0²)^{1/3} for rates and (α/V0)^{1/3} for wavenumbers, plus the window
group αV0ξ_w.

### 11c. Quantization and the closed-form dispersion (model A)

The well is bounded on the layer side by the tanh³ knee of g (inner edge
ξ0 ≈ 1.4–2, from tanh³ξ0 ≈ γ²/G) and on the outer side by the window
radius ξ_w or, if the window is loose, by the turning point where G falls
back to γ². Under a hard cut the outer face is zero-flux (Neumann); the
inner edge is a sharp step on the scale of the interior wavelength.
Matching cos(∫k dx) to the under-barrier exponential across the step gives
the n = 0 quantization

```
tan S = κ / k_edge ,     κ = √(γ² + k_z²) ≈ k_z                   (11.6)
```

with S ∈ (0, π/2): the branch is **quantization-marginal** — the well
holds less than a quarter wave (measured actions 0.31π–0.46π at production
points), which is why γ sits close to but below the ceiling, and why naive
(n+½)π quantization fails. With the interior drive constant (G varies by
< 5% across production wells — the numerically confirmed square-well
regime), (11.6) closes to **model A**:

```
X ≡ √(G-γ²)/γ   from   L·X = arctan(1/X) ,   L = EPS (ξ_w - ξ0) k_z
γ² = ½ [ -V0²k_z² + √( V0⁴k_z⁴ + 8 α V0³ k_z/(1+X²) ) ]           (11.7)
```

**Model B** ("exact-action") drops the square-well approximation: it
integrates √Q from (11.2) over the exact well at each trial γ and
root-finds (11.6), with the connection switched to π/4 when the well
detaches from the knee and +π/4 when the outer edge is a free turning
point. Validation against σ-chased dominant (n=0) eigenvalues of the
6-field solver — 12 series spanning α = 1–5, V0 = 0.03–0.2, windows
ξ_w = 5–40, k_z = 0.5–10 (figure): **model B matches to ≤ 2% (median
≤ 0.2%) at every k_z ≥ 1.5; model A is within ~3% near and above the
peak** and identifies the peak within ±0.5 in k_z. Worst deviations
(6–9%) are at k_z ≲ 1 where the well is widest and least square.

### 11d. Consequences: no intrinsic peak; k_z,peak is confinement-set

1. **The unbounded system has no interior k_z maximum.** γ(k_z) rises and
   saturates monotonically at the ceiling (αV0²)^{1/3} while the eigenmode
   migrates outward riding the resonance surface (mode peaks track ξ_res;
   measured -1 → -16 across k_z = 0.5–10 at C25 parameters, -36 at cut
   40). Directly demonstrated at (α=2, V0=0.05, cut=40): γ climbs to
   0.9955 of the ceiling by k_z = 10 with no turnover. The non-monotonic
   dispersion of fig04 is **windowed physics**: once ξ_res reaches the
   sponge/cut radius, the well is truncated at u_w = αV0(ξ_w - ln2), only
   the Doppler-detuned drive G(w ≈ k_z) ≈ 2αV0³k_z/(γ²+V0²k_z²) remains,
   and γ rolls off ∝ √(2αV0/k_z)·V0-ish — the measured decline.

2. **Peak location** — resonance surface at the window edge, evaluated at
   the ceiling rate (w* → (α/V0)^{1/3}):

```
k_z,peak ≈ αV0 (ξ_w - ln 2) + c (α/V0)^{1/3} ,   c = 1.0 ± 0.1    (11.8)
```

   Verified across 11 usable series (V0 = 0.03–0.2, ξ_w = 5–25): (11.8)
   with c = 1 predicts every measured dominant-branch peak to ±0.6 in k_z,
   including the direct window test — moving the cut 11 → 25 at fixed
   physics (α=2, V0=0.05) moved the peak k_z 4.5 → 5.5 (formula: 4.45 →
   5.85). Peak table (true / formula): C25-type (1, 0.05, 20): 3.5 / 3.7;
   (1.5, 0.05, 12): 4.0 / 4.0; (2, 0.05, 11): 4.5 / 4.5; (2.5, 0.05, 9):
   4.5 / 4.7; (3, 0.05, 8): 5.0 / 5.0; (3, 0.03, 5): 5.5 / 5.0;
   (4, 0.03, 5): 6.0 / 5.6; (5, 0.03, 5): 6.5 / 6.2; (1, 0.1, 10):
   3.0 / 3.1; (1, 0.2, 10): 3.0 / 3.6.

3. **Why the data said k_z,peak ≈ 2α.** Both terms of (11.8) are EPS-free
   — the theory *predicts* that the shear width does not select the
   wavelength (T1.1's headline expectation) — but the correct statement is
   "**the coupling and the containment radius select it together**". Over
   the surveyed grid (α = 1–5, V0 = 0.03–0.1, sponges 5–20) expression
   (11.8) numerically tracks ≈ 2α because the sub-linear resonance term
   (α/V0)^{1/3} plus a window term whose radius the campaign design
   shrank as α grew mimics a linear trend across a factor-5 α range.
   k_z,peak ≈ 2α is a serviceable mnemonic inside the surveyed box, not a
   law; (11.8) is the law (to the model's ±0.5).

4. **γ_peak** = (0.95–0.99)·(αV0²)^{1/3} for windows ξ_w ≥ 8, dropping to
   ~0.95 at ξ_w = 5. The empirical γ_peak ~ V0^{0.85–0.92} exponent at
   fixed α is the V0^{2/3} of the ceiling times the window/quantization
   correction γ̂(P, αV0ξ_w), which increases with V0 across the surveyed
   range.

### 11e. By-product: eigenmode-selection artifact in the reference data

The branch is a *ladder* of well overtones (n = 0, 1, 2, …; spacing a few
×0.01 TU⁻¹ at loose windows). `solve_eigenmode`'s default shift-invert
target σ = 0.55·γ_WKB(quartic) lands mid-ladder wherever the quartic
underestimates — i.e. at low α and/or k_z above the quartic's peak. At
(α=1, V0=0.05, k_z=4, window 20): the dominant mode is γ = 0.134 (cut) /
0.131 (production sponge), but default-σ returns 0.106, and the cached C25
curve carries 0.082 — an n≈3 overtone. The eigenmode-seeded simulation
then grew exactly the overtone it was seeded with (plateau-audited 0.081):
**sim-vs-solver agreement certifies the numerics, not dominant-mode
selection.** True C25-window peak: k_z = 3.5 at γ = 0.135 (99% of
ceiling), not k_z = 2 at 0.122. The α ≥ 2 series are unaffected near
their peaks (the quartic is accurate enough there for σ to find n = 0).
Affected artifacts: eigensolver_grid_cache / exact_grid_cache
(figs 03/04/05/13) at low α and beyond-peak k_z; the low-α end of fig05's
k_z,peak ≈ 2α trend. Falsifiable CUDA check (queued, cheap): rerun one C25
point with a broadband or true-n0 seed (`ym_eigenmode.py --sigma 0.14
--export-seed`) and watch the plateau move 0.081 → ≈0.13.

### 11f. Scope and relation to eq. 33

The reduction inherits the 6-field model's scope: background By1 coupling
in Ampère-x, Ez1 back-reaction, and fluid density/momentum perturbations
are outside it (their combined effect on the shear branch is bounded at
the few-% level by the sim agreement). The k_z = 0 chromo-Weibel anchor
(0.5% agreement, §5.1-level) lives in the wide-EPS cosine geometry where
those omissions matter and eq. 33's parabolic quantization is exact — it
is untouched by this section. The **WKB gap is now diagnosed**: eq. 33's
drive term -α²V0k_z does not match the true beam response (11.3) — three
powers of v, Doppler-resonant, ceiling-bounded. Its low-k_z overshoot
produces the 10–20× overestimates in fig07's tail; its decline at high
k_z, against the true branch's ceiling saturation, produces the
weak-coupling-corner ~25% underestimates.
