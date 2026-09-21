### Variance of Swapped - ind replicate ###
#Midway R script 

library(dplyr)
library(readr)
#command line arguments
args <- commandArgs(trailingOnly = TRUE)

id <- args[1] #numerical id fed in as array
suffix <- args[2] #which generation is being compared, ex. "150000.csv"
norm_name <- args[3]
repnum <- args[4]

fitness_fun <- function(pheno){
	fitness <- dnorm(pheno, 0, 1)*sqrt(2*pi)
	return(fitness)
}
rep_heads <- c("sex", "auto_p", "mito_p", "mito_scaled_p","x_p", "y_p", "pheno")

normalizing_fun <- function(num, data, norm){
  ##THIS FUNCTION ASSUMES SCALING FACTOR IS 1 FOR MITOCHONDRIA --- EDIT IF CHANGING SCALING!!!
  N <- length(data$sex)
  m_norm_f <- norm$X1[num] #mean female mitochondrial value at end of burn-in
  m_norm_m <- norm$X2[num]

  a_norm_f <- norm$X3[num] #mean female autosomal value at end of burn-in
  a_norm_m <- norm$X4[num]

  x_norm_f <- norm$X5[num] 
  x_norm_m <- norm$X6[num]
  y_norm_m <- norm$X7[num]

  #SLiM puts all females first then all males in the population
  auto_p <- data$auto_p - c(rep(a_norm_f, N/2), rep(a_norm_m, N/2))
  mito_p <- data$mito_p - c(rep(m_norm_f, N/2), rep(m_norm_m, N/2))
  mito_scaled_p <- data$mito_scaled_p - c(rep(m_norm_f, N/2), rep(m_norm_m, N/2))
  x_norm <- data$x_p - c(rep(x_norm_f, N/2), rep(x_norm_m, N/2))
  y_norm <- c(rep(0, N/2), data$y_p[5001:10000] - rep(y_norm_m, N/2))
  pheno <- auto_p + mito_scaled_p + x_norm + y_norm

  normalized <- data.frame("sex" = data$sex, "auto_p" = auto_p, "mito_p" = mito_p, "mito_scaled_p" = mito_scaled_p,
                           "x_p" = x_norm, "y_p" = y_norm, "pheno" = pheno)
  return(normalized)
}

var_collector <- function(file){
  #initializing with first file
  #subsetting to the time period where recording is every 100 gens
  f_only <- filter(file, sex=="F")
  m_only <- filter(file, sex=="M")
  
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

prefix <- paste("results/", repnum, "/mito_auto_",repnum,"_", sep="")

print(id)
num1 <- as.integer(id)
file_name <- paste(prefix, id,"_pheno_", suffix, sep="")

raw_file <- read_csv(file_name, col_names = rep_heads)
norm_file <- read_csv(norm_name, col_names = FALSE)

normed <- normalizing_fun(num1, raw_file, norm_file)
within_vars <- var_collector(normed)

print("done!")

## OUTPUT CSV
result_pre <- paste("results/within/variances/rep", repnum, "_", sep="")
out_file <- paste(result_pre, id,"_within_pheno_", suffix, sep="")

write.table(within_vars, out_file, sep=",", col.names=FALSE)
