#!/usr/bin/env python3
"""Worker: compute find_safe_xi_sponge for a chunk of (alpha,V0,kz) points.
Run with single-threaded BLAS env vars set BEFORE this script starts
(set by the caller, not here, since numpy is imported at module load time).

Usage: python3 _sponge_chunk_worker.py chunk_in.csv chunk_out.csv
chunk_in.csv columns: alpha,V0,kz
chunk_out.csv columns: alpha,V0,kz,xi_sponge,gamma_exact,safe
"""
import sys, os, csv, time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from find_safe_sponge import find_safe_xi_sponge

def main():
    in_path, out_path = sys.argv[1], sys.argv[2]
    rows = []
    with open(in_path) as f:
        r = csv.DictReader(f)
        for row in r:
            rows.append((float(row['alpha']), float(row['V0']), float(row['kz'])))

    with open(out_path, 'w', newline='') as fo:
        w = csv.writer(fo)
        w.writerow(['alpha', 'V0', 'kz', 'xi_sponge', 'gamma_exact', 'safe'])
        for i, (alpha, V0, kz) in enumerate(rows):
            t0 = time.time()
            try:
                sp, g, info = find_safe_xi_sponge(alpha, V0, kz, verbose=False)
            except Exception as e:
                print(f"  ERROR alpha={alpha} V0={V0} kz={kz}: {e}", file=sys.stderr)
                sp, g, info = 5, float('nan'), {'safe': False}
            w.writerow([alpha, V0, kz, sp, g if g is not None else '', info.get('safe', False)])
            fo.flush()
            if (i + 1) % 20 == 0:
                print(f"  [{out_path}] {i+1}/{len(rows)} done ({time.time()-t0:.1f}s last)", file=sys.stderr)

if __name__ == '__main__':
    main()
