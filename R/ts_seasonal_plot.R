seasonal_plot <- function(data, .seasons = NULL, .smooth = FALSE, .freq = NULL, ...) {
  year <- NULL
  season <- NULL
  value <- NULL
  if ("ts" %in% class(data)) {
    data <- ts_to_df(data)
  }
  if (is.null(.freq)) {
    .freq <- ts_guest_freq(data, "date")
  }
  data <- data |>
    dplyr::mutate(
      year = lubridate::year(date),
      season = dplyr::case_when(
        .freq == 4 ~ quarter(date),
        .freq == 12 ~ month(date)
        ),
      .keep = "unused"
    )

  if (!is.null(.seasons)) {
    data <- data |>
      dplyr::filter(season %in% .seasons)
  }

  data <- data |>
    dplyr::mutate(
      season = dplyr::case_when(
        .freq == 4 ~ paste0("Q", season),
        .freq == 12 ~ paste0("M", stringr::str_pad(season, 2, pad = "0"))
      ),
      .keep = "unused"
    )

  gplot <- data |>
    tidyr::pivot_longer(-c(year, season)) |>
    ggplot2::ggplot(ggplot2::aes(x = year, y = value, color = season)) +
    ggplot2::geom_line() +
    ggplot2::facet_wrap(~name, scales = "free_y", ncol = 2) +
    ggplot2::theme_bw()
  if (.smooth) {
    gplot <- gplot +
      ggplot2::geom_smooth(...)
  }
  gplot
}
