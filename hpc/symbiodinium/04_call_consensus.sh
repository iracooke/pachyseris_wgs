module load seqtk
module load samtools
module load parallel
module load bioawk

call_cons(){
	mitogenome=SymbC1.MITO_seqs.fa

	bamfile=$1

	sample=${bamfile%_SymbC1.bam}

	samtools sort ${bamfile} | \
	samtools mpileup -uf ${mitogenome} - | \
	bcftools call -c --ploidy 1  - | \
	vcfutils.pl vcf2fq -d 10 -Q 20 | \
	seqtk seq -A | \
	bioawk -c fastx -v samp=$sample '{printf(">%s\n%s\n",samp,$seq)}'> ${sample}_consensus.fasta
}

export -f call_cons

parallel -j 20 call_cons ::: $(ls *SymbC1.bam | tr '\n' ' ')

cat *_consensus.fasta > AllSamplesPSPESymbC1MitoConsensus.fasta
