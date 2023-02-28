test_that("ts_merge merges two time series with different starting dates", {
  ts1 <- ts(c(1,2,3), start = c(2010, 1), frequency = 12)
  ts2 <- ts(c(4,5,6), start = c(2010, 1), frequency = 12)
  expected <- ts(
    data.frame(ts1, ts2),
    start = c(2010, 1),
    frequency = 12
  )
  result <- ts_merge(list(ts1, ts2))
  expect_identical(c(result), c(expected))
  expect_identical(time(result), time(expected))
})

test_that("ts_merge merges two time series with different frequencies", {
  ts1 <- ts(c(1,2,3), start = c(2010, 1), frequency = 12)
  ts2 <- ts(c(4,5,6), start = c(2010, 1), frequency = 4)
  result <- ts_merge(list(ts1, ts2))
  expect_identical(start(ts1), start(result))
  expect_identical(max(ts_to_df(ts2)$date), max(ts_to_df(result)$date))
})

test_that("ts_merge merges three time series with different starting dates and frequencies", {
  ts1 <- ts(c(1,2,3), start = c(2010, 1), frequency = 12)
  ts2 <- ts(c(4,5,6), start = c(2010, 1), frequency = 4)
  ts3 <- ts(c(7,8,9), start = c(2010, 1), frequency = 1)
  result <- ts_merge(list(ts1, ts2, ts3))
  expect_identical(start(ts1), start(result))
  expect_identical(max(ts_to_df(ts3)$date), max(ts_to_df(result)$date))
})
