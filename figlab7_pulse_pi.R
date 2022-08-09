require(deSolve)
require(ggplot2)
source("aes_ggplot.R")

x0 = 0
tmax = 20
params =list()
params$alpha=1 # hr^-1
params$beta_mid=5 # nM/hr
params$beta = function(t) (params$beta_mid*(sin(2*pi*t)+1)) # nM/hr

#and then modify the dynamics code to refer to a pre-specified function.
pulse_production = function(t,x,params){
  dxdt = params$beta(t) - params$alpha*x
  return(list(dxdt))
}

mrna = ode(x0,seq(0,tmax,length.out = 1000), pulse_production, params)
mrna_df=data.frame(mrna)
colnames(mrna_df) = c("Time","mRNA")
pdf("figlab7_pulse_pi.pdf")
ggplot(mrna_df,aes(Time,mRNA)) + geom_line(size=1.5) +
  xlab("Time (hr)") +
  ylab("mRNA (nM)") +
  aes_ggplot
dev.off()
