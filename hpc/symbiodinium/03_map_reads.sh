module load bwa
module load samtools
module load parallel

map_reads(){

	mitogenome=$1

	bamfile=$2

	sample=${bamfile%_nonhost_sorted.bam}
	clade=${mitogenome%.MITO_seqs.fa}

	if [ ! -f ${sample}_${clade}.bam ];then
		samtools view -f 12 ${bamfile} | \
		samtools sort -n -@ 8 | \
		samtools fastq -F 1024 - | \
		bwa mem -t 16 ${mitogenome} - | \
		samtools view -b -F 4 - > ${sample}_${clade}.bam
	fi

}

export -f map_reads

parallel -j 40 map_reads SymbC1.MITO_seqs.fa ::: $(ls *nonhost_sorted.bam | tr '\n' ' ')

parallel -j 40 map_reads SymbF.MITO_seqs.fa ::: $(ls *nonhost_sorted.bam | tr '\n' ' ')
