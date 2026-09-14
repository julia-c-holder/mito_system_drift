#!/bin/bash
#SBATCH --job-name=mito_swap
#SBATCH --output=mito_swap.out
#SBATCH --error=mito_swap.err

#SBATCH --account=pi-pmuralidhar
#SBATCH --partition=caslake

#SBATCH --time=00:05:00

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=5000

#SBATCH --mail-type=FAIL  # Email notification options: ALL, BEGIN, END, FAIL, ALL, NONE
#SBATCH --mail-user=jcholder@rcc.uchicago.edu

module load R
cd /project/pmuralidhar/jcholder/mito_nuclear
