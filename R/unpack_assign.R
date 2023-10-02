
#' Unpack and assign values to specified names in an environment
#' `r lifecycle::badge("experimental")`
#'
#' @param names A character vector specifying the names of variables to be assigned.
#' @param values A list or vector containing the values to be assigned to the names.
#' @param .envir The environment where the variables will be assigned. Defaults to the global environment.
#' @param .warn Logical flag indicating whether to show a warning message. Defaults to TRUE.
#'
#' @return NULL. The function performs assignments in the specified environment.
#' @export
#'
#' @examples
#' c("x", "y") %<...% list(1, 2)
`%<...%` <- function(names, values, .envir = .GlobalEnv, .warn = TRUE) {
  # Emitir una advertencia si 'warn' es TRUE
  if (.warn) {
    warning("This function assigns variables to the global environment by default. ",
            "This may overwrite existing objects. To assign to a different environment, ",
            "use the '.envir' argument.")
  }

  if (inherits(values, "list")) {
    if (all(names %in% names(values))) {
      for (variable in seq_along(values)) {
        assign(names[variable], values[[names[variable]]], envir = .envir)
      }
    } else {
      for (variable in seq_along(values)) {
        assign(names[variable], values[variable][[1]], envir = .envir)
      }
    }
  } else {
    if (all(names %in% names(values))) {
      for (variable in seq_along(values)) {
        assign(names[variable], values[[names[variable]]], envir = .envir)
      }
    } else {
      for (variable in seq_along(values)) {
        assign(names[variable], values[variable], envir = .envir)
      }
    }
  }
}





#' Wrapper around `%<...%` to unpack and assign values to specified names in an environment
#' `r lifecycle::badge("experimental")`
#'
#' @param values A list or vector containing the values to be assigned to the names.
#' @param names A character vector specifying the names of variables to be assigned.
#' @param .envir The environment where the variables will be assigned. Defaults to the global environment.
#' @param .warn Logical flag indicating whether to show a warning message. Defaults to TRUE.
#'
#' @return NULL. The function performs assignments in the specified environment.
#' @export
#'
#' @examples
#' values <- list(1, 2)
#' names <- c("x", "y")
#' values %...>% names
`%...>%` <- function(values, names, .envir = .GlobalEnv, .warn = TRUE) {
  `%<...%`(names, values, .envir = .envir, .warn = .warn)
}
