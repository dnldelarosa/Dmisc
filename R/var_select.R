var_select <- function(ts, xreg = NULL) {
  . <- NULL
  criteria <- NULL
  lags <- NULL
  value <- NULL
  ts |>
    vars::VARselect(
      exogen = xreg
    ) %>%
    .[["criteria"]] %>%
    as.data.frame() %>%
    tibble::rownames_to_column("criteria") %>%
    tidyr::pivot_longer(-criteria, names_to = "lags") %>%
    dplyr::group_by(lags) %>%
    dplyr::filter(!is.infinite(value), value != 0) %>%
    tidyr::drop_na(value) %>%
    dplyr::group_by(criteria) %>%
    dplyr::filter(value == min(value))
}
