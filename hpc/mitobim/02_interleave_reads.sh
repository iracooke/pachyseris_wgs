paste <(paste - - - - < DC1105_S3_R1.fastq) \
      <(paste - - - - < DC1105_S3_R2.fastq) \
    | tr '\t' '\n' \
    > DC1105_S3.fastq