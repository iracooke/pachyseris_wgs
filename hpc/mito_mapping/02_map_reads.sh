module load bwa
module load samtools
module load parallel/20170522 

map_reads(){

	mitogenome=PSPEMitoCircularized.fasta

	bamfile=$1

	if [ ! -f ${sample}_mitoreads.bam ];then

		sample=${bamfile%_merged_marked_sorted.bam}

		samtools fastq -F 1024 ${bamfile} | bwa mem -t 16 ${mitogenome} - | samtools view -b -F 4 - > ${sample}_mitoreads.bam

	fi

}

export -f map_reads

parallel -j 20 map_reads ::: $(ls *_merged_marked_sorted.bam | tr '\n' ' ')
