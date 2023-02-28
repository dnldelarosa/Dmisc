test_that("df_to_ts", {

  # Test with daily data
  data <- data.frame(date = seq.Date(from = as.Date("2000-01-01"), to = as.Date("2020-12-01"), by = "day"), value = rnorm(7641))
  data[['date']] <- as.Date(data[['date']])
  expect_equal(nrow(df_to_ts(data, .date = "date")), nrow(data$value))
  expect_equal(class(df_to_ts(data, .date = "date")), "ts")
  expect_true(frequency(df_to_ts(data, .date = "date")) == 365.25)
  data[['new_var']] <- rnorm(7641)
  expect_true("mts" %in% class(df_to_ts(data, .date = "date")))
  expect_error(df_to_ts(data, .date = "Date"), "is not in date format")

  # Test with monthly data
  data <- data.frame(date = seq.Date(from = as.Date("2000-01-01"), to = as.Date("2020-12-01"), by = "month"), value = rnorm(252))
  data[['date']] <- as.Date(data[['date']])
  expect_equal(nrow(df_to_ts(data, .date = "date")), nrow(data$value))
  expect_equal(class(df_to_ts(data, .date = "date")), "ts")
  expect_true(frequency(df_to_ts(data, .date = "date")) == 12)
  data[['new_var']] <- rnorm(252)
  expect_true("mts" %in% class(df_to_ts(data, .date = "date")))
  expect_error(df_to_ts(data, .date = "Date"), "is not in date format")

  # Test with quarterly data
  data <- data.frame(date = seq.Date(from = as.Date("2000-01-01"), to = as.Date("2020-12-01"), by = "quarter"), value = rnorm(84))
  data[['date']] <- as.Date(data[['date']])
  expect_equal(nrow(df_to_ts(data, .date = "date")), nrow(data$value))
  expect_equal(class(df_to_ts(data, .date = "date")), "ts")
  expect_true(frequency(df_to_ts(data, .date = "date")) == 4)
  data[['new_var']] <- rnorm(84)
  expect_true("mts" %in% class(df_to_ts(data, .date = "date")))
  expect_error(df_to_ts(data, .date = "Date"), "is not in date format")

  # Test with yearly data
  data <- data.frame(date = seq.Date(from = as.Date("2000-01-01"), to = as.Date("2020-12-01"), by = "year"), value = rnorm(21))
  data[['date']] <- as.Date(data[['date']])
  expect_equal(nrow(df_to_ts(data, .date = "date")), nrow(data$value))
  expect_equal(class(df_to_ts(data, .date = "date")), "ts")
  expect_true(frequency(df_to_ts(data, .date = "date")) == 1)
  data[['new_var']] <- rnorm(21)
  expect_true("mts" %in% class(df_to_ts(data, .date = "date")))
  expect_error(df_to_ts(data, .date = "Date"), "is not in date format")

  # Test with unknown frequency
  data <- data.frame(date = seq.Date(from = as.Date("2000-01-01"), to = as.Date("2020-12-01"), by = "day"), value = rnorm(7641))
  data[['date']] <- as.Date(data[['date']])
  data[['date']][[450]] <- Sys.Date()
  expect_error(df_to_ts(data, .date = "date"))
})
