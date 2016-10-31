#!/bin/bash -e

. /home/tcj25/.virtualenvs/35/bin/activate

task=$1
log=../$task.log
bam=../02-map/$task.bam

echo "03-find-unmapped on task $task started at `date`" >> $log
echo "  bam file is $bam" >> $log

echo "  print-unmapped-sam.py started at `date`" >> $log
print-unmapped-sam.py $bam | gzip > $task-unmapped.fastq.gz
echo "  print-unmapped-sam.py stopped at `date`" >> $log

echo "03-find-unmapped on task $task stopped at `date`" >> $log
echo >> $log
