# Load necessary libraries
library(forecast)
library(tseries)

# Load the dataset (assuming it's already prepared)
data <- read.csv("Microsoft_Stock.csv")
data$Date <- mdy_hms(data$Date)

# Convert the 'Close' column to a time series object (monthly or daily frequency)
data_ts <- ts(data$Close, frequency = 252)  # Assuming daily data (252 trading days in a year)

# Fit the ARIMA model
arima_model <- auto.arima(data_ts)

# Print the model summary
print(arima_model)

# Check residuals for randomness (no pattern)
checkresiduals(arima_model)

# Make forecasts (e.g., for the next 30 days)
forecast_horizon <- 30
forecasted_values <- forecast(arima_model, h = forecast_horizon)

# Plot the forecasts
plot(forecasted_values)

# Print the forecasted values
print(forecasted_values)
