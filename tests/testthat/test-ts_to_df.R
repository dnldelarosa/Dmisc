
# Test that the function returns a data frame
test_that("ts_to_df returns a data frame", {
  ts <- ts(rnorm(10))
  res <- ts_to_df(ts)
  expect_is(res, "data.frame")
})

# Test that the function correctly converts the time series to a data frame
test_that("ts_to_df converts time series to data frame", {
  ts <- ts(rnorm(10), start = c(2022, 1), frequency = 12)
  res <- ts_to_df(ts)
  expect_equal(nrow(res), 10)
  expect_identical(as.character(res$date[1]), "2022-01-31")
  expect_identical(as.character(res$date[10]), "2022-10-31")
})

# Test that the function adds a column with the specified name
test_that("ts_to_df adds a column with the specified name", {
  ts <- ts(rnorm(10))
  res <- ts_to_df(ts, .name = "my_data")
  expect_identical(colnames(res)[2], "my_data")
})

# Test that the function converts the time series to dates correctly
test_that("ts_to_df converts time series to dates correctly", {
  ts <- ts(rnorm(10), start = c(2022, 1), frequency = 12)
  res <- ts_to_df(ts, as_date = TRUE)
  expect_is(res$date, "Date")
  expect_identical(as.character(res$date[1]), "2022-01-31")
  expect_identical(as.character(res$date[10]), "2022-10-31")
})
