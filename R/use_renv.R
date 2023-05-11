# Initialize renv
# `r lifecycle::badge("experimental")`
#
# This function does the same as \code{renv::\link[renv:init]{init}} but forces
# renv to use an external (customizable) library location.
#
# @param project project path. The working directory is used by detafult.
# @param lib_path path where you want to save the libraries.
#  The default value is relative to R's home directory.
# @param ... other arguments passed to \code{renv::\link[renv:init]{init}}
#
# @return [NULL]
# 
#
# @examples
# \dontrun{
# use_renv()
# }
use_renv <- function(project = getwd(), lib_path = "~/.renv/library", ...) {
  if (!requireNamespace("renv", quietly = TRUE)) {
    stop(
      "Package \"renv\" needed for this function to work. Please install it.",
      call. = FALSE
    )
  }
  name <- basename(project)
  write(
    paste0(
      "RENV_PATHS_LIBRARY = ",
      lib_path,
      "/",
      name
    ),
    paste0(project, "/", ".Renviron")
  )
  renv::init(project = project, ...)
}
