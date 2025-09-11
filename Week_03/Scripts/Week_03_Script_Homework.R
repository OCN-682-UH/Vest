### Today we are going to plot penguin data for HWST 682 assignment due 2025_09_16 ####
### Created by: Jordan Vest ####################
### Updated on: 2025_09_11 #####################

###Load Libraries ######
library(palmerpenguins)
library(tidyverse)
library(here)
library(praise)
library(ghibli)
library(ggthemes)

### Load data ###
glimpse(penguins)

### Data analysis ###
#I want to plot how penguin flipper lengths might vary across species and islands.
#Using a histogram I can see distribution
ggplot(data = penguins, #Start the ggplot, telling it what dataset to use
       mapping = aes(x = flipper_length_mm, fill = species)) +
  #Mapping is telling ggplot to link a variable to an aesthetic (color, fill, size, etc.)
  #Here, fill = species means 'fill the bars differently depending on which penguin species it is'
    geom_histogram(binwidth = 5,  
  #binwidth = 5 means the x-axis is divided into bins of 5 mm
                   color = "black") +  
  #color = "black" outlines the bars so they are easier to see 
    labs(
    #label the axes
      title = "Distribution of Penguin Flipper Lengths",
      x = "Flipper Length (mm)",
      y = "Number of Penguins",
      fill = "Species"
    ) +
  theme_minimal(base_size = 14)+ 
  #make plot clean and easy to see with preset theme
  scale_fill_ghibli_d("SpiritedMedium", direction = -1) 
  #add some nice colors from library.ghibli

##Plot is okay but it only shows me what the overall species size trends are. 
#I want to plot how penguin flipper lengths might vary across species and islands.
#Adding a facet I can see the islands as separate subplots
ggplot(data = penguins, #Start the ggplot, telling it what data set to use
       mapping = aes(x = flipper_length_mm, fill = species)) +
  #Mapping is telling ggplot to link a variable to an aesthetic (color, fill, size, etc.)
  #Here, fill = species means 'fill the bars differently depending on which penguin species it is'
  geom_histogram(binwidth = 5,  
                 #binwidth = 5 means the x-axis is divided into bins of 5 mm
                 color = "black") +  
  #color = "black" outlines the bars so they are easier to see 
  facet_wrap(~ island) + 
  #Split the data into subplots by island to compare distributions
  labs(
    #label the axes
    title = "Distribution of Penguin Flipper Lengths by Island",
    x = "Flipper Length (mm)",
    y = "Number of Penguins",
    fill = "Species"
  ) +
  theme_minimal(base_size = 14)+ 
  #make plot clean and easy to see with preset theme
  scale_fill_ghibli_d("SpiritedMedium", direction = -1) 
#add some nice colors from library.ghibli

ggsave(here("Week_03","Output","homework.pdf"),
       width = 7, height = 5)