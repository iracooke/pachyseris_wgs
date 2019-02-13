
read_sample_admix_data <- function(){
  samples <- read_tsv("hpc/NGSAdmix/all.bamlist",col_names = "bam") %>% 
    pull(bam) %>% 
    stringr::str_extract(pattern = "DC([^\\_]+)")
  
  sample_data <- read_tsv("raw_data/samples.txt") %>% 
    filter(SampleCode!="") %>% 
    select(Sample=SampleCode,Pop=Cluster,Location) %>% 
    add_row(Pop="Cluster1",Location="Unknown",Sample="DCRM31")
  
  sample_data <- sample_data[match(samples,sample_data$Sample),]
  sample_data
}