### Today we are going to plot penguin data ####
### Created by: Dr. Nyssa Silbiger #############
### Updated on: 2025-09-17 ####################
#### Load Libraries ######

library(palmerpenguins)
library(tidyverse)
library(here)

### Load data ######
# The data is part of the package and is called penguins
glimpse(penguins)

###calculates the mean and variance of body mass by species, island, and sex without any NAs
penguins %>%
  drop_na(island, species, sex, body_mass_g) %>%
  group_by(island, species, sex) %>%
  summarise(
    mean_body_mass = mean(body_mass_g, na.rm = TRUE),
    var_body_mass  = var(body_mass_g, na.rm = TRUE)
  )

###filters out male penguins, then calculates the log body mass
penguins %>%
  drop_na(sex, body_mass_g) %>% #remove missing data
  filter(sex != "male") %>% #let's hear it for the girls
  mutate(log_mass = log(body_mass_g)) %>%
  select(species, island, sex, log_mass) #selects only the columns we want

  
###then use these data to make any plot
(penguins %>%
  drop_na(sex, body_mass_g) %>%
  filter(sex != "male") %>%
  mutate(log_mass = log(body_mass_g)) %>%
  select(species, island, sex, log_mass) %>%
  ggplot(aes(x = species, y = log_mass, fill = island)) + #assign my aes
  geom_boxplot() + #choose a plot
  labs( 
    title = "Female Penguin Body Mass (log scale)",
    subtitle = "Comparisons across species and islands",
    x = "Penguin Species",
    y = "Log Body Mass (grams)",
    fill = "Island"
  ) +
  scale_fill_brewer(palette = "Set2") +  # make it pretty
  theme_bw() +
  theme(
    axis.title = element_text(size = 14, face = "bold"),
    plot.title = element_text(size = 18, face = "bold"),
    legend.position = "top"
    )

  ###save it
ggsave(here("Week_04", "Outputs", "penguin_boxplot.png"))