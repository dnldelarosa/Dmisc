#' Multiple variables to unique date variable
#'
#'   `r lifecycle::badge("experimental")`
#'
#' @param tbl data.frame or tbl connection
#' @param year  year variable position or name
#' @param trim trimester variable position or name
#' @param month month variable position or name
#' @param month_type character the char or num type of month variable
#' @param day day variable position or name
#'
#' @return tbl a new data.frame with the compute variable
#'
#' @export
#'
#' @examples
#' \dontrun{
#' tbl <- vars_to_date(tbl)
#' }
vars_to_date <- function(tbl, year = NULL, trim = NULL, month = NULL, month_type = "char", day = NULL) {
  if(!is.null(year)){
    if(is.character(year)){
      year <- match(year, names(tbl))
    }
    names(tbl)[year] <- "year"
  }

  if(!is.null(month)){
    if(is.character(month)){
      month <- match(month, names(tbl))
    }
    names(tbl)[month] <- "month"
  }

  if (!is.null(day)) {

  } else if (!is.null(month)) {
    if (month_type == "num") {
      tbl <- dplyr::mutate(tbl,
                            date = paste(year, month, "01", sep = "-")
      )
    } else {
      tbl <- dplyr::mutate(tbl,
                            month = stringr::str_trim(month),
                            month = stringr::str_sub(month, 1, 3),
                            month = stringr::str_to_title(month),
                            month = dplyr::case_when(
                              month == "Ene" ~ "Jan",
                              month == "Abr" ~ "Apr",
                              month == "Ago" ~ "Aug",
                              month == "Dic" ~ "Dec",
                              TRUE ~ month
                            ),
                            date = as.Date(tsibble::yearmonth(paste(year, month)))
      )
    }
    tbl[, month] <- NULL
    tbl[, year] <- NULL
    tbl <- dplyr::relocate(tbl, date)
    tbl
  }
}
