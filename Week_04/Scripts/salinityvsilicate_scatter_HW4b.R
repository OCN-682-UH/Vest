### Today we are going to do an assignment with tidyr and biogeochem sgd data ####
### Created by: Jordan Vest #############
### Updated on: 2025-09-18 ####################
#### Load Libraries ######
library(tidyverse)
library(here)
### Load data ######
ChemData<-read_csv(here("Week_04","data", "chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)

#Clean data
ChemData_clean <- ChemData %>%
  drop_na(-Temp_in) %>%   # remove all NAs in all columns EXCEPT (-) Temp_in
  separate(col = Tide_time,
           into = c("Tide", "Time"), # split tide/time into two columns
           sep = "_",
           remove = FALSE)
glimpse(ChemData_clean)

#Filter subset of Zone to remove "Ambient"
ChemData_subset <- ChemData_clean %>%
  filter(Zone != "Near Spring")
glimpse(ChemData_subset)

#Pivot longer
# gather chemical variables into a long format for flexibility
ChemData_long <- ChemData_subset %>%
  pivot_longer(cols = c(Salinity, pH, Temp_in, TA, NN, Phosphate, Silicate),
               names_to = "Variable",
               values_to = "Value")
glimpse(ChemData_long)
# calculate mean and variance by zone and chemical variables
ChemData_long %>%
  group_by(Zone, Variable) %>%
  summarise(mean_val = mean(Value, na.rm = TRUE),
            var_val = var(Value, na.rm = TRUE),
            .groups = "drop")
glimpse(ChemData_long)

#Plot: scatterplot of Silicate vs Salinity
plot <- ChemData_subset %>%
  ggplot(aes(x = Silicate, y = Temp_in, color = Zone)) +
  geom_point(alpha = 0.7, size = 2) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Relationship between Salinity and Silicate",
       x = "Silicate (µM)",
       y = "Temperature (°C)") +
  theme_minimal() +
  scale_x_log10() + #log scale to pull outliers back
  facet_wrap(~Zone) #see data by Zone
print(plot)
       
#Save Plot
ggsave(here("Week_04", "Outputs", "salinityvsilicate_scatter_HW4b.png"), p, width = 7, height = 5)









