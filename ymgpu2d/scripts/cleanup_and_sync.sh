#!/bin/bash
# Periodic disk cleanup + local sync for the suspectfix campaign.
# For each node: extract timeseries from any run directory that hasn't been
# touched in >20 min (safe margin vs. the slowest single-export gap observed,
# ~11 min on 1080Ti fine-tier runs) via remote_timeseries.py -- which deletes
# the large raw ym_*.csv field dumps after extracting the small timeseries_k*.csv
# summary -- then rsyncs the extracted CSVs to the local remote_data/ mirror.
# Deliberately skips anything modified more recently than the staleness window
# so an in-progress run's field dumps are never partially deleted mid-write
# (see FINDINGS discussion: re-running remote_timeseries.py against a still-
# writing directory would truncate the growth curve to only the dumps written
# since the last pass).
set -e
cd /home/user/kh/ymgpu2d

run_node() {
  local host=$1 wdir=$2 label=$3 parallel=$4
  echo "--- $label ($host, P=$parallel) ---"
  before=$(ssh "$host" "du -sh $wdir/outputs 2>/dev/null | cut -f1")
  ssh "$host" "cd $wdir/outputs && find . -maxdepth 1 -type d -name 'ym_k*' -not -newermt '-20 minutes' -printf '%f\n' | \
    xargs -P $parallel -I{} python3 ../analysis/remote_timeseries.py {} >> ../logs/cleanup_extract.log 2>&1"
  after=$(ssh "$host" "du -sh $wdir/outputs 2>/dev/null | cut -f1")
  free=$(ssh "$host" "df -h $wdir 2>/dev/null | tail -1 | awk '{print \$4\" free (\"\$5\" used)\"}'")
  echo "  outputs: $before -> $after   disk: $free"
  mkdir -p "remote_data/$label"
  rsync -aq --include='*/' --include='timeseries_k*.csv' --include='energy.csv' --exclude='*' \
    "$host:$wdir/outputs/" "remote_data/$label/" 2>&1 | tail -5
}

# Parallelism: 12 on shared teaching desktops (32 cores, leave headroom for
# other logged-in users), 24 on abi (dedicated server, 64 cores, biggest backlog).
run_node t126 /DATA/cm/lcpfct/ymgpu2d t126 12
run_node t130 /DATA/cm/lcpfct/ymgpu2d t130 12
run_node t140 /DATA/cm/lcpfct/ymgpu2d t140 12
run_node abi  /DATA/s23103/lcpfct/ymgpu2d abi 24

echo "=== done $(date) ==="
