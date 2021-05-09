#' Insert HTML file into another
#'
#'   `r lifecycle::badge("experimental")`
#'
#' @param path [character]: the path where the HTML file exists. Should end with /
#' @param name [character]: the name of HTML file to insert
#' @param source_code [character]: used for highlighting the code into the document.
#'   Also the output is wrapped by a \code{<pre></pre>} tags.
#' @param file [character]: path to HTML file. Should include the file name.
#' @param keep_styles [logical]: indicates if the styles of the file to be
#'    included are preserved. They only apply to their own content.
#'
#' @return character an HTML character string
#'
#' @details This function was created to insert HTML file content into
#'  RMarkdown HTML documents. Important considerations:
#'  \itemize{
#'    \item{
#'      The images are converted to base64 strings if needed.
#'    }
#'    \item{
#'      A caption with de file name is added to each image.
#'    }
#'  }
#'
#' @export
#'
#' @examples
#' \dontrun{
#' insert_html(file = "html/index.html")
#' }
insert_html <- function(path = deprecated(), name = deprecated(), file = paste0(path, name), source_code = NULL, keep_styles = TRUE) {
  if (lifecycle::is_present(path)) {
    deprecate_warn("0.2.0", "insertHTML(path = )", "insertHTML(file = )")
  }
  if (lifecycle::is_present(name)) {
    deprecate_warn("0.2.0", "insertHTML(name = )", "insertHTML(file = )")
  }
  splitter_pos <- max(stringr::str_locate_all(file, "/")[[1]])
  path <- stringr::str_sub(file, end = splitter_pos)
  file <- xml2::read_html(file)
  style <- as.character(rvest::html_node(file, "style"))
  style <- stringr::str_replace(style, "style", "style scoped")
  file2 <- as.character(rvest::html_node(file, "body"))
  images <- stringr::str_extract_all(file2, '<img.*?src="(.*?)"[^>]+>')
  images <- images[[1]]
  for (image in seq_along(images)) {
    imageType <- strsplit(images[[image]], "src=")[[1]][2]
    imageType <- strsplit(imageType, ";")[[1]][2]
    imageType <- strsplit(imageType, ",")[[1]][1]
    if (is.na(imageType)) {
      image_name <- strsplit(strsplit(images[[image]], "src=")[[1]][2], " ")[[1]][1]
      image_name <- noquote(image_name)
      image_name <- stringr::str_remove_all(image_name[length(image_name)], '"')
      if (!is.na(path)) {
        path_splits <- strsplit(path, "/")[[1]]
        for (split in path_splits) {
          image_name <- stringr::str_remove_all(image_name, paste0(split, "/"))
        }
      }
      image_path <- paste0(ifelse(is.na(path), "./", path), image_name)
      uri <- knitr::image_uri(image_path)
      file2 <- stringr::str_replace(file2, images[[image]], paste0(
        '<img src=\"', uri, '\" />\n',
        "<figure><figcaption>", "Fig. ", image, ": ", stringr::str_remove(image_name, ".png"), "</figcaption>",
        "</figure>"
      ))
    }
  }
  if(!is.null(source_code)){
    file2 <- paste0("<pre>", file2, " </pre>")
    file2 <- stringr::str_replace_all(file2, "<pre", paste0('<pre class="sourceCode ', source_code, '"'))
  }
  if(keep_styles){
    file2 <- stringr::str_replace(file2, "<body>", paste("<body>", style))
  }
  htmltools::HTML(file2)
}


#' Insert HTML file into another
#'
#'   `r lifecycle::badge("deprecated")`
#'
#' @param path [character]: the path where the HTML file exists. Should end with /
#' @param name [character]: the name of HTML file to insert
#' @param source_code [character]: used for highlighting the code into the document.
#'   Also the output is wrapped by a \code{<pre></pre>} tags.
#' @param file [character]: path to HTML file. Should include the file name.
#' @param keep_styles [logical]: indicates if the styles of the file to be
#'    included are preserved. They only apply to their own content.
#'
#' @return character an HTML character string
#'
#' @details This function was created to insert HTML file content into
#'  RMarkdown HTML documents. Important considerations:
#'  \itemize{
#'    \item{
#'      The images are converted to base64 strings if needed.
#'    }
#'    \item{
#'      A caption with de file name is added to each image.
#'    }
#'  }
#'
#' @export
#'
#' @examples
#' \dontrun{
#' insertHTML(file = "html/index.html")
#' }
insertHTML <- function(path = deprecated(), name = deprecated(), file = paste0(path, name), source_code = NULL, keep_styles = TRUE) {
  deprecate_warn("0.2.3", "Dmisc::insertHTML()", "insert_html()")
  insert_html(path, name, file, source_code, keep_styles)
}
