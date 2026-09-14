#!/bin/bash
#SBATCH -J dumb_test
#SBATCH --partition=caslake
#SBATCH --account=pi-pmuralidhar
#SBATCH --mem=10
#SBATCH --time=0-00:10:00
#SBATCH --output=dumb_test_%A_%a.out
#SBATCH --error=dumb_test_%A_%a.error
#SBATCH --array=1-10
#SBATCH --mail-type=FAIL  # Email notification options: ALL, BEGIN, END, FAIL, ALL, NONE
#SBATCH --mail-user=jcholder@rcc.uchicago.edu

cd /project/pmuralidhar/jcholder/mito_nuclear/scripts

label=$SLURM_ARRAY_TASK_ID

echo $label
