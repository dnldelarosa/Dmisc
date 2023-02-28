#' Unpack assignments
#'  `r lifecycle::badge("experimental")`
#'
#' @param names A character vector of names for the assignments.
#' @param values A vector/list/data.frame of values for the assignments.
#'
#' @return NULL. Assignments are made in the global environment.
#' @export
#'
#' @examples
#' \dontrun{
#' # Assignment by position
#' c("num1", "num2") %<...% c(1, 2)
#'
#' #> num1
#' #> [1] 1
#'
#' # Assignment by name
#' c("num1", "num2") %<...% list(num2 = 1, num1 = 2)
#'
#' #> num1
#' #> [1] 2
#' }
`%<...%` <- function(names, values) {
  if (class(values) == "list") {
    if (all(names %in% names(values))) {
      for (variable in seq_along(values)) {
        assign(names[variable], values[[names[variable]]], envir = .GlobalEnv)
      }
    } else {
      for (variable in seq_along(values)) {
        assign(names[variable], values[variable][[1]], envir = .GlobalEnv)
      }
    }
  } else {
    if (all(names %in% names(values))) {
      for (variable in seq_along(values)) {
        assign(names[variable], values[[names[variable]]], envir = .GlobalEnv)
      }
    } else {
      for (variable in seq_along(values)) {
        assign(names[variable], values[variable], envir = .GlobalEnv)
      }
    }
  }
}



#' Unpack right assignments
#'  `r lifecycle::badge("experimental")`
#'
#' @param values A vector/list/data.frame of values for the assignments.
#' @param names A character vector of names for the assignments.
#'
#' @return NULL. Assignments are made in the global environment.
#' @export
#'
#' @examples
#' \dontrun{
#' c(1, 2) %...>% c("num1", "num2")
#' }
`%...>%` <- function(values, names) {
  names %<...% values
}
