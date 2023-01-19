#!/bin/bash
#SBATCH --job-name=test    ## Name of the job.
#SBATCH -p free 
#SBATCH --cpus-per-task=1  ## number of cores the job needs

SourceDir="/data/class/ecoevo283/public/RAWDATA/DNAseq"
FILES="$SourceDir/*"
for f in $FILES
do
   #echo "Processing $(basename $f)f file..."
   ln -s $f $(basename $f)
done
