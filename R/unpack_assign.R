
#' Unpack and assign values to specified names in an environment
#' `r lifecycle::badge("experimental")`
#'
#' @param names A list or character vector specifying the names of variables to be assigned.
#' @seealso Additional arguments that can be passed to names include
#'   \itemize{
#'     \item{.envir}{The environment where the variables will be assigned. Defaults to the global environment.}
#'     \item{.warn}{Logical flag indicating whether to show a warning message. Defaults to TRUE.}
#'   }
#' @param values A list or vector containing the values to be assigned to the names.
#'
#' @return NULL. The function performs assignments in the specified environment.
#'
#' @export
#'
#' @rdname unpkg-assign
#'
#' @examples
#' \dontrun{
#' c("x", "y") %<...% list(1, 2)
#' }
`%<...%` <- function(names, values) {
  # Collect additional arguments
  .envir <- .GlobalEnv
  tryCatch({
    .envir <- names[['.envir']]
    names[['.envir']] <- NULL
  }, error = function(x){
    #cli::cli_warn("The '.envir' argument must be a valid environment. ",
    #             "The global environment will be used by default.")
  })

  .warn <- TRUE
  tryCatch({
    .warn <- names[['.warn']]
    .warn <- NULL
  }, error = function(x){
    #cli::cli_warn("The '.warn' argument must be a logical value. ",
    #             "A warning will be issued by default.")
  })

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
# @export
`%...>%` <- function(values, names) {
  `%<...%`(names, values)
}
