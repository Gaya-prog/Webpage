# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Load your dataset
data <- read.csv("C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/Dataset/10 years/Production/productionN_total.csv")

# Filter data for the first 50 countries
fourth_50_countries <- unique(data$Area)[151:201]  # Get the first 50 unique countries
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

# Generate a custom color palette for the countries
country_colors <- setNames(
  grDevices::colorRampPalette(RColorBrewer::brewer.pal(8, "Set3"))(length(unique(data_summary$Area))),
  unique(data_summary$Area)
)

# Create the plot and assign it to the variable `plot`
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
    legend.title = element_text(size = 10),
    legend.text = element_text(size = 8),
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
    plot.title = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 12)
  )

# Save the plot in high resolution
output_path <- "C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/images/Production/Nutrient_N4.png"
ggsave(
  filename = output_path,  # Use the specified file path
  plot = plot,            # Refer to the `plot` object
  width = 30,             # Width in inches
  height = 20,            # Height in inches
  dpi = 700               # High resolution
)
