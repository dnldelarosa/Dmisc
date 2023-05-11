# Reverses differencing of a time series.
# `r lifecycle::badge("experimental")`
#
# @param .ts A time series object.
# @param .original A time series object containing at least one data point from
# the original time series before differencing. This can be a single data point
# or a subset of the original time series.
# @param .ndiffs The number of lags used for differencing.
#
# @return A time series.
#
# @examples
# \dontrun{
# data(AirPassengers)
# ts_undiff(ts_diff(AirPassengers))
# ts_undiff(ts_diff(AirPassengers, .n = 2), .n = 2)
# }
ts_undiff <- function(.ts, .original, .ndiffs = 1){
  dif <- NULL
  ts2 <- NULL
  res <- NULL
  ts <- NULL
  if("mts" %in% class(.ts) || "mts" %in% class(.original)){
    stop("Input must be univariate time series.")
  }
  if(min(stats::time(.ts)) > max(stats::time(.original))){
    tryCatch({
      ts_concat(list(diff(.original, .ndiffs), .ts))
    }, error = function(e){
      stop("Supplied time series need to overlap or at least be contiguous...")
    })
  }
  .original |>
    ts_to_df() |>
    dplyr::full_join(
      .ts |>
        ts_to_df() |>
        dplyr::rename(dif = ts),
      by = dplyr::join_by(date)
    ) |>
    dplyr::mutate(ts2 = stats::lag(ts, .ndiffs)) |>
    tidyr::drop_na(dif) |>
    dplyr::mutate(res = ts2[[1]] + cumsum(dif)) |>
    dplyr::select(date, res) |>
    df_to_ts()
}
