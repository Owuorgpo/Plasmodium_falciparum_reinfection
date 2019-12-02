#!/usr/bin/env bash
#SBATCH -J SeekDeep
#SBATCH --time=12:00:00
#SBATCH --nodes=2
#SBATCH --tasks-per-node=8
#SBATCH -o SeekDeep-%j.out
#SBATCH -e SeekDeep-%j.err
module load gatk/4.0.9.0
module load R/3.6.0
gatk VariantFiltration \
	-V raw_snps.vcf \
    	--filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0" \
    	--filter-name "my_snp_filter" \
    	-O filtered_snps.vcf 
