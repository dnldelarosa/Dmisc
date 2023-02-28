test_that("ts_select returns the same data when .include and .exclude are NULL", {
  data <- ts(rnorm(100), start = c(2010, 1), frequency = 12)
  expect_identical(ts_select(data), data)
})

test_that("ts_select throws an error when data is not mts", {
  data <- ts(rnorm(100), start = c(2010, 1), frequency = 12)
  expect_error(ts_select(data, .include = "rnorm"), "data must be multivariate time series object")
})

test_that("ts_select returns only the included columns", {
  data <- data.frame(
    date = seq(as.Date("2022-01-01"), by = "month", length.out = 10),
    rnorm = rnorm(10),
    runif = runif(10)
  ) |>
    df_to_ts()
  expect_equal(c(ts_select(data, .include = "rnorm")), c(data[,"rnorm"]))
  expect_equal(time(ts_select(data, .include = "rnorm")), time(data[,"rnorm"]))
})

test_that("ts_select excludes the specified columns", {
  data <- data.frame(date = seq(as.Date("2022-01-01"), by = "month", length.out = 10), x = rnorm(10), y = rnorm(10), z = rnorm(10))
  ts_data <- ts(data[,-1], start = c(2022,1), frequency = 12)
  ts_subset <- ts_select(ts_data, .exclude = c("x", "z"))
  expect_identical(c(ts_subset), c(ts(data[,c("y")], start = c(2022,1), frequency = 12)))
  expect_identical(time(ts_subset), time(ts(data[,c("y")], start = c(2022,1), frequency = 12)))
})

test_that("ts_select ignores the date column when excluding columns", {
  data <- data.frame(date = seq(as.Date("2022-01-01"), by = "month", length.out = 10), x = rnorm(10), y = rnorm(10), z = rnorm(10))
  ts_data <- ts(data[,-1], start = c(2022,1), frequency = 12)
  ts_subset <- ts_select(ts_data, .exclude = c("date"))
  expect_identical(c(ts_subset), c(ts(data[,c("x", "y", "z")], start = c(2022,1), frequency = 12)))
  expect_identical(time(ts_subset), time(ts(data[,c("x", "y", "z")], start = c(2022,1), frequency = 12)))
})
