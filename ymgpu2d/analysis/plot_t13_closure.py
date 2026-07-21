#!/usr/bin/env python3
"""
plot_t13_closure.py -- figure for the T1.3 CLOSED result (2026-07-21).

Renders the punchline of FINDINGS.md "T1.3 CLOSED (2026-07-21)": the original
sub-kz=1 "two-branch" claim (gamma=0.32 at kz_phys=0.5 -> 0.06 at 0.75,
alpha=2, V0=0.05) is a sponge-boundary quasi-mode, not a genuine crossing
between two physical eigenmode families.

Left panel: gamma(kz_phys). The xi_sponge=13 "dominant" eigenvalue (from
sweep/t13_branch_continuation.csv, the same continuation used in the roadmap
closure) reproduces the original dip; the xi_cut=5 hard-wall control (values
hard-coded from FINDINGS.md/results.tex, the certified numbers) is smooth and
monotonic. GPU points (run_campaign_t13confirm.sh, also hard-coded from
FINDINGS.md's confirmation table) confirm both curves in full nonlinear CUDA.

Right panel: the eigenfunction parity correlation for the xi_sponge=13 branch
collapses from ~0.99 (coherent) to <0.3 exactly where the dip occurs --- the
diagnostic that exposed the quasi-mode.
"""
import csv

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

CSV_PATH = "/home/user/kh/ymgpu2d/sweep/t13_branch_continuation.csv"
OUT_PATH = "/home/user/.claude/jobs/20590871/tmp/beamer/fig_r_t13_closure.pdf"

kz_sponge, gamma_sponge, parity_sponge = [], [], []
with open(CSV_PATH) as f:
    for row in csv.DictReader(f):
        if row["xi_sponge"] == "13.0" and row["rank"] == "0":
            kz_sponge.append(float(row["kz_phys"]))
            gamma_sponge.append(float(row["gamma"]))
            parity_sponge.append(float(row["parity_corr"]))

kz_cut = [0.25, 0.50, 0.75, 1.00, 1.25, 1.50]
gamma_cut = [0.0170, 0.0595, 0.0839, 0.1014, 0.1144, 0.1245]

kz_gpu_cut = [0.25, 0.50, 0.75, 1.00, 1.25, 1.50]
gamma_gpu_cut = [0.0118, 0.0584, 0.0830, 0.1005, 0.1132, 0.1233]
gpu_cut_confirmed = [False, True, True, True, True, True]

kz_gpu_sponge = [0.50, 0.75]
gamma_gpu_sponge = [0.3210, 0.0696]

fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(10.5, 4.2))

ax1.plot(kz_sponge, gamma_sponge, "--", color="#b22234", lw=1.6,
          label=r"$\xi_{\rm sponge}=13$ dominant eigenvalue (artifact)")
ax1.plot(kz_cut, gamma_cut, "-", color="#1b6fb2", lw=1.8, marker="o", ms=4,
          label=r"$\xi_{\rm cut}=5$ hard wall (true shear branch)")

ax1.scatter([k for k, ok in zip(kz_gpu_cut, gpu_cut_confirmed) if ok],
            [g for g, ok in zip(gamma_gpu_cut, gpu_cut_confirmed) if ok],
            marker="s", s=42, facecolor="#1b6fb2", edgecolor="black", zorder=5,
            label=r"GPU, $\xi_{\rm cut}=5$ (plateau-confirmed)")
ax1.scatter([k for k, ok in zip(kz_gpu_cut, gpu_cut_confirmed) if not ok],
            [g for g, ok in zip(gamma_gpu_cut, gpu_cut_confirmed) if not ok],
            marker="s", s=42, facecolor="white", edgecolor="#1b6fb2", zorder=5,
            label=r"GPU, $\xi_{\rm cut}=5$ (no plateau)")
ax1.scatter(kz_gpu_sponge, gamma_gpu_sponge, marker="D", s=42,
            facecolor="#b22234", edgecolor="black", zorder=5,
            label=r"GPU, $\xi_{\rm sponge}=13$ (reproduces artifact)")

ax1.axvspan(0.65, 0.95, color="grey", alpha=0.12, lw=0)
ax1.set_xlabel(r"$k_{z,\rm phys}$")
ax1.set_ylabel(r"$\gamma$")
ax1.set_xlim(0.1, 2.0)
ax1.set_ylim(0, 0.55)
ax1.set_title(r"$\alpha=2,\ V_0=0.05,\ \varepsilon_s=0.15$")
ax1.legend(fontsize=6.6, loc="upper right", framealpha=0.9)

ax2.plot(kz_sponge, parity_sponge, "-", color="#b22234", lw=1.6, marker=".", ms=4)
ax2.axvspan(0.65, 0.95, color="grey", alpha=0.12, lw=0)
ax2.axhline(1.0, color="grey", lw=0.8, ls=":")
ax2.set_xlabel(r"$k_{z,\rm phys}$")
ax2.set_ylabel("eigenfunction parity correlation")
ax2.set_xlim(0.1, 2.0)
ax2.set_ylim(0, 1.05)
ax2.set_title(r"coherence collapses exactly at the ``dip''")

fig.text(0.5, -0.02,
         r"Shaded band: where the $\xi_{\rm sponge}=13$ branch is pinned near the sponge wall "
         r"($\xi_{\rm peak}\!\approx\!\xi_{\rm sponge}$, $A_z/B_y$ blows up $2.6\!\to\!40$--$150$).",
         ha="center", fontsize=7.5)

fig.tight_layout()
fig.savefig(OUT_PATH, bbox_inches="tight")
print(f"wrote {OUT_PATH}")
