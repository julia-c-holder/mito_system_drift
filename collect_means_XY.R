#### Midway R Script - Collects replicates of mito_auto_naive_XY.slim ######
library(dplyr)
library(readr)
#command line arguments
args <- commandArgs(trailingOnly = TRUE)
repnum <- args[1]

csv_collector <- function(files){
  #initializing with first file
  #subsetting to the time period where recording is every 100 gens
  index = read.csv(files[1], header=F, sep=",")
  cycles = index$V1
  avg_auto_f = index$V2
  avg_mito_f = index$V3
  avg_x_f = index$V5

  avg_auto_m = index$V6
  avg_mito_m = index$V7
  avg_x_m = index$V9
  avg_y_m = index$V10

  var_auto_female = index$V11
  var_mito_female = index$V12
  #var_mito_scaled_female = index$V13
  var_x_female = index$V14
  var_auto_male = index$V15
  var_mito_male  = index$V16
  #var_mito_scaled_male  = index$V17
  var_x_male   = index$V18
  var_y_male = index$V19
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
                       avg_x_f=avg_x_f, avg_auto_m=avg_auto_m, avg_mito_m=avg_mito_m, avg_x_m=avg_x_m,
                       avg_y_m=avg_y_m, reps=reps, var_pheno_f = var_phenotype_female,
                       var_pheno_m=var_phenotype_male, var_mito_f = var_mito_female, var_mito_m=var_mito_male,
  var_auto_f = var_auto_female, var_auto_m = var_auto_male, var_x_f=var_x_female, var_x_m=var_x_male,
                       var_y_m=var_y_male)
  for(i in 2:length(files)){
    index = read.csv(files[i], header=F, sep=",")
    #columns I will record
    cycles = index$V1
    avg_auto_f = index$V2
    avg_mito_f = index$V3
    avg_x_f = index$V5

    avg_auto_m = index$V6
    avg_mito_m = index$V7
    avg_x_m = index$V9
    avg_y_m = index$V10


  var_auto_female = index$V11
  var_mito_female = index$V12
  #var_mito_scaled_female = index$V13
  var_x_female = index$V14
  var_auto_male = index$V15
  var_mito_male  = index$V16
  #var_mito_scaled_male  = index$V17
  var_x_male   = index$V18
  var_y_male = index$V19
  ###avg_phenotype_female = index$V20
  ###avg_phenotype_male  = index$V21
  var_phenotype_female = index$V22
  var_phenotype_male  = index$V23

    reps = rep(i, length(cycles))
    all_df <- rbind(all_df, data.frame(cycles = cycles, avg_auto_f=avg_auto_f, avg_mito_f=avg_mito_f, 
                       avg_x_f=avg_x_f, avg_auto_m=avg_auto_m, avg_mito_m=avg_mito_m, avg_x_m=avg_x_m,
                       avg_y_m=avg_y_m, reps=reps, var_pheno_f = var_phenotype_female,
                       var_pheno_m=var_phenotype_male, var_mito_f = var_mito_female, var_mito_m=var_mito_male,
  var_auto_f = var_auto_female, var_auto_m = var_auto_male, var_x_f=var_x_female, var_x_m=var_x_male,
                       var_y_m=var_y_male))
  }
  return(all_df)
}

nreps <- 250

### Results are in folder 5
chrom_file_names <- c()

for(i in 1:nreps){
  chrom_file_names[i] <- paste("results/5/mito_auto_", repnum, "_", i, "_chrom.csv", sep="")
}

cov_var_collected <- csv_collector(chrom_file_names)

## OUTPUT CSV

write.table(data.frame(cov_var_collected),paste("results/summaries/unnorm_", repnum,"_collected.csv", sep=""), sep=",", col.names=TRUE)