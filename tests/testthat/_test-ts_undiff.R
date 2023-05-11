# Load sample data
data(AirPassengers)

# Create tests
test_that("ts_undiff reverses differencing", {
  # Create a differenced time series
  diff_ts <- ts_diff(AirPassengers, .n = 1)

  # Take a single data point from the original time series
  original_sample <- window(AirPassengers, start = c(1949, 1), end = c(1949, 1))

  # Test ts_undiff
  undiff_ts <- ts_undiff(diff_ts, .original = original_sample, .ndiffs = 1)

  # Compare undiff_ts with the original time series (excluding the first data point)
  expect_true(all.equal(undiff_ts, window(AirPassengers, start = c(1949, 2))))
})

test_that("ts_undiff works with multiple lags", {
  # Create a differenced time series with 2 lags
  diff_ts <- ts_diff(AirPassengers, .n = 2)

  # Take two data points from the original time series
  original_sample <- window(AirPassengers, start = c(1949, 1), end = c(1949, 2))

  # Test ts_undiff
  undiff_ts <- ts_undiff(diff_ts, .original = original_sample, .ndiffs = 2)

  # Compare undiff_ts with the original time series (excluding the first two data points)
  expect_true(all.equal(undiff_ts, window(AirPassengers, start = c(1949, 3))))
})

test_that("ts_undiff fails with multivariate time series", {
  # Create a multivariate time series
  mts_data <- ts(cbind(AirPassengers, AirPassengers * 2), start = 1949)
  diff_mts <- ts_diff(mts_data, .n = 1)

  # Test ts_undiff with multivariate input
  expect_error(ts_undiff(diff_mts, .original = mts_data, .ndiffs = 1), "Input must be univariate time series.")
})
