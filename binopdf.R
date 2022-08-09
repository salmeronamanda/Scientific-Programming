require(ggplot2)
require(reshape2)
source("randi_wheel.R")
source("aes_ggplot.R")

#Challenge Problem
N=15
p=0.5
xsupp = 0:N
mypdf = dbinom(xsupp,N,p)
# Simulate the ensemble
nvals=0:N # The actual support of the pdf
totruns = 10^4
rand_builtin = rbinom(totruns,N,p)
randbino = replicate(totruns,randi_wheel(mypdf))

rands=data.frame("rbinom"=rand_builtin,"Sim"=randbino)
rands_df=melt(rands)
mypdf=data.frame(nvals,mypdf,"variable"=rep("Theory",16))

pdf("binopdf.pdf")
ggplot(rands_df,aes(x=value, y=after_stat(density), color=variable,linetype=variable, shape=variable)) +
  geom_freqpoly(bins=N+1) + 
  geom_point(stat="bin",bins=N+1,size=5) + 
  geom_point(data=mypdf,aes(x=nvals,y=mypdf),size=5) +
  scale_linetype_manual(values=c("blank","blank","blank")) +
  scale_shape_manual(values=c(16,16,16)) +
  scale_color_manual(values = c("black","gray50","gray70")) +
  xlab("Number of heads") +
  ylab("Probability") +
  ylim(0,0.3) +
  aes_ggplot +
  theme(legend.title = element_blank(),
        legend.text = element_text(size=18),
        legend.position = c(0.85,0.8))
dev.off()

