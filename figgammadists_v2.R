require(ggplot2)
require(reshape2)
source("aes_ggplot.R")

exp1 = rexp(10^5,1/3)
exp2a = rexp(10^5,1/1.5)
exp2b = rexp(10^5,1/1.5)
exp12 = exp2a+exp2b
exps_df=melt(data.frame(exp1,exp12))

pdf("figgammadists_v2.pdf")
ggplot(exps_df,aes(x=value, color=variable)) +
  geom_freqpoly(bins=200,size=1.5) + 
  scale_color_manual(values = c("black","gray60"),
                     labels= c("Single random value", "Sum of two exponentials"))+
  scale_x_continuous(limits = c(0.1,20),expand = c(0,0)) +
  xlab("Random value") +
  ylab("Histogram") +
  aes_ggplot +
  theme(legend.title = element_blank(),
        legend.text = element_text(size=15),
        legend.position = c(0.75,0.85))
dev.off()

