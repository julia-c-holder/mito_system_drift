#!/bin/bash

for (( i=1; i < 101; i++ )); do
    cp submit-template.sh job${i}.sh
    echo "slim -d extra=${i} longer_walk_ld.slim" >> job${i}.sh
done

