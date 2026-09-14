#### Collects swapped mean and variance ###
#script for midway

#these obviously shouldn't be hardcoded - will fix in the future
library(stringr)
library(readr)
library(dplyr)


args <- commandArgs(trailingOnly = TRUE)
rep <- args[1]
nreps <- 250
prefix <- paste("results/within/variances/rep", rep, "_", sep="")
suffix <- "within_pheno_150000.csv"
var_file_names <- c()

for(i in 1:nreps){
 # num2 <- num1 + 1
  var_file_names[i] <- paste(prefix, i,"_", suffix, sep="")
}

var_collector <- function(files){
  #initializing with first file
  data_mat <- matrix(nrow=nreps, ncol=6)
  #subsetting to the time period where recording is every 100 gens
  index = read.csv(files[1], header=F, sep=",")
  
  f_avg = index$V2[1]
  m_avg = index$V3[1]
  f_var = index$V4[1]
  m_var = index$V5[1]
  f_fit = index$V6[1]
  m_fit = index$V7[1] 
  #print(c(f_avg, m_avg, f_var, m_var))
  data_mat[1,] <- c(f_avg, m_avg, f_var, m_var, f_fit, m_fit)
  
  for(i in 2:length(files)){
    index = read.csv(files[i], header=F, sep=",")
    #columns I will record
    f_avg = index$V2[1]
    m_avg = index$V3[1]
    f_var = index$V4[1]
    m_var = index$V5[1]
    f_fit = index$V6[1]
    m_fit = index$V7[1]
    
    data_mat[i,] <- c(f_avg, m_avg, f_var, m_var, f_fit, m_fit)
  }
  all_df <- as.data.frame(data_mat)
  return(all_df)
}

within_vars <- var_collector(var_file_names)

### store output

write.table(within_vars, paste(prefix, "new", suffix, sep=""), sep=",", col.names=FALSE)
