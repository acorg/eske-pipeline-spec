#!/bin/bash

case $# in
  1) fastq="$1";;
  *) echo "Usage: `basename $0` fastq-file" 2>&1; exit 1;;
esac

. /home/tcj25/.virtualenvs/35/bin/activate

basename="`basename $fastq | sed 's/\.fastq\.gz$//'`"

# Map to human genome, save to ramdisk SAM file.
bwa mem -t 24 $HOME/scratch/homo-sapiens/homo-sapiens $fastq > /ramdisks/terry-$basename.sam

# Convert SAM to BAM, on ramdisk.
samtools view -bS /ramdisks/terry-$basename.sam > /ramdisks/terry-$basename.bam

# Sort ramdisk BAM, writing to persisted local storage.
samtools sort --threads 24 -o $basename.bam /ramdisks/terry-$basename.bam
