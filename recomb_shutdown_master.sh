#!/bin/bash


## define changing variables ###

sds=$(echo 1.0) 

names=$(echo "recombination_shutdown.slim")
#"Y_chrom_no_male_rec.slim"

cd /scratch/midway3/pmuralidhar/pavitra/sex_chromosome_transitions_rev/LOOP_recomb_shutdown/



for name in $names
do
   for num in $sds
   	do
   	sbatch --export=SD=$num,CD=$name  AFTER_recomb_shutdown.sh
   	done
done

