# Install and load necessary packages
install.packages("readxl")    # For reading Excel files
install.packages("dplyr")     # For data manipulation
install.packages("openxlsx")  # For writing Excel files
library(readxl)
library(dplyr)
library(openxlsx)

# Define the file paths
input_file <- "C:/Users/mmpek/Desktop/who_ambient_air_quality_DeletedColumns.xlsx"
output_file <- "C:/Users/mmpek/Desktop/who_ambient_air_quality_Poland.xlsx"

# Read the Excel file
data <- read_excel(input_file)

# Filter rows where the country is "Poland"
filtered_data <- data %>%
  filter(country_name == "Poland")

# Save the filtered data to a new Excel file
write.xlsx(filtered_data, file = output_file, rowNames = FALSE)

# Print a confirmation message
cat("The filtered data has been saved to:\n", output_file)





#1. ONLY TUCHOW PLOT

# Install and load necessary packages
install.packages("readxl")   # For reading Excel files
install.packages("ggplot2")  # For creating visualizations
install.packages("dplyr")    # For data manipulation
install.packages("ggthemes") # For additional themes
library(readxl)
library(ggplot2)
library(dplyr)
library(ggthemes)

# Define the file path
file_path <- "C:/Users/mmpek/Desktop/Fun Side Projects/Project one - Air Pollution in Poland/who_ambient_air_quality_Poland.xlsx"

# Read the Excel file
data <- read_excel(file_path)

# Convert `pm10_concentration` to numeric (if it's not already)
data <- data %>%
  mutate(pm10_concentration = as.numeric(pm10_concentration))

# Filter data for Tuchow/POL and years 2010–2020
filtered_data <- data %>%
  filter(city == "Tuchow/POL" & year >= 2010 & year <= 2020) %>%
  mutate(pm10_concentration = round(pm10_concentration, 2))  # Round to 2 decimal places

# Create the line graph
plot <- ggplot(filtered_data, aes(x = year, y = pm10_concentration)) +
  geom_line(color = "#776274", size = 2, alpha = 0.7, na.rm = TRUE) +  # Add a line (handles missing values)
  geom_point(color = "#776274", size = 2) +               # Add points for each year
  labs(
    title = "Change in PM10 Concentration in Tuchow (Poland) (2010–2020)",
    x = "Year",
    y = "PM10 Concentration (µg/m³)"
  ) +
  scale_x_continuous(breaks = seq(2010, 2020, by = 1)) +  # Set x-axis breaks for each year
  scale_y_continuous(
    breaks = seq(0, max(filtered_data$pm10_concentration, na.rm = TRUE) + 5, by = 5),  # Set y-axis breaks every 5 units
    labels = scales::number_format(accuracy = 0.01)  # Round y-axis labels to 2 decimal places
  ) +
  theme_fivethirtyeight() +  # Apply the FiveThirtyEight theme
  theme(
    axis.title.x = element_text(size = 12, color = "black"),  # Customize x-axis title
    axis.title.y = element_text(size = 12, color = "black"),  # Customize y-axis title
    panel.grid.major.y = element_line(color = "gray80", size = 0.5),  # Add major y-axis gridlines
    panel.grid.minor.y = element_line(color = "gray90", size = 0.25)   # Add minor y-axis gridlines
  )

# Display the plot
print(plot)











#2.  COMPARISON PLOT WITH CITIES WITH SIMILAR POPULATION TO TUCHOW
library(readxl)
library(ggplot2)
library(dplyr)
library(ggthemes)
library(RColorBrewer)

# Define the file path
file_path <- "C:/Users/mmpek/Desktop/Fun Side Projects/Project one - Air Pollution in Poland/who_ambient_air_quality_Poland.xlsx"

# Read the Excel file
data <- read_excel(file_path)

# Clean and prepare the data
data <- data %>%
  mutate(
    pm10_concentration = as.numeric(pm10_concentration),
    population = as.numeric(population)
  )

# Extract the first population value for each city
cities_with_population <- data %>%
  group_by(city) %>%
  arrange(year) %>%
  summarise(population = first(na.omit(population))) %>%
  filter(population >= 3681 & population <= 9681 & !is.na(population))

# Filter data - keep only cities with at least 5 PM10 values (2010-2020)
filtered_data_comparison <- data %>%
  filter(city %in% cities_with_population$city & 
           year >= 2010 & year <= 2020 & 
           !is.na(pm10_concentration)) %>%
  group_by(city) %>%
  filter(n() >= 5) %>%  # Keep only cities with 5+ measurements
  ungroup() %>%
  mutate(pm10_concentration = round(pm10_concentration, 2))

