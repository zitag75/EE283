#!/bin/bash
#SBATCH --job-name=samtools    ## Name of the job.
#SBATCH -A GRYLEE_LAB       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=1  ## number of cores the job needs
#SBATCH --array=1-6

#variable
SourceDir="/pub/yig21/ee283/DNAseq/results"
file="/pub/yig21/ee283/DNAseq/script/prefixes.txt"
prefix=`head -n $SLURM_ARRAY_TASK_ID $file | tail -n 1`

#load modules
module load samtools/1.15.1

#run samtools
echo "extracting ${prefix}.sort.bam" 
#samtools index $SourceDir/$prefix.sort.bam
#samtools view -q 30 $SourceDir/$prefix.sort.bam X:1880000-2000000 > $SourceDir/$prefix.1880000-2000000.sort.bam
#samtools view --bam -f 4 -F 8 $SourceDir/$prefix.sort.bam X:1880000-2000000 > $SourceDir/$prefix.unmapped.bam
samtools fastq -1 $SourceDir/$prefix.unmapped.1.fq.gz -2 $SourceDir/$prefix.unmapped.2.fq.gz  $SourceDir/$prefix.unmapped.bam

