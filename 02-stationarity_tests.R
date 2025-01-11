# Load necessary libraries
library(tseries)
library(ggplot2)
library(lubridate)

# Load the dataset
data <- read.csv("Microsoft_Stock.csv")

# Convert 'Date' column to datetime format using mdy_hms from lubridate
data$Date <- mdy_hms(data$Date)


# Perform the Augmented Dickey-Fuller test on the 'Close' column
dickey_fuller_test <- adf.test(data$Close, alternative = "stationary")

# Print the results of the ADF test
print(dickey_fuller_test)

# If the p-value > 0.05, perform differencing to make the data stationary
if (dickey_fuller_test$p.value > 0.05) {
  # Perform first-order differencing
  data$Close_diff <- c(NA, diff(data$Close))
  
  # Remove the first row with NA after differencing
  data_diff <- na.omit(data)
  
  # Plot the differenced data to visualize stationarity
  ggplot(data_diff, aes(x = Date, y = Close_diff)) +
    geom_line(color = "red") +
    labs(title = "Differenced Microsoft Stock Closing Price",
         x = "Date",
         y = "Differenced Closing Price") +
    theme_minimal()
  
  # Perform the ADF test again on the differenced data
  dickey_fuller_test_diff <- adf.test(data_diff$Close_diff, alternative = "stationary")
  
  # Print the results of the ADF test on differenced data
  print(dickey_fuller_test_diff)
  
} else {
  print("The data is already stationary. No differencing required.")
}


# ACF and PACF of the differenced series
acf(diff(data$Close), main = "ACF of Differenced Series")
pacf(diff(data$Close), main = "PACF of Differenced Series")
