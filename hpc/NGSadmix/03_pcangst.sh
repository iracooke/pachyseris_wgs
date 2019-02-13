#!/usr/bin/bash

. /fast/sw/miniconda3/etc/profile.d/conda.sh

conda activate pcangst

python /usr/local/sci-irc/sw/pcangsd/pcangsd.py -beagle all.beagle.gz -threads 20 -o pcangst

