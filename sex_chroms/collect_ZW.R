#### Midway R Script - Collects replicates of mito_auto_naive_XY.slim ######
library(dplyr)
library(readr)
#command line arguments
args <- commandArgs(trailingOnly = TRUE)
repnum <- args[1]
nreps <- args[2]

csv_collector <- function(files){
  #initializing with first file
  #subsetting to the time period where recording is every 100 gens
  index = read.csv(files[1], header=F, sep=",")
  cycles = index$V1
  avg_auto_f = index$V2
  avg_mito_f = index$V3
  avg_z_f = index$V5
  avg_w_f = index$V6

  avg_auto_m = index$V7
  avg_mito_m = index$V8
  avg_z_m = index$V10

  var_auto_female = index$V11
  var_mito_female = index$V12
  #var_mito_scaled_female = index$V13
  var_z_female = index$V14
  var_w_female = index$V15
  var_auto_male = index$V16
  var_mito_male  = index$V17
  #var_mito_scaled_male  = index$V17
  var_z_male   = index$V19
  ###avg_phenotype_female = index$V20
  ###avg_phenotype_male  = index$V21
  var_phenotype_female = index$V22
  var_phenotype_male  = index$V23
  genic_var_auto_female  = index$V24
  genic_var_mito_female  = index$V25
  genic_var_mito_scaled_female  = index$V26
  genic_var_x_female = index$V27

  genic_var_auto_male  = index$V28
  genic_var_mito_male = index$V29
  genic_var_mito_scaled_male = index$V30
  genic_var_x_male = index$V31
  genic_var_y_male  = index$V32
  cov_mito_female  = index$V33
  cov_mito_scaled_female  = index$V34
  cov_auto_female  = index$V35
  cov_x_female  = index$V36
  cov_mito_male  = index$V37
  cov_mito_scaled_male  = index$V38
  cov_auto_male = index$V39
  cov_x_male  = index$V40
  cov_y_male = index$V41
  cov_mito_auto_female  = index$V42
  cov_mito_auto_male = index$V43
  
  reps = rep(1, length(cycles))
  all_df <- data.frame(cycles = cycles, avg_auto_f=avg_auto_f, avg_mito_f=avg_mito_f,
                       avg_z_f=avg_z_f, avg_w_f = avg_w_f, avg_auto_m=avg_auto_m, avg_mito_m=avg_mito_m, avg_z_m=avg_z_m,
                       reps=reps, var_pheno_f = var_phenotype_female,
                       var_pheno_m=var_phenotype_male, var_mito_f = var_mito_female, var_mito_m=var_mito_male,
  var_auto_f = var_auto_female, var_auto_m = var_auto_male, var_z_f=var_z_female, var_w_f = var_w_female, var_z_m=var_z_male)
  for(i in 2:length(files)){
    index = read.csv(files[i], header=F, sep=",")
    #columns I will record
    cycles = index$V1
    avg_auto_f = index$V2
    avg_mito_f = index$V3
    avg_z_f = index$V5
    avg_w_f = index$V6

    avg_auto_m = index$V7
    avg_mito_m = index$V8
    avg_z_m = index$V10

  var_auto_female = index$V11
  var_mito_female = index$V12
  #var_mito_scaled_female = index$V13
  var_z_female = index$V14
  var_w_female = index$V15

  var_auto_male = index$V16
  var_mito_male  = index$V17
  #var_mito_scaled_male  = index$V17
  var_z_male   = index$V19
  ###avg_phenotype_female = index$V20
  ###avg_phenotype_male  = index$V21
  var_phenotype_female = index$V22
  var_phenotype_male  = index$V23

    reps = rep(i, length(cycles))
    all_df <- rbind(all_df, data.frame(cycles = cycles, avg_auto_f=avg_auto_f, avg_mito_f=avg_mito_f,
                       avg_z_f=avg_z_f, avg_w_f = avg_w_f, avg_auto_m=avg_auto_m, avg_mito_m=avg_mito_m, avg_z_m=avg_z_m,
                       reps=reps, var_pheno_f = var_phenotype_female,
                       var_pheno_m=var_phenotype_male, var_mito_f = var_mito_female, var_mito_m=var_mito_male,
  var_auto_f = var_auto_female, var_auto_m = var_auto_male, var_z_f=var_z_female, var_w_f = var_w_female, var_z_m=var_z_male))
  }
  return(all_df)
}

### Results are in folder 5
chrom_file_names <- c()

for(i in 1:nreps){
  chrom_file_names[i-1] <- paste("results/", repnum,"/mito_auto_", repnum, "_", i, "_chrom.csv", sep="")
}
print(chrom_file_names[1:5])
cov_var_collected <- csv_collector(chrom_file_names)

## OUTPUT CSV

write.table(data.frame(cov_var_collected),paste("results/summaries/unnorm_", repnum,"_collected.csv", sep=""), sep=",", col.names=TRUE)