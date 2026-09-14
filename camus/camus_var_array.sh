#!/bin/bash

for (( i=1; i < 10; i++ )); do
	for (( j=1; j < 10; j++ )); do
		if [ ${j} -ne ${i} ]; then
			cp camus/camus_var_sing.sh camus_var_${i}_${j}.sh
    			echo "Rscript camus/camus_var_sing.R ${i} ${j} '8' '150000.csv'" >> camus_var_${i}_${j}.sh
			sbatch camus_var_${i}_${j}.sh
		fi
	done
done

