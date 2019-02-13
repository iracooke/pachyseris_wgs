#!/bin/bash

module load picard
module load bwa
module load samtools
module load java

GENOME=yulin_canuPwm_001.fasta

set -e

# First index the genome
bwa index -a bwtsw $GENOME

# Make the dict
java -jar $PICARD_HOME/picard.jar CreateSequenceDictionary REFERENCE=$GENOME OUTPUT=${GENOME%.fasta}.dict
