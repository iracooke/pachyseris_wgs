// Bpipe script for running a complete GATK snp and genotype calling pipeline on pachyseris WGS data
// 
// Assumes that the following modules are loaded
//
// bwa, python (as python3), java (1.8), picard
//
// All input files should be present in this directory and the script should then be run as
//
// bpipe -n 4 gatk.groovy *.fastq.gz Pspe_001.fasta.gz
//

fastq2ubam = {
	branch.match = input1 =~ /(DC.*)_([AGCT]*-[AGCT]*)_(L00[12])_(R[12])/

	branch.sample = match[0][1]
	branch.barcode = match[0][2]
	branch.lane = match[0][3]

	exec """
	java -Xmx4G -jar $PICARD_HOME/picard.jar FastqToSam
    FASTQ=$input1
    FASTQ2=$input2
    OUTPUT=$output.bam
    READ_GROUP_NAME=$lane
    SAMPLE_NAME=$sample
    LIBRARY_NAME=$sample
    PLATFORM_UNIT=$barcode.$lane
    PLATFORM=illumina
    """

}


mark_adapters = {
    exec """
    java -Xmx4G -jar $PICARD_HOME/picard.jar MarkIlluminaAdapters
    I=$input.bam
    M=${input}_txt
    O=$output.bam
    """
}

map_reads = {

    branch.match = input.bam =~ /(.*).fastq/
    branch.ubam = "$input.fastq.fastq2ubam.bam"


    exec """java -Xmx4G -jar $PICARD_HOME/picard.jar SamToFastq
    I=$input.bam
    FASTQ=/dev/stdout
    CLIPPING_ATTRIBUTE=XT CLIPPING_ACTION=2 INTERLEAVE=true NON_PF=true
    |  
    bwa mem -M -t 16 -p $input.fasta /dev/stdin 
    | 
    java -Xmx8G -jar $PICARD_HOME/picard.jar MergeBamAlignment
    ALIGNED_BAM=/dev/stdin
    UNMAPPED_BAM=$ubam 
    OUTPUT=$output.bam 
    R=$input.fasta CREATE_INDEX=true ADD_MATE_CIGAR=true 
    CLIP_ADAPTERS=false CLIP_OVERLAPPING_READS=true 
    INCLUDE_SECONDARY_ALIGNMENTS=true MAX_INSERTIONS_OR_DELETIONS=-1 
    PRIMARY_ALIGNMENT_STRATEGY=MostDistant ATTRIBUTES_TO_RETAIN=XS 
    """
}

mark_duplicates = {
    exec """
    java -Xmx32G -jar $PICARD_HOME/picard.jar MarkDuplicates 
    INPUT=$input.bam
    OUTPUT=$output.bam
    METRICS_FILE=${input}_markduplicates_txt
    CREATE_INDEX=true
    TMP_DIR=/tmp/sci-irc
    MAX_RECORDS_IN_RAM=5000000
    MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=800
    """
}

sort = {
    exec """
    samtools sort --threads 2 $input.bam > $output.bam
    """
}

call_variants = {
    exec """
    java -Xmx5G -jar $GATK_HOME/GenomeAnalysisTK.jar 
    -T HaplotypeCaller 
    -I $input.bam
    -R $input.fasta 
    --genotyping_mode DISCOVERY
    -stand_emit_conf 10
    -stand_call_conf 30
    -ERC GVCF
    -variant_index_type LINEAR -variant_index_parameter 128000
    -o $output.gvcf 
    """
}

list_gvcfs = {
    produce("all_gvcfs.list"){
        exec """
        ls *.gvcf > $output
        """
    }
}

joint_genotype = {
    produce("all.vcf"){
        exec """
        java -Xmx240G -jar $GATK_HOME/GenomeAnalysisTK.jar 
        -T GenotypeGVCFs 
        -R $input.fasta --variant $input.list 
        -nt 32
        -o $output.vcf -log $output.log
        """
    }
}

bcfcall = {
    produce("var.raw.vcf"){
        exec """bcftools call -m --output-type z --threads 2 $input.vcf > $output.vcf"""
    }
}

bcfstats = {
    produce("var.raw.stats.txt"){
        exec """bcftools stats $input.vcf > $output.txt"""
    }
}

mpileup = {
    produce("mpileup.vcf"){
        exec """samtools mpileup -vf $input.fasta $inputs.bam -o $output"""
    }
}

unified_genotype = {
    produce("unified_all.vcf"){
        exec """
        java -jar $GATK_HOME/GenomeAnalysisTK.jar  -T UnifiedGenotyper -R $input.fasta 
       -I $inputs.bam
       -o $output.vcf 
       -stand_call_conf 50.0
       -stand_emit_conf 10.0 
        """
    }
}

unzip_genome = {
    transform('.fasta.gz') to ('.fasta') {
        exec "gunzip -c $input > $output"
    }
}

trim_genome = {
    transform('.fasta') to ('_10000.fasta') {
        exec "python ../bin/filter_fasta.py -l 10000 $input > $output"
    }
}

index_genome = {
    transform('.fasta') to ('.fasta.bwt') {
        exec "bwa index -a bwtsw $input"
    }
    forward input
}

make_genome_reference_dict = {
    transform('.fasta') to ('.dict'){
        exec """java -jar $PICARD_HOME/picard.jar CreateSequenceDictionary 
        REFERENCE=$input 
        OUTPUT=$output"""        
    }
    forward input
}


// GVCF based workflow
Bpipe.run {
 unzip_genome + trim_genome + index_genome + make_genome_reference_dict +
   "%R*_" * [ fastq2ubam + mark_adapters + map_reads + mark_duplicates + call_variants] + list_gvcfs + joint_genotype
}


// Old UnifiedGenotyper workflow
// Dont do this
//Bpipe.run {
//    unzip_genome + trim_genome + index_genome + make_genome_reference_dict + samtools_index_genome +
//    "%R*_" * [ fastq2ubam + mark_adapters + map_reads + mark_duplicates ] + unified_genotype
//}

