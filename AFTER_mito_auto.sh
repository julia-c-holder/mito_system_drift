#!/bin/bash
#SBATCH -J runSLIM
#SBATCH --export=ALL
#SBATCH --partition=tier1q
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=700
#SBATCH --time=2-12:00:00
#SBATCH --output=logs/Array_test.%A_%a.out
#SBATCH --error=logs/Array_test.%A_%a.error
#SBATCH --array=1-250

cd /ess/scratch/scratch1/pmuralidhar/pavitra/mitochondria/CODE_mito_auto/

BASEDIR=/ess/scratch/scratch1/pmuralidhar/pavitra/mitochondria/results/mito_auto_only_concord_shift/

mkdir -p $BASEDIR

if [[ "$MT" == "10" ]]; then
    folder=mito_auto_size_10/
elif [[ "$MT" == "100" ]]; then
    folder=mito_auto_size_100/
else
    folder=mito_auto_other_${MT}/
fi

dirPath=$BASEDIR$folder
mkdir -p $dirPath
	
varString=$(echo "-d" results_path_base="'$dirPath'" "-d" length_mito="${MT}" "-d" replicate_id="${SLURM_ARRAY_TASK_ID}")
./run_slim_after.sh ${CD} "$varString"



