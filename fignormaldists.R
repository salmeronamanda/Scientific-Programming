require(reshape2)
require(ggplot2)
source("aes_ggplot.R")

norm1 = rnorm(10^5)
norm2 = rnorm(10^5)+2
norm3 = 2*rnorm(10^5)

norms_df=melt(data.frame(norm1,norm2,norm3))

pdf("fignormaldists.pdf")
ggplot(norms_df,aes(x=value, color=variable)) +
  geom_freqpoly(bins=200,size=standard_linesize) + 
  scale_color_manual(values = c("black","gray40","gray60")) +
  xlim(-10,10) +
  xlab("Random value") +
  ylab("Histogram") +
  aes_ggplot +
  theme(legend.position = "none")
dev.off()
