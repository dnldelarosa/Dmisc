arima_to_ols <- function(
    model,
    .ts = NULL,
    .xreg = NULL,
    .na_rm = TRUE,
    .train = TRUE) {
  arma <- NULL
  sarma <- NULL
  arima_specs <- model |>
    get_arima_comp()
  if (is.null(.ts)) {
    .ts <- model$x
  }
  .df <- .ts |>
    ts_to_df()
  .name <- names(.df)[2]
  .df[["arma"]] <- .df[, 2]
  .df[["sarma"]] <- .df[, 2]
  .df[[.name]] <- NULL
  .drift <- arima_specs[["drift"]]
  if (.drift) {
    .df <- .df |>
      dplyr::mutate(c = 1)
  }
  .d <- arima_specs[["d"]]
  if (.d > 0) {
    .df <- .df |>
      dplyr::mutate(
        arma = arma - dplyr::lag(arma, .d)
      )
  }
  .ar <- arima_specs[["ar"]]
  if (.ar > 0) {
    for (ar in seq_along(1:.ar)) {
      .df <- .df |>
        dplyr::mutate(
          !!paste0("ar", ar) := dplyr::lag(arma, ar)
        )
    }
  }
  .ma <- arima_specs[["ma"]]
  if (.ma > 0) {
    for (ma in seq_along(1:.ma)) {
      .mafit <- forecast::Arima(
        .df[["arma"]],
        c(0, 0, ma)
      )
      .df <- .df |>
        dplyr::mutate(
          !!paste0("ma", ma) := .mafit$fitted - .mafit$residuals
        ) # Aún hay cierta diferencia
    }
  }
  if (.na_rm) {
    .df <- .df |>
      tidyr::drop_na()
  }
  .df <- .df |>
    dplyr::select(-sarma) |>
    tibble::column_to_rownames("date")
  .df <- .df |>
    dplyr::rename(
      !!.name := arma
    )
  if (.train) {
    .formula <- stats::as.formula(
      paste0(.name, "~", ifelse(!.drift, "0 + .", "."))
    )
    res <- stats::lm(.formula, .df)
  } else {
    res <- .df
  }
  res
}


arima_to_ols_old <- function(
    model,
    .ts,
    .name = NULL,
    .xreg = NULL,
    .na_rm = TRUE,
    .train = TRUE) {
  arma <- NULL
  sarma <- NULL
  season <- NULL
  arima_specs <- model |>
    get_arima_comp()
  if ("mts" %in% class(.ts) & is.null(.name)) {
    stop()
  }
  .df <- .ts |>
    ts_to_df()
  if (is.null(.name)) {
    .name <- names(.df)[ncol(.df)]
  }
  .df <- .df |>
    dplyr::select(
      dplyr::all_of(names(.df)),
      # y = dplyr::any_of(names(.df)[ncol(.df)]),
      arma = dplyr::any_of(.name),
      sarma = dplyr::any_of(.name)
    )
  .drift <- arima_specs[["drift"]]
  if (.drift) {
    .df <- .df |>
      dplyr::mutate(c = 1)
  }
  .d <- arima_specs[["d"]]
  if (.d > 0) {
    .df <- .df |>
      dplyr::mutate(
        arma = arma - dplyr::lag(arma, .d)
      )
  }
  .ar <- arima_specs[["ar"]]
  if (.ar > 0) {
    for (ar in seq_along(1:.ar)) {
      .df <- .df |>
        dplyr::mutate(
          !!paste0("ar", ar) := dplyr::lag(arma, ar)
        )
    }
  }
  .ma <- arima_specs[["ma"]]
  if (.ma > 0) {
    for (ma in seq_along(1:.ma)) {
      .df <- .df |>
        dplyr::mutate(
          !!paste0("ma", ma) := zoo::rollmean(arma, ma, NA, align = "right")
        )
    }
  }
  .freq <- arima_specs[["freq"]]
  .D <- arima_specs[["D"]]
  if (.D > 0) {
    .df <- .df |>
      dplyr::mutate(
        sarma = sarma - dplyr::lag(sarma, .D * .freq)
      )
  }
  .sar <- arima_specs[["sar"]]
  if (.sar > 0) {
    for (sar in seq_along(1:.sar)) {
      .df <- .df |>
        dplyr::mutate(
          !!paste0("sar", sar) := dplyr::lag(sarma, sar * .freq)
        )
    }
  }
  .sma <- arima_specs[["sma"]]
  if (.sma > 0) {
    for (sma in 2:(.sma + 1)) {
      .df <- .df |>
        dplyr::mutate(
          season = dplyr::case_when(
            .freq == 4 ~ lubridate::quarter(date),
            .freq == 12 ~ lubridate::month(date)
          )
        ) |>
        dplyr::group_by(season) |>
        dplyr::mutate(
          !!paste0("sma", sma - 1) := zoo::rollmean(sarma, sma, NA, align = "right")
        ) |>
        dplyr::ungroup() |>
        dplyr::select(-season)
    }
  }
  .df <- .df |>
    dplyr::select(-sarma) |>
    dplyr::rename(!!.name := arma)
  if (.na_rm) {
    .df <- .df |>
      tidyr::drop_na()
  }
  if (!is.null(.xreg)) {
    .df <- .df |>
      dplyr::left_join(
        .xreg |>
          ts_to_df(),
        by = dplyr::join_by("date")
      )
  }
  .df <- .df |>
    tibble::column_to_rownames("date")
  if (.train) {
    .formula <- stats::as.formula(
      paste0(.name, "~", ifelse(!.drift, "0 + .", "."))
    )
    res <- stats::lm(.formula, .df)
  } else {
    res <- .df
  }
  res
}
