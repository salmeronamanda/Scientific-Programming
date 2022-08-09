interp_2D = function(t,Pos,samplet){
  # function [samplePos] = interp_2D(t,Pos,samplet)
  # Returns sample values for a 2D data in 'pos'
  # given events at time t with values in samplePos
  # which will be resampled at the time values samplet
  samplePos = matrix(0,nrow=length(samplet),ncol=2)
  # Earlier sample points will be set to the initial value
  tmpi=which(samplet<=t[1])
  if (length(tmpi)>0){
    samplePos[tmpi,1]=Pos[1,1]
    samplePos[tmpi,2]=Pos[1,2]
    indmin=which(samplet>t[1],1)
  }else
    indmin=1
  # Later sample points will be sent to the final value
  tmpi=which(samplet>t[length(t)])
  if (length(tmpi)>0){
    samplePos[tmpi,1]=Pos(length(Pos),1)
    samplePos[tmpi,2]=Pos(length(Pos),2)
    indmax=which(samplet>t[length(t)],1)-1
  }else
    indmax=length(samplet)
  
  # Resample the trajectory
  for(jj in indmin:indmax){
    # Define the times
    lowdyn = t<=samplet[jj]
    highdyn = t>samplet[jj]
    tlow = t[lowdyn]
    ta = tlow[length(tlow)]
    thigh = t[highdyn]
    tb = thigh[1]
    # Define the values
    xlow = Pos[lowdyn,1]
    xa = xlow[length(xlow)]
    xhigh = Pos[highdyn,1]
    xb = xhigh[1]
    ylow = Pos[lowdyn,2]
    ya = ylow[length(ylow)]
    yhigh = Pos[highdyn,2]
    yb = yhigh[1]
    # Interpolate
    deltat = tb-ta
    deltax = xb-xa
    slopex = deltax/deltat
    xnew = xa+slopex*(samplet[jj]-ta)
    deltay = yb-ya
    slopey = deltay/deltat
    ynew = ya+slopey*(samplet[jj]-ta)
    samplePos[jj,1] = xnew
    samplePos[jj,2] = ynew
  }
  return(samplePos)
}