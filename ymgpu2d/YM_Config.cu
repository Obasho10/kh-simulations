#include "YM_Config.cuh"
#include <fstream>
#include <sstream>
#include <iostream>
#include <algorithm>
#include <cmath>
#include <cstdlib>

static std::string trim(const std::string& s) {
    size_t a = s.find_first_not_of(" \t\r\n");
    size_t b = s.find_last_not_of(" \t\r\n");
    return (a == std::string::npos) ? "" : s.substr(a, b - a + 1);
}

RunConfig load_config(const std::string& path) {
    std::ifstream f(path);
    if (!f.is_open()) {
        std::cerr << "ERROR: cannot open config file '" << path << "'\n";
        std::exit(1);
    }

    RunConfig cfg;
    std::string line;
    int lineno = 0;

    while (std::getline(f, line)) {
        ++lineno;
        line = trim(line);
        if (line.empty() || line[0] == '#') continue;

        auto eq = line.find('=');
        if (eq == std::string::npos) {
            std::cerr << "WARNING: " << path << ":" << lineno
                      << ": no '=' found, skipping: " << line << "\n";
            continue;
        }

        std::string key = trim(line.substr(0, eq));
        std::string val = trim(line.substr(eq + 1));
        // Strip inline comments
        auto hash = val.find('#');
        if (hash != std::string::npos) val = trim(val.substr(0, hash));

        if      (key == "k_mode")            cfg.k_mode             = std::stoi(val);
        else if (key == "alpha_YM")          cfg.alpha_YM           = std::stof(val);
        else if (key == "perturb_amp")       cfg.perturb_amp        = std::stof(val);
        else if (key == "run_mode")          cfg.run_mode           = std::stoi(val);
        else if (key == "V0")                cfg.V0                 = std::stof(val);
        else if (key == "xi_sponge")         cfg.xi_sponge          = std::stof(val);
        else if (key == "sigma_sponge")      cfg.sigma_sponge       = std::stof(val);
        else if (key == "freeze_override")   cfg.freeze_override    = std::stoi(val);
        else if (key == "suppress_kz0")      cfg.suppress_kz0       = std::stoi(val);
        else if (key == "hyp_diff")          cfg.hyp_diff           = std::stof(val);
        else if (key == "kz_suppress_max")   cfg.kz_suppress_max    = std::stoi(val);
        else if (key == "eps_override")      cfg.eps_override       = std::stof(val);
        else if (key == "kz_suppress_hi")    cfg.kz_suppress_hi     = std::stoi(val);
        else if (key == "nz_override")       cfg.nz_override        = std::stoi(val);
        else if (key == "nx_override")       cfg.nx_override        = std::stoi(val);
        else if (key == "courant_override")  cfg.courant_override   = std::stof(val);
        else if (key == "lz_override")       cfg.lz_override        = std::stof(val);
        else if (key == "lx_override")       cfg.lx_override        = std::stof(val);
        else if (key == "target_tu")         cfg.target_tu          = std::stof(val);
        else if (key == "run_tag")           cfg.run_tag            = val;
        else if (key == "seed_profile_file") cfg.seed_profile_file  = val;
        else {
            std::cerr << "WARNING: " << path << ":" << lineno
                      << ": unknown key '" << key << "'\n";
        }
    }

    // ── Derived grid values (for validation and printout) ─────────────────────
    const int   NZ      = (cfg.nz_override > 0)   ? cfg.nz_override   : 64;
    const int   NX      = (cfg.nx_override > 0)   ? cfg.nx_override   : 768;
    const float LX      = (cfg.lx_override > 0.f) ? cfg.lx_override   : (float)(6.0 * M_PI);
    const float LZ      = (cfg.lz_override > 0.f) ? cfg.lz_override   : (float)(2.0 * M_PI);
    const float DX      = LX / NX;
    const float DZ      = LZ / NZ;
    const float COURANT = (cfg.courant_override > 0.f) ? cfg.courant_override : 0.1f;
    const float DT      = COURANT * DX;

    static const char* mode_names[] = {"NAB_LINEAR","NAB_CIRC","EMHD_KH","NAB_DTANH",
                                       "NAB_STEP","NAB_TANH_COSAZ","NAB_CIRC_AZ2"};
    const char* mname = (cfg.run_mode >= 0 && cfg.run_mode < 7)
                        ? mode_names[cfg.run_mode] : "?";

    std::cout << "================================================================\n"
              << " GPU SU(2) Yang-Mills KH Solver — config: " << path << "\n"
              << " k_mode="     << cfg.k_mode
              << "  alpha_YM="  << cfg.alpha_YM
              << "  perturb_amp=" << cfg.perturb_amp
              << "  V0="        << cfg.V0
              << "  mode="      << mname << "\n"
              << " xi_sponge="  << cfg.xi_sponge
              << "  sigma_sponge=" << cfg.sigma_sponge
              << "  freeze_override=" << cfg.freeze_override
              << "  suppress_kz0=" << cfg.suppress_kz0 << "\n"
              << " hyp_diff="   << cfg.hyp_diff
              << "  kz_suppress_max=" << cfg.kz_suppress_max
              << "  kz_suppress_hi="  << cfg.kz_suppress_hi
              << "  eps_override=" << cfg.eps_override << "\n"
              << " NX=" << NX << "  NZ=" << NZ
              << "  LX=" << LX << "  LZ=" << LZ
              << "  DX=" << DX << "  DZ=" << DZ
              << "  courant=" << COURANT << "  DT=" << DT << "\n"
              << " target_tu="  << cfg.target_tu
              << "  run_tag="   << cfg.run_tag << "\n"
              << " seed_file="  << (cfg.seed_profile_file.empty() ? "(WKB gaussian)"
                                                                   : cfg.seed_profile_file) << "\n"
              << "================================================================\n";

    // ── Constraint checks ─────────────────────────────────────────────────────
    if (cfg.suppress_kz0 && (NZ & (NZ - 1)) != 0) {
        std::cerr << "ERROR: suppress_kz0=1 requires NZ to be a power of 2 (got NZ=" << NZ << ")\n";
        std::exit(1);
    }
    if ((cfg.kz_suppress_max >= 1 || cfg.kz_suppress_hi > 0) && (NZ % 32 != 0)) {
        std::cerr << "ERROR: kz_suppress_max/kz_suppress_hi require NZ multiple of 32 (got NZ=" << NZ << ")\n";
        std::exit(1);
    }
    if (cfg.lz_override > 0.f && cfg.nz_override < 0)
        std::cerr << "WARNING: lz_override set but nz_override not set (NZ=" << NZ
                  << ", DZ=" << DZ << "). Consider nz_override=NZ*(lz/2pi) to keep DZ≈0.098.\n";
    if (cfg.lx_override > 0.f && cfg.nx_override < 0)
        std::cerr << "WARNING: lx_override set but nx_override not set (NX=" << NX
                  << ", DX=" << DX << "). Consider scaling NX to maintain EPS/DX≳6.\n";

    return cfg;
}
