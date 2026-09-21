# Title     : collect_chrom
# Objective : Collect a particular generation from the chrom files for a replicate, written to be used with snakemake
# Created by: juliaholder
# Created on: 9/17/26

library(stringr)
library(readr)
library(dplyr)
## takes parameters from the snakemake object
#input and output specified in snakefile
#gen and rep and sample specified in the config
input_file <- snakemake@input[[1]]
gen <- snakemake@config[["gen"]]
rep <- snakemake@config[["rep"]]

chrom_file_selection <- function(file, gen){
  full_file <- read.csv(file, header=F)
  chosen_gen <- filter(full_file, V1 == gen)
  return(chosen_gen)
}

subset_file <- chrom_file_selection(input_file, gen)
write.csv(subset_file, snakemake@output[[1]])
