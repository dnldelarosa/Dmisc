#' Insert a SVG/HTML big button
#' r lifecycle::badge("experimental")
#'
#' @param text [character]: Required text to display in the button
#' @param href [character]: Required HTML a tag href attribute
#' @param ... [character]: Optional arguments to pass to progress_bar
#'
#' @details The function creates a big button with the specified text, link, and
#' styles. The button is wrapped in an HTML 'a' tag and its appearance can be
#' customized using the optional arguments. The text style can be customized with
#' font size and font family. The button background color can also be customized.
#'
#' @note This function is experimental and should be used with caution.
#'
#' @export
#'
#' @importFrom htmltools HTML
#'
#' @seealso \code{\link{progress_bar}} for the code used to generate the button itself.
#'
#' @import htmltools
#'
#' @return a big button in the form of an SVG/HTML element.
#' @examples
#' \dontrun{
#' big_button(text = "Get started", href = "./articles/Dmisc.html")
#' big_button("Get started", "./articles/Dmisc.html", bg_color = "#4CAF50")
#' }
#'
#' Customize button appearance by passing optional arguments to progress_bar:
#' \dontrun{
#' big_button("Get started", "./articles/Dmisc.html",
#' width = "75%", height = 40, font_size = 22, bg_color = "#00a65a")
#' }
big_button <- function(text, href, ...) {

  # Extract remaining arguments
  args <- list(...)

  # Set default values for optional arguments
  suffix <- if ("suffix" %in% names(args)) args[["suffix"]] else ""
  width <- if ("width" %in% names(args)) args[["width"]] else "50%"
  height <- if ("height" %in% names(args)) args[["height"]] else 30
  font_size <- if ("font_size" %in% names(args)) args[["font_size"]] else 18
  font_family <- if ("font_family" %in% names(args)) args[["font_family"]] else NULL
  bg_color <- if ("bg_color" %in% names(args)) args[["bg_color"]] else "#00a65a"
  styles <- if ("styles" %in% names(args)) args[["styles"]] else "display: block; margin: auto;"

  # Call progress_bar function with specified arguments
  html <- paste0(
    '<a href="',
    href,
    '">',
    progress_bar(
      text,
      suffix,
      width,
      height,
      font_size,
      font_family,
      bg_color,
      styles
    ),
    "</a>"
  )

  # Return HTML element
  htmltools::HTML(html)
}
