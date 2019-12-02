#!/usr/bin/env bash
#SBATCH -J SeekDeep
#SBATCH --time=12:00:00
#SBATCH --nodes=2
#SBATCH --tasks-per-node=8
#SBATCH -o SeekDeep-%j.out
#SBATCH -e SeekDeep-%j.err
module load gatk/4.0.9.0
module load R/3.6.0
gatk SelectVariants  \
	-R Pfalciparum.genome.fasta \
	-V merge.vcf \
	-select-type SNP \
	-O raw_snps.vcf \
	-se 'SAMPLE.+AH10'  
