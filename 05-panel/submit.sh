#!/bin/bash

#SBATCH -J panels
#SBATCH -A DSMITH-BIOCLOUD
#SBATCH -o slurm-%A-%a.out
#SBATCH -p biocloud-normal
#SBATCH --time=10:00:00

json_option=
fastq_option=
for task in "$@"
do
    json_option="$json_option --json ../04-diamond/$task.json.bz2"
    fastq_option="$fastq_option --fastq ../$task.fastq.gz"
done

. /home/tcj25/.virtualenvs/35/bin/activate

srun -n 1 noninteractive-alignment-panel.py \
  --outputDir out \
  $json_option \
  $fastq_option \
  --withScoreBetterThan 50 \
  --checkAlphabet 0
