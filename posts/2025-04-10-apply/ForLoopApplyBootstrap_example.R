# Bootstrap mean of petalL

# Using the iris Petal.Length data

petalL <- iris$Petal.Length

# get a sample with replacement

sample( petalL, replace=T )

mean( sample( petalL, replace=T ) )

allmeans <- vector("list", 100)

for ( i in 1:100) {
	
	allmeans[i] <- mean( sample( petalL, replace=T ) ) 
}


allmeans <- vector(length=100)

for ( i in 1:100) {
	
	allmeans[i] <- mean( sample( petalL, replace=T ) ) 
}

## baby steps: take a sample, get the mean

x <- sample(petalL, replace=T)
mean(x)

## use lapply to get 100 samples

lapply( 1:100, sample, x=petalL, replace=T)
samples <- lapply (1:100, sample, x=petalL, replace=T)

## Does this work? What is the problem?

mean(samples)

## samples is a list, so use lapply to get means of each sample. This works:

lapply (samples, mean)

## So save it:

allmeans <- lapply(samples, mean)

## We need two sequential lapply statements, not too bad:

samples <- lapply (1:100, sample, x=petalL, replace=T)
allmeans <- lapply(samples, mean)
head(allmeans)


## Another way is to define the function within lapply:
## Note here that x is just a dummy variable. It takes on a single value of the input list, but we donʻt actually use it

lapply ( 1:100, function(x) { mean(sample( petalL, replace=T))})

## Now try sapply on any/all of the above:

sapply ( 1:100, function(x) { mean(sample( petalL, replace=T))})

## see what they mean about "pretty" output? sapply returns a vector or a matrix if it can

## Back to our confidence interval example:

allmeans <- sapply ( 1:100, function(x) { mean(sample( petalL, replace=T))})

hist(allmeans)

## This is a bit blocky, so letʻs plot more bins:

hist(allmeans, breaks=20)


## The 95% confidence interval is where 95% of the sampled means falls. So if we sort them and draw a line at the 2.5 percentile, and the 97.5 percentile, weʻll see the 95%CI

ss <- sort(allmeans)
ss[3] ## lower 2.5% only 100, so round to 3
ss[97] ## upper 97.5%, round to 97

## you could do more samples to cleanly separate 2.5 and 97.5%

## Plot with bells and whistles
## Plot the true mean of petalL in red, CI in blue
## Add labels to plot
## Arrows to indicate 95% CI
hist(allmeans, breaks=20)

abline( v=mean(petalL), col="red", lwd=3)
abline( v=ss[3], col="blue", lwd=3)
abline( v=ss[97], col="blue", lwd=3)
text(mean(petalL), 10, "True Mean", pos=4, col="red", cex=2)
text(ss[3], 10, "Lower 2.5%", pos=4, col="blue")
text(ss[97], 10, "Upper 97.5%", pos=4, col="blue")
arrows(ss[3], 9.75, ss[97], 9.75, lty=2, code=3, col="blue")
text(mean(petalL), 9.5, "95% CI", col="blue")
## The mean is mean(petalL), and the 95% CI is (ss[3], ss[97])

## We can also plot the "density" of the means using a  
## kernal density method assuming Gaussian kernal densities
## (Normal)
density(allmeans)
lines(density(allmeans))


