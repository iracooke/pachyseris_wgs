module load angsd

# This produces the all important genotype likelihood file, all.beagle.gz 
# used by PCAngst and NGSAdmix
#
# It also produces a covariance matrix and IBS distance matrix 
# for looking at population structure the old way (ngsTools)
#

angsd -bam all.bamlist -minMapQ 30 -minQ 20 -GL 2 -fai yulin_canuPwm_001.fasta.fai -out all -P 30 \
-doGlf 2 -doMajorMinor 1 -doMaf 1 -SNP_pval 2e-6 -minInd 10  -doIBS 1 \
-doCounts 1 -doCov 1 -makeMatrix 1 -minMaf 0.05 


