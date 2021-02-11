#' Convert numeric to factor weighted and by group
#'
#'   `r lifecycle::badge("experimental")`
#'
#' @param tbl [data.frame]: Database connection or data.frame
#' @param var_name [character]: variable name
#' @param breaks [numeric]: break points. See \code{base::\link[base:cut]{cut}}
#' @param groups [character]: name of a numeric variable of groups
#' @param ... argument passed to cut and/or breaks functions
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
cut3  <- function(tbl, var_name, breaks, groups = NULL, ...) {
  if (is.function(breaks)) {
    breaks <- breaks(tbl, var_name, ...)
  } else if(length(breaks) > 1){
    newb <- numeric()
    for (b in breaks) {
      if(is.numeric(b)){
        newb <- append(newb, b)
      } else if(is.function(b)){
        res <- b(tbl, var_name, ...)
        if(is.numeric(res)){
          newb <- append(newb, res)
        } else {
          stop("La funci\u00F3n debe retornar un vector num\u00E9rico de tama\u00F1o mayor o igual a 1.")
        }
      } else {
        stop("Solo se pueden incluir n\u00FAmeros o funciones que generen n\u00FAmeros.")
      }
    }
    breaks <- newb
  } else if(!is.numeric(breaks)){
    stop("Solo se pueden incluir n\u00FAmeros o funciones que generen n\u00FAmeros.")
  }
  if(!is.null(groups)){
    tbl[[var_name]] <- as.character(tbl[[var_name]])
    for (group in unique(tbl[[groups]])) {
      tbl[tbl[[groups]] == group, var_name] <- as.character(cut(as.numeric(tbl[tbl[[groups]] == group, var_name]), breaks, ...))
    }
    tbl[[var_name]] <- as.factor(tbl[[var_name]])
  } else {
    tbl[[var_name]] <- cut(tbl[[var_name]], breaks, ...)
  }
  tbl
}


#' Cut3: quantiles
#'
#'   `r lifecycle::badge("experimental")`
#'
#'  Helper function for convert numeric variables into categorical variables
#'   based on their own quantiles.
#'
#' @param tbl [data.frame]: Database connection or data.frame
#' @param var_name [character]: variable name
#' @param weights [character]: name of a numeric variable of weights
#' @param probs See \code{Hmisc::\link[Hmisc:wtd.quantile]{wtd.quantile}}
#' @param ... other arguments passed to quantile functions
#'
#' @seealso
#'   \code{vignette("cut3", package = "Dmisc")}
#'
#' @return vector of specified quantiles
#' @export
#'
#' @examples
#'   (tbl <- data.frame(
#'     edad = 1:10,
#'     peso = round(runif(10)*10),
#'     grupo = sample(c("H", "M"), 10, replace = TRUE)))
#'
#'     cut3(tbl,
#'          "edad",
#'          c(0, cut3_quantiles),
#'          labels = c("1", "2", "3", "4"),
#'          groups = "grupo",
#'          weights = "peso",
#'          probs = c(0.25, 0.5, 0.75, 1))

cut3_quantiles <- function(tbl, var_name, weights, probs, ...) {
  if(is.null(weights)){
    stats::quantile(as.numeric(tbl[[var_name]]), probs = probs)
  } else {
    Hmisc::wtd.quantile(as.numeric(tbl[[var_name]]), tbl[[weights]], probs = probs)
  }
}
