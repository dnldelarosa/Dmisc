#' Insert a HTML big button
#'
#' @param text [character]: text to display in the button
#' @param href [character]: HTML a tag href
#' @param bg_color [character]: HEX code for the button color
#'
#' @return a HTML element button
#' @export
#'
#' @examples
#' \dontrun{
#'   big_button(text = "Get started", href = "./articles/Dmisc.html", bg_color = "#00a65a")
#' }
big_button <- function(text = "Get started", href = "./articles/Dmisc.html", bg_color = "#00a65a"){
  htmltools::HTML(
    glue::glue('
<a href="{href}"><button type="button"
style = "
    border: 1px solid transparent;
    background-color: {bg_color};
    display: block;
    padding: 10px 16px;
    font-size: 18px;
    line-height: 1.3333333;
    color: #fff;
    cursor: pointer;
    margin-left: 35%;
    margin-top: 10px;
    font-weight: 900;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;">
    {text}</button></a>')
  )
}
