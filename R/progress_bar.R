#' Html progress bar
#' `r lifecycle::badge("experimental")`
#'
#'  Add a svg/html progress bar with 4 states:
#'  \itemize{
#'   \item{0-25%}
#'  \item{25-50%}
#' \item{50-75%}
#' \item{75-100%}
#' }
#' You can use the \code{bg_color} parameter to change the color of the bar.
#'
#' @param progress [numeric] The progress value.
#' @param width The width of the progress bar.
#' @param height The height of the progress bar.
#' @param suffix The suffix of the progress text.
#' @param font_family The font family of the progress text.
#' @param bg_color The background color of the progress bar.
#' @param font_size The font size of the progress bar.
#' @param styles The styles of the SVG element.
#'
#' @return a html object representing a svg progress bar
#' @export
#'
#' @examples
#' \dontrun{
#' progress_bar(77)
#' }
progress_bar <- function(progress,
                         suffix = "%",
                         width = "50%",
                         height = 25,
                         font_size = 14,
                         font_family = "DejaVu Sans,Verdana,Geneva,sans-serif",
                         bg_color = NULL,
                         styles = "display: block; margin: auto;"
                        ) {
  if (!is.null(bg_color)) {
    status <- bg_color
  } else {
    status <- dplyr::case_when(
      progress < 25 ~ "#d9534f",
      progress < 50 ~ "#f0ad4e",
      progress < 75 ~ "#5bc0de",
      progress >= 75 ~ "#5cb85c"
    )
  }
  ws <- stringr::str_remove_all(width, "[0-9.]")
  multx <- as.numeric(stringr::str_remove_all(width, "[^0-9]")) / 100
  multy <- as.numeric(stringr::str_remove_all(height, "[^0-9]"))

  htmltools::HTML(
    paste0(
      "
  <svg width=\"", width, "\" height=\"", height, "\" xmlns=\"http://www.w3.org/2000/svg\" style=\"",styles,"\">
  <linearGradient id=\"a\" x2=\"0\" y2=\"100%\">
    <stop offset=\"0\" stop-color=\"#bbb\" stop-opacity=\"0.2\"/>
  <stop offset=\"1\" stop-opacity=\"0.1\"/>
    </linearGradient>
    <rect rx=\"4\" x=\"0\" width=\"", width, "\" height=\"", height, "\" fill=\"#555\"/>
    <rect rx=\"4\" x=\"0\" width=\"", round(multx * ifelse(is.character(progress), 100, progress)), ws, "\" height=\"", height, "\" fill=\"", status, "\"/>
    <rect rx=\"4\" width=\"", width, "\" height=\"", height, "\" fill=\"url(#a)\"/>
    <g fill=\"#fff\" text-anchor=\"middle\"",ifelse(!is.null(font_family), paste0(" font-family=", font_family), "")," font-size=\"", font_size, "\">
    <text x=\"", round(0.5 * multx * ifelse(is.character(progress), 100, progress)), ws, "\" y=\"", 0.7 * multy, "\">",
      progress,
      suffix,
      "</text>
    </g>
    </svg>
    "
    )
  )
}
