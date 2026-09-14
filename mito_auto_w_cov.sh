#!/bin/bash
#SBATCH -J mito_auto_cov
#SBATCH --partition=caslake
#SBATCH --account=pi-pmuralidhar
#SBATCH --mem=250
#SBATCH --time=0-12:00:00
#SBATCH --output=logs/Array_test.%A_%a.out
#SBATCH --error=logs/Array_test.%A_%a.error
#SBATCH --array=1-250

module load SLiM/5.1

cd /project/pmuralidhar/jcholder/mito_nuclear/scripts

dirPath='/project/pmuralidhar/jcholder/mito_nuclear/results/'

slim -d results_path_base=$dirPath -d extra=${%A_%a} mito_auto_w_cov.slim