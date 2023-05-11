# Split data into train and test sets
# `r lifecycle::badge("experimental")`
#
# This function splits a dataset into train and test sets.
# The function can handle both time series and regular data frames.
# For time series data, the function splits the data based on time,
# while for regular data frames, it uses the rsample package to split
# the data randomly.
#
# @param data [data.frame]: the data to be split.
# @param prop [numeric]: the proportion of the data to be assigned
# to the training set. If prop is less than 1, it is treated as a
# fraction of the total number of observations in the data.
# If prop is greater than or equal to 1, it is treated as the exact
# number of observations to be assigned to the training set.
# @param val_split [logical]: whether or not to create a validation set.
# If val_split is TRUE, a validation set is created from the test set.
# @param ... : additional arguments passed to the
# rsample::initial_split function.
#
# @return [list]: a list with train, test, and valid (if val_split is TRUE) data sets.
#
# 
#
# @examples
# \dontrun{
# # Time series data
# library(lubridate)
# library(tidyverse)
# ts_data <- ts(
#   data = sin(seq(from = 0, to = 2 * pi, length.out = 100)),
#   start = ymd("2022-01-01"),
#   frequency = 12
# )
# train_test_split(ts_data, prop = 0.8)
#
# # Non-time series data
# data(mtcars)
# train_test_split(mtcars, prop = 0.8)
# }
train_test_split <- function(data, prop = 3 / 4, val_split = FALSE, ...) {
  res <- list()
  if ("ts" %in% class(data)) {
    if (prop < 1) {
      ntest <- ceiling(length(stats::time(data)) * prop)
    } else {
      ntest <- prop
    }
    end <- max(stats::time(data)[1:(length(stats::time(data)) - ntest)])
    start <- max(stats::time(data)[1:(length(stats::time(data)) - ntest + 1)])
    if ("mts" %in% class(data)) {
      res[["train"]] <- stats::window(data, end = end) |> ts_name(attr(data, ".name"))
      res[["test"]] <- stats::window(data, start = start)
    } else {
      res[["train"]] <- stats::window(data, end = end) |> ts_name(attr(data, ".name"))
      res[["test"]] <- stats::window(data, start = start)
    }
    if (val_split) {
      nvalid <- floor(ntest / 2)
      end <- max(stats::time(res[["test"]])[1:(length(stats::time(res[["test"]])) - nvalid)])
      start <- max(
        stats::time(res[["test"]])[1:(length(stats::time(res[["test"]])) - nvalid + 1)]
      )
      if ("mts" %in% class(data)) {
        res[["valid"]] <- stats::window(
          res[["test"]],
          end = end
        ) |> ts_name(attr(data, ".name"))
        res[["test"]] <- stats::window(
          data,
          start = start
        ) |> ts_name(attr(data, ".name"))
      } else {
        res[["valid"]] <- stats::window(
          res[["test"]],
          end = end
        ) |> ts_name(attr(data, ".name"))
        res[["test"]] <- stats::window(
          data,
          start = start
        ) |> ts_name(attr(data, ".name"))
      }
    }
  } else {
    if (!requireNamespace("rsample", quietly = TRUE)) {
      stop("rsample package is required for non-time series data. Please install it using install.packages('rsample')")
    }
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


# Get train set from a dataset split
# `r lifecycle::badge("experimental")`
#
# @param tts [list]: dataset split
#
# @return [data.frame]: train set
#
# 
#
# @examples
# \dontrun{
# warpbreaks
# tts <- Dmisc::train_test_split(tbl, test_size = 0.2)
# train <- train_split(tts)
# }
train_split <- function(tts) {
  tts[["train"]]
}

# Get valiation set from a dataset split (if exists)
# `r lifecycle::badge("experimental")`
#
# @param tts [list]: dataset split
#
# @return [data.frame]: validation set
#
# 
#
# @examples
# \dontrun{
# warpbreaks
# tts <- Dmisc::train_test_split(tbl, test_size = 0.2)
# valid <- valid_split(tts)
# }
valid_split <- function(tts) {
  tts[["valid"]]
}

# Get test set from a dataset split
# `r lifecycle::badge("experimental")`
#
# @param tts [list]: dataset split
#
# @return [data.frame]: test set
#
# 
#
# @examples
# \dontrun{
# warpbreaks
# tts <- Dmisc::train_test_split(tbl, test_size = 0.2)
# test <- test_split(tts)
# }
test_split <- function(tts) {
  tts[["test"]]
}
