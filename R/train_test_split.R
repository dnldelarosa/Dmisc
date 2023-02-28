#' Split data into train and test sets
#'
#' This function splits a dataset into train and test sets. The function can handle both time series and regular data frames. For time series data, the function splits the data based on time, while for regular data frames, it uses the rsample package to split the data randomly.
#'
#' @param data [ts or data.frame]: the dataset to be split
#' @param prop [numeric]: the proportion of the data to be assigned to the training set. If prop is less than 1, it is treated as a fraction of the total number of observations in the data. If prop is greater than or equal to 1, it is treated as the exact number of observations to be assigned to the training set.
#' @param val_split [logical]: whether or not to create a validation set. If val_split is TRUE, a validation set is created from the test set.
#' @param ... [named arguments]: additional arguments passed to rsample::initial_split for non-time series data.
#'
#' @return [list]: a list with train, test, and valid (if val_split is TRUE) data sets.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Time series data
#' library(lubridate)
#' library(tidyverse)
#' ts_data <- ts(data = sin(seq(from = 0, to = 2 * pi, length.out = 100)), start = ymd("2022-01-01"), frequency = 12)
#' train_test_split(ts_data, prop = 0.8)
#'
#' # Non-time series data
#' data(mtcars)
#' train_test_split(mtcars, prop = 0.8)
#' }
train_test_split <- function(data, prop = 3 / 4, val_split = FALSE, ...) {
  res <- list()
  if ("ts" %in% class(data)) {
    if (prop < 1) {
      ntest <- ceiling(length(time(data)) * prop)
    } else {
      ntest <- prop
    }
    end <- max(time(data)[1:(length(time(data)) - ntest)])
    start <- max(time(data)[1:(length(time(data)) - ntest + 1)])
    res[["train"]] <- window(data, end = end)
    res[["test"]] <- window(data, start = start)
    if (val_split) {
      nvalid <- floor(ntest / 2)
      end <- max(time(res[["test"]])[1:(length(time(res[["test"]])) - nvalid)])
      start <- max(time(res[["test"]])[1:(length(time(res[["test"]])) - nvalid + 1)])
      res[["valid"]] <- window(res[["test"]], end = end)
      res[["test"]] <- window(data, start = start)
    }
  } else {
    if (prop >= 1) {
      prop <- prop / nrow(data)
    }
    is <- rsample::initial_split(data, prop = prop, ...)
    res[["train"]] <- rsample::training(is)
    res[["test"]] <- rsample::testing(is)
    if (val_split) {
      is <- rsample::initial_split(res[["test"]], prop = 0.5, ...)
      res[["valid"]] <- rsample::training(is)
      res[["test"]] <- rsample::testing(is)
    }
  }
  res
}


#' Get train set from a dataset split
#' `r lifecycle::badge("experimental")`
#'
#' @param tts [list]: dataset split
#'
#' @return [data.frame]: train set
#'
#' @export
#'
#' @examples
#' \dontrun{
#' warpbreaks
#' tts <- Dmisc::train_test_split(tbl, test_size = 0.2)
#' train <- train_split(tts)
#' }
train_split <- function(tts) {
  tts[['train']]
}

#' Get valiation set from a dataset split (if exists)
#' `r lifecycle::badge("experimental")`
#'
#' @param tts [list]: dataset split
#'
#' @return [data.frame]: validation set
#'
#' @export
#'
#' @examples
#' \dontrun{
#' warpbreaks
#' tts <- Dmisc::train_test_split(tbl, test_size = 0.2)
#' valid <- valid_split(tts)
#' }
valid_split <- function(tts) {
  tts[["valid"]]
}

#' Get test set from a dataset split
#' `r lifecycle::badge("experimental")`
#'
#' @param tts [list]: dataset split
#'
#' @return [data.frame]: test set
#'
#' @export
#'
#' @examples
#' \dontrun{
#' warpbreaks
#' tts <- Dmisc::train_test_split(tbl, test_size = 0.2)
#' test <- test_split(tts)
#' }
test_split <- function(tts) {
  tts[["test"]]
}
