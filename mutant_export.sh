#!/usr/bin/env sh
# -*- coding: utf-8 -*-

# Remove old export
rm -rf assets/img/mutant
mkdir assets/img/mutant

cd mutant
# Export SVGs to PNGs, using 8 threads, only exporting human skin tones (sorry, furries)
./Orxporter/orxport.py -m manifest/out.orx -i ../input -q 32x32 -o ../assets/img/mutant -F png-256 -C cache -r resvg -f %f/%s -t 8
# -e color=y2

# Export JSON
./Orxporter/orxport.py -m manifest/out.orx -i ../input -C cache -t 8 -j ../assets/mutant_output.json
cd ..
# # Process JSON file to remove unnecessary data and flatten the structure
py json_fix.py