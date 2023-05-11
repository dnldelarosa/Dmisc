# STL Plot
#
# This function performs STL (Seasonal-Trend Decomposition of Time Series)
# decomposition on a time series data frame and plots the resulting trend,
# seasonal, and residual components.
#
# @param data A data frame or a time series object.
# @param var_name The name of the variable in df to be decomposed.
# @param date_var The name of the date/time variable in df.
# @param .freq The frequency of the time series.
# @param .select The variables to be selected from df.
# @param .report Whether to print the results.
# @param ... Additional arguments passed to \code{\link{stl}}.
#
# @return A plot of the decompositions of the time series.
# 
# @export 
#
# @examples
#\dontrun{
# data(economics, package = "ggplot2")
# df <- economics
#
# # Plot decomposed time series
# stl_plot(df, var_name = "unemploy", date_var = "date", .freq = 12)
# }
stl_plot <- function(data, var_name = NULL, date_var = "date", .freq = NULL, .select = NULL, .report = TRUE, ...) {
  df <- data
  if ("ts" %in% class(df)) {
    if (!is.null(.select)) {
      df <- df |> ts_select(.select)
    }
    df <- df |> ts_to_df()
  } else {
    if (!is.null(.select)) {
      df <- df |> dplyr::select(dplyr::all_of(.select))
    }
  }
  if (is.null(var_name)) {
    result <- list()
    for (.name in names(df)[names(df) != date_var]) {
      result[[.name]] <- stl_plot0(df, .name, date_var, .freq, ...)
    }
  } else {
    return(stl_plot0(df, var_name, date_var, .freq, ...))
  }
  if (.report) {
    for (.name in names(result)) {
      print(cli::rule(center = .name))
      print(result[[.name]])
    }
    invisible(result)
  } else {
    result
  }
}



stl_plot0 <- function(df, var_name, date_var = "date", .freq = NULL, ...) {
  . <- NULL
  name <- NULL
  value <- NULL
  df |>
    dplyr::select(
      {{ date_var }},
      {{ var_name }}
    ) |>
    df_to_ts(.date = date_var) -> ts_df

  decomposed_ts <- stats::stl(ts_df, s.window = "periodic", ...)

  # trend <- decomposed_ts$time.series[, 1]
  # seasonal <- decomposed_ts$time.series[, 2]
  # residual <- decomposed_ts$time.series[, 3]

  df <- df |>
    dplyr::select({{ date_var }}, {{ var_name }})

  decomposed_ts$time.series[, 1] |>
    xts::as.xts() %>%
    as.data.frame() %>%
    .[["V1"]] -> df[["seasonal"]]

  decomposed_ts$time.series[, 2] |>
    xts::as.xts() %>%
    as.data.frame() %>%
    .[["V1"]] -> df[["trend"]]

  decomposed_ts$time.series[, 3] |>
    xts::as.xts() %>%
    as.data.frame() %>%
    .[["V1"]] -> df[["residual"]]

  df[["date"]] <- df[[date_var]]

  df |>
    tidyr::pivot_longer(-{{ date_var }}) |>
    dplyr::mutate(name = factor(name, levels = c({{ var_name }}, "trend", "seasonal", "residual"))) |>
    ggplot2::ggplot(ggplot2::aes(x = date, y = value)) +
    ggplot2::geom_line() +
    ggplot2::facet_wrap(~name, scales = "free") +
    ggplot2::theme_bw() +
    ggplot2::ylab("") +
    ggplot2::xlab("")
}
