library(tidyverse)
library(gganimate)
library(gapminder) # This imports 2 datasets, gapminder and country_colors

#setwd("Training")
getwd()

g <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  theme_dark() +
  # Here comes the gganimate specific bits
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  ease_aes('cubic-in-out')

animate(g, fps=3, renderer = gifski_renderer(loop=FALSE), height = 600, width = 600)
anim_save("gapminder.gif")

