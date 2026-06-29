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
| NAB_STEP mode 4 | up to 49 TU (2M steps) | No outer blowup; cosine Az1 bounded |
| NAB_DTANH mode 3 | TBD | Two smooth layers; double log-cosh Az1 |

**Key improvement**: max coupling is `α·V₀=0.05/TU` everywhere in mode 4, vs. unbounded `α·V₀·log cosh(ξ)` in old runs. No outer-region blow-up mechanism.

---

## 8. Run Modes Summary

| Mode | Velocity profile | Az1 profile | Seed | freeze_Az1 |
|------|-----------------|-------------|------|------------|
| 0 NAB_LINEAR | tanh (single) | −V₀ log cosh(ξ), full domain | By2 sin(kz), windowed |ξ|<3 | off |
| 1 NAB_CIRC | tanh (single) | same, frozen | By2 cos + By3 sin | on |
| 2 EMHD_KH | tanh (single) | 0 | By1 sin(kz) | N/A |
| 3 NAB_DTANH | double-tanh | −V₀(log cosh ξ₁−log cosh ξ₂), frozen | circular (sech₁+sech₂)·(cos,sin) | on |
| 4 NAB_STEP | step ±V₀ | −V₀ cos(x), frozen | By2 sin(kz), uniform x | on |
