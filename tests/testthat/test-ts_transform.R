test_that("multiplication works", {
  # Create some test data
  test_ts <- ts(data.frame(x = 1:5, y = 6:10), start = c(2020, 1), frequency = 12)

  # Test that ts_transform returns a ts object
    transformed_ts <- ts_transform(test_ts, sqrt)
    expect_s3_class(transformed_ts, "ts")

  # Test that ts_transform applies a transformation to all columns by default
    expect_identical(transformed_ts, ts(data.frame(x = sqrt(1:5), y = sqrt(6:10)), start = c(2020, 1), frequency = 12))

  # Test that ts_transform applies a transformation to only the specified columns when a subset is provided
    transformed_ts <- ts_transform(test_ts, log, .subset = "y")
    expect_identical(transformed_ts, ts(data.frame(x = 1:5, y = log(6:10)), start = c(2020, 1), frequency = 12))

  # Test that ts_transform handles missing values correctly
    test_ts[3, "x"] <- NA
    transformed_ts <- ts_transform(test_ts, sqrt)
    expect_identical(transformed_ts, ts(data.frame(x = c(sqrt(1:2), NA, sqrt(4:5)), y = sqrt(6:10)), start = c(2020, 1), frequency = 12))

})
