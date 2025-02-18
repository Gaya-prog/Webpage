library(ggplot2)
library(dplyr)
library(tidyr)
library(gganimate)

# Load your dataset
data <- read.csv("C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/Dataset/10 years/Production/productionN_total.csv")

# Filter data for the first 50 countries
fourth_50_countries <- unique(data$Area)[1:50]  # Get the first 50 unique countries
data_filtered <- data %>%
  filter(Area %in% fourth_50_countries) %>%  # Keep only the first 50 countries
  filter(Element %in% c("Production", "Import Quantity", "Export Quantity")) %>%
  pivot_longer(cols = starts_with("Y"), names_to = "Year", values_to = "Value") %>%
  mutate(Year = gsub("Y", "", Year))  # Clean year column

# Summarize the data (optional: adjust aggregation as needed)
data_summary <- data_filtered %>%
  group_by(Area, Element, Year) %>%
  summarize(Total = sum(Value, na.rm = TRUE)) %>%
  ungroup()

# Custom dark color palette for the countries
dark_colors <- c("#003366", "#5C4033", "#006400", "#8B0000", "#4B0082", "#FF8C00", "#B8860B", "#008080", 
                 "#A9A9A9", "#008B8B", "#C71585", "#556B2F", "#2F4F4F", "#483D8B", "#191970", "#654321", 
                 "#800000", "#4682B4", "#DC143C", "#2E8B57", "#6B8E23", "#D2691E", "#8B4513", "#B22222", 
                 "#A52A2A", "#D2691E", "#CD853F", "#8B0000", "#556B2F", "#6A5ACD", "#7B68EE", "#708090", 
                 "#8B008B", "#9932CC", "#9400D3", "#800080", "#4B0082", "#2F4F4F", "#696969", "#708090", 
                 "#778899", "#191970", "#000080", "#00008B", "#0000CD", "#0000FF", "#4169E1", "#8A2BE2", "#5F9EA0", "#7FFF00")

country_colors <- setNames(rep(dark_colors, length.out = length(unique(data_summary$Area))), unique(data_summary$Area))

# Create the plot and assign it to the variable plot
plot <- ggplot(data_summary, aes(x = Year, y = Total, fill = Area)) +
  geom_bar(stat = "identity", position = "stack", width = 1) +
  coord_polar(theta = "x") +
  facet_wrap(~ Element, scales = "free_y", ncol = 1) +  # Facet by Element
  scale_fill_manual(values = country_colors) +  # Apply custom colors
  labs(
    title = "Total Nutrient Nitrogen (N) for Production, Import and Export Quantity",
    x = "Year",
    y = "Total Value",
    fill = "Country"
  ) +
  theme_minimal() +
  theme(
    legend.position = "right",  # Move legend to the right
    legend.title = element_text(size = 18),
    legend.text = element_text(size = 16),
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1, size = 12),
    axis.text.y = element_text(size = 16),
    axis.title = element_text(size = 20),
    plot.title = element_text(size = 32, face = "bold"),
    plot.subtitle = element_text(size = 14)
  ) +
  transition_time(as.numeric(Year)) +  # Animate over years
  ease_aes('linear')  # Faster transition

# Animate and save
animated_plot <- animate(plot, nframes = 150, fps = 15, width = 1200, height = 800, bg = "transparent")
anim_save("C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/images/Production/Nutrient_N1.gif", animation = animated_plot)
