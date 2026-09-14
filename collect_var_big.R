#### Midway R Script - Collects replicates of mito_auto_w_cov.slim ######
## records avg and var phenotype for males and females, cov within mito
## and mito auto covariance in males and females #
# This script is adjusted for the run of mito_auto_w_cov.slim with mito length=100
args <- commandArgs(trailingOnly = TRUE)
repnum <- args[1] #simulation replicate number, which is the folder the results are in 

csv_collector <- function(files){
  #initializing with first file
  #subsetting to the time period where recording is every 100 gens
  index = read.csv(files[1], header=F, sep=",")
  cycles = index$V1
  avg_auto_f = index$V2
  avg_mito_f = index$V3
  avg_auto_m = index$V5
  avg_mito_m = index$V6

  avg_pheno_f = index$V14
  avg_pheno_m = index$V15
  var_pheno_f = index$V16
  var_pheno_m = index$V17
  var_mito_f = index$V9
  var_auto_f = index$V8
  var_auto_m = index$V11
  var_mito_m = index$V12
  genic_var_auto_f = index$V18
  genic_var_mito_f = index$V19
  genic_var_auto_m = index$V21
  genic_var_mito_m = index$V22
  cov_mito_f = index$V24
  cov_mito_m = index$V27
  cov_auto_f = index$V26
  cov_auto_m = index$V29
  cov_mito_auto_f = index$V30
  cov_mito_auto_m = index$V31
  
  reps = rep(1, length(cycles))
  all_df <- data.frame(cycles = cycles, avg_auto_f=avg_auto_f, avg_mito_f=avg_mito_f, 
		       avg_auto_m=avg_auto_m, avg_mito_m=avg_mito_m, 
		       avg_pheno_f = avg_pheno_f, avg_pheno_m = avg_pheno_m,
                       var_pheno_f=var_pheno_f, var_pheno_m = var_pheno_m, var_mito_f=var_mito_f,
                       var_mito_m=var_mito_m, var_auto_f=var_auto_f, var_auto_m=var_auto_m,
		       genic_var_auto_f = genic_var_auto_f, genic_var_mito_f = genic_var_mito_f, 
		       genic_var_auto_m = genic_var_auto_m, genic_var_mito_m = genic_var_mito_m,
		       cov_mito_f=cov_mito_f, cov_mito_m= cov_mito_m,
                       cov_auto_f=cov_auto_f, cov_auto_m= cov_auto_m,
		       cov_mito_auto_f=cov_mito_auto_f, cov_mito_auto_m=cov_mito_auto_m,
                      reps=reps)
  for(i in 2:length(files)){
    index = read.csv(files[i], header=F, sep=",")
    #columns I will record
    cycles = index$V1
    avg_auto_f = index$V2
    avg_mito_f = index$V3
    avg_auto_m = index$V5
    avg_mito_m = index$V6
    avg_pheno_f = index$V14
    avg_pheno_m = index$V15
    var_pheno_f = index$V16
    var_pheno_m = index$V17
    var_mito_f = index$V9
    var_auto_f = index$V8
    var_auto_m = index$V11
    var_mito_m = index$V12
    genic_var_auto_f = index$V18
    genic_var_mito_f = index$V19
    genic_var_auto_m = index$V21
    genic_var_mito_m = index$V22
    cov_mito_f = index$V24
    cov_mito_m = index$V27
    cov_auto_f = index$V26
    cov_auto_m = index$V29
    cov_mito_auto_f = index$V30
    cov_mito_auto_m = index$V31
    
    reps = rep(i, length(cycles))
    all_df <- rbind(all_df, data.frame(cycles = cycles, avg_auto_f=avg_auto_f, avg_mito_f=avg_mito_f, 
                       			avg_auto_m=avg_auto_m, avg_mito_m=avg_mito_m,
				       avg_pheno_f = avg_pheno_f, avg_pheno_m = avg_pheno_m,
                                       var_pheno_f=var_pheno_f, var_pheno_m = var_pheno_m, var_mito_f=var_mito_f,
                                       var_mito_m=var_mito_m, var_auto_f=var_auto_f, var_auto_m=var_auto_m,
				       genic_var_auto_f = genic_var_auto_f, genic_var_mito_f = genic_var_mito_f,
                      		       genic_var_auto_m = genic_var_auto_m, genic_var_mito_m = genic_var_mito_m,
                       		       cov_mito_f=cov_mito_f, cov_mito_m= cov_mito_m,
                      		       cov_auto_f=cov_auto_f, cov_auto_m= cov_auto_m,

                                       cov_mito_auto_f=cov_mito_auto_f, cov_mito_auto_m=cov_mito_auto_m,
                                       reps=reps))
  }
  return(all_df)
}

nreps <- 250

### Results are in folder 5
chrom_file_names <- c()

for(i in 1:nreps){
  chrom_file_names[i] <- paste("results/",repnum,"/mito_auto_",repnum,"_", i, "_chrom.csv", sep="")
}

cov_var_collected <- csv_collector(chrom_file_names)

## OUTPUT CSV

write.table(data.frame(cov_var_collected),paste("results/summaries/unnorm_", repnum,"_collected.csv", sep=""), sep=",", col.names=TRUE)
