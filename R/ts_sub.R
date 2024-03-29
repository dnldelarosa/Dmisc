# ts_sub: Subtract two time series
# `r lifecycle::badge("experimental")`
#
# @param ts1 A time series object.
# @param ts2 A time series object.
#
# @return A time series object representing the difference between ts1 and ts2.
# The time frame starts from the end of ts2.
#
#
# @examples
# \dontrun{
# ts1 <- ts(rnorm(100), start = c(2010, 1), frequency = 12)
# ts2 <- ts(rnorm(50), start = c(2010, 1), frequency = 12)
# ts_sub(ts1, ts2)
# }
ts_sub <- function(ts1, ts2){
  stats::window(
    ts1,
    start = stats::end(ts2) + c(0, 1)
  )
}
