#' Html progress bar
#'
#'  Add a html 4 colors progress bar.
#'
#' @param complete [numeric]: number of items completed
#' @param total [numeric]: number of total items
#'
#' @return a html object representing a progress bar
#' @export
#'
#' @examples
#' \dontrun{
#'   progress_bar(77, 102)
#' }
progress_bar <- function(complete, total){

  progress <- round(complete/total*100, 1)
  status <- dplyr::case_when(
    progress < 25 ~ "background-color: #d9534f;",
    progress < 50 ~ "background-color: #f0ad4e;",
    progress < 75 ~ "background-color: #5bc0de;",
    progress >= 75 ~ "background-color: #5cb85c;"
  )

  htmltools::HTML(paste0(
    '<div style="display:inline-block;
                 vertical-align:baseline;
                 width:100%;
                 height:20px;
                 margin-bottom:20px;
                 overflow:hidden;
                 background-color:#f5f5f5;
                 border-radius:4px;
                 -webkit-box-shadow:inset 0 1px 2px rgba(0,0,0,.1);
                 box-shadow:inset 0 1px 2px rgba(0,0,0,.1);">

    <div style="float: left;
    height: 100%;
    font-size: 16px;
    line-height: 20px;
    color: #fff;
    text-align: center;
    box-shadow: inset 0 -1px 0 rgb(0 0 0 / 15%);
    transition: width .6s ease;
    ', status, '  width: ', progress, '%;">

      ', progress, '%

    </div>
      </div>'
  ))
}
