module load seqbility
module load parallel
module load bwa

genome=yulin_canuPwm_001.fasta

splitfa ${genome} 100 | split -l 20000000

bwa index yulin_canuPwm_001.fasta

do_bwa(){
	in=$1
	bwa aln -t 8 -R 1000000 -O 3 -E 3 yulin_canuPwm_001.fasta ${in} > ${in}.sai 	
}

do_sampe(){
	input=${1%.sai}
	bwa samse yulin_canuPwm_001.fasta ${input}.sai ${input} | gzip -c > ${input}.sam.gz
}

export -f do_bwa do_sampe


parallel -j 6 do_bwa ::: $(ls x* | tr '\n' ' ')

parallel -j 40 do_sampe ::: $(ls *.sai | tr '\n' ' ')

gzip -dc x??.sam.gz | gen_raw_mask.pl > rawMask_100.fa

gen_mask -l 100 -r 0.5 rawMask_100.fa > mask_100_50.fa
