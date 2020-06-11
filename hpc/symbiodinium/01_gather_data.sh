for f in ../gatk2/*merged_marked.bam;do ln -s $f .;done
for f in ../gatk2/*merged_marked.bai;do ln -s $f .;done