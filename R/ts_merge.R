#' ts_merge: Merge Multiple Time Series
#' `r lifecycle::badge("experimental")`
#'
#' Given a list of time series objects, this function merges them based on the "date" column
#' and returns a new time series object with all the data. If the input time series objects are not of class
#' "mts", then the column names will be used to label the respective series in the merged data.
#'
#' @param data A list of time series objects to be merged.
#'
#' @return A merged time series object.
#'
#' @export
#'
#' @examples
#' ts1 <- ts(rnorm(100), start = c(2010, 1), frequency = 12)
#' ts2 <- ts(rnorm(50), start = c(2010, 1), frequency = 12)
#' ts3 <- ts(rnorm(120), start = c(2010, 1), frequency = 12)
#' ts_merge(list(ts1, ts2, ts3))
ts_merge <- function(data){
  res <- list()
  if(is.null(names(data))){
    names(data) <- paste0("ts", 1:length(data))
  }
  for (.ts in names(data)) {
    .data <- data[[.ts]]
    .subres <- .data |>
      ts_to_df()
    if(!"mts" %in% class(.data)){
      names(.subres)[names(.subres) == 'ts'] <- .ts
    }
    if(length(res) == 0){
      res <- .subres
    } else {
      res <- dplyr::full_join(res, .subres, "date")
    }
  }
  res |>
    df_to_ts()
}
