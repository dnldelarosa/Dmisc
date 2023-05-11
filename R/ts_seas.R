ts_seas <- function(.ts, .periods = NULL, .rm = FALSE) {
  .freq <- .ts |>
    ts_to_df() |>
    ts_guest_freq("date")
  .fn <- ifelse(
    .freq == 4,
    lubridate::quarter,
    ifelse(
      .freq == 12,
      lubridate::month,
      lubridate::day
    )
  )
  .prefix <- ifelse(
    .freq == 4,
    "Q",
    ifelse(
      .freq == 12,
      "M",
      "D"
    )
  )
  res <- .ts |>
    ts_to_df()
  if (.rm) {
    res <- res |>
      dplyr::select(date)
  }
  if (is.null(.periods)) {
    .periods <- 1:(.freq - 1)
  }
  for (.p in .periods) {
    res <- res |>
      dplyr::mutate(
        !!paste0(.prefix, .p) := as.integer(.fn(date) == .p)
      )
  }
  res |>
    df_to_ts()
}
