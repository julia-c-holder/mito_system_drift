#!/bin/bash
#SBATCH -J runSLIM
#SBATCH --partition=caslake
#SBATCH --account=pi-pmuralidhar
#SBATCH --mem=3500
#SBATCH --time=1-12:00:00
#SBATCH --output=logs/Array_test.%A_%a.out
#SBATCH --error=logs/Array_test.%A_%a.error
#SBATCH --array=1-250


cd /scratch/midway3/pmuralidhar/pavitra/sex_chromosome_transitions_rev/CODE_recomb_shutdown/

BASEDIR=/scratch/midway3/pmuralidhar/pavitra/sex_chromosome_transitions_rev/results/

mkdir -p $BASEDIR

folder='longer_second_round/'
dirPath=$BASEDIR$folder
mkdir -p $dirPath

	
varString=$(echo "-d" results_path_base="'$dirPath'" "-d" fit_sd="${SD}")
./run_slim_after.sh ${CD} "$varString"