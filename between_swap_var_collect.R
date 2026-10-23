# Title     : TODO
# Objective : TODO
# Created by: juliaholder
# Created on: 10/23/26

library(stringr)
library(readr)
library(dplyr)

args <- commandArgs(trailingOnly = TRUE)
rep <- args[1]
prefix <- paste("results/swapped/variances/rep", rep, "_", sep="")
suffix <- args[2]

var_file_names <- c()
for(i in 1:10){
  for (j in 1:10){
    for (k in 1:(k-1)){
      new_name <- paste(prefix, "pop_", i, "_", j, "a_", k, "m_pheno", suffix, sep="")
      var_files_names <- c(var_file_names, new_name)
    }
  }
}

#### Collects swapped mean and variance ###
#script for cluster

var_collector <- function(files){
  #initializing with first file
  data_mat <- matrix(nrow=nreps, ncol=7)
  #subsetting to the time period where recording is every 100 gens
  index = read.csv(files[1], header=F, sep=",")
  pop_lab = str_split(files[1],pattern="_")[[1]][3]

  f_avg = index$V2[1]
  m_avg = index$V3[1]
  f_var = index$V4[1]
  m_var = index$V5[1]
  f_fit = index$V6[1]
  m_fit = index$V7[1]
  #print(c(f_avg, m_avg, f_var, m_var))
  data_mat[1,] <- c(f_avg, m_avg, f_var, m_var, f_fit, m_fit, pop_lab)

  for(i in 2:length(files)){
    index = read.csv(files[i], header=F, sep=",")
    #columns I will record
    f_avg = index$V2[1]
    m_avg = index$V3[1]
    f_var = index$V4[1]
    m_var = index$V5[1]
    f_fit = index$V6[1]
    m_fit = index$V7[1]
    pop_lab = str_split(files[i],pattern="_")[[1]][3]
    pop = pop_lab

    data_mat[i,] <- c(f_avg, m_avg, f_var, m_var, f_fit, m_fit, pop_lab)
  }
  all_df <- as.data.frame(data_mat)
  return(all_df)
}

swapped_vars <- var_collector(var_file_names)

### store output

write.table(swapped_vars, paste(prefix, suffix, sep=""), sep=",", col.names=FALSE)
