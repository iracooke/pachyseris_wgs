# The initial abyss assembly of DC1105 was highly fragmented (N50:1kb)
# but contained 12 relatively well assembled mitochondrial genome
# fragments

# These mitogenome fragments were identified by mapping (using minimap) to
# the Acropora digitifera mitochondrial genome and extracted as follows;

samtools faidx pspe-contigs.fa \
	$(minimap adi_mito_genome.fasta pspe-contigs.fa | cut -f 1 | sort -u | tr '\n' ' ') \
	> mito_contigs.fa

