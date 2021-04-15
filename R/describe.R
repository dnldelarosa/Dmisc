#' Create a table of summaries for an entery dataframe
#'
#' @param data [data.frame]: a dataframe with the data
#' @param digits [numeric]: number of digits for the numbers
#' @param t [logical]: indicates if the resulting table is transposed
#' @param flextable [logical]: indicates if the table is converted to a simple flextable
#' @param ... other arguments passed to summary function
#'
#' @return a table containing the summary of every variable in the provided dataframe
#'
#' @export
#'
#' @examples
#' \dontrun{
#' describe(cars, flextable = T)
#' }
describe <- function(data, digits = 4, t = TRUE, flextable = FALSE, ...){
  res <- list()
  for (variable in seq_along(data)) {
    res[[names(data)[[variable]]]] <- summary(data[[variable]], digits = digits, ...)
  }
    res <- dplyr::bind_rows(res, .id = "var")
    if(t){
      res <- t(res) %>%
        as.data.frame() %>%
        janitor::row_to_names(1)
    } else {
      res <- res %>%
        tibble::column_to_rownames("var")
    }
    if(flextable){
      res <- res %>%
        tibble::rownames_to_column(" ") %>%
        flextable::flextable()
    }
    res
}
