library(dplyr)
library(readr)
##command line arguments
args <- commandArgs(trailingOnly = TRUE)
repnum <- args[1] #refers to the folder which the results are in
nreps <- args[2] #refers to the number of replicates in the aforementioned folder

ZW_header <- c("cycle", "avg_auto_f","avg_mito_f", "avg_mito_scaled_f","avg_z_f",
                   "avg_w_f",
                   "avg_auto_m", "avg_mito_m", "avg_mito_scaled_m","avg_z_m",
                   "var_auto_f","var_mito_f", "var_mito_scaled_f","var_z_f","var_w_f",
                   "var_auto_m","var_mito_m","var_mito_scaled_m","var_z_m",
                   "avg_pheno_f","avg_pheno_m", "var_pheno_f",
                   "var_pheno_m","genic_var_auto_f", "genic_var_mito_f",
                   "genic_var_mito_s_f", "genic_var_z_f","genic_var_w_f", "genic_var_auto_m","genic_var_mito_m",
                   "genic_var_mito_s_m","genic_var_z_m",
                   "cov_mito_f","cov_mito_s_f","cov_auto_f","cov_z_f","cov_w_f",
                   "cov_mito_m","cov_mito_s_m","cov_auto_m","cov_z_m",
	"cov_mito_auto_f","cov_mito_auto_m")

csv_collector <- function(files, head_names){
  #initializing
  first_file <- read.csv(files[1], col.names=head_names)
  files_collected <- first_file

  for(i in 2:nreps){
    new_file <- read.csv(files[i], col.names=head_names)
    files_collected <- rbind(files_collected, new_file)
  }

  return(files_collected)
}

file_log <- c()
for (i in 1:nreps){
  file_log[i] <- paste("results/", repnum,"/mito_auto_", repnum, "_", i, "_chrom.csv", sep="")
}

big_file <- csv_collector(file_log, ZW_header)

write.csv(big_file,paste("results/full_chrom/unnorm_", repnum,"_collected.csv", sep=""), sep=",")

