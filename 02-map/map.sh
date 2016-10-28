#!/bin/bash -e

task=$1
fastq=../01-trim/$task-trimmed.fastq.gz

. /home/tcj25/.virtualenvs/35/bin/activate

# Map to human genome, save to ramdisk SAM file.
bwa mem -t 24 $HOME/scratch/homo-sapiens/homo-sapiens $fastq > /ramdisks/terry-$task.sam

# Convert SAM to BAM, on ramdisk.
samtools view --threads 24 -bS /ramdisks/terry-$task.sam > /ramdisks/terry-$task.bam

# Sort ramdisk BAM, writing to persisted local storage.
samtools sort --threads 24 -o $task.bam /ramdisks/terry-$task.bam
