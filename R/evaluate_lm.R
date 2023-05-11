evaluate_lm <- function(model, valid = NULL, test = NULL, .undiff = NULL, .train_stats = TRUE, .resid_tests = TRUE, .metrics = c("rmse", "mae", "mape", "smape"), .transf = NULL, .report = TRUE, ...) {
  rownumberrr <- NULL
  el_grupos <- NULL
  outlier <- NULL
  ts <- NULL
  fitted <- NULL
  residuals <- NULL

  args <- list(...)
  .interactive <- args[[".interactive"]]
  # train |> ts_to_df() |> pull(date) -> .date
  # .transf = c(exp)
  .date <- args[[".date"]]
  .y <- as.character(model$terms[[2]])
  result <- list()
  metric <- list()
  if (!is.null(.date)) {
    if (!is.null(valid)) {
      if (!"ts" %in% class(valid)) {
        stop("The validation data must be a time series, when using the .date argument")
      }
    }
    if (!is.null(test)) {
      if (!"ts" %in% class(test)) {
        stop("The test data must be a time series, when using the .date argument")
      }
    }
    .observed <- model$model[, 1] |> as.data.frame()
    .observed[["date"]] <- .date
    .observed <- df_to_ts(.observed)
    .fitted <- stats::fitted(model) |> as.data.frame()
    .fitted[["date"]] <- .date
    .fitted <- df_to_ts(.fitted)
    .residuals <- stats::residuals(model) |> as.data.frame()
    .residuals[["date"]] <- .date
    .residuals <- df_to_ts(.residuals)
  } else {
    .observed <- model$model[, 1] |> stats::ts()
    .fitted <- stats::fitted(model) |> stats::ts()
    .residuals <- stats::residuals(model) |> stats::ts()
    valid <- valid |> stats::ts()
    test <- test |> stats::ts()
  }

  if (!is.null(.undiff)) {
    .observed <- ts_undiff(.observed, .undiff[[1]], .undiff[[2]])
    .fitted <- ts_undiff(.fitted, .undiff[[1]], .undiff[[2]])
    # .residuals <- .fitted - .observed
    if (!is.null(valid)) {
      .valid <- ts_to_df(valid)
      .valid[[.y]] <- ts_select(valid, .y) |>
        ts_undiff(.undiff[[1]], .undiff[[2]]) |>
        c()
      .valid <- df_to_ts(.valid)
    }
    if (!is.null(test)) {
      .test <- ts_to_df(test)
      .test[[.y]] <- ts_select(test, .y) |>
        ts_undiff(.undiff[[1]], .undiff[[2]]) |>
        c()
      .test <- df_to_ts(.test)
    }
  } else {
    .valid <- valid
    .test <- test
  }

  if (!is.null(.transf)) {
    for (.t in .transf) {
      .observed <- .t(.observed)
      .fitted <- .t(.fitted)
      if (!is.null(valid)) {
        .valid <- .t(.valid)
      }
      if (!is.null(test)) {
        .test <- .t(.test)
      }
    }
  }

  note1 <- NULL

  if (.train_stats) {
    result[["model-summary"]] <- summary(model)

    for (m in .metrics) {
      metric_func <- utils::getFromNamespace(paste0(m, "_vec"), "yardstick")
      if (!is.function(metric_func)) {
        stop(paste0("The function `", m, "` is not available in the `yardstick` package"))
      }
      metric[[m]] <- round(metric_func(c(.observed), c(.fitted)), 4)
    }
    result[["training_metrics"]] <- as.matrix(metric)
    note1 <- "The training metrics are different from those in the model summary because the indicated transformations were applied to the former, while not to the summary ones."
    note2 <- NULL
    result[["correlations"]] <- ggcorrplot::ggcorrplot(stats::cor(model$model), type = "lower", lab = TRUE)
    if (.resid_tests) {
      if (!"package:patchwork" %in% search()) {
        requireNamespace('patchwork')
      }
      result[["residuals-checks"]][["linearity"]] <- .fitted |>
        ts_to_df() |>
        dplyr::rename(fitted = ts) |>
        dplyr::left_join(.residuals |> ts_to_df() |> dplyr::rename(residuals = ts)) |>
        ggplot2::ggplot(ggplot2::aes(x = fitted, y = residuals)) +
        ggplot2::geom_point() +
        ggplot2::geom_smooth(se = F) +
        ggplot2::geom_hline(yintercept = 0, color = "lightgray") +
        ggplot2::theme_bw()
      result[["residuals-checks"]][["normality"]] <- .residuals |>
        ts_to_df() |>
        ggplot2::ggplot(ggplot2::aes(sample = ts)) +
        ggplot2::stat_qq() +
        ggplot2::stat_qq_line() +
        ggplot2::theme_bw()
      result[["residuals-checks"]][["non-heteroscedasticity"]] <- .fitted |>
        ts_to_df() |>
        dplyr::rename(fitted = ts) |>
        dplyr::left_join(.residuals |> ts_to_df() |> dplyr::rename(residuals = ts)) |>
        dplyr::mutate(residuals = residuals / stats::sd(residuals)) |>
        ggplot2::ggplot(ggplot2::aes(x = fitted, y = residuals)) +
        ggplot2::geom_point() +
        ggplot2::geom_smooth() +
        ggplot2::geom_hline(yintercept = 0, color = "lightgray") +
        ggplot2::theme_bw()
      result[["residuals-checks"]][["non-autocorrelation"]] <- .residuals |>
        ts_to_df() |>
        ggplot2::ggplot(ggplot2::aes(x = date, y = ts)) +
        ggplot2::geom_point() +
        ggplot2::theme_bw()
      result[["residuals-checks"]][["unit-root"]] <- .residuals |> tseries::adf.test()

      result[["residuals-plots"]] <-
        (.residuals |>
          ts_to_df() %>%
          dplyr::mutate(outlier = ifelse(.residuals %in% graphics::boxplot(ts, plot = FALSE)$out, "Outlier", "Not Outlier")) %>%
          ggplot2::ggplot(ggplot2::aes(x = date, y = ts, group = 1)) +
          ggplot2::geom_line() +
          ggplot2::geom_point(ggplot2::aes(color = outlier)) +
          ggplot2::geom_hline(yintercept = 0, color = "lightgray") +
          ggplot2::scale_color_manual(values = c("Not Outlier" = "lightblue", "Outlier" = "red")) +
          ggplot2::theme_bw() +
          ggplot2::theme(legend.position = "bottom") +
          ggplot2::scale_color_discrete(guide = ggplot2::guide_legend(NULL)) +
          ggplot2::xlab("") +
          ggplot2::ylab("")) / (
          (.residuals |> ts_acf(.partial = F)) +
            (.residuals |> ts_to_df() |>
              ggplot2::ggplot(ggplot2::aes(x = ts)) +
              ggplot2::geom_density() +
              ggplot2::theme_bw() +
              ggplot2::xlab("") +
              ggplot2::ylab("")
            )
        )
    }
  }







  if (!is.null(valid)) {
    type <- c(
      rep("train", length(c(.observed))),
      rep("valid", nrow(ts_to_df(valid)))
    )
    if (!is.null(test)) {
      type <- c(type, rep("test", nrow(ts_to_df(test))))
    }
    date <- stats::time(ts_concat(list(.observed, ts_select(valid, .y))))
    if (!is.null(test)) {
      date <- stats::time(ts_concat(list(.observed, ts_select(valid, .y), ts_select(test, .y))))
    }
    date <- ts_to_df(date)[["date"]]
    truth <- c(
      .observed,
      ts_select(.valid, .y)
    )
    if (!is.null(test)) {
      truth <- c(truth, ts_select(.test, .y))
    }
    p <- nrow(ts_to_df(valid))
    if (!is.null(test)) {
      p <- p + nrow(ts_to_df(test))
    }
    new_data <- valid
    if (!is.null(test)) {
      new_data <- ts_concat(list(valid, test))
    }
    new_data <- ts_to_df(new_data)
    fcs <- forecast::forecast(model, h = p, newdata = new_data)[["mean"]]
    if (!is.null(.undiff)) {
      fcs <- stats::ts(fcs, start = stats::end(.observed) + c(0, 1), frequency = stats::frequency(.observed))
      fcs <- ts_undiff(fcs, .undiff[[1]], .undiff[[2]])
    }

    if (!is.null(.transf)) {
      for (.t in .transf) {
        fcs <- .t(fcs)
      }
    }

    estimate <- c(
      .fitted,
      fcs
    )

    metric <- c()
    for (m in .metrics) {
      metric_func <- utils::getFromNamespace(paste0(m, "_vec"), "yardstick")
      if (!is.function(metric_func)) {
        stop(paste0("The function `", m, "` is not available in the `yardstick` package"))
      }
      metric[toupper(m)] <- round(metric_func(utils::tail(c(truth), sum(type != "train")), utils::tail(c(estimate), sum(type != "train"))), 4)
    }
    result[["forecast-metrics"]] <- as.matrix(metric)

    res <- data.frame(
      type,
      date,
      truth,
      estimate
    )
    res <- res |>
      dplyr::mutate(rownumberrr = dplyr::row_number()) |>
      split(~rownumberrr)
    if (
      any(
        all("mae" %in% .metrics, "rmse" %in% .metrics)
      )
    ) {
      note2 <- "Some calculations (table and graphs) are done at the row level, so some metrics like 'RMSE' and 'MAE' will give the same results."
    }
    for (.m in .metrics) {
      # if (.m %in% c("rmse")) {
      #  .metrics <- .metrics[.metrics != .m]
      # } else {
      res <- res |>
        purrr::map(calc_metric, .m)
      # }
    }

    res <- dplyr::bind_rows(res) |>
      dplyr::select(-rownumberrr)

    res <- res |>
      dplyr::group_by(el_grupos = type == "train") |>
      dplyr::mutate(dplyr::across(dplyr::all_of(.metrics), dplyr::cummean, .names = "{.col}_cum")) |>
      dplyr::ungroup() |>
      dplyr::select(-el_grupos)

    result[["pred"]] <- utils::tail(res, p) |>
      dplyr::mutate(dplyr::across(dplyr::where(is.numeric), round, 4)) |>
      as.data.frame()

    if (all(!is.null(.interactive), .interactive)) {
      result[["pred"]] <- DT::datatable(result[["pred"]])
    }

    res |>
      ggplot2::ggplot(ggplot2::aes(x = date)) +
      ggplot2::geom_line(ggplot2::aes(y = truth)) +
      ggplot2::geom_line(ggplot2::aes(y = estimate, color = type)) +
      ggplot2::theme_bw() -> result[["plot_pred"]]

    for (m in .metrics) {
      res %>%
        ggplot2::ggplot(ggplot2::aes(x = date)) +
        ggplot2::geom_col(ggplot2::aes(y = !!as.name(m), fill = type)) +
        ggplot2::geom_line(ggplot2::aes(y = !!as.name(paste0(m, "_cum")))) +
        ggplot2::theme_bw() -> result[[paste0("plot_", m)]]
    }
  }
  notes <- c(note1, note2)
  if (length(notes) > 0) {
    result[["notes"]] <- notes
  }












  if (.report) {
    .reporter(result)
    invisible(result)
  } else {
    result
  }
}
