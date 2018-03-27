## Put comments here that give an overall description of what your
## functions do

## Function to create special matrix to cache inverse, which creates list containing functions to
#
#    - set matrix
#    - get matrix
#    - set inverse of matrix
#    - get inverse of matrix

makeCacheMatrix <- function(x = matrix()) {
  im   <- NULL
  setm <- function(y) {
    x  <<- y
    im <<- NULL
  }
  getm <- function() x
  setinvm <- function(invm) im <<- invm
  getinvm <- function() im
  list(setm = setm, getm = getm,
       setinvm = setinvm,
       getinvm = getinvm)
}


## Funcaton calculate inverse of matrics and cachesd it using special matrix from above

cacheSolve <- function(x, ...) {
  im <- x$getinvm()
  if(!is.null(im)) {
    message("getting cached data")
    return(im)
  }
  data <- x$getm()
  im <- solve(data, ...)
  x$setinvm(im)
  im
}
