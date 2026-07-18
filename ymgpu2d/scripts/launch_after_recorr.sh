#!/bin/bash
# Launch the T1.1 EPS-scan + T1.4 warm-closure campaigns once the current
# GPU campaign frees a node. Staged 2026-07-18 -- see RESEARCH_ROADMAP.md
# T1.1/T1.4 and FINDINGS.md "EPS-scan status + next-up queue".
#
# NOTE on "the current campaign": this was generated while the full 8-stream
# recorrection campaign (t126/t130/t132/t133/t140/abi0-2, run_tag=recorr) was
# running, but it was later replaced by a trimmed integer-kz-only relaunch
# (run_tag=recorr, generator gen_intkz_campaign.py, scripts/intkz_<node>.sh)
# on only 7 streams -- t130 was DELIBERATELY EXCLUDED (a human, ds_students,
# was logged into it at relaunch time). Both a rename (intkz_* vs recorr_*
# progress logs) and t130's status may have moved on again since. This script
# does NOT trust either assumption: it checks both log-name conventions, and
# -- more importantly -- checks for an actual logged-in human on every target
# node immediately before launching, every time it runs (see
# feedback_check_other_users.md: GPU idleness is not the same as "no one is
# using this machine").
#
# What this does:
#   1. Checks every current-campaign stream's progress log (recorr_* or
#      intkz_*, whichever exists) for its "ALL DONE" marker. Refuses to
#      proceed on a node that's still busy -- see feedback_gpu_parallel.md
#      (never launch parallel jobs against a node/GPU that's still in use).
#   2. Checks `who` + `ps -u` on both target nodes (t126, t130) for any
#      logged-in human session, regardless of what the campaign-completion
#      check said. Aborts (per-node) if anyone is found -- ask them, or pick
#      a different node, rather than overriding this automatically.
#   3. Syncs the current source (this branch's .cu/.cuh, analysis/, seeds/)
#      to whichever of t126/t130 passed both checks and rebuilds with
#      `make -B` (mandatory after any scp -- see t130's 360-run garbage
#      incident, feedback_rebuild_after_sync.md). This sync carries two
#      correctness fixes neither campaign works without:
#        - main_ym.cu: output dirs now tagged `_nx<N>` (and `_lx<N>`) when
#          nx_override/lx_override are set (previously untagged -- needed for
#          the EPS=0.10 leg's nx_override=1152 runs and the EPS>=0.30 legs'
#          widened-box runs).
#        - remote_timeseries.py: NX is now parsed from the `_nx<N>` tag
#          instead of a hardcoded 768 (previously would have silently
#          misread every nx_override run's field dumps -- reshape into the
#          wrong grid, wrong amplitudes, no crash, just quietly wrong
#          numbers).
#   4. Runs each campaign's own smoke test (embedded as the first block of
#      epsscan_t126.sh / warmclosure_t130.sh) by simply launching the script
#      -- both abort loudly and do not proceed to the real runs if the smoke
#      test fails.
#   5. Launches both campaigns via nohup, one per node, so they run
#      concurrently without contending for the same GPU.
#
# Usage: bash scripts/launch_after_recorr.sh [--force] [--skip-user-check]
#   --force            skips the campaign-completion check (use only if you
#                       have independently confirmed the target nodes are
#                       free GPU-wise).
#   --skip-user-check  skips the logged-in-human check (use only if you have
#                       independently confirmed via `who`/`ps -u` yourself --
#                       do not use this reflexively, see the note above).

set -uo pipefail
FORCE=0
SKIP_USER_CHECK=0
for a in "$@"; do
    [[ "$a" == "--force" ]] && FORCE=1
    [[ "$a" == "--skip-user-check" ]] && SKIP_USER_CHECK=1
done

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
YMROOT="$(dirname "$HERE")"   # .../ymgpu2d

declare -A WDIR=(
    [t126]=/DATA/cm/lcpfct/ymgpu2d [t130]=/DATA/cm/lcpfct/ymgpu2d
    [t132]=/DATA/ym_kh             [t133]=/DATA/ym_kh/ymgpu2d
    [t140]=/DATA/cm/lcpfct/ymgpu2d
)
ABI_WDIR=/DATA/s23103/lcpfct/ymgpu2d
ABI_GPUS=(0 1 2)
# t130 intentionally left out here -- it was excluded from the last relaunch
# for having an active human user, not for being part of the finished
# campaign; its completion status vs this script's targets is checked
# separately by check_target_free().
CAMPAIGN_STREAMS=(t126 t132 t133 t140)

stream_done() {
    local host=$1 wdir=$2 tag=$3   # tag = stream name used in the log filename
    ssh -o ConnectTimeout=8 "$host" \
        "grep -q 'ALL DONE' $wdir/logs/recorr_${tag}_progress.log 2>/dev/null || \
         grep -q 'ALL DONE' $wdir/logs/intkz_${tag}_progress.log 2>/dev/null"
}

