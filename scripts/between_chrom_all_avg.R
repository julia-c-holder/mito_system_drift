# Title     : between_chrom_all_avg.R
# Objective : average fitnesses in all reps
# Created by: juliaholder
# Created on: 10/30/26

library(stringr)
library(readr)
library(dplyr)

args <- commandArgs(trailingOnly = TRUE)

folder <- args[1]

file_list <- c()

for (j in 1:100){
    new_name <- paste("results/between/swapped/chrom_fits/rep", folder, "_pop_", j,".csv", sep="")
    file_list <- c(file_list, new_name)
}


female_mat <- matrix(nrow=500, ncol=length(file_list))
male_mat <- matrix(nrow=500, ncol=length(file_list))

for(i in 1:length(file_list)){
  new_file <- read.csv(file_list[i], header=F)
  female_mat[,i] <- new_file$V2
  male_mat[,i] <- new_file$V3
}

female_df <- as.data.frame(female_mat)
male_df <- as.data.frame(male_mat)

avg_fit_f <- rowMeans(female_df)
avg_fit_m <- rowMeans(male_df)

pop_avg <- data.frame("f"=avg_fit_f, "m"=avg_fit_m)
out_file <- paste("results/between/swapped/chrom_fits/rep", folder, "chrom_avg.csv", sep="")

write.table(pop_avg, out_file, sep=",", col.names=F)