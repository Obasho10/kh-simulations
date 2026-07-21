#!/bin/bash
# Campaign T13confirm: T1.3 sub-kz=1 "two-branch" claim — GPU confirmation
# that the claim (RESEARCH_ROADMAP.md T1.3, results.tex Sec. Limitations) is a
# sponge-wall artifact, not a genuine mode crossing. See
# analysis/t13_branch_continuation.py + FINDINGS.md "T1.3" entry for the
# eigensolver-side derivation.
#
# Leg A (xc): xi_cut=5 hard wall (no soft sponge) — the true, artifact-free
#   inner shear-layer branch. Predicted (eigensolver, xi_cut=5): kz_phys=0.25
#   ->0.0170, 0.50->0.0595, 0.75->0.0839, 1.00->0.1014, 1.25->0.1144,
#   1.50->0.1245. Smooth, monotonically rising -- NO dip expected.
# Leg B (sp13): xi_sponge=13 soft sponge (original C45/C50 config) at the two
#   points central to the original claim, using the ORIGINAL eigenvector-based
#   seeds (which the solver picks as "localised within xi_sponge=13" but are
#   actually pinned near the wall) -- expected to reproduce the artifact
#   numbers (kz_phys=0.50 ~0.32, kz_phys=0.75 ~0.06) in full nonlinear CUDA,
#   proving the artifact is a real property of the sponge kernel, not just the
#   linear solver.
ALPHA=2.0; V0=0.05; AMP=0.001; MODE=6; HYP=5e-5; KZ0=1; BP=14; EPS=0.15
SIGMA=5.0; TARGET_TU=100
LZ=25.132741228718345   # 8*pi
NZ=256

# ---- Leg A: xi_cut=5, xi_sponge=0 (k_mode 1..6 -> kz_phys 0.25..1.50) ----
for k in 1 2 3 4 5 6; do
    KZ_SUPP=$((k - 1))
    SEED="seeds/eigenmode_seed_kz${k}_a2.00_V0.050_sp0.0_lz25.1327.bin"
    cat > run_t13confirm_xc_k${k}.ini <<EOF
k_mode          = $k
alpha_YM        = $ALPHA
perturb_amp     = $AMP
run_mode        = $MODE
V0              = $V0
xi_sponge       = 0
sigma_sponge    = $SIGMA
xi_cut          = 5.0
suppress_kz0    = $KZ0
hyp_diff        = $HYP
kz_suppress_max = $KZ_SUPP
eps_override    = $EPS
kz_suppress_hi  = $BP
nz_override     = $NZ
lz_override     = $LZ
target_tu       = $TARGET_TU
run_tag         = t13confirm_xc
seed_profile_file = $SEED
EOF
    echo "=== T13confirm-xc k_mode=${k} (kz_phys=$(echo "scale=3; $k/4" | bc)) starting at $(date) ==="
    ./ym_coupled run_t13confirm_xc_k${k}.ini > run_t13confirm_xc_k${k}.log 2>&1
    echo "=== T13confirm-xc k_mode=${k} done at $(date) ==="
done

# ---- Leg B: xi_sponge=13, xi_cut=0 -- artifact-reproduction check at the two
#      points central to the original claim (k_mode=2 -> kz_phys=0.5, k_mode=3
#      -> kz_phys=0.75), using the pre-existing eigenvector-based sp13 seeds ----
for k in 2 3; do
    KZ_SUPP=$((k - 1))
    SEED="seeds/eigenmode_seed_kz${k}_a2.00_V0.050_sp13.0_lz25.1327.bin"
    cat > run_t13confirm_sp13_k${k}.ini <<EOF
k_mode          = $k
alpha_YM        = $ALPHA
perturb_amp     = $AMP
run_mode        = $MODE
V0              = $V0
xi_sponge       = 13.0
sigma_sponge    = $SIGMA
xi_cut          = 0
suppress_kz0    = $KZ0
hyp_diff        = $HYP
kz_suppress_max = $KZ_SUPP
eps_override    = $EPS
kz_suppress_hi  = $BP
nz_override     = $NZ
lz_override     = $LZ
target_tu       = $TARGET_TU
run_tag         = t13confirm_sp13
seed_profile_file = $SEED
EOF
    echo "=== T13confirm-sp13 k_mode=${k} (kz_phys=$(echo "scale=3; $k/4" | bc)) starting at $(date) ==="
    ./ym_coupled run_t13confirm_sp13_k${k}.ini > run_t13confirm_sp13_k${k}.log 2>&1
    echo "=== T13confirm-sp13 k_mode=${k} done at $(date) ==="
done
