Analysis of GATK SNP calls
==========================

## Call Variants

The workflow presented here is based on careful reading of the [gatk best practices guidelines and forums](https://www.broadinstitute.org/gatk/guide/bp_step.php?p=1)

Create a symlink to the Pspe genome.

```bash
	ln -s ../raw_data/dna.anu.edu.au/pspe/Pspe_001.fasta.gz Pspe_001.fasta.gz 
```

Run the pipeline.  So far I have never run the last step in this to completion as it stalls and provides no progress output.  I expect it will work when we have a more contiguous genome as part of the issue is probably the very large number of small contigs.

```bash
	bpipe -n 4 gatk.groovy *.fastq.gz Pspe_001.fasta.gz
```

