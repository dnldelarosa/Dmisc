#' Convert numeric to factor weighted and by group
#' `r lifecycle::badge("experimental")`
#'
#' @param tbl [data.frame]: Database connection or data.frame
#' @param var_name [character]: variable name
#' @param breaks [numeric]: break points. See \code{base::\link[base:cut]{cut}}
#' @param groups [character]: name of a groups variable
#' @param bf_args [list]: arguments to be passed to break function
#' @param ... argument passed to cut
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
cut3  <- function(tbl, var_name, breaks, groups = NULL, bf_args = list(), ...) {
  if (is.function(breaks)) {
    breaks <- do.call(breaks, bf_args)
  } else if(length(breaks) > 1){
    newb <- numeric()
    for (b in breaks) {
      if(is.numeric(b)){
        newb <- append(newb, b)
      } else if(is.function(b)){
        res <- do.call(b, bf_args)
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
  if(!is.null(groups)){
    tbl[[var_name]] <- as.character(tbl[[var_name]])
    for (group in unique(tbl[[groups]])) { # use split-apply-combine strategy
      tbl[tbl[[groups]] == group, var_name] <- as.character(cut(as.numeric(tbl[tbl[[groups]] == group, var_name]), breaks, ...))
    }
    tbl[[var_name]] <- as.factor(tbl[[var_name]])
  } else {
    tbl[[var_name]] <- cut(tbl[[var_name]], breaks, ...)
  }
  tbl
}
