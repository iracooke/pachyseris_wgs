module load parallel

generate_bootstraps(){
	ds=$1
	../../../atenuis_wgs/hpc/sw/msmc-tools/multihetsep_bootstrap.py -n 100 -s 500000 \
	--chunks_per_chromosome 40 --nr_chromosomes 15 ${ds}_bootstrap *_${ds}.multihetsep.txt	
}

export -f generate_bootstraps

parallel -j 10 generate_bootstraps ::: 'DC1105' 'DC1107' 'DC1108' 'DC1109' 'DC7955' 'DC7957' 'DC7962' 'DC7967' 'DC7968' 'DC7969'

