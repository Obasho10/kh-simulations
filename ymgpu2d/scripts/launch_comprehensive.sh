#!/bin/bash
# Launch the comprehensive post-intkz campaign: T1.1 EPS-scan (expanded,
# t126+t140), T1.4 warm-closure (extended to kz=1..8, t133), and the new
# kz=0 chromo-Weibel growth-rate extension (abi0-2). Staged 2026-07-19.
#
# Supersedes launch_after_recorr.sh: the intkz campaign this was originally
# written to wait on is PAUSED (user hold, 2026-07-19 ~01:55 IST, 988/1134
# done, 146 runs held for later -- see project_ym_campaign_status memory),
# not finished, and confirmed via live `who`+`nvidia-smi`+`ps aux` on every
# node (2026-07-19) that:
#   - t130, t132: an active human session (ds_students) -- EXCLUDED.
#   - t126, t133, t140, abi0-2: idle GPU, no logged-in user, no ym_coupled
#     or campaign python process running.
# This script re-checks all of that itself, live, every time it runs --
# GPU idleness observed once is not a standing guarantee (feedback_check_
# other_users.md), and this campaign's own 4 nodes overlap with intkz's,
# so if intkz gets resumed on any of them before this runs, that must win.
#
# What this does, per target node:
#   1. `who` — abort (skip that node) if anyone is logged in.
#   2. `ps aux | grep ym_coupled` — abort (skip that node) if a simulation
#      is already running (paused campaigns leave no process behind, but a
#      resume would).
#   3. Sync this branch's .cu/.cuh/Makefile, analysis/, and seeds/, then
#      `make -B` (mandatory after any scp -- feedback_rebuild_after_sync.md).
#   4. Launch the node's script via nohup; each one runs its own smoke test
#      first and aborts loudly without touching the real grid if it fails.
#
# Usage: bash scripts/launch_comprehensive.sh [--skip-checks] [NODE ...]
#   --skip-checks   skip the who/ps checks (only if you've verified yourself)
#   NODE ...        restrict to a subset, e.g. `t126 t140` to launch just the
#                   EPS-scan half. Default: all four (t126 t140 t133 abi).

set -uo pipefail
SKIP_CHECKS=0
TARGETS=()
for a in "$@"; do
    if [[ "$a" == "--skip-checks" ]]; then SKIP_CHECKS=1; else TARGETS+=("$a"); fi
done
[[ ${#TARGETS[@]} -eq 0 ]] && TARGETS=(t126 t140 t133 abi)

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
YMROOT="$(dirname "$HERE")"   # .../ymgpu2d

declare -A WDIR=( [t126]=/DATA/cm/lcpfct/ymgpu2d [t140]=/DATA/cm/lcpfct/ymgpu2d
                  [t133]=/DATA/ym_kh/ymgpu2d      [abi]=/DATA/s23103/lcpfct/ymgpu2d )
declare -A SCRIPTS=( [t126]=epsscan_t126.sh [t140]=epsscan_t140.sh
                     [t133]=warmclosure_t133.sh [abi]=kz0ext_abi.sh )

check_node_free() {
    local host=$1
    local who_out ps_out
    who_out=$(ssh -o ConnectTimeout=8 "$host" "who" 2>/dev/null)
    if [[ -n "$who_out" ]]; then
        echo "  $host: LOGGED-IN USER DETECTED, skipping:"
        echo "$who_out" | sed 's/^/    /'
        return 1
    fi
    ps_out=$(ssh -o ConnectTimeout=8 "$host" "ps aux | grep -E 'ym_coupled|gen_.*_campaign' | grep -v grep" 2>/dev/null)
    if [[ -n "$ps_out" ]]; then
        echo "  $host: A SIMULATION IS ALREADY RUNNING, skipping:"
        echo "$ps_out" | sed 's/^/    /'
        return 1
    fi
    echo "  $host: idle, no logged-in user, no running job"
    return 0
}

sync_and_build() {
    local host=$1 remote=$2
    echo "=== Syncing + rebuilding on $host ($remote) ==="
    scp "$YMROOT"/*.cu "$YMROOT"/*.cuh "$YMROOT/Makefile" "$host:$remote/" || return 1
    scp -r "$YMROOT/analysis" "$host:$remote/" || return 1
    scp "$YMROOT"/seeds/*.bin "$host:$remote/seeds/" 2>/dev/null
    ssh "$host" "cd $remote && make -B" || return 1
    echo "$host: source + seeds synced, build OK"
}

launch() {
    local host=$1 remote=$2 script=$3
    echo "=== Launching $script on $host ==="
    scp "$HERE/$script" "$host:$remote/scripts/$script" || return 1
    ssh "$host" "mkdir -p $remote/scripts $remote/logs" || return 1
    # ssh -f is the correct, documented mechanism for this ("go to background
    # just before command execution") -- tested 2026-07-19: nohup+&, and even
    # nohup+disown+setsid+</dev/null all left the orchestrator's ssh call
    # blocked until the ENTIRE multi-hour remote campaign finished (found
    # when it hung on the very first node while the campaign underneath it
    # was actually running fine); ssh -f reliably returns in <1s regardless
    # of the backgrounded command's duration, verified against both a plain
    # sleep and the real campaign scripts.
    ssh -f "$host" "cd $remote && bash scripts/$script > logs/${script%.sh}.log 2>&1"
    echo "$host: launched $script"
}

echo "=== Checking node availability (who + ps aux, live) ==="
OK_NODES=()
if [[ $SKIP_CHECKS -eq 1 ]]; then
    echo "  --skip-checks: skipping (you have verified this yourself)"
    OK_NODES=("${TARGETS[@]}")
else
    for h in "${TARGETS[@]}"; do
        check_node_free "$h" && OK_NODES+=("$h")
    done
fi

if [[ ${#OK_NODES[@]} -eq 0 ]]; then
    echo ""
    echo "No requested node is free. Not launching anything."
    exit 1
fi

echo ""
LAUNCHED=()
for h in "${OK_NODES[@]}"; do
    wdir=${WDIR[$h]}
    script=${SCRIPTS[$h]}
    if [[ ! -f "$HERE/$script" ]]; then
        echo "  (skip) $script not found for $h -- regenerate the matching gen_*_campaign.py first"
        continue
    fi
    if sync_and_build "$h" "$wdir" && launch "$h" "$wdir" "$script"; then
        LAUNCHED+=("$h")
    else
        echo "  $h: sync/build/launch FAILED, not counted as launched"
    fi
done

echo ""
if [[ ${#LAUNCHED[@]} -eq 0 ]]; then
    echo "Nothing launched."
    exit 1
fi
echo "Launched on: ${LAUNCHED[*]}"
echo "Each runs its own smoke test first and aborts loudly on failure -- check"
echo "logs/<script-basename>_progress.log on each node within a minute or two"
echo "to confirm (e.g. logs/epsscan_t126_progress.log, logs/kz0ext_abi0_progress.log)."
