Analysis on freebayes variant calls
===================================

## Call variants with freebayes

This depends on bam files generated using the gatk calling pipeline.   
First run that pipeline (as least through to bam generation) before running `gather_data.sh`

Running freebayes takes weeks and results in a 32Gb vcf file `var.vcf` (not in this repo)

## Linkage analysis

Since our variants are unphased we have only one option for linkage analysis with vcftools.  Running this on the entire vcf file would take an eternity. So far I have just run as follows and stopped the command after enough contigs have been processed to produce sufficient data.

```bash
	vcftools --minQ 20 --vcf var.vcf --geno-r2 --minGQ 5 --max-missing 0.7 --ld-window-bp 500  --min-r2 0.001
```

