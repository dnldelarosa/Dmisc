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

train_split <- function(tts){
  tts$data[tts[["train"]], ]
}

valid_split <- function(tts){
  tts$data[tts[["valid"]], ]
}

test_split <- function(tts){
  tts$data[tts[["test"]], ]
}
