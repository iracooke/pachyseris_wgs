cat AllSamplesPSPEMitoConsensus_Trim.nex \
<(bash 04_generate_traits.sh | sed s/-/_/g) \
> AllSamplesPSPEMitoConsensus_PopArt.nex
