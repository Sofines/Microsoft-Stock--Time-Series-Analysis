# Load necessary libraries
library(forecast)
library(tseries)
library(ggplot2)

# Load the dataset
data <- read.csv("Microsoft_Stock.csv")
data$Date <- mdy_hms(data$Date)

# Fit ARIMA model (use the ARIMA(1,1,0) from previous step or refit it)
arima_model <- arima(data$Close, order = c(1, 1, 0))

# Generate forecast (let's forecast the next 10 days, for example)
forecasted_values <- forecast(arima_model, h = 10)

# Print forecasted values
print(forecasted_values)

# Plot the forecasted values
autoplot(forecasted_values) +
  labs(title = "Microsoft Stock Price Forecast",
       x = "Time",
       y = "Forecasted Closing Price") +
  theme_minimal()

# You can also extract confidence intervals from the forecasted values
forecast_conf_intervals <- forecasted_values$lower
