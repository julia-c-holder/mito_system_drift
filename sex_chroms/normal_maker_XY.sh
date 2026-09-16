#!/bin/bash
#SBATCH --job-name=normal_maker
#SBATCH --output=normal_maker.out
#SBATCH --error=normal_maker.err

#SBATCH --account=pi-pmuralidhar
#SBATCH --partition=caslake

#SBATCH --time=00:15:00

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=2000

#SBATCH --mail-type=FAIL  # Email notification options: ALL, BEGIN, END, FAIL, ALL, NONE
#SBATCH --mail-user=jcholder@rcc.uchicago.edu

in_file="results/summaries/unnorm_16_collected.csv"
out_file="results/normalizer/normal_16.csv"

module load R
cd /project/pmuralidhar/jcholder/mito_nuclear

Rscript sex_chroms/normal_maker_XY.R $in_file $out_file
