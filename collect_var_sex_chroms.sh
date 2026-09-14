#!/bin/bash
#SBATCH --job-name=collect_sex_chroms
#SBATCH --output=collect_sex_chroms.out
#SBATCH --error=collect_sex_chroms.err

#SBATCH --account=pi-pmuralidhar
#SBATCH --partition=caslake

#SBATCH --time=00:25:00

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=5000

#SBATCH --mail-type=FAIL  # Email notification options: ALL, BEGIN, END, FAIL, ALL, NONE
#SBATCH --mail-user=jcholder@rcc.uchicago.edu

module load R
cd /project/pmuralidhar/jcholder/mito_nuclear
repnum="16"
Rscript collect_means_XY.R $repnum
