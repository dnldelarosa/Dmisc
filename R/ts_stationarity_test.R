# Test Stationarity of Time Series
# `r lifecycle::badge("experimental")`
#
# This function performs the Augmented Dickey-Fuller (ADF) test to check if a time series is stationary.
#
# @param data A time series object or a data frame with multiple time series.
# @param .select An optional character vector of column names of the data frame to be used.
#
# @return A list of ADF test results or a single ADF test result.
#
# @examples
# \dontrun{
# ts1 <- ts(rnorm(100), start = c(2010, 1), frequency = 12)
# ts2 <- ts(rnorm(100), start = c(2010, 1), frequency = 12)
# data <- cbind(ts1, ts2)
# ts_stationarity_test(data)
# ts_stationarity_test(data, .select = c("ts1"))
# ts_stationarity_test(ts1)
#}
ts_stationarity_test <- function(data, .select = NULL){
  if("mts" %in% class(data)){
    if(!is.null(.select)){
      data <- data |> ts_select(.select)
    }
    data |>
      ts_to_df() |>
      dplyr::select(-date) |>
      purrr::map(tseries::adf.test)
  } else {
    tseries::adf.test(data)
  }
}
