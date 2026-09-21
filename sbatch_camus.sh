#!/bin/bash
for (( j=1; j <10; j++ )); do 
	for (( i=1; i < 10; i++ )); do
    		sbatch camus_swap_${i}_${j}.sh
	done
done
