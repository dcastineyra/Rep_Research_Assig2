## Reproducible Research
## Project Course 2
## Reading the data
datos<-read.csv(zz<-bzfile("repdata%2FData%2FStormData.bz2"),header=TRUE,sep=",")
library(dplyr)
## Subsetting the data
harmful<-datos[,c("EVTYPE","FATALITIES","INJURIES","PROPDMG","CROPDMG")]
## Getting the total health and economic damage
harmful<-mutate(harmful,health = FATALITIES + INJURIES)
harmful<-mutate(harmful,economic = PROPDMG + CROPDMG)
by_event<-harmful %>% group_by(EVTYPE)
healthdmg<- summarise(by_event,health = sum(health))
hdmg <- data.frame(Event = healthdmg$EVTYPE, Health_DMG = healthdmg$health)
## sorting
hdmg<- hdmg[with(hdmg,order(-Health_DMG)),]
## Top 10 most harmful
top10<-hdmg[1:10,]

par(cex.axis=.5)
plot(top10$Health_DMG,xlab="Event",ylab="Health Damage",main="Top 10 most harmful events (Health)",xaxt="n")
axis(side=1,at=1:10,labels=top10$Event)

## Getting the total property and crop damage by event
ecodmg<- summarise(by_event,economic = sum(economic))
edmg <- data.frame(Event = ecodmg$EVTYPE, Economic_DMG = ecodmg$economic)
##sorting
edmg<- edmg[with(edmg,order(-Economic_DMG)),]
## Getting the top 10 events most harmful with respect to fatalities and injurires
top10e<-head(edmg,n=10L)
top10e

par(cex.axis=.5)
plot(top10e$Economic_DMG,xlab="Event",ylab="Economic Damage",main="Top 10 most harmful events (Economic)",xaxt="n")
axis(side=1,at=1:10,labels=top10e$Event)
