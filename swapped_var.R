### Variance of Swapped ###
#Midway R script 

library(dplyr)
library(readr)
#command line arguments
args <- commandArgs(trailingOnly = TRUE)
prefix <- args[1] #file prefix ex. "rep3_" for replicates from folder 3
suffix <- args[2] #file suffix ex. "150000.csv" for swaps at gen. 150000 

fitness_fun <- function(pheno){
	fitness <- dnorm(pheno, 0, 1)*sqrt(2*pi)
	return(fitness)
}
var_collector <- function(files){
  #initializing with first file
  #subsetting to the time period where recording is every 100 gens
  index = read_csv(files[1], col_names = c("num", "sex", "auto_p", "mito_p", "mito_s_p", "pheno"))
  
  f_only <- filter(index, sex=="F")
  m_only <- filter(index, sex=="M")
  
  f_mean <- c()
  m_mean <- c()
  
  f_var <- c()
  m_var <- c()
  
  f_fit <- c()
  m_fit <- c()

  f_mean[1] <- mean(f_only$pheno)
  m_mean[1] <- mean(m_only$pheno)
  
  f_var[1] <- var(f_only$pheno)
  m_var[1] <- var(m_only$pheno)

  f_fit[1] <- mean(fitness_fun(f_only$pheno))
  m_fit[1] <- mean(fitness_fun(m_only$pheno))
  
  
  ## loop
  for(i in 2:length(files)){
    index = read_csv(files[i], col_names = c("num", "sex", "auto_p", "mito_p", "mito_s_p", "pheno"))
    #columns I will record
    f_only <- filter(index, sex=="F")
    m_only <- filter(index, sex=="M")
    
    f_mean[i] <- mean(f_only$pheno)
    m_mean[i] <- mean(m_only$pheno)
    
    f_var[i] <- var(f_only$pheno)
    m_var[i] <- var(m_only$pheno)

    f_fit[i] <- mean(fitness_fun(f_only$pheno))
    m_fit[i] <- mean(fitness_fun(m_only$pheno))
    
  }
  return(data.frame(f_mean=f_mean, m_mean = m_mean, f_var=f_var, m_var=m_var, f_fit=f_fit, m_fit=m_fit))
}


### This script analyzes 125 swaps - 
nreps <- 125

swapped_file_names <- c()

for(i in 1:nreps){
  num1 <- 2*i - 1
  num2 <- num1 + 1
  swapped_file_names[i] <- paste(prefix, num1,"a_", num2,"m_pheno_", suffix, sep="")
}

print("running")
swapped_vars <- var_collector(swapped_file_names)
print("done!")

## OUTPUT CSV
out_file <- "results/summaries/swapped_vars.csv"
write.table(swapped_vars, out_file, sep=",", col.names=FALSE)
