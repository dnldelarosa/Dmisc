forecast_var <- function(model, .extend = NULL, ...) {
  trend <- NULL
  if (!is.null(.extend)) {
    .names <- names(model$varresult)

    .date <- model$y %>%
      ts_to_df() %>%
      dplyr::pull(date)

    .res <- model$datamat %>%
      dplyr::select(
        -tidyselect::starts_with(.names)
      )
    if ("trend" %in% names(.res)) {
      .res <- .res %>%
        dplyr::select(-trend)
    }
    if ("const" %in% names(.res)) {
      .res <- .res %>%
        dplyr::select(-trend)
    }

    xreg <- .res %>%
      dplyr::mutate(date = .date[(model$p + 1):length(.date)]) %>%
      df_to_ts() %>%
      ts_extend(.extend) %>%
      ts_to_df()

    .dates <- xreg[["date"]]

    xreg <- xreg %>%
      dplyr::select(-date)
  }

  res <- stats::predict(
    model,
    n.ahead = nrow(xreg),
    dumvar = xreg
  )
  list(res, .dates)
}
