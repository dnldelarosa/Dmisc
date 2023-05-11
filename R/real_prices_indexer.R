# Monetary quantities adjusted for inflation
#  `r lifecycle::badge("experimental")`
#
# @param tbl [data.frame]: Database connection or data.frame
# @param name [character]: variable name
# @param prices [data.frame]: Database connection or data.frame with the prices
# @param variable [character]: prices variable name
# @param base_prices [numeric]: indicates the base prices. See \code{Details}.
# @param .join [character]: name of the variable that joins the two data.frames
# @param .keep [logical]: indicates if the prices variables should be kept
#
# @details The base_prices parameter can be a negative or positive integer.
#  If it is a negative integer, the prices are adjusted backward by \code{base_prices} months.
#  If it is a positive integer, the prices are adjusted forward by \code{base_prices} months.
#  However, if the base_prices is 0, the prices are not adjusted.
#  The base_prices parameter can be a two-element vector too. In this case, if the
#  first element is a negative or positive integer lower than 1900, it will be
#  interpreted as the number of years to move back or forward. If the first element
#  is a positive integer greater than 1900, it will be interpreted as the year
#  to use as the base. The sencond element needs to be a positive integer between 1 and 12,
# and is the month to use as the base.
#
# @return tbl a new data.frame with the variable in base prices
# 
#
# @examples
# \dontrun{
# tbl <- data.frame(
#   year = c(rep(2009, 12), rep(2010, 12), rep(2011, 12)),
#   month = rep(1:12, 3),
#   income = sample(100:500, 12 * 3, TRUE)
# ) %>%
#   dplyr::mutate(income2 = income)
#
# cpi <- data.frame(
#   year = c(rep(2008, 12), rep(2009, 12), rep(2010, 12), rep(2011, 12), rep(2012, 12)),
#   month = rep(1:12, 5),
#   cpi = 1:(12 * 5)
# ) %>%
#   dplyr::mutate(
#     cpi = cpi / cpi[year == 2010 & month == 12] * 100,
#     cpi = round(cpi, 1)
#   ) %>%
#   vars_to_date(year = "year", month = "month")
#
#
# # n months ago
# real_prices_indexer(tbl, "income2", cpi, "cpi", -1, .keep = TRUE)
#
# # n month later
# real_prices_indexer(tbl, "income2", cpi, "cpi", 1, .keep = TRUE)
#
# # same month, previous year (n = 12)
# real_prices_indexer(tbl, "income2", cpi, "cpi", -12, .keep = TRUE)
#
# # same month, next year (n = 12)
# real_prices_indexer(tbl, "income2", cpi, "cpi", 12, .keep = TRUE)
#
# # specific month, specific year (Jun 2009)
# real_prices_indexer(tbl, "income2", cpi, "cpi", c(2009, 6), .keep = TRUE)
#
# # same year, specific month (June)
# real_prices_indexer(tbl, "income2", cpi, "cpi", c(0, 6), .keep = TRUE)
#
# # n years ago, specific month (June previes year)
# real_prices_indexer(tbl, "income2", cpi, "cpi", c(-1, 6), .keep = TRUE)
#
# # n years later, specific month (June next year)
# real_prices_indexer(tbl, "income2", cpi, "cpi", c(1, 6), .keep = TRUE)
# }
real_prices_indexer <- function(tbl, name, prices, variable, base_prices, .join = c("year", "month"), .keep = FALSE) {
  actual_price <- NULL
  base_price <- NULL
  .skip <- FALSE
  if (all(length(base_prices) == 1, is.numeric(base_prices))) {
    if (base_prices == 0) {
      .skip <- TRUE
    }
  }
  if (!.skip) {
    tbl <- add_actual_prices(tbl, prices, variable, .join)
    tbl <- add_base_prices(tbl, prices, variable, base_prices, .join)
    tbl <- dplyr::mutate(
      tbl,
      !!rlang::sym(name) := !!rlang::sym(name) / actual_price * base_price
    )

    if (!.keep) {
      tbl <- tbl %>%
        dplyr::select(-c("base_price", "actual_price"))
    }
  }
  tbl
}

add_actual_prices <- function(tbl, prices, variable, .join) {
  . <- NULL
  prices[[.join[[1]]]] <- lubridate::year(prices[["date"]])
  prices[[.join[[2]]]] <- lubridate::month(prices[["date"]])
  prices[["actual_price"]] <- prices[[variable]]

  prices %>%
    dplyr::select(dplyr::all_of(c(.join, "actual_price"))) %>%
    dplyr::left_join(
      tbl,
      .,
      by = .join,
      copy = TRUE
    )
}


add_base_prices <- function(tbl, prices, variable, base_prices, .join) {
  . <- NULL
  if (length(base_prices) == 1) {
    prices <- prices %>%
      dplyr::mutate(
        date = lubridate::add_with_rollback(date, months(-base_prices))
      )
    prices[[.join[[1]]]] <- lubridate::year(prices[["date"]])
    prices[[.join[[2]]]] <- lubridate::month(prices[["date"]])
    prices[["base_price"]] <- prices[[variable]]

    prices %>%
      dplyr::select(dplyr::all_of(c(.join, "base_price"))) %>%
      dplyr::left_join(
        tbl,
        .,
        by = .join,
        copy = TRUE
      ) -> tbl
  } else {
    if (base_prices[[1]] < 1900) {
      prices <- prices %>%
        dplyr::mutate(
          date = lubridate::`year<-`(date, lubridate::year(date) - base_prices[[1]])
        ) %>%
        dplyr::filter(
          lubridate::month(date) == base_prices[[2]]
        )

      prices[[.join[[1]]]] <- lubridate::year(prices[["date"]])
      prices[["base_price"]] <- prices[[variable]]

      prices %>%
        dplyr::select(dplyr::all_of(c(.join[[1]], "base_price"))) %>%
        dplyr::left_join(
          tbl,
          .,
          by = .join[[1]],
          copy = TRUE
        ) -> tbl
    } else {
      prices %>%
        dplyr::filter(
          lubridate::year(date) == base_prices[[1]],
          lubridate::month(date) == base_prices[[2]]
        ) %>%
        dplyr::pull(!!rlang::sym(variable)) %>%
        .[[1]] %>%
        dplyr::mutate(tbl, base_price = .) -> tbl
    }
  }
}
