#!/bin/bash
#SBATCH -J swap_var_sing
#SBATCH --partition=caslake
#SBATCH --account=pi-pmuralidhar
#SBATCH --mem=5000
#SBATCH --time=0-00:10:00
#SBATCH --output=/project/pmuralidhar/jcholder/mito_nuclear/logs/Swap_Array_%A_%a.out
#SBATCH --error=/project/pmuralidhar/jcholder/mito_nuclear/logs/Swap_Array_%A_%a.error
#SBATCH --array=1-125
#SBATCH --mail-type=FAIL  # Email notification options: ALL, BEGIN, END, FAIL, ALL, NONE
#SBATCH --mail-user=jcholder@rcc.uchicago.edu

module load R

cd /project/pmuralidhar/jcholder/mito_nuclear/

label=$SLURM_ARRAY_TASK_ID
suffix="150000.csv"

Rscript swap_var_sing.R $label $suffix
