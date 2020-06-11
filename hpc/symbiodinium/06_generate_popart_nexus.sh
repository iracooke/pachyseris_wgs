cat AllSamplesPSPESymbC1MitoConsensusHighCov.nex \
<(bash 05_generate_traits.sh | sed s/-/_/g) \
> AllSamplesPSPESymbC1MitoConsensusHighCov_PopArt.nex