# Create a custom colour palette
num_cities <- length(unique(filtered_data_comparison$city))
muted_colors <- brewer.pal(n = max(3, min(12, num_cities)), name = "Set3")
muted_colors <- colorRampPalette(muted_colors)(num_cities)
muted_colors[unique(filtered_data_comparison$city) == "Tuchow/POL"] <- "#776274"

# The rest of your existing plotting code remains exactly the same:
comparison_plot <- ggplot(filtered_data_comparison, 
                          aes(x = year, y = pm10_concentration, color = city)) +
  geom_line(aes(linewidth = ifelse(city == "Tuchow/POL", 2, 1)), 
            alpha = 0.7, na.rm = TRUE) +
  geom_point(size = 2, alpha = 0.7) +
  labs(
    title = "Comparison of PM10 Concentration in Cities with Similar Population",
    x = "Year",
    y = "PM10 Concentration (µg/m³)",
    color = "City"
  ) +
  scale_x_continuous(breaks = seq(2010, 2020, by = 1)) +
  scale_y_continuous(
    breaks = seq(0, ceiling(max(filtered_data_comparison$pm10_concentration, na.rm = TRUE)/10)*10, 
                 by = 10),
    labels = scales::number_format(accuracy = 0.01),
    expand = expansion(mult = c(0.05, 0.1))) +
  scale_color_manual(values = muted_colors) +
  scale_linewidth_identity() +
  theme_fivethirtyeight() +
  theme(
    axis.title = element_text(size = 12, color = "black"),
    panel.grid.major.y = element_line(color = "gray80", size = 0.5),
    panel.grid.minor.y = element_line(color = "gray90", size = 0.25),
    legend.position = "bottom",
    legend.title = element_text(size = 10),
    legend.text = element_text(size = 8)
  )

print(comparison_plot)











#3. COMPARISON PLOT WITH HIGHEST POPULATION CITIES

library(readxl)
library(ggplot2)
library(dplyr)
library(ggthemes)
library(RColorBrewer)

# Define the file path
file_path <- "C:/Users/mmpek/Desktop/Fun Side Projects/Project one - Air Pollution in Poland/who_ambient_air_quality_Poland.xlsx"

# Read the Excel file
data <- read_excel(file_path)

# Clean and prepare the data
data <- data %>%
  mutate(
    pm10_concentration = as.numeric(pm10_concentration),
    population = as.numeric(population)
  )

# Get the 10 cities with highest population (excluding Tuchow if it's in the top 10)
top_cities <- data %>%
  group_by(city) %>%
  summarise(population = max(population, na.rm = TRUE)) %>%
  arrange(desc(population)) %>%
  filter(!is.na(population)) %>%
  head(10)

# Include Tuchow
if(!"Tuchow/POL" %in% top_cities$city) {
  tuchow_data <- data %>%
    filter(city == "Tuchow/POL") %>%
    summarise(city = first(city), population = max(population, na.rm = TRUE))
  
  top_cities <- bind_rows(top_cities, tuchow_data) %>%
    arrange(desc(population))
}

# Filter data for the selected cities and years 2010-2020
filtered_data_comparison <- data %>%
  filter(city %in% top_cities$city & 
           year >= 2010 & year <= 2020 & 
           !is.na(pm10_concentration)) %>%
  group_by(city) %>%
  filter(n() >= 5) %>%  # Keep only cities with 5+ measurements
  ungroup() %>%
  mutate(pm10_concentration = round(pm10_concentration, 2))

# Create a custom color palette
num_cities <- length(unique(filtered_data_comparison$city))
muted_colors <- brewer.pal(n = max(3, min(12, num_cities)), name = "Set3")
muted_colors <- colorRampPalette(muted_colors)(num_cities)
muted_colors[unique(filtered_data_comparison$city) == "Tuchow/POL"] <- "#776274"

# Create the plot
comparison_plot <- ggplot(filtered_data_comparison, 
                          aes(x = year, y = pm10_concentration, color = city)) +
  geom_line(aes(linewidth = ifelse(city == "Tuchow/POL", 2, 1)), 
            alpha = 0.7, na.rm = TRUE) +
  geom_point(size = 2, alpha = 0.7) +
  labs(
    title = "PM10 Concentration: Tuchow vs 10 Most Populous Cities (2010-2020)",
    x = "Year",
    y = "PM10 Concentration (µg/m³)",
    color = "City"
  ) +
  scale_x_continuous(breaks = seq(2010, 2020, by = 1)) +
  scale_y_continuous(
    breaks = seq(0, ceiling(max(filtered_data_comparison$pm10_concentration, na.rm = TRUE)/10)*10, 
                 by = 10),
    labels = scales::number_format(accuracy = 0.01),
    expand = expansion(mult = c(0.05, 0.1))) +
  scale_color_manual(values = muted_colors) +
  scale_linewidth_identity() +
  theme_fivethirtyeight() +
  theme(
    axis.title = element_text(size = 12, color = "black"),
    panel.grid.major.y = element_line(color = "gray80", size = 0.5),
    panel.grid.minor.y = element_line(color = "gray90", size = 0.25),
    legend.position = "bottom",
    legend.title = element_text(size = 10),
    legend.text = element_text(size = 8)
  )

