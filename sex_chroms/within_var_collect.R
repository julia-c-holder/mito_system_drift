#### Collects swapped mean and variance ###
#script for use on the cluster - I cannot say this is particularly good code

#these obviously shouldn't be hardcoded - will fix in the future
library(stringr)
library(readr)
library(dplyr)


args <- commandArgs(trailingOnly = TRUE) #This is the command for interpreting arguments from the bash script
#the trailing thing means that the variables in the bash script are all after the name of the R script
rep <- args[1] #this is the folder number in which the results were stored
nreps <- args[3] #Excellent naming, Julia. this is the number of replicates of a given set
prefix <- paste("results/within/variances/rep", rep, "_", sep="")
suffix <- args[2]
var_file_names <- c()

for(i in 1:nreps){
 # num2 <- num1 + 1
  var_file_names[i] <- paste(prefix, i,"_", suffix, sep="")
}

#Why the first iteration isn't just in the loop, I cannot tell you anymore! Once I believe there was a reason. maybe
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
