# Time Series Dummy Variable
# `r lifecycle::badge("experimental")`
#
# This function creates a time series dummy variable based on provided dates.
#
# @param dates The dates to set ones.
# @param start The time series start date.
# @param end The time series end date.
# @param frequency The time series frequency.
# @param ts A time series object.
# @param method The method used for the comparison between the time series and the dates. It can be one of "<", "<=", "==", ">=", ">".
#
# @return A time series dummy variable.
#
# @export
#
# @examples
# tsd1 <- ts_dummy(dates = 2005, start = 2000, end = 2021)
# tsd1
# tsd2 <- ts_dummy(dates = c(2005, 3), start = 2000, end = c(2021, 4), frequency = 4)
# tsd2
# tsd3 <- ts_dummy(dates = data.frame(c(2005, 2006), c(8, 11)), start = 2000, end = c(2021, 12), frequency = 12)
# tsd3
#
# @seealso \code{\link{ts}} for information on time series objects.
# @seealso \code{\link{ts_to_df}} for converting time series objects to data frames.
ts_dummy <- function(dates, start = NULL, end = NULL, frequency = NULL, .name = NULL, ts = NULL, method = "==", ...) {
  if (is.null(ts) & is.null(start) & is.null(end) & is.null(frequency)) {
    stop("start, end and frequency must be provided if ts is not provided")
  }
  if (!is.null(ts)) {
    start <- min(stats::time(ts))
    end <- max(stats::time(ts))
    frequency <- stats::frequency(ts)
  }
  res <- list()
  if (inherits(dates, 'list')) {
    for (i in names(dates)) {
      res[[i]] <- ts_dummy0(
        dates = dates[[i]],
        start = start,
        end = end,
        frequency = frequency,
        .method = method,
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
      .method = method,
      ...
    )
    if(!is.null(.name)){
      attr(res, '.name') <- .name
    }
  }
  res
}


ts_dummy0 <- function(dates, start = NULL, end = NULL, frequency = NULL, .name = NULL, ts = NULL, .method, ...) {
  tsd <- stats::ts(0, start = start, end = end, frequency = frequency, ...)
  if (is.vector(dates)) {
    tsd <- set_ones(tsd, dates, frequency, .method)
  } else {
    for (num in 1:nrow(dates)) {
      tsd <- set_ones(tsd, dates[num, ], frequency, .method)
    }
  }
  tsd
}

set_ones <- function(tsd, date, freq, .method) {
  if (!.method %in% c("<", "<=", "==", ">", ">=")) {
    stop("Invalid comparison operator.")
  }
  months <- .ts_months(freq)
  if (freq == 1) {
    if (.method == "==") {
      tsd[abs(eval(parse(text = paste0("stats::time(tsd) - date")))) <= 0.0001] <- 1
    } else {
      tsd[eval(parse(text = paste0("stats::time(tsd)", .method, "date")))] <- 1
    }
  } else if (freq > 1) {
    if (.method == "==") {
      tsd[abs(eval(parse(text = paste0("stats::time(tsd) - sum((date - c(0, 1)) / c(1, freq))")))) <= 0.0001] <- 1
    } else {
      tsd[eval(parse(text = paste0("stats::time(tsd)", .method, "sum((date - c(0, 1)) / c(1, freq))")))] <- 1
    }
  }
  tsd
}
