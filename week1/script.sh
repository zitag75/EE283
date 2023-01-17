#!/bin/bash
#SBATCH --job-name=test    ## Name of the job.
#SBATCH -p free       ## partition/queue name
#SBATCH --cpus-per-task=1  ## number of cores the job needs

#download tar ball
wget https://wfitch.bio.uci.edu/~tdlong/problem1.tar.gz

#untar
tar -xvf problem1.tar.gz
rm problem1.tar.gz

#write the 10th lines
head problem1/p.txt| tail -1
head problem1/f.txt| tail -1

