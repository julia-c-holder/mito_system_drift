#### Script to collect burn in averages to normalize with ###

#So the normalization constants should be drawn from the no_dups burn ins
library(readr)
library(dplyr)

args <- commandArgs(trailingOnly = TRUE)

file_collected <- read.csv(args[1], skip=1, header=F)
file_out <- args[2]

n <- nrow(file_collected)
m <- length(unique(file_collected$V2))*1000

if(n == m){
  no_dups <- file_collected
}

burn_in <- filter(no_dups, V2==100000)

normal_df <- data.frame(burn_in$V4, burn_in$V7,
                        burn_in$V3, burn_in$V6)

write_csv(normal_df, file_out, col_names = F)
