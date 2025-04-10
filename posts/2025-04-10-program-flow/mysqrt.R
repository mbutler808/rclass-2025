# A program for solving square roots numerically following
# the flowchart from the "Fortran Coloring Book"

# Inputs  or starting conditions

x <- 4    # calculate the square root of x 
tol <- 0.001   # within this tolerance
guess <- 10    # initial guess


# Figure out the lines of code we need for the algorithm:

newguess <- (guess + x/guess)/2   # x/guess = approximate sqrt.
error <- abs( x - newguess*newguess ) # how far off are we?
guess <- newguess        # adopt newguess as the current guess
error >= tol         # If true, run through the algorithm again


# A loop that calculates the square root 

while ( error >= tol  )    {   # conditional is error small?
	
  newguess <- (guess + x/guess)/2   # x/guess = approximate sqrt.
  error <- abs( x - newguess*newguess ) # how far off are we?
  guess <- newguess        # adopt newguess as the current guess
}


# Wrap a function around the loop to easily calculate more sqrts

mysqrt <-  function(   x, guess=x/2 ,  tol = 0.00001) {

  while ( error >= tol  )    {   # conditional is error small?
	
      newguess <- (guess + x/guess)/2
      error <- abs( x - newguess*newguess ) 
      guess <- newguess 
# print(guess)
  }

return(guess)
}

mysqrt(9)
mysqrt(10)
mysqrt(395)