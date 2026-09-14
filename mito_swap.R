#### REPLICATE SWAP MITOCHONDRIAL VALUES ####
#script for midway

library(stringr)
library(readr)
library(dplyr)

args <- commandArgs(trailingOnly = TRUE)

### TEST METHODOLOGY
#name_1 <- args[1]
#name_2 <- args[2]

#### For scaling version
id_num <- args[1]
num1 <- (2*as.integer(id_num)) - 1
folder <- args[2]
suffix <- args[3]
norm_file <- args[4] ## normalization file name

num2 <- num1 + 1

name_1 <- paste("results/", folder, "/mito_auto_", folder, "_", num1, "_pheno_", suffix, sep="")
name_2 <- paste("results/", folder, "/mito_auto_", folder, "_", num2, "_pheno_", suffix, sep="")


rep_heads <- c("sex", "auto_p", "mito_p", "mito_scaled_p", "pheno")
rep1 <- read_csv(name_1, col_names=rep_heads)
rep2 <- read_csv(name_2, col_names=rep_heads)
norm_df <- read_csv(norm_file, col_names=FALSE)

normalizing_fun <- function(num, data, norm){
  ##THIS FUNCTION ASSUMES SCALING FACTOR IS 1 FOR MITOCHONDRIA --- EDIT IF CHANGING SCALING!!!
  N <- length(data$sex)
  m_norm_f <- norm$X1[num] #mean female mitochondrial value at end of burn-in
  m_norm_m <- norm$X2[num]

  a_norm_f <- norm$X3[num] #mean female autosomal value at end of burn-in
  a_norm_m <- norm$X4[num]

  #SLiM puts all females first then all males in the population
  auto_p <- data$auto_p - c(rep(a_norm_f, N/2), rep(a_norm_m, N/2))
  mito_p <- data$mito_p - c(rep(m_norm_f, N/2), rep(m_norm_m, N/2))
  mito_scaled_p <- data$mito_scaled_p - c(rep(m_norm_f, N/2), rep(m_norm_m, N/2))
  pheno <- auto_p + mito_scaled_p

  normalized <- data.frame("sex" = data$sex, "auto_p" = auto_p, "mito_p" = mito_p, "mito_scaled_p" = mito_scaled_p,
                           "pheno" = pheno)
  return(normalized)
}

#normalizing the populations that will be used in the swap
norm_1 <- normalizing_fun(num1, rep1, norm_df)
norm_2 <- normalizing_fun(num2, rep2, norm_df)

#Swapping
swap_fn <- function(repA, repB){
  n <- nrow(repA)
  #should I do this within the function?
  repA_f <- filter(repA, sex == "F")
  repA_m <- filter(repA, sex == "M")
  
  repB_f <- filter(repB, sex == "F")
  repB_m <- filter(repB, sex == "M")
  
  repAa_Bm <- data.frame(sex = c(rep("F", n/2), rep("M", n/2)), auto_p = c(repA_f$auto_p, repA_m$auto_p), 
                         mito_p = c(repB_f$mito_p, repB_m$mito_p), mito_scaled_p = c(repB_f$mito_scaled_p, 
                                                                                     repB_m$mito_scaled_p))
  repAa_Bm <- mutate(repAa_Bm, pheno = auto_p + mito_scaled_p)
  
  ### SHOULD I DO THE RECIPROCAL CROSS? PROBABLY NO...
  #repBa_Am <- data.frame(sex = c(rep("F", n/2), rep("M", n/2)), auto_p = c(repB_f$auto_p, repB_m$auto_p), 
   #                        mito_p = c(repA_f$mito_p, repA_m$mito_p), mito_scaled_p = c(repA_f$mito_scaled_p, 
    #                                                                                   repA_m$mito_scaled_p))
  # repBa_Am <- mutate(repBa_Am, pheno = auto_p + mito_scaled_p)
  
  return(repAa_Bm)
}


swapped <- swap_fn(norm_1, norm_2)

new_file_name <- paste("results/swapped/rep", folder, "_", num1, "a_", num2, "m_pheno_", suffix, sep="")

write.table(data.frame(swapped), new_file_name, sep=",", col.names=FALSE)