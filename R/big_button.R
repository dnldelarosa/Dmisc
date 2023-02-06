#' Insert a HTML big button
#'
#' @param text [character]: Required text to display in the button.
#' @param href [character]: Required link for the button.
#' @param ... [character]: Optional arguments to customize the button appearance.
#'
#' @details The function creates a big button with the specified text, link, and styles. The button is wrapped in an HTML 'a' tag and its appearance can be customized using optional arguments such as font size, font family, background color, and styles.
#'
#' @return a big button in the form of an SVG/HTML element.
#'
#' @examples
#' big_button(text = "Get started", href = "./articles/Dmisc.html")
#' big_button("Get started", "./articles/Dmisc.html", bg_color = "#4CAF50")
#'
#' # Customize button appearance by passing optional arguments
#' big_button("Get started", "./articles/Dmisc.html",
#' width = "75%", height = 40, font_size = 22, bg_color = "#00a65a")
#'
#' @note This function is experimental and should be used with caution.
#'
#' @import htmltools
#' @importFrom htmltools HTML
big_button <- function(text, href, ...) {

  # Extract remaining arguments
  args <- list(...)

  # Set default values for optional arguments
  width <- if ("width" %in% names(args)) args[["width"]] else "50%"
  height <- if ("height" %in% names(args)) args[["height"]] else "30px"
  font_size <- if ("font_size" %in% names(args)) args[["font_size"]] else "18px"
  font_family <- if ("font_family" %in% names(args)) args[["font_family"]] else ""
  bg_color <- if ("bg_color" %in% names(args)) args[["bg_color"]] else "#00a65a"
    styles <- if ("styles" %in% names(args)) args[["styles"]] else "display: inline-block; padding: 0.5em 1em; margin: auto; text-align: center; color: white; font-size: 20px; font-weight: bold;"

    # Build the HTML for the button
    html <- paste0(
      '<a href="', href, '" style="width:', width, '; height:', height, '; font-size:', font_size, '; font-family:', font_family, '; background-color:', bg_color, ';', styles, '">',
      text,
      "</a>"
    )

    # Return HTML element
    htmltools::HTML(html)
}
