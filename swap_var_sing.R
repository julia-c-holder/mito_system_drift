### Variance of Swapped - ind replicate ###
#Midway R script 

library(dplyr)
library(readr)
#command line arguments
args <- commandArgs(trailingOnly = TRUE)

id <- args[1] #numerical id fed in as array
suffix <- args[2] #which generation is being compared, ex. "150000.csv"
rep <- args[3]
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

  return(data.frame(f_mean=f_mean, m_mean = m_mean, f_var=f_var, m_var=m_var, f_fit=f_fit, m_fit=m_fit))
}

prefix <- paste("results/swapped/rep", rep, "_", sep="")

print(id)
num1 <- 2*as.integer(id) - 1
num2 <- num1 + 1
file_name <- paste(prefix, num1,"a_", num2,"m_pheno_", suffix, sep="")

swapped_vars <- var_collector(file_name)

print("done!")

## OUTPUT CSV
out_file <- paste("results/swapped/variances/rep", rep, "_", num1,"a_", num2,"m_pheno_", suffix, sep="")

write.table(swapped_vars, out_file, sep=",", col.names=FALSE)
