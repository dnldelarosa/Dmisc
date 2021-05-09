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
#' tbl <- data.frame(
#' year = rep("2021", 12),
#' month = 1:12,
#' day = sample(1:3, 12, TRUE),
#' value = sample(100:1000, 12, TRUE)
#' )
#'
#' tbl
#'
#' vars_to_date(tbl)
vars_to_date <- function(tbl, year = NULL, trim = deprecated(), month = NULL, month_type = deprecated(), day = NULL) {
  if (lifecycle::is_present(trim)) {
    deprecate_warn("0.2.4", "Dmisc::vars_to_date(trim = )")
  }

  if (lifecycle::is_present(month_type)) {
    deprecate_warn("0.2.4", "Dmisc::vars_to_date(month_type = )")
  }


  if (!is.null(year)) {
    if (is.character(year)) {
      year <- match(year, names(tbl))
    }
    names(tbl)[year] <- "year"
  }

  if (!is.null(month)) {
    if (is.character(month)) {
      month <- match(month, names(tbl))
    }
    names(tbl)[month] <- "month"
  }

  if (!is.null(day)) {
    if (is.character(day)) {
      day <- match(day, names(tbl))
    }
    names(tbl)[day] <- "day"
  }

  if (all("month" %in% names(tbl), !is.numeric(tbl[["month"]]))) {
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
      )
    )
  }

  if ("year" %in% names(tbl)) {
    tbl[["date"]] <- tbl[["year"]]
    if ("day" %in% names(tbl)) {
      if (!is.numeric(tbl[["month"]])) {
        tbl <- dplyr::mutate(
          tbl,
          month = match(month, month.abb)
        )
      }
      tbl <- dplyr::mutate(tbl,
        date = paste(year, month, day, sep = "-")
      )
    } else if ("month" %in% names(tbl)) {
      if (is.numeric(tbl$month)) {
        tbl <- dplyr::mutate(tbl,
          date = paste(year, month, "01", sep = "-")
        )
      } else {
        tbl <- dplyr::mutate(
          tbl,
          date = as.Date(tsibble::yearmonth(paste(year, month)))
        )
      }
    }
  } else {
    stop("Please. Specifies the position or name of the year variable.")
  }
  tbl[["day"]] <- NULL
  tbl[["month"]] <- NULL
  tbl[["year"]] <- NULL
  tbl <- dplyr::relocate(tbl, date)
  tbl
}
