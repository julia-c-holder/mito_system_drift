#!/bin/bash
#SBATCH --job-name=swapped_var
#SBATCH --output=swapped_var.out
#SBATCH --error=swapped_var.err

#SBATCH --account=pi-pmuralidhar
#SBATCH --partition=caslake

#SBATCH --time=00:25:00

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=15000

#SBATCH --mail-type=FAIL  # Email notification options: ALL, BEGIN, END, FAIL, ALL, NONE
#SBATCH --mail-user=jcholder@rcc.uchicago.edu

module load R
cd /project/pmuralidhar/jcholder/mito_nuclear

Rscript swapped_var.R "results/swapped/rep3_" "150000.csv"
