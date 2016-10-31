#!/bin/bash -e

. /home/tcj25/.virtualenvs/35/bin/activate

log=../slurm-pipeline.log

echo "SLURM pipeline finished at `date`" >> $log

touch ../slurm-pipeline.done
