
# makeCacheMatrix() creates a list containing 4 objects, which are functions to: 
# 1. set the the input matrix x
# 2. get the the currently stored matrix
# 3. set the inverse matrix i
# 4. get the inverse matrix   
   
makeCacheMatrix <- function(x = matrix()) {
  i <- NULL
  set <- function(y) {
    x <<- y
    i <<- NULL
  }
  get <- function() x
  setinverse <- function(solve) i <<- solve
  getinverse <- function() i
  list(set = set,
       get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


# cacheSolve calculates the inverse of the matrix x, where x <- makeCacheMatrix(x)
# It will check to see if the inverse i has already been calculated - if(!is.null(i)))
# if i is not NULL (i.e. inverse has already been calculated), it will return the cached inverse
# if i is NULL, it will calculate the inverse and then cache it - x$setinverse(i)
# thus the next time it runs it will not need to calculate and will instead retreive from cache speeding up the operation


cacheSolve <- function(x, ...) {
  i <- x$getinverse()
  if(!is.null(i)) {
    message("getting cached data")
    return(i)
  }
  data <- x$get()
  i <- solve(data, ...)
  x$setinverse(i)
  i
}
