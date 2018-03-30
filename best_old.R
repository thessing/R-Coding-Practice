best <- function(state, outcome) {
  #
  # state   is a 2 character abbreviated name for a state to search
  # outcome is a character vector of outcome to find best for, 
  #            i.e. one of the following: "heart attack", "heart failure", "pneumonia"
  # result  is a character vector containing the name of hospital 
  #            from the specified state with best (i.e. lowest)   
  #            30 day mortality for the specified outcome'
  #
  # initialize result, outcomes allowed, hn 
  result <- NA
  aout   <- c("heart attack", "heart failure", "pneumonia")
  iout   <- c( 11,             17,              23)
  hn     <- NA
  
  ## Read outcome data
  oo <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  if ((is.element(state, state.abb) || state == "DC") && is.element(outcome, aout)) {
    indx <- iout[match(outcome,aout)]
    bl   <- Inf
    for (i in 1:nrow(oo)) {
      if (state == oo[i,7]) {
        if (oo[i,indx] != "Not Available") {
          chk <- as.numeric(oo[i,indx])
          if (chk < bl) {
            bl  <- chk
            cnt <- 1
            hn[cnt] <- oo[i,2]
          } else if (chk == bl) {
            cnt <- cnt + 1
            hn[cnt] <- oo[i,2]
          } # end if outcome
        } # end if NA 
      } # end if state
    } # end for
    ## Return hospital name in that state with lowest 30-day death
    ## rate 
    hnn <- sort(hn, partial=1:cnt)
    result <- hnn[1]
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