#!/bin/bash -e

#SBATCH -J panel
#SBATCH -A DSMITH-BIOCLOUD
#SBATCH -o slurm-%A.out
#SBATCH -p biocloud-normal
#SBATCH --time=10:00:00

. /home/tcj25/.virtualenvs/35/bin/activate

# The log file is the overall top-level job log file, seeing as this step
# is a 'collect' step that is only run once.
log=../slurm-pipeline.log

echo "05-panel started at `date`" >> $log

json_option=
fastq_option=
for task in "$@"
do
    echo "  task $task" >> $log
    json_option="$json_option --json ../04-diamond/$task.json.bz2"
    fastq_option="$fastq_option --fastq ../03-find-unmapped/$task-unmapped.fastq.gz"
done

echo >> $log

dbfile=$HOME/scratch/root/share/ncbi/viral-refseq/viral.protein.fasta

if [ ! -f $dbfile ]
then
    echo "DIAMOND database FASTA file $dbfile does not exist!" >> $log
    exit 1
fi

echo "  noninteractive-alignment-panel.py started at `date`" >> $log
srun -n 1 noninteractive-alignment-panel.py \
  $json_option \
  $fastq_option \
  --matcher diamond \
  --outputDir out \
  --withScoreBetterThan 40 \
  --maxTitles 200 \
  --minMatchingReads 3 \
  --negativeTitleRegex phage \
  --diamondDatabaseFastaFilename $dbfile
echo "  noninteractive-alignment-panel.py stopped at `date`" >> $log

echo "05-panel stopped at `date`" >> $log
echo >> $log
