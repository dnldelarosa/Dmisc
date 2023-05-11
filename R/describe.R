# Create a summary table for a data frame
# `r lifecycle::badge("experimental")`
#
# This function generates a summary table for a data frame, containing summary statistics for each variable in the data frame.
#
# @param data A data frame containing the data to be summarized
# @param digits The number of digits to display in the summary table (default is 4)
# @param t If TRUE, the table will be transposed (default is TRUE)
# @param flextable If TRUE, the table will be converted to a simple flextable (default is FALSE)
# @param ft_args A list of additional arguments to pass to the \code{flextable} function if \code{flextable = TRUE} (default is an empty list)
# @param ... Other arguments to pass to the \code{summary} function
#
# @return A table containing summary statistics for each variable in the data frame
#
# 
#
# @examples
# \dontrun{
# describe(cars, flextable = TRUE)
# describe(cars, flextable = TRUE, ft_args = list(cwidth = 1))
# }
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
        stop("Package \"flextable\" needed for this argument to work. Please install it.", call. = FALSE)
      }
      if (!requireNamespace("tibble", quietly = TRUE)) {
        stop("Package \"tibble\" needed for this argument to work. Please install it.", call. = FALSE)
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
