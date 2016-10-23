#!/bin/bash

task=$1
jobid=`sbatch -n 1 $SP_DEPENDENCY_ARG --exclusive submit.sh $task | cut -f4 -d' '`
echo "TASK: $task $jobid"
