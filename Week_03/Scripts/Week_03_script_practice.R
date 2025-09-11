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
#### V1 ####
ggplot(data = penguins, 
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
  scale_x_continuous(limits = c(12,20))+ #set x limits from 12 to 20
  scale_y_continuous(limits = c(30, 50)) #set y limits from  30 to 50
#Note anytime you are make a vector you need to put "c" for "concatenate"

#### V2 ####
ggplot(data = penguins, 
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
  scale_x_continuous(breaks = c(14,17,21),
                     labels = c("low", 'medium','high'))
#Breaks, limits, and label let you visualize in more intuitive ways

#### V3 ####
ggplot(data = penguins, 
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
  scale_color_manual(values = c("orange", "purple", "blue"))
#Manual way to change colors. Preset colors by name already in R. Any HEX code can go here as well

#### V4 ####
ggplot(data = penguins, 
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
  scale_colour_ghibli_d("YesterdayLight", direction = -1)
##Color palettes can be imported by installing 'devtools' package and calling install_gitbub("username/packagename")
#Each README will have instructions for how that color pallette needs to run 

#### V5 ####
ggplot(data = penguins, 
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
  coord_flip() #flip x and y axes

#### V5 ####
ggplot(data = penguins, 
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
  theme_wsj() #ggthemes

#### Diamond dataset ####
ggplot(diamonds, aes(carat, price))+
  geom_point()+
  coord_trans(x= "log10", y= "log10")+
  coord_polar("x")

#### V6 ####
ggplot(data = penguins, 
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
  theme_bw()+ #preset themes
  theme(axis.title = element_text(size = 20,
                                  color = "black"),
        panel.background = element_rect(fill = "linen"))
#layer in what you want to change, the element you want changed, what that change is

#### V7 ####
ggplot(data = penguins, 
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
ggsave(here("Week_03","Scripts","Week_03_script_practice")