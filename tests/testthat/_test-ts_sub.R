ts1 <- ts(rnorm(100), start = c(2010, 1), frequency = 12)
ts2 <- ts(rnorm(50), start = c(2010, 1), frequency = 12)

test_that("ts_sub returns correct time series", {
  expect_identical(
    ts_sub(ts1, ts2),
    ts(ts1[51:100], start = c(2014, 3), frequency = 12)
  )
})

ts3 <- ts(rnorm(10), start = c(2021, 1), frequency = 12)

test_that("ts_sub error if ts1 and ts2 don't overlap", {
  expect_error(
    ts_sub(ts1, ts3)
  )
})
