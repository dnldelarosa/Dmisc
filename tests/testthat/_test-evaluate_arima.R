test_that("Tests for evaluate_arima", {
  set.seed(1234)

  # Data
  data <- mdeaths
  train <- window(data, end = c(1977, 12))
  valid <- window(data, start = c(1978, 1), end = c(1978, 12))
  test <- window(data, start = c(1979, 1))

  # ARIMA model
  model <- forecast::Arima(train, order = c(1, 1, 1), seasonal = list(order = c(1, 1, 1), period = 12))

  #  Test return value
  result <- suppressWarnings(evaluate_arima(model, valid, test, .report = FALSE))

  #  Check objects
  expect_true("model-summary" %in% names(result))
  expect_true("training_metrics" %in% names(result))
  expect_true("residual_checks" %in% names(result))
  expect_true("residual_plot" %in% names(result))
  expect_true("forecast-metrics" %in% names(result))
  expect_true("pred" %in% names(result))
  expect_true("plot_pred" %in% names(result))
  expect_true("plot_rmse" %in% names(result))
  expect_true("plot_mae" %in% names(result))
  expect_true("notes" %in% names(result))

  #  Check training metrics
  expect_equal(dim(result$training_metrics), c(4, 1))
  expect_equal(rownames(result$training_metrics), c("RMSE", "MAE", "MAPE", "SMAPE"))

  #  Check forecast metrics
  expect_equal(dim(result$`forecast-metrics`), c(4, 1))
  expect_equal(rownames(result$`forecast-metrics`), c("RMSE", "MAE", "MAPE", "SMAPE"))

  #  Check pred object
  expect_equal(dim(result$pred), c(length(valid) + length(test), 6*2))
  expect_equal(
    colnames(result$pred),
    c("type", "date", "truth", "estimate", "rmse", "mae", "mape", "smape", "rmse_cum", "mae_cum", "mape_cum", "smape_cum")
  )

  #  Check plot_pred object
  expect_true(ggplot2::is.ggplot(result$plot_pred))

  #  Check plot_rmse object
  expect_true(ggplot2::is.ggplot(result$plot_rmse))

  #  Check plot_mae object
  expect_true(ggplot2::is.ggplot(result$plot_mae))

  #  Check notes object
  expect_equal(class(result$notes), "character")

  # Failing...
  ## evaluate_arima returns expected results when transformation is applied
  #result <- evaluate_arima(model, valid, test, .transf = c(exp))
#
  ##  Check pred object
  #  expect_equal(dim(result$pred), c(length(valid) + length(test), 6*2))
  #  expect_equal(
  #    colnames(result$pred),
  #    c("type", "date", "truth", "estimate", "rmse", "mae", "mape", "smape", "rmse_cum", "mae_cum", "mape_cum", "smape_cum")
  #  )

  #  Test error handling
  expect_error(evaluate_arima(model, valid, test, .metrics = "not_a_metric", .report = FALSE))

})

  # test_that("evaluate_arima returns expected results when interactive is TRUE", {
  #
  #  Test return value
  #  result <- evaluate_arima(model, valid, test, .interactive = TRUE)
  #
  #  Check pred object
  #  expect_equal(class(result$pred), "datatable")
  #
  # })
