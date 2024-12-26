# Load necessary libraries
library(ggplot2)
library(lubridate)

# Load the dataset
data <- read.csv("Microsoft_Stock.csv")

# Check the first few rows of the data to understand the format
head(data)

# Convert 'Date' column to datetime format (including time) using mdy_hms
data$Date <- mdy_hms(data$Date)

# Check for missing values in Date
sum(is.na(data$Date))

# If there are any NA values, remove those rows
data <- data[!is.na(data$Date), ]

# View the structure of the data
str(data)

# Plot the closing price over time
ggplot(data, aes(x = Date, y = Close)) +
  geom_line(color = "blue") +
  labs(title = "Microsoft Stock Price Over Time",
       x = "Date",
       y = "Closing Price") +
  theme_minimal()
