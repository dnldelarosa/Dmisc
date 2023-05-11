train_test_plot <- function(..., .select = NULL) {
  value <- NULL
  group <- NULL
  data <- list(...)
  res <- list()
  .exclude <- c("group")
  for (.name in names(data)) {
    if ("ts" %in% class(data[[.name]])) {
      .data <- data[[.name]]
      if (!is.null(.select)) {
        .data <- .data |> ts_select(.include = .select)
      }
      .data <- .data |> ts_to_df()
      .exclude <- append(.exclude, "date")
    } else {
      .data <- data[[.name]]
      if (!is.null(.select)) {
        .data <- dplyr::select(.data, .select)
      }
    }
    res[[.name]] <- .data
  }
  .exclude <- unique(.exclude)
  res |>
    dplyr::bind_rows(.id = "group") |>
    tidyr::pivot_longer(-.exclude) |>
    ggplot2::ggplot(ggplot2::aes(x = date, y = value, color = group)) +
    ggplot2::geom_line() +
    ggplot2::facet_wrap(~name, ncol = 1, scales = "free_y") +
    ggplot2::theme_bw() +
    ggplot2::ylab("") +
    ggplot2::xlab("") +
    ggplot2::theme(legend.position = "bottom")
}
