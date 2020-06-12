
run_replicate(){
	bsn=$1

	for ds in 'DC1105' 'DC1107' 'DC1108' 'DC1109' 'DC7955' 'DC7957' 'DC7962' 'DC7967' 'DC7968' 'DC7969';do

		msmc2 -t 40 -I 0,1 -o ${bsn}_${ds}_within_msmc  ${ds}_bootstrap_${bsn}/*multihetsep*.txt

	done

}

module load parallel
module load msmc

export -f run_replicate

parallel -j 20 run_replicate ::: $(seq -s ' ' 100)

for ds in 'DC1105' 'DC1107' 'DC1108' 'DC1109' 'DC7955' 'DC7957' 'DC7962' 'DC7967' 'DC7968' 'DC7969';do
	mkdir -p ${ds}_within_msmc_bs
	mv *_${ds}_within_msmc.* ${ds}_within_msmc_bs
done