# Resize a time series to match another time series.
#  `r lifecycle::badge("experimental")`
#
# @param .ts time series to be resized.
# @param .resize time series to be used as reference for resizing.
# @param .start [logical]: If `TRUE`, the start of the resized time series will
# be the start of the reference time series. If `FALSE`, the start of the
# resized time series will be the start of the input time series.
# @param .default [numeric]: default value to be used for filling missing
#
# @return A time series.
#
# @examples
# \dontrun{
# data(AirPassengers)
# ts_resize(AirPassengers, AirPassengers, .start = FALSE)
# ts_resize(AirPassengers, AirPassengers, .start = FALSE, .default = 1)
# }
ts_resize <- function(.ts, .resize, .start = TRUE, .default = 0) {
  if (stats::frequency(.ts) != stats::frequency(.resize)) {
    stop("Frequency of input time series and resize time series do not match.")
  }
  res <- stats::window(
    .ts,
    start = ifelse(.start, stats::time(.resize), stats::time(.ts)),
    end = stats::end(.resize),
    frequency = stats::frequency(.resize),
    extend = TRUE
  )
  res |>
    ts_to_df() |>
    dplyr::mutate(
      dplyr::across(
        -date,
        ~ tidyr::replace_na(.x, .default)
      )
    ) |>
    df_to_ts()
}
