rm(list=setdiff(ls(), "storm.data"))
colnames(storm.data)
#lets first clean up the data and pick the necessary column only.
#step1 reduce number of levels of EVTYPE by changing all to upper case
storm.data$EVTYPE <- as.character(toupper(storm.data$EVTYPE))
# remove all parentheses in EVTYPE
storm.data$EV.TYPE <- gsub("\\(.*","",storm.data$EVTYPE )
nlevels(as.factor(storm.data$EV.TYPE))
