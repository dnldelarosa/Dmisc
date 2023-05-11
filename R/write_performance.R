.write_performance <- function(.eval, .board = pins::board_folder("./pins/performance/", versioned = TRUE), .params = NULL, .interactive = FALSE) {
  . <- NULL
  if (.interactive | !interactive()) {
    .metrics <- .eval[["forecast-metrics"]]
    if (!stringr::str_detect(stringr::str_to_lower(.params$model), "var")) {
      .metrics <- .metrics |>
        t()
    }
    .metrics <- .metrics |>
      as.data.frame() |>
      dplyr::mutate(
        # variable = .params$variable,
        model = .params$model,
        form = .params$form,
        transf = .params$transf
      )

    if (!is.null(.params$variable)) {
      .metrics <- .metrics %>%
        dplyr::mutate(
          variable = .params$variable
        )
    }

    .metrics %T>%
      pins::pin_write(.board, ., .params$model, type = "csv")
  }
}
