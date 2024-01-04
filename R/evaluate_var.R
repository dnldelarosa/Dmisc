evaluate_var <- function(model, valid = NULL, test = NULL, xreg = NULL, .undiff = NULL, .train_stats = TRUE, .resid_tests = TRUE, .metrics = c("rmse", "mae", "mape", "smape"), .transf = NULL, .report = TRUE, ...) {
  outlier <- NULL
  rownumberrr <- NULL
  el_grupos <- NULL
  value <- NULL
  ts <- NULL
  var <- NULL
  # args <- list(...)
  # .interactive <- args[[".interactive"]]
  result <- list()
  metric <- list()
  if (!is.null(model[["vecm"]])) {
    observed <- model[["vecm"]]@x |>
      ts_to_df()
    .residuals <- model$resid |>
      as.data.frame() |>
      dplyr::rename_with(~ str_remove(.x, "resids of "))
    fitted <- (model[["datamat"]][, 1:(ncol(observed) - 1)] + .residuals) |>
      as.data.frame()
    observed <- observed |>
      utils::tail(nrow(fitted))
    .date <- observed[["date"]]
    observed <- observed |>
      dplyr::select(-date)
  } else {
    observed <- model$varresult |>
      purrr::map(`[[`, "model") |>
      purrr::map(`[[`, "y") |>
      dplyr::bind_cols()
    fitted <- model$varresult |>
      purrr::map(`[[`, "fitted.values") |>
      dplyr::bind_cols()
    .date <- model$y |>
      ts_to_df() |>
      utils::tail(nrow(observed)) |>
      dplyr::pull(date)
    .residuals <- model$varresult |>
      purrr::map(`[[`, "residuals") |>
      dplyr::bind_cols()
  }

  if (!is.null(.undiff)) {
    .original <- .undiff[[1]]
    .nombres <- names(observed)
    .observed <- observed
    .observed[["date"]] <- .date
    .observed <- .observed |> df_to_ts()
    for (.name in .nombres) {
      observed[[.name]] <- ts_undiff(
        ts_select(.observed, .name),
        ts_select(.original, .name),
        .undiff[[2]]
      ) |>
        ts_to_df() |>
        dplyr::pull(ts)
    }



    .fitted <- fitted
    .fitted[["date"]] <- .date
    .fitted <- .fitted |> df_to_ts()
    for (.name in .nombres) {
      fitted[[.name]] <- ts_undiff(
        ts_select(.fitted, .name),
        ts_select(.original, .name),
        .undiff[[2]]
      ) |>
        ts_to_df() |>
        dplyr::pull(ts)
    }


    # for (.name in .nombres) {
    #  .residuals[[.name]] <- fitted[[.name]] - observed[[.name]]
    #  #return(.residuals)
    # }

    if (!is.null(valid)) {
      .valid <- valid |> ts_to_df()
      for (.name in .nombres) {
        .valid[[.name]] <- ts_undiff(
          ts_select(valid, .name),
          ts_select(.original, .name),
          .undiff[[2]]
        )
      }
      valid <- .valid |> df_to_ts()
    }

    if (!is.null(test)) {
      .test <- test |> ts_to_df()
      for (.name in .nombres) {
        .test[[.name]] <- ts_undiff(
          ts_select(test, .name),
          ts_select(.original, .name),
          .undiff[[2]]
        )
      }
      test <- .test |> df_to_ts()
    }
  }

  if (!is.null(.transf)) {
    for (.t in .transf) {
      observed <- observed |>
        dplyr::mutate(dplyr::across(dplyr::everything(), .t))
      fitted <- fitted |>
        dplyr::mutate(dplyr::across(dplyr::everything(), .t))
      if (!is.null(valid)) {
        valid <- valid |>
          ts_to_df() |>
          dplyr::mutate(dplyr::across(-date, .t))
      }
      if (!is.null(test)) {
        test <- test |>
          ts_to_df() |>
          dplyr::mutate(dplyr::across(-date, .t))
      }
    }
  } else {
    if (!is.null(valid)) {
      valid <- valid |>
        ts_to_df()
    }
    if (!is.null(test)) {
      test <- test |>
        ts_to_df()
    }
  }

  note1 <- NULL

  if (.train_stats) {
    if (!is.null(model[["vecm"]])) {
      result[["model-summary"]] <- model
    } else {
      result[["model-summary"]] <- summary(model)
    }

    instalar_paquete_si_falta("yardstick")
    for (m in .metrics) {
      metric_func <- utils::getFromNamespace(paste0(m, "_vec"), "yardstick")
      if (!is.function(metric_func)) {
        stop(paste0("The function `", m, "` is not available in the `yardstick` package"))
      }
      for (.n in names(observed)) {
        metric[[m]][[.n]] <- round(metric_func(observed[[.n]], fitted[[.n]]), 4)
      }
    }
    result[["training_metrics"]] <- metric |>
      purrr::map(dplyr::bind_rows, .id = "var") |>
      dplyr::bind_rows(.id = "metric") |>
      tidyr::pivot_longer(-metric, names_to = "variable") |>
      tidyr::pivot_wider(names_from = metric, values_from = value)
    note1 <- "The training metrics are different from those in the model summary because the indicated transformations were applied to the former, while not to the summary ones."
    note2 <- NULL
    if (.resid_tests) {
      instalar_paquete_si_falta("patchwork")
      if (!"package:patchwork" %in% search()) {
        requireNamespace('patchwork')
      }
      result[["residuals-tests"]][["non-autocorrelation"]] <- vars::serial.test(model)
      result[["residuals-tests"]][["non-heteroscedasticity"]] <- vars::arch.test(model)
      result[["residuals-tests"]][["normality"]] <- vars::normality.test(model)
      result[["residuals-tests"]][["unit-root"]] <- .residuals |>
        purrr::map(tseries::adf.test)

      result[["residuals-plots"]] <- .residuals |>
        purrr::map(\(.x){
          .x <- .x |>
            stats::ts() |>
            ts_to_df()
          .x[["date"]] <- .date
          (.x %>%
            dplyr::mutate(ts = as.numeric(ts), outlier = ifelse(ts %in% graphics::boxplot(ts, plot = FALSE)$out, "Outlier", "Not Outlier")) %>%
            ggplot2::ggplot(ggplot2::aes(x = date, y = c(ts), group = 1)) +
            ggplot2::geom_line() +
            ggplot2::geom_point(ggplot2::aes(color = outlier)) +
            ggplot2::geom_hline(yintercept = 0, color = "lightgray") +
            ggplot2::scale_color_manual(values = c("Not Outlier" = "lightblue", "Outlier" = "red")) +
            ggplot2::theme_bw() +
            ggplot2::theme(legend.position = "bottom") +
            ggplot2::scale_color_discrete(guide = ggplot2::guide_legend(NULL)) +
            ggplot2::xlab("") +
            ggplot2::ylab("")) / (

            (.x |>
              df_to_ts() |>
              ts_acf(.partial = F)) +
              (
                .x |>
                  ggplot2::ggplot(ggplot2::aes(x = ts)) +
                  ggplot2::geom_density() +
                  ggplot2::theme_bw() #+ xlab("") + ylab("")
              )
          )
        })
    }
  }
  if (!is.null(valid)) {
    type <- c(
      rep("train", nrow(observed)),
      rep("valid", nrow(valid))
    )
    if (!is.null(test)) {
      type <- c(type, rep("test", nrow(test)))
    }
    .date <- c(.date, valid$date)
    if (!is.null(test)) {
      .date <- c(.date, test$date)
    }
    truth <- dplyr::bind_rows(observed, valid)
    if (!is.null(test)) {
      truth <- dplyr::bind_rows(truth, test)
    }
    truth[["date"]] <- .date
    p <- nrow(valid)
    if (!is.null(test)) {
      p <- p + nrow(test)
    }
    if ("ts" %in% class(xreg)) {
      xreg <- xreg |>
        ts_to_df() |>
        dplyr::select(-date)
    }
    fcs <- stats::predict(model, n.ahead = p, dumvar = xreg)[["fcst"]] |> # Faltan otros argumentos como xreg
      purrr::map(as.data.frame) |>
      purrr::map(dplyr::pull, 1) |>
      dplyr::bind_cols()

    if (!is.null(.undiff)) {
      .fcs <- stats::ts(fcs, start = stats::end(.observed) + c(0, 1), frequency = stats::frequency(.observed))
      for (.name in .nombres) {
        fcs[[.name]] <- ts_undiff(
          ts_select(.fcs, .name),
          ts_select(.original, .name),
          .undiff[[2]]
        )
      }
    }

    if (!is.null(.transf)) {
      for (.t in .transf) {
        fcs <- fcs |> dplyr::mutate(dplyr::across(dplyr::everything(), .t))
      }
    }
    estimate <- dplyr::bind_rows(fitted, fcs)

    instalar_paquete_si_falta("yardstick")
    metric <- list()
    for (m in .metrics) {
      metric_func <- utils::getFromNamespace(paste0(m, "_vec"), "yardstick")
      if (!is.function(metric_func)) {
        stop(paste0("The function `", m, "` is not available in the `yardstick` package"))
      }
      for (.n in names(estimate)) {
        metric[[m]][[.n]] <- round(metric_func(utils::tail(truth[[.n]], nrow(fcs)), fcs[[.n]]), 4)
      }
    }

    result[["forecast-metrics"]] <- metric |>
      purrr::map(dplyr::bind_rows, .id = "var") |>
      dplyr::bind_rows(.id = "metric") |>
      tidyr::pivot_longer(-metric, names_to = "variable") |>
      tidyr::pivot_wider(names_from = metric, values_from = value)
    res <- list()
    for (.n in names(estimate)) {
      res[[.n]] <- data.frame(
        type,
        date = truth[["date"]],
        truth = truth[[.n]],
        estimate = estimate[[.n]]
      )
    }

    res <- dplyr::bind_rows(res, .id = "var") |>
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
      dplyr::select(-rownumberrr) |>
      dplyr::group_by(var, el_grupos = type == "train") |>
      dplyr::mutate(dplyr::across(dplyr::all_of(.metrics), dplyr::cummean, .names = "{.col}_cum")) |>
      dplyr::ungroup() |>
      dplyr::select(-el_grupos)
    .n <- ifelse(!is.null(test), length(valid) + length(test), length(valid))

    result[["pred"]] <- res |>
      dplyr::group_by(var) |>
      dplyr::slice_tail(n = .n) |>
      dplyr::mutate(dplyr::across(is.numeric, round, 4)) |>
      as.data.frame() |>
      split(~var) |>
      purrr::map(as.data.frame)

    res |>
      ggplot2::ggplot(ggplot2::aes(x = date)) +
      ggplot2::geom_line(ggplot2::aes(y = truth)) +
      ggplot2::geom_line(ggplot2::aes(y = estimate, color = type)) +
      ggplot2::theme_bw() +
      ggplot2::facet_wrap(~var, ncol = 1, scales = "free_y") -> result[["plot_pred"]]

    for (m in .metrics) {
      res %>%
        ggplot2::ggplot(ggplot2::aes(x = date)) +
        ggplot2::geom_col(ggplot2::aes(y = !!as.name(m), fill = type)) +
        ggplot2::geom_line(ggplot2::aes(y = !!as.name(paste0(m, "_cum")))) +
        ggplot2::theme_bw() +
        ggplot2::scale_y_continuous(labels = scales::comma) +
        ggplot2::facet_wrap(~var, scales = dplyr::if_else(stringr::str_detect(m, "mape"), "fixed", "free_y")) -> result[[paste0("plot_", m)]]
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
