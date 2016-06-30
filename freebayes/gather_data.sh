
function import_data {
	sample=$1
	samplename=$2
	echo "Merging ${sample#../gatk/}.bam"
	samtools merge --threads 4 ${samplename}.bam ${sample}*mark_duplicates.sort.bam;
	echo "Sorting"
	samtools sort --reference Pspe_001_10000.fasta ${samplename}.bam -o ${samplename}.sort.bam
	echo "Fixing ReadGroups"
	bamaddrg -b ${samplename}.sort.bam -c -r ${samplename}rg -s $samplename > ${samplename}.rgfix.bam
	echo "Indexing"
	samtools index ${samplename}.rgfix.bam
}


for f in `ls ../gatk/*L001*mark_duplicates.sort.bam`; do 
	sample=${f%_[ATGC]*_L00*}; 
	samplename=${sample#../gatk/}
	import_data $sample $samplename
done

ln -s ../gatk/Pspe_001_10000.fasta Pspe_001_10000.fasta
