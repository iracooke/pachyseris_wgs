module load samtools
module load parallel/20170522 

extract_reads(){
	bamfile=$1

	sample=${bamfile%_merged_marked.bam}

	if [ ! -f ${sample}_nonhost_sorted.bam ];then
		samtools view -f 12 ${bamfile} | samtools sort -n -@ 8 > ${sample}_nonhost_sorted.bam
	fi

}

export -f extract_reads

parallel -j 40 extract_reads ::: $(ls *_merged_marked.bam | tr '\n' ' ')
