#!/usr/bin/env python3
"""
band_map.py — A2: exchange-band dispersion maps (see BAND_THEORY.md).

Scan (a): gamma(kz) for lambda_xc in {0.05,0.1,0.25,0.5,1.0} at alpha=2, V0=0.05
          -> tests the exchange-set selection law kz* = lambda/V0 - kappa*|A|.
Scan (b): gamma(kz) for kappa=alpha in {0,1,2,4} at lambda=0.1, V0=0.05
          -> SOC-dominated regime: gate control of the band peak.

Writes band_map.npz and plots/band_map.png.
Reuses the kinematic operator from spin_eigenmode.py (NX=256, Ds=1e-4,
logcosh profile, xi_sponge=10, sigma_sponge=5, EPS=0.15).
"""

import os
import numpy as np
import spin_eigenmode as se

NX, EPS, V0A = 256, 0.15, 0.05
DS, XI_SP, SIG_SP = 1e-4, 10.0, 5.0
LX = se.LX

LAM_LIST = [0.05, 0.10, 0.25, 0.50, 1.00]
KZ_A = [0.5, 1, 1.5, 2, 3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25]
KAPPA_LIST = [0.0, 1.0, 2.0, 4.0]
KZ_B = [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0, 2.5, 3.0, 4.0]
LAM_B, V0B = 0.10, 0.05


def gamma_max(kz, kappa, lam, V0):
    x = (np.arange(NX) + 0.5) * (LX / NX)
    dx = LX / NX
    vzA, A = se.background("logcosh", x, V0, EPS)
    sp = se.sponge_profile(x, EPS, XI_SP, SIG_SP)
    M = se.assemble(kz, kappa, lam, DS, vzA, A, sp, dx)
    w, v = np.linalg.eig(M)
    j = int(np.argmax(w.real))
    amp = np.sqrt(sum(np.abs(v[k * NX:(k + 1) * NX, j]) ** 2 for k in range(4)))
    xi_pk = (x[np.argmax(amp)] - LX / 2) / EPS
    return w[j].real, xi_pk


def run_scans():
    ga = np.zeros((len(LAM_LIST), len(KZ_A)))
    xa = np.zeros_like(ga)
    for i, lam in enumerate(LAM_LIST):
        for k, kz in enumerate(KZ_A):
            ga[i, k], xa[i, k] = gamma_max(kz, 2.0, lam, V0A)
        print(f"scan(a) lam={lam}: gamma={np.round(ga[i], 4).tolist()}", flush=True)

    gb = np.zeros((len(KAPPA_LIST), len(KZ_B)))
    xb = np.zeros_like(gb)
    for i, kap in enumerate(KAPPA_LIST):
        for k, kz in enumerate(KZ_B):
            gb[i, k], xb[i, k] = gamma_max(kz, kap, LAM_B, V0B)
        print(f"scan(b) kappa={kap}: gamma={np.round(gb[i], 4).tolist()}", flush=True)

    np.savez("band_map.npz",
             lam_list=LAM_LIST, kz_a=KZ_A, gamma_a=ga, xi_a=xa,
             kappa_list=KAPPA_LIST, kz_b=KZ_B, gamma_b=gb, xi_b=xb,
             lam_b=LAM_B, V0A=V0A, V0B=V0B, alpha_a=2.0, EPS=EPS, NX=NX, Ds=DS)
    return ga, xa, gb, xb


def make_figure(ga, gb):
    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt

    # validated ordinal ramps (dataviz reference palette, light surface)
    BLUES = ["#86b6ef", "#5598e7", "#2a78d6", "#1c5cab", "#104281"]   # 5 steps
    AQUAS = ["#4cc496", "#1baf7a", "#0d8259", "#065c3e"]              # 4 steps
    INK, INK2, SURF = "#0b0b0b", "#52514e", "#fcfcfb"

    fig, (ax0, ax1) = plt.subplots(1, 2, figsize=(11.5, 4.4), facecolor=SURF)
    for ax in (ax0, ax1):
        ax.set_facecolor(SURF)
        ax.grid(True, color="#e6e5e1", lw=0.7)
        ax.tick_params(colors=INK2, labelsize=9)
        for s in ax.spines.values():
            s.set_color("#d8d7d2")
        ax.set_xlabel("kz  (code units)", color=INK, fontsize=10)

    # (a) exchange-set selection
    for i, lam in enumerate(LAM_LIST):
        ax0.plot(KZ_A, ga[i], "-", color=BLUES[i], lw=2,
                 marker="o", ms=4, mec=SURF, mew=0.5)
        if lam < 0.2:   # low-lambda curves die at high kz: label near their peak
            j_pk = int(np.argmax(ga[i]))
            ax0.annotate(f"λ={lam:g}", xy=(KZ_A[j_pk], ga[i, j_pk]),
                         xytext=(6, 5), textcoords="offset points",
                         color=INK2, fontsize=8.5)
        else:
            ax0.annotate(f"λ={lam:g}", xy=(KZ_A[-1], ga[i, -1]),
                         xytext=(4, 0), textcoords="offset points",
                         color=INK2, fontsize=8.5, va="center")
        ax0.plot([lam / V0A], [ga[i].max()], marker="v", color=BLUES[i],
                 ms=7, mec=INK, mew=0.4, ls="none")
    ax0.set_xlim(0, 28.5)
    ax0.set_ylabel("growth rate  γ", color=INK, fontsize=10)
    ax0.set_title("(a)  exchange-set selection   α=2, V0=0.05\n"
                  "▼ = predicted kz* = λ/V0;  γ_max = λ", color=INK, fontsize=10)

    # (b) SOC/gate control at small lambda
    for i, kap in enumerate(KAPPA_LIST):
        ax1.plot(KZ_B, gb[i], "-", color=AQUAS[i], lw=2,
                 marker="o", ms=4, mec=SURF, mew=0.5)
        ax1.annotate(f"κ={kap:g}", xy=(KZ_B[0], gb[i, 0]),
                     xytext=(-5, 0), textcoords="offset points",
                     color=INK2, fontsize=8.5, va="center", ha="right")
    ax1.set_xlim(-0.35, 4.35)
    ax1.set_title(f"(b)  SOC/gate control   λ={LAM_B}, V0={V0B}\n"
                  "low-kz flank rises as κ·|A(x)| supplies detuning",
                  color=INK, fontsize=10)

    fig.tight_layout()
    os.makedirs("plots", exist_ok=True)
    fig.savefig("plots/band_map.png", dpi=150, facecolor=SURF)
    print("wrote plots/band_map.png")


if __name__ == "__main__":
    ga, xa, gb, xb = run_scans()
    make_figure(ga, gb)
