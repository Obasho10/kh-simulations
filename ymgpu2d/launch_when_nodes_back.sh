#!/bin/bash
# Run this when t130/t136/t140 come back up.
# Syncs seeds, rebuilds, and launches campaigns.

TEACHING_NODES="t130 t136 t140"
SRC_DIR="/home/user/kh/ymgpu2d"
REMOTE_DIR="/DATA/cm/lcpfct/ymgpu2d"

sync_node() {
    local NODE=$1
    echo "=== Syncing $NODE ==="
    scp $SRC_DIR/*.cu $SRC_DIR/*.cuh $SRC_DIR/*.sh \
        $SRC_DIR/eigenmode_seed_kz*_a2.50_V0.050_sp9.0.bin \
        $SRC_DIR/eigenmode_seed_kz*_a3.00_V0.050_sp8.0.bin \
        $SRC_DIR/dispersion_ym.py $SRC_DIR/remote_timeseries.py \
        $NODE:$REMOTE_DIR/ && \
    ssh $NODE "cd $REMOTE_DIR && make -j4" && echo "$NODE: build OK"
}

# First extract timeseries from existing data on each node
extract_ts() {
    local NODE=$1
    local REMOTE=${2:-$REMOTE_DIR}
    echo "=== Extracting timeseries on $NODE ==="
    ssh $NODE "cd $REMOTE && python3 remote_timeseries.py 'ym_k*_a*_circ_az2seed*'" 2>&1
}

launch_node() {
    local NODE=$1
    local SCRIPT=$2
    local REMOTE=${3:-$REMOTE_DIR}
    echo "=== Launching $SCRIPT on $NODE ==="
    ssh $NODE "cd $REMOTE && nohup bash $SCRIPT > ${SCRIPT%.sh}.log 2>&1 &"
    echo "$NODE: launched $SCRIPT"
}

echo "=== Checking node availability ==="
for NODE in $TEACHING_NODES; do
    if ssh -o ConnectTimeout=5 $NODE "echo $NODE up" 2>/dev/null; then
        sync_node $NODE
        # Extract timeseries from C26-C30 data already on the node
        extract_ts $NODE
    else
        echo "$NODE: not reachable"
    fi
done

echo ""
echo "=== Launching new campaigns ==="
# t136: C33 (α=3.0, V0=0.05, xi_sponge=8)
ssh -o ConnectTimeout=5 t136 "echo t136 up" 2>/dev/null && \
    launch_node t136 run_campaign33_t136.sh

# t130: C34 (α=2.5, V0=0.05, xi_sponge=9) — complements C32 on abi
ssh -o ConnectTimeout=5 t130 "echo t130 up" 2>/dev/null && \
    launch_node t130 run_campaign34_t130.sh

echo "Done."
