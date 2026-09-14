#!/bin/bash

for (( i=1; i < 101; i++ )); do
    sbatch job${i}.sh
done
