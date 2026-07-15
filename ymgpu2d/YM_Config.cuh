#pragma once
#include <string>

// All runtime parameters for a single ym_coupled run.
// Loaded from a key=value config file; see YM_Config.cu for the parser.
struct RunConfig {
    // ── Required ──────────────────────────────────────────────────────────────
    int   k_mode    = 1;
    float alpha_YM  = 0.5f;

    // ── Physics ───────────────────────────────────────────────────────────────
    float perturb_amp    = 0.001f;
    int   run_mode       = 6;        // 6=NAB_CIRC_AZ2 (active); see CLAUDE.md
    float V0             = 0.1f;
    float xi_sponge      = 0.0f;    // 0 = disabled
    float sigma_sponge   = 5.0f;
    float xi_cut         = 0.0f;    // 0 = disabled; hard-wall Dirichlet BC, |xi|>xi_cut forced to zero
    int   freeze_override = -1;     // -1 = use run_mode default
    int   suppress_kz0   = 0;
    float hyp_diff       = 0.0f;
    int   kz_suppress_max = 0;
    float eps_override   = -1.0f;   // -1 = Lx/6
    int   kz_suppress_hi  = 0;
    float vz_edge_taper  = 0.0f;    // >0: taper vz smoothly to 0 for |ξ| beyond this
                                    // (width 3 ξ-units), modes 1/6 — removes the
                                    // periodic-wrap vz discontinuity that destroys
                                    // suppress_kz0=0 runs (kz=0 wrap collapse, see
                                    // OUTER_REGION.md). Put it well outside the
                                    // measurement window (e.g. 50).
    int   init_by1_eq    = 0;       // 1 = initialize By1 to the current-consistent
                                    // color-1 equilibrium (∂x By1 = Jz1) in modes 1/6.
                                    // Required for suppress_kz0=0 runs: with By1=0 the
                                    // color-1 background is out of equilibrium and the
                                    // screened DC of Ez1 secularly pumps By1 at the
                                    // shear layer → kz=0 density collapse by t≈12
                                    // (2026-07-15 depletion experiment, OUTER_REGION.md)

    // ── Grid / timestep ───────────────────────────────────────────────────────
    int   nz_override      = -1;    // -1 = default 64
    int   nx_override      = -1;    // -1 = default 768
    float courant_override = -1.0f; // -1 = default 0.1
    float lz_override      = -1.0f; // -1 = default 2π
    float lx_override      = -1.0f; // -1 = default 6π

    // ── Run control ───────────────────────────────────────────────────────────
    float       target_tu        = -1.0f; // -1 = run until energy threshold
    std::string run_tag          = "";
    std::string seed_profile_file = "";
};

// Parse a key=value config file (lines starting with # are comments).
// Prints all loaded values and validates NZ/kz constraints.
// Exits with error message if required keys or constraints are violated.
RunConfig load_config(const std::string& path);
