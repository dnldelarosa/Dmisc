# ts_select: Select columns from a time series
# r lifecycle::badge("experimental")
#
# This function allows the user to select columns from a time series object
# using column names, while keeping the time series format.
#
# @param data A time series object.
# @param .include Character vector of column names to include.
# @param .exclude Character vector of column names to exclude.
#
# @return A time series object containing the columns selected.
#
#
# @examples
# \dontrun{
# data(ausair)
# ts_select(ausair, .include = c("Q2", "Q3", "Q4"))
# ts_select(ausair, .exclude = "Q1")
# }
ts_select <- function(data, .include = NULL, .exclude = NULL){
  if(all(is.null(.include), is.null(.exclude))){
    return(data)
  }
  if(!"mts" %in% class(data)){
    stop("data must be multivariate time series object")
  }
  data <- data |>
    ts_to_df()
  if(!is.null(.include)){
    .include <- .include[.include != "date"]
    data <- data |>
      dplyr::select(date, dplyr::all_of(.include))
  }
  if(!is.null(.exclude)){
    .exclude <- .exclude[.exclude != "date"]
    data <- data |>
      dplyr::select(-dplyr::all_of(.exclude))
  }
  data |>
    df_to_ts()
}
