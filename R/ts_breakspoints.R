ts_breakpoints <- function(.ts, n = NULL, .bps = c("s", "a", "n"), ...) {
  if (length(.bps) > 1) {
    .bps <- .bps[[1]]
  }
  if (is.null(n)) {
    n <- min(3, ceiling(length(.ts) / (stats::frequency(.ts) * 3)))
  }
  res <- purrr::map(1:n, function(.x) {
    bps <- strucchange::breakpoints(ts_data ~ 1, breaks = .x, ...)
    .bps <- bps[["breakpoints"]]
    .ts |>
      ts_ggplot() -> .gplot
    for (.bp in .bps) {
      .gplot <- .gplot +
        ggplot2::geom_vline(xintercept = ts_to_df(.ts)[["date"]][[.bp]], linetype = "dashed")
    }
    .gplot
  })
  bps <- strucchange::breakpoints(ts_data ~ 1, breaks = n, ...)
  if (.bps == "s") {
    res[["bps"]] <- summary(bps)
  } else if (.bps == "a") {
    res[["bps"]] <- bps
  }
  res
}
