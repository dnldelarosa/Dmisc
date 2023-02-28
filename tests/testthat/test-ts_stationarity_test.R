# Generate some test data
set.seed(123)
data1 <- rnorm(100)
data2 <- data.frame(
  date = seq(as.Date("2010-01-01"), as.Date("2019-12-01"), by = "month"),
  V1 = rnorm(120),
  V2 = rnorm(120)
) |>
  df_to_ts()

# Test for non-multivariate input
test_that("ts_stationarity_test returns correct results for non-multivariate input", {
  output <- suppressWarnings(ts_stationarity_test(data1))
  expect_is(output, "htest")
  expect_equal(output$method, "Augmented Dickey-Fuller Test")
  expect_false(output$p.value >= 0.05)
})

# Test for multivariate input with default column selection
test_that("ts_stationarity_test returns correct results for multivariate input with default column selection", {
  output <- suppressWarnings(ts_stationarity_test(data2))
  expect_is(output, "list")
  expect_equal(length(output), 2)
  expect_equal(output[[1]][['method']], "Augmented Dickey-Fuller Test")
  expect_false(output[[1]][['p.value']] >= 0.05)
  expect_equal(output[[2]]$method, "Augmented Dickey-Fuller Test")
  expect_false(output[[2]]$p.value > 0.05)
})

# Test for multivariate input with specified column selection
test_that("ts_stationarity_test returns correct results for multivariate input with specified column selection", {
  output <- suppressWarnings(ts_stationarity_test(data2, .select = c("V1")))
  expect_is(output[[1]], "htest")
  expect_equal(length(output), 1)
  expect_equal(output[[1]]$method, "Augmented Dickey-Fuller Test")
  expect_false(output[[1]]$p.value > 0.05)
})
