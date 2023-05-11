ts_extend <- function(.ts, .end, .default = 0, .sub = TRUE){
    res <- stats::window(.ts, end = .end, frequency = stats::frequency(.ts), extend = TRUE)
    res |>
      ts_to_df() |>
      dplyr::mutate(
        dplyr::across(
          -date,
          ~ tidyr::replace_na(.x, .default)
        )
      ) |>
      df_to_ts() %>%
      ts_sub(.ts)
}
