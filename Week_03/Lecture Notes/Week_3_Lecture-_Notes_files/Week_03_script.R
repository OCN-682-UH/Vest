#This is my ggplot2 test script
#Created by: Jordan Vest
#Created on 09_09_25
#Load Libraries 
library(palmerpenguins)
library(tidyverse)
glimpse(penguins)

ggplot(data = penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     color = species,
                     shape = island))+
  geom_point(size = 2, alpha = 0.5)+
  labs(title = "Bills depth and length", 
       subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins", 
  x = "Bill depth (mm)", y = "Bill length (mm)",
color = "Species",
caption = "source: Palmer Station LTER / palmerpenguins package") +
  scale_colour_viridis_d()

  