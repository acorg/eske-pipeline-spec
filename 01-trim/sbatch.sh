#!/bin/sh

for fastq in "$@"
do
    task=`echo $fastq | cut -f1 -d.`
    jobid=`sbatch -n 1 trim.sh $task | cut -f4 -d' '`
    echo "TASK: $task $jobid"
done
