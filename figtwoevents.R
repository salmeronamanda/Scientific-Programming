require(ggplot2)
source("aes_ggplot.R")
# Define the sampling
dt = 0.05
t1 = seq(0,5,dt)
t2 = seq(0,5,dt)
tau1 = 1
tau2 = 2

#Define the joint probabilities 
grid = expand.grid(x=t1,y=t2)
p1=exp(-t1/tau1)/tau1
p2=exp(-t2/tau2)/tau2
ptot=exp(-grid$x/tau1)*exp(-grid$y/tau2)
df=data.frame("x"=grid$x,"y"=grid$y,ptot)
#Plot an equal total time to set the axis
# recalling that the implicit dt of the grid is 0.05

pdf("figtwoevents.pdf")
ggplot() + 
  geom_tile(data=df,aes(x=x,y=y,fill=ptot)) +
  scale_fill_gradient(low="black",high="white") +
  geom_line(aes((t1*20)*dt,(100-t1*20)*dt),color="white") + 
  annotate(geom="text",x=2.5+0.1,y=2.5,
           label="t=5.0",color="white",angle=315,family="serif") +
  geom_line(aes((t1*20)*dt,(60-t1*20)*dt),color="white") +
  annotate(geom="text",x=1.5+0.1,y=1.5,
           label="t=3.0",color="white",angle=315,family="serif") +
  geom_line(aes((t1*20)*dt,(30-t1*20)*dt),color="white") +
  annotate(geom="text",x=0.75+0.1,y=0.75,
           label="t=1.5",color="white",angle=315,family="serif") +
  geom_line(aes((t1*20)*dt,(10-t1*20)*dt),color="white") +
  annotate(geom="text",x=0.25+0.1,y=0.25,
           label="t=0.5",color="white",angle=315,family="serif") +
  xlab("Event 1 - time") +
  ylab("Event 2 - time") +
  ggtitle("Probability of event combinations") +
  scale_x_continuous(limits = c(0,5),expand = c(0,0)) +
  scale_y_continuous(limits = c(0,5),expand = c(0,0)) +
  aes_ggplot +
  theme(legend.position = "none")
dev.off()
