mm_dyn = function(t,y,pars){
  # function dydt = mm_dyn(t,y,pars)
  #
  # Simulates a full enzyme kinetics model
  # with parameters stored in pars
  # Assign variables
  S=y[1]; E=y[2]; C=y[3]; P=y[4];
  # Core dynamics
  dydt=rep(0,4)
  dydt[1]=-pars$kplus*S*E+pars$kminus*C
  dydt[2]=-pars$kplus*S*E+pars$kminus*C+pars$kf*C
  dydt[3]= pars$kplus*S*E-(pars$kminus+pars$kf)*C
  dydt[4]= pars$kf*C
  return(list(dydt))
}