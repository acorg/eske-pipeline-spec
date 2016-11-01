#!/bin/bash -e

. /home/tcj25/.virtualenvs/35/bin/activate

task=$1
log=../$task.log
fastq=../03-find-unmapped/$task-unmapped.fastq.gz
out=$task.json.bz2

echo "04-diamond on task $task started at `date`" >> $log
echo "  fastq file is $fastq" >> $log


dbfile=$HOME/scratch/root/share/ncbi/diamond-dbs/viral-protein.dmnd

if [ ! -f $dbfile ]
then
    echo "DIAMOND database file $dbfile does not exist!" >> $log
    exit 1
fi

echo "  diamond blastx started at `date`" >> $log
diamond blastx \
    --tmpdir /ramdisks \
    --threads 24 \
    --query $fastq \
    --db $dbfile \
    --outfmt 6 qtitle stitle bitscore evalue qframe qseq qstart qend sseq sstart send slen btop |
convert-diamond-to-json.py | bzip2 > $out
echo "  diamond blastx stopped at `date`" >> $log

echo "04-diamond on task $task stopped at `date`" >> $log
echo >> $log
