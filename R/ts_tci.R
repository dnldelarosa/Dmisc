ts_tc <- function(.ts, .vars = NULL, .type = c('i', 'p', 'c'), .base = 1){
    .names <- names(ts_to_df(.ts))
    .names <- ifelse(is.null(.vars), .names[.names != 'date'], .vars)
    .type <- ifelse(length(.type) > 1, .type[[1]], .type)
    .lags <- dplyr::case_match(
      .type,
      'i' ~ frequency(.ts),
      .default = 1
    )
    .ts2 <- .ts %>%
      ts_to_df() %>%
      dplyr::mutate(tc = dplyr::across(.names, ~(.x/dplyr::lag(.x, stats::frequency(.x)) - 1)*.base)) %>%
      df_to_ts()

    if(.type == 'c') {
      .ts2 %>%
      ts_to_df() %>%
      dplyr::group_by(year = lubridate::year(date)) %>%
      dplyr::mutate(tc = cumsum(tc)) %>%
        dplyr::ungroup() %>%
        dplyr::select(-year) %>%
        df_to_ts()
    } else {
      .ts2
    }
}
