# Load necessary libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Read the dataset
data <- read.csv("C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/Dataset/10 years/Rice Cultivation/RiceCultivation_CH4_SECOND.csv")

# Reshape the data for a simple time series plot
time_series_data <- data %>%
  select(Area, starts_with("Y")) %>%
  pivot_longer(cols = starts_with("Y"), 
               names_to = "Year", 
               values_to = "Emissions") %>%
  mutate(Year = as.numeric(sub("Y", "", Year)))  # Convert Year to numeric

# Get unique country names (Areas)
unique_countries <- unique(time_series_data$Area)

# Create a custom color palette dynamically based on the number of countries
custom_colors <- scales::hue_pal()(length(unique_countries))

# Create a named vector for custom colors
names(custom_colors) <- unique_countries

# Create the time series plot with custom colors for each country
p <- ggplot(time_series_data, aes(x = Year, y = Emissions, color = Area)) +
  geom_line(size = 1) +  # Line plot for each country
  geom_point(size = 2) +  # Points on the lines to emphasize data points
  labs(title = "Time Series of CH4 Emissions from Rice Cultivation",
       x = "Year", 
       y = "Emissions (CH4)",
       color = "Country") +
  scale_color_manual(values = custom_colors) +  # Apply custom colors
  theme_minimal() +
  theme(legend.position = "right")

# Save the plot in high resolution (300 DPI)
ggsave("C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/images/RiceCultivation_CH4/CH4_Emissions_2.png", 
       plot = p, 
       width = 10,  # Set width of the image (in inches)
       height = 6,  # Set height of the image (in inches)
       dpi = 300)   # Set resolution to 300 DPI for high quality
