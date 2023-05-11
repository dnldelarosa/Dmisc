# Create a time series object filled with zeros
# `r lifecycle::badge("experimental")`
#
# This function creates a time series object filled with zeros of the same length and frequency as the input
# time series object. If a 'resize' object is provided, the resulting time series object will be resized to
# the length and frequency of the 'resize' object.
#
# @param x A time series object.
# @param resize An optional time series object to be used for resizing the output time series object.
# @param .name An optional name for the output time series object.
#
# @return A time series object of the same length and frequency as 'x', filled with zeros.
#
# @examples
# \dontrun{
# ts_zero(AirPassengers)
# }
ts_zero <- function(x, .name = NULL, resize = NULL) {
  if(!is.null(resize)){
    x <- ts_resize(x, resize)
  }
  x[] <- 0
  if(!is.null(.name)){
    attr(x, ".name") <- .name
  }
  x
}
