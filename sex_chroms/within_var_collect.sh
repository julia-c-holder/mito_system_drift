#!/bin/bash
#SBATCH --job-name=within_var_collect
#SBATCH --output=within_var_collect.out
#SBATCH --error=within_var_collect.err

#SBATCH --account=pi-pmuralidhar
#SBATCH --partition=caslake

#SBATCH --time=00:25:00

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=5000

#SBATCH --mail-type=FAIL  # Email notification options: ALL, BEGIN, END, FAIL, ALL, NONE
#SBATCH --mail-user=jcholder@rcc.uchicago.edu
rep=16
module load R
cd /project/pmuralidhar/jcholder/mito_nuclear

Rscript within_var_collect.R $rep
