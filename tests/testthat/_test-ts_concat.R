# Load sample data
data(AirPassengers)

# Create tests
test_that("ts_concat concatenates time series objects", {
  # Split the original time series into two parts
  ts_part1 <- window(AirPassengers, start = c(1949, 1), end = c(1955, 12))
  ts_part2 <- window(AirPassengers, start = c(1956, 1), end = c(1960, 12))

  # Test ts_concat
  concat_ts <- ts_concat(ts_part1, ts_part2)

  # Compare concat_ts with the original time series
  expect_true(all.equal(concat_ts, AirPassengers))
})

test_that("ts_concat concatenates a list of time series objects", {
  # Split the original time series into three parts
  ts_part1 <- window(AirPassengers, start = c(1949, 1), end = c(1953, 12))
  ts_part2 <- window(AirPassengers, start = c(1954, 1), end = c(1957, 12))
  ts_part3 <- window(AirPassengers, start = c(1958, 1), end = c(1960, 12))

  # Test ts_concat with a list of time series objects
  concat_ts <- ts_concat(list(ts_part1, ts_part2, ts_part3))

  # Compare concat_ts with the original time series
  expect_true(all.equal(concat_ts, AirPassengers))
})

test_that("ts_concat fails with non-contiguous time series", {
  # Split the original time series into two non-contiguous parts
  ts_part1 <- window(AirPassengers, start = c(1949, 1), end = c(1955, 11))
  ts_part2 <- window(AirPassengers, start = c(1956, 2), end = c(1960, 12))

  # Test ts_concat with non-contiguous time series
  expect_error(ts_concat(ts_part1, ts_part2), "Supplied time series aren't contiguous!")
})
