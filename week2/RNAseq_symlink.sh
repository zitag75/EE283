SourceDir="/data/class/ecoevo283/public/RAWDATA/RNAseq/"
find $SourceDir/* -name "*.fastq.gz" > RNAseq_fname.txt
File=../"RNAseq_fname.txt"
while read f
do
    echo $(basename $f)
    ln -s $f $(basename $f) 
done < $File

