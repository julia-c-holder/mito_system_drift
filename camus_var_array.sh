#!/bin/bash
#SBATCH -J camus_var_array
#SBATCH --partition=caslake
#SBATCH --account=pi-pmuralidhar
#SBATCH --mem=5000
#SBATCH --time=0-00:10:00
#SBATCH --output=/project/pmuralidhar/jcholder/mito_nuclear/logs/Camus_Array_%A_%a.out
#SBATCH --error=/project/pmuralidhar/jcholder/mito_nuclear/logs/Camus_Array_%A_%a.error
#SBATCH --array=1-81
#SBATCH --mail-type=FAIL  # Email notification options: ALL, BEGIN, END, FAIL, ALL, NONE
#SBATCH --mail-user=jcholder@rcc.uchicago.edu

module load R

cd /project/pmuralidhar/jcholder/mito_nuclear/

num1=$(($(($SLURM_ARRAY_TASK_ID / 9)) + 1))
num2=$(($(($SLURM_ARRAY_TASK_ID % 9)) + 1))
suffix="150000.csv"

Rscript camus_var_sing.R $num1 $num2 $suffix
