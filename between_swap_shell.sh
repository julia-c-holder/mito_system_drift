#!/bin/bash

for (( i=1; i < 11; i++ )); do
	for (( j=1; j < 11; j++ )); do
	  for (( k=1; k < j; k++ )); do
		  cp between_swap_template.sh between_swap_${k}_${i}_${j}.sh
    		echo "Rscript mito_system_drift/mito_swap_between.R ${i} ${j} ${k} '14' '150000.csv'" >> between_swap_${k}_${i}_${j}.sh
		  sbatch between_swap_${i}_${j}_${k}.sh
		done
	done
done
