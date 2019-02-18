module load seqtk
module load samtools
module load parallel/20170522 
module load bioawk/1.0

call_cons(){
	mitogenome=PSPEMitoCircularized.fasta

	bamfile=$1

	sample=${bamfile%_mitoreads.bam}

	samtools sort ${bamfile} | \
	samtools mpileup -uf ${mitogenome} - | \
	bcftools call -c --ploidy 1  - | \
	vcfutils.pl vcf2fq | \
	seqtk seq -A | \
	bioawk -c fastx -v samp=$sample '{printf(">%s\n%s\n",samp,$seq)}'> ${sample}_consensus.fasta
}

export -f call_cons

parallel -j 40 call_cons ::: $(ls *_mitoreads.bam | tr '\n' ' ')

cat *_consensus.fasta > AllSamplesPSPEMitoConsensus.fasta