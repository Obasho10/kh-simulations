#!/bin/bash
# Master orchestrator -- abi, 3 GPUs (2026-07-20): chains the 3 unattended
# campaign phases in order (A: low-alpha EPS validation, B: intkz completion,
# C: tachyonic-instability measurements). Each phase script
# (epsscan_lowalpha_abi.sh / intkz_abi.sh / tachyonic_abi.sh) is already a
# single self-contained script that internally backgrounds+waits all 3
# CUDA_VISIBLE_DEVICES streams -- sequencing the three phase scripts here
# automatically sequences all 3 GPUs together, phase by phase.
# Launch: ssh -f abi "cd /DATA/s23103/lcpfct/ymgpu2d && nohup bash scripts/master_abi.sh > logs/master_abi_stdout.log 2>&1 &"
set -e
WDIR=/DATA/s23103/lcpfct/ymgpu2d
cd $WDIR
mkdir -p logs
LOG=logs/master_abi.log
echo "=== master start $(date) ===" >> $LOG

echo "--- Phase A: epsscan_lowalpha start $(date) ---" >> $LOG
bash scripts/epsscan_lowalpha_abi.sh
echo "--- Phase A: epsscan_lowalpha done $(date) ---" >> $LOG

echo "--- Phase B: intkz start $(date) ---" >> $LOG
bash scripts/intkz_abi.sh
echo "--- Phase B: intkz done $(date) ---" >> $LOG

echo "--- Phase C: tachyonic start $(date) ---" >> $LOG
bash scripts/tachyonic_abi.sh
echo "--- Phase C: tachyonic done $(date) ---" >> $LOG

echo "=== master ALL PHASES DONE $(date) ===" >> $LOG
