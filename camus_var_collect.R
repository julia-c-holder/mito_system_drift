#### Collects swapped mean and variance ###
#script for midway

#these obviously shouldn't be hardcoded - will fix in the future
nreps <- 9
prefix <- "results/swapped/variances/camus/rep3_"
suffix <- "150000.csv"
var_file_names <- c()

for(i in 1:nreps){
	#so order will be 1a_1m, 1a_2m, usw.
	for(j in 1:nreps){
		num1 <- i
		num2 <- j
		var_file_names <- c(var_file_names, paste(prefix, num1,"a_", num2,"m_pheno_", suffix, sep=""))
	}
}

var_collector <- function(files){
  #initializing with first file
  n <- length(files)
  data_mat <- matrix(nrow=n, ncol=4)
  #subsetting to the time period where recording is every 100 gens
  index = read.csv(files[1], header=F, sep=",")
  
  f_avg = index$V2[1]
  m_avg = index$V3[1]
  f_var = index$V4[1]
  m_var = index$V5[1]
  
  #print(c(f_avg, m_avg, f_var, m_var))
  data_mat[1,] <- c(f_avg, m_avg, f_var, m_var)
  
  for(i in 2:n){
    index = read.csv(files[i], header=F, sep=",")
    #columns I will record
    f_avg = index$V2[1]
    m_avg = index$V3[1]
    f_var = index$V4[1]
    m_var = index$V5[1]
    
    data_mat[i,] <- c(f_avg, m_avg, f_var, m_var)
  }
  all_df <- as.data.frame(data_mat)
  return(all_df)
}

swapped_vars <- var_collector(var_file_names)

### store output

write.table(swapped_vars, paste(prefix, suffix, sep=""), sep=",", col.names=FALSE)
