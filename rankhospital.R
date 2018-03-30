rankhospital <- function(state, outcome, num = "best") {
  #
  # state   is a 2 character abbreviated name for a state to search
  # outcome is a character vector of outcome to find best for, 
  #            i.e. one of the following: "heart attack", "heart failure", "pneumonia"
  # num     is an can take values "best", "worst", or an integer indicating the ranking 
  #            (smaller numbers are better).
  # result  is a character vector containing the name of hospital 
  #            from the specified state with the specified rank (num) 
  #            e.g. best (i.e. lowest) 30 day mortality for the specified outcome'
  #
  # initialize result and outcomes allowed 
  result <- NA
  aout   <- c("heart attack", "heart failure", "pneumonia")
  iout   <- c( 11,             17,              23)

  ## Read outcome data
  oo <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  if ((is.element(state, state.abb) ||
       state == "DC"  ||
       state == "GU"  ||
       state == "PR"  ||
       state == "VI") && is.element(outcome, aout)) {
    indx <- iout[match(outcome,aout)]
    #
    # Choose State
    #
    hnam <- oo[,   2][state == oo[,7]]
    hnum <- oo[,indx][state == oo[,7]]
    #
    # Choose only with available data
    #
    hnam1 <- hnam[hnum != "Not Available"]
    hnum1 <- hnum[hnum != "Not Available"]
    
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    #
    # Order alphabetically
    #
    hnam2 <- hnam1[order(hnam1)]
    hnum2 <- as.numeric(hnum1[order(hnam1)])
    #
    # Order alpha now numerically
    #
    hnam3 <- hnam2[order(hnum2)]
    hnum3 <- hnum2[order(hnum2)]
    #
    # Determine what to return
    #
    if (is.numeric(num)) ires = num
    if (num == "best"  ) ires = 1
    if (num == "worst" ) ires = length(hnam3)
    if (is.na(ires)) stop("invalid rank")
    #
    # set result
    #
    result <- hnam3[ires]
    
  } else {
    if (!is.element(state, state.abb) && !is.element(outcome, aout)) stop("invalid state & outcome")
    if (!is.element(state, state.abb))                               stop("invalid state")
    if (!is.element(outcome, aout))                                  stop("invalid outcome")
  } # end if
  #
  # Return result
  #
  result
  
}