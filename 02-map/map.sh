#!/bin/bash -e

. /home/tcj25/.virtualenvs/35/bin/activate

task=$1
log=../$task.log
fastq=../01-trim/$task-trimmed.fastq.gz

echo "02-map on task $task started at `date`" >> $log
echo "  fastq is $fastq" >> $log

# Map to human genome, save to ramdisk SAM file.
echo "  bwa mem started at `date`" >> $log
bwa mem -t 24 $HOME/scratch/homo-sapiens/homo-sapiens $fastq > /ramdisks/terry-$task.sam
echo "  bwa mem stopped at `date`" >> $log

# Convert SAM to BAM, on ramdisk.
echo "  sam -> bam conversion started at `date`" >> $log
samtools view --threads 24 -bS /ramdisks/terry-$task.sam > /ramdisks/terry-$task.bam
echo "  sam -> bam conversion stopped at `date`" >> $log

# Sort ramdisk BAM, writing to persisted local storage.
echo "  bam sort started at `date`" >> $log
samtools sort --threads 24 -o $task.bam /ramdisks/terry-$task.bam
echo "  bam sort stopped at `date`" >> $log

echo "02-map on task $task stopped at `date`" >> $log
echo >> $log
