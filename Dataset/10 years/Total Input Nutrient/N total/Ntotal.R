# Load required libraries
library(ggplot2)
library(reshape2)  # For reshaping data from wide to long format
library(RColorBrewer)  # For color palettes

# Function to generate and save violin plots for a single file
generate_violin_plots <- function(file_path, output_file_name) {
  # Read the data
  data <- read.csv(file_path)
  
  # Check if the 'Area' column exists
  if (!("Area" %in% colnames(data))) {
    stop("The input file must have a column named 'Area' for country names.")
  }
  
  # Reshape the data from wide to long format
  long_data <- melt(data, id.vars = "Area", 
                    measure.vars = grep("^Y", colnames(data), value = TRUE), 
                    variable.name = "Year", value.name = "Value")
  
  # Determine the number of unique countries
  num_countries <- length(unique(long_data$Area))
  
  # Generate color palette depending on the number of countries
  if (num_countries <= 12) {
    country_colors <- brewer.pal(n = num_countries, name = "Set3")
  } else {
    # Use a more expansive palette if there are more than 12 countries
    country_colors <- colorRampPalette(brewer.pal(9, "Set1"))(num_countries)
  }
  
  # Assign country names to the corresponding colors
  names(country_colors) <- unique(long_data$Area)
  
  # Generate the violin plot with distinct colors for each country
  violin_plot <- ggplot(long_data, aes(x = Area, y = Value, fill = Area)) +
    geom_violin(alpha = 0.7) +
    geom_boxplot(width = 0.1, outlier.size = 0.5, outlier.color = "red") +
    scale_fill_manual(values = country_colors) +
    labs(
      title = "Total Input Nutrient Nitrogen (N) from 2008-2022",
      x = "Country",
      y = "Nutrient nitrogen N per Area of Cropland kg/ha"
    ) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    theme(legend.position = "none")  # Remove legend
  
  # Save the plot as a PNG file
  ggsave(output_file_name, violin_plot, width = 12, height = 8, dpi = 300)  # PNG by default when the file name ends with .png
  
  cat("Violin plot saved to:", output_file_name, "\n")
}

# File path for the first file
file_path <- "C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/Dataset/10 years/Total Input Nutrient/N total/LAST 50.csv"

# Output file name (Change the file extension to .png)
output_file_name <- "C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/images/LAST_50_violin_plot.png"

# Generate and save the violin plot
generate_violin_plots(file_path, output_file_name)
