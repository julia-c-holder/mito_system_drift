#!/bin/bash

for (( i=1; i < 101; i++ )); do
    cp submit-template.sh job${i}.sh
    echo "slim -d extra=${i} walking_ld_midway.slim" >> job${i}.sh
done

