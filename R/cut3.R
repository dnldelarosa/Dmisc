#' Convert numeric to factor weighted and by group
#' `r lifecycle::badge("experimental")`
#'
#' @param tbl [data.frame]: Database connection or data.frame
#' @param var_name [character]: variable name
#' @param breaks [numeric]: break points. See \code{base::\link[base:cut]{cut}}
#' @param groups [character]: name of a groups variable
#' @param bf_args [list]: arguments to be passed to break function
#' @param .inf [logical]: indicates if the breaks need to be extended by -Inf and Inf
#' @param ... argument passed to \code{base::\link[base:cut]{cut}}
#'
#' @seealso
#'   \code{vignette("cut3", package = "Dmisc")}
#'   \code{base::\link[base:cut]{cut}}
#'
#' @return same as \code{tbl} input with \code{var_name} converted to factor
#' @export
#'
#' @examples
#' datos <- data.frame(edad = seq(1:100))
#' cut3(datos, "edad", 5)
cut3 <- function(tbl, var_name, breaks, groups = NULL, bf_args = list(), .inf = FALSE , ...) {
  breaks <- breaker(tbl[[var_name]], breaks, bf_args)
  if (.inf){
    breaks <- c(-Inf, breaks, Inf)
  }
  if (!is.null(groups)) {
    tbl[[var_name]] <- as.character(tbl[[var_name]])
    tbl <- dplyr::group_by(tbl, !!rlang::sym(groups))
    tbl <- dplyr::mutate(tbl, !!rlang::sym(var_name) := as.character(cut(as.numeric(!!rlang::sym(var_name)), breaks, ...)))
    tbl[[var_name]] <- as.factor(tbl[[var_name]])
    tbl <- dplyr::ungroup(tbl)
  } else {
    tbl[[var_name]] <- as.factor(cut(tbl[[var_name]], breaks, ...))
  }
  tbl
}




breaker  <- function(.data, breaks, bf_args) {
  if (is.function(breaks)) {
    kargs <- list(.data)
    if(length(bf_args) > 0){
      kargs <- append(kargs, bf_args)
    }
    breaks <- do.call(breaks, kargs)
  } else if(length(breaks) > 1){
    newb <- numeric()
    for (b in breaks) {
      if(is.numeric(b)){
        newb <- append(newb, b)
      } else if(is.function(b)){
        kargs <- list(.data)
        if(length(bf_args) > 0){
          kargs <- append(kargs, bf_args)
        }
        res <- do.call(b, kargs)
        if(is.numeric(res)){
          newb <- append(newb, res)
        } else {
          stop("The function must return a numeric vector of size greater or equal than 1.")
        }
      } else {
        stop("Only numbers or functions that generate numbers can be included.")
      }
    }
    breaks <- newb
  } else if(!is.numeric(breaks)){
    stop("Only numbers or functions that generate numbers can be included.")
  }
  breaks <- unique(breaks)
  breaks
}



#' Cut3 by quantile
#'
#' @param tbl [data.frame]: Database connection or data.frame
#' @param var_name [character]: variable name
#' @param .labels [list]: labels for the breaks
#' @param .groups [character]: name of a groups variable
#' @param .inf [logical]: indicates if the breaks need to be extended by -Inf and Inf
#' @param ... argument passed to quantile
#'
#' @return same as \code{tbl} input with \code{var_name} converted to factor by quantiles
#' @export
#'
#' @examples
#' datos <- data.frame(edad = seq(1:100))
#' cut3_quantile(datos, "edad")
cut3_quantile <- function(tbl, var_name, .labels = NULL, .groups = NULL, .inf = TRUE, ...){
  .probs <- list(...)[["probs"]]
  if(is.null(.probs)){
    .probs <- seq(0.25, 0.75, 0.25)
  }
  .args <- list(...)
  .args <- append(.args, list(probs = .probs))
  Dmisc::cut3(tbl, var_name, stats::quantile, .groups, .args, .inf, labels = .labels)
}
