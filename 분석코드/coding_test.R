## java 
remotes::install_github("mrchypark/multilinguer")
library(multilinguer)
multilinguer::has_java(force = T)

## tensorflow 

# devtools::install_github("rstudio/tensorflow")
# install.packages("Rcpp")
.libPaths() # find package root 

library(devtools) ; library(Rcpp) ; library(reticulate)
# devtools::install_github("rstudio/tensorflow", force = T)
# install.packages("keras")

library(tensorflow) ; library(keras)
sess = tf$Session()
hello <- tf$constant("Hi, tensorflow!")
sess$run(hello)  

