
raw_depth(){
	bam=$1
	bases=$(samtools stats ${bam} | grep 'bases mapped:' | sed -E 's/.*\s+([0-9]+).*/\1/')
	len=19007
	echo "$bases $len"
}

for bf in *_mitoreads.bam; do
	printf "%s\t" $bf;
	raw_depth $bf | awk '{printf("%s\t", $1/$2)}';
	printf "\n"
done > read_depths_raw.txt

