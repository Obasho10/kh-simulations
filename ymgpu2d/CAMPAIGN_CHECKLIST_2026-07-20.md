# Campaign Checklist — 2026-07-20 3-phase unattended run

Plan: `/home/user/.claude/plans/can-you-make-a-fancy-beaver.md`. Three phases run
sequentially on each of **6 streams** (t126, t133, t140, abi0/abi1/abi2) via
`scripts/master_{t126,t133,t140,abi}.sh`.

**Node count note**: t136 was originally included as a substitute for the excluded
t132, but a live re-check (right before launch) found t136 already running another
student's unrelated GPU training job (98% util, 15GB VRAM, `teaching` account,
started 03:09) — the earlier "idle tmux" read was misleading; there was a real batch
job separate from those shells. Dropped to 6 streams instead of finding a further
substitute.

**Revised time estimate** (both from the low-alpha growth being slow — most
`target_tu` values hit the 400 TU cap — and from losing the 7th stream): **Phase A
~4.2h + Phase B ~3.3h + Phase C ~24min ≈ 7.9h**, all 6 streams running in parallel
with each other.

## Pre-flight
- [ ] Source (`*.cu`/`*.cuh`) + new/changed `scripts/*.sh` and `analysis/*.py` synced to
      all 5 targets (t126, t133, t136, t140, abi)
- [ ] `make -B` clean on all 5 targets, no compile errors
- [ ] 1-TU smoke `.ini` run clean on all 5 targets (or rely on each phase script's own
      built-in smoke test, first thing it does)
- [ ] All 5 master scripts launched via `ssh -f ... "nohup bash scripts/master_<node>.sh
      ... &"`, backgrounded PIDs noted
- [ ] t126 launched and verified healthy (smoke pass, first real run started) BEFORE
      launching the other 4

## Phase A — low-alpha EPS validation (75 runs: 60 magnitude-check + 15 cascade)
Grid: α∈{0.2,0.25,0.3,0.4} × V0∈{0.03,0.05,0.10} × EPS∈{0.10,0.15,0.225,0.30,0.45}.
α≤0.15 deliberately excluded (known FP32 noise-floor wall from the suspectfix campaign).
- [ ] All 7 streams show `epsscan_lowalpha ... ALL DONE` in
      `logs/epsscan_lowalpha_<stream>_progress.log`
- [ ] rsync `timeseries_k*.csv` / `energy.csv` from each node to local `remote_data/<node>/`
- [ ] Run `analysis/batch_analyze.py` (or an adapted `measure_epsscan_v2_accuracy.py`
      pointed at `sweep/epsscan_lowalpha_manifest.csv` +
      `sweep/eps_collapse_gridB_lowalpha.csv`) to get γ_sim vs γ_theory per point
- [ ] Check: does γ_hat=γ_peak/(αV0²)^(1/3) vs P continue the same collapse curve
      established at α≥0.5, or break down below α=0.5?
- [ ] Check crash/quality-gate rate — did any low-α points hit the noise floor despite
      excluding α≤0.15? (would confirm/refine the noise-floor boundary)
- [ ] Update FINDINGS.md with the low-α extension result

## Phase B — intkz completion (146 runs, resuming from 988/1134)
NOTE (found 2026-07-20): the intkz phase scripts reuse `gen_recorrection_campaign.py`'s
`emit_single`/`emit_abi` unmodified, so progress logs are actually named
`logs/recorr_<stream>_progress.log`, NOT `intkz_<stream>_progress.log` — and that log
file is shared with the original 2026-07-18/19 recorrection + intkz campaigns, so its
`done`/`CRASHED` counts are cumulative across ALL history, not just today's run. Use the
master script's `Phase B: intkz start/done` markers (unambiguous) and/or count new
`*_recorr` output directories by mtime to track today's progress specifically.
- [x] abi: Phase B done (19:15:36 IST, 48/48 output dirs confirmed present, 10-point
      data-quality spot check clean)
- [ ] t126/t133/t140: Phase B start/done confirmed in `logs/master_<node>.log`
- [ ] rsync remote_data to local (done for abi 2026-07-20; repeat for t126/t133/t140 when done)
- [ ] Run `analysis/batch_analyze.py`, append results into `sweep/recorr_results.csv`
- [ ] Confirm 1134/1134 (100%) integer-kz points now measured (gamma_sim > 1e-6)
- [ ] Rerun the chased-eigensolver audit (FINDINGS.md 2852-2857 documented next step)
- [ ] Regenerate/update the dispersion-map figures and FINDINGS.md summary

## Phase C — tachyonic-instability growth-rate measurements (50 runs)
Grid: 40 magnitude-check points (α≤2.0, ξ_crit∈[12,33], sponge≈1.5×ξ_crit capped at 53)
+ 2 profile cascades (5 sponge depths each) at (α=0.5,V0=0.05,kz=0.5) and
(α=1.0,V0=0.05,kz=1.5) — see `sweep/tachyonic_manifest.csv` for exact points.

**IMPORTANT correction found 2026-07-20 during abi verification**: the manifest's
`gamma_loc_pred` column is `gamma_local()` evaluated crudely AT the raw sponge-edge
value — this is NOT the same quantity as the true global-eigenmode rate, and
overestimates it by 5-10x in the abi sample (the true rate is set by the mode's own
peak position and a WKB-tunneling-type suppression, not the local rate at an
arbitrary chosen boundary). Comparing γ_sim to `gamma_loc_pred` directly gives a
misleading ~78% median "error" that is NOT a data-quality problem — see abi checks
below. **Use `analysis/outer_region_theory.py validate --alpha A --V0 V --kz K
--sponge SP --EPS 0.15` (the eigensolver-based tool, already in the repo) as the real
benchmark per point, not the manifest column.**
- [x] abi: Phase C done (19:25:41 IST, 17/17 output dirs confirmed present)
- [x] abi: 3-point spot-check against the TRUE eigensolver (`validate` subcommand, not
      the manifest's crude column) — all 3 agree within ~15-20%, consistent with this
      project's normal accuracy (α=0.5/V0=0.05/kz=0.5/sp=29: sim=0.051 vs eig=0.046;
      α=1.5/V0=0.05/kz=1.0/sp=20: sim=0.109 vs eig=0.090; α=1.0/V0=0.05/kz=1.5/sp=45:
      sim=0.792 vs eig=0.918). Simulation data itself looks good.
- [ ] t126/t133/t140: Phase C completion + same eigensolver-based spot-check once done
- [ ] For every point: run the `validate` cross-check (not just a spot sample) to get a
      proper aggregate error statistic
- [ ] Plot the 2 profile cascades: γ_sim(sp) vs the eigensolver-validated rate at fixed
      (α,V0,kz) — the key "behavior" check (does the sponge-depth dependence match?)
- [ ] Check for any unexpected catastrophic blowups despite the α≤2.0 cap; note onset
      times in `energy.csv` if any occurred (would sharpen the onset-time-vs-α curve)
- [ ] Update FINDINGS.md / PHYSICS.md with the expanded tachyonic-branch measurement set
      (was: 1 clean point + 2-point side-study; now: up to 51 points)

## Wrap-up
- [ ] All 3 phases' results committed to git (data CSVs, updated .md docs, new
      scripts/analysis files)
- [ ] No stray `ym_coupled` processes left running on any of the 5 nodes
      (`ssh <node> "ps aux | grep ym_coupled"`)
- [ ] This checklist filled in and archived (or deleted once superseded by FINDINGS.md)
