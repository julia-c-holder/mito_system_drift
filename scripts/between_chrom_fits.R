# Title     : between_chrom_fits.R
# Objective : calculate mean fitness of swaps for between population swaps through time
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
  mean_f <- repA$X2 + repM$X3
  # mean auto_m from rep A and mean mito m from rep M
  mean_m <- repA$X5 + repM$X6
  var_f <- repA$X8 + repM$X9
  var_m <- repA$X11 + repM$X12

  return(data.frame(mean_f=mean_f, mean_m=mean_m, var_f=var_f, var_m=var_m))
}

dumb_fit_calc <- function(vals){
  dumb_data <- rnorm(100, vals[1], vals[2])
  return(mean(dnorm(dumb_data))*sqrt(2*pi))
}

fit_thru_time <- function(data){
  f_data_mat <- matrix(c(data$mean_f, data$var_f), ncol=2)
  m_data_mat <- matrix(c(data$mean_m, data$var_m), ncol=2)
  f_fits <- apply(f_data_mat, 1, function(PAIR) dumb_fit_calc(PAIR))

  m_fits <- apply(m_data_mat, 1, function(PAIR) dumb_fit_calc(PAIR))

  return(data.frame(fit_f = f_fits, fit_m=m_fits))
}

swapped_vals <- swap_vals_fn(rep1, rep2)
print(head(swapped_vals))
swapped_fits <- fit_thru_time(swapped_vals)
print(head(swapped_fits))

out_file <- paste("results/between/swapped/chrom_fits/rep", folder, "_pop_", pop_num, "_", num1,"a_", num2,"m_chrom.csv", sep="")

write.table(swapped_fits, out_file, sep=",", col.names=T)


