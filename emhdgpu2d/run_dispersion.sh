#!/bin/bash
# Run emhd_coupled for k_mode = 1..16 to build the dispersion relation.
# Each run takes ~same wall time as the k=1 run.
# Usage:  bash run_dispersion.sh

set -e
BIN=./emhd_coupled

if [ ! -x "$BIN" ]; then
    echo "ERROR: $BIN not found. Run 'make' first."
    exit 1
fi

# Mode numbers to sweep.
# k_n = n * 2*pi / (256*1.0).  n=1..16 covers k = 0.025 .. 0.39
MODES="1 2 3 4 5 6 7 8 10 12 14 16"

for n in $MODES; do
    echo "===== k_mode = $n ====="
    $BIN $n
    echo ""
done

echo "All runs complete."
echo ""
echo "To analyse, run:"
DIRS=$(for n in $MODES; do printf "coupled_k%d " $n; done)
echo "  python dispersion.py --dirs $DIRS --plot-dispersion"
