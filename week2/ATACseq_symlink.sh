#!/bin/bash
#SBATCH --job-name=test    ## Name of the job.
#SBATCH -p free 
#SBATCH --cpus-per-task=1  ## number of cores the job needs

SourceDir="/data/class/ecoevo283/public/RAWDATA/ATACseq"
File="ATACseq.labels.txt"
while read p
do
   echo "${p}"
   barcode=$(echo $p | cut -f1 -d" ")
   genotype=$(echo $p | cut -f2 -d" ")
   tissue=$(echo $p | cut -f3 -d" ")
   bioRep=$(echo $p | cut -f4 -d" ")
   READ1=$(find ${SourceDir}/ -type f -iname "*_${barcode}_R1.fq.gz")
   READ2=$(find ${SourceDir}/ -type f -iname "*_${barcode}_R2.fq.gz")    
   
   Fname_R1=$genotype\_$tissue\_$bioRep\_R1.fq.gz
   Fname_R2=$genotype\_$tissue\_$bioRep\_R2.fq.gz
   ln -s $SourceDir/*_${barcode}_R1.fq.gz $Fname_R1
   ln -s $SourceDir/*_${barcode}_R2.fq.gz $Fname_R2
done < $File


