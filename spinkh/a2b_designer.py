#!/usr/bin/env python3
"""
a2b_designer.py — A2b: gate-defined SOC island ("designer instability") test.

Profile: A(x) = A_g * exp(-(xi-xi0)^2 / 2w^2)  (SOC island over a PSH-tuned
background with beta_bg ~ 0), lambda=0.1, V0=0.05, kappa=2, w=1.5.

Local theory (BAND_THEORY.md §1): on the vz>0 side the island opens a band at
    kz in ( kappa*A_g - 2*lam/V0 , kappa*A_g )        [width 2lam/V0 = 4]
with mid-band (gamma ~ lam) at kz* ~ kappa*A_g - lam/V0 = kappa*A_g - 2,
localized AT the island. Background (A=0) two-stream band dies above kz ~ 13
(A2 map a), so island modes at kz >= 14 grow where nothing else does.

Test 1 (wavelength control): depth scan A_g in {6, 8, 10} -> kz* = 10, 14, 18.
Test 2 (position control):   A_g = 8, kz = 14 fixed, xi0 in {-6, -3, +3, +6}
                             -> mode peak must track the island.

Writes a2b_designer.npz and plots/a2b_designer.png.
"""

import os
import numpy as np
import spin_eigenmode as se

NX, EPS, V0, KAPPA, LAM = 256, 0.15, 0.05, 2.0, 0.10
DS, XI_SP, SIG_SP, W_PATCH = 1e-4, 10.0, 5.0, 1.5
LX = se.LX

AG_LIST = [6.0, 8.0, 10.0]
KZ_SCAN = [6, 8, 10, 12, 14, 16, 18, 20, 22]
XI0_LIST = [-6.0, -3.0, 3.0, 6.0]
KZ_POS, AG_POS = 14.0, 8.0


def solve_one(kz, A_g, xi0):
    x = (np.arange(NX) + 0.5) * (LX / NX)
    dx = LX / NX
    vzA, A = se.background("patch", x, V0, EPS, A_g, xi0, W_PATCH)
    sp = se.sponge_profile(x, EPS, XI_SP, SIG_SP)
    M = se.assemble(kz, KAPPA, LAM, DS, vzA, A, sp, dx)
    w, v = np.linalg.eig(M)
    j = int(np.argmax(w.real))
    amp = np.sqrt(sum(np.abs(v[k * NX:(k + 1) * NX, j]) ** 2 for k in range(4)))
    xi = (x - LX / 2) / EPS
    return w[j].real, xi[np.argmax(amp)], amp / amp.max(), xi


def main():
    # Test 1: wavelength control by island depth
    g1 = np.zeros((len(AG_LIST), len(KZ_SCAN)))
    x1 = np.zeros_like(g1)
    for i, ag in enumerate(AG_LIST):
        for k, kz in enumerate(KZ_SCAN):
            g1[i, k], x1[i, k], _, _ = solve_one(kz, ag, 5.0)
        print(f"depth A_g={ag}: gamma={np.round(g1[i], 4).tolist()}", flush=True)
        print(f"            xi_pk={np.round(x1[i], 2).tolist()}", flush=True)

    # Test 2: position control at fixed kz
    profs, xpks = [], []
    for xi0 in XI0_LIST:
        g, xpk, amp, xi = solve_one(KZ_POS, AG_POS, xi0)
        profs.append(amp)
        xpks.append(xpk)
        print(f"position xi0={xi0:+.1f}: gamma={g:.4f}  xi_pk={xpk:+.2f}", flush=True)

    np.savez("a2b_designer.npz", ag_list=AG_LIST, kz_scan=KZ_SCAN,
             gamma_depth=g1, xipk_depth=x1, xi0_list=XI0_LIST,
             profiles=np.array(profs), xi_axis=xi, xpks=xpks,
             lam=LAM, V0=V0, kappa=KAPPA, w_patch=W_PATCH,
             kz_pos=KZ_POS, ag_pos=AG_POS)

    # ── figure ────────────────────────────────────────────────────────────────
    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    BLUES = ["#5598e7", "#2a78d6", "#104281"]          # 3-step ordinal (validated ramp)
    AQUAS = ["#4cc496", "#1baf7a", "#0d8259", "#065c3e"]
    INK, INK2, SURF = "#0b0b0b", "#52514e", "#fcfcfb"

    fig, (ax0, ax1) = plt.subplots(1, 2, figsize=(11.5, 4.4), facecolor=SURF)
    for ax in (ax0, ax1):
        ax.set_facecolor(SURF)
        ax.grid(True, color="#e6e5e1", lw=0.7)
        ax.tick_params(colors=INK2, labelsize=9)
        for s in ax.spines.values():
            s.set_color("#d8d7d2")

    for i, ag in enumerate(AG_LIST):
        ax0.plot(KZ_SCAN, g1[i], "-", color=BLUES[i], lw=2, marker="o", ms=4,
                 mec=SURF, mew=0.5)
        j_pk = int(np.argmax(g1[i]))
        ax0.annotate(f"A_g={ag:g}", xy=(KZ_SCAN[j_pk], g1[i, j_pk]),
                     xytext=(0, 7), textcoords="offset points", color=INK2,
                     fontsize=8.5, ha="center")
        kz_pred = KAPPA * ag - LAM / V0
        ax0.axvline(kz_pred, color=BLUES[i], lw=1, ls="--", alpha=0.6)
    ax0.set_xlabel("kz  (code units)", color=INK, fontsize=10)
    ax0.set_ylabel("growth rate  γ", color=INK, fontsize=10)
    ax0.set_title("(a)  island depth selects kz   λ=0.1, V0=0.05, ξ0=+5\n"
                  "dashed = predicted kz* = κ·A_g − λ/V0", color=INK, fontsize=10)

    for i, xi0 in enumerate(XI0_LIST):
        ax1.plot(xi, profs[i], "-", color=AQUAS[i], lw=2)
        ax1.axvline(xi0, color=AQUAS[i], lw=1, ls="--", alpha=0.6)
        ax1.annotate(f"ξ0={xi0:+g}", xy=(xi0, 1.02), color=INK2, fontsize=8.5,
                     ha="center")
    ax1.set_xlim(-11, 11)
    ax1.set_ylim(0, 1.12)
    ax1.set_xlabel("ξ", color=INK, fontsize=10)
    ax1.set_ylabel("|mode| / max", color=INK, fontsize=10)
    ax1.set_title(f"(b)  island position places the mode   kz={KZ_POS:g}, "
                  f"A_g={AG_POS:g}\ndashed = island centre", color=INK, fontsize=10)

    fig.tight_layout()
    os.makedirs("plots", exist_ok=True)
    fig.savefig("plots/a2b_designer.png", dpi=150, facecolor=SURF)
    print("wrote plots/a2b_designer.png")


if __name__ == "__main__":
    main()
