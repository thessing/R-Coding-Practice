rankall <- function(outcome, num = "best") {
  #
  # outcome is a character vector of outcome to find best for, 
  #            i.e. one of the following: "heart attack", "heart failure", "pneumonia"
  # num     is an can take values "best", "worst", or an integer indicating the ranking 
  #            (smaller numbers are better).
  # result  is a character vector containing the name of hospital 
  #            from the specified state with the specified rank (num) 
  #            e.g. best (i.e. lowest) 30 day mortality for the specified outcome'
  #
  # initialize result. outcomes allowed and state list (including DC, Guam, Virgin Island, Puerto Rico)
  result   <- NA
  aout     <- c("heart attack", "heart failure", "pneumonia")
  iout     <- c( 11,             17,              23)
  state    <- sort(c(state.abb, "DC", "GU", "PR", "VI"))
  hospital <- NA
  
  ## Read outcome data
  oo <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check outcome is valid
  if (is.element(outcome, aout)) {
    indx <- iout[match(outcome,aout)]
    
    ## For each state, find the hospital of the given rank
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    #
    # for each State & DC
    #
    for(ist in 1:length(state)) {
      #
      # Get Each State
      #
      hnam <- oo[,   2][state[ist] == oo[,7]]
      hnum <- oo[,indx][state[ist] == oo[,7]]
      #
      # Choose only with available data
      #
      hnam1 <- hnam[hnum != "Not Available"]
      hnum1 <- hnum[hnum != "Not Available"]
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
      # set host
      #
      hospital[ist] <- hnam3[ires]
    } # end state for


    #
    # set result
    #
    result <- data.frame(hospital,state)
    
  } else {
    if (!is.element(outcome, aout))                                  stop("invalid outcome")
  } # end if
  #
  # Return result
  #
  result
  
}