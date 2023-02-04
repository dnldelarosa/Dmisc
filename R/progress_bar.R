#' Html Progress Bar
#' r lifecycle::badge("experimental")
#'
#' Create a svg/html progress bar that displays the progress value in 4 different states, depending on its percentage:
#' \itemize{
#' \item{0-25%}
#' \item{25-50%}
#' \item{50-75%}
#' \item{75-100%}
#' }
#' You can use the bg_color parameter to change the color of the bar.
#'
#' @param progress [numeric] The progress value in percentage (0-100).
#' @param width [character] The width of the progress bar, as a string with a numeric value followed by a unit of measurement (e.g. "50%").
#' @param height [numeric or character] The height of the progress bar, as a numeric value with or without a unit of measurement (e.g. 25 or "25px").
#' @param suffix [character] The text to display after the progress value (e.g. "%").
#' @param font_family [character] The font family to use for the text.
#' @param bg_color [character] The background color of the progress bar (e.g. "#5bc0de").
#' @param font_size [numeric] The font size of the text, in pixels.
#' @param styles [character] A string with inline styles to apply to the SVG element.
#'
#' @return an html object that displays a svg progress bar
#' @export
#'
#' @examples
#' \dontrun{
#' progress_bar(77)
#' }
progress_bar <- function(progress, ...) {
  options <- list(
    suffix = "%",
    width = "50%",
    height = 25,
    font_size = 14,
    font_family = "DejaVu Sans,Verdana,Geneva,sans-serif",
    bg_color = NULL,
    styles = "display: block; margin: auto;"
  )

  options <- c(options, list(...))

  if (!is.null(options$bg_color)) {
    status <- options$bg_color
  } else {
    status <- dplyr::case_when(
      progress < 25 ~ "#d9534f",
      progress < 50 ~ "#f0ad4e",
      progress < 75 ~ "#5bc0de",
      progress >= 75 ~ "#5cb85c"
    )
  }

  ws <- stringr::str_remove_all(options$width, "[0-9.]")
  multx <- as.numeric(stringr::str_remove_all(options$width, "[^0-9]")) / 100
  multy <- as.numeric(stringr::str_remove_all(options$height, "[^0-9]"))

  htmltools::HTML(
    glue::glue('<svg width="{options$width}" height="{options$height}" xmlns="http://www.w3.org/2000/svg" style="{options$styles}">
<linearGradient id="a" x2="0" y2="100%">
<stop offset="0" stop-color="#bbb" stop-opacity="{1 - progress/100}"/>
<stop offset="1" stop-opacity="{1 - progress/100}"/>
  </linearGradient>
  <rect rx="4" x="0" width="{options$width}" height="{options$height}" fill="#555"/>
  <rect rx="4" x="0" width="{round(multx * ifelse(is.character(progress), 100, progress))}{ws}" height="{options$height}" fill="{status}"/>
  <rect rx="4" width="{options$width}" height="{options$height}" fill="url(#a)"/>
  <g fill="#fff" text-anchor="middle"{ifelse(!is.null(options$font_family), paste0(" font-family=", options$font_family), "")} font-size="{options$font_size}">
  <text x="{round(0.5 * multx * ifelse(is.character(progress), 100, progress))}{ws}" y="{0.7 * multy}">
  {progress}
{options$suffix}
</text>
  </g>
  </svg>
  ')
  )
}
