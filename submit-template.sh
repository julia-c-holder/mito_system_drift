#!/bin/bash
#SBATCH --job-name=ld_walk
#SBATCH --output=ld_walk.out
#SBATCH --error=ld_walk.err

#SBATCH --account=pi-pmuralidhar
#SBATCH --partition=caslake

#SBATCH --time=00:15:00

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=15000

#SBATCH --mail-type=FAIL  # Email notification options: ALL, BEGIN, END, FAIL, ALL, NONE
#SBATCH --mail-user=jcholder@rcc.uchicago.edu

module load SLiM/5.1
cd /project/pmuralidhar/jcholder/ld_walk
