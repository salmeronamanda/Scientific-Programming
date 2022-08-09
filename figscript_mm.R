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

# Simulation
y = ode(c(10,1,0,0),0:pars$tf,mm_dyn,pars)
colnames(y) = c("Time","Substrate","E","C","Product")
y_df = melt(as.data.frame(y),id.vars="Time")

pdf("figscript_mm.pdf")
ggplot(y_df[y_df$variable==c("Substrate","Product"),],
       aes(Time,value,linetype=variable)) + 
  geom_line(size=standard_linesize) +
  xlab("Time (sec)") +
  ylab(expr(paste("Concentration ",mu, "M"))) +
  aes_ggplot +
  theme(legend.title = element_blank(),
        legend.text = element_text(size=20),
        legend.key.width = unit(0.5,"in"),
        legend.position = c(0.8,0.5))
dev.off()

