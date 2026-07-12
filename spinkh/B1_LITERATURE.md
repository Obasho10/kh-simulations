# B1_LITERATURE.md — novelty check for the exchange-band instability (2026-07-04)

Method: web search (8 targeted queries) + abstract fetches; arXiv and journal
landing pages accessible, paywalled full texts not. Older Soviet/JETP-era
literature is under-indexed online — flagged as residual risk in §3.

## 1. The landscape, by family

| Family | Drive | System | Relation to our mode |
|---|---|---|---|
| **Castaing instability** (Castaing 1986; trapped-gas versions: [arXiv:cond-mat/0202072](https://arxiv.org/abs/cond-mat/0202072), [arXiv:cond-mat/0209506](https://arxiv.org/abs/cond-mat/0209506)) | **gradient** of longitudinal polarization (k² < μ k·∇M₀) | spin-polarized ³He gas, trapped alkali/Fermi gases | Same *family* (transverse fluctuations destabilized via the exchange molecular field), **different drive**: ours is relative **drift** between counter-polarized streams (Doppler-detuned resonance), no ∇M₀ required |
| **Leggett–Rice / transverse spin diffusion** (theory [arXiv:cond-mat/9707020](https://arxiv.org/abs/cond-mat/9707020), [arXiv:1307.5175](https://arxiv.org/abs/1307.5175); measured in 2D Fermi gas [PRL 118, 130405](https://journals.aps.org/prl/abstract/10.1103/PhysRevLett.118.130405)) | — | polarized Fermi liquids, ultracold gases | Framework, not an instability. Supplies D_⊥ and the spin-rotation (γ_LR) inputs for our A3 threshold; cite for the dissipation model |
| **Current-driven spin-wave instability in FERROMAGNETS** (Bazaliy–Jones–Zhang topological-term prediction; [arXiv:cond-mat/0304069](https://arxiv.org/abs/cond-mat/0304069), [arXiv:cond-mat/0508732](https://arxiv.org/abs/cond-mat/0508732); spin-wave Doppler measured: [Vlaminck & Bailleul, Science 322, 410 (2008)](https://www.science.org/doi/10.1126/science.1162843); magnon-drag Doppler [arXiv:2011.15008](https://arxiv.org/abs/2011.15008)) | uniform drift Doppler-tilts the magnon dispersion; instability at critical current | **ordered ferromagnets**, single drifting carrier population, STT | **Closest solid-state precedent.** Structural cousin (drift + Doppler + magnetic stiffness → threshold). Deltas: ours needs **no magnetic order** (paramagnetic 2DEG), uses **two counter-streaming populations** (pure spin current, zero charge current → no Oersted complications), and the restoring "stiffness" is the exchange molecular field of the *injected* polarization |
| **Spin-modified quantum-plasma two-stream** ([Khanum et al., Contrib. Plasma Phys. 2020](https://onlinelibrary.wiley.com/doi/abs/10.1002/ctpp.202000024); "two-stream with electron spin effects", SSE-QHD) | counter-streaming beams | quantum plasmas / solid-state plasma models | Superficially similar setup, **different sector**: those are electrostatic (Langmuir/charge) instabilities with spin corrections that *reduce* growth. Our mode is a pure transverse-spin band, invisible in their charge-sector analysis. Cite to differentiate |
| **Spin-injection spin-wave amplification in paramagnets** ([arXiv:0908.0466](https://arxiv.org/abs/0908.0466)) | spin injection near the Stoner transition | disordered paramagnetic metals | Adjacent claim of paramagnetic spin-wave gain — but the mechanism is injection-driven population/spectrum inversion near the FM transition, diffusive regime, no counterflow geometry, no SOC. Cite and contrast |
| **PSH with drift** ([Kunihashi et al., Nat. Commun. 2016](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4786748/); Altmann et al., PRL 2016; [Stretchable PSH, PRX 7, 031010](https://link.aps.org/doi/10.1103/PhysRevX.7.031010)) | drift transport of helical spin coherence | GaAs PSH quantum wells | **Platform literature, no instability studied.** Ideal: the exact device physics we need (gate-tuned α=β, drifting spin textures, Kerr imaging) is experimentally mature — the phenomenon we predict is unclaimed on it |
| **Spin Coulomb drag** (D'Amico–Vignale EPL 55, 566 (2001), [2D theory](https://arxiv.org/abs/cond-mat/0112294); observed: [Weber et al., Nature 437, 1330 (2005)](https://www.nature.com/articles/nature04206)) | — | GaAs 2DEG | Pins the dissipation input D_s,eff for the A3 threshold — measured, not just modeled. Use their numbers in soc_params.py second pass |
| **Suhl / parametric magnon instabilities** | parametric pumping above amplitude threshold | ferromagnetic films | Different mechanism (three/four-magnon parametric); cite only if a referee raises it |

## 2. Delta list — what appears to be new

No hit found claiming any of the following, individually or combined:

1. **The drive**: an exchange-band instability of **counter-streaming,
   counter-polarized spin populations** in a paramagnetic itinerant 2DEG —
   a Doppler-detuned two-beam resonance (band −2λ < Δ < 0), as opposed to
   gradient-driven (Castaing), order-parameter STT (Bazaliy), or
   injection-inversion (0908.0466) mechanisms.
2. **The selection law**: pattern wavevector kz* = ω_xc/v_drift − κ|𝒜| with
   γ_max = λ_xc, i.e. wavelength set by exchange/drift, growth set by exchange
   alone.
3. **SOC as band structure**: the frozen SOC background as a spatial control
   field — long-wavelength band-edge control by a uniform gate, and
   **gate-programmable instability islands** (position + wavelength both
   programmable) — nothing comparable found in any family above.
4. **The setting**: hydrodynamic-regime electron fluid, pure spin current
   (zero charge current), with a quantitative threshold law
   V0_c = (1/τ_s)^{3/2}√D_s/(0.65λ_xc) and a material budget showing GaAs PSH
   supercritical by 10².

**Framing recommendation for Paper E**: introduce the mode as *"a paramagnetic,
counterflow-driven relative of the Castaing and current-driven spin-wave
instabilities"* — anchoring to both communities (He-3/cold-atoms and
spintronics) — with deltas 1–4 as the new content. The PSH-drift experiments
(Kunihashi/Altmann) should be cited as demonstrating every element of the
proposed device except the instability itself.

## 3. Residual risks (accepted, monitored)

- **JETP-era literature**: Silin-wave amplification under drift in paramagnetic
  metals may exist in 1960s–80s Soviet journals that are poorly indexed online.
  Mitigation: search Aronov, Dyakonov, Silin citation trails when drafting;
  ask a librarian/senior colleague who knows that corpus.
- **³He counterflow**: coherently precessing states / spin supercurrents in
  ³He-B (Borovik-Romanov, Bunkov) involve counterflow-like spin transport, but
  in a superfluid coherent state — different physics; a referee from that
  community may still ask for the comparison paragraph.
- **Cold-atom two-component counterflow**: counterflow *dynamical* instabilities
  in two-component BECs are known (bosonic, mean-field); the fermionic/itinerant
  exchange-band version with SOC appears distinct, but the BEC literature should
  be cited in the cold-atom realizability paragraph (also useful: they saw
  pattern formation — supports our Phase-2C expectations).

## 4. Verdict

**Proceed with Paper E.** The configuration (counterflow drive + paramagnetic
2DEG + SOC band control + threshold/material budget) is unclaimed in everything
accessible. The two anchor communities and their canonical citations are
identified. Risk level: normal (residual JETP-era exposure, mitigated by the
framing which claims the *configuration and control*, not the broad concept of
exchange-field spin instabilities).
