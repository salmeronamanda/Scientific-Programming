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

xdist100 = sample_1000[sample_1000[,3]==100,1]
meandata = mean(xdist100)
vardata = var(xdist100)
sortxpos=sort(xdist100)
mycdf=(1:length(sortxpos))/length(sortxpos)
normtheory = pnorm(sortxpos,meandata,sqrt(vardata))

pdf("normcdfcompare.pdf")
ggplot() +
  geom_point(aes(sortxpos,mycdf,shape="Data"),color="black",size=standard_pointsize) +
  geom_line(aes(sortxpos,normtheory,linetype="Theory"),color="gray",lwd=standard_linesize) +
  xlab("x-position") +
  ylab("Probability") +
  scale_shape_manual(values=16) + 
  scale_linetype_manual(values="solid")+
  ggtitle("t=100") +
  aes_ggplot +
  theme(legend.title = element_blank(),
        legend.text = element_text(size=15),
        legend.position = c(0.15,0.9))
dev.off()
