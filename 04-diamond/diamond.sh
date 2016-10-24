#!/bin/bash

task=$1
fastq=../03-find-unmapped/$task-unmapped.fastq.gz
out=$task.json.bz2

echo "FASTQ file is $fastq"

diamond blastx \
    --tmpdir /ramdisks \
    --threads 24 \
    --query $fastq \
    --db /home/tcj25/scratch/root/share/ncbi/diamond-dbs/viral.nonredundant_protein.protein.dmnd \
    --outfmt 6 qtitle stitle bitscore evalue qframe qseq qstart qend sseq sstart send slen |
convert-diamond-to-json.py --bzip2 > $out