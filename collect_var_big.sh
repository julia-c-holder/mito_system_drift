#!/bin/bash
#SBATCH --job-name=collect_var_big
#SBATCH --output=collect_var_please.out
#SBATCH --error=collect_error_please.err

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
#repnum="8"
R --no-save CMD BATCH collect_var_big.R #$repnum
