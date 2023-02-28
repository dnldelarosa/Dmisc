#' Create a time series object filled with zeros
#'
#' This function creates a time series object filled with zeros of the same length and frequency as the input
#' time series object. If a 'resize' object is provided, the resulting time series object will be resized to
#' the length and frequency of the 'resize' object.
#'
#' @param x A time series object.
#' @param resize An optional time series object to be used for resizing the output time series object.
#'
#' @return A time series object of the same length and frequency as 'x', filled with zeros.
#'
#' @examples
#' ts_zero(AirPassengers)
ts_zero <- function(x, resize = NULL) {
  if(!is.null(resize)){
    if(frequency(x) != frequency(resize)){
      stop("Frequency of input time series and resize time series do not match.")
    }
    x <- window(x, start = start(resize), end = end(resize), frequency = frequency(resize), extend = TRUE)
  }
  x[] <- 0
  x
}
