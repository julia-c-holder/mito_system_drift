#!/bin/bash
#SBATCH -J within_var_sing
#SBATCH --partition=caslake
#SBATCH --account=pi-pmuralidhar
#SBATCH --mem=7000
#SBATCH --time=0-00:15:00
#SBATCH --output=/project/pmuralidhar/jcholder/mito_nuclear/logs/Within_Array_%A_%a.out
#SBATCH --error=/project/pmuralidhar/jcholder/mito_nuclear/logs/Within_Array_%A_%a.error
#SBATCH --array=1-250
#SBATCH --mail-type=FAIL  # Email notification options: ALL, BEGIN, END, FAIL, ALL, NONE
#SBATCH --mail-user=jcholder@rcc.uchicago.edu

module load R

cd /project/pmuralidhar/jcholder/mito_nuclear/

label=$SLURM_ARRAY_TASK_ID
suffix="150000.csv"
norm_file="results/normalizer/normal_6.csv"
repnum="6"
Rscript within_var_sing.R $label $suffix $norm_file $repnum
