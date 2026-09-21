### Variance of Swapped - ind replicate ###
#Midway R script 

library(dplyr)
library(readr)
#command line arguments
args <- commandArgs(trailingOnly = TRUE)

num1<- args[1] #numerical id fed in as array
num2 <- args[2] #numerical id fed in as array
suffix <- args[3] #which generation is being compared, ex. "150000.csv"
#print("nums")
#print(num1)
#print(num2)
#print("suffix")
#print(suffix)
var_collector <- function(files){
  #takes a single population, calculates the descriptive statistics
  index = read_csv(files[1], col_names = c("num", "sex", "auto_p", "mito_p", "mito_s_p", "pheno"))
  
  f_only <- filter(index, sex=="F")
  m_only <- filter(index, sex=="M")
  
  f_mean <- c()
  m_mean <- c()
  
  f_var <- c()
  m_var <- c()
  
  f_mean[1] <- mean(f_only$pheno)
  m_mean[1] <- mean(m_only$pheno)
  
  f_var[1] <- var(f_only$pheno)
  m_var[1] <- var(m_only$pheno)
  
  return(data.frame(f_mean=f_mean, m_mean = m_mean, f_var=f_var, m_var=m_var))
}

prefix <- "results/swapped/reciprocal/rep8_"

file_name <- paste(prefix, num1,"a_", num2,"m_pheno_", suffix, sep="")

swapped_vars <- var_collector(file_name)

print("done!")

## OUTPUT CSV
out_file <- paste("results/swapped/variances/camus/rep8_", num1,"a_", num2,"m_pheno_", suffix, sep="")

write.table(swapped_vars, out_file, sep=",", col.names=FALSE)
