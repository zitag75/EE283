#!/bin/bash
#SBATCH --job-name=samtools    ## Name of the job.
#SBATCH -p standard
#SBATCH -A ECOEVO283
#SBATCH --cpus-per-task=1  ## number of cores the job need
#SBATCH --array=2-4

#load module
module load java/1.8.0
module load gatk/4.2.6.1 
#module load picard-tools/2.27.1  
#module load samtools/1.15.1

#variable
SourceDir="/pub/yig21/ee283/DNAseq/results"
ref="/pub/yig21/ee283/dm6_ref/dmel-all-chromosome-r6.13.fasta"
file="/pub/yig21/ee283/DNAseq/script/sample.txt"
sample=`head -n $SLURM_ARRAY_TASK_ID $file | tail -n 1`

#run command
#echo "processing" $sample
#samtools merge -o $SourceDir/$sample.bam $SourceDir/$sample\_1.sort.bam $SourceDir/$sample\_2.sort.bam $SourceDir/$sample\_3.sort.bam 
#samtools sort -o $SourceDir/$sample.sort.bam $SourceDir/$sample.bam 
#rm $SourceDir/$sample.bam
 
#java -jar /opt/apps/picard-tools/2.27.1/picard.jar AddOrReplaceReadGroups I=$SourceDir/$sample.sort.bam O=$SourceDir/$sample.RG.bam SORT_ORDER=coordinate RGPL=illumina RGPU=D109LACXX RGLB=Lib1 RGID=ADL06 RGSM=ADL06 VALIDATION_STRINGENCY=LENIENT
#java -jar /opt/apps/picard-tools/2.27.1/picard.jar MarkDuplicates REMOVE_DUPLICATES=true I=$SourceDir/$sample.RG.bam O=$SourceDir/$sample.dedup.bam M=$SourceDir/$sample\_marked_dup_metrics.txt
#samtools index $SourceDir/$sample.dedup.bam
/opt/apps/gatk/4.2.6.1/gatk HaplotypeCaller -R $ref -I $SourceDir/$sample.dedup.bam --minimum-mapping-quality 30 -ERC GVCF -O $SourceDir/$sample.g.vcf.gz

