#!/bin/bash

for (( i=1; i < 10; i++ )); do
	for (( j=1; j < 10; j++ )); do
		cp camus_swap_template.sh camus_swap_${i}_${j}.sh
    		echo "Rscript camus_swap.R ${i} ${j} '3' '150000.csv'" >> camus_swap_${i}_${j}.sh
		sbatch camus_swap${i}_${j}.sh
	done
done

