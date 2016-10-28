#!/bin/bash -e

task=$1

echo "task is $task" > sbatch-$task.out
echo "deps are $SP_DEPENDENCY_ARG" >> sbatch-$task.out

# Request an exclusive machine because we're going to tell bwa and samtools
# to use 24 threads.
jobid=`sbatch -n 1 --exclusive $SP_DEPENDENCY_ARG submit.sh $task | cut -f4 -d' '`
echo "TASK: $task $jobid"
