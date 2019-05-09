#https://stackoverflow.com/questions/53162821/animated-sorted-bar-chart-with-bars-overtaking-each-other/53163549#53163549

library(tidyverse)
library(gganimate)

gva <- read.csv("gva.csv",sep="\t", stringsAsFactors = FALSE)
gva <- gva %>%
  gather(key="Year", value="value", -SIC07.description)

gva$Year <- parse_number(gva$Year)
gva$value <- parse_number(gva$value)

gva <- gva %>%
  group_by(Year) %>%
  # The * 1.0 makes it possible to have non-integer ranks while sliding
  mutate(rank = min_rank(-value) * 1.0 ) %>%
  filter(rank <= 20)

gva14 <- gva %>%
  filter(Year==2014)

interesting <- c("Wholesale and retail trade; repair of motor vehicles","Manufacture of food, beverages and tobacco","Accommodation and food service activities")

p <- ggplot(gva, aes(x = rank, fill = as.factor(SIC07.description))) +
  geom_col(aes(y = value)) +
  coord_flip(clip="off",expand=FALSE) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_reverse() +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0, size = 22),
        plot.margin = margin(1,1,1,9, "cm"),
        legend.position="none",
        axis.ticks.y = element_blank(),  # These relate to the axes post-flip
        axis.text.y  = element_blank()) +  # These relate to the axes post-flip) 
  geom_text(aes(y = 0, label = paste(SIC07.description, " ")), vjust = 0.2, hjust=1, color = ifelse(gva$SIC07.description %in% interesting,"black","grey")) +
    labs(title='{closest_state}', x = "", y = "Chained volume in 2016 £million") +
  
  transition_states(Year, transition_length = 3, state_length = 1, wrap=FALSE) +
  ease_aes('cubic-in-out')

animate(p, fps = 10, duration = 20, width = 800, height = 600)
anim_save("gva.gif")
