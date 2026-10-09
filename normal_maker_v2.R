#### Script to collect burn in averages to normalize with ###

#So the normalization constants should be drawn from the no_dups burn ins
library(readr)
library(dplyr)

args <- commandArgs(trailingOnly = TRUE)

file_collected <- read.csv(args[1])
file_out <- args[2]

n <- nrow(file_collected)
m <- length(unique(file_collected$cycles))*length(unique(file_collected$reps))

if(n == m){
  no_dups <- file_collected
}

burn_in <- filter(no_dups, cycles==100000)

normal_df <- data.frame(burn_in$avg_mito_f, burn_in$avg_mito_m,
                        burn_in$avg_auto_f, burn_in$avg_auto_m)

write_csv(normal_df, file_out, col_names = F)
