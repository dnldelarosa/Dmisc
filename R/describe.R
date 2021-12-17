#' Create a table of summaries for an entery dataframe
#' `r lifecycle::badge("experimental")`
#'
#' @param data [data.frame]: a dataframe with the data
#' @param digits [numeric]: number of digits for the numbers
#' @param t [logical]: indicates if the resulting table is transposed
#' @param flextable [logical]: indicates if the table is converted to a simple flextable.
#'    See \code{flextable::\link[flextable:flextable]{flextable}}
#' @param ft_args [list]: other arguments passed to \code{flextable::\link[flextable:flextable]{flextable}} function
#' @param ... other arguments passed to summary function
#'
#' @return a table containing the summary of every variable in the provided dataframe
#'
#' @export
#'
#' @examples
#' \dontrun{
#' describe(cars, flextable = T)
#' describe(cars, flextable = T, ft_args = list(cwidth = 1))
#' }
describe <- function(data, digits = 4, t = TRUE, flextable = FALSE, ft_args = list(), ...){
  data <- as.data.frame(data)
  res <- list()
  for (variable in seq_along(data)) {
    res[[names(data)[[variable]]]] <- summary(data[[variable]], digits = digits, ...)
  }
    res <- dplyr::bind_rows(res, .id = "var")
    if(t){
      res <- t(res) %>%
        as.data.frame()
      names(res) <- res[1,]
      res <- res[-1,]
    } else {
      res <- res %>%
        tibble::column_to_rownames("var")
    }
    res <- utils::type.convert(res, as.is = TRUE)
    if(flextable){
      if (!requireNamespace("flextable", quietly = TRUE)) {
        stop("Package \"flextable\" needed for this function to work. Please install it.", call. = FALSE)
      }
      if(length(ft_args) > 0){
        res <- res %>%
          tibble::rownames_to_column(" ")
        res <- do.call(flextable::flextable, c(list(data = res), ft_args))
      } else {
      res <- res %>%
        tibble::rownames_to_column(" ") %>%
        flextable::flextable()
      }
    }
    res
}
