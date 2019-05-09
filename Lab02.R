library(tidyverse)
library(gganimate)
library(RColorBrewer) # We'll be using this to create a new colour palette later

#setwd()
getwd()

projections <- read.csv("popProjections.csv",sep="\t", stringsAsFactors = F)
projections <- gather(projections,key="Year",value="Population", -Variant)
projections$Year <- parse_number(projections$Year)
projections$Population <- parse_number(projections$Population)

pastData <- read.csv("popHistory.csv",sep="\t")

allData <- rbind(pastData, projections)

ggplot() +
  geom_line(data = allData, aes(x=Year, y=Population, group=Variant, colour=Variant)) +
  labs(y = "Northern Ireland Population") 





