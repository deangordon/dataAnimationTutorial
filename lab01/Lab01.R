library(tidyverse)
library(gganimate)
library(gapminder) # This imports 2 datasets, gapminder and country_colors

#setwd("Training")
getwd() # This checks your working directory

ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, size = pop, colour = country)) +
  geom_point(show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  transition_time(year) # This is the line that defines the animation.





