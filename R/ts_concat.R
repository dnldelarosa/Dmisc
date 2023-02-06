#' Concatenate Time Series Objects
#'
#' The function ts_concat concatenates time series objects into one time series
#' object. If the input is a list of time series objects, then it first converts
#' each time series object to a data frame using the as.data.frame function, and
#' then concatenates the resulting data frames using the dplyr::bind_rows function.
#' If the input is not a list, it converts it to a time series object using the
#' ts function.
#'
#' @param x A list of time series objects or a time series object.
#'
#' @return A time series object.
#'
#' @export
#'
#' @examples
#' data(airlines)
#'
#' # Concatenating a list of time series objects
#' x <- list(airlines[1:5], airlines[6:10])
#' ts_concat(x)
ts_concat <- function(x) {
  if ("mts" %in% class(x[[1]])) {
    purrr::map(x, as.data.frame) |>
      dplyr::bind_rows() |>
      ts(
      start = start(x[[1]]),
      frequency = frequency(x[[1]])
    )
  } else {
    x |>
      unlist() |>
      ts(
        start = start(x[[1]]),
        frequency = frequency(x[[1]])
      )
  }
}
