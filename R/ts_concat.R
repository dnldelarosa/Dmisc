# Concatenate Time Series Objects
#
# The function ts_concat concatenates time series objects into one time series
# object. If the input is a list of time series objects, then it first converts
# each time series object to a data frame using the as.data.frame function, and
# then concatenates the resulting data frames using the dplyr::bind_rows function.
# If the input is not a list, it converts it to a time series object using the
# ts function.
#
# @param ... Time series objects to be concatenated.
#
# @return A time series object.
#
#
# @examples
# \dontrun{
# data(airlines)
#
# # Concatenating a list of time series objects
# x <- list(airlines[1:5], airlines[6:10])
# ts_concat(x)
# }
ts_concat <- function(...) {
  x <- list(...)
  #.freq <- ts_guest_freq(ts_to_df(x), "date")
    purrr::map(x, ts_to_df) |>
      dplyr::bind_rows() |>
      .check_continuity2() |>
      df_to_ts()
}


# Esta funciona solo con 2 ts
.check_continuity <- function(ts1, ts2){
  .last <- ts1 |>
    ts_to_df() |>
    dplyr::pull(date) |>
    utils::tail(1)
  .first <- ts2 |>
    ts_to_df() |>
    dplyr::pull(date) |>
    utils::head(1)
  .valid <- ts1 |>
    ts_to_df() |>
    dplyr::pull(date) |>
    diff() |>
    unique()
  if(!diff(.first, .last) %in% .valid){
    stop("Supplied time series aren't contiguous!")
  }
}



.check_continuity2 <- function(datos){
  .date <- datos[["date"]]
  .d <- diff(.date) |> as.numeric()
  .qs <- stats::quantile(.d, c(0.25, 0.75))
  .q1 <- .qs[[1]]
  .q3 <- .qs[[2]]
  .iqr <- (.q3 - .q1)*2.5
  .mean <- mean(.d)
  .out <- !dplyr::between(.d, .mean - .iqr, .mean + .iqr)
  if(sum(.out) > 0){
    stop("Supplied time series aren't contiguous!", call. = FALSE)
  }
  datos
}


