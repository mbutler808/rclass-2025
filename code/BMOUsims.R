### R code from vignette source 'BMOUsims.Rnw'

###################################################
### code chunk number 1: BMOUsims.Rnw:3-4
###################################################
options(width=80)


###################################################
### code chunk number 2: BMOUsims.Rnw:29-30 (eval = FALSE)
###################################################
##    x[i+1] <- x[i] + devs[i]


###################################################
### code chunk number 3: BMOUsims.Rnw:34-36
###################################################
ngens = 100       # number of generations in our simulation
devs =rnorm(ngens)    # 100 draws from a normal distribution or ``deviates"


###################################################
### code chunk number 4: devs
###################################################
x <- c(0:100)    # initialize x (create a vector of the appropriate length), our phenotype

for (i in 1:ngens)    # a loop which will run ngens times, each time increasing the value of i by one 
{
   x[i+1] <- x[i] + devs[i]
}


###################################################
### code chunk number 5: BMOUsims.Rnw:50-51
###################################################
x      # take a look at the values of x, this is how x changes each generation


###################################################
### code chunk number 6: BMOUsims.Rnw:55-66
###################################################
plot(1:length(devs), devs, type = "n", col="red", 
ylim = c(-max(devs)*30, max(devs)*30), 
xlab="Time", ylab="Value", main="BM Simulation")  

x <- c(0:100)

for (i in 1:ngens) 
{
   x[i+1] <- x[i] + devs[i]
   lines(i:(i+1), x[i:(i+1)], col="red")     # plotting the simulation      
}


###################################################
### code chunk number 7: BMOUsims.Rnw:71-72 (eval = FALSE)
###################################################
##    x[i+1] <- x[i] + sigma * devs[i]


###################################################
### code chunk number 8: BMOUsims.Rnw:76-93
###################################################
bm.plot <- function( sigma=1, ngens=100, nwalks=30, yylim=c(-50, 50) )
{
    plot(1:length(devs), devs, type = "n", col="red", ylim = yylim, 
     xlab="Time", ylab="Value", main="BM Simulation")

    for (i in 1:nwalks)       # number of lineages to simulate
    {
        x <- c(0:ngens)
        devs =rnorm(ngens)    # draws from a normal distribution, one per generation
        for (i in 1:ngens) 
        {
           x[i+1] <- x[i] + sigma*devs[i]     # BM equation   
          	# step through time, increasing x a little bit each time
           lines(i:(i+1), x[i:(i+1)], col="red")   # plot line segment
        }
    }    
}


###################################################
### code chunk number 9: BMOUsims.Rnw:97-98
###################################################
bm.plot()


###################################################
### code chunk number 10: BMOUsims.Rnw:108-128
###################################################
bm.plot <- function( sigma=1, ngens=100, nwalks=30, yylim=c(-30, 30) )
{
    plot(1:length(devs), devs, type = "n", col="red", ylim = yylim,  
    xlab="Time", ylab="Value", main="BM Simulation")
    xfinal <- c(1:nwalks)      ### initialize xfinal

    for (j in 1:nwalks)      
    {
        x <- c(0:ngens)
        devs =rnorm(ngens)    
        for (i in 1:ngens) 
        {
           x[i+1] <- x[i] + sigma*devs[i]     # BM equation   
          	# step through time, increasing x a little bit each time
           lines(i:(i+1), x[i:(i+1)], col="red")   # plot line segment
        }
        xfinal[j] <- x[ngens+1]       ### collect the last value at each lineage
    }    
    return(xfinal)          ### return the final values
}


###################################################
### code chunk number 11: BMOUsims.Rnw:146-148 (eval = FALSE)
###################################################
##     sigma=1
##     cumsum(rnorm(ngens, sd=sigma)) 


###################################################
### code chunk number 12: BMOUsims.Rnw:152-154 (eval = FALSE)
###################################################
##     y <- c(0, cumsum(rnorm(ngens, sd=sigma)) )
##     lines(0:ngens, y)


###################################################
### code chunk number 13: BMOUsims.Rnw:158-160 (eval = FALSE)
###################################################
##    sigma=1
##    lines(0:ngens, c(0, cumsum(rnorm(ngens, sd=sigma))))


###################################################
### code chunk number 14: BMOUsims.Rnw:164-174 (eval = FALSE)
###################################################
## bm.plot <- function( sigma=1, ngens=100, nwalks=30, yylim=c(-50, 50))
## {
## # Set up plotting environment
## 	plot(0, 0, type = "n", xlab = "Time", ylab = "Trait", 
## 		xlim=c(0, ngens), ylim=yylim)
## 
## # Draw random deviates and plot
## 	lapply( 1:nwalks, function(x) 
## 	  lines(0:ngens, c(0, cumsum(rnorm(ngens, sd=sigma)))))
## }


###################################################
### code chunk number 15: BMOUsims.Rnw:201-202 (eval = FALSE)
###################################################
##         x[i+1] = alpha*(theta-x[i])+x[i] + sigma*devs[i]


###################################################
### code chunk number 16: BMOUsims.Rnw:207-227
###################################################
ou.plot <- function( alpha=0.005, theta=0, sigma=1, ngens=100, nwalks=30, 
yylim=c(-30, 30) )
{
    plot(1:length(devs), devs, type = "n", col="red",  ylim = yylim, 
    xlab="Time", ylab="Value", main="OU Simulation")
    xfinal <- c(1:nwalks)     

    for (j in 1:nwalks)       # number of lineages to simulate
    {
	x <- c(0:ngens)
	devs =rnorm(ngens)    
	for (i in 1:ngens) 
	{
            x[(i+1)] = alpha*(theta-x[i])+x[i] + sigma*devs[i]    # OU eq  
            lines(i:(i+1), x[i:(i+1)], col="red")   # plot line segment
	}
        xfinal[j] <- x[ngens+1]   ## collect last value at each lineage
    }    
    return(xfinal)          ### return the final values
}    


###################################################
### code chunk number 17: BMOUsims.Rnw:231-232
###################################################
ou.plot( theta=30 )


###################################################
### code chunk number 18: BMOUsims.Rnw:263-264
###################################################
source("OU.sim.branch.R")


###################################################
### code chunk number 19: BMOUsims.Rnw:268-269 (eval = FALSE)
###################################################
## OU.sim.branch


###################################################
### code chunk number 20: BMOUsims.Rnw:290-305 (eval = FALSE)
###################################################
## ngens=100
## nwalks=30
## sigma=1
## sims <- sapply(1:nwalks, function(x) c(0, cumsum(rnorm(ngens, sd=sigma))))
## yylim <- c(-30, 30)
## 
## png(filename="movies/Rplot%03d.png")  
##               # turn on png graphical device (write to file)
## for (i in 2:nwalks)
## {
## 	plot(0, 0, type = "n", xlab = "Time", ylab = "Trait", 
## 	xlim=c(0, ngens), ylim=yylim)
## 	apply( sims[,1:i], 2 , function(x) lines(0:ngens, x, col="red"))
## }
## dev.off()      # turn off png


