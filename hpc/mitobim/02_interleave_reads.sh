# Since coverage is not an issue we only used one of the three libraries
# In this case the S3 100bp PE library with approx 16G of data.

paste <(paste - - - - < DC1105_S3_R1.fastq) \
      <(paste - - - - < DC1105_S3_R2.fastq) \
    | tr '\t' '\n' \
    > DC1105_S3.fastq