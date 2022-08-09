install.packages("vegan")
comm <- read.csv("data/raw/cestes/comm.csv")
dim(comm)
head(comm[,1:6])

#five most abundant species
comm_sorted <- sort(colSums(comm), decreasing=TRUE)
comm_sorted[2:6]

#richness
boolean_comm <- comm != 0
comm$number_of_species = rowSums(boolean_comm != 0)-1
library(ggplot2)
ggplot(data=comm, aes(x=Sites,y=number_of_species)) +
  geom_bar(stat="identity")

#most abundant specie in each site
comm_sitesp <- subset(comm, select = -Sites)
for (i in 1:length(comm_sitesp)){
  max(comm_sitesp[i,])
  spmost <-  which (comm_sitesp[i,] == max (comm_sitesp[i,]))
  print(spmost)

}

