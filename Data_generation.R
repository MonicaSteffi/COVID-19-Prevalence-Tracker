# Load necessary libraries
library(tidyverse)

# Set seed for reproducibility
set.seed(123)

# Generate simulated data for 5 regions over 30 days
regions <- c("Region A", "Region B", "Region C", "Region D", "Region E")
days <- seq.Date(from = as.Date("2024-01-01"), to = as.Date("2024-01-30"), by = "day")

# Create data frame
covid_data <- expand.grid(Date = days, Region = regions) %>%
  mutate(
    Population = sample(seq(500000, 5000000, by = 100000), n(), replace = TRUE),  # Random populations
    Active_Cases = round(runif(n(), min = 0, max = 0.03) * Population),           # Random active cases
    Prevalence = (Active_Cases / Population) * 100                               # Prevalence percentage
  )

# Save the dataset
write.csv(covid_data, "simulated_covid_data.csv", row.names = FALSE)

# View sample data
head(covid_data)

# Line plot of prevalence over time
ggplot(covid_data, aes(x = Date, y = Prevalence, color = Region)) +
  geom_line(size = 1) +
  labs(
    title = "COVID-19 Prevalence Over Time",
    x = "Date",
    y = "Prevalence (%)",
    color = "Region"
  ) +
  theme_minimal()

# Filter data for the latest date
latest_date <- max(covid_data$Date)
latest_data <- filter(covid_data, Date == latest_date)

# Bar chart for regional prevalence
ggplot(latest_data, aes(x = Region, y = Prevalence, fill = Region)) +
  geom_bar(stat = "identity") +
  labs(
    title = paste("COVID-19 Prevalence by Region on", latest_date),
    x = "Region",
    y = "Prevalence (%)",
    fill = "Region"
  ) +
  theme_minimal()

# Heatmap for prevalence over time
ggplot(covid_data, aes(x = Date, y = Region, fill = Prevalence)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "blue", high = "red", name = "Prevalence (%)") +
  labs(
    title = "COVID-19 Prevalence Trends Over Time",
    x = "Date",
    y = "Region"
  ) +
  theme_minimal()

# Boxplot for prevalence distribution
ggplot(covid_data, aes(x = Region, y = Prevalence, fill = Region)) +
  geom_boxplot() +
  labs(
    title = "Distribution of COVID-19 Prevalence Across Regions",
    x = "Region",
    y = "Prevalence (%)",
    fill = "Region"
  ) +
  theme_minimal()

