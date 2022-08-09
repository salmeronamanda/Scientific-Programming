cestes_files <- list.files(path = "data/raw/cestes",
                           pattern = "csv$",
                           full.names = TRUE)

cestes_names <- gsub(".csv", "", basename(cestes_files), fixed = TRUE)

# reads community and traits matrix

comm <- read.csv(cestes_files[1], row.names = 1)
head(comm)
rownames(comm) <- paste("Site", 1:nrow(comm))
rownames(comm)

traits <- read.csv(cestes_files[5], row.names = 1)
rownames(traits) #already good!


##

splist <-  read.csv(cestes_files[4])
splist$TaxonName

library(taxize)
classification_data <- classification(splist$TaxonName, db = "ncbi")
str(classification)
length(classification_data)

classification_data$`Arisarum vulgare`
classification_data[[1]]
classification_data[[4]]


library(dplyr)
tible_ex <- classification_data[[1]] %>%
  filter(rank == "family") %>%
  select(name) #returns a data.frame

extract_family <- function(x) {
  if (!is.null(dim(x))) {
  y <- x %>%
    filter(rank == "family") %>%
    pull(name) #returns a data.frame
  return(y)
  }
}
extract_family(classification_data[[1]])
extract_family(classification_data[[4]])
dim(classification_data[[1]])
dim(classification_data[[4]])

families <- vector()
for (i in 1:length(classification_data)) {
  f <- extract_family(classification_data[[i]])
  if (length(f) > 0) families[i] <- f
}
families
###we need a mega tree. APG from Magallón (UNAM)
library(ape)
?`ape-package`
library(phytools)
read.newick()
