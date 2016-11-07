#!/bin/bash -e

#SBATCH -J trim
#SBATCH -A DSMITH-BIOCLOUD
#SBATCH -o slurm-%A.out
#SBATCH -p biocloud-normal
#SBATCH --time=05:00:00

. /home/tcj25/.virtualenvs/35/bin/activate

task=$1
fastq=../$task.fastq.gz
log=../$task.log
out=$task-trimmed.fastq.gz

echo "01-trim on task $task started at `date`" >> $log
echo "  fastq is $fastq" >> $log

# The adapter is either in field 7 or 8 (underscore separated) and must
# have 6 characters from the set A, C, G, T, N (this is what AdapterRemoval
# says when you give it something that it cannot handle).
adapter=`echo $task | cut -f7 -d_ | egrep '^[ACGTN]{6}$'`

if [ -z "$adapter" ]
then
    adapter=`echo $task | cut -f8 -d_ | egrep '^[ACGTN]{6}$'`

    if [ -z "$adapter" ]
    then
        echo "  WARNING: Could not find adapter sequence in task $task" >> $log
        exit 1
    fi
fi

echo "  adapter is $adapter" >> $log

srun -n 1 AdapterRemoval \
  --basename $task \
  --adapter1 $adapter \
  --file1 $fastq \
  --output1 $out \
  --gzip \
  --trimns \
  --trimqualities

echo "01-trim on task $task stopped at `date`" >> $log
echo >> $log
