require(deSolve)
require(ggplot2)
source("pulse_production.R")
source("aes_ggplot.R")

x0 = 0
tmax = 20
mrna = ode(x0, seq(0,tmax,length.out = 1000), pulse_production)
mrna_df=data.frame(mrna)
colnames(mrna_df) = c("Time","mRNA")

pdf("figlab7_pulse_const.pdf")
ggplot(mrna_df,aes(Time,mRNA)) + 
  geom_line(size=1.5) +
  xlab("Time (hr)") +
  ylab("mRNA (nM)") +
  aes_ggplot
dev.off()
