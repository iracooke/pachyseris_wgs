# Whole Genome Resequencing for *Pachyseris speciosa* on the GBR

Shell scripts and R code to accompany the paper

> Cryptic diversity masks ecologically divergent coral species on tropical reefs


### Raw Data Processing

- [Host mitochondrial genome assembly](hpc/mitobim/README.md)
- [Host mitochondrial haplotype network](hpc/mito_mapping/README.md)
- [Symbiont mitochondrial haplotype network](hpc/symbiodinium/README.md)
- [Sequencing coverage summary](04_sequencing_summary.md)

### Downstream Analysis

- [Population Structure](02_population_structure.md)
- [Phylogenetic inference from Mitochondrial genomes](01_mitogenomes.md)
- [Demographic History with MSMC](03_msmc.md)


All of the sections above are provided as processed markdown files.  Clicking the link should display a web readable page with text, a few select commands and plots and tables. The code used to generate these pages is provided in the corresponding `.Rmd` file. If you would like to run the code in these files yourself you will need to;

1. Checkout this repository 
```bash
git clone https://github.com/iracooke/pachysers_wgs.git
```
2. Download additional data not hosted on github due to size constraints
```bash
cd pachyseris_wgs
wget 'https://cloudstor.aarnet.edu.au/plus/s/dARw9IaI8WBwIvR/download' -O data.tgz
tar -zxvf data.tgz 
```
3. Open the project file in RStudio and open the desired file (eg 01_mitogenomes.Rmd).  After installing any required R packages the code should run and produce plots and tables identical to those shown in the web links above.


