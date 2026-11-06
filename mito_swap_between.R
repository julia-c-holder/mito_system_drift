#### REPLICATE SWAP MITOCHONDRIAL VALUES ####
#script for midway

library(stringr)
library(readr)
library(dplyr)

args <- commandArgs(trailingOnly = TRUE)

pop_num <- args[1]
num1 <- args[2] #first individual replicate in swap
num2 <- args[3] #second individual replicate in swap
folder <- args[4]
suffix <- args[5]


name_1 <- paste("results/between/", folder, "/pop_", pop_num, "/mito_auto_", folder, "_", num1, "_pheno_", suffix, sep="")
name_2 <- paste("results/between/", folder, "/pop_", pop_num, "/mito_auto_", folder, "_", num2, "_pheno_", suffix, sep="")


rep1 <- read_csv(name_1, col_names=T)
rep2 <- read_csv(name_2, col_names=T)

#Swapping
swap_fn <- function(repA, repB){
  n <- nrow(repA)
  #should I do this within the function?
  repA_f <- filter(repA, sex == "F")
  repA_m <- filter(repA, sex == "M")

  repB_f <- filter(repB, sex == "F")
  repB_m <- filter(repB, sex == "M")

  repAa_Bm <- data.frame(sex = c(rep("F", n/2), rep("M", n/2)), auto_p = c(repA_f$auto, repA_m$auto),
                         mito_p = c(repB_f$mito, repB_m$mito), mito_scaled_p = c(repB_f$mito_scaled,
                                                                                     repB_m$mito_scaled))
  repAa_Bm <- mutate(repAa_Bm, pheno = auto_p + mito_scaled_p)

  ### SHOULD I DO THE RECIPROCAL CROSS? PROBABLY NO...
  #repBa_Am <- data.frame(sex = c(rep("F", n/2), rep("M", n/2)), auto_p = c(repB_f$auto_p, repB_m$auto_p),
   #                        mito_p = c(repA_f$mito_p, repA_m$mito_p), mito_scaled_p = c(repA_f$mito_scaled_p,
    #                                                                                   repA_m$mito_scaled_p))
  # repBa_Am <- mutate(repBa_Am, pheno = auto_p + mito_scaled_p)

  return(repAa_Bm)
}


swapped <- swap_fn(rep1, rep2)

new_file_name <- paste("results/between/swapped/rep", folder, "_pop_", pop_num,"_", num1, "a_", num2, "m_pheno_", suffix, sep="")

write.table(data.frame(swapped), new_file_name, sep=",", col.names=FALSE)


