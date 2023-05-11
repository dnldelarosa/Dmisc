# ts_ggplot: Time Series Visualization with ggplot2
# `r lifecycle::badge("experimental")`
#
# This function creates a ggplot object for time series data.
#
# @param ts A time series object
# @param .facet a logical value. When TRUE (default), the plot will have a facet for each series.
# @param .hline a numeric value to add a horizontal line to the plot.
# @param .ncol the number of columns to use in the facet.
# @param .select a character vector indicating which columns to select.
#
# @return A ggplot object representing the time series.
#
# @examples
# \dontrun{
# # Load the 'nottem' dataset
# data(nottem)
#
# # Create a time series plot
# ts_ggplot(nottem, .facet = TRUE, .hline = 50)
# }
#
ts_ggplot <- function(ts, .facet = TRUE, .hline = NULL, .ncol = 1, .select = NULL) {
  name <- NULL
  value <- NULL
  if (!is.null(.select)) {
    ts <- ts |>
      ts_select(.select)
  }
  ts |>
    ts_to_df() |>
    tidyr::pivot_longer(-date) |>
    ggplot2::ggplot(ggplot2::aes(x = date, y = value, color = name)) +
    ggplot2::geom_line() -> gplot
  if (!is.null(.hline)) {
    gplot <- gplot +
      ggplot2::geom_hline(yintercept = .hline, color = "lightgray")
  }
  if (.facet) {
    gplot +
      ggplot2::facet_wrap(~name, scales = "free_y", ncol = .ncol) -> gplot
  }
  gplot <- gplot +
    ggplot2::theme_bw() +
    ggplot2::ylab("") +
    ggplot2::xlab("")
  if (!"mts" %in% class(ts)) {
    gplot <- gplot +
      ggplot2::theme(legend.position = "none")
  }
  gplot
}
