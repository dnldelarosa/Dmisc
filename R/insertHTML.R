#' Insert HTML file into another
#'
#'   `r lifecycle::badge("experimental")`
#'
#' \lifecycle{experimental}
#'
#' @param path character the path where the HTML file exists. Should end with /
#' @param name character the name of HTML file to insert
#' @param source_code character used for highlighting the code into the document
#'
#' @return character an HTML character string
#'
#' @details This function was created to insert MatLab published HTML into
#'  RMarkdown documents. Important considerations:
#'  \itemize{
#'    \item{
#'      Only the body of the document if returned.
#'    }
#'    \item{
#'      The images are converted to base64 strings if needed.
#'    }
#'    \item{
#'      A caption with de file name is added to each image.
#'    }
#'    \item{
#'      The output is wrapped by a \code{<pre></pre>} tag.
#'    }
#'  }
#'
#' @export
#'
#' @examples
#' \dontrun{
#' insertHTML('html/', 'index.html')
#' }
insertHTML <- function(path = './', name, source_code = 'matlab') {
  file <- xml2::read_html(paste0(path, name))
  file2 <- as.character(rvest::html_node(file,'body'))
  images <- stringr::str_extract_all(file2, '<img.*?src="(.*?)"[^>]+>')
  images <- images[[1]]
  for (image in seq_along(images)) {
    imageType <- strsplit(images[[image]], 'src=')[[1]][2]
    imageType <- strsplit(imageType, ';')[[1]][2]
    imageType <- strsplit(imageType, ',')[[1]][1]
    if(is.na(imageType)){
      image_name <- strsplit(strsplit(strsplit(images[[image]], 'src=')[[1]][2], ' ')[[1]][1], '/', perl = T)[[1]]
      image_name <- noquote(image_name)
      image_name <- stringr::str_remove_all(image_name[length(image_name)], '"')
      image_path = paste0(path, image_name)
      uri=knitr::image_uri(image_path)
      file2 <- stringr::str_replace(file2, images[[image]], paste0(
        '<img src=\"', uri, '\" />\n',
        '<figure><figcaption>','Fig. ', image, ': ',stringr::str_remove(image_name, '.png'),'</figcaption>',
        '</figure>'
      ))
    }
  }
  file2 <- paste0('<pre>',file2,' </pre>')
  file2 <- stringr::str_replace_all(file2, '<pre', paste0('<pre class="sourceCode ', source_code,'"'))
  htmltools::HTML(file2)
}
