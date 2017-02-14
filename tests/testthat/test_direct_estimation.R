# Test if point estimation runs on its own and returns the same values


# Load needed data
library(laeken)
data(eusilc)



test_that("Does the direct estimation in emdi return the point and variance 
          estimates when a naive bootstrap is used?", {
  
  # Direct estimation with naive bootstrap
  direct_all_naive <- direct(y="eqIncome",
                             smp_data=eusilc, 
                             smp_domains="db040", 
                             weights="rb050", 
                             # with weights
                             pov_line=10859.24, 
                             var=TRUE,
                             bootType = "naive",
                             X = NULL, 
                             totals = NULL, 
                             B=5,  
                             seed=123, 
                             na.rm=TRUE)
  
  # HCR from laeken package (benchmark)
  arpr_all <- read.csv2("./arpr_all.csv", sep=",")  
  arpr_all_naive  <- read.csv2("./arpr_all_naive.csv", sep=",")
  arpr_all$Head_Count <- as.numeric(as.character(arpr_all$Head_Count))
  arpr_all_naive$Head_Count <- as.numeric(as.character(arpr_all_naive$Head_Count))
  
  # Compare HCR from direct and benchmark
  expect_equal(arpr_all,
               direct_all_naive$ind[, c("Domain","Head_Count")])
  # expect_equal(arpr_all_naive,
  #              direct_all_naive$MSE[, c("Domain","Head_Count")])
  
  
  # Gini from laeken package (benchmark)
  gini_all <- read.csv2("./gini_all.csv", sep=",")  
  gini_all_naive  <- read.csv2("./gini_all_naive.csv", sep=",")
  gini_all$Gini <- as.numeric(as.character(gini_all$Gini))
  gini_all_naive$Gini <- as.numeric(as.character(gini_all_naive$Gini))

  # Compare Gini from direct and benchmark
  expect_equal(gini_all,
               direct_all_naive$ind[, c("Domain","Gini")])
  expect_equal(gini_all_naive,
               direct_all_naive$MSE[, c("Domain","Gini")])
  
  
  # QSR from laeken package (benchmark)
  qsr_all <- read.csv2("./qsr_all.csv", sep=",")  
  qsr_all_naive  <- read.csv2("./qsr_all_naive.csv", sep=",")
  qsr_all$Quintile_Share <- as.numeric(as.character(qsr_all$Quintile_Share))
  qsr_all_naive$Quintile_Share <- as.numeric(as.character(qsr_all_naive$Quintile_Share))
  
  # Compare QSR from direct and benchmark
  # expect_equal(qsr_all,
  #             direct_all_naive$ind[, c("Domain","Quintile_Share")])
  expect_equal(qsr_all_naive,
               direct_all_naive$MSE[, c("Domain","Quintile_Share")])
  
})



test_that("Does the direct estimation in emdi return the point and variance 
          estimates when a calibrated bootstrap is used?", {
            
            # Direct estimation with naive bootstrap
            direct_all_cali <-  direct(y="eqIncome",
                                       smp_data=eusilc, 
                                       smp_domains="db040", 
                                       weights="rb050", 
                                       # without weights
                                       #pov_line = 10848.8, 
                                       # with weights
                                       pov_line=10859.24, 
                                       var=TRUE,
                                       bootType = "calibrate",
                                       X = as.matrix(eusilc$age), 
                                       totals = NULL, 
                                       B=5,  
                                       seed=123, 
                                       na.rm=TRUE)
            
            # HCR from laeken package (benchmark)
            # arpr_all_cali  <- read.csv2("./arpr_all_cali.csv", sep=",")
            # arpr_all_cali$Head_Count <- as.numeric(as.character(arpr_all_cali$Head_Count))
            
            # Compare HCR from direct and benchmark
            # expect_equal(arpr_all_cali,
            #              direct_all_cali$MSE[, c("Domain","Head_Count")])
            
            
            # Gini from laeken package (benchmark)
            gini_all_cali  <- read.csv2("./gini_all_cali.csv", sep=",")
            gini_all_cali$Gini <- as.numeric(as.character(gini_all_cali$Gini))
            
            # Compare Gini from direct and benchmark
            expect_equal(gini_all_cali,
                         direct_all_cali$MSE[, c("Domain","Gini")])
            
            
            # QSR from laeken package (benchmark)
            qsr_all_cali  <- read.csv2("./qsr_all_cali.csv", sep=",")
            qsr_all_cali$Quintile_Share <- as.numeric(as.character(qsr_all_cali$Quintile_Share))
            
            # Compare QSR from direct and benchmark
            # expect_equal(qsr_all,
            #             direct_all_naive$ind[, c("Domain","Quintile_Share")])
            expect_equal(qsr_all_cali,
                         direct_all_cali$MSE[, c("Domain","Quintile_Share")])
            
          })