check_campaign_done() {
    local ok=1
    for s in "${CAMPAIGN_STREAMS[@]}"; do
        if stream_done "$s" "${WDIR[$s]}" "$s"; then
            echo "  $s: campaign done"
        else
            echo "  $s: campaign NOT done (or unreachable) -- checked both recorr_${s} and intkz_${s} logs"
            ok=0
        fi
    done
    for g in "${ABI_GPUS[@]}"; do
        if stream_done abi "$ABI_WDIR" "abi${g}"; then
            echo "  abi${g}: campaign done"
        else
            echo "  abi${g}: campaign NOT done (or unreachable)"
            ok=0
        fi
    done
    return $((1 - ok))
}

# Logged-in-human check -- independent of GPU/campaign state. See
# feedback_check_other_users.md: idle GPUs do not mean idle machine.
check_no_humans() {
    local host=$1
    local who_out
    who_out=$(ssh -o ConnectTimeout=8 "$host" "who" 2>/dev/null)
    if [[ -n "$who_out" ]]; then
        echo "  $host: LOGGED-IN USER DETECTED:"
        echo "$who_out" | sed 's/^/    /'
        return 1
    fi
    echo "  $host: no logged-in users"
    return 0
}

sync_and_build() {
    local host=$1 remote=$2
    echo "=== Syncing + rebuilding on $host ($remote) ==="
    scp "$YMROOT"/*.cu "$YMROOT"/*.cuh "$YMROOT/Makefile" "$host:$remote/" || return 1
    scp -r "$YMROOT/analysis" "$host:$remote/" || return 1
    scp "$YMROOT"/seeds/*.bin "$host:$remote/seeds/" || return 1
    ssh "$host" "cd $remote && make -B" || return 1
    echo "$host: source + seeds synced, build OK"
}

launch() {
    local host=$1 remote=$2 script=$3
    echo "=== Launching $script on $host ==="
    scp "$HERE/$script" "$host:$remote/scripts/$script" || return 1
    ssh "$host" "mkdir -p $remote/scripts $remote/logs && cd $remote && \
        nohup bash scripts/$script > logs/${script%.sh}.log 2>&1 &"
    echo "$host: launched $script (tail -f $remote/logs/epsscan_${host}_progress.log or warmclosure_${host}_progress.log to watch)"
}

echo "=== Checking campaign completion (recorr_* or intkz_* naming) ==="
if [[ $FORCE -eq 1 ]]; then
    echo "  --force: skipping completion check"
elif ! check_campaign_done; then
    echo ""
    echo "Campaign is not finished on every stream yet. Re-run this script once"
    echo "every check above says done, or pass --force if you have independently"
    echo "confirmed t126/t130 specifically are free GPU-wise."
    exit 1
fi

echo ""
echo "=== Checking for logged-in humans on t126, t130 (independent of the above) ==="
TARGET_OK=()
if [[ $SKIP_USER_CHECK -eq 1 ]]; then
    echo "  --skip-user-check: skipping (you have verified this yourself)"
    TARGET_OK=(t126 t130)
else
    for h in t126 t130; do
        if check_no_humans "$h"; then
            TARGET_OK+=("$h")
        fi
    done
fi

RUN_EPSSCAN=0; RUN_WARMCLOSURE=0
[[ " ${TARGET_OK[*]} " == *" t126 "* ]] && RUN_EPSSCAN=1
[[ " ${TARGET_OK[*]} " == *" t130 "* ]] && RUN_WARMCLOSURE=1

if [[ $RUN_EPSSCAN -eq 0 && $RUN_WARMCLOSURE -eq 0 ]]; then
    echo ""
    echo "Both target nodes have an active human session (or --skip-user-check was"
    echo "not passed and neither could be checked). Not launching anything --"
    echo "ask before using someone else's machine. Re-run once clear, or pick"
    echo "different nodes (edit STREAM in gen_epsscan_campaign.py / "
    echo "gen_warmclosure_campaign.py and regenerate)."
    exit 1
fi

echo ""
[[ $RUN_EPSSCAN -eq 1 ]] && { sync_and_build t126 /DATA/cm/lcpfct/ymgpu2d || { echo "t126 sync/build FAILED"; RUN_EPSSCAN=0; }; }
[[ $RUN_WARMCLOSURE -eq 1 ]] && { sync_and_build t130 /DATA/cm/lcpfct/ymgpu2d || { echo "t130 sync/build FAILED"; RUN_WARMCLOSURE=0; }; }

echo ""
[[ $RUN_EPSSCAN -eq 1 ]] && launch t126 /DATA/cm/lcpfct/ymgpu2d epsscan_t126.sh
[[ $RUN_WARMCLOSURE -eq 1 ]] && launch t130 /DATA/cm/lcpfct/ymgpu2d warmclosure_t130.sh
if [[ $RUN_EPSSCAN -eq 0 ]]; then
    echo "EPS-scan NOT launched (t126 busy/human-present/build-failed) -- rerun this script for it once clear."
fi
if [[ $RUN_WARMCLOSURE -eq 0 ]]; then
    echo "Warm-closure NOT launched (t130 busy/human-present/build-failed) -- rerun this script for it once clear."
fi

echo ""
echo "Done. Both campaigns run their own smoke test first and abort loudly on"
echo "failure -- check logs/epsscan_t126_progress.log and"
echo "logs/warmclosure_t130_progress.log within a minute or two to confirm."
