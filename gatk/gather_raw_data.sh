file_paths=`find ../raw_data/dna.anu.edu.au/pspe/resequencing_001/data/Project_SN877_0331_DHayward_RSB_Pspeciosa_gDNA/ -name *.fastq.gz`

for f in $file_paths; do 
	link_name=`basename $f`	
	ln -s $f $link_name
done

ln -s ../raw_data/dna.anu.edu.au/pspe/Pspe_001.fasta.gz Pspe_001.fasta.gz


