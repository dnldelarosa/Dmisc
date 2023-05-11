# gt summary rows with external values
#
# @param .x The column values gt passes to the function.
# @param values A vector of values to use in the summary rows.
#   The values are used in the order they are provided.
# @param start_pos The position in the `values` vector to start using values.
#
# @return A value from the `values` vector for each column.
# 
#
# @examples
# \dontrun{
# ext_total <- c(100, 200)
# gt(mtcars) %>%
#   summary_rows(
#     groups = vars(cyl),
#     columns = vars(mpg, disp),
#     fns = list(
#       "Total" = ~summary_rows_ext(.x, ext_total)
#     )
#   )
# }
summary_rows_ext <- function(.x, values, start_pos = 1) {
  .sre_pos <- NULL
  if (!exists(".sre_pos", .GlobalEnv)) {
    .sre_pos <<- start_pos
  }
  res <- values[.sre_pos][[1]]
  if (.sre_pos == length(values)) {
    rm(.sre_pos, envir = .GlobalEnv)
  } else {
    .sre_pos <<- .sre_pos + 1
  }
  res
}