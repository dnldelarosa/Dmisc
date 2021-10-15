#' Initialize renv
#'
#'   `r lifecycle::badge("experimental")`
#'
#' This function does the same as \code{renv::\link[renv:init]{init}} but forces renv
#' to use an external (customizable) library location.
#'
#' @param envs_path path where you want to save the libraries.
#'  The default value is relative to R's home directory.
#' @param ... other arguments passed to \code{renv::\link[renv:init]{init}}
#'
#' @return [NULL]
#' @export
#'
#' @examples
#' \dontrun{
#'  use_renv
#' }
use_renv <- function(envs_path = "~/.renv/library", ...){
  if (!requireNamespace("renv", quietly = TRUE)) {
    stop("Package \"renv\" needed for this function to work. Please install it.", call. = FALSE)
  }
  name <- basename(getwd())
  write(paste0("RENV_PATHS_LIBRARY = ", envs_path, "/", name), ".Renviron")
  renv::init(...)
}
