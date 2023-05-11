test_that("ts_ggplot", {

  #Create an example time series
  ts_data <- ts(sin(1:100), start = c(1959, 1), frequency = 12)

  #Test the default plot
  expect_silent(ts_ggplot(ts_data))

  #Test the facet parameter
  expect_silent(ts_ggplot(ts_data, .facet = FALSE))

  #Test the hline parameter
  expect_silent(ts_ggplot(ts_data, .hline = 0.5))

  #Test the ncol parameter
  expect_silent(ts_ggplot(ts_data, .facet = TRUE, .ncol = 2))

  #Test with a non-multivariate time series
  #expect_silent(ts_ggplot(ts_data[, 1]))

  #Test the select parameter
  #expect_silent(ts_ggplot(AirPassengers, .select = "Jan"))
})
