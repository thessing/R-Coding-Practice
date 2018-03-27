#
# File   -: pollutantmean.R
# Author -: Tim Hessing
# Date   -: 26-March-2018
# Version-: 1.0
#
# Description-: Function to return the mean of a specified pollutant over one or more data files in a directory
#
#        Args-: directory - character vector length 1, containing name of directory containing data files
#               pollutant - character vector length 1, containing name of pullutant ("sulfate" or "nitrate")
#               id        - integer   vector indicating which monitors (aka files) to use in calculation
#
pollutantmean <- function(directory, pollutant, id = 1:332) {
  #
  # Initialize result to NA
  #
  result <- NA
  #
  # Save Working Directory
  #
  old.dir <- getwd()
  #
  # Verify input args are reasonable
  #
  if (file.info(directory)$isdir && (pollutant == "sulfate" || pollutant == "nitrate")) {
    #
    # Get list of data files from directory then move into "directory"
    #
    fileList <- dir(directory)
    setwd(directory)
    #
    # Initialize sum & count
    #
    sum   <- 0
    count <- 0
    #
    # loop over ids
    #
    for (n in id) {
      #
      # get input data and extract pollutant
      #
      dd <- read.csv(fileList[n])
      if (pollutant == "sulfate") {
        ss <- dd$sulfate[!is.na(dd$sulfate[])]        
      } else {
        ss <- dd$nitrate[!is.na(dd$nitrate[])]        
      }# end pollutant if
      #
      # sum
      #
      count <- count + length(ss)
      sum   <- sum   + length(ss)*mean(ss)
    } # end id loop
    #
    # Calculate result
    #
    if (count != 0) result <- sum/count
  } #  end args if
  #
  # reset working directory & return result
  #
  setwd(old.dir)
  result
} # end function