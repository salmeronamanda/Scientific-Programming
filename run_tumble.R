run_tumble = function(tmax,v,currangle,tumblerate){
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
  return(list("Time"=t,"X"=Xoft[,1],"Y"=Xoft[,2]))
}