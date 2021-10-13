library(tidyverse)
library(gganimate)

stats <- read.csv("..//..//genderPay//2020//hourlyPayExOvertime.csv")

stats <- stats %>% select(-Median, -AnnualChangeMedian, -Mean, -annualChangeMean, -Code) %>%
  pivot_longer(cols = c("X10","X20","X25","X30","X40","X50","X60","X70","X75","X80","X90"),values_to = "value")

stats <- stats %>% separate(Description, into = c("Gender","Pattern"),sep = " ")
stats$Pattern <- ifelse(is.na(stats$Pattern) & stats$Gender == "All","All",ifelse(
  is.na(stats$Pattern) & stats$Gender %in% c("Full-time","Part-time"),stats$Gender, ifelse(
    is.na(stats$Pattern), "All", stats$Pattern
  )
))

stats$Gender <- ifelse(stats$Gender %in% c("Full-time","Part-time"), "All",stats$Gender)

points <- stats
points$side <- NA
points$cat <- NA

phase1 <- points %>% filter(Gender != "All", Pattern != "All")
phase1$phase <- 1
#phase1$Size <- 4
phase1$side[phase1$Pattern=="Full-time"] <- 1
phase1$cat[phase1$Pattern=="Full-time"] <- "Full-time"
phase1$value[phase1$Pattern=="Full-time" & phase1$Gender == "Female"] <- points %>% 
  filter(name == "X50", Gender == "Female", Pattern == "Full-time") %>% select(value) %>% pull()
phase1$value[phase1$Pattern=="Full-time" & phase1$Gender == "Male"] <- points %>% 
  filter(name == "X50", Gender == "Male", Pattern == "Full-time") %>% select(value) %>% pull()
phase1$side[phase1$Pattern=="Part-time" & phase1$Gender == "Female"] <- 2
phase1$side[phase1$Pattern=="Part-time" & phase1$Gender == "Male"] <- 2.1
phase1$cat[phase1$Pattern=="Part-time" & phase1$Gender == "Female"] <- "Part-time"
phase1$value[phase1$Pattern=="Part-time" & phase1$Gender == "Female"] <- points %>% 
  filter(name == "X50", Gender == "Female", Pattern == "Part-time") %>% select(value) %>% pull()
phase1$value[phase1$Pattern=="Part-time" & phase1$Gender == "Male"] <- points %>% 
  filter(name == "X50", Gender == "Male", Pattern == "Part-time") %>% select(value) %>% pull()

phase2 <- points %>% filter(Gender != "All", Pattern != "All")
phase2$phase <- 2
#phase2$Size <- 3
phase2$side[phase2$Pattern=="Full-time"] <- 1
phase2$side[phase2$Pattern=="Part-time"] <- 2
phase2$cat[phase2$Pattern=="Full-time"] <- "Full-time"
phase2$cat[phase2$Pattern=="Part-time"] <- "Part-time"

phase3 <- points %>% filter(Gender != "All", Pattern != "All")
phase3$phase <- 3
#phase3$Size <- 3
phase3$side[phase3$Gender=="Female"] <- 1
phase3$side[phase3$Gender=="Male"] <- 2
phase3$cat[phase3$Gender=="Female"] <- "Female"
phase3$cat[phase3$Gender=="Male"] <- "Male"

phase4 <- points %>% filter(Gender != "All", Pattern != "All")
phase4$phase <- 4
#phase4$Size <- 4
phase4$side[phase4$Gender=="Female"] <- 1
phase4$value[phase4$Gender=="Female"] <- points %>% filter(name == "X50", Gender == "Female", Pattern == "All") %>% select(value) %>% pull()
phase4$side[phase4$Gender=="Male"] <- 2
phase4$value[phase4$Gender=="Male"] <- points %>% filter(name == "X50", Gender == "Male", Pattern == "All") %>% select(value) %>% pull()
phase4$cat[phase4$Gender=="Female"] <- "Female"
phase4$cat[phase4$Gender=="Male"] <- "Male"

df <- rbind.data.frame(phase1,phase2, phase3, phase4)

g <- ggplot(df, aes(x = side, y = value, color = Gender, size = Number/100)) +
  geom_point() +
  theme_minimal() +
  labs( y = "Hourly pay (excluding overtime)", x = "",
        title = "{ifelse(closest_state < 3, 'Full-time females are paid more than full-time males \n Part-time females are paid more than part-time males',ifelse(closest_state == 3,'Male employees are much less likely to work part-time','Overall, male employees are paid more per hour'))}") +
  scale_x_continuous(breaks = c(0,1,2,3), labels = c("","","",""), 
                     limits = c(0.5,2.5)) +
#  annotate(geom = "text", label =  "{ifelse(closest_state < 3, 'pattern','gender')}", y = 0, x = 1) +
  geom_text(aes(x = side, y = 0, label = cat), color = "black", size = 3) +
  theme(legend.position = "none") +
  transition_states(phase)

animate(g, nframes = 48, fps = 2)

anim_save("..//genderPay.gif")


