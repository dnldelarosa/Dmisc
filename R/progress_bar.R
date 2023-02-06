#' Html Progress Bar
#'  `r lifecycle::badge("experimental")`
#'
#' Create a html progress bar that displays the progress value in 4 different states, depending on its percentage:
#' \itemize{
#' \item{0-25%}
#' \item{25-50%}
#' \item{50-75%}
#' \item{75-100%}
#' }
#'
#' @param progress [numeric] The progress value in percentage (0-100).
#' @param width [numeric] The width of the progress bar.
#' @param height [numeric] The height of the progress bar.
#' @param suffix [character] The text to display after the progress value (e.g. "%").
#' @param font_family [character] The font family to use for the text.
#' @param font_size [numeric] The font size of the text, in pixels.
#' @param styles [character] A string with inline styles to apply to the SVG element.
#'
#' @return an html object that displays a progress bar
#' @export
#'
#' @examples
#' progress_bar(77)
progress_bar <- function(progress, ...) {
  options <- list(
    suffix = "%",
    width = "50%",
    height = 25,
    font_size = 14,
    font_family = "DejaVu Sans,Verdana,Geneva,sans-serif",
    bg_color = NULL,
    styles = ""
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

  width_style <- paste0("width:", progress, "%;")
  height_style <- paste0("height:", options$height, "px;")
  bar_style <- paste0(width_style, height_style, "background-color:", status, ";", options$styles)

  value_style <- paste0(
    "font-family:", options$font_family, ";",
    "font-size:", options$font_size, "px;",
    "line-height:", options$height, "px;",
    "text-align:center;"
  )

  value_label <- paste0(as.character(round(progress, 2)), options$suffix)

  htmltools::tags$div(
    style = glue::glue('background-color: #D3D3D3; width: {options$width};'),
    htmltools::tags$div(
      style = bar_style,
      htmltools::tags$div(value_label, style = value_style)
    )
  )
}
