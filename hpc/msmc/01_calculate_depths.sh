
# for bf in ../gatk2/*_merged_marked.bam; do
# 	printf "%s\t" $(basename $bf);
# 	for r in $(cat yulin_canuPwm_001.1MB.txt | cut -f 1 | tr '\n' ' ');do 
# 		samtools depth -r $r $bf | awk '{sum += $3} END {printf("%s\t" , sum/NR)}';
# 	done
# 	printf "\n"
# done > read_depths.txt


raw_depth(){
	bam=$1
	chrom=$2
	bases=$(samtools stats ${bam} ${chrom} | grep 'bases mapped:' | sed -E 's/.*\s+([0-9]+).*/\1/')
	len=$(grep ${chrom} yulin_canuPwm_001.txt | cut -f 2)
	echo "$bases $len"
}

for bf in ../gatk2/*_merged_marked.bam; do
	printf "%s\t" $(basename $bf);
	for r in $(cat yulin_canuPwm_001.txt | cut -f 1 | tr '\n' ' ');do
		raw_depth $bf $r | awk '{printf("%s\t", $1/$2)}';
	done
	printf "\n"
done > read_depths_raw.txt
