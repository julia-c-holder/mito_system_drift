#!/bin/bash

for (( i=1; i < 126; i++ )); do
    sbatch job${i}.sh
done
