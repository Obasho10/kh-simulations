#!/bin/bash
# Runs cleanup_and_sync.sh every 2 hours for the duration of the suspectfix
# campaign, then self-terminates once no suspectfix processes remain on any
# of the 4 nodes (does one final pass first so nothing is left uncleaned).
cd /home/user/kh/ymgpu2d
mkdir -p logs

while true; do
  echo "=== cleanup pass $(date) ===" >> logs/cleanup_loop_runs.log
  bash scripts/cleanup_and_sync.sh >> logs/cleanup_loop_runs.log 2>&1

  active=0
  for h in t126 t130 t140 abi; do
    if ssh -o ConnectTimeout=8 "$h" "pgrep -f suspectfix_wave" > /dev/null 2>&1; then
      active=1
    fi
  done

  if [ "$active" -eq 0 ]; then
    echo "=== no suspectfix processes remain anywhere, final pass then exiting $(date) ===" >> logs/cleanup_loop_runs.log
    bash scripts/cleanup_and_sync.sh >> logs/cleanup_loop_runs.log 2>&1
    break
  fi

  sleep 7200
done
