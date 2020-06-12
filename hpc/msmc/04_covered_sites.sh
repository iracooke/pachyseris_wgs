module load parallel
module load samtools
module load bcftools

# Before running this script on new data you must run the 01_calculate_depths first

#cat read_depths_raw.txt | awk '{AV=0;for(i=2;i<NF;i++){ AV+=$i };print $1,AV/(NF-1)}' | sed -E s/_merged_marked.bam// > read_depths_av.txt 

make_mask(){
	c=$1
	ds=$2
	av_depth=$(grep $ds read_depths_av.txt | awk '{print $2}')
	echo "Making mask for $c and $ds at ${av_depth}"
	samtools mpileup -q 20 -Q 20 -C 50 -u -r $c -f yulin_canuPwm_001.fasta \
	"../gatk2/${ds}_merged_marked.bam" | bcftools call -c -V indels | \
	./bamCaller.py ${av_depth} ${ds}_${c}_mask.bed.gz | gzip -c > ${ds}_${c}.vcf.gz	
}

export -f make_mask

parallel -j 40 make_mask ::: \
			$(cat contig_list_1M_nocontam.txt | tr '\n' ' ') ::: \
			'DC1105' 'DC1107' 'DC1108' 'DC1109' 'DC7955' 'DC7957' 'DC7962' 'DC7967' 'DC7968' 'DC7969'
