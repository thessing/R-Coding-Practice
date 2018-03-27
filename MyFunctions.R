##
## Example
##
## Author - Tim Hessing
##
## Description - This is an example R Function to play with
##
add2 <- function(x,y) {x+y}

above <- function(x,n = 10) {
  # 10 is the defazult for n
  use <- x>n
  x[use]
}

colmean <- function(x, removeNA = TRUE) {
  nc <- ncol(x)
  means <- numeric(nc)
  for (i in 1:nc) {
    means[i] <- mean(x[,i], na.rm = removeNA)
  }
  means
}