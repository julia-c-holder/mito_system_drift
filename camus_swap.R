#### REPLICATE SWAP MITOCHONDRIAL VALUES ####
#script for midway

library(stringr)
library(readr)
library(dplyr)

args <- commandArgs(trailingOnly = TRUE)

### TEST METHODOLOGY
num1 <- args[1] #replicate number for autosomal donor pop
num2 <- args[2] #replicate number for mitochondrial donor pop

#### For scaling version
#id_num <- args[1]
#num1 <- (2*as.integer(id_num)) - 1
folder <- args[3]
suffix <- args[4]

#num2 <- num1 + 1

name_1 <- paste("results/", folder, "/mito_auto_", folder, "_", num1, "_pheno_", suffix, sep="")
name_2 <- paste("results/", folder, "/mito_auto_", folder, "_", num2, "_pheno_", suffix, sep="")


rep_heads <- c("sex", "auto_p", "mito_p", "mito_scaled_p", "pheno")
rep1 <- read_csv(name_1, col_names=rep_heads)
rep2 <- read_csv(name_2, col_names=rep_heads)

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

swapped <- swap_fn(rep1, rep2)

new_file_name <- paste("results/swapped/reciprocal/rep", folder, "_", num1, "a_", num2, "m_pheno_", suffix, sep="")

write.table(data.frame(swapped), new_file_name, sep=",", col.names=FALSE)
