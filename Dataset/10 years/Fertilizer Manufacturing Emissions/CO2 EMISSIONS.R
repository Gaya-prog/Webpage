# Load required libraries
library(ggplot2)
library(reshape2)
library(gganimate)
library(colorspace)  # For generating dark color palettes

# Load the data
file_path <- "C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/Dataset/10 years/Fertilizer Manufacturing Emissions/SECOND 40.csv"
data <- read.csv(file_path)

# Reshape data to long format
data_long <- melt(data, id.vars = c("Area", "Item", "Element", "Unit"),
                  variable.name = "Year", value.name = "Emissions")

# Convert year format (e.g., Y2008 -> 2008)
data_long$Year <- as.numeric(sub("Y", "", data_long$Year))

# Replace NA values with 0
data_long$Emissions[is.na(data_long$Emissions)] <- 0

# Generate 40 distinct dark colors using colorspace
num_areas <- length(unique(data_long$Area))
dark_palette <- qualitative_hcl(num_areas, palette = "Dark 3")  # More flexible than RColorBrewer

# Assign colors to each Area
area_colors <- setNames(dark_palette, unique(data_long$Area))

# Plot the animated stacked area chart
plot <- ggplot(data_long, aes(x = Year, y = Emissions, fill = Area)) +
  geom_area(alpha = 0.8, color = "black", linewidth = 0.1) +
  scale_fill_manual(values = area_colors) + 
  labs(title = "Cumulative CO2 Emissions by Region Over Time: {closest_state}",
       x = "Year", y = "CO2 Emissions (kt)") +
  theme_minimal() +
  theme(legend.position = "bottom",
        legend.title = element_blank(),
        panel.grid.major = element_line(linewidth = 0.5, color = "gray"),
        panel.grid.minor = element_blank()) +
  transition_states(Year, transition_length = 2, state_length = 1) +
  ease_aes('cubic-in-out')

# Save the animation
anim_output <- "C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/images/SECOND_40_animation.gif"
animate(plot, duration = 10, fps = 20, width = 800, height = 600, renderer = gifski_renderer(anim_output))

print(paste("Animated chart saved successfully as", anim_output))
