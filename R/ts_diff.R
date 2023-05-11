# Calculate the difference of a time series
# `r lifecycle::badge("experimental")`
#
#  This function takes a time series and calculates the difference of the time
# series. In contrast to the `diff` function, this function returns a time
# series object preserving the date `.name` attribute.
#
# @param .ts A time series object.
# @param .n An integer specifying the number of lags to be used for calculating
# the difference.
# @param .subset A character vector specifying the columns to be differentiated
# in the output.
# @param .na.omit A boolean indicating whether missing values should be omitted.
# @param ... Additional arguments passed to functions.
#
# @return A time series.
#
# @examples
# \dontrun{
# data(AirPassengers)
# ts_diff(AirPassengers)
# ts_diff(AirPassengers, .n = 2)
# }
ts_diff <- function(.ts, .n = 1, .subset = NULL, .na.omit = TRUE, ...) {
  .name <- NULL
  if (!"mts" %in% class(.ts)) {
    .name <- attr(.ts, ".name")
  }
  res <- .ts |>
    ts_to_df()
  if (is.null(.subset)) {
    res <- res |>
      dplyr::mutate(dplyr::across(-date, ~ .x - lag(.x, .n)))
  } else {
    res <- res |>
      dplyr::mutate(dplyr::across(dplyr::all_of(.subset), ~ .x - lag(.x, .n)))
  }
  if (.na.omit) {
    res <- tidyr::drop_na(res)
  }
  res <- res |>
    df_to_ts()
  if (!is.null(.name)) {
    attr(res, ".name") <- .name
  }
  res
}
