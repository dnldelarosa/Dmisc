# Time series transformation
# `r lifecycle::badge("experimental")`
#
# This function applies a transformation function to the values of a time series object and returns
# a new time series object with the transformed values.
#
# @param .ts A time series object.
# @param .t A transformation function to be applied to the values of the time series.
# @param .subset Optional character vector of column names of the data frame to be subsetted for transformation.
#
# @return A time series object with transformed values.
#
# @examples
# \dontrun{
# # Create a sample time series object
# ts_obj <- ts(1:10, start = c(2020, 1), frequency = 12)
#
# # Apply a transformation function to all columns
# ts_transform(ts_obj, log)
#
# # Apply a transformation function to a subset of columns
# ts_transform(ts_obj, log, .subset = c("Jan", "Feb"))
#}
ts_transform <- function(.ts, .t, .subset = NULL){
  if(is.null(.subset)){
    .ts |>
      ts_to_df() |>
      dplyr::mutate(dplyr::across(-date, .t)) |>
      df_to_ts()
  } else {
    .ts |>
      ts_to_df() |>
      dplyr::mutate(dplyr::across(dplyr::all_of(.subset), .t)) |>
      df_to_ts()
  }
}
