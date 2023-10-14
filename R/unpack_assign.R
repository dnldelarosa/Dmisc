
# Unpack and assign values to specified names in an environment
# `r lifecycle::badge("experimental")`
#
# @param names A character vector specifying the names of variables to be assigned.
# @param values A list or vector containing the values to be assigned to the names.
# @param ... Additional arguments, including
#   \itemize{
#     \item{.envir}{The environment where the variables will be assigned. Defaults to the global environment.}
#     \item{.warn}{Logical flag indicating whether to show a warning message. Defaults to TRUE.}
#   }
#
# @return NULL. The function performs assignments in the specified environment.
#
#
# @rdname unpkg-assign
#
# @examples
# \dontrun{
# c("x", "y") %<...% list(1, 2)
# }
`%<...%` <- function(names, values, ...) {
  # Collect additional arguments
  args <- list(...)

  # Set default values if not provided
  if (is.null(args[['.envir']])){
    .envir <- .GlobalEnv
  }

  if (is.null(args[['.warn']])){
    .warn <- TRUE
  }

  # Issue a warning if '.warn' is TRUE
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





# @rdname unpkg-assign
# @order 2
`%...>%` <- function(values, names, ...) {
  `%<...%`(names, values, ...)
}
