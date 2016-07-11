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

## Fst analysis

```bash
	vcftools --minQ 20 --bcf var.DPFiltered.bcf --minGQ 5 --max-missing 0.5 --weir-fst-pop cluster1.txt --chr 'flattened_line_0' --weir-fst-pop cluster2.txt --weir-fst-pop cluster3.txt
```

## Export allele table for import to adegenet package

```bash
	vcftools --minQ 20 --bcf var.DPFiltered.bcf --minGQ 5 --max-missing 0.0 --ld-window-bp 500  --min-r2 0.001 --chr 'flattened_line_0' --thin 500 --012
```

## Export a single chrom to plink format

This will produce a bunch of files starting with 'out' and 'plink'.  

Unfortunately plink is not designed to handle non standard chromosome names and certainly not data like ours from thousands of tiny contigs.  If we could use plink then we could do 

```bash
	bcftools index var.DPFiltered.bcf
	bcftools filter -r 'flattened_line_0' var.DPFiltered.bcf -O b > flattened_line_0.bcf
	plink2 --bcf flattened_line_0.bcf --recode A
```

but that doesn't work so we do this instead (note remove --chr option to use all data)

```bash
	bcftools view -h var.DPFiltered.bcf | egrep -oh 'flattened_line_\d+' | awk -F '_' 'BEGIN{OFS = "\t"}{print $0,$3}' > var.DPFiltered.chrmap
	vcftools --minQ 20 --bcf var.DPFiltered.bcf --minGQ 5 --chr 'flattened_line_0' --thin 500 --plink --chrom-map  var.DPFiltered.chrmap --remove-indv DCRM31

	vcftools --minQ 20 --bcf var.DPFiltered.bcf --minGQ 10 --max-missing 0.7 --thin 500 --plink --chrom-map  var.DPFiltered.chrmap --remove-indv DCRM31 --remove-indels

	plink --file out --recodeA
```
