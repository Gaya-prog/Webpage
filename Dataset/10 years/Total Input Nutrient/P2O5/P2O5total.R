# Load necessary library
library(ggplot2)
library(tidyr)
library(RColorBrewer)

# Read the data
data <- read.csv("C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/Dataset/10 years/FilteredData_Min9Years_P2O5total.csv")

# Step 1: Calculate average usage per country across all years
data$Average <- rowMeans(data[, grep("^Y20", colnames(data))])

# Step 2: Filter top 10 countries based on average usage
top_countries <- data[order(-data$Average), ][1:10, ]

# Step 3: Reshape the data to long format for plotting
data_long <- pivot_longer(top_countries, cols = starts_with("Y20"), 
                          names_to = "Year", values_to = "Usage")

# Convert years to a factor (this prevents fractional representations on the x-axis)
data_long$Year <- factor(gsub("Y", "", data_long$Year))

# Define custom colors
custom_colors <- c("red", "blue", "green", "purple", "orange", 
                   "cyan", "magenta", "brown", "hotpink", "black")
# Step 4: Plot the line chart with custom colors
plot_obj <- ggplot(data_long, aes(x = Year, y = Usage, color = Area, group = Area)) +
  geom_line(linewidth = 1) +  # Use linewidth for line thickness
  geom_point() +
  theme_minimal() +
  scale_color_manual(values = custom_colors) + 
  labs( title= "Nutrient phosphate P2O5 Total Usage per Area of Cropland (kg/ha) Trend for Top 10 Countries", x = "Year", y = "Usage (kg/ha)", color = "Country") +
  theme(
    plot.title = element_text(hjust = 0.5), # Center the title horizontally
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

ggsave("C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/images/P2O5_usage_chart.png", plot = plot_obj, width = 10, height = 6, dpi = 300)
