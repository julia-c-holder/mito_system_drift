#!/bin/bash
#SBATCH --job-name=rand_mito_swap
#SBATCH --output=rand_mito_swap.out
#SBATCH --error=rand_mito_swap.err

#SBATCH --account=pi-pmuralidhar
#SBATCH --partition=caslake

#SBATCH --time=00:15:00

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=5000

#SBATCH --output=/project/pmuralidhar/jcholder/mito_nuclear/logs/rand_swap_Array_%A_%a.out
#SBATCH --error=/project/pmuralidhar/jcholder/mito_nuclear/logs/rand_swap_Array_%A_%a.error
#SBATCH --array=1-125
#SBATCH --mail-type=FAIL  # Email notification options: ALL, BEGIN, END, FAIL, ALL, NONE
#SBATCH --mail-user=jcholder@rcc.uchicago.edu

ind=$SLURM_ARRAY_TASK_ID
folder="3"
suffix="150000.csv"

module load R
cd /project/pmuralidhar/jcholder/mito_nuclear
Rscript rand_mito_swap.R $ind $folder $suffix
