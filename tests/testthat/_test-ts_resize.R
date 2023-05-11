# Datos de ejemplo
ts1 <- ts(c(1, 2, 3, 4, 5, 6), start = c(2020, 1), frequency = 4)
ts2 <- ts(c(10, 20, 30, 40, 50, 60), start = c(2020, 3), frequency = 4)

test_that("ts_resize resizes the time series to match the reference time series", {
  resized_ts <- ts_resize(ts1, ts2)

  expect_equal(length(resized_ts), length(ts2))
  expect_equal(time(resized_ts), time(ts2))
  expect_equal(frequency(resized_ts), frequency(ts2))
})

test_that("ts_resize uses the correct start time based on .start argument", {
  resized_ts_start_true <- ts_resize(ts1, ts2, .start = TRUE)
  resized_ts_start_false <- ts_resize(ts1, ts2, .start = FALSE)

  expect_equal(time(resized_ts_start_true)[1], time(ts2)[1])
  expect_equal(time(resized_ts_start_false)[1], time(ts1)[1])
})

# test_that("ts_resize fills missing values with the specified .default value", {
#   resized_ts <- ts_resize(ts1, ts2, .default = -1)
#   expected_values <- c(-1, -1, 1, 2, 3, 4)
#
#   expect_equal(as.numeric(resized_ts), expected_values)
# })

test_that("ts_resize throws an error when frequencies do not match", {
  ts3 <- ts(c(1, 2, 3, 4, 5, 6), start = c(2020, 1), frequency = 2)

  expect_error(ts_resize(ts1, ts3), "Frequency of input time series and resize time series do not match.")
})
