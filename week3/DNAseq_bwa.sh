#!/bin/bash
#SBATCH --job-name=bwa    ## Name of the job.
#SBATCH -A ECOEVO283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=2  ## number of cores the job needs
#SBATCH --array=1-12

#variables
SourceDir="/pub/yig21/ee283/DNAseq/rawdata"
DestDir="/pub/yig21/ee283/DNAseq/results"
file="/pub/yig21/ee283/DNAseq/script/prefixes.txt"
ref="/pub/yig21/ee283/dm6_ref/dmel-all-chromosome-r6.13.fasta"
prefix=`head -n $SLURM_ARRAY_TASK_ID $file | tail -n 1`

#load modules
module load bwa/0.7.17
module load samtools/1.15.1

#bwa
echo "aligning" $prefix
bwa mem -t 2 -M $ref $SourceDir/$prefix\_1.fq.gz $SourceDir/$prefix\_2.fq.gz | samtools view -bS - > $DestDir/$prefix.bam 
samtools sort $DestDir/$prefix.bam -o $DestDir/$prefix.sort.bam
