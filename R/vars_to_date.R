#' Multiple variables to unique date variable
#'
#'   `r lifecycle::badge("experimental")`
#'
#' @param tbl data.frame or tbl connection
#' @param year  year variable position or name
#' @param quarter quarter variable position or name
#' @param trim quarter variable position or name
#' @param month month variable position or name
#' @param month_type character the char or num type of month variable
#' @param day day variable position or name
#' @param date a variable name or position containing a like date format
#' @param date_format actual date format of variable in \code{date} argument
#' @param origin base date for variable convertion to date
#'
#' @return tbl a new data.frame with the compute variable
#'
#' @export
#'
#' @examples
#' tbl <- data.frame(
#'   year = rep("2021", 12),
#'   month = 1:12,
#'   day = sample(1:3, 12, TRUE),
#'   value = sample(100:1000, 12, TRUE)
#' )
#'
#' tbl
#'
#' vars_to_date(tbl)
vars_to_date <- function(tbl,
                         year = NULL,
                         quarter = NULL,
                         trim = deprecated(),
                         month = NULL,
                         month_type = deprecated(),
                         day = NULL,
                         date = NULL,
                         date_format = "%d-%m-%y",
                         origin = "1900-01-01") {
  if (lifecycle::is_present(trim)) {
    deprecate_warn("0.2.4", "Dmisc::vars_to_date(trim = )", "Dmisc::vars_to_date(quarter = )")
  }

  if (lifecycle::is_present(month_type)) {
    deprecate_warn("0.2.4", "Dmisc::vars_to_date(month_type = )")
  }

  if (all(is.null(year), is.null(date))) {
    stop("One of 'year' or 'date' variable needs to be non-null")
  }

  if (!is.null(date)) {
    if (is.character(date)) {
      date <- match(date, names(tbl))
    }
    names(tbl)[date] <- "date"
  }

  if (!is.null(year)) {
    if (is.character(year)) {
      year <- match(year, names(tbl))
    }
    names(tbl)[year] <- "year"
  }

  if (!is.null(quarter)) {
    if (is.character(quarter)) {
      quarter <- match(quarter, names(tbl))
    }
    names(tbl)[quarter] <- "quarter"
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

  if (!is.null(date)) {
    tbl <- clean_date(tbl)
  }

  if (all("month" %in% names(tbl), !is.numeric(tbl[["month"]]))) {
    tbl <- abb_months(tbl)
  }

  if ("year" %in% names(tbl)) {
    if ("day" %in% names(tbl)) {
      tbl <- ddate(tbl)
    } else if (!is.null(month)) {
      tbl <- mdate(tbl)
    } else if (!is.null(quarter)) {
      tbl <- qdate(tbl)
    }
  } else {
    stop("Argument vars_to_date(year = ) is required.")
  }

  tbl[["day"]] <- NULL
  tbl[["month"]] <- NULL
  tbl[["quarter"]] <- NULL
  tbl[["year"]] <- NULL
  tbl <- dplyr::relocate(tbl, date)
  tbl
}

mdate <- function(tbl) {
  if (is.numeric(tbl$month)) {
    tbl <- dplyr::mutate(tbl, date = paste(year, month, "01", sep = "-"))
  } else {
    if (!requireNamespace("tsibble", quietly = TRUE)) {
      stop("Package \"tsibble\" needed for yearmonth format work. Please install it.", call. = FALSE)
    }
    tbl <- dplyr::mutate(
      tbl,
      date = paste(year, month),
      date = tsibble::yearmonth(date)
    )
  }
  dplyr::mutate(tbl,
    date = as.Date(date),
    date = lubridate::ceiling_date(date, unit = "month"),
    date = lubridate::add_with_rollback(date, lubridate::days(-1))
  )
}

abb_months <- function(tbl) {
  dplyr::mutate(tbl,
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


ddate <- function(tbl) {
  if (!is.numeric(tbl[["month"]])) {
    tbl <- dplyr::mutate(tbl, month = match(month, month.abb))
  }
  tbl %>%
    dplyr::mutate(
      date = paste(year, month, day, sep = "-"),
      date = as.Date(date)
    )
}



clean_date <- function(tbl) {
  tbl <- tbl %>%
    dplyr::mutate(
      date = dplyr::case_when(
        is.na(as.numeric(date)) ~ stringr::str_remove_all(stringr::str_remove_all(date, "\\."), "\\*"),
        TRUE ~ date
      ),
      date = dplyr::case_when(
        stringr::str_detect(tolower(date), "enero") ~ stringr::str_replace(tolower(date), "enero", "jan"),
        stringr::str_detect(tolower(date), "ene") ~ stringr::str_replace(tolower(date), "ene", "jan"),
        stringr::str_detect(tolower(date), "abril") ~ stringr::str_replace(tolower(date), "abril", "apr"),
        stringr::str_detect(tolower(date), "abr") ~ stringr::str_replace(tolower(date), "abr", "apr"),
        stringr::str_detect(tolower(date), "agosto") ~ stringr::str_replace(tolower(date), "agosto", "aug"),
        stringr::str_detect(tolower(date), "ago") ~ stringr::str_replace(tolower(date), "ago", "aug"),
        stringr::str_detect(tolower(date), "diciembre") ~ stringr::str_replace(tolower(date), "diciembre", "dec"),
        stringr::str_detect(tolower(date), "dic") ~ stringr::str_replace(tolower(date), "dic", "dec"),
        TRUE ~ date
      ),
      date = dplyr::case_when(
        stringr::str_detect(
          date,
          stringr::regex("[a-z]{3}-")
        ) ~ stringr::str_replace(
          date,
          stringr::regex("[a-z]{3}"),
          paste0(
            match(
              stringr::str_to_title(stringr::str_extract(date, "[a-z]{3}")),
              month.abb
            )
          )
        ),
        TRUE ~ date
      )
    )
  if (date_format %in% c("%d-%m-%y", "%m-%y")) {
    tbl <- tbl %>%
      dplyr::mutate(
        date = dplyr::case_when(
          stringr::str_count(date, "-") == 1 & stringr::str_starts(date, "[0-9]") ~ paste0(1, "-", date),
          TRUE ~ date
        ),
        date = dplyr::case_when(
          stringr::str_count(date, "-") == 2 ~ as.character(difftime(as.Date(date, format = date_format), as.Date(origin), units = "days")),
          TRUE ~ date
        )
      )
  }
  tbl %>%
    dplyr::mutate(date = as.Date(as.numeric(date), origin = origin))
}






qdate <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      quarter = dplyr::case_when(
        stringr::str_detect(quarter, "[eEjJ].*?-.*?[mM].*?") ~ "Q1",
        stringr::str_detect(quarter, "[aAeEjJ].*?-.*?[jJ].*?") ~ "Q2",
        stringr::str_detect(quarter, "[jJeE].*?-.*?[sS].*?") ~ "Q3",
        stringr::str_detect(quarter, "[oOjJeE].*?-.*?[dD].*?") ~ "Q4",
        TRUE ~ quarter
      ),
      quarter = stringr::str_replace(quarter, "IV", "Q4"),
      quarter = stringr::str_replace(quarter, "III", "Q3"),
      quarter = stringr::str_replace(quarter, "II", "Q2"),
      quarter = stringr::str_replace(quarter, "I", "Q1"),
      date = tsibble::yearquarter(paste(year, quarter)),
      date = as.Date(date),
      date = lubridate::ceiling_date(date, unit = "quarter"),
      date = lubridate::add_with_rollback(date, lubridate::days(-1))
    ) %>%
    dplyr::relocate(date)
}
