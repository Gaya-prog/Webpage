# Load required libraries
library(ggplot2)
library(reshape2)  # For reshaping data
library(RColorBrewer)  # For color palettes
library(gganimate)  # For animation

# Function to generate and save animated violin plots for a single file
generate_animated_violin_plots <- function(file_path, output_file_name) {
  # Read the data
  data <- read.csv(file_path)
  
  # Check if the 'Area' column exists
  if (!("Area" %in% colnames(data))) {
    stop("The input file must have a column named 'Area' for country names.")
  }
  
  # Extract year columns
  year_columns <- grep("^Y", colnames(data), value = TRUE)
  if (length(year_columns) == 0) stop("No columns starting with 'Y' were found.")
  
  # Reshape data to long format
  long_data <- melt(data, id.vars = "Area", measure.vars = year_columns, 
                    variable.name = "Year", value.name = "Value", drop = FALSE)
  
  # Assign colors to each country
  num_countries <- length(unique(long_data$Area))
  country_colors <- if (num_countries <= 12) {
    brewer.pal(n = num_countries, name = "Set3")
  } else {
    colorRampPalette(brewer.pal(9, "Set1"))(num_countries)
  }
  names(country_colors) <- unique(long_data$Area)
  
  # Create animated violin plot
  animated_violin_plot <- ggplot(long_data, aes(x = Area, y = Value, fill = Area)) +
    geom_violin(alpha = 0.7) +
    geom_boxplot(width = 0.1, outlier.size = 0.5, outlier.color = "red") +
    scale_fill_manual(values = country_colors) +
    labs(
      title = "Total Input Nutrient Nitrogen (N) from 2008-2022",
      x = "Country",
      y = "Nutrient nitrogen N per Area of Cropland kg/ha"
    ) +
    theme_classic() +  # Removes the background grid
    theme(
      axis.text.x = element_text(angle = 90, hjust = 1, size = 14), # Rotate labels
      axis.line = element_line(size = 1.5),
      axis.text = element_text(size = 16),
      axis.title = element_text(size = 20),
      plot.title = element_text(size = 32, face = "bold"),
      legend.position = "none"  # Remove legend
    ) +
    transition_states(Area, transition_length = 10, state_length = 15, wrap = FALSE) + 
    enter_fade() + exit_fade()  # Ensures plots stay after appearing
  
  # Generate animation with correct size
  animated_violin_plot <- animate(animated_violin_plot, nframes = 300, fps = 6, width = 1200, height = 800)
  
  # Save animation as GIF
  anim_save(output_file_name, animation = animated_violin_plot)
  
  cat("Animated violin plot saved to:", output_file_name, "\n")
}

# File path for the data
file_path <- "C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/Dataset/10 years/Total Input Nutrient/N total/THIRD 50.csv"

# Output GIF file
output_file_name <- "C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/images/Input_Nutrient_N/THIRD_50_animated_violin_plot.gif"

# Generate and save the animated violin plot
generate_animated_violin_plots(file_path, output_file_name)
