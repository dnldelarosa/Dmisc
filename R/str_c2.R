#' str_c2: Concatenate Strings with Custom Last Delimiter
#' `r lifecycle::badge("deprecated")`
#'
#'  This function has been deprecated in favor of stringr::str_flatten() function.
#'
#' This function concatenates multiple strings into a single string using a specified delimiter and provides the option to change the delimiter for the last pair of strings.
#'
#' @param ... strings to be concatenated.
#' @param sep delimiter to be used to concatenate the strings.
#' @param collapse default delimiter used in base str_c function.
#' @param last_coll delimiter to be used for the last pair of strings.
#'
#' @return a single string that is the concatenation of all the input strings.
#' @export
#'
#' @examples
#' str_c2("A", "B", "C", "D", sep = ", ")
#' str_c2("A", "B", "C", "D", sep = ", ", last_coll = " and ")
str_c2 <- function(..., sep = "", collapse = "", last_coll = " y ") {
  deprecate_warn("0.20.0", "Dmisc::str_c2()", "stringr::str_flatten()")
  string <- stringr::str_c(..., sep = sep, collapse = collapse)
  stringr::str_locate_all(string, collapse) %>%
    `[[`(1) %>%
    tail(1) -> last
  stringr::str_sub(string, last[1], last[2]) <- last_coll
  string
}
