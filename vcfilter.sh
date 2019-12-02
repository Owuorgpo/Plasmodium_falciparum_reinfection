#!/usr/bin/env bash
#SBATCH -J recurrent
#SBATCH --time=12:00:00
#SBATCH --nodes=2
#SBATCH --tasks-per-node=8
#SBATCH -o recurrent-%j.out
#SBATCH -e recurrent-%j.err
module load gatk/4.0.9.0

#Merge different vcf files into one
gatk MergeVcfs  \
	-I chr1.vcf \
	-I chr2.vcf \
	-I chr3.vcf \
	-I chr4.vcf \
	-I chr5.vcf \
	-I chr5.vcf \
	-I chr5.vcf \
	-I chr6.vcf \
	-I chr7.vcf \
	-I chr8.vcf \
	-I chr10.vcf \
	-I chr11.vcf \
	-I chr12.vcf \
	-I chr13.vcf \
	-I chr14.vcf \
	-I chrM.vcf \
	-O merge.vcf

#Select SNPs from the list
 gatk SelectVariants  \
        -R Pfalciparum.genome.fasta \
        -V merge.vcf \
        -select-type SNP \
        -O raw_snps.vcf \
        -se 'SAMPLE.+AH10' #Only select samples with this naming pattern to exclude others in the vcf file

#Apply default filtering to the SNPs file (selecting for INDELs gave an empty file)
gatk VariantFiltration \
        -V raw_snps.vcf \
        --filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0" \
        --filter-name "my_snp_filter" \
        -O filtered_snps.vcf 
