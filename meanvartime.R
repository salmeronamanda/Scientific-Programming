require(ggplot2)
require(reshape2)
source("run_tumble.R")
source("interp_2D.R")
source("aes_ggplot.R")

# Parameters and constraints
tmax = 100 # Seconds
v = 1 # Microns/sec
currangle = runif(1)*2*pi
tumblerate = 2 # Per sec

sample_1000=matrix(ncol=3)
for(i in 1:1000){
  run = run_tumble(tmax,v,currangle,tumblerate)
  t = run$Time
  Xoft = data.frame(run$X,run$Y)
  sample=cbind(interp_2D(t,Xoft,1:100),1:100)
  sample_1000=rbind(sample_1000,sample)
}
sample_1000=sample_1000[-1,]


stats=sapply(1:100,function(tt){mean_s=mean(sample_1000[sample_1000[,3]==tt,1]); var_s=var(sample_1000[sample_1000[,3]==tt,1]); return(c(mean_s,var_s))})
stats=data.frame(t(stats),1:100)
colnames(stats) = c("Mean","Variance","Time")
stats_df=melt(stats,id.vars = "Time")

pdf("meanvartime.pdf")
ggplot(data=stats_df,aes(Time,value,color=variable)) +
  geom_line(size=standard_linesize) +
  scale_color_manual(values=c("black","gray60")) +
  xlab("Time") +
  ylab("x-position") +
  ylim(-50,50) +
  aes_ggplot +
  theme(legend.title = element_blank(),
        legend.text = element_text(size=22),
        legend.position = c(0.2,0.2),
        legend.key.height = unit(1,"cm"),
        aspect.ratio = 0.8)
dev.off()
