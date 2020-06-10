module load MITObim/1.9

MITObim.pl -end 10 \
	-quick mito_contigs.fa \
	-sample 'DC1105' -readpool DC1105_S3.fastq \
	-ref pspemito --pair

