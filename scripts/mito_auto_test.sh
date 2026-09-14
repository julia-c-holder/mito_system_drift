#!/bin/bash
#SBATCH -J mito_auto_cov_test
#SBATCH --partition=caslake
#SBATCH --account=pi-pmuralidhar
#SBATCH --mem=500
#SBATCH --time=1-12:00:00
#SBATCH --output=/project/pmuralidhar/jcholder/mito_nuclear/logs/Array_test.out
#SBATCH --error=/project/pmuralidhar/jcholder/mito_nuclear/logs/Array_test.error
#SBATCH --array=1
#SBATCH --mail-type=FAIL  # Email notification options: ALL, BEGIN, END, FAIL, ALL, NONE
#SBATCH --mail-user=jcholder@rcc.uchicago.edu

module load SLiM/5.1

cd /project/pmuralidhar/jcholder/mito_nuclear/scripts

dirPath="/project/pmuralidhar/jcholder/mito_nuclear/results/"

slim -d "results_path_base='$dirPath'" -d 'extra="test"' -d 'replicate_id=1' mito_auto_w_cov.slim
