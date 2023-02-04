#!/bin/bash
#SBATCH --job-name=hisat2   ## Name of the job.
#SBATCH -p standard
#SBATCH -A GRYLEE_LAB
#SBATCH --cpus-per-task=1  ## number of cores the job need
#SBATCH --array=1-2

fa="/pub/yig21/ee283/dm6_ref/dmel-all-chromosome-r6.13.fasta"
gtf="/pub/yig21/ee283/dm6_ref/dmel-all-r6.13.gtf"
RefDir="/pub/yig21/ee283/dm6_ref/"
SourceDir="/pub/yig21/ee283/RNAseq/rawdata"
OutDir="/pub/yig21/ee283/RNAseq/result"
file="/pub/yig21/ee283/RNAseq/script/prefixes.txt"
prefix=`head -n $SLURM_ARRAY_TASK_ID $file | tail -n 1`


#load module
module load hisat2/2.2.1
module load samtools/1.15.1

#building reference
#hisat2_extract_splice_sites.py $gtf > dm6.ss
#hisat2_extract_exons.py $gtf > dm6.exon
#hisat2-build -p 8 --exon $RefDir/dm6.exon --ss $RefDir/dm6.ss $fa $RefDir/dm6_trans

#aligning and sort 
echo "aligning" $prefix 
hisat2 -p 2 -x $RefDir/dm6_trans -1 $SourceDir/$prefix\_R1_001.fastq.gz -2 $SourceDir/$prefix\_R2.001.fastq.gz | samtools view -bS - > $OutDir/$prefix.bam
samtools sort $OutDir/$prefix.bam -o $OutDir/$prefix.sort.bam
samtools index $OutDir/$prefix.sorted.bam
rm $OutDir/$prefix.bam
