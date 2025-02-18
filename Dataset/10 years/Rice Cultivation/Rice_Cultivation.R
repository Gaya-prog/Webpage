# Load necessary libraries
library(ggplot2)
library(dplyr)
library(tidyr)
library(gganimate)

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

# Define a custom color palette with dark colors
custom_colors <- c(
  "Dark Blue" = "#003366", 
  "Dark Brown" = "#5C4033", 
  "Dark Green" = "#006400", 
  "Dark Red" = "#8B0000", 
  "Dark Purple" = "#4B0082", 
  "Dark Orange" = "#FF8C00", 
  "Dark Yellow" = "#B8860B", 
  "Dark Teal" = "#008080", 
  "Dark Grey" = "#A9A9A9",
  "Dark Cyan" = "#008B8B", 
  "Dark Pink" = "#C71585", 
  "Dark Olive" = "#556B2F",
  
  # Additional dark colors
  "Dark Indigo" = "#2E1A47", 
  "Dark Magenta" = "#800080", 
  "Dark Charcoal" = "#333333", 
  "Dark Slate Blue" = "#483D8B", 
  "Dark Sea Green" = "#8FBC8F", 
  "Dark Salmon" = "#E9967A", 
  "Dark Orchid" = "#9932CC", 
  "Dark Khaki" = "#BDB76B", 
  "Dark Violet" = "#9400D3", 
  "Dark Coral" = "#FF7F50", 
  "Dark Turquoise" = "#00CED1", 
  "Dark Plum" = "#8E4585", 
  "Dark Chocolate" = "#D2691E", 
  "Dark Sienna" = "#3C1414", 
  "Dark Lime" = "#228B22", 
  "Dark Mint" = "#3EB489", 
  "Dark Mustard" = "#6B8E23", 
  "Dark Copper" = "#7E4B3C", 
  "Dark Periwinkle" = "#6660A1",
  "Dark Rose" = "#C71585",
  
  # Additional 20 dark colors
  "Dark Forest Green" = "#228B22", 
  "Dark Burgundy" = "#800020", 
  "Dark Brass" = "#B5A642", 
  "Dark Asphalt" = "#4C4C4C", 
  "Dark Magenta Pink" = "#8B008B", 
  "Dark Steel Blue" = "#1F3A55", 
  "Dark Peach" = "#D99058", 
  "Dark Charcoal Grey" = "#4F4F4F", 
  "Dark Electric Blue" = "#003B5C", 
  "Dark Blue Green" = "#006F6A", 
  "Dark Amber" = "#BF9B30", 
  "Dark Lime Green" = "#4C9F38", 
  "Dark Violet Red" = "#9B1B30", 
  "Dark Ash" = "#5F5F5F", 
  "Dark Raspberry" = "#9B2D20", 
  "Dark Mustard Yellow" = "#D3B56C", 
  "Dark Aquamarine" = "#7FFFD4", 
  "Dark Greenish Blue" = "#006F72", 
  "Dark Royal Purple" = "#3E1C41", 
  "Dark Goldenrod" = "#B8860B"
)

# If more countries, add darker variants of the same colors or adjust the palette manually
if (length(unique_countries) > length(custom_colors)) {
  additional_colors <- scales::hue_pal()(length(unique_countries) - length(custom_colors))
  custom_colors <- c(custom_colors, additional_colors)
}

# Create a named vector for custom colors
names(custom_colors) <- unique_countries

# Create the time series plot with custom colors for each country
p <- ggplot(time_series_data, aes(x = Year, y = Emissions, color = Area, group = Area)) +
  geom_line(size = 1.5) +  # Thicker line for better visibility
  geom_point(size = 3) +  # Larger points
  labs(title = "Time Series of CH4 Emissions from Rice Cultivation",
       x = "Year", 
       y = "Emissions (CH4)",
       color = "Country") +
  scale_color_manual(values = custom_colors) +  # Apply custom colors
  theme_minimal() +
  theme(
    plot.title = element_text(size = 32, face = "bold"),  # Larger, bold title
    axis.text = element_text(size = 16),  # Larger axis labels
    axis.title = element_text(size = 20),
    legend.title = element_text(size = 18),  # Larger legend title
    legend.text = element_text(size = 16),  # Larger legend labels
    legend.position = "right",
    panel.background = element_blank(),  # Transparent background
    plot.background = element_blank(),  # Transparent background
    plot.margin = margin(20, 20, 20, 20)  # Optional: Adjust plot margins to avoid cutting off labels
  ) +
  transition_reveal(Year)  # Animation over time

# Animate and save
animated_plot <- animate(p, nframes = 300, fps = 10, width = 1200, height = 800, bg = "transparent")
anim_save("C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/images/RiceCultivation_CH4/CH4_Emissions_2.gif", animation = animated_plot)
