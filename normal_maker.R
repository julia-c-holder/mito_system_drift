#### Script to collect burn in averages to normalize with ###

#So the normalization constants should be drawn from the no_dups burn ins
library(readr)
library(DescTools)
library(dplyr)

args <- commandArgs(trailingOnly = TRUE)

file_collected <- read.csv(args[1])
file_out <- args[2]

### Function to remove incomplete runs 
remove_dups <- function(nreps, init_file, all_file){
  dup_reps <- Mode(init_file$reps)
  all_file <- mutate(all_file, rows=seq(1, length(all_file$cycles)))
  keep_file <- all_file
  #while some reps are included more than once, remove those duplicates
  while((length(dup_reps) < nreps) && (is.na(max(dup_reps))==FALSE)){
    keep_starts <- c()
    keep_ends <- c()
    rows_to_keep <- c()
    
    keep_file$rows <- seq(1, length(keep_file$cycles)) #index updates to remove the correct lines
    for(i in 1:length(dup_reps)){
      a_dup <- filter(keep_file, reps==dup_reps[i] & cycles==10) #lists every start/restart
      keep_starts[i] <- a_dup$rows[1]-1 #keep up until the first false start
      keep_ends[i] <- a_dup$rows[length(a_dup$rows)] #keep the last start (which was a full run)
    }
    #turn these indeces into a vector I can use to subset the full original file
    if(length(keep_starts)==1){
      rows_to_keep <- c(1:keep_starts[1], keep_ends[1]:length(keep_file$rows))
    }
    else{
      rows_to_keep <- c(1:keep_starts[1])
      for(j in 2:(length(keep_starts))){
        rows_to_keep <- c(rows_to_keep, keep_ends[j-1]:keep_starts[j])
      }
      
      rows_to_keep <- c(rows_to_keep, keep_ends[j]:length(keep_file$rows))
    }
    keep_file <- keep_file[rows_to_keep, ] #subset
    dup_reps <- Mode(filter(keep_file, cycles==10)$reps) #update list of remaining duplicates
    #once every replicate is represented only once, Mode returns NA and the while loop ends
  }
  return(keep_file)
}
#filter out duplicates
no_dups <- remove_dups(max(file_collected$reps), filter(file_collected, cycles==10), filter(file_collected, cycles<100001))

burn_in <- filter(no_dups, cycles==100000)

normal_df <- data.frame(burn_in$avg_mito_f, burn_in$avg_mito_m, 
                        burn_in$avg_auto_f, burn_in$avg_auto_m)

write_csv(normal_df, file_out, col_names = F)
