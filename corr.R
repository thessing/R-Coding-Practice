# File   -: corr.R
# Author -: Tim Hessing
# Date   -: 27-March-2018
# Version-: 1.0
#
# Description-: Function to return the correlation of pollutants for selected files 
#               with number of completed cases above threshold in from a specified directory
#
#        Args-: directory - character vector length 1, containing name of directory containing data files
#               threshold - numeric   vector  length 1 indicating number of complete caes needed in file to do correlation
#
corr <- function(directory, threshold = 0) {
  #
  # Initialize result, fid & dcor to NA and set cnt to zero
  #
  result <- NA
  dcor   <- vector("numeric")
  cnt    <-  0
  #
  # Save Working Directory
  #
  old.dir <- getwd()

  #
  # Verify input args are reasonable
  #
  if (file.info(directory)$isdir) {
    #
    # get list of ids and total number of completed cases for each file
    #
    cc <- complete(directory)
    #
    # Get list of data files from directory then move into "directory"
    #
    fileList <- dir(directory)
    setwd(directory)
    #
    # loop over ids (aka files)
    #
    for (n in 1:length(cc$id)) {
      #
      #
      #
      if (cc$nobs[n] > threshold) { 
        #
        # get input data, increment count and find number of complete observations
        #
        cnt       <- cnt + 1
        dd        <- read.csv(fileList[cc$id[n]])
        dcor[cnt] <- cor( dd$sulfate[!is.na(dd$sulfate[]) & !is.na(dd$nitrate[]) ], 
                          dd$nitrate[!is.na(dd$sulfate[]) & !is.na(dd$nitrate[]) ] )
      } # end threshold if
    } # end id loop
    #
    # set result
    #
    result <- dcor
  } #  end args if
  #
  # reset working directory & return result
  #
  setwd(old.dir)
  result
} # end function