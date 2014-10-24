setwd("~/Coursera/course5/Project2")
fileURL <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
if (!file.exists("stormdata.csv.bz2")){
  download.file(url = fileURL, destfile = "stormdata.csv.bz2" )
  
}
library(data.table)
?read.csv
storm.data <- read.csv("stormdata.csv.bz2",header=TRUE, sep = ",",stringsAsFactors=FALSE,strip.white=TRUE)
?read.table
colnames(storm.data)

head(storm.data)
summary(storm.data)
population.damage.data <- aggregate(storm.data, by= list(storm.data$EVTYPE), FUN=sum)
what.type <- as.factor(toupper(storm.data$EVTYPE))
summary(what.type)
nlevels(what.type)
rm(noaa_evtype)
noaa.evtype <- toupper(c("Astronomical Low Tide", "Avalanche", "Blizzard", 
               "Coastal Flood", "Cold/Wind Chill", "Debris Flow", "Dense Fog", 
               "Dense Smoke", "Drought", "Dust Devil", "Dust Storm", "Excessive Heat", 
               "Extreme Cold/Wind Chill", "Flash Flood", "Flood", "Frost/Freeze", "Funnel Cloud", 
               "Freezing Fog", "Hail", "Heat", "Heavy Rain", "Heavy Snow", "High Surf", "High Wind", 
               "Hurricane (Typhoon)", "Ice Storm", "Lake-Effect Snow", "Lakeshore Flood", "Lightning", 
               "Marine Hail", "Marine High Wind", "Marine Strong Wind", "Marine Thunderstorm Wind", 
               "Rip Current", "Seiche", "Sleet", "Storm Surge/Tide", "Strong Wind", "Thunderstorm Wind", 
               "Tornado", "Tropical Depression", "Tropical Storm", "Tsunami", "Volcanic Ash", 
               "Waterspout", "Wildfire", "Winter Storm", "Winter Weather"))
evtype.data <- as.character(toupper(storm.data$EVTYPE))

?amatch
library(stringdist)
?amatch
match.evtype <- amatch(evtype.data, noaa.evtype, nomatch =0)
match.evtype1 <- as.numeric(amatch(evtype.data[1], noaa.evtype, nomatch =0))

nlevels(as.factor(match.evtype))
?which
nomatch.evtype = which(match.evtype==0)
# if match.evtype =0, return original, else return noaa.evtype

match.it <- function(x){
  y <- as.numeric(amatch(x,noaa.evtype, nomatch =0))
  if(!(y==0)){
    return(noaa.evtype[y])
  }
    else{
      return(x)
    }
  
}
?sapply
matched.evtype <- vapply(evtype.data, FUN=match.it,character(1) )
levels(as.factor(matched.evtype))

levels(as.factor(evtype.data))

rm(match.evtype,match.evtype1,matched.evtype,nomatch.evtype,what.type)
g<- unlist(strsplit(noaa.evtype[1], split = " "))

# divide noaa types into single and multiple 
?gsub
noaa.evtype <- gsub("/", " ",noaa.evtype)
noaa.single.evtype <- noaa.evtype[!grepl(" ",noaa.evtype)]
noaa.multi.evtype <- noaa.evtype[grepl(" ",noaa.evtype)]


?agrepl

x <- c("b a d", "d g b a", "d c g a")
g <- "a b"

?Map
all(unlist(strsplit(g, " "))%in% unlist(strsplit(x[1], " ")))

sub.func <- function(x,y){
  
  if(all(unlist(strsplit(x, " "))%in% unlist(strsplit(y, " ")))){
    return(x)
  }
  else{
    return(y)
  }
}

(all(unlist(strsplit(find, " "))%in% unlist(strsplit(vals, " "))))

myList1 <- c("a ", "c d", "e f")
myList2 <- c("a 1", " b a d", "d", "e f g h", "2 3 a c d", "c g")
?grep
Reduce(function(vals, find) {vals[agrep(find,vals, max.distance=0.1)]<-find; vals}, myList1, myList2)

rm(match.evtype)

match.evtype <- Reduce(function(vals, find) {vals[agrep(find,vals, max.distance=0.1)]<-find; vals}, 
                       noaa.multi.evtype, evtype.data)

evtype.noflood <- noaa.single.evtype[-c(4)]
print(evtype.noflood)

match2.evtype <- Reduce(function(vals, find) {vals[agrep(find,vals, max.distance=0.1)]<-find; vals}, 
                        evtype.noflood, match.evtype)

print(noaa.single.evtype)

nlevels(as.factor(match2.evtype))

levels(as.factor(match2.evtype))

colnames(storm.data)
levels(as.factor(storm.data$PROPDMGEXP))
levels(as.factor(storm.data$CROPDMGEXP))
