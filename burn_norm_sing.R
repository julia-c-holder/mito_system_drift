### Variance of Swapped - ind replicate ###
#Midway R script 

library(dplyr)
library(readr)
#command line arguments
args <- commandArgs(trailingOnly = TRUE)

id <- args[1] #numerical id fed in as array
suffix <- args[2] #which generation is being compared, ex. "150000.csv"
repnum <- args[3]


rep_heads <- c("sex", "auto_p", "mito_p", "mito_scaled_p", "pheno")

mean_collector <- function(file){
  #initializing with first file
  #subsetting to the time period where recording is every 100 gens
  f_only <- filter(file, sex=="F")
  m_only <- filter(file, sex=="M")
  f_mean_auto <- c(mean(f_only$auto_p))
  f_mean_mito <- c(mean(f_only$mito_p))

  m_mean_auto <- mean(m_only$auto_p)
  m_mean_mito <- mean(m_only$mito_p)
  
  return(data.frame(f_mean_mito=f_mean_mito, m_mean_mito = m_mean_mito, f_mean_auto=f_mean_auto, m_mean_auto=m_mean_auto))
}

prefix <- paste("results/", repnum, "/mito_auto_",repnum,"_", sep="")

print(id)
file_name <- paste(prefix, id,"_pheno_", suffix, sep="")

raw_file <- read_csv(file_name, col_names = rep_heads)
norms <- mean_collector(raw_file)

print("done!")

## OUTPUT CSV
result_pre <- paste("results/normalizer/", repnum, "/rep", repnum, "_", sep="")
out_file <- paste(result_pre, id,"_within_pheno_", suffix, sep="")

write.table(norms, out_file, sep=",", col.names=FALSE)
