# Load necessary libraries
library(forecast)
library(ggplot2)

# Load the dataset
data <- read.csv("Microsoft_Stock.csv")
data$Date <- mdy_hms(data$Date)

# Fit the ARIMA model using auto.arima for automatic parameter selection
arima_model <- auto.arima(data$Close)

# Print the ARIMA model summary
print(arima_model)

# Generate forecast (forecast for the next 10 days)
forecast_horizon <- 10
forecasted_values <- forecast(arima_model, h = forecast_horizon)

# Print forecasted values
print(forecasted_values)

# Visualize the forecast with confidence intervals
autoplot(forecasted_values) +
  labs(title = "Microsoft Stock Price Forecast (ARIMA Model)",
       subtitle = paste("Forecast for the next", forecast_horizon, "days"),
       x = "Time",
       y = "Forecasted Closing Price") +
  theme_minimal()
