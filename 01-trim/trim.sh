#!/bin/bash

#SBATCH -J trim
#SBATCH -A DSMITH-BIOCLOUD
#SBATCH -o slurm-%A.out
#SBATCH -p biocloud-normal
#SBATCH --time=05:00:00

# The task is $1
task=$1
fastq=../$task.fastq.gz
adapter=`echo $task | cut -f7 -d_`
out=$task-trimmed.fastq.gz

echo "hostname is `hostname`"
echo "task is $task"
echo "fastq is $fastq"
echo "output going to $out"
echo "adapter is $adapter"

. /home/tcj25/.virtualenvs/35/bin/activate

srun -n 1 AdapterRemoval \
  --basename $task \
  --adapter1 $adapter \
  --file1 $fastq \
  --output1 $out \
  --gzip \
  --trimns \
  --trimqualities
