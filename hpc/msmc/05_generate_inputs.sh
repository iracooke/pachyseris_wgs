module load parallel
module load samtools

generate_multihetsep(){
	c=$1

    # One at a time
    for ds in 'DC1105' 'DC1107' 'DC1108' 'DC1109' 'DC7955' 'DC7957' 'DC7962' 'DC7967' 'DC7968' 'DC7969';do
    		echo "$ds $c"
			${HOME}/Projects/atenuis_wgs/hpc/sw/msmc-tools/generate_multihetsep.py  \
						--mask=${ds}_${c}_mask.bed.gz \
                        --mask=chr${c}.mask.bed \
                        ${ds}_${c}.vcf.gz | \
                        awk '{printf("%s\t%s\t%s\t%s,%s%s\n",$1,$2,$3,$4, substr($4,2,1), substr($4,1,1))}' \
                        > ${c}_${ds}.multihetsep.txt    	
    done

}

export -f generate_multihetsep

parallel -j 40 generate_multihetsep ::: $(cat contig_list_1M_nocontam.txt | tr '\n' ' ')

