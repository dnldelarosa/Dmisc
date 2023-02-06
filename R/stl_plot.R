#' STL Plot
#'
#' This function performs STL (Seasonal-Trend Decomposition of Time Series)
#' decomposition on a time series data frame and plots the resulting trend,
#' seasonal, and residual components.
#'
#' @param df A data frame with time series data.
#' @param var_name The name of the variable in df to be decomposed.
#' @param date_var The name of the date/time variable in df.
#' @param .freq The frequency of the time series.
#'
#' @return A plot of the decompositions of the time series.
#' @export
#'
#' @examples
#'
#' data(economics, package = "ggplot2")
#' df <- economics
#'
#' # Plot decomposed time series
#' stl_plot(df, var_name = "unemploy", date_var = "date", .freq = 12)
stl_plot <- function(df, var_name, date_var = "date", .freq = 4){
  df |>
    #drop_na() |>
    pull({{var_name}}) |>
    ts(c(year(min(as.Date(data$date))), month(min(as.Date(data$date)))/(12/.freq)), frequency = .freq) -> ts_df

  decomposed_ts <- stl(ts_df, s.window = "periodic")

  trend <- decomposed_ts$time.series[, 1]
  seasonal <- decomposed_ts$time.series[, 2]
  residual <- decomposed_ts$time.series[, 3]

  df <- df |>
    select({{date_var}}, {{var_name}})

  decomposed_ts$time.series[, 1] |>
    xts::as.xts() %>%
    as.data.frame() %>%
    .[["V1"]] -> df[['seasonal']]

  decomposed_ts$time.series[, 2] |>
    xts::as.xts() %>%
    as.data.frame() %>%
    .[["V1"]] -> df[['trend']]

  decomposed_ts$time.series[, 3] |>
    xts::as.xts() %>%
    as.data.frame() %>%
    .[["V1"]] -> df[['residual']]

  df[['date']] <- df[[date_var]]

  df |>
    pivot_longer(-{{date_var}}) |>
    mutate(name = factor(name, levels = c({{var_name}}, "trend", "seasonal", "residual"))) |>
    ggplot(aes(x = date, y = value)) +
    geom_line() +
    facet_wrap(~name, scales = "free")
}
