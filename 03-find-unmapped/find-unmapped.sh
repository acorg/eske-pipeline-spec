#!/bin/bash

task=$1
bam=../02-map/$task-trimmed.bam

echo "BAM file is $bam"

/home/tcj25/.virtualenvs/35/bin/python read-bam.py $bam | gzip > $task-unmapped.fastq.gz
