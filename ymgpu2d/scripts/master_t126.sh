#!/bin/bash
# Master orchestrator -- t126 (2026-07-20): chains the 3 unattended campaign
# phases in order (A: low-alpha EPS validation, B: intkz completion,
# C: tachyonic-instability measurements). Each phase script is already
# self-contained (own smoke test that aborts THAT phase's stream on failure,
# non-fatal per-run crash handling) -- this script just sequences them.
# Launch: ssh -f t126 "cd /DATA/cm/lcpfct/ymgpu2d && nohup bash scripts/master_t126.sh > logs/master_t126_stdout.log 2>&1 &"
set -e
WDIR=/DATA/cm/lcpfct/ymgpu2d
cd $WDIR
mkdir -p logs
LOG=logs/master_t126.log
echo "=== master start $(date) ===" >> $LOG

echo "--- Phase A: epsscan_lowalpha start $(date) ---" >> $LOG
bash scripts/epsscan_lowalpha_t126.sh
echo "--- Phase A: epsscan_lowalpha done $(date) ---" >> $LOG

echo "--- Phase B: intkz start $(date) ---" >> $LOG
bash scripts/intkz_t126.sh
echo "--- Phase B: intkz done $(date) ---" >> $LOG

echo "--- Phase C: tachyonic start $(date) ---" >> $LOG
bash scripts/tachyonic_t126.sh
echo "--- Phase C: tachyonic done $(date) ---" >> $LOG

echo "=== master ALL PHASES DONE $(date) ===" >> $LOG
