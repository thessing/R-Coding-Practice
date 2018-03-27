# File   -: template.R
# Author -: Tim Hessing
# Date   -: dd-month-year
# Version-: 1.0
#
# Description-: Function to do something
#
#        Args-: arg1 - xxx vector length 1, containing xxx
#               arg2 - xxx vector length 1, indicating yyy
#
template <- function(arg1, arg2 = 0) {
  #
  # Save Working Directory and
  # Initialize result and other stuff
  #
  old.dir <- getwd()
  result  <- NA
  # other ...
  # = = = = = = = = = = = = = = = = = = = = = = =

  #
  # Verify input args are reasonable
  #
  if (is.na(arg1)) {
    #
    # do something
    #

    # something
    
    #
    # set result
    #
    result <- result
  } # end args if check

  # = = = = = = = = = = = = = = = = = = = = = = =
  #
  # reset working directory & return result
  #
  setwd(old.dir)
  result
} # end function