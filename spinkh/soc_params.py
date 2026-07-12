#!/usr/bin/env python3
"""
soc_params.py — material scales and feasibility matrix for the spin-KH instability.

For each candidate platform, computes:
  - SOC scales: precession length lambda_so (PSH helix wavelength), precession
    rate Omega_so at the Fermi/drift momentum
  - hydrodynamic window: l_ee vs W vs l_imp
  - predicted pattern wavelength lambda_peak ~ lambda_so/2  (from the YM result
    kz_peak ~ 2*alpha, see MAPPING.md §7 — O(1) factors pending T-S1/T-S4)
  - rate budget: candidate growth rate gamma ~ 0.1 * Omega_drive vs 1/tau_p,
    1/tau_s, and the shear rate V0/W
  - the dimensionless numbers that map onto the YM code units (alpha_code, V0/v_F)

All device numbers are order-of-magnitude, chosen from the cited experiments
(MAPPING.md §9). Edit the MATERIALS dict to explore.

Usage: python3 soc_params.py
"""

import numpy as np

# ── constants (SI) ────────────────────────────────────────────────────────────
hbar = 1.0545718e-34      # J s
me   = 9.1093837e-31      # kg
e    = 1.60217663e-19     # C
meVA = 1e-3 * e * 1e-10   # 1 meV*Angstrom in J*m


MATERIALS = {
    # GaAs PSH quantum well (Koralek 2009 / Walser 2012 style, hydrodynamic
    # regime a la de Jong-Molenkamp; parabolic band)
    "GaAs-PSH-QW": dict(
        band="parabolic",
        m_eff=0.067 * me,          # effective mass
        beta=5.0 * meVA,           # balanced Rashba=Dresselhaus scale (gate-tunable 3-12)
        n2d=2.0e15,                # carrier density [m^-2]  (2e11 cm^-2)
        tau_p=20e-12,              # momentum relaxation [s] (high-mobility, low T)
        l_ee=0.5e-6,               # e-e mean free path [m] in hydro window
        tau_s_helix=100e-12,       # PSH-enhanced spin lifetime [s] (Koralek: ~ns at best)
        W=2.0e-6,                  # shear-layer width [m] (device-defined)
        v_drift=2.0e4,             # spin-current drift velocity [m/s]
        F0a=0.3,                   # |F0^a| spin Landau parameter (rs~1-3 2DEG)
        P=0.2,                     # injected spin polarization
        tau_sd=1e-12,              # spin-drag (transverse spin-current) time [s]
        # MEASURED spin diffusivity: Weber et al., Nature 437, 1330 (2005),
        # transient spin gratings; their n=1.9e11 cm^-2 sample (T_F=100 K)
        # matches this entry's density and shows D_s ~ 100 cm^2/s roughly
        # flat over 5-300 K (SCD-limited). Longitudinal D_s, used as a proxy
        # for the transverse D_perp (valid to O(1) at P <~ 0.2).
        Ds_measured=1.0e-2,        # [m^2/s]
    ),
    # Graphene on WSe2 (proximity SOC; massless band). SOC here is meV-scale
    # spin splitting Delta_so; precession rate Omega_so = 2*Delta_so/hbar.
    "graphene/WSe2": dict(
        band="dirac",
        v_F=1.0e6,                 # Dirac velocity [m/s]
        Delta_so=1.0e-3 * e,       # proximity-induced splitting [J] (~1 meV)
        n2d=1.0e16,                # [m^-2]
        tau_p=1e-12,
        l_ee=0.2e-6,
        tau_s_helix=10e-12,        # no PSH protection; DP-limited estimate
        W=1.0e-6,
        v_drift=5.0e4,
        F0a=0.1,                   # weak exchange (small rs)
        P=0.1,
        tau_sd=0.5e-12,
    ),
}

# YM campaign anchors (code units), used for the rate estimate:
#   gamma_peak ~ GAMMA_CODE in units of the drive rate Omega_drive,
#   with kz_peak ~ 2*alpha  =>  lambda_peak ~ pi/alpha_phys = lambda_so/2.
GAMMA_CODE = 0.12          # typical measured peak growth rate (C32-C35: 0.14-0.17,
                           # conservative 0.12) in code-rate units — see MAPPING.md §7


