### Today we are going to plot penguin data ####
### Created by: Jordan Vest ####################
### Updated on: 2025_09_11 #####################



###Load Libraries ######
library(palmerpenguins)
library(tidyverse)
library(here)
library(praise)
library(beyonce)
library(ggthemes)


### Load data)

glimpse(penguins)


## data analysis section ###
plot1<-ggplot(data = penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species, 
                     color = species))+
  geom_point()+
  geom_smooth(method = "lm")+
  labs(x = "Bill depth (mm)",
       y = "Bill length (mm)"
  )+
  scale_color_viridis_d()+
  scale_colour_ghibli_d("YesterdayLight", direction = -1)+
  coord_fixed(ratio= 0.5)+ #fix axes
  theme_bw()+
  theme(legend.text = element_text(size = 15))

ggsave(here("Week_03","Output","penguin.pdf"),
       width = 7, height = 5)

plot1