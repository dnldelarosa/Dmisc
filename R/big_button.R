#' Insert a SVG/HTML big button
#' `r lifecycle::badge("experimental")`
#'
#' @param text [character]: text to display in the button
#' @param href [character]: HTML a tag href
#' @param suffix [character]: suffix to display after the text
#' @param width width of the button
#' @param height height of the button
#' @param font_size font size of the text
#' @param font_family font family of the text
#' @param bg_color background color of the button
#'
#' @return a SVG/HTML element button
#'
#' @export
#'
#' @examples
#' \dontrun{
#' big_button(text = "Get started", href = "./articles/Dmisc.html")
#' }
big_button <- function(
  text,
  href,
  suffix = "",
  width = "50%",
  height = 30,
  font_size = 18,
  font_family = NULL,
  bg_color = "#00a65a"
  ) {
  htmltools::HTML(
    paste0(
      '
<a href="',
      href,
      '">',
      progress_bar(
        text,
        suffix,
        width,
        height,
        font_size,
        font_family,
        bg_color
      ),
      "</a>"
    )
  )
}
