#!/bin/bash

for (( i=1; i < 126; i++ )); do
    cp mito_swap_template.sh job${i}.sh
    echo "Rscript mito_swap.R ${i} '5' '150000.csv' 'results/summaries/normalizer_big.csv'" >> job${i}.sh
done

