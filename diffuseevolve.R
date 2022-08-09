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

sub_sample = sample_1000[sample_1000[,3]%in%c(10,30,100),c(1,3)]
colnames(sub_sample) = c("x","Time")
sub_sample = data.frame(sub_sample)
sub_sample$Time = as.character(sub_sample$Time)

pdf("diffuseevolve.pdf")
ggplot(data=sub_sample,aes(x,color=Time)) + 
  geom_freqpoly(size=standard_linesize,bins=25) +
  ylab("Histogram") +
  xlab("x-position") +
  scale_color_manual(values=c("10"="black","30"="gray50","100"="gray70")) +
  aes_ggplot +
  theme(legend.position = c(0.9,0.9),
        legend.text = element_text(size=15),
        legend.title = element_text(size=15))
dev.off()
