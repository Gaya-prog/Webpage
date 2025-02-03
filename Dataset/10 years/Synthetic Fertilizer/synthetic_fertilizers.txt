# Load necessary libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Read the dataset
data <- read.csv("C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/Dataset/10 years/Synthetic Fertilizer/THIRD 50.csv")

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
  labs(title = "Direct Emissions (N20) from Synthetic Fertilizers",
       x = "Year",
       y = "Country") +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 6),  # Adjust font size for better readability
        axis.text.x = element_text(angle = 45, hjust = 1))

# Display plot
print(plot)

# Save the plot as a high-resolution image
output_file <- "C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/images/Synthetic_Fertilizer_heatmap/THIRD 50.png" # Replace with your desired file name
ggsave(output_file, plot = plot, width = 12, height = 8, dpi = 300)

print(paste("Chart saved successfully as", output_file))

