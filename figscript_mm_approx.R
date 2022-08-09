require(deSolve)
require(ggplot2)
require(reshape2)
source("mm_dyn.R")
source("aes_ggplot.R")

# Parameters - uM and sec units
pars=list()
pars$kplus=0.1
pars$kminus=100
pars$Km=pars$kminus/pars$kplus
pars$kf=1
pars$tf=3600
pars$dt=1
y0=c(10,1,0,0)

# Simulation
y = ode(y0,0:pars$tf,mm_dyn,pars)
colnames(y) = c("Time","S","E","C","P")
#y_df = melt(as.data.frame(y),id.vars="Time")

# Compare and contrast the derivatives
dpdt_real = cbind(y[-nrow(y),"Time"],(y[-1,"P"]-y[-nrow(y),"P"])/pars$dt)
colnames(dpdt_real) = c("Time","dpdt")
dpdt_real=data.frame(dpdt_real)
dpdt_approx = cbind(y[-nrow(y),"Time"],pars$kf*y0[2]*y[-nrow(y),"S"]/(pars$Km+y[-nrow(y),"S"]))
colnames(dpdt_approx) = c("Time","dpdt")
dpdt_approx= data.frame(dpdt_approx)




pdf("figscript_mm_approx.pdf")
ggplot() + 
  geom_line(data=dpdt_real,
            aes(Time,dpdt,linetype="dP/dt"),size=standard_linesize,col="black") +
  geom_point(data=dpdt_approx[!dpdt_approx$Time%%200,],
             aes(Time,dpdt,shape="MM approximation"),color="gray40",size=4) +
  xlab("Time (sec)") +
  ylab(expression(paste("Product generation, ",italic("dP/dt")))) +
  scale_linetype_discrete(labels=expression(frac(paste("d",italic("P(t)")),italic("dt")))) +
  aes_ggplot +
  theme(legend.title = element_blank(),
        legend.text = element_text(size=20),
        legend.position = c(0.7,0.8))
dev.off()
