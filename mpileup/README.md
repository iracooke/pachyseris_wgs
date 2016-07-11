Analysis of samtools mpileup SNP calls
======================================

## Call Variants

Create a symlink to the Pspe genome.

```bash
	ln -s ../raw_data/dna.anu.edu.au/pspe/Pspe_001.fasta.gz Pspe_001.fasta.gz 
```

```bash
	bpipe -n 4 mpileup.groovy *.fastq.gz Pspe_001.fasta.gz
```


## Visualise reads

Generate small bam files with reads mapped to a single contig

./extract_contig.sh 'flattened_line_1884'


## Extract various stats from variants


Extract SNPs for a single contig

```bash
	bcftools filter -r 'flattened_line_1884' var.raw.bcf > flattened_line_1884.vcf
```

Extract section of stats file

```bash
	../bin/split_vcf_stats.py ../gatk/var.raw.stats.txt DP > var.raw.stats.dp.txt
```

Filter based on depth

```bash
	bcftools filter -e 'DP>100 || DP<20' var.raw.bcf -O b > var.DPFiltered.bcf
```

Get a sample of Depths for the first 10k snps

```bash
	cat var.raw.vcf | grep 'DP=' | awk '{print $8}' | awk -F '=' '{print $2}' | awk -F ';' '{print $1}' | head -n 100000 > ../raw_data/var.raw.dp_first10k.txt
```
