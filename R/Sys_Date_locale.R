#' System date with specific format and locale
#'
#'  You need to have installed the specified locale.
#'
#' @param locale a currently installed locale string
#' @param format a valid format for dates or NULL
#'
#' @return a date with specified locale and format
#'
#' @export
#'
#' @examples
#' \dontrun{
#'  Sys_Date_locale()
#' }
Sys_Date_locale <- function(locale = "es_DO.utf8", format = "%a de %B de %Y"){
  if(is.null(format)){
    withr::with_locale(new = c("LC_TIME" = locale), Sys.Date())
  } else {
    withr::with_locale(new = c("LC_TIME" = locale), format(Sys.Date(), format))
  }
}
