#!/usr/bin/env python3
"""
a3_threshold.py — A3: dissipation, neutral curve, and the threshold law.

Linear-order fact (BAND_THEORY.md §9): the band mode is exactly decoupled from
flow/density/Coulomb perturbations for this background, so the threshold is set
by spin-sector dissipation alone (D_s, 1/tau_s).

Analytics from the flank law gamma ~ sqrt(2*lam*V0*kz) (validated vs band_map):
    net gamma(kz) = sqrt(2*lam*V0*kz) - D_s kz^2 - 1/tau_s
    kz_opt  = (sqrt(2 lam V0)/(4 D_s))^(2/3)
    gamma_net,max = 0.75 * (lam^2 V0^2 / D_s)^(1/3) - 1/tau_s   [flank regime]
    threshold:  V0_c = (1/tau_s)^(3/2) * sqrt(D_s) / (0.65 * lam)

Scan 1: gamma_max(kz) at lam=0.1, V0=0.05 for D_s in {1e-3,3e-3,1e-2,3e-2},
        inv_tau_s in {0, 0.02, 0.05} -> net dispersion with dissipation.
Scan 2: neutral curve: D_s=1e-2, inv_tau_s=0.05, V0 scan -> measured V0_c vs
        analytic prediction 0.0172.

Writes a3_threshold.npz and plots/a3_threshold.png.
"""

import os
import numpy as np
import spin_eigenmode as se

NX, EPS, KAPPA, LAM = 256, 0.15, 2.0, 0.10
XI_SP, SIG_SP = 10.0, 5.0
LX = se.LX

DS_LIST = [1e-3, 3e-3, 1e-2, 3e-2]
ITS_LIST = [0.0, 0.02, 0.05]
KZ_SCAN = [0.5, 1.0, 1.5, 2.0, 3.0, 4.0, 6.0]
V0_A = 0.05

DS_NC, ITS_NC = 1e-2, 0.05
V0_SCAN = [0.005, 0.010, 0.015, 0.020, 0.030, 0.050]
KZ_NC = [0.25, 0.5, 1.0, 1.5, 2.0, 3.0]


def gmax(kz, V0, Ds, its):
    x = (np.arange(NX) + 0.5) * (LX / NX)
    dx = LX / NX
    vzA, A = se.background("logcosh", x, V0, EPS)
    sp = se.sponge_profile(x, EPS, XI_SP, SIG_SP)
    M = se.assemble(kz, KAPPA, LAM, Ds, vzA, A, sp, dx, inv_tau_s=its)
    return np.max(np.linalg.eigvals(M).real)


def main():
    # Scan 1: net dispersion with dissipation
    g1 = np.zeros((len(DS_LIST), len(ITS_LIST), len(KZ_SCAN)))
    for i, Ds in enumerate(DS_LIST):
        for j, its in enumerate(ITS_LIST):
            for k, kz in enumerate(KZ_SCAN):
                g1[i, j, k] = gmax(kz, V0_A, Ds, its)
        print(f"Ds={Ds:g}: its=0 -> {np.round(g1[i,0],4).tolist()}", flush=True)

    # Scan 2: neutral curve in V0
    g2 = np.zeros((len(V0_SCAN), len(KZ_NC)))
    for i, V0 in enumerate(V0_SCAN):
        for k, kz in enumerate(KZ_NC):
            g2[i, k] = gmax(kz, V0, DS_NC, ITS_NC)
        print(f"V0={V0:g}: gamma_max={g2[i].max():+.4f}", flush=True)

    np.savez("a3_threshold.npz", ds_list=DS_LIST, its_list=ITS_LIST,
             kz_scan=KZ_SCAN, gamma_disp=g1, v0_scan=V0_SCAN, kz_nc=KZ_NC,
             gamma_nc=g2, lam=LAM, V0_A=V0_A, ds_nc=DS_NC, its_nc=ITS_NC)

    # ── figure ────────────────────────────────────────────────────────────────
    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    BLUES = ["#86b6ef", "#5598e7", "#2a78d6", "#104281"]
    INK, INK2, SURF = "#0b0b0b", "#52514e", "#fcfcfb"

    fig, (ax0, ax1) = plt.subplots(1, 2, figsize=(11.5, 4.4), facecolor=SURF)
    for ax in (ax0, ax1):
        ax.set_facecolor(SURF)
        ax.grid(True, color="#e6e5e1", lw=0.7)
        ax.tick_params(colors=INK2, labelsize=9)
        for s in ax.spines.values():
            s.set_color("#d8d7d2")

    kzf = np.linspace(0.05, 6.5, 200)
    for i, Ds in enumerate(DS_LIST):
        ax0.plot(KZ_SCAN, g1[i, 0], "-", color=BLUES[i], lw=2, marker="o",
                 ms=4, mec=SURF, mew=0.5)
        ax0.annotate(f"D_s={Ds:g}", xy=(KZ_SCAN[-1], g1[i, 0, -1]),
                     xytext=(4, 0), textcoords="offset points", color=INK2,
                     fontsize=8.5, va="center")
    ax0.plot(kzf, np.minimum(np.sqrt(2 * LAM * V0_A * kzf), LAM), ":",
             color=INK2, lw=1.5)
    ax0.annotate("flank law √(2λV0·kz)", xy=(4.3, 0.105), color=INK2, fontsize=8.5)
    ax0.axhline(0, color=INK2, lw=0.8)
    ax0.set_xlabel("kz  (code units)", color=INK, fontsize=10)
    ax0.set_ylabel("growth rate  γ", color=INK, fontsize=10)
    ax0.set_title("(a)  dissipated dispersion   λ=0.1, V0=0.05, 1/τ_s=0",
                  color=INK, fontsize=10)

    gm = g2.max(axis=1)
    ax1.plot(V0_SCAN, gm, "-", color=BLUES[3], lw=2, marker="o", ms=5,
             mec=SURF, mew=0.5)
    v0c_pred = ITS_NC ** 1.5 * np.sqrt(DS_NC) / (0.65 * LAM)
    ax1.axvline(v0c_pred, color="#e34948", lw=1.4, ls="--")
    ax1.annotate(f"predicted V0_c={v0c_pred:.3f}", xy=(v0c_pred, gm.max() * 0.85),
                 xytext=(6, 0), textcoords="offset points", color="#e34948",
                 fontsize=8.5)
    ax1.axhline(0, color=INK2, lw=0.8)
    ax1.set_xlabel("drift velocity V0  (code units)", color=INK, fontsize=10)
    ax1.set_ylabel("max γ over kz", color=INK, fontsize=10)
    ax1.set_title(f"(b)  neutral curve   λ=0.1, D_s={DS_NC:g}, 1/τ_s={ITS_NC:g}\n"
                  "threshold law V0_c = (1/τ_s)^{3/2}·√D_s/(0.65·λ)",
                  color=INK, fontsize=10)

    fig.tight_layout()
    os.makedirs("plots", exist_ok=True)
    fig.savefig("plots/a3_threshold.png", dpi=150, facecolor=SURF)
    print("wrote plots/a3_threshold.png")


if __name__ == "__main__":
    main()
