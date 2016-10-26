#!/bin/bash

#SBATCH -J map
#SBATCH -A DSMITH-BIOCLOUD
#SBATCH -o slurm-%A-%a.out
#SBATCH -p biocloud-normal
#SBATCH --time=05:00:00

task=$1

echo "hostname is `hostname`"

srun -n 1 map.sh $task
