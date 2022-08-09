require(ggplot2)
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

lowdyn = t<1
highdyn = t>1
tlow = t[lowdyn]
ta = tlow[length(tlow)]
thigh = t[highdyn]
tb = thigh[1]
xlow = Xoft[lowdyn,1]
xa = xlow[length(xlow)]
xhigh = Xoft[highdyn,1]
xb = xhigh[1]
deltat = tb-ta
deltax = xb-xa
slope = deltax/deltat
xnew = xa+slope*(1-ta)

df=data.frame("x"=c(xa,xb,xnew), "Time"=c(ta,tb,1),color=c("white","white","black"))

pdf("interp.pdf")
ggplot(df,aes(Time,x)) +
  geom_line(color="gray60",size=standard_linesize) +
  geom_point(aes(fill=color),size=5,shape=21) +
  scale_fill_manual(values = c("white"="white","black"="black"),guide="none") +
  aes_ggplot
dev.off()
