# Convert time series to data frame
# `r lifecycle::badge("experimental")`
#
# This function takes a time series and converts it to a data frame with a date column and a value column.
#
# @param ts A time series object.
# @param as_date A boolean indicating whether the output should have a date column. Default is TRUE.
# @param .name A character string specifying the name of the value column. If not specified, the column name will be taken from the name attribute of the time series object.
# @param ... Additional arguments passed to functions.
#
# @return A data frame with columns date and .name.
#
#
# @examples
# \dontrun{
# data(AirPassengers)
# ts_to_df(AirPassengers)
# ts_to_df(AirPassengers, .name = "air_passengers")
# }
ts_to_df <- function(ts, as_date = TRUE, .name = NULL, ...){
  year <- NULL
  month <- NULL
  x <- NULL
  months <- .ts_months(stats::frequency(ts))
  res <- ts |>
    stats::time() |>
    as.data.frame() |>
    stats::setNames(c("x")) |>
    dplyr::mutate(x = format(x, nsmall = 4)) |>
    tidyr::separate(col = x, into = c("year", "month"), sep = "\\.") |>
    dplyr::mutate(year = as.numeric(year), month = months[month]) |>
    #tidyr::replace_na(list(month = ifelse(freq == 4, 3, 1))) |>
    cbind(ts)
  if(as_date){
  res <- res |>
    vars_to_date(year = "year", month = "month")
  }
  if(!is.null(.name)){
    res <- stats::setNames(res, c("date", .name))
  } else {
    if(!'mts' %in% class(ts)){
      if(!is.null(attr(ts, '.name'))){
        res <- stats::setNames(res, c("date", attr(ts, '.name')))
      }
    }
  }
  res |>
    dplyr::mutate(dplyr::across(-date, as.numeric))
}

.ts_months <- function(frequency){

  months <- c(
    "0000" = 1,
    "0833" = 2,
    "1667" = 3,
    "2500" = 4,
    "3333" = 5,
    "4167" = 6,
    "5000" = 7,
    "5833" = 8,
    "6667" = 9,
    "7500" = 10,
    "8333" = 11,
    "9167" = 12
  )

  if(frequency == 4){
    months = months + 2
  }
  months
}
