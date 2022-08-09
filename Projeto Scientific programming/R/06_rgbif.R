## install.packages("rgbif")
## install.packages("Taxonstand")
## install.packages("CoordinateCleaner")
## install.packages("maps")


## loading pkg
library(rgbif)
library(Taxonstand)
library(CoordinateCleaner)
library(maps)


## occs
library(rgbif)
library(dplyr)
species <- "Myrsine coriacea"
occs <- occ_search(scientificName = species,
                   limit = 100000,
                   basisOfRecord = "PRESERVED_SPECIMEN")
names(occs)


## create
myrsine.data <- occs$data


## colnames(myrsine.data)


## save-raw-
dir.create("data/raw/", recursive = TRUE)
write.csv(myrsine.data,
          "data/raw/myrsine_data.csv",
          row.names = FALSE)


## sp-name
sort(unique(myrsine.data$scientificName))


## sp-accepted-
table(myrsine.data$taxonomicStatus)


## names-accepted-
table(myrsine.data$scientificName, myrsine.data$taxonomicStatus)


## taxonstand-
species.names <- unique(myrsine.data$scientificName)
dim(species.names)
tax.check <- TPL(species.names)


## tax-out
tax.check


## merge
# creating new object w/ original and new names after TPL
new.tax <- data.frame(scientificName = species.names,
                      genus.new.TPL = tax.check$New.Genus,
                      species.new.TPL = tax.check$New.Species,
                      status.TPL = tax.check$Taxonomic.status,
                      scientificName.new.TPL = paste(tax.check$New.Genus,
                                                     tax.check$New.Species))
# now we are merging raw data and checked data
myrsine.new.tax <- merge(myrsine.data, new.tax, by = "scientificName")


## -save
dir.create("data/processed/", recursive = TRUE)
write.csv(myrsine.new.tax,
          "data/processed/data_taxonomy_check.csv",
          row.names = FALSE)


## -maps
plot(decimalLatitude ~ decimalLongitude, data = myrsine.data, asp = 1)
map(, , , add = TRUE)


## coord-prep
myrsine.coord <- myrsine.data[!is.na(myrsine.data$decimalLatitude)
                              & !is.na(myrsine.data$decimalLongitude),]


## coord-clean
# output w/ only potential correct coordinates
geo.clean <- clean_coordinates(x = myrsine.coord,
                               lon = "decimalLongitude",
                               lat = "decimalLatitude",
                               species = "species",
                               value = "clean")
table(myrsine.coord$country)
table(geo.clean$country)


## map-plot-
par(mfrow = c(1, 2))
plot(decimalLatitude ~ decimalLongitude, data = myrsine.data, asp = 1)
map(, , , add = TRUE)
plot(decimalLatitude ~ decimalLongitude, data = geo.clean, asp = 1)
map(, , , add = TRUE)
par(mfrow = c(1, 1))


## coord-clean-2
myrsine.new.geo <- clean_coordinates(x = myrsine.coord,
                                     lon = "decimalLongitude",
                                     lat = "decimalLatitude",
                                     species = "species",
                                     value = "spatialvalid")
table(myrsine.new.geo$.summary)
tail(names(myrsine.new.geo))


## -
# merging w/ original data
dim(myrsine.data)
dim(myrsine.new.geo)
myrsine.new.geo2 <- merge(myrsine.data, myrsine.new.geo,
                          all.x = TRUE)
dim(myrsine.new.geo2)
full_join(myrsine.data, myrsine.new.geo)


## geoclean-

plot(decimalLatitude ~ decimalLongitude, data = myrsine.new.geo2, asp = 1,
     col = if_else(myrsine.new.geo2$.summary, "green", "red"))
map(, , , add = TRUE)



## -write the new coordinate check

write.csv(myrsine.new.geo2,
          "data/processed/myrsine_coordinate_check.csv",
          row.names = FALSE)
