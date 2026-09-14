#!/bin/bash
#SBATCH --job-name=collect_ld_fit
#SBATCH --output=collect_ld_fit.out
#SBATCH --error=collect_ld_fit.err

#SBATCH --account=pi-pmuralidhar
#SBATCH --partition=caslake

#SBATCH --time=00:05:00

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=5000

#SBATCH --mail-type=FAIL  # Email notification options: ALL, BEGIN, END, FAIL, ALL, NONE
#SBATCH --mail-user=jcholder@rcc.uchicago.edu

module load R
cd /project/pmuralidhar/jcholder/ld_walk

R --no-save CMD BATCH ld_mov_collect.R
