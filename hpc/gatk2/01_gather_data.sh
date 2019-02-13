for f in $(find /rdsi/Q0214/Data/Sequencing/Corals/PachyserisWGS/ -name '*.fastq.gz'); do
	flowcell=`gunzip -c $f | head -n 1 | awk -F ':' '{print $3}'`
	name=$(basename $f)

	ln -s $f ${flowcell}_${name}
done