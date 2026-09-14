#### Collects swapped mean and variance ###
#script for midway

#these obviously shouldn't be hardcoded - will fix in the future
nreps <- 250
repnum <- "7"
prefix <- paste("results/normalizer/", repnum,"/rep", repnum, "_", sep="")
suffix <- "_within_pheno_100000.csv"
var_file_names <- c()

for(i in 1:nreps){
  var_file_names[i] <- paste(prefix, i, suffix, sep="")
}

var_collector <- function(files){
  #initializing with first file
  data_mat <- matrix(nrow=nreps, ncol=4)
  #subsetting to the time period where recording is every 100 gens
  index = read.csv(files[1], header=F, sep=",")
  
  f_mito = index$V2[1]
  m_mito = index$V3[1]
  f_auto = index$V4[1]
  m_auto = index$V5[1]
  
  #print(c(f_avg, m_avg, f_var, m_var))
  data_mat[1,] <- c(f_mito, m_mito, f_auto, m_auto)
  
  for(i in 2:length(files)){
    index = read.csv(files[i], header=F, sep=",")
    #columns I will record
    f_mito = index$V2[1]
    m_mito = index$V3[1]
    f_auto = index$V4[1]
    m_auto = index$V5[1]
    
    data_mat[i,] <- c(f_mito, m_mito, f_auto, m_auto)
  }
  all_df <- as.data.frame(data_mat)
  return(all_df)
}

norms_all <- var_collector(var_file_names)

### store output
out_name <- paste("results/normalizer/normalizer_", repnum, ".csv", sep="")
write.table(norms_all, out_name, sep=",", col.names=FALSE)
