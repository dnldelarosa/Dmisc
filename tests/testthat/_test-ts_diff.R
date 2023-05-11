test_that("ts_diff calculates differences correctly", {
  # Load AirPassengers data
  data(AirPassengers)

  # Calculate the first difference
  ts_diff_1 <- ts_diff(AirPassengers, .n = 1)

  # Check if the length of the first difference is one less than the original data
  expect_equal(length(ts_diff_1), length(AirPassengers) - 1)

  # Calculate the second difference
  ts_diff_2 <- ts_diff(AirPassengers, .n = 2)

  # Check if the length of the second difference is two less than the original data
  expect_equal(length(ts_diff_2), length(AirPassengers) - 2)

  # Check if the differences are calculated correctly
  expect_equal(ts_diff_1, diff(AirPassengers, lag = 1))
  expect_equal(ts_diff_2, diff(AirPassengers, lag = 2))
})

test_that("ts_diff handles .subset argument correctly", {
  # Create a multivariate time series
  data(AirPassengers)
  ts_data <- ts(cbind(AirPassengers, AirPassengers * 2), start = start(AirPassengers), frequency = frequency(AirPassengers))

  # Calculate the first difference for the first column only
  ts_diff_subset <- ts_diff(ts_data, .n = 1, .subset = "V1")

  # Check if the length of the first difference is one less than the original data
  expect_equal(nrow(ts_diff_subset), nrow(ts_data) - 1)

  # Check if the differences are calculated correctly for the first column
  expect_equal(ts_diff_subset[, "V1"], diff(ts_data[, "V1"], lag = 1))

  # Check if the second column remains unchanged
  expect_equal(ts_diff_subset[, "V2"], ts_data[-1, "V2"])
})

test_that("ts_diff handles .na.omit argument correctly", {
  # Load AirPassengers data
  data(AirPassengers)

  # Calculate the first difference without omitting NAs
  ts_diff_na <- ts_diff(AirPassengers, .n = 1, .na.omit = FALSE)

  # Check if the length of the first difference is equal to the original data
  expect_equal(length(ts_diff_na), length(AirPassengers))

  # Check if the first element is NA
  expect_true(is.na(ts_diff_na[1]))
})
