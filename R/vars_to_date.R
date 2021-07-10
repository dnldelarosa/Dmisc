#' Multiple variables to unique date variable
#'
#'   `r lifecycle::badge("experimental")`
#'
#' @param tbl data.frame or tbl connection
#' @param year  year variable position or name
#' @param quarter quarter variable position or name
#' @param month month variable position or name
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
vars_to_date <- function(tbl, year = NULL, quarter = NULL, month = NULL, day = NULL,
                         date = NULL, date_format = "%d-%m-%y", origin = "1900-01-01") {

  if(!is.null(day)){
    day <- get_pos(day, names(tbl))
    dayn <- names(tbl)[day]
  } else {
    day <- FALSE
  }

  if(!is.null(month)){
    month <- get_pos(month, names(tbl))
    monthn <- names(tbl)[month]
    tbl <- make_month(tbl, monthn)
  } else {
    month <- FALSE
  }

  if(!is.null(quarter)){
    quarter <- get_pos(quarter, names(tbl))
    quartern <- names(tbl)[quarter]
    tbl <- make_quarter(tbl, quartern)
  } else {
    quarter <- FALSE
  }

  if(!is.null(year)){
    year <- get_pos(year, names(tbl))
    yearn <- names(tbl)[year]
  } else {
    year <- FALSE
  }

  if(!is.null(date)){
    date <- get_pos(date, names(tbl))
    daten <- names(tbl)[date]
  } else {
    date <- FALSE
  }

  if(day){
    if(is.null(year)){
      stop("Falta ano")
    }
    if(is.null(month)){
      stop("Falta mes")
    }

    tbl$date <- as.Date(paste0(tbl[,yearn], '-', tbl[, monthn], '-', tbl[, dayn]))
    tbl <- tbl %>%
      dplyr::relocate(date)

    tbl[, yearn] <- NULL
    tbl[, monthn] <- NULL
    tbl[, dayn] <- NULL

    return(tbl)
  }

  if(month){
    if(!year){
      stop("Falta ano")
    }

    tbl$date <- as.Date(paste0(tbl[,yearn], '-', tbl[, monthn], '-', '01'))
    tbl$date <- lubridate::ceiling_date(tbl$date, unit = "month")
    tbl$date <- lubridate::add_with_rollback(tbl$date, lubridate::days(-1))

    tbl[, yearn] <- NULL
    tbl[, monthn] <- NULL

    return(tbl)
  }

  if(quarter){
    if(!year){
      stop("Falta ano")
    }

    tbl <- vars_to_date(tbl, year = year, month = quarter)

    tbl[, yearn] <- NULL
    tbl[, quartern] <- NULL

    return(tbl)
  }

  if(date){
    nombres <- names(tbl)
    nombres[nombres == daten] <- "date"
    names(tbl) <- nombres
    tbl <- clean_date(tbl, date_format, origin)
    nombres[nombres == "date"] <- daten
    names(tbl) <- nombres

    return(tbl)
  }
}



get_pos <- function(arg, names){
  if(is.character(arg)){
    arg <- match(arg, names)
  }
  arg
}


make_month <- function(tbl, month){
  if(is.character(tbl[, month])){
    tbl[, month] <- stringr::str_remove_all(tbl[, month], stringr::regex("[^a-zA-Z]"))
    tbl[, month] <- stringr::str_trim(tbl[, month])
    tbl[, month] <- stringr::str_to_title(stringr::str_sub(tbl[, month], 1, 3))
    tbl[, month][tbl[, month] == "Ene"] <- "Jan"
    tbl[, month][tbl[, month] == "Abr"] <- "Apr"
    tbl[, month][tbl[, month] == "Ago"] <- "Aug"
    tbl[, month][tbl[, month] == "Dic"] <- "Dec"

    tbl[, month] <- match(tbl[, month], month.abb)
  }
  tbl
}


make_quarter <- function(tbl, quarter){
  . <- NULL
  qq <- c("1" = 1, "2" = 2, "3" = 3, "4" = 4,
          "1" = "I", "2" = "II", "3" = "III", "4" = "IV",
          "1" = "Q1", "2" = "Q2", "3" = "Q3", "4" = "Q4",
          "1" = "T1", "2" = "T2", "3" = "T3", "4" = "T4",
          "1" = "em", "2" = "aj", "3" = "js", "4" = "od",
          "2" = "ej", "3" = "es", "4" = "ed",
          "1" = "jm", "2" = "aj", "3" = "js", "4" = "od",
          "2" = "jj", "4" = "jd"
  )

  qncharmean <- mean(nchar(tbl[, quarter]))

  if(qncharmean>2){
    stringr::str_split(tbl[, quarter], "[^[:alnum:]]+", simplify = T, n = 2) %>%
      as.data.frame() %>%
      dplyr::mutate(dplyr::across(dplyr::everything(), ~stringr::str_sub(.x, 1, 1))) %>%
      {paste0(.[["V1"]], .[["V2"]])} %>%
      tolower() -> tbl[, quarter]
  }

  tbl[, quarter] <- as.numeric(names(qq)[match(tbl[, quarter], qq)])*3

  tbl
}


# Reformular
clean_date <- function(tbl, date_format, origin) {
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
