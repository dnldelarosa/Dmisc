revert_scale <- function(scaled_data, center = NULL, scale = NULL) {
  if(is.null(center)){
    center <- attr(scaled_data, 'scaled:center')
  }
  if(is.null(scale)){
    scale <- attr(scaled_data, 'scaled:scale')
  }
  (scaled_data * scale) + center
}



ts_scale <- function(ts, center = TRUE, scale = TRUE) {
  if('mts' %in% class(ts)){
    stop("Not implemented for mts.")
  }
  ts(
    scale(ts, center, scale),
    start = stats::start(ts),
    end = stats::end(ts),
    frequency = stats::frequency(ts)
  )
}

scale2 <- function(data, scaled){
  media <- attr(scaled, 'scaled:center')
  de <- attr(scaled, 'scaled:scale')

  ts_scale(data, media, de)
}
