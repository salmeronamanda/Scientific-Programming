pulse_production = function(t,x,parms){
  alphaval = 1 # Decay rate, hrs-1
  betamax = 5 #Production rate, e.g., nM/hrs
  dxdt = (t<10)*betamax - alphaval*x
  return(list(dxdt))
}