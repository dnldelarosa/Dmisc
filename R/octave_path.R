#' Retrieve octave path
#' `r lifecycle::badge("experimental")`
#'
#'   It is intended to be used in R Markdown files that use Octave.
#'   The advantage of using this function instead of specifying the path
#'   directly is that it allows you to move an Rmd between one operating system
#'   and another.
#'
#' @param drive [character]: drive letter on which the program is installed
#' @param version [character]: octave version
#' @param ... for development use
#'
#' @return A character string with the location of the program based on the inputs
#'   arguments
#'
#' @export
#'
#' @examples
#' \dontrun{
#'   octave <- octave_path(drive="C", version="5.2.0")
#' }
octave_path <- function(drive = "C", version = "5.2.0", ...) {
  args = list(...)
  sysname <- args[["sysname"]]
  if(is.null(sysname)){
    sysname <- Sys.info()["sysname"][[1]]
  }
  if (sysname == "Windows") {
    paste0(drive, ":/Octave/Octave-", version, "/mingw64/bin/octave-cli-", version, ".exe")
  } else {
    "/usr/bin/octave-cli"
  }
}
