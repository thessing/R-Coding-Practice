# File   -: complete.R
# Author -: Tim Hessing
# Date   -: 26-March-2018
# Version-: 1.0
#
# Description-: Function to return the number of complete data entries for each file selected 
#               from a specified directory
#
#        Args-: directory - character vector length 1, containing name of directory containing data files
#               id        - integer   vector indicating which monitors (aka files) to use in calculation
#
complete <- function(directory, id = 1:332) {
  #
  # Initialize result & nobs to NA and set cnt to zero
  #
  result <- NA
  nobs   <- NA
  cnt    <- 0
  #
  # Save Working Directory
  #
  old.dir <- getwd()
  #
  # Verify input args are reasonable
  #
  if (file.info(directory)$isdir) {
    #
    # Get list of data files from directory then move into "directory"
    #
    fileList <- dir(directory)
    setwd(directory)
    #
    # loop over ids (aka files)
    #
    for (n in id) {
      #
      # get input data, increment count and find number of complete observations
      #
      dd        <- read.csv(fileList[n])
      cnt       <- cnt + 1
      nobs[cnt] <- length( dd$sulfate[!is.na(dd$sulfate[]) & !is.na(dd$nitrate[]) ] )
    } # end id loop
    #
    # set result
    #
    result <- data.frame(id, nobs)
  } #  end args if
  #
  # reset working directory & return result
  #
  setwd(old.dir)
  result
} # end function