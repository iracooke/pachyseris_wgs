# Host mitochondrial mapping and genotyping

We used the reference mitochondrial genome for P. speciosa assembled from sample DC1105 and raw reads for each sample to obtain individual haplotype mitochondrial sequences for each sample. 

This was performed as follows;

- Raw reads for each sample were first processed according to the GATK3 best practices workflow.  This produced a single bam file for each sample with adapters and likely PCR duplicate reads marked. 
- All host reads were them mapped to the P. speciosa mitochondrial genome reference using bwa mem to identify reads of mito origin. See the script [02_map_reads.sh](02_map_reads.sh) for the exact commands used. As a result of this process sufficient reads were identified to result in at least 1000x coverage of each host mitogenome.
- Mitochondrial reads were then used to call variants against the reference sequence using samtools mpileup (version 1.7), followed by bcftools (version 1.9) to call a consensus sequence for the sample. (See script [03_call_consensus.sh](03_call_consensus.sh))
- Since consensus sequences were all the same length no alignment was necessary and they were simply concatenated to produce an alignment. 
- This set of aligned mitochondrial sequences was loaded into geneious and trimmed to remove regions with bases. The resulting trimmed alignment was 18539bp in length.
- The trimmed alignment was used as a set of haplotypes for network visualisation with [PopArt](http://popart.otago.ac.nz/index.shtml) using a TCS network. The resulting haplotype network is shown below
![host_mito_network](../../figures/mito_network.png)
- [iqtree](http://www.iqtree.org/) version 1.4.4 was then used to perform model selection and build a maximum likelihood tree based on the aligned mitochondrial sequences.
