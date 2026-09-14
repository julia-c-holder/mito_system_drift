#!/bin/bash

## define changing variables ###
names=$(echo "mito_auto_only_concord_shift.slim")
ms=$(echo 10 100)

# submit from this directory; ensure logs/ exists here because --output uses it
cd /ess/scratch/scratch1/pmuralidhar/pavitra/mitochondria/LOOP_mito_auto/
mkdir -p logs

for name in $names; do
  for num in $ms; do
    sbatch --export=MT=$num,CD=$name AFTER_mito_auto.sh
  done
done