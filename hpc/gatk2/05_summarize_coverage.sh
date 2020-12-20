# for f in DC*_marked.bam;do 
# 	echo "$f $(samtools depth -r Sc0000001 $f | awk '{sum += $3} END {print sum / NR}')";
# done


for f in DC*_marked.bam;do 
	echo "$f $(samtools depth $f | awk '{sum += $3} END {print sum / NR}')";
done
