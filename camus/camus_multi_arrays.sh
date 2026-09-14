#!/bin/bash

for (( i=1; i < 10; i++ )); do
	for (( j=1; j < 10; j++ )); do
		if [ ${j} -ne ${i} ]; then
			cp camus_swap_template.sh camus_swap_${i}_${j}.sh
    			echo "Rscript camus/camus_swap.R ${i} ${j} '8' '150000.csv' 'results/normalizer/normal_8.csv'" >> camus_swap_${i}_${j}.sh
			sbatch camus_swap_${i}_${j}.sh
		fi
	done
done

