#!/usr/bin/bash

# . /fast/sw/miniconda3/etc/profile.d/conda.sh

# conda activate pcangst

python ./pcangsd/pcangsd.py \
	-beagle all.beagle.gz -threads 40 \
	-e 2\
	-admix -admix_save -admix_auto 10000 -o pcangst3


