module load abyss/2.0.2 
module load openmpi

# All assembly was based on sequencing from a single individual coded as DC1105
# All in all there were 3 libraries for this individual including;
# S5: 100bp PE 10 million reads
# S3: 100bp PE 83 million reads
# TAGGCATG-TATCCTCT: 150bp PE 6 million reads
# Total sequencing volume of 20.4Gb

zcat *'DC1105_S5'*R1* > DC1105_S5_R1.fastq
zcat *'DC1105_S5'*R2* > DC1105_S5_R2.fastq

zcat *'DC1105_S3'*R1* > DC1105_S3_R1.fastq
zcat *'DC1105_S3'*R2* > DC1105_S3_R2.fastq

zcat *'DC1105_TAGGCATG-TATCCTCT'*R2* > DC1105_TAGGCATG-TATCCTCT_R2.fastq
zcat *'DC1105_TAGGCATG-TATCCTCT'*R1* > DC1105_TAGGCATG-TATCCTCT_R1.fastq

abyss-pe -j 24 k=64 name=pspe lib='S5 S3 TAGGCATG' \
	S5='DC1105_S5_R1.fastq DC1105_S5_R2.fastq' \
	S3='DC1105_S3_R1.fastq DC1105_S3_R2.fastq' \
	TAGGCATG='DC1105_TAGGCATG-TATCCTCT_R1.fastq DC1105_TAGGCATG-TATCCTCT_R2.fastq'
