require(ggplot2)
require(reshape2)
source("run_tumble.R")
source("aes_ggplot.R")

# Parameters and constraints
tmax = 100 # Seconds
v = 1 # Microns/sec
currangle = runif(1)*2*pi
tumblerate = 2 # Per sec

# Initialize the system
currt = 0
currx = 0
curry = 0
Xoft = matrix(c(currx,curry),ncol=2)
t = 0

a = replicate(3,run_tumble(tmax,v,currangle,tumblerate))

colnames(a) = c("Run1","Run2","Run3")
Run=list()
for(h in colnames(a)){
  len=length(a[[1,h]])
  Run[[h]]=rep(h,len)
}
a = rbind(a,Run)
a = apply(a,2,function(a){a=data.frame(a); melt(a,measure.vars=c())})
a = rbind(a$Run1,a$Run2,a$Run3)

pdf("figtraject.pdf")
ggplot() + 
  geom_path(data=a,aes(X,Y,color=Run),size=standard_linesize) +
  scale_color_manual(values=c("black","gray50","gray70"),guide="none") +
  aes_ggplot
dev.off()
