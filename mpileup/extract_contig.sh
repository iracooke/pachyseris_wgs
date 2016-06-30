#!/bin/bash

contig_name=$1
shift

samflags='-b -F 256'



mkdir -p ${contig_name}

for bf in $*;do
	samtools view $samflags $bf ${contig_name} > ${contig_name}/$bf
done

cd ${contig_name};
ls *.bam > ${contig_name}.bam.list



