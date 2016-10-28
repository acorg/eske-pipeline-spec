#!/bin/bash

task=$1
bam=../02-map/$task.bam

. /home/tcj25/.virtualenvs/35/bin/activate

echo "BAM file is $bam"

print-unmapped-sam.py $bam | gzip > $task-unmapped.fastq.gz