def analyze(name, p):
    print(f"\n{'='*72}\n{name}\n{'='*72}")

    if p["band"] == "parabolic":
        m = p["m_eff"]
        kF = np.sqrt(2 * np.pi * p["n2d"])
        vF = hbar * kF / m
        # SU(2) potential magnitude and helix scales (PSH):  q0 = 4 m beta / hbar^2
        alpha_phys = 2 * m * p["beta"] / hbar**2          # [1/m]  (= kappa*|A|)
        q0 = 2 * alpha_phys
        lambda_so = 2 * np.pi / q0
        Omega_so_F = 2 * p["beta"] * kF / hbar            # precession rate at k_F
        Omega_drive = alpha_phys * p["v_drift"] * 1.0     # kappa*v_drift*|A| (|A|~1 gate depth)
    else:  # dirac
        vF = p["v_F"]
        kF = np.sqrt(np.pi * p["n2d"])                    # per spin/valley, order-of-mag
        Omega_so_F = 2 * p["Delta_so"] / hbar
        # effective inverse precession length: carrier flips spin over v_F/Omega
        alpha_phys = Omega_so_F / vF                      # [1/m]
        lambda_so = 2 * np.pi / (2 * alpha_phys)
        Omega_drive = alpha_phys * p["v_drift"]

    lambda_peak = lambda_so / 2.0                          # kz_peak ~ 2 alpha
    gamma = GAMMA_CODE * Omega_drive                       # candidate growth rate
    shear_rate = p["v_drift"] / p["W"]
    l_imp = vF * p["tau_p"]

    print(f"  Fermi velocity              v_F     = {vF:9.3e} m/s")
    print(f"  drift / Fermi               V0/v_F  = {p['v_drift']/vF:9.3f}   (want << 1)")
    print(f"  SOC inverse length          alpha   = {alpha_phys:9.3e} 1/m")
    print(f"  spin-helix wavelength       lam_so  = {lambda_so*1e6:9.3f} um")
    print(f"  PREDICTED pattern           lam_pk  = {lambda_peak*1e6:9.3f} um   (~lam_so/2)")
    print(f"  shear width                 W       = {p['W']*1e6:9.3f} um")
    print(f"  W / lam_pk                          = {p['W']/lambda_peak:9.2f}   "
          f"(pattern {'fits in' if p['W']/lambda_peak>1 else 'EXCEEDS'} shear layer; "
          f"independence test wants W scan around this)")

    print(f"\n  hydrodynamic window:  l_ee = {p['l_ee']*1e6:.2f} um  <  W = {p['W']*1e6:.2f} um"
          f"  <  l_imp = {l_imp*1e6:.2f} um  -> "
          f"{'OK' if p['l_ee'] < p['W'] < l_imp else 'VIOLATED'}")
    print(f"  fluid validity at pattern:  l_ee/lam_pk = {p['l_ee']/lambda_peak:.2f}  (want < 1)")

    print(f"\n  rate budget [1/s]:")
    print(f"    Omega_so(k_F)     = {Omega_so_F:9.3e}")
    print(f"    Omega_drive       = {Omega_drive:9.3e}   (precession at drift momentum)")
    print(f"    gamma ~ 0.12*drive= {gamma:9.3e}")
    print(f"    shear rate V0/W   = {shear_rate:9.3e}")
    print(f"    1/tau_p           = {1/p['tau_p']:9.3e}")
    print(f"    1/tau_s(helix)    = {1/p['tau_s_helix']:9.3e}")
    ok_p = gamma * p["tau_p"]
    ok_s = gamma * p["tau_s_helix"]
    print(f"    gamma*tau_p       = {ok_p:9.2f}   ({'OK' if ok_p > 1 else 'FAILS'} — need > 1)")
    print(f"    gamma*tau_s       = {ok_s:9.2f}   ({'OK' if ok_s > 1 else 'FAILS'} — need > 1)")

    # map to YM code units for direct solver comparison:
    #   code length unit = W/ (Lx_frac) is a choice; simplest: EPS_code=0.15 <-> W
    #   code alpha = alpha_phys * (code unit length); code V0 = v_drift/vF? No —
    #   the YM code is nonrel. with c=1; the honest map keeps only the two
    #   dimensionless groups below. See MAPPING.md §7.
    print(f"\n  dimensionless (for spin_eigenmode.py in code units):")
    print(f"    alpha_code (=alpha_phys*W*0.15/W_code...) — use alpha_phys*W = "
          f"{alpha_phys*p['W']:.2f} per shear width")
    print(f"    Doppler/precession ratio  kz_pk*V0/Omega_drive = "
          f"{(2*alpha_phys)*p['v_drift']/Omega_drive:.2f}")

    verdict = (p["l_ee"] < p["W"] < l_imp) and ok_p > 1 and ok_s > 1 \
              and p["v_drift"] / vF < 0.3
    print(f"\n  VERDICT: {'PROMISING' if verdict else 'MARGINAL/FAILS'}")
    return verdict


