#!/bin/bash

#SBATCH -J map
#SBATCH -A DSMITH-BIOCLOUD
#SBATCH -o slurm-%A-%a.out
#SBATCH -p biocloud-normal
#SBATCH --time=05:00:00

fastq=../01-trim/$1-trimmed.fastq.gz

echo "hostname is `hostname`"
echo "fastq is $fastq"

srun -n 1 map.sh $fastq
