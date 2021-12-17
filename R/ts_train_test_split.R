#' Split dataset into train and test sets
#' `r lifecycle::badge("experimental")`
#'
#' @param tbl [data.frame]: dataset to split
#' @param test_size [numeric]: proportion of the dataset to use as test set
#' @param valid_split [logical]: if TRUE, the test set will be splitted into validation and test set
#' @param ts [logical]: if TRUE, indicates that the dataset is time series
#'
#' @return [list]: a list with the data and the indices for the splits
#'
#' @export
#'
#' @examples
#' \dontrun{
#'  warpbreaks
#'  tts <- train_test_split(tbl, test_size = 0.2)
#'  train <- Dmisc::train_split(tts)
#'  test <- Dmisc::test_split(tts)
#' }
train_test_split <- function(tbl, test_size = 0.2, valid_split = FALSE, ts = FALSE){
  idx <- list()
  idx[["data"]] <- tbl
  if(test_size<1){
    test_size <-  ceiling(nrow(tbl)*test_size)
  }
  idx[["train"]] <- 1:(nrow(tbl) - test_size)
  idx[["test"]] <- (length(idx[["train"]]) + 1):nrow(tbl)
  if(valid_split){
    idx[["valid"]] <- 1:ceiling(length(idx[["test"]])/2) + max(idx[["train"]])
    idx[["test"]] <- (length(idx[["valid"]])+1):length(idx[["test"]]) + max(idx[["train"]])
  }
  idx
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
train_split <- function(tts){
  tts$data[tts[["train"]], ]
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
valid_split <- function(tts){
  tts$data[tts[["valid"]], ]
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
test_split <- function(tts){
  tts$data[tts[["test"]], ]
}
