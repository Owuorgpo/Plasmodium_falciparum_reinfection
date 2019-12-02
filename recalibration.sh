#!/usr/bin/env bash
#SBATCH -J SeekDeep
#SBATCH --time=12:00:00
#SBATCH --nodes=2
#SBATCH --tasks-per-node=8
#SBATCH -o SeekDeep-%j.out
#SBATCH -e SeekDeep-%j.err
module load gatk/4.0.9.0
module load R/3.6.0
gatk VariantRecalibrator \
	-R Pfalciparum.genome.fasta \
	-input merge.vcf \
	-resource 3D7,known=false,training=true,truth=true,prior=15.0:3d7_hb3.combined.final.vcf \
	-resource 7g8,known=false,training=true,truth= false,prior=12.0:7g8_gb4.combined.final.vcf \
	-resource hb3,known=false,training=true,truth=false,prior=10.0:hb3_dd2.combined.final.vcf \
	-an DP -an QD -an FS -an MQRankSum -an ReadPosRankSum \
	-mode SNP \
	--tranches-file recalibrate_SNP.tranches \
	--rscript-file recalibrate_SNP_plots.R
