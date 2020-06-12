module load msmc2/17May2016
#msmc2 -t 40 -o historical_ne Sc000000?*multihetsep.txt


for ds in 'DC1105' 'DC1107' 'DC1108' 'DC1109' 'DC7955' 'DC7957' 'DC7962' 'DC7967' 'DC7968' 'DC7969';do

	msmc2 -t 40 -I 0,1 -o ${ds}_within_msmc Sc*_${ds}.multihetsep.txt

done