print(comparison_plot)

# Save the plot
#ggsave("C:/Users/mmpek/Desktop/pm10_tuchow_vs_top10.pdf", 
      # plot = comparison_plot, 
      # width = 10, 
       #height = 6, 
      # dpi = 300)






#4. COMPARISON PLOT WITH BOTH SIMILAR POPULATION AND HIGHEST POPULATION

library(readxl)
library(ggplot2)
library(dplyr)
library(ggthemes)
library(RColorBrewer)

# Define the file path
#file_path <- "C:/Users/mmpek/Desktop/Fun Side Projects/Project one - Air Pollution in Poland/who_ambient_air_quality_Poland.xlsx"

# Read the Excel file
#data <- read_excel(file_path)

# Clean and prepare the data
#data <- data %>%
 # mutate(
  #  pm10_concentration = as.numeric(pm10_concentration),
   # population = as.numeric(population)
  #)

# Get cities with similar population to Tuchow (3681-9681)
similar_pop_cities <- data %>%
  group_by(city) %>%
  summarise(population = max(population, na.rm = TRUE)) %>%
  filter(population >= 3681 & population <= 9681 & !is.na(population))

# Get top 10 most populous cities (excluding similar pop cities)
top_pop_cities <- data %>%
  group_by(city) %>%
  summarise(population = max(population, na.rm = TRUE)) %>%
  filter(!city %in% similar_pop_cities$city) %>%
  arrange(desc(population)) %>%
  filter(!is.na(population)) %>%
  head(10)

# Combine both groups and ensure Tuchow is included
selected_cities <- bind_rows(
  similar_pop_cities,
  top_pop_cities
) %>%
  distinct(city, .keep_all = TRUE)

# Filter data for the selected cities and years 2010-2020
filtered_data_comparison <- data %>%
  filter(city %in% selected_cities$city & 
           year >= 2010 & year <= 2020 & 
           !is.na(pm10_concentration)) %>%
  group_by(city) %>%
  filter(n() >= 5) %>%  # Keep only cities with 5+ measurements
  ungroup() %>%
  mutate(pm10_concentration = round(pm10_concentration, 2),
         city_group = case_when(
           city == "Tuchow/POL" ~ "Tuchow",
           city %in% similar_pop_cities$city ~ "Similar Population",
           city %in% top_pop_cities$city ~ "Highest Population",
           TRUE ~ "Other"
         ))

# Create color mapping
color_mapping <- c(
  "Tuchow" = "#776274",
  "Similar Population" = "#4E79A7",  # Muted blue
  "Highest Population" = "#E15759"      # Muted red
)

# Create the plot
comparison_plot <- ggplot(filtered_data_comparison, 
                          aes(x = year, y = pm10_concentration, 
                              color = city_group,
                              group = city)) +
  geom_line(aes(linewidth = ifelse(city == "Tuchow/POL", 2, 1)), 
            alpha = 0.7, na.rm = TRUE) +
  geom_point(size = 2, alpha = 0.7) +
  labs(
    title = "PM10 Concentration: Tuchow vs Similar and High Population Cities (2010-2020)",
    x = "Year",
    y = "PM10 Concentration (µg/m³)",
    color = "City Group"
  ) +
  scale_x_continuous(breaks = seq(2010, 2020, by = 1)) +
  scale_y_continuous(
    breaks = seq(0, ceiling(max(filtered_data_comparison$pm10_concentration, na.rm = TRUE)/10)*10, 
                 by = 10),
    labels = scales::number_format(accuracy = 0.01),
    expand = expansion(mult = c(0.05, 0.1))) +
  scale_color_manual(values = color_mapping) +
  scale_linewidth_identity() +
  theme_fivethirtyeight() +
  theme(
    axis.title = element_text(size = 12, color = "black"),
    panel.grid.major.y = element_line(color = "gray80", size = 0.5),
    panel.grid.minor.y = element_line(color = "gray90", size = 0.25),
    legend.position = "bottom",
    legend.title = element_text(size = 10),
    legend.text = element_text(size = 8)
  )

print(comparison_plot)

