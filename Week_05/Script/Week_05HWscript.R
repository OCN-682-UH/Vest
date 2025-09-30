title: "Week_05HWscript"
author: "Jordan Vest"
date: "2025-09-29"

# Packages
library(tidyverse)
library(here)
library(lubridate)

# Read in conductivity and depth data separately
CondData <- read_csv(here("Week_05","Data","CondData.csv"))
DepthData <- read_csv(here("Week_05","Data","DepthData.csv"))

# Process and join into one dataframe
FullData_minute <- CondData %>%
  mutate(
    date = mdy_hms(date), #CondData has MM/DD/YYYY format
    date = round_date(date, unit = "10s") #round to 10s
  ) %>%
  inner_join(
    DepthData %>%
      mutate(date = ymd_hms(date)),#DepthData has YYYY-MM-DD format
    by = "date"
  ) %>%
  mutate(
    minute = floor_date(date, "minute") #bin into minutes
  ) %>%
  group_by(minute) %>%
  summarise(
    avg_depth = mean(Depth, na.rm = TRUE),
    avg_temp  = mean(Temperature, na.rm = TRUE),
    avg_sal   = mean(Salinity, na.rm = TRUE),
    .groups = "drop"
  )
# Plot
ggplot(FullData_minute, aes(x = avg_temp, y = avg_depth)) +
  geom_point() +
  labs(
    x = "Average Temperature (°C)",
    y = "Average Depth (m)",
    title = "Temperature vs Depth (averaged by minute)"
  ) +
  theme_minimal()

#Save the work
# Save the averaged data to a CSV
write_csv(FullData_minute, here("Week_05","Outputs","HW5_FullData_minute.csv"))

# Save the plot to a PNG file
ggsave(
  filename = here("Week_05","Outputs","HW5_Temp_vs_Depth.png"),
  width = 6, height = 4, dpi = 300
)


                   