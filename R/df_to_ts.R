#' Convert a dataframe to a time series object
#' `r lifecycle::badge("experimental")`
#'
#' @param data [data.frame]: a dataframe with the data
#' @param .freq [numeric]: the frequency of the time series. If not specified, it is automatically determined by the data
#' @param .date [character]: the name of the date column in the dataframe
#' @param end [character]: the last observation of the time series. If not specified, it is automatically determined by the data
#'
#' @return a time series object
#'
#' @export
#'
#' @examples
#' \dontrun{
#' data(fdeaths)
#' ts_data <- data.frame(time = time(fdeaths), y = fdeaths)
#' ts <- df_to_ts(ts_data, .freq = 12, .date = "time")
#' }
df_to_ts <- function(data, .freq = NULL, .date = 'date', end = NULL){
  if(!class(data[[.date]]) %in% c("Date", "POSIXct")) {
  stop(".date column is not in date format.")
}
  if(any(diff(data[[.date]]) != difftime(tail(data[[.date]], -1), head(data[[.date]], -1), units = .freq))) {
    stop("Jumps in date column.")
  }
  if(is.null(.freq)){
    .freq <- ts_guest_freq(data, .date)
  }
  .start = min(data[[.date]])
  if(.freq == 1){
    .start = lubridate::year(.start)
  } else if(.freq == 4){
    quarter = as.numeric(format(.start, "%m"))/3
    .start = lubridate::year(.start) + (quarter - 1)/4
  } else if(.freq == 12) {
    .start = lubridate::year(.start) + (lubridate::month(.start)-1)/12
  } else {
    .start <- .start
  }
  if(is.null(end)) {
    end = max(data[[.date]])
    if(.freq == 1){
      end = lubridate::year(end)
    } else if(.freq == 4){
      quarter = as.numeric(format(end, "%m"))/3
      end = lubridate::year(end) + (quarter - 1)/4
    } else if(.freq == 12) {
      end = lubridate::year(end) + (lubridate::month(end)-1)/12
    } else {
      end <- end
    }
  }
  .ts <- ts(data[,names(data) != .date], start = .start, end = end, frequency = .freq)
  if(!'mts' %in% class(.ts)){
    attr(.ts, 'name') <- names(data)[names(data) != .date]
  }
  .ts
}

ts_guest_freq <- function(data, .date){

  if(is.numeric(data[[.date]])){
    data[[.date]] <- paste0(data[[.date]], "-01-01")
  }

  # Guess the frequency
  dates = as.Date(data[[.date]])
  delta = diff(dates)
  mode_delta = as.numeric(names(sort(table(delta), decreasing = T)))[1]
  if(mode_delta < 28){
    .freq = 365.25
  } else if(mode_delta <= 85) {
    .freq = 12
  } else if(mode_delta < 365) {
    .freq = 4
  }else {
    .freq = 1
  }
  .freq
}



df_to_ts_old <- function(data, .freq = NULL, .date = 'date'){
  if(is.null(.freq)){
    .freq <- ts_guest_freq(data, .date)
  }
  .start = min(data[[.date]])
  if(.freq == 1){
    .start = lubridate::year(.start)
  } else if(.freq == 4){
    quarter = as.numeric(format(.start, "%m"))/3
    .start = lubridate::year(.start) + (quarter - 1)/4
  } else if(.freq == 12) {
    .start = lubridate::year(.start) + (lubridate::month(.start)-1)/12
  } else {
    .start <- .start
  }
  ts(data[,names(data) != .date], start = .start, frequency = .freq)
}
