Mitochondrial Haplotypes
================

The mitochondrial haplotype network showed that every sample had a
distinct haplotype, resulting in a highly reticulated network. This was
visualised using PopArt (see below).

![hostmito](figures/mito_network.png)

As a complement to examining mitochondrial haplotype networks we also
performed maximum likelihood tree inference on mitochondrial haplotypes
using iq-tree. This is especially sensible for the host case since there
were no shared haplotypes.

For the host we find that the red lineages almost form a monophyletic
group (with the exception of DC7957) whereas the green and blue lineages
are intermingled within several clades.

![](01_mitogenomes_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

For the symbionts the haplotype network visualised with PopArt. In this
case the network is not based on the full mitogenome but instead just
focussed on an 8kb region with good coverage across the majority of
samples.

![sym\_popart](figures/AllSamplesPSPESymbC1MitoConsensusHighCov_PopArt.png)

We find that one sample, `DC8229` has a haplotype very different from
the rest, perhaps indicating that its dominant symbiont is not
Cladocopium. We removed this sample when visualising the haplotypes as a
tree in order to focus on relationships between the other samples. The
tree reflects the fact that many of the red lineage samples had the same
haplotype (see TCS network of haplotypes) and therefore have very short
branch lengths in the tree. The green and blue lineages are also
strongly intermingled.

![](01_mitogenomes_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

#### Structuring of symbiont mitotypes by lineage

Although we have very few samples we can test (albeit with low power) to
see if there is an association between lineage and the genetic
differentiation between symbiont mitochondrial genomes. For this we use
\[@Excoffier1992-pe\] implemented in
[pegas](https://cran.r-project.org/web/packages/pegas/index.html)
\[@Paradis2010-ds\] version 0.12.

![](01_mitogenomes_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

``` r
mhaps.gid <- multidna2genind(mhaps, mlst = TRUE)

sample_data_mhaps <- sample_data %>% 
  filter(Sample %in% mhaps@labels) %>% 
  arrange(factor(Sample, levels=mhaps@labels),Sample)

strata(mhaps.gid) <- sample_data_mhaps %>% select(Pop)
```

AMOVA is then performed to test for differentiation according to
cluster. This is not significant (p~0.5) despite some superficial
indications that it might be based on the haplotype network. We can’t
rule out that some differentiation exists since our non-significant
result in this case most likely reflects low power due to the small
number of samples.

``` r
mhaps_dist <- dist.multidna(mhaps, pool = TRUE)
pegas::amova(mhaps_dist ~ Pop, data = strata(mhaps.gid), nperm = 100)
```

    ## 
    ##  Analysis of Molecular Variance
    ## 
    ## Call: pegas::amova(formula = mhaps_dist ~ Pop, data = strata(mhaps.gid), 
    ##     nperm = 100)
    ## 
    ##                SSD          MSD df
    ## Pop   5.379981e-07 2.689991e-07  2
    ## Error 4.133305e-06 3.179465e-07 13
    ## Total 4.671303e-06 3.114202e-07 15
    ## 
    ## Variance components:
    ##            sigma2 P.value
    ## Pop   -9.7895e-09  0.5545
    ## Error  3.1795e-07        
    ## 
    ## Phi-statistics:
    ## Pop.in.GLOBAL 
    ##   -0.03176786 
    ## 
    ## Variance coefficients:
    ## a 
    ## 5
