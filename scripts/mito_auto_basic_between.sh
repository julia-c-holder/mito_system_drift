#!/bin/bash
#SBATCH -J mito_auto_between
#SBATCH --partition=caslake
#SBATCH --account=pi-pmuralidhar
#SBATCH --mem=1500
#SBATCH --time=1-12:00:00
#SBATCH --output=/project/pmuralidhar/jcholder/mito_nuclear/logs/Array_%A_%a.out
#SBATCH --error=/project/pmuralidhar/jcholder/mito_nuclear/logs/Array_%A_%a.error
#SBATCH --array=1-1000
#SBATCH --mail-type=FAIL  # Email notification options: ALL, BEGIN, END, FAIL, ALL, NONE
#SBATCH --mail-user=jcholder@rcc.uchicago.edu

module load SLiM/5.1

cd /project/pmuralidhar/jcholder/mito_nuclear/scripts

label=$(($(($(($SLURM_ARRAY_TASK_ID - 1)) / 100)) + 1))
which_pop=$(($(($SLURM_ARRAY_TASK_ID % 10))+1))
dirPath="/project/pmuralidhar/jcholder/mito_nuclear/results/"

slim -d "results_path_base='$dirPath'" -d "extra='$label'" -d 'replicate_id=14' -d "which_pop='$which_pop'" mito_auto_basic_between.slim
