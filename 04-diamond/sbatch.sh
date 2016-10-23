#!/bin/bash

task=$1

echo "task is $task" > sbatch-$task.out
echo "deps are $SP_DEPENDENCY_ARG" >> sbatch-$task.out

jobid=`sbatch -n 1 $SP_DEPENDENCY_ARG --exclusive submit.sh $task | cut -f4 -d' '`
echo "TASK: $task $jobid"
