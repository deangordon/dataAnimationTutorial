library(tidyverse)
library(gganimate)
library(RColorBrewer)

#setwd()
getwd()

projections <- read.csv("popProjections.csv",sep="\t", stringsAsFactors = F)
projections <- projections %>%
  gather(key="Year",value="Population", -Variant)
projections$Year <- parse_number(projections$Year)
projections$Population <- parse_number(projections$Population)

pastData <- read.csv("popHistory.csv",sep="\t")

allData <- rbind(pastData, projections)

allData$Variant <- ordered(allData$Variant, levels = c("Starting population",
                                                  "Principal projection",
                                                 "Moderately high life expectancy variant", "Moderately low life expectancy variant",
                                                 "High life expectancy variant", "Low life expectancy variant", 
                                                 "High fertility variant", "Low fertility variant", 
                                                 "Northern Ireland medium high migration", "Northern ireland medium low migration",
                                                 "High migration variant", "Low migration variant",
                                                 "High population variant", "Low population variant",
                                                 "Zero net migration variant"))

levels(allData$Variant) <- c("Recent Estimates",
                          "Principal projection",
                          "Moderately high life expectancy", "Moderately low life expectancy",
                          "High life expectancy", "Low life expectancy", 
                          "High fertility", "Low fertility", 
                          "Medium/high migration","Medium/low migration",
                          "High migration", "Low migration",
                          "High population","Low population", 
                          "Zero net migration")


allData <- allData %>%
  arrange(Variant, Year)
allData$order <- seq(1:nrow(allData))

dLast <- allData %>%
  filter(Year == max(Year))

pal <- c("#000000", "#000000",brewer.pal(12,"Paired"),"#DDDDDD") # Add in black colour for recent estiamtes and principle projection. Grey for zero net migration, as it is not paired with another

g <- ggplot() +
  geom_line(data = allData, aes(x=Year, y=Population, group=Variant, colour=Variant), size=ifelse(allData$Variant=="Recent Estimates",2.5,1)) +
  scale_colour_manual(values = pal) +
  theme_light() +
  theme(legend.position="none") +
  scale_x_continuous(expand = expand_scale(add=c(0,28)), minor_breaks=seq(2001,2061,10), breaks=seq(2006,2066,10)) +
  scale_y_continuous(breaks=c(1500000,1750000, 2000000,2250000,2500000), labels = c("1.5M","1.75M","2M","2.25M","2.5M")) +
  labs(y = "Northern Ireland Population") +
  geom_text(data=dLast,aes(x=Year,y=Population, label=Variant, group=Variant), hjust=0) +
  transition_reveal(order) 

animate(g, fps=3, renderer = gifski_renderer(loop=FALSE), height = 800, width = 800)
anim_save("popProjections.gif")

