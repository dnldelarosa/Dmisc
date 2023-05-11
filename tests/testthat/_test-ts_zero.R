test_that("ts_zero returns a time series with all values set to zero", {

  #Create a sample time series object
  ts_obj <- ts(1:10, start = c(2020, 1), frequency = 12)

  #Call ts_zero function
  zero_ts <- ts_zero(ts_obj)

  #Test if all values in resulting time series are zero
  expect_true(all.equal(zero_ts, ts(rep(0, length(ts_obj)), start = c(2020, 1), frequency = 12)))
})

test_that("ts_zero returns a time series with all values set to zero for a specific period", {

  #Create a sample time series object
  ts_obj <- ts(1:10, start = c(2020, 1), frequency = 12)

  #Define period to be considered
  period <- ts(1:12, start = c(2020, 1), frequency = 12)

  #Call ts_zero function
  zero_ts <- ts_zero(ts_obj, resize = period)

  #Test if resulting time series only has values set to zero for the specific period
  expect_true(all.equal(zero_ts, ts(c(rep(0, 12)), start = c(2020, 1), frequency = 12)))
})


test_that("ts_zero returns an object of class 'ts'", {

  #Create a sample time series object
  ts_obj <- ts(1:10, start = c(2020, 1), frequency = 12)

  #Call ts_zero function
  zero_ts <- ts_zero(ts_obj)

  #Test if resulting object is of class 'ts'
  expect_true(class(zero_ts) == "ts")
})


test_that("ts_zero returns an error when frequency of input and resize time series do not match", {

  #Create a sample time series object
  ts_obj <- ts(1:10, start = c(2020, 1), frequency = 12)

  #Define period to be considered
  period <- ts(1:12, start = c(2020, 1), frequency = 4)

  #Call ts_zero function and expect error message
  expect_error(ts_zero(ts_obj, resize = period), "Frequency of input time series and resize time series do not match.")
})
