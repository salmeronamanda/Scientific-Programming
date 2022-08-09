require(ggplot2)
require(reshape2)
source("interp_2D.R")
source("aes_ggplot.R")

# Parameters and constraints
tmax = 100 # Seconds
v = 1 # Microns/sec
currangle = runif(1)*2*pi
tumblerate = 2 # Per sec

# Initialize the system
currt = 0
currx = 0
curry = 0
Xoft = matrix(c(currx,curry),ncol=2)
t = 0

# Run and tumble
while (currt<tmax){
  dt = -(1/tumblerate)*log(runif(1)) # Find the next tumble time
  dx = v*cos(currangle)*dt # Advance in the x-direction
  dy = v*sin(currangle)*dt # Advance in the y-direction
  currt = currt+dt
  currx = currx+dx
  curry = curry+dy
  t = c(t,currt) # Store time
  Xoft = rbind(Xoft,c(currx,curry)) # Store position
  currangle = runif(1)*2*pi
}

sample = interp_2D(t,Xoft,1:100)
pdf("sampled_trajectory.pdf")
ggplot() +
  geom_path(aes(t,Xoft[,1]),color="gray60",size=standard_linesize) +
  geom_point(aes(1:100,sample[,1]),color="black",size=standard_pointsize) +
  xlab("Time") +
  ylab("x-position") +
  aes_ggplot
dev.off()

