#' Time Series Dummy Variable
#' `r lifecycle::badge("experimental")`
#'
#' @param dates dates to set ones
#' @param start time series start date
#' @param end time series end date
#' @param frequency time series frequency
#' @param ... other arguments passed to ts function
#'
#' @return a time series dummy variable
#'
#' @export
#'
#' @examples
#'
#' tsd1 <- ts_dummy(
#'   dates = 2005,
#'   start = 2000,
#'   end = 2021
#' )
#' tsd1
#'
#' tsd2 <- ts_dummy(
#'   dates = c(2005, 3),
#'   start = 2000,
#'   end = c(2021, 4),
#'   frequency = 4
#' )
#' tsd2
#'
#' tsd3 <- ts_dummy(
#'   dates = data.frame(c(2005, 2006), c(8, 11)),
#'   start = 2000,
#'   end = c(2021, 12),
#'   frequency = 12
#' )
#' tsd3
#'
ts_dummy <- function(dates, start = NULL, end = NULL, frequency = NULL, ts = NULL, ...) {
  if (is.null(ts) & is.null(start) & is.null(end) & is.null(frequency)) {
    stop("start, end and frequency must be provided if ts is not provided")
  }
  if (!is.null(ts)) {
    start <- min(time(ts))
    end <- max(time(ts))
    frequency <- frequency(ts)
  }
  res <- list()
  if (class(dates) == "list") {
    for (i in names(dates)) {
      res[[i]] <- ts_dummy0(
        dates = dates[[i]],
        start = start,
        end = end,
        frequency = frequency,
        ...
      )
    }
    res <- do.call(cbind, res)
  } else {
    res <- ts_dummy0(
      dates = dates,
      start = start,
      end = end,
      frequency = frequency,
      ...
    )
  }
  res
}


ts_dummy0 <- function(dates, start = NULL, end = NULL, frequency = NULL, ts = NULL, ...) {
  tsd <- stats::ts(0, start = start, end = end, frequency = frequency, ...)
  if (is.vector(dates)) {
    tsd <- set_ones(tsd, dates, frequency)
  } else {
    for (num in 1:nrow(dates)) {
      tsd <- set_ones(tsd, dates[num, ], frequency)
    }
  }
  tsd
}

set_ones <- function(tsd, date, freq) {
  if (freq == 1) {
    tsd[stats::time(tsd) == date] <- 1
  } else if (freq > 1) {
    tsd[abs(stats::time(tsd) - sum((date - c(0, 1)) / c(1, freq))) < 0.01] <- 1
  }
  tsd
}