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
    float warm_T         = 0.0f;    // isothermal pressure closure: P=n*T, 0=cold (backward compat)
    int   freeze_override = -1;     // -1 = use run_mode default
    int   suppress_kz0   = 0;
    float hyp_diff       = 0.0f;
    int   kz_suppress_max = 0;
    float eps_override   = -1.0f;   // -1 = Lx/6
    int   kz_suppress_hi  = 0;

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
