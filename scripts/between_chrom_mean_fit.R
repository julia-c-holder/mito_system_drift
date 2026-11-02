# Title     : between_chrom_fits.R
# Objective : calculate fitness of mean pheno for between population swaps through time
# Created by: juliaholder
# Created on: 10/28/26

library(stringr)
library(readr)
library(dplyr)

args <- commandArgs(trailingOnly = TRUE)

pop_num <- args[1]
num1 <- args[2] #first individual replicate in swap
num2 <- args[3] #second individual replicate in swap
folder <- args[4]


name_1 <- paste("results/between/", folder, "/pop_", pop_num, "/mito_auto_", folder, "_", num1, "_chrom.csv", sep="")
name_2 <- paste("results/between/", folder, "/pop_", pop_num, "/mito_auto_", folder, "_", num2, "_chrom.csv", sep="")
print(name_1)
rep1 <- read.csv(name_1, skip=1, header=F)
print(head(rep1))

rep2 <- read.csv(name_2, skip=1, header=F)

swap_vals_fn <- function(repA, repM){
  # mean auto_f from rep A and mean mito f from rep M
  mean_f <- repA$V2 + repM$V3
  # mean auto_m from rep A and mean mito m from rep M
  mean_m <- repA$V5 + repM$V6
  return(data.frame(mean_f=mean_f, mean_m=mean_m, var_f=var_f, var_m=var_m))
}

dumb_fit_calc <- function(val){
  mean_fit <- dnorm(val)*sqrt(2*pi)
  return(mean_fit)
}

  f_data_mat <- matrix(c(data$mean_f), ncol=1)
  m_data_mat <- matrix(c(data$mean_m), ncol=1)
  f_fits <- apply(f_data_mat, 1, function(VAL) dumb_fit_calc(VAL))

  m_fits <- apply(m_data_mat, 1, function(VAL) dumb_fit_calc(VAL))

  return(data.frame(fit_f = f_fits, fit_m=m_fits))
}

swapped_vals <- swap_vals_fn(rep1, rep2)
print(head(swapped_vals))
swapped_fits <- fit_thru_time(swapped_vals)
print(head(swapped_fits))

out_file <- paste("results/between/swapped/chrom_fits/rep", folder, "_pop_", pop_num, "_", num1,"a_", num2,"m_mean_chrom.csv", sep="")

write.table(swapped_fits, out_file, sep=",", col.names=T)
