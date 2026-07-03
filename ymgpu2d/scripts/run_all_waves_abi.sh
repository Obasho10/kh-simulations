#!/bin/bash
# Runs wave1 → wave2 → wave3 sequentially (each wave uses all 3 GPUs in parallel)
# Launch: nohup bash scripts/run_all_waves_abi.sh > logs/all_waves.log 2>&1 &
set -e
mkdir -p logs
WDIR=/DATA/s23103/lcpfct/ymgpu2d
cd $WDIR
echo "=== Wave 1 (V0=0.05) start $(date) ===" | tee -a logs/all_waves.log
bash scripts/run_multigpu_abi_wave1.sh 2>&1 | tee -a logs/all_waves.log
echo "=== Wave 2 (V0=0.10) start $(date) ===" | tee -a logs/all_waves.log
bash scripts/run_multigpu_abi_wave2.sh 2>&1 | tee -a logs/all_waves.log
echo "=== Wave 3 (V0=0.03) start $(date) ===" | tee -a logs/all_waves.log
bash scripts/run_multigpu_abi_wave3.sh 2>&1 | tee -a logs/all_waves.log
echo "=== ALL WAVES DONE $(date) ===" | tee -a logs/all_waves.log
