revert_scale <- function(scaled_data, center = NULL, scale = NULL) {
  if(is.null(center)){
    center <- attr(scaled_data, 'scaled:center')
  }
  if(is.null(scale)){
    scale <- attr(scaled_data, 'scaled:scale')
  }
  (scaled_data * scale) + center
}


ts_revert_scale <- function(ts, center = NULL, scale = NULL) {
  if('mts' %in% class(ts)){
    stop("Not implemented for mts.")
  }
  .res <- revert_scale(ts, center, scale)
  attr(.res, 'scaled:center') <- NULL
  attr(.res, 'scaled:scale') <- NULL
  .res
}



ts_scale <- function(ts, center = TRUE, scale = TRUE) {
  if('mts' %in% class(ts)){
    stop("Not implemented for mts.")
  }
  scaled <- scale(ts, center, scale)
  .res <- ts(
    scaled,
    start = stats::start(ts),
    end = stats::end(ts),
    frequency = stats::frequency(ts)
  )
  attr(.res, 'scaled:center') <- attr(scaled, 'scaled:center')
  attr(.res, 'scaled:scale') <- attr(scaled, 'scaled:scale')
  .res
}

scale2 <- function(data, scaled){
  media <- attr(scaled, 'scaled:center')
  de <- attr(scaled, 'scaled:scale')

  ts_scale(data, media, de)
}
