# Load required libraries
library(ggplot2)
library(reshape2)

# Load the data
file_path <- "C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/Dataset/10 years/Fertilizer Manufacturing Emissions/SECOND 40.csv"  # Replace with your file path
data <- read.csv(file_path)

# Inspect column names
print("Column names in the dataset:")
print(names(data))

# Reshape data to long format for ggplot2
data_long <- melt(data, id.vars = c("Area", "Item", "Element", "Unit"),
                  variable.name = "Year", value.name = "Emissions")

# Convert year format (e.g., Y2008 -> 2008)
data_long$Year <- as.numeric(sub("Y", "", data_long$Year))

# Check for missing values in the Emissions column
print("Check for missing values in Emissions:")
print(sum(is.na(data_long$Emissions)))

# Replace NA values with 0 (or alternatively, use interpolation if desired)
data_long$Emissions[is.na(data_long$Emissions)] <- 0

# Custom colors for regions
custom_colors <- c(
  "Region1" = "#1f77b4", "Region2" = "#ff7f0e", "Region3" = "#ff0000"
)

# Plot the stacked area chart
plot <- ggplot(data_long, aes(x = Year, y = Emissions, fill = Area)) +
  geom_area(alpha = 0.8, color = "black", linewidth = 0.1) +  # Updated to linewidth
  labs(title = "Cumulative CO2 Emissions by Region Over Time",
       x = "Year", y = "CO2 Emissions (kt)") +
  theme_minimal() +  # Ensure that theme_minimal() is used here
  theme(legend.position = "bottom",
        legend.title = element_blank(),
        panel.grid.major = element_line(linewidth = 0.5, color = "gray"),  # Updated to linewidth
        panel.grid.minor = element_blank())

# Display plot
print(plot)

# Save the plot as a high-resolution image
output_file <- "C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/images/SECOND 40.png" # Replace with your desired file name
ggsave(output_file, plot = plot, width = 12, height = 8, dpi = 300)

print(paste("Chart saved successfully as", output_file))
