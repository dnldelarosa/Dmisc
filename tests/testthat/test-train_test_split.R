test_that("train_test_split returns a list with train and test sets", {

  #Create a test dataset
  set.seed(123)
  df <- data.frame(time = 1:100, value = rnorm(100))
  ts_df <- ts(df$value, start = c(2020, 1), frequency = 12)

  #Test for a data.frame object
  result <- train_test_split(df)
  expect_that(result, is_a("list"))
  expect_that(result$train, is_a("data.frame"))
  expect_that(result$test, is_a("data.frame"))

  #Test for a time series object
  result_ts <- train_test_split(ts_df)
  expect_that(result_ts, is_a("list"))
  expect_that(result_ts$train, is_a("ts"))
  expect_that(result_ts$test, is_a("ts"))
})

test_that("train_test_split returns a list with train, validation, and test sets if val_split is TRUE", {

  #Create a test dataset
  set.seed(123)
  df <- data.frame(time = 1:100, value = rnorm(100))
  ts_df <- ts(df$value, start = c(2020, 1), frequency = 12)

  #Test for a data.frame object
  result <- train_test_split(df, val_split = TRUE)
  expect_that(result, is_a("list"))
  expect_that(result$train, is_a("data.frame"))
  expect_that(result$valid, is_a("data.frame"))
  expect_that(result$test, is_a("data.frame"))

  #Test for a time series object
  result_ts <- train_test_split(ts_df, val_split = TRUE)
  expect_that(result_ts, is_a("list"))
  expect_that(result_ts$train, is_a("ts"))
  expect_that(result_ts$valid, is_a("ts"))
  expect_that(result_ts$test, is_a("ts"))
})
