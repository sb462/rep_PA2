setwd("~/Coursera/course5/Project2")
fileURL <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
if (!file.exists("stormdata.csv.bz2")){
  download.file(url = fileURL, destfile = "stormdata.csv.bz2" )
  
}
library(data.table)
?read.csv
storm.data <- read.csv("stormdata.csv.bz2",header=TRUE, stringsAsFactors=FALSE)
?read.table
colnames(storm.data)

head(storm.data)
summary(storm.data)
population.damage.data <- aggregate(storm.data, by= list(storm.data$EVTYPE), FUN=sum)
what.type <- as.factor(toupper(storm.data$EVTYPE))
summary(what.type)
levels(what.type)