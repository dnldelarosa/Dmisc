#' Time Series Dummy Variable
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
#'   tsd1 <- ts_dummy(dates = 2005,
#'                    start = 2000,
#'                    end = 2021)
#'   tsd1
#'
#'   tsd2 <- ts_dummy(dates = c(2005, 3),
#'                    start = 2000,
#'                    end = c(2021, 4),
#'                    frequency = 4)
#'   tsd2
#'
#'   tsd3 <- ts_dummy(dates = data.frame(c(2005, 2006), c(8, 11)),
#'                    start = 2000,
#'                    end = c(2021, 12),
#'                    frequency = 12)
#'   tsd3
#'
ts_dummy <- function(dates, start, end, frequency = 1, ...){
  tsd <- stats::ts(0, start = start, end = end, frequency = frequency, ...)
  if(is.vector(dates)){
    tsd <- set_ones(tsd, dates, frequency)
  } else {
    for(num in 1:nrow(dates)){
      tsd <- set_ones(tsd, dates[num,], frequency)
    }
  }
  tsd
}

set_ones <- function(tsd, date, freq){
  if(freq == 1){
    tsd[stats::time(tsd)==date] <- 1
  } else if(freq > 1){
    tsd[abs(stats::time(tsd)-sum((date-c(0,1))/c(1, freq)))<0.01] <- 1
  }
  tsd
}
