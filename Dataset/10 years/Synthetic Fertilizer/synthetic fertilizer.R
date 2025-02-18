# Load necessary libraries
library(ggplot2)
library(dplyr)
library(tidyr)
library(gganimate)

# Read the dataset
data <- read.csv("C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/Dataset/10 years/Synthetic Fertilizer/LAST 50.csv")

# Reshape data for heatmap
heatmap_data <- data[1:50, ] %>%  # Select first 50 countries
  select(Area, starts_with("Y")) %>%
  pivot_longer(cols = starts_with("Y"), 
               names_to = "Year", 
               values_to = "Emissions") %>%
  mutate(Year = as.numeric(sub("Y", "", Year)))

# Create the heatmap and assign it to a variable
plot <- ggplot(heatmap_data, aes(x = Year, y = Area, fill = Emissions)) +
  geom_tile(color = "white") +
  scale_fill_viridis_c(option = "C", name = "Emissions (kt)") +  # Use a colorblind-friendly palette
  labs(title = "Direct Emissions of N₂O from Synthetic Fertilizers",
       x = "Year",
       y = "Country") +
  theme_minimal() +
  theme(
    axis.line = element_line(size = 1),  # Thicker axis lines
    axis.text = element_text(size = 16),  # Larger axis text
    axis.title = element_text(size = 20),  # Larger axis titles
    plot.title = element_text(size = 32, face = "bold"),  # Larger and bold title
    axis.text.x = element_text(angle = 45, hjust = 1)  # Rotate x-axis labels for better readability
  )

# Animate the heatmap and show all previous years with the current one
animated_plot <- plot + 
  transition_time(Year) +  # Move through the years
  ease_aes('linear') +  # Smooth the animation transition
  labs(title = "Direct Emissions of N₂O from Synthetic Fertilizers: Year {round(frame_time)}") + 
  shadow_mark(past = TRUE)  # Keep previous years visible

# Animate and save the plot
animation_output <- "C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/images/LAST_50_animated.gif"
animate(animated_plot, nframes = 100, fps = 10, width = 1200, height = 800, bg = "transparent")
anim_save(animation_output)

print(paste("Animated chart saved successfully as", animation_output))
