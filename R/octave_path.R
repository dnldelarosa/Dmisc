#' Retrieve octave path
#'
#'   \lifecycle{experimental}
#'
#'   It is intended to be used in R Markdown files that use Octave
#'
#' @param drive drive letter on which the program is installed
#' @param version octave version
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
octave_path <- function(drive = "C", version = "5.2.0") {
  if (Sys.info()["sysname"][[1]] == "Windows") {
    glue::glue("{drive}:/Octave/Octave-{version}/mingw64/bin/octave-cli-{version}.exe")
  } else {
    "/usr/bin/octave-cli"
  }
}