def band_budget(name, p):
    """A3/D1 budget for the EXCHANGE-BAND mode (BAND_THEORY.md §9-10), which
    superseded the KH-analog after the T-S2 verdict. Threshold law (flank
    regime, validated in a3_threshold.py):
        v_c    = (1/tau_s)^{3/2} * sqrt(D_s) / (0.65 * omega_xc)
        kz_opt = ( sqrt(2 omega_xc v_d) / (4 D_s) )^{2/3}
        gamma  = 0.75 (omega_xc^2 v_d^2 / D_s)^{1/3} - 1/tau_s   (capped at omega_xc)
    """
    print(f"\n{'='*72}\n{name} — EXCHANGE-BAND budget (primary)\n{'='*72}")
    if p["band"] == "parabolic":
        m = p["m_eff"]
        kF = np.sqrt(2 * np.pi * p["n2d"])
        vF = hbar * kF / m
        EF = hbar**2 * kF**2 / (2 * m)
    else:
        vF = p["v_F"]
        kF = np.sqrt(np.pi * p["n2d"])
        EF = hbar * vF * kF

    w_xc = 2 * p["F0a"] * EF * p["P"] / hbar          # exchange precession rate
    inv_ts = 1.0 / p["tau_s_helix"]
    vd = p["v_drift"]
    print(f"  omega_xc = 2|F0a| E_F P / hbar      = {w_xc:9.3e} 1/s   "
          f"(gamma_max bound)")
    print(f"  1/tau_s                              = {inv_ts:9.3e} 1/s   "
          f"(omega_xc/(1/tau_s) = {w_xc*p['tau_s_helix']:.0f})")

    d_cases = [("ohmic  D=vF^2*tau_p/2 ", vF**2 * p["tau_p"] / 2),
               ("spin-drag D=vF^2*tau_sd/2", vF**2 * p["tau_sd"] / 2)]
    if "Ds_measured" in p:
        d_cases.append(("MEASURED (Weber05 SCD)  ", p["Ds_measured"]))
    for label, D in d_cases:
        v_c = inv_ts**1.5 * np.sqrt(D) / (0.65 * w_xc)
        a = np.sqrt(2 * w_xc * vd)
        kz_opt = (a / (4 * D)) ** (2.0 / 3.0)
        kz_star = w_xc / vd
        if kz_opt < kz_star:                          # flank regime
            gam = 0.75 * (w_xc**2 * vd**2 / D) ** (1.0 / 3.0) - inv_ts
            regime = "flank"
        else:                                         # saturated at kz*
            kz_opt = kz_star
            gam = w_xc - D * kz_star**2 - inv_ts
            regime = "saturated"
        lam_pat = 2 * np.pi / kz_opt
        print(f"  [{label}] D = {D:8.3e} m^2/s")
        print(f"      v_c = {v_c:9.3e} m/s   margin v_d/v_c = {vd/v_c:9.1f}")
        print(f"      operating ({regime}): gamma_net = {gam:9.3e} 1/s, "
              f"pattern = {lam_pat*1e6:6.2f} um, "
              f"l_ee/pattern = {p['l_ee']/lam_pat:.2f}")
    ok = vd > 10 * inv_ts**1.5 * np.sqrt(vF**2 * p["tau_p"] / 2) / (0.65 * w_xc)
    print(f"  VERDICT (band mode): {'SUPERCRITICAL — PROMISING' if ok else 'marginal'}")
    return ok


if __name__ == "__main__":
    print("spin-KH feasibility matrix  (order-of-magnitude; edit MATERIALS to explore)")
    print("NOTE: the per-material 'analyze' section below budgets the ORIGINAL")
    print("KH-analog mode — SUPERSEDED by the exchange-band mode after T-S2;")
    print("kept for the paper's contrast argument. The band budget follows it.")
    results = {name: analyze(name, p) for name, p in MATERIALS.items()}
    band = {name: band_budget(name, p) for name, p in MATERIALS.items()}
    print(f"\n{'='*72}\nSummary (KH-analog, superseded): " +
          ", ".join(f"{k}: {'ok' if v else 'marginal'}" for k, v in results.items()))
    print("Summary (EXCHANGE-BAND, primary):  " +
          ", ".join(f"{k}: {'SUPERCRITICAL' if v else 'marginal'}" for k, v in band.items()))
    print("Caveats: D_s scenarios bracket the transverse spin diffusivity (true")
    print("value needs the D'Amico-Vignale spin-drag input at operating T);")
    print("O(1) factors per BAND_THEORY.md §10 [sketch].")